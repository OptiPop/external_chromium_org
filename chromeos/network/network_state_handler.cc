// Copyright (c) 2012 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "chromeos/network/network_state_handler.h"

#include "base/stl_util.h"
#include "base/string_util.h"
#include "base/values.h"
#include "chromeos/network/device_state.h"
#include "chromeos/network/managed_state.h"
#include "chromeos/network/network_state.h"
#include "chromeos/network/network_state_handler_observer.h"
#include "chromeos/network/shill_property_handler.h"
#include "third_party/cros_system_api/dbus/service_constants.h"

namespace chromeos {

NetworkStateHandler::NetworkStateHandler() {
}

NetworkStateHandler::~NetworkStateHandler() {
  STLDeleteContainerPointers(network_list_.begin(), network_list_.end());
  STLDeleteContainerPointers(device_list_.begin(), device_list_.end());
}

void NetworkStateHandler::Init() {
  shill_property_handler_.reset(new internal::ShillPropertyHandler(this));
  shill_property_handler_->Init();
}

void NetworkStateHandler::AddObserver(NetworkStateHandlerObserver* observer) {
  observers_.AddObserver(observer);
}

void NetworkStateHandler::RemoveObserver(
    NetworkStateHandlerObserver* observer) {
  observers_.RemoveObserver(observer);
}

bool NetworkStateHandler::TechnologyAvailable(
    const std::string& technology) const {
  return available_technologies_.find(technology) !=
      available_technologies_.end();
}

bool NetworkStateHandler::TechnologyEnabled(
    const std::string& technology) const {
  return enabled_technologies_.find(technology) != enabled_technologies_.end();
}

void NetworkStateHandler::SetTechnologyEnabled(const std::string& technology,
                                               bool enabled) {
  shill_property_handler_->SetTechnologyEnabled(technology, enabled);
}

const DeviceState* NetworkStateHandler::GetDeviceState(
    const std::string& device_path) const {
  return GetModifiableDeviceState(device_path);
}

const DeviceState* NetworkStateHandler::GetDeviceStateByType(
    const std::string& type) const {
  for (ManagedStateList::const_iterator iter = device_list_.begin();
       iter != device_list_.end(); ++iter) {
    ManagedState* device = *iter;
    if (device->type() == type)
      return device->AsDeviceState();
  }
  return NULL;
}

const NetworkState* NetworkStateHandler::GetNetworkState(
    const std::string& service_path) const {
  return GetModifiableNetworkState(service_path);
}

const NetworkState* NetworkStateHandler::ActiveNetwork() const {
  if (network_list_.empty())
    return NULL;
  const NetworkState* network = network_list_.front()->AsNetworkState();
  DCHECK(network);
  if (!network->IsConnectedState())
    return NULL;
  return network;
}

const NetworkState* NetworkStateHandler::ConnectedNetworkByType(
    const std::string& type) const {
  for (ManagedStateList::const_iterator iter = network_list_.begin();
       iter != network_list_.end(); ++iter) {
    const NetworkState* network = (*iter)->AsNetworkState();
    DCHECK(network);
    if (!network->IsConnectedState())
      break;  // Connected networks are listed first.
    if (network->type() == type)
      return network;
  }
  return NULL;
}

const NetworkState* NetworkStateHandler::ConnectingNetworkByType(
    const std::string& type) const {
  for (ManagedStateList::const_iterator iter = network_list_.begin();
       iter != network_list_.end(); ++iter) {
    const NetworkState* network = (*iter)->AsNetworkState();
    DCHECK(network);
    if (network->IsConnectedState())
      continue;
    if (!network->IsConnectingState())
      break;  // Connected and connecting networks are listed first.
    if (network->type() == type ||
        (type.empty() && type != flimflam::kTypeEthernet)) {
      return network;
    }
  }
  return NULL;
}

std::string NetworkStateHandler::HardwareAddressForType(
    const std::string& type) const {
  std::string result;
  const NetworkState* network = ConnectedNetworkByType(type);
  if (network) {
    const DeviceState* device = GetDeviceState(network->device_path());
    if (device)
      result = device->mac_address();
  }
  StringToUpperASCII(&result);
  return result;
}

std::string NetworkStateHandler::FormattedHardwareAddressForType(
    const std::string& type) const {
  std::string address = HardwareAddressForType(type);
  if (address.size() % 2 != 0)
    return address;
  std::string result;
  for (size_t i = 0; i < address.size(); ++i) {
    if ((i != 0) && (i % 2 == 0))
      result.push_back(':');
    result.push_back(address[i]);
  }
  return result;
}

void NetworkStateHandler::GetNetworkList(NetworkStateList* list) const {
  DCHECK(list);
  shill_property_handler_->RequestScan();
  NetworkStateList result;
  list->clear();
  for (ManagedStateList::const_iterator iter = network_list_.begin();
       iter != network_list_.end(); ++iter) {
    const NetworkState* network = (*iter)->AsNetworkState();
    DCHECK(network);
    list->push_back(network);
  }
}

//------------------------------------------------------------------------------
// ShillPropertyHandler::Delegate overrides

void NetworkStateHandler::UpdateManagedList(ManagedState::ManagedType type,
                                            const base::ListValue& entries) {
  ManagedStateList* managed_list = GetManagedList(type);
  VLOG(2) << "UpdateManagedList: " << type;
  // Create a map of existing entries.
  std::map<std::string, ManagedState*> managed_map;
  for (ManagedStateList::iterator iter = managed_list->begin();
       iter != managed_list->end(); ++iter) {
    ManagedState* managed = *iter;
    managed_map[managed->path()] = managed;
  }
  // Clear the list (pointers are owned by managed_map).
  managed_list->clear();
  // Updates managed_list and request updates for new entries.
  for (base::ListValue::const_iterator iter = entries.begin();
       iter != entries.end(); ++iter) {
    std::string path;
    (*iter)->GetAsString(&path);
    DCHECK(!path.empty());
    std::map<std::string, ManagedState*>::iterator found =
        managed_map.find(path);
    bool request_properties = false;
    ManagedState* managed;
    bool is_observing = shill_property_handler_->IsObservingNetwork(path);
    if (found == managed_map.end()) {
      request_properties = true;
      managed = ManagedState::Create(type, path);
      managed_list->push_back(managed);
    } else {
      managed = found->second;
      managed_list->push_back(managed);
      managed_map.erase(found);
      if (!managed->is_observed() && is_observing)
        request_properties = true;
    }
    if (is_observing)
      managed->set_is_observed(true);
    if (request_properties)
      shill_property_handler_->RequestProperties(type, path);
  }
  // Delete any remaning entries in managed_map.
  STLDeleteContainerPairSecondPointers(managed_map.begin(), managed_map.end());
}

void NetworkStateHandler::UpdateAvailableTechnologies(
    const base::ListValue& technologies) {
  available_technologies_.clear();
  for (base::ListValue::const_iterator iter = technologies.begin();
       iter != technologies.end(); ++iter) {
    std::string technology;
    (*iter)->GetAsString(&technology);
    DCHECK(!technology.empty());
    available_technologies_.insert(technology);
  }
}

void NetworkStateHandler::UpdateEnabledTechnologies(
    const base::ListValue& technologies) {
  enabled_technologies_.clear();
  for (base::ListValue::const_iterator iter = technologies.begin();
       iter != technologies.end(); ++iter) {
    std::string technology;
    (*iter)->GetAsString(&technology);
    DCHECK(!technology.empty());
    enabled_technologies_.insert(technology);
  }
}

void NetworkStateHandler::UpdateManagedStateProperties(
    ManagedState::ManagedType type,
    const std::string& path,
    const base::DictionaryValue& properties) {
  ManagedState* managed = GetModifiableManagedState(GetManagedList(type), path);
  if (!managed) {
    LOG(ERROR) << "GetPropertiesCallback: " << path << " Not found!";
    return;
  }
  bool network_property_changed = false;
  for (base::DictionaryValue::Iterator iter(properties);
       iter.HasNext(); iter.Advance()) {
    if (type == ManagedState::MANAGED_TYPE_NETWORK) {
      if (ParseNetworkServiceProperty(managed->AsNetworkState(),
                                      iter.key(), iter.value()))
        network_property_changed = true;
    } else {
      managed->PropertyChanged(iter.key(), iter.value());
    }
  }
  // Notify observers.
  if (network_property_changed) {
    NetworkState* network = managed->AsNetworkState();
    DCHECK(network);
    FOR_EACH_OBSERVER(NetworkStateHandlerObserver, observers_,
                      NetworkServiceChanged(network));
  }
}

void NetworkStateHandler::UpdateNetworkServiceProperty(
    const std::string& service_path,
    const std::string& key,
    const base::Value& value) {
  NetworkState* network = GetModifiableNetworkState(service_path);
  if (!network)
    return;
  if (ParseNetworkServiceProperty(network, key, value)) {
    FOR_EACH_OBSERVER(NetworkStateHandlerObserver, observers_,
                      NetworkServiceChanged(network));
  }
}

void NetworkStateHandler::UpdateNetworkServiceIPAddress(
    const std::string& service_path,
    const std::string& ip_address) {
  NetworkState* network = GetModifiableNetworkState(service_path);
  if (!network)
    return;
  network->set_ip_address(ip_address);
  FOR_EACH_OBSERVER(
      NetworkStateHandlerObserver, observers_,
      NetworkServiceChanged(network));
}

void NetworkStateHandler::ManagerPropertyChanged() {
  FOR_EACH_OBSERVER(NetworkStateHandlerObserver, observers_,
                    NetworkManagerChanged());
}

void NetworkStateHandler::ManagedStateListChanged(
    ManagedState::ManagedType type) {
  if (type == ManagedState::MANAGED_TYPE_NETWORK) {
    // Notify observers that the list of networks has changed.
    NetworkStateList network_list;
    GetNetworkList(&network_list);
    FOR_EACH_OBSERVER(NetworkStateHandlerObserver, observers_,
                      NetworkListChanged(network_list));
    // Update the active network and notify observers if it has changed.
    NetworkState* new_active_network =
        network_list_.empty() ? NULL : network_list_.front()->AsNetworkState();
    std::string new_active_network_path;
    if (new_active_network)
      new_active_network_path = new_active_network->path();
    if (new_active_network_path != active_network_path_) {
      active_network_path_ = new_active_network_path;
      FOR_EACH_OBSERVER(NetworkStateHandlerObserver, observers_,
                        ActiveNetworkChanged(new_active_network));
    }
  } else if (type == ManagedState::MANAGED_TYPE_DEVICE) {
    FOR_EACH_OBSERVER(NetworkStateHandlerObserver, observers_,
                      DeviceListChanged());
  } else {
    NOTREACHED();
  }
}

//------------------------------------------------------------------------------
// Private methods

DeviceState* NetworkStateHandler::GetModifiableDeviceState(
    const std::string& device_path) const {
  ManagedState* managed = GetModifiableManagedState(&device_list_, device_path);
  if (!managed)
    return NULL;
  return managed->AsDeviceState();
}

NetworkState* NetworkStateHandler::GetModifiableNetworkState(
    const std::string& service_path) const {
  ManagedState* managed =
      GetModifiableManagedState(&network_list_, service_path);
  if (!managed)
    return NULL;
  return managed->AsNetworkState();
}

ManagedState* NetworkStateHandler::GetModifiableManagedState(
    const ManagedStateList* managed_list,
    const std::string& path) const {
  for (ManagedStateList::const_iterator iter = managed_list->begin();
       iter != managed_list->end(); ++iter) {
    ManagedState* managed = *iter;
    if (managed->path() == path)
      return managed;
  }
  return NULL;
}

NetworkStateHandler::ManagedStateList* NetworkStateHandler::GetManagedList(
    ManagedState::ManagedType type) {
  switch(type) {
    case ManagedState::MANAGED_TYPE_NETWORK:
      return &network_list_;
    case ManagedState::MANAGED_TYPE_DEVICE:
      return &device_list_;
  }
  NOTREACHED();
  return NULL;
}

bool NetworkStateHandler::ParseNetworkServiceProperty(
    NetworkState* network,
    const std::string& key,
    const base::Value& value) {
  DCHECK(network);
  bool property_changed = false;
  if (key == shill::kIPConfigProperty) {
    // Handle IPConfig here instead of in NetworkState::PropertyChanged since
    // we need to call into shill_property_handler_ to fetch them. This will
    // trigger a call to UpdateNetworkServiceIPAddress(), which will notify
    // any observers.
    std::string ip_config_path;
    value.GetAsString(&ip_config_path);
    DCHECK(!ip_config_path.empty());
    shill_property_handler_->RequestIPConfig(network->path(), ip_config_path);
  } else {
    if (network->PropertyChanged(key, value)) {
      property_changed = true;
      if (network->path() == active_network_path_ &&
          key == flimflam::kStateProperty) {
        FOR_EACH_OBSERVER(NetworkStateHandlerObserver, observers_,
                          ActiveNetworkStateChanged(network));
      }
    }
  }
  return property_changed;
}

}  // namespace chromeos
# This file is generated by gyp; do not edit.

include $(CLEAR_VARS)

LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE := third_party_libphonenumber_libphonenumber_without_metadata_gyp
LOCAL_MODULE_SUFFIX := .a
LOCAL_MODULE_TAGS := optional
gyp_intermediate_dir := $(call local-intermediates-dir)
gyp_shared_intermediate_dir := $(call intermediates-dir-for,GYP,shared)

# Make sure our deps are built first.
GYP_TARGET_DEPENDENCIES := \
	$(call intermediates-dir-for,GYP,third_party_icu_icui18n_gyp)/icui18n.stamp \
	$(call intermediates-dir-for,GYP,third_party_icu_icuuc_gyp)/icuuc.stamp \
	$(gyp_shared_intermediate_dir)/protoc


### Generated for rule "_usr_local_google_code_clank_master_ab_external_chromium_org_third_party_libphonenumber_libphonenumber_gyp_libphonenumber_without_metadata_target_genproto":
# "{'inputs': ['../../tools/protoc_wrapper/protoc_wrapper.py', '$(gyp_shared_intermediate_dir)/protoc'], 'msvs_cygwin_shell': '0', 'extension': 'proto', 'outputs': ['$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/%(INPUT_ROOT)s_pb2.py', '$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/%(INPUT_ROOT)s.pb.cc', '$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/%(INPUT_ROOT)s.pb.h'], 'rule_name': 'genproto', 'rule_sources': ['src/resources/phonemetadata.proto', 'src/resources/phonenumber.proto'], 'action': ['python', '../../tools/protoc_wrapper/protoc_wrapper.py', '--include', '', '--protobuf', '$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/%(INPUT_ROOT)s.pb.h', '--', '$(gyp_shared_intermediate_dir)/protoc', '--proto_path', 'src/resources', 'src/resources/%(INPUT_ROOT)s$(suffix $<)', '--cpp_out', '$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers', '--python_out', '$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers'], 'message': 'Generating C++ and Python code from $(RULE_SOURCES)', 'process_outputs_as_sources': '1'}":
$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py: gyp_local_path := $(LOCAL_PATH)
$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py: gyp_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_intermediate_dir)
$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py: gyp_shared_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_shared_intermediate_dir)
$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py: $(LOCAL_PATH)/third_party/libphonenumber/src/resources/phonemetadata.proto $(LOCAL_PATH)/tools/protoc_wrapper/protoc_wrapper.py $(gyp_shared_intermediate_dir)/protoc $(GYP_TARGET_DEPENDENCIES)
	mkdir -p $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers $(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers; cd $(gyp_local_path)/third_party/libphonenumber; python ../../tools/protoc_wrapper/protoc_wrapper.py --include "" --protobuf "$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonemetadata.pb.h" -- "$(gyp_shared_intermediate_dir)/protoc" --proto_path src/resources "src/resources/phonemetadata$(suffix $<)" --cpp_out "$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers" --python_out "$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers"

$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonemetadata.pb.cc: $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py
$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonemetadata.pb.h: $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py
.PHONY: third_party_libphonenumber_libphonenumber_without_metadata_gyp_rule_trigger
third_party_libphonenumber_libphonenumber_without_metadata_gyp_rule_trigger: $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py

$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py: gyp_local_path := $(LOCAL_PATH)
$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py: gyp_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_intermediate_dir)
$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py: gyp_shared_intermediate_dir := $(GYP_ABS_ANDROID_TOP_DIR)/$(gyp_shared_intermediate_dir)
$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py: $(LOCAL_PATH)/third_party/libphonenumber/src/resources/phonenumber.proto $(LOCAL_PATH)/tools/protoc_wrapper/protoc_wrapper.py $(gyp_shared_intermediate_dir)/protoc $(GYP_TARGET_DEPENDENCIES)
	mkdir -p $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers $(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers; cd $(gyp_local_path)/third_party/libphonenumber; python ../../tools/protoc_wrapper/protoc_wrapper.py --include "" --protobuf "$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonenumber.pb.h" -- "$(gyp_shared_intermediate_dir)/protoc" --proto_path src/resources "src/resources/phonenumber$(suffix $<)" --cpp_out "$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers" --python_out "$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers"

$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonenumber.pb.cc: $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py
$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonenumber.pb.h: $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py
.PHONY: third_party_libphonenumber_libphonenumber_without_metadata_gyp_rule_trigger
third_party_libphonenumber_libphonenumber_without_metadata_gyp_rule_trigger: $(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py

### Finished generating for all rules

GYP_GENERATED_OUTPUTS := \
	$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonemetadata.pb.cc \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonemetadata.pb.h \
	$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonenumber.pb.cc \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonenumber.pb.h

# Make sure our deps and generated files are built first.
LOCAL_ADDITIONAL_DEPENDENCIES := $(GYP_TARGET_DEPENDENCIES) $(GYP_GENERATED_OUTPUTS)

LOCAL_CPP_EXTENSION := .cc
$(gyp_intermediate_dir)/phonemetadata.pb.cc: $(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonemetadata.pb.cc
	mkdir -p $(@D); cp $< $@
$(gyp_intermediate_dir)/phonenumber.pb.cc: $(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonenumber.pb.cc
	mkdir -p $(@D); cp $< $@
LOCAL_GENERATED_SOURCES := \
	$(gyp_intermediate_dir)/phonemetadata.pb.cc \
	$(gyp_intermediate_dir)/phonenumber.pb.cc \
	$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonemetadata_pb2.py \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonemetadata.pb.h \
	$(gyp_shared_intermediate_dir)/pyproto/third_party/libphonenumber/phonenumbers/phonenumber_pb2.py \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers/phonenumber.pb.h \
	third_party_libphonenumber_libphonenumber_without_metadata_gyp_rule_trigger

GYP_COPIED_SOURCE_ORIGIN_DIRS := \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber/phonenumbers

LOCAL_SRC_FILES := \
	third_party/libphonenumber/src/phonenumbers/asyoutypeformatter.cc \
	third_party/libphonenumber/src/phonenumbers/default_logger.cc \
	third_party/libphonenumber/src/phonenumbers/logger.cc \
	third_party/libphonenumber/src/phonenumbers/phonenumber.cc \
	third_party/libphonenumber/src/phonenumbers/phonenumbermatch.cc \
	third_party/libphonenumber/src/phonenumbers/phonenumbermatcher.cc \
	third_party/libphonenumber/src/phonenumbers/phonenumberutil.cc \
	third_party/libphonenumber/src/phonenumbers/regexp_adapter_icu.cc \
	third_party/libphonenumber/src/phonenumbers/regexp_cache.cc \
	third_party/libphonenumber/src/phonenumbers/string_byte_sink.cc \
	third_party/libphonenumber/src/phonenumbers/stringutil.cc \
	third_party/libphonenumber/src/phonenumbers/unicodestring.cc \
	third_party/libphonenumber/src/phonenumbers/utf/rune.c \
	third_party/libphonenumber/src/phonenumbers/utf/unicodetext.cc \
	third_party/libphonenumber/src/phonenumbers/utf/unilib.cc


# Flags passed to both C and C++ files.
MY_CFLAGS := \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-Wno-format \
	-mthumb \
	-march=armv7-a \
	-mtune=cortex-a8 \
	-mfloat-abi=softfp \
	-mfpu=vfpv3-d16 \
	-fno-tree-sra \
	-fuse-ld=gold \
	-Wno-psabi \
	-mthumb-interwork \
	-ffunction-sections \
	-funwind-tables \
	-g \
	-fstack-protector \
	-fno-short-enums \
	-finline-limit=64 \
	-Wa,--noexecstack \
	-Wno-error=extra \
	-Wno-error=ignored-qualifiers \
	-Wno-error=type-limits \
	-Wno-error=non-virtual-dtor \
	-Wno-error=sign-promo \
	-Wno-error=address \
	-Wno-error=format-security \
	-Wno-error=non-virtual-dtor \
	-Wno-error=return-type \
	-Wno-error=sequence-point \
	-Os \
	-g \
	-fomit-frame-pointer \
	-fdata-sections \
	-ffunction-sections

MY_CFLAGS_C :=

MY_DEFS := \
	'-DUSE_HASH_MAP=1' \
	'-DUSE_GOOGLE_BASE=1' \
	'-DUSE_ICU_REGEXP=1' \
	'-D_FILE_OFFSET_BITS=64' \
	'-DNO_TCMALLOC' \
	'-DDISABLE_NACL' \
	'-DCHROMIUM_BUILD' \
	'-DUSE_LIBJPEG_TURBO=1' \
	'-DUSE_PROPRIETARY_CODECS' \
	'-DENABLE_PEPPER_THREADING' \
	'-DENABLE_GPU=1' \
	'-DUSE_OPENSSL=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-DUSE_SKIA=1' \
	'-DU_USING_ICU_NAMESPACE=0' \
	'-DUSE_SYSTEM_ICU' \
	'-DGOOGLE_PROTOBUF_NO_RTTI' \
	'-DGOOGLE_PROTOBUF_NO_STATIC_INITIALIZER' \
	'-DANDROID' \
	'-D__GNU_SOURCE=1' \
	'-DUSE_STLPORT=1' \
	'-D_STLP_USE_PTR_SPECIALIZATIONS=1' \
	'-DCHROME_SYMBOLS_ID=""' \
	'-DANDROID_UPSTREAM_BRINGUP=1' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=1' \
	'-DWTF_USE_DYNAMIC_ANNOTATIONS=1' \
	'-D_DEBUG'

LOCAL_CFLAGS := $(MY_CFLAGS_C) $(MY_CFLAGS) $(MY_DEFS)

# Include paths placed before CFLAGS/CPPFLAGS
LOCAL_C_INCLUDES := \
	$(LOCAL_PATH) \
	$(LOCAL_PATH)/third_party/libphonenumber/src \
	$(LOCAL_PATH)/third_party/libphonenumber/src/test \
	$(gyp_shared_intermediate_dir)/protoc_out/third_party/libphonenumber \
	$(gyp_shared_intermediate_dir)/protoc_out \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/icu4c/common \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/icu4c/i18n \
	$(LOCAL_PATH)/third_party/protobuf \
	$(LOCAL_PATH)/third_party/protobuf/src \
	$(GYP_ABS_ANDROID_TOP_DIR)/frameworks/wilhelm/include \
	$(GYP_ABS_ANDROID_TOP_DIR)/bionic \
	$(GYP_ABS_ANDROID_TOP_DIR)/external/stlport/stlport

LOCAL_C_INCLUDES := $(GYP_COPIED_SOURCE_ORIGIN_DIRS) $(LOCAL_C_INCLUDES)

# Flags passed to only C++ (and not C) files.
LOCAL_CPPFLAGS := \
	-fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wno-deprecated \
	-Wno-abi \
	-Wno-error=c++0x-compat

### Rules for final target.

LOCAL_LDFLAGS := \
	-Wl,-z,noexecstack \
	-fPIC \
	-Wl,-z,relro \
	-Wl,-z,now \
	-fuse-ld=gold \
	-nostdlib \
	-Wl,--no-undefined \
	-Wl,--exclude-libs=ALL \
	-Wl,--icf=safe \
	-Wl,-O1 \
	-Wl,--as-needed \
	-Wl,--gc-sections


LOCAL_STATIC_LIBRARIES :=

# Enable grouping to fix circular references
LOCAL_GROUP_STATIC_LIBRARIES := true

LOCAL_SHARED_LIBRARIES := \
	libstlport \
	libdl

# Add target alias to "gyp_all_modules" target.
.PHONY: gyp_all_modules
gyp_all_modules: third_party_libphonenumber_libphonenumber_without_metadata_gyp

# Alias gyp target name.
.PHONY: libphonenumber_without_metadata
libphonenumber_without_metadata: third_party_libphonenumber_libphonenumber_without_metadata_gyp

include $(BUILD_STATIC_LIBRARY)
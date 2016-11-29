#
# Copyright (C) 2016 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH:= $(call my-dir)

# ==========================================================
# Setup some common variables for the different build
# targets here.
# ==========================================================

main := Main.cpp
sources := \
	compile/IdAssigner.cpp \
	compile/Png.cpp \
	compile/PseudolocaleGenerator.cpp \
	compile/Pseudolocalizer.cpp \
	compile/XmlIdCollector.cpp \
	filter/ConfigFilter.cpp \
	flatten/Archive.cpp \
	flatten/TableFlattener.cpp \
	flatten/XmlFlattener.cpp \
	io/FileSystem.cpp \
	io/ZipArchive.cpp \
	link/AutoVersioner.cpp \
	link/ManifestFixer.cpp \
	link/ProductFilter.cpp \
	link/PrivateAttributeMover.cpp \
	link/ReferenceLinker.cpp \
	link/TableMerger.cpp \
	link/XmlReferenceLinker.cpp \
	process/SymbolTable.cpp \
	proto/ProtoHelpers.cpp \
	proto/TableProtoDeserializer.cpp \
	proto/TableProtoSerializer.cpp \
	split/TableSplitter.cpp \
	unflatten/BinaryResourceParser.cpp \
	unflatten/ResChunkPullParser.cpp \
	util/BigBuffer.cpp \
	util/Files.cpp \
	util/Util.cpp \
	ConfigDescription.cpp \
	Debug.cpp \
	Flags.cpp \
	java/AnnotationProcessor.cpp \
	java/ClassDefinition.cpp \
	java/JavaClassGenerator.cpp \
	java/ManifestClassGenerator.cpp \
	java/ProguardRules.cpp \
	Locale.cpp \
	Resource.cpp \
	ResourceParser.cpp \
	ResourceTable.cpp \
	ResourceUtils.cpp \
	ResourceValues.cpp \
	SdkConstants.cpp \
	StringPool.cpp \
	xml/XmlActionExecutor.cpp \
	xml/XmlDom.cpp \
	xml/XmlPullParser.cpp \
	xml/XmlUtil.cpp

sources += Format.proto

testSources := \
	compile/IdAssigner_test.cpp \
	compile/PseudolocaleGenerator_test.cpp \
	compile/Pseudolocalizer_test.cpp \
	compile/XmlIdCollector_test.cpp \
	filter/ConfigFilter_test.cpp \
	flatten/TableFlattener_test.cpp \
	flatten/XmlFlattener_test.cpp \
	link/AutoVersioner_test.cpp \
	link/ManifestFixer_test.cpp \
	link/PrivateAttributeMover_test.cpp \
	link/ProductFilter_test.cpp \
	link/ReferenceLinker_test.cpp \
	link/TableMerger_test.cpp \
	link/XmlReferenceLinker_test.cpp \
	process/SymbolTable_test.cpp \
	proto/TableProtoSerializer_test.cpp \
	split/TableSplitter_test.cpp \
	util/BigBuffer_test.cpp \
	util/Files_test.cpp \
	util/Maybe_test.cpp \
	util/StringPiece_test.cpp \
	util/Util_test.cpp \
	ConfigDescription_test.cpp \
	java/AnnotationProcessor_test.cpp \
	java/JavaClassGenerator_test.cpp \
	java/ManifestClassGenerator_test.cpp \
	Locale_test.cpp \
	Resource_test.cpp \
	ResourceParser_test.cpp \
	ResourceTable_test.cpp \
	ResourceUtils_test.cpp \
	SdkConstants_test.cpp \
	StringPool_test.cpp \
	ValueVisitor_test.cpp \
	xml/XmlActionExecutor_test.cpp \
	xml/XmlDom_test.cpp \
	xml/XmlPullParser_test.cpp \
	xml/XmlUtil_test.cpp

toolSources := \
	compile/Compile.cpp \
	diff/Diff.cpp \
	dump/Dump.cpp \
	link/Link.cpp

protoIncludes := \
	proto/Format.pb.h

aopt_staticlibs := \
    libandroidfw-static \
    libpng \
    liblog \
    libexpat_static \
    libutils \
    libcutils \
    libziparchive \
    libbase \
    libm \
    libc \
    libz \
    libc++_static \
    libprotobuf-cpp-lite_arm

CFLAGS := \
	-DHAVE_SYS_UIO_H \
	-DHAVE_PTHREADS \
	-DHAVE_SCHED_H \
	-DHAVE_SYS_UIO_H \
	-DHAVE_IOCTL \
	-DHAVE_TM_GMTOFF \
	-DANDROID_SMP=1  \
	-DHAVE_ENDIAN_H \
	-DHAVE_POSIX_FILEMAP \
	-DHAVE_OFF64_T \
	-DHAVE_ENDIAN_H \
	-DHAVE_SCHED_H \
	-DHAVE_LITTLE_ENDIAN_H \
	-D__ANDROID__ \
	-DHAVE_ANDROID_OS=1 \
	-D_ANDROID_CONFIG_H \
	-D_BYPASS_DSO_ERROR \
	-DHAVE_ERRNO_H='1' \
	-DSTATIC_ANDROIDFW_FOR_TOOLS \
	
aopt_cflags += -D'AOPT_VERSION="android-$(PLATFORM_VERSION)-$(TARGET_BUILD_VARIANT)"' 
aopt_cflags += -Wno-format-y2k
aopt_cflags += $(CFLAGS)

aopt_ldlibs := -lm -lc -lgcc -ldl -lz 

aopt_cflags += \
	-Wno-unused-variable \
	-Wno-unused-parameter \
	-Wno-maybe-uninitialized
	
aopt_cxxflags := \
	-std=gnu++1y \
	-Wno-missing-field-initializers \
	-fno-exceptions \
	-fno-rtti \
	-Wno-missing-field-initializers 

aopt_includes := \
        $(LOCAL_PATH)/include \
        system/core/base/include \
        system/core/libutils \
        system/core/liblog \
        system/core/libcutils \
        external/libpng \
        external/expat \
        external/zlib \
        external/libcxx/include \
        system/core/libziparchive \
        frameworks/base/libs/androidfw \
        frameworks/base/include/androidfw \
        external/protobuf/src \
        external/protobuf/android 
        

include $(CLEAR_VARS)
LOCAL_MODULE := libprotobuf-cpp-lite_arm
IGNORED_WARNINGS := -Wno-sign-compare -Wno-unused-parameter -Wno-sign-promo -Wno-error=return-type
LOCAL_CPP_EXTENSION := .cc
DIR := ../../../../external/protobuf
CC_LITE_SRC_FILES := \
	$(DIR)/src/google/protobuf/stubs/atomicops_internals_x86_gcc.cc \
	$(DIR)/src/google/protobuf/stubs/atomicops_internals_x86_msvc.cc \
	$(DIR)/src/google/protobuf/stubs/common.cc \
	$(DIR)/src/google/protobuf/stubs/once.cc \
	$(DIR)/src/google/protobuf/stubs/stringprintf.cc \
	$(DIR)/src/google/protobuf/extension_set.cc \
	$(DIR)/src/google/protobuf/generated_message_util.cc \
	$(DIR)/src/google/protobuf/message_lite.cc \
	$(DIR)/src/google/protobuf/repeated_field.cc \
	$(DIR)/src/google/protobuf/wire_format_lite.cc \
	$(DIR)/src/google/protobuf/io/coded_stream.cc \
	$(DIR)/src/google/protobuf/io/zero_copy_stream.cc \
	$(DIR)/src/google/protobuf/io/zero_copy_stream_impl_lite.cc

LOCAL_C_INCLUDES := \
	$(DIR)/android \
    $(DIR)/src \
    $(aopt_includes) \
    $(DIR)

LOCAL_CPPFLAGS := $(aopt_cxxflags)    
LOCAL_CFLAGS := -DGOOGLE_PROTOBUF_NO_RTTI $(IGNORED_WARNINGS) $(aopt_cxxflags)
LOCAL_SRC_FILES := $(CC_LITE_SRC_FILES)
LOCAL_EXPORT_C_INCLUDE_DIRS := \
	$(DIR)/android \
    $(DIR)/src \
    $(DIR)
    
include $(BUILD_STATIC_LIBRARY)
# Android Protocol buffer compiler, aprotoc (target executable)
# used by the build systems as $(PROTOC) defined in
# build/core/config.mk
#
# Note: this isnt needed anymore since making the temp files
# 		I included it for historical reasons 
# =======================================================
include $(CLEAR_VARS)

LOCAL_MODULE := aprotoc
LOCAL_MODULE_TAGS := optional
LOCAL_CXX_STL := libc++_static
LOCAL_CPP_EXTENSION := .cc
IGNORED_WARNINGS := -Wno-sign-compare -Wno-unused-parameter -Wno-sign-promo -Wno-error=return-type
COMPILER_SRC_FILES :=  \
    $(DIR)/src/google/protobuf/descriptor.cc \
    $(DIR)/src/google/protobuf/descriptor.pb.cc \
    $(DIR)/src/google/protobuf/descriptor_database.cc \
    $(DIR)/src/google/protobuf/dynamic_message.cc \
    $(DIR)/src/google/protobuf/extension_set.cc \
    $(DIR)/src/google/protobuf/extension_set_heavy.cc \
    $(DIR)/src/google/protobuf/generated_message_reflection.cc \
    $(DIR)/src/google/protobuf/generated_message_util.cc \
    $(DIR)/src/google/protobuf/message.cc \
    $(DIR)/src/google/protobuf/message_lite.cc \
    $(DIR)/src/google/protobuf/reflection_ops.cc \
    $(DIR)/src/google/protobuf/repeated_field.cc \
    $(DIR)/src/google/protobuf/service.cc \
    $(DIR)/src/google/protobuf/text_format.cc \
    $(DIR)/src/google/protobuf/unknown_field_set.cc \
    $(DIR)/src/google/protobuf/wire_format.cc \
    $(DIR)/src/google/protobuf/wire_format_lite.cc \
    $(DIR)/src/google/protobuf/compiler/code_generator.cc \
    $(DIR)/src/google/protobuf/compiler/command_line_interface.cc \
    $(DIR)/src/google/protobuf/compiler/importer.cc \
    $(DIR)/src/google/protobuf/compiler/main.cc \
    $(DIR)/src/google/protobuf/compiler/parser.cc \
    $(DIR)/src/google/protobuf/compiler/plugin.cc \
    $(DIR)/src/google/protobuf/compiler/plugin.pb.cc \
    $(DIR)/src/google/protobuf/compiler/subprocess.cc \
    $(DIR)/src/google/protobuf/compiler/zip_writer.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_enum.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_enum_field.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_extension.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_field.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_file.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_generator.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_helpers.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_message.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_message_field.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_primitive_field.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_service.cc \
    $(DIR)/src/google/protobuf/compiler/cpp/cpp_string_field.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_context.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_enum.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_enum_field.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_extension.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_field.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_file.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_generator.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_generator_factory.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_helpers.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_lazy_message_field.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_message.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_message_field.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_name_resolver.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_primitive_field.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_shared_code_generator.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_service.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_string_field.cc \
    $(DIR)/src/google/protobuf/compiler/java/java_doc_comment.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_enum.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_enum_field.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_field.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_file.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_generator.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_helpers.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_message.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_message_field.cc \
    $(DIR)/src/google/protobuf/compiler/javamicro/javamicro_primitive_field.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_enum.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_enum_field.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_extension.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_field.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_file.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_generator.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_helpers.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_message.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_message_field.cc \
    $(DIR)/src/google/protobuf/compiler/javanano/javanano_primitive_field.cc \
    $(DIR)/src/google/protobuf/compiler/python/python_generator.cc \
    $(DIR)/src/google/protobuf/io/coded_stream.cc \
    $(DIR)/src/google/protobuf/io/gzip_stream.cc \
    $(DIR)/src/google/protobuf/io/printer.cc \
    $(DIR)/src/google/protobuf/io/strtod.cc \
    $(DIR)/src/google/protobuf/io/tokenizer.cc \
    $(DIR)/src/google/protobuf/io/zero_copy_stream.cc \
    $(DIR)/src/google/protobuf/io/zero_copy_stream_impl.cc \
    $(DIR)/src/google/protobuf/io/zero_copy_stream_impl_lite.cc \
    $(DIR)/src/google/protobuf/stubs/atomicops_internals_x86_gcc.cc \
    $(DIR)/src/google/protobuf/stubs/atomicops_internals_x86_msvc.cc \
    $(DIR)/src/google/protobuf/stubs/common.cc \
    $(DIR)/src/google/protobuf/stubs/once.cc \
    $(DIR)/src/google/protobuf/stubs/structurally_valid.cc \
    $(DIR)/src/google/protobuf/stubs/strutil.cc \
    $(DIR)/src/google/protobuf/stubs/substitute.cc \
    $(DIR)/src/google/protobuf/stubs/stringprintf.cc
    
LOCAL_MODULE_STEM_32 := aprotoc        
LOCAL_MODULE_STEM_64 := aprotoc64
LOCAL_MULTILIB := both
LOCAL_SRC_FILES := $(COMPILER_SRC_FILES)

LOCAL_C_INCLUDES := \
	$(DIR)/android \
    $(DIR)/src \
    $(aopt_includes) \
    $(DIR)

LOCAL_CPPFLAGS := -std=gnu++1y -frtti 
LOCAL_CFLAGS := $(IGNORED_WARNINGS) 
LOCAL_EXPORT_C_INCLUDE_DIRS := \
	$(DIR)/android \
    $(DIR)/src \
    $(aopt_includes) \
    $(DIR)
    
LOCAL_STATIC_LIBRARIES :=  $(aopt_staticlibs)
LOCAL_CFLAGS := $(IGNORED_WARNINGS)
LOCAL_LDFLAGS += -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_PACK_MODULE_RELOCATIONS := false
include $(BUILD_EXECUTABLE)


# C++ lite static library for host tools.
# =======================================================

# ==========================================================
# NOTE: Do not add any shared libraries.
# aopt2 is built to run on many environments
# that may not have the required dependencies.
# ==========================================================

# ==========================================================
# Build the host static library: libaopt2
# ==========================================================
include $(CLEAR_VARS)
LOCAL_MODULE := libaopt2
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_CPPFLAGS := $(aopt_cxxflags)

LOCAL_C_INCLUDES := \
	$(aopt_includes) \
	$(protoIncludes)
	
LOCAL_SRC_FILES := $(sources)
include $(BUILD_STATIC_LIBRARY)

# ==========================================================
# Build the target executable: aopt2
# ==========================================================
include $(CLEAR_VARS)
LOCAL_MODULE := aopt2

LOCAL_CPPFLAGS := $(aopt_cxxflags) -D__ANDROID__
LOCAL_C_INCLUDES := \
	$(aopt_includes) \
	$(protoIncludes)

LOCAL_MODULE_TAGS := optional
LOCAL_STATIC_LIBRARIES := libaopt2 $(aopt_staticlibs)
LOCAL_LDLIBS := $(aopt_ldlibs)
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_UNSTRIPPED_PATH := $(PRODUCT_OUT)/symbols/utilities
LOCAL_LDFLAGS := -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_PACK_MODULE_RELOCATIONS := false
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk

# Disable multilib build for now new build system makes it difficult
# I can switch to one or the other but creating and using an intermediates-dir
# thats arch specific is not working, using the same  method as debuggered and linker
# also fails 
# 

LOCAL_SRC_FILES := $(main) $(toolSources)
LOCAL_MODULE_STEM_32 := aopt2
LOCAL_MODULE_STEM_64 := aopt2-64
LOCAL_MODULE_PATH_32 := $(ANDROID_PRODUCT_OUT)/system/bin
LOCAL_MODULE_PATH_64 := $(ANDROID_PRODUCT_OUT)/system/bin
LOCAL_MULTILIB := both

include $(BUILD_EXECUTABLE)

#include $(call first-makefiles-under,$(LOCAL_PATH))

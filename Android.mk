#
# Copyright (C) 2015 The Android Open Source Project
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

# This tool is prebuilt if we're doing an app-only build.

# ==========================================================
# Setup some common variables for the different build
# targets here.
# ==========================================================
LOCAL_PATH:= $(call my-dir)

main := Main.cpp
sources := \
	BigBuffer.cpp \
	BinaryResourceParser.cpp \
	BindingXmlPullParser.cpp \
	ConfigDescription.cpp \
	Debug.cpp \
	Files.cpp \
	Flag.cpp \
	JavaClassGenerator.cpp \
	Linker.cpp \
	Locale.cpp \
	Logger.cpp \
	ManifestMerger.cpp \
	ManifestParser.cpp \
	ManifestValidator.cpp \
	Png.cpp \
	ProguardRules.cpp \
	ResChunkPullParser.cpp \
	Resource.cpp \
	ResourceParser.cpp \
	ResourceTable.cpp \
	ResourceTableResolver.cpp \
	ResourceValues.cpp \
	SdkConstants.cpp \
	StringPool.cpp \
	TableFlattener.cpp \
	Util.cpp \
	ScopedXmlPullParser.cpp \
	SourceXmlPullParser.cpp \
	XliffXmlPullParser.cpp \
	XmlDom.cpp \
	XmlFlattener.cpp \
	ZipEntry.cpp \
	ZipFile.cpp

testSources := \
	BigBuffer_test.cpp \
	BindingXmlPullParser_test.cpp \
	Compat_test.cpp \
	ConfigDescription_test.cpp \
	JavaClassGenerator_test.cpp \
	Linker_test.cpp \
	Locale_test.cpp \
	ManifestMerger_test.cpp \
	ManifestParser_test.cpp \
	Maybe_test.cpp \
	NameMangler_test.cpp \
	ResourceParser_test.cpp \
	Resource_test.cpp \
	ResourceTable_test.cpp \
	ScopedXmlPullParser_test.cpp \
	StringPiece_test.cpp \
	StringPool_test.cpp \
	Util_test.cpp \
	XliffXmlPullParser_test.cpp \
	XmlDom_test.cpp \
	XmlFlattener_test.cpp

cIncludes := \
        $(LOCAL_PATH)/include \
        $(LOCAL_PATH)/ \
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

hostLdLibs := -lc -lgcc -ldl -lz -lm

hostStaticLibs := \
	libandroidfw-static \
    libpng \
	libexpat_static \
	libutils \
	libcutils \
	libziparchive \
    liblog \
	libbase \
	libm \
    libc \
	libz \
    libc++_static \

cFlags := \
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

cFlags += -D'AOPT_VERSION="android-$(PLATFORM_VERSION)-$(TARGET_BUILD_VARIANT)"' 
cFlags += -Wno-format-y2k
cFlags += $(CFLAGS)

cFlags += \
	-Wall \
	-Werror \
	-Wno-unused-parameter \
	-D'AOPT_VERSION="android-$(PLATFORM_VERSION)-$(TARGET_BUILD_VARIANT)"' \
	-Wno-format-y2k \
	-Wno-unused-variable \
	-Wno-unused-parameter \
	-Wno-maybe-uninitialized \
	-Wunreachable-code \
	-Wno-error=unused-but-set-variable


cFlags += \
        -Wno-unused-variable \
        -Wno-unused-parameter \
        -Wno-maybe-uninitialized \
		-Wno-error=non-virtual-dtor \
		-Wno-unused-private-field

cppFlags := \
       -std=gnu++1y \
        -Wno-missing-field-initializers \
        -fno-exceptions \
        -fno-rtti \
        -Wno-missing-field-initializers \
		-Wno-unused-private-field \
        -Wno-unused-function \
		-Wno-non-virtual-dtor \
        -Wno-error=non-virtual-dtor \



# ==========================================================
# Build the host executable: aapt2
# ==========================================================
include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(cIncludes)
LOCAL_STATIC_LIBRARIES += $(hostStaticLibs)
LOCAL_LDLIBS += $(hostLdLibs)
LOCAL_CFLAGS += $(cFlags)
LOCAL_CPPFLAGS += $(cppFlags) -D__ANDROID__

LOCAL_MODULE := aopt2
LOCAL_SRC_FILES := $(main) $(sources)
LOCAL_MODULE_STEM_32 := aopt2
LOCAL_MODULE_STEM_64 := aopt2-64
LOCAL_MODULE_PATH_32 := $(ANDROID_PRODUCT_OUT)/system/bin
LOCAL_MODULE_PATH_64 := $(ANDROID_PRODUCT_OUT)/system/bin
LOCAL_MULTILIB := both
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_LDFLAGS += -static
LOCAL_FORCE_STATIC_EXECUTABLE := true
LOCAL_PACK_MODULE_RELOCATIONS := false
include $(BUILD_EXECUTABLE)



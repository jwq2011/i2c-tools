LOCAL_PATH := $(call my-dir)

# LOCAL_MODULE_TAGS := user     : 只有在user版本时该模块才被编译进去
# LOCAL_MODULE_TAGS := eng      : 只有在eng版本时该模块才被编译进去
# LOCAL_MODULE_TAGS := test     : 只有在tests版本时该模块才被编译进去
# LOCAL_MODULE_TAGS := optional : 在所有版本中都编译该模块进去

# include $(BUILD_STATIC_LIBRARY)   ：编译为静态库
# include $(BUILD_SHARED_LIBRARY)   ：编译为动态库
# include $(BUILD_EXECUTABLE)       ：编译为Native C可执行程序
# include $(BUILD_PREBUILT)         ：该模块已经预先编译

# $(warning "the value of LOCAL_PATH is $(LOCAL_PATH)")
# $(warning "the value of TARGET_OUT is $(TARGET_OUT)")


################### i2c-tools #########################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)
LOCAL_MODULE := i2c-tools

LOCAL_SRC_FILES := \
    tools/i2cbusses.c \
    tools/util.c \
    lib/smbus.c

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include

#LOCAL_CFLAGS := -g -Wall -Werror -Wno-unused-parameter
include $(BUILD_STATIC_LIBRARY)

################### i2cdetect #########################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)
LOCAL_MODULE:=i2cdetect

LOCAL_SRC_FILES:= \
    tools/i2cdetect.c

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include

LOCAL_SHARED_LIBRARIES:= \
    libc

LOCAL_STATIC_LIBRARIES := \
    i2c-tools

LOCAL_CPPFLAGS += -DANDROID

include $(BUILD_EXECUTABLE)

#################### i2cget ###########################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)
LOCAL_MODULE:=i2cget

LOCAL_SRC_FILES:= \
    tools/i2cget.c

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include

LOCAL_SHARED_LIBRARIES:= \
    libc

LOCAL_STATIC_LIBRARIES := \
    i2c-tools

LOCAL_CPPFLAGS += -DANDROID

include $(BUILD_EXECUTABLE)

##################### i2cset ##########################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)
LOCAL_MODULE:=i2cset

LOCAL_SRC_FILES := \
    tools/i2cset.c

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include

LOCAL_SHARED_LIBRARIES := \
    libc

LOCAL_STATIC_LIBRARIES := \
    i2c-tools

LOCAL_CPPFLAGS += -DANDROID

include $(BUILD_EXECUTABLE)

##################### i2cdump #########################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)
LOCAL_MODULE:=i2cdump

LOCAL_SRC_FILES := \
    tools/i2cdump.c

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include

LOCAL_SHARED_LIBRARIES:= \
    libc

LOCAL_STATIC_LIBRARIES := \
    i2c-tools

LOCAL_CPPFLAGS += -DANDROID

include $(BUILD_EXECUTABLE)

################### i2ctransfer #######################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)
LOCAL_MODULE:=i2ctransfer

LOCAL_SRC_FILES := \
    tools/i2ctransfer.c

LOCAL_C_INCLUDES += \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/include

LOCAL_SHARED_LIBRARIES := \
    libc

LOCAL_STATIC_LIBRARIES := \
    i2c-tools

LOCAL_CPPFLAGS += -DANDROID

include $(BUILD_EXECUTABLE)
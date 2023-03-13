LOCAL_DIR := $(GET_LOCAL_DIR)

MODULE := $(LOCAL_DIR)
#app_i2c
MODULE_SRCS += \
	$(LOCAL_DIR)/i2ctools.c \

MODULE_COMPILEFLAGS += -Wno-format -fno-builtin -Wno-unused-variable -Wno-sign-compare -Wno-format -Wno-int-to-void-pointer-cast

include make/module.mk

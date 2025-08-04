-- xmake.lua

-- 设置工具链（根据你的交叉编译工具链路径调整）
-- 假设你已经安装了 arm-linux-gnueabihf 工具链

-- 定义平台配置
set_project("i2c-tools")

-- i2c-tools 静态库
target("i2c-tools")
    set_kind("static")
    add_files("tools/i2cbusses.c", "tools/util.c", "lib/smbus.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_cflags("-g", "-Wall", "-Werror", "-Wno-unused-parameter")

-- i2cdetect
target("i2cdetect")
    set_kind("binary")
    add_files("tools/i2cdetect.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID")

-- i2cget
target("i2cget")
    set_kind("binary")
    add_files("tools/i2cget.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID")

-- i2cset
target("i2cset")
    set_kind("binary")
    add_files("tools/i2cset.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID")

-- i2cdump
target("i2cdump")
    set_kind("binary")
    add_files("tools/i2cdump.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID")

-- i2ctransfer
target("i2ctransfer")
    set_kind("binary")
    add_files("tools/i2ctransfer.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID")

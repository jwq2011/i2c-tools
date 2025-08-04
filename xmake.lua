-- xmake.lua

-- 定义平台配置
set_project("i2c-tools")

-- 设置默认平台为 armv7
set_plat("linux")
set_arch("armv7")

-- 直接配置交叉编译工具链
set_toolset("cc", "arm-linux-gnueabihf-gcc")
set_toolset("cxx", "arm-linux-gnueabihf-g++")
set_toolset("ld", "arm-linux-gnueabihf-gcc")
set_toolset("ar", "arm-linux-gnueabihf-ar")
set_toolset("strip", "arm-linux-gnueabihf-strip")

-- i2c-tools 静态库
target("i2c-tools")
    set_kind("static")
    add_files("tools/i2cbusses.c", "tools/util.c", "lib/smbus.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_cflags("-g", "-Wall", "-Werror", "-Wno-unused-parameter")
    set_languages("c99")

-- i2cdetect
target("i2cdetect")
    set_kind("binary")
    add_files("tools/i2cdetect.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID", "-D_GNU_SOURCE")
    add_ldflags("-static")
    set_languages("c99")

-- i2cget
target("i2cget")
    set_kind("binary")
    add_files("tools/i2cget.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID", "-D_GNU_SOURCE")
    add_ldflags("-static")
    set_languages("c99")

-- i2cset
target("i2cset")
    set_kind("binary")
    add_files("tools/i2cset.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID", "-D_GNU_SOURCE")
    add_ldflags("-static")
    set_languages("c99")

-- i2cdump
target("i2cdump")
    set_kind("binary")
    add_files("tools/i2cdump.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID", "-D_GNU_SOURCE")
    add_ldflags("-static")
    set_languages("c99")

-- i2ctransfer
target("i2ctransfer")
    set_kind("binary")
    add_files("tools/i2ctransfer.c")
    add_includedirs("$(projectdir)", "$(projectdir)/include")
    add_deps("i2c-tools")
    add_cflags("-DANDROID", "-D_GNU_SOURCE")
    add_ldflags("-static")
    set_languages("c99")

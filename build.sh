
# make CC=arm-linux-gnueabihf-gcc USE_STATIC_LIB=1
if [ -e $1 ]; then
    echo "请输入工具链路径!"
    exit 1
fi
make \
CC=$1 \
USE_STATIC_LIB=1 \
BUILD_DYNAMIC_LIB=0

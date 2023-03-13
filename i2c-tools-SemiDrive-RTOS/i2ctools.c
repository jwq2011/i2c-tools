/*
 * Copyright (c) 2020 Semidrive Semiconductor, Inc.
 * All rights reserved.
 */

#include <stdlib.h>
#include <assert.h>
#include <debug.h>
#include <stdio.h>
#include <err.h>
#include <i2c_hal.h>
#include <hal_port.h>

#include <dw_i2c_test.h>
#include <dw_i2c_reg.h>
#include <assert.h>
#include <err.h>
#include <reg.h>

/*
** this is i2ctools for how use i2c-dw api
*/

#if defined(WITH_LIB_CONSOLE)
#include <lib/console.h>

static uint32_t i2c_bus_res_get(uint8_t i2c_bus)
{
    uint32_t ret = 0;
    switch(i2c_bus){
        case 1:
            ret = RES_I2C_I2C1;
            break;

        case 2:
            ret = RES_I2C_I2C2;
            break;

        case 3:
            ret = RES_I2C_I2C3;
            break;

        case 4:
            ret = RES_I2C_I2C4;
            break;

        default :
            dprintf(CRITICAL, "error,input i2c_bus(=%d) error,no resoure matched\n", i2c_bus);
            break;
    }

    if( i2c_bus <=4 ){
        uint32_t res_location = *(uint32_t *)0xfc280000;
        res_location = res_location>>(8+i2c_bus-1);
        res_location &= 0x01;

        if(res_location != 0){
            dprintf(CRITICAL, "error,I2C_%d is in %s\n", i2c_bus, (res_location == 0)? "saf":"ap");
            ret = 0;  //res is in ap,can't use in saf
        }
    }

    return ret;
}

static int cmd_i2cset(int argc, const cmd_args *argv)
{
    void *i2c_handle;
    bool create_state = false;

    uint32_t i2c_bus = 0;
    uint16_t i2c_addr = 0;
    uint8_t i2c_reg = 0;
    uint8_t i2c_val = 0;
    int ret = -1;

    i2c_bus = (uint32_t )argv[1].u;
    i2c_addr = (uint16_t )argv[2].u; //this addr should full 8bit
    i2c_reg = (uint8_t )argv[3].u;
    i2c_val = (uint8_t )argv[4].u;
    i2c_addr >>= 1;  //make addr as 7bit format

    uint32_t i2c_bus_res = i2c_bus_res_get(i2c_bus);
    if(0 == i2c_bus_res) {
        dprintf(CRITICAL, "I2C_%d is in ap,can't use in safety domain\n", i2c_bus);
    }
    create_state = hal_i2c_creat_handle(&i2c_handle, i2c_bus_res);
    if (!create_state){
        dprintf(CRITICAL, "%s creat fail\n", __func__);
        return -1;
    }

    ret = hal_i2c_write_reg_data(i2c_handle, i2c_addr, &i2c_reg, 1, &i2c_val, 1);
    if(ret < 0){
        dprintf(INFO, "\ni2c-%d write reg=%d error\n", i2c_bus, i2c_reg);
    }else{
        dprintf(INFO, "\ni2c-%d write device(0x%x) reg=%x val=%x\n",
                i2c_bus, i2c_addr<<1, i2c_reg, i2c_val);
    }

    hal_i2c_release_handle(i2c_handle);

    return 0;
}

static int cmd_i2cget(int argc, const cmd_args *argv)
{
    void *i2c_handle;
    bool create_state = false;

    uint32_t i2c_bus = 0;
    uint16_t i2c_addr = 0; //this addr should full 8bit
    uint8_t i2c_reg = 0;
    uint8_t i2c_val = 0;
    int ret = -1;

    i2c_bus = (uint32_t )argv[1].u;
    i2c_addr = (uint16_t )argv[2].u;
    i2c_reg = (uint8_t )argv[3].u;
    i2c_val = (uint8_t )argv[4].u;
    i2c_addr >>= 1;  //make addr as 7bit format

    uint32_t i2c_bus_res = i2c_bus_res_get(i2c_bus);
    if(0 == i2c_bus_res) {
        dprintf(CRITICAL, "I2C_%d is in ap,can't use in safety domain\n", i2c_bus);
    }
    create_state = hal_i2c_creat_handle(&i2c_handle, i2c_bus_res);
    if (!create_state){
        dprintf(CRITICAL, "%s creat fail\n", __func__);
        return -1;
    }

    ret = hal_i2c_read_reg_data(i2c_handle, i2c_addr, &i2c_reg, 1, &i2c_val, 1);
    if(ret < 0){
        dprintf(CRITICAL, "\ni2c-%d read reg=%d error\n", i2c_bus, i2c_reg);
    }else{
        dprintf(INFO, "\ni2c-%d read device(0x%x) reg=%x val=%x\n",
                i2c_bus, i2c_addr<<1, i2c_reg, i2c_val);
    }

    hal_i2c_release_handle(i2c_handle);
    return 0;
}

static int cmd_i2cdump(int argc, const cmd_args *argv)
{
    void *i2c_handle;
    bool create_state = false;

    uint32_t i2c_bus = 0;
    uint16_t i2c_addr = 0;
    uint8_t i2c_reg = 0;
    uint8_t i2c_val = 0;
    uint32_t offset = 0;
    uint32_t len = 64;
    uint32_t i;
    int ret = -1;

    i2c_bus = (uint32_t )argv[1].u;
    i2c_addr = (uint16_t )argv[2].u; //this addr should full 8bit
    offset = (uint32_t )argv[3].u;
    len = (uint32_t )argv[4].u;
    i2c_addr >>= 1;  //make addr as 7bit format

    uint32_t i2c_bus_res = i2c_bus_res_get(i2c_bus);
    if(0 == i2c_bus_res) {
        dprintf(CRITICAL, "I2C_%d is in ap,can't use in safety domain\n", i2c_bus);
    }
    create_state = hal_i2c_creat_handle(&i2c_handle, i2c_bus_res);
    if (!create_state){
        dprintf(CRITICAL, "%s creat fail\n", __func__);
        return -1;
    }

    dprintf(INFO, " i2c-%d read device addr=0x%x. offset=%d len=%d\n",
            i2c_bus, i2c_addr, offset, len);
    for(i = offset; i < (offset + len); i++){
        if(i%16 == 0){
            dprintf(INFO, "\n");
        }

        if(i%8 == 0){
            dprintf(INFO, " ");
        }

        ret = hal_i2c_read_reg_data(i2c_handle, i2c_addr, &i, 1, &i2c_val, 1);
        if(ret < 0){
            dprintf(CRITICAL, " --");
        }else{
            dprintf(INFO, " %.02x", i2c_val);
        }
    }

    hal_i2c_release_handle(i2c_handle);
    return 0;
}

static int cmd_i2cdetect(int argc, const cmd_args *argv)
{
    void *i2c_handle;
    bool create_state = false;

    uint32_t i2c_bus = 0;
    uint16_t i2c_addr = 0;
    uint8_t i2c_reg = 0;
    uint8_t i2c_val = 0;
    uint16_t len = 128;
    uint32_t i;
    int ret = -1;

    i2c_bus = (uint32_t )argv[1].u;
    i2c_addr >>= 1;  //make addr as 7bit format

    uint32_t i2c_bus_res = i2c_bus_res_get(i2c_bus);
    if(0 == i2c_bus_res) {
        dprintf(CRITICAL, "I2C_%d is in ap,can't use in safety domain\n", i2c_bus);
    }
    create_state = hal_i2c_creat_handle(&i2c_handle, i2c_bus_res);
    if (!create_state){
        dprintf(CRITICAL, "%s creat fail\n", __func__);
        return -1;
    }

    dprintf(INFO, "i2c_bus=%d device detect:\n", i2c_bus);
    i2c_reg = 0x01;
    for(i = 0; i < len; i++){
        if(i%16 == 0){
            dprintf(INFO, "\n");
        }

        if(i%8 == 0){
            dprintf(INFO," ");
        }

        ret = hal_i2c_read_reg_data(i2c_handle, i, &i2c_reg, 1, &i2c_val, 1);
        if(ret < 0){
            dprintf(INFO, " --");
        }else{
            dprintf(INFO, " %.02x", i2c_val);
        }
    }

    hal_i2c_release_handle(i2c_handle);
    return 0;
}

#define I2CSET_STR "i2cset bus addr(8bit) reg val.\n" \
    "\t\texample: i2cset 4 0xA0 0x01 0xAF" \
    "  ---set i2c-4's A0 device's 01 reg = 0xAF"

#define I2CGET_STR "i2cget bus addr(8bit) reg.\n" \
    "\t\texample: i2cget 4 0xA0 0x01" \
    "  ---get i2c-4's A0 device's 01 reg"

 #define I2CDUMP_STR "i2cdump bus addr(8bit) off len.\n" \
    "\t\texample: i2cdump 4 0xA0 0 128" \
    "   ---dump i2c-4's A0 device's 01~128 reg"

 #define I2CDETECT_STR "i2cdetect bus" \
    "detect i2c-4's devices."

STATIC_COMMAND_START
STATIC_COMMAND("i2cset", I2CSET_STR,(console_cmd)&cmd_i2cset)
STATIC_COMMAND("i2cget", I2CGET_STR,(console_cmd)&cmd_i2cget)
STATIC_COMMAND("i2cdump", I2CDUMP_STR,(console_cmd)&cmd_i2cdump)
STATIC_COMMAND("i2cdetect", I2CDETECT_STR,(console_cmd)&cmd_i2cdetect)
STATIC_COMMAND_END(i2ctools);
#endif


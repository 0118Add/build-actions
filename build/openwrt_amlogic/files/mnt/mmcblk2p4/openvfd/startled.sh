#!/bin/bash

if [ "$1" == "" ];then
	echo "使用方法： $0 <config_file> [test]"
	exit 1
fi

CONF=$1
MYHOME=$(dirname $0)
cd $MYHOME
MYHOME=${PWD}

SERVICE="${MYHOME}/vfdservice"
echo "service is $SERVICE"

if [ -f "$CONF" ];then
	source $CONF
else
	echo "配置文件 $CONF 不存在！"
	exit 1
fi

modprobe openvfd vfd_gpio_clk=${vfd_gpio_clk} \
                         vfd_gpio_dat=${vfd_gpio_dat} \
                         vfd_gpio_stb=${vfd_gpio_stb:-0,0,0xFF} \
                         vfd_gpio0=${vfd_gpio0:-0,0,0xFF} \
                         vfd_gpio1=${vfd_gpio1:-0,0,0xFF} \
                         vfd_gpio2=${vfd_gpio2:-0,0,0xFF} \
                         vfd_gpio3=${vfd_gpio3:-0,0,0xFF} \
                         vfd_gpio_protocol=${vfd_gpio_protocol:-0,0} \
                         vfd_chars=${vfd_chars} vfd_dot_bits=${vfd_dot_bits} \
                         vfd_display_type=${vfd_display_type}

"${SERVICE}" &

trap "killall ${SERVICE}; rmmod openvfd; exit" 2 3 15

if [ "$2" == "test" ];then
	DEBUG=1
fi

while :;do
	echo "--->"
	for func in $functions;do
		echo "-----------------------------------------"
		echo "turn led $func on ... "
		echo "$func" > /sys/class/leds/openvfd/led_on
		if [ "$DEBUG" == "1" ];then
		    sleep 5
		    echo "turn led $func off ... "
		    echo "$func" > /sys/class/leds/openvfd/led_off
		    echo "-----------------------------------------"
		    sleep 5
		fi
	done
	echo "<---"
	if [ "$DEBUG" != "1" ];then
		exit 0
	fi
done

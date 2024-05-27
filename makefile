.PHONY : tc ts clean install uninstall android-install android-uninstall

all: tc ts

tc:
	cd tc; make; cd ..

ts:
	cd ts; make; cd ..

clean:
	cd tc; make clean; cd ..
	cd ts; make clean; cd ..

install:
	sudo cp bin/echo-client /usr/local/sbin
	sudo cp bin/echo-server /usr/local/sbin

uninstall:
	sudo rm /usr/local/sbin/echo-client /usr/local/sbin/echo-server

android-install:
	adb push bin/echo-client bin/echo-server /data/local/tmp
	adb exec-out "su -c 'mount -o rw,remount /system'"
	adb exec-out "su -c 'cp /data/local/tmp/echo-client /data/local/tmp/echo-server /system/xbin'"
	adb exec-out "su -c 'chmod 755 /system/xbin/echo-client'"
	adb exec-out "su -c 'chmod 755 /system/xbin/echo-server'"
	adb exec-out "su -c 'mount -o ro,remount /system'"
	adb exec-out "su -c 'rm /data/local/tmp/echo-client /data/local/tmp/echo-server'"

android-uninstall:
	adb exec-out "su -c 'mount -o rw,remount /system'"
	adb exec-out "su -c 'rm /system/xbin/echo-server /system/xbin/echo-client'"
	adb exec-out "su -c 'mount -o ro,remount /system'"

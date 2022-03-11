# phicomm-n1 userpatch for armbian/build #
build minimal armbian image for phicomm-n1.

## usage ##
```
git clone https://github.com/armbian/build
cd build
git clone https://github.com/whiler/armbian-n1-userpatch userpatches
git checkout $(awk -F '\"' '/LIB_TAG/ {print $2}' userpatches/config-phicomm-n1.conf)
./compile.sh
```

## thanks ##
- <https://github.com/armbian/build>
- <https://www.kflyo.com/howto-compile-armbian-for-n1-box/>
- <https://github.com/yunsur/phicomm-n1>
- <https://github.com/ophub/amlogic-s9xxx-armbian>

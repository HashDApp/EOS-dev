# EOS-dev

在这里记录下开发EOS智能合约过程中的一些笔记  
如有错误之处，还请多多指正  
谢谢  

## 环境搭建

参考 https://developers.eos.io/eosio-nodeos/docs/getting-the-code  

使用Ubuntu 16.04  
git clone https://github.com/EOSIO/eos --recursive  
cd eos  
git submodule update --init --recursive  
./eosio_build.sh -s EOS  
cd build
make install

如果本地主机或虚拟机内存、磁盘空间不够报错  
可以通过修改脚本scripts/eosio_build_ubuntu.sh  
将exit 1注释掉
```
        if [ "${MEM_MEG}" -lt 7000 ]; then
                printf "\\tYour system must have 7 or more Gigabytes of physical memory installed.\\n"
                printf "\\tExiting now.\\n"
                # exit 1
        fi

        if [ "${DISK_AVAIL%.*}" -lt "${DISK_MIN}" ]; then
                printf "\\tYou must have at least %sGB of available storage to install EOSIO.\\n" "${DISK_MIN}"
                printf "\\tExiting now.\\n"
                # exit 1
        fi
```


## 头文件引用
在make install的时候，会将用到的头文件复制到目录/usr/local/include下  
如果遇到头文件找不到的情况  
比如contracts/eosio.token里的头文件eosio.token.hpp  
是因为默认contracts/CMakeLists.txt中没有安装eosio.token目录  
可以在contracts/CMakeLists.txt增加一行  
***install(DIRECTORY eosio.token DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR})***  
来解决
```
install(DIRECTORY eosiolib DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}) 
install(DIRECTORY eosio.system DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}) 
install(DIRECTORY eosio.token DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}) 
install(DIRECTORY musl DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}) 
install(DIRECTORY libc++ DESTINATION ${CMAKE_INSTALL_FULL_INCLUDEDIR}) 
install(DIRECTORY skeleton DESTINATION ${CMAKE_INSTALL_FULL_DATAROOTDIR}/eosio) 
install_directory_permissions(DIRECTORY ${CMAKE_INSTALL_FULL_DATAROOTDIR}/eosio) 
```

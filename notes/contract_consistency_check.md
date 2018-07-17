# 验证链上合约一致性

1、使用eosiocpp编译合约源代码  
```
# eosiocpp -o hello.wast hello.cpp
```
得到文件hello.wasm  hello.wast  

2、使用如下命令计算.wasm文件的哈希值  
```
# sha256sum hello.wasm
1d0070ffc528f1268ad1f6c5ba998245811318bdcfd8827432d56e24c69a476c  hello.wasm
```

3、使用如下命令获取链上合约的哈希值
```
# cleos get code contractuser
code hash: 1d0070ffc528f1268ad1f6c5ba998245811318bdcfd8827432d56e24c69a476c
```

两个哈希值一致，说明链上运行的合约与源代码的实现一致  

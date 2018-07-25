# 账号数值范围

```
/**
 * @brief Name of an account
 * @details Name of an account
 */
typedef uint64_t account_name;
```

```
# g++ account_name_range.cpp
# ./a.out 
.12345abcdefghijklmnopqrstuvwxyz
strlen(charmap): 32
0 1 2 3 4 5 6 7 8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 
            1 :   576460752303423488
 111111111111 :   595056260442243600
 zzzzzzzzzzzz : 18446744073709551600
 zzzzzzzzzzzz :     fffffffffffffff0
zzzzzzzzzzzzz :     ffffffffffffffff
zzzzzzzzzzzzm :     fffffffffffffff2
zzzzzzzzzzzz5 :     fffffffffffffff5
zzzzzzzzzzzzp :     fffffffffffffff5
```

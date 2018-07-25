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
# ./a.out -t -n eosio
.12345abcdefghijklmnopqrstuvwxyz
strlen(charmap): 32
0 1 2 3 4 5 6 7 8 9 a b c d e f 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f 
 ............ :                    0
 111111111111 :   595056260442243600
 222222222222 :  1190112520884487200
 333333333333 :  1785168781326730800
 444444444444 :  2380225041768974400
 555555555555 :  2975281302211218000
 aaaaaaaaaaaa :  3570337562653461600
 bbbbbbbbbbbb :  4165393823095705200
 cccccccccccc :  4760450083537948800
 dddddddddddd :  5355506343980192400
 eeeeeeeeeeee :  5950562604422436000
 ffffffffffff :  6545618864864679600
 gggggggggggg :  7140675125306923200
 hhhhhhhhhhhh :  7735731385749166800
 iiiiiiiiiiii :  8330787646191410400
 jjjjjjjjjjjj :  8925843906633654000
 kkkkkkkkkkkk :  9520900167075897600
 llllllllllll : 10115956427518141200
 mmmmmmmmmmmm : 10711012687960384800
 nnnnnnnnnnnn : 11306068948402628400
 oooooooooooo : 11901125208844872000
 pppppppppppp : 12496181469287115600
 qqqqqqqqqqqq : 13091237729729359200
 rrrrrrrrrrrr : 13686293990171602800
 ssssssssssss : 14281350250613846400
 tttttttttttt : 14876406511056090000
 uuuuuuuuuuuu : 15471462771498333600
 vvvvvvvvvvvv : 16066519031940577200
 wwwwwwwwwwww : 16661575292382820800
 xxxxxxxxxxxx : 17256631552825064400
 yyyyyyyyyyyy : 17851687813267308000
 zzzzzzzzzzzz : 18446744073709551600
            1 :   576460752303423488
 zzzzzzzzzzzz :     fffffffffffffff0
zzzzzzzzzzzzz :     ffffffffffffffff
zzzzzzzzzzzzm :     fffffffffffffff2
zzzzzzzzzzzz5 :     fffffffffffffff5
zzzzzzzzzzzzp :     fffffffffffffff5
        eosio :  6138663577826885632
```

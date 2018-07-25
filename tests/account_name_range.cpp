/**
 *  @hashdapp
 *
 *  splited from eos/contracts/eosiolib/types.hpp
 */

#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <iostream>
#include <iomanip>

using namespace std;

static char char_to_symbol( char c ) {
   if( c >= 'a' && c <= 'z' )
      return (c - 'a') + 6;
   if( c >= '1' && c <= '5' )
      return (c - '1') + 1;
   return 0;
}

static uint64_t string_to_name( const char* str ) {

   uint32_t len = 0;
   while( str[len] ) ++len;

   uint64_t value = 0;

   for( uint32_t i = 0; i <= 12; ++i ) {
      uint64_t c = 0;
      if( i < len && i <= 12 ) c = uint64_t(char_to_symbol( str[i] ));

      if( i < 12 ) {
         c &= 0x1f;
         c <<= 64-5*(i+1);
      }
      else {
         c &= 0x0f;
      }

      value |= c;
   }

   return value;
}

void dump_name(const char *name, string type)
{
    cout << right << setw(13) << name << " : ";
    if (type == "hex") {
        cout << hex;
    } else {
        cout << dec;
    }

    cout << right << setw(20);
    cout << string_to_name(name) << endl;
}

int test = 0;
char *name = NULL;

int main(int argc, char **argv)
{
    int ch;
    while ((ch = getopt(argc,argv,"n:t")) != -1) {
        switch (ch) {
        case 't': {
            test = 1;
            break;
        }
        case 'n': {
            name = optarg;
            break;
        }
        default: {

            break;
        }
        }
    }

    if (test) {
        static const char* charmap = ".12345abcdefghijklmnopqrstuvwxyz";
        cout << charmap << endl;
        cout << "strlen(charmap): " << strlen(charmap) << endl;

        int i;
        for (i = 0; i < strlen(charmap); i++) {
            cout << hex << uint64_t(char_to_symbol(charmap[i])) << " ";
        }
        cout << endl;

        for (i = 0; i < strlen(charmap); i++) {
            char n[13];
            int j;
            for (j = 0; j < 12; j++) {
                n[j] = charmap[i];
            }
            n[12] = 0;
            dump_name(n, "");
        }

        dump_name("1", "");
        dump_name("zzzzzzzzzzzz", "hex");
        dump_name("zzzzzzzzzzzzz", "hex");
        dump_name("zzzzzzzzzzzzm", "hex");
        dump_name("zzzzzzzzzzzz5", "hex");
        dump_name("zzzzzzzzzzzzp", "hex");
    }

    if (name) {
        dump_name(name, "");
    }

    return 0;
}


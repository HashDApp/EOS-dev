#!/usr/bin/env python3
# coding:utf-8

import base58
from binascii import hexlify, unhexlify
import os
import hashlib
import ecdsa
import argparse


def ripemd160(data):
    h = hashlib.new('ripemd160')
    h.update(data)
    return h.hexdigest()


def get_x_str(_vk):
    return hexlify(ecdsa.util.number_to_string(_vk.pubkey.point.x(), _vk.pubkey.order)).decode()


def get_y_big_num(_vk):
    return _vk.pubkey.point.y()


def wif_to_hex_str(wif):
    return hexlify(base58.b58decode_check(wif)).decode()[2:]


def hex_str_to_wif(hexstr):
    ps = unhexlify('80' + hexstr)
    bck = base58.b58encode_check(ps)
    if isinstance(bck, bytes):
        bck = bck.decode()
    return bck


def get_comp_key_hex_str(_vk):
    # compressed
    # 0x02 for even, 0x03 for odd
    prefix = '02'
    if get_y_big_num(_vk) & 1:
        prefix = '03'
    compressed = prefix + get_x_str(_vk)
    return compressed


def get_public_key(vk):
    cmpub = get_comp_key_hex_str(vk)
    rip1 = ripemd160(unhexlify(cmpub))
    chksum = rip1[:8]
    pub = base58.b58encode(unhexlify(cmpub + chksum))
    if isinstance(pub, bytes):
        pub = pub.decode()
    addr = 'EOS' + pub
    return addr


def get_rand_pri_hex_str():
    rand = os.urandom(32)
    return hexlify(rand).decode()


def test():
    wift = '5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3'
    pub = 'EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV'
    prihex = wif_to_hex_str(wift)
    sk = ecdsa.SigningKey.from_string(unhexlify(prihex), ecdsa.SECP256k1)
    vk = sk.get_verifying_key()
    addr = get_public_key(vk)
    print(prihex)
    print(wift)
    print(addr)
    if pub != addr:
        print('error')
    else:
        print('pass')


def gen_rand_key():
    prihex = get_rand_pri_hex_str()
    sk = ecdsa.SigningKey.from_string(unhexlify(prihex), ecdsa.SECP256k1)
    vk = sk.get_verifying_key()
    addr = get_public_key(vk)
    print('Private Key:', hex_str_to_wif(prihex))
    print('Public Key:', addr)


def pub_from_wif(wif):
    prihex = wif_to_hex_str(wif)
    sk = ecdsa.SigningKey.from_string(unhexlify(prihex), ecdsa.SECP256k1)
    vk = sk.get_verifying_key()
    addr = get_public_key(vk)
    print('Private Key:', hex_str_to_wif(prihex))
    print('Public Key:', addr)


def start_main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--test', action='store_true', help='test')
    parser.add_argument('-w', '--wif', help='get public key from private key wif')
    args = parser.parse_args()
    if args.test:
        test()
        return
    if args.wif:
        pub_from_wif(args.wif)
        return
    gen_rand_key()


if __name__ == '__main__':
    start_main()

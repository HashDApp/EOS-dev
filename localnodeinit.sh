#!/bin/bash

set -x

cd ~/eos

#cleos wallet unlock

# default key
cleos wallet import 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

# demo key
cleos wallet import 5Jmsawgsp1tQ3GD6JyGCwy1dcvqKZgX6ugMVMdjirx85iv5VyPR

cleos set contract eosio build/contracts/eosio.bios -p eosio@active

cleos create account eosio contractuser EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio user EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio user1 EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio user2 EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio user3 EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio tester EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio tester1 EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio tester2 EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos create account eosio tester3 EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4

cleos create account eosio eosio.token EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos set contract eosio.token build/contracts/eosio.token -p eosio.token@active

cleos push action eosio.token create '[ "eosio", "1000000000.0000 EOS"]' -p eosio.token@active
cleos push action eosio.token issue '[ "user", "100000000.0000 EOS", "memo" ]' -p eosio@active

cleos push action eosio.token transfer '[ "user", "contractuser", "25000.0000 EOS", "m" ]' -p user@active
cleos push action eosio.token transfer '[ "user", "user1", "25000.0000 EOS", "m" ]' -p user@active
cleos push action eosio.token transfer '[ "user", "user2", "25000.0000 EOS", "m" ]' -p user@active
cleos push action eosio.token transfer '[ "user", "user3", "25000.0000 EOS", "m" ]' -p user@active
cleos push action eosio.token transfer '[ "user", "tester", "25000.0000 EOS", "m" ]' -p user@active
cleos push action eosio.token transfer '[ "user", "tester1", "25000.0000 EOS", "m" ]' -p user@active
cleos push action eosio.token transfer '[ "user", "tester2", "25000.0000 EOS", "m" ]' -p user@active
cleos push action eosio.token transfer '[ "user", "tester3", "25000.0000 EOS", "m" ]' -p user@active

cleos create account eosio exchange EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos set contract exchange build/contracts/exchange -p exchange@active

cleos create account eosio eosio.msig EOS7ijWCBmoXBi3CgtK7DJxentZZeTkeUnaSDvyro9dq7Sd1C3dC4
cleos set contract eosio.msig build/contracts/eosio.msig -p eosio.msig@active




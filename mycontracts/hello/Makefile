#

CONTRACT = hello

all: abi wast deploy


abi:
	eosiocpp -g $(CONTRACT).abi $(CONTRACT).cpp

wast:
	eosiocpp -o $(CONTRACT).wast $(CONTRACT).cpp

deploy:
	cleos set contract contractuser ../$(CONTRACT) -p contractuser@active

test:
	cleos push action contractuser hi '[ "user" ]' -p user@active
	cleos push action contractuser hi '[ "user" ]' -p user1@active

clean:
	rm -rf $(CONTRACT).abi $(CONTRACT).wasm $(CONTRACT).wast

.PHONY: all abi wast deploy test clean



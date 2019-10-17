###############################################
#
# Makefile
#
###############################################

GOROOT:=/usr/local/go
# by default goes to ~/go
GOPATH:=~/go
PATH:=$(shell echo ${GOPATH}/bin:$$PATH)

env:
	echo ${PATH}

home:
	open https://github.com/asticode/go-astilectron

install:
	go get -u github.com/asticode/go-astilectron-demo/...
	-rm ${GOPATH}/src/github.com/asticode/go-astilectron-demo/bind.go
	# windows
	go get -u github.com/mattn/go-colorable/...
	go get -u github.com/konsorten/go-windows-terminal-sequences/...

bundler:
	# go get -u github.com/asticode/go-astilectron-bundler/...
	go install github.com/asticode/go-astilectron-bundler/astilectron-bundler


WIN = "{\"arch\":\"386\",\"os\":\"windows\"}"
MAC = "{\"arch\":\"amd64\",\"os\":\"darwin\"}"
setup:
	# cat bundler.json
	cat ${GOPATH}/src/github.com/asticode/go-astilectron-demo/bundler.json | jq --argjson environments [${WIN},${MAC}] '. += {environments: $$environments}'

show:
	cat ${GOPATH}/src/github.com/asticode/go-astilectron-demo/bundler.json

bundle:
	cd ${GOPATH}/src/github.com/asticode/go-astilectron-demo; \
	PATH="${PATH}" astilectron-bundler -v

list:
	ls ${GOPATH}/src/github.com/asticode/go-astilectron-demo/output

test:
	ls ${GOPATH}/src/github.com/asticode/go-astilectron-demo/output
	cd ${GOPATH}/src/github.com/asticode/go-astilectron-demo/output/darwin-amd64; \
	open Astilectron\ demo.app

.PHONY: all clean test bin php2v phpsrv run-srv run-transpile

CONFIG ?= laravel.yml
FILE ?= input.php

all: bin php2v phpsrv

bin:
	mkdir -p bin

php2v: bin
	v -nocache -path "src:@vlib" -o bin/php2v src/main.v

phpsrv: bin
	v -path "src:@vlib" -gc none -cc gcc \
	  -cflags "-I/usr/local/php-embed/include/php -I/usr/local/php-embed/include/php/main -I/usr/local/php-embed/include/php/Zend -I/usr/local/php-embed/include/php/TSRM -I/usr/local/php-embed/include/php/ext -I/usr/local/php-embed/include/php/sapi/embed -I/opt/homebrew/opt/curl/include" \
	  -ldflags "-L/usr/local/php-embed/lib -Wl,-rpath,/usr/local/php-embed/lib -lphp -L/opt/homebrew/opt/curl/lib -lcurl -lresolv -lxml2 -liconv -lz" \
	  -o bin/phpsrv src/phpsrv_main.v

# 1. 简易一键运行 Embedded Server (默认 laravel.yml，也可 make run-srv CONFIG=gateway.yaml)
run-srv: phpsrv
	./bin/phpsrv $(CONFIG)

# 2. 简易一键运行代码转译器 (如 make run-transpile FILE=path/to/script.php)
run-transpile: php2v
	./bin/php2v compile $(FILE)

test: php2v
	v test tests/

clean:
	rm -rf bin/
	rm -rf tmp/build/
	rm -f tests/fixtures/*.v
	rm -f tests/fixtures/14_include

%.bin: %.php php2v
	v run build.v $<

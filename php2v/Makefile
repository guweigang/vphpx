.PHONY: all clean test bin php2v phpsrv

all: bin php2v phpsrv

bin:
	mkdir -p bin

php2v: bin
	v -nocache -path "src:@vlib" -o bin/php2v src/main.v

phpsrv: bin
	v -path "src:@vlib" -gc none -cc gcc \
	  -cflags "-I/usr/local/php-embed/include/php -I/usr/local/php-embed/include/php/main -I/usr/local/php-embed/include/php/Zend -I/usr/local/php-embed/include/php/TSRM -I/usr/local/php-embed/include/php/ext -I/usr/local/php-embed/include/php/sapi/embed -I/opt/homebrew/opt/curl/include" \
	  -ldflags "-L/usr/local/php-embed/lib -lphp -L/opt/homebrew/opt/curl/lib -lcurl -lresolv -lxml2 -liconv -lz" \
	  -o bin/phpsrv src/phpsrv_main.v

test: php2v
	v test tests/

clean:
	rm -rf bin/
	rm -rf tmp/build/
	rm -f tests/fixtures/*.v
	rm -f tests/fixtures/14_include

# 编译任意 PHP 文件为二进制
# 用法: make tests/fixtures/14_include.bin
%.bin: %.php php2v
	v run build.v $<

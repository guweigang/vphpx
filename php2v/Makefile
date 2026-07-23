.PHONY: all clean test playground

all: php2v

php2v:
	v -nocache -keepc -path "..:@vlib" -o php2v src

test: php2v
	v test tests/

playground:
	python3 scripts/generate_playground_data.py

clean:
	rm -f php2v
	rm -f tests/fixtures/*.v
	rm -f tests/fixtures/14_include

server:
	v -path "src:@vlib" -gc none -cc gcc \
	  -cflags "-I/usr/local/php-embed/include/php -I/usr/local/php-embed/include/php/main -I/usr/local/php-embed/include/php/Zend -I/usr/local/php-embed/include/php/TSRM -I/usr/local/php-embed/include/php/ext -I/usr/local/php-embed/include/php/sapi/embed -I/opt/homebrew/opt/curl/include" \
	  -ldflags "-L/usr/local/php-embed/lib -lphp -L/opt/homebrew/opt/curl/lib -lcurl -lresolv -lxml2 -liconv -lz" \
	  -o tmp/build/test_gateway tmp/build/test_gateway.v

# 编译任意 PHP 文件为二进制
# 用法: make tests/fixtures/14_include.bin
%.bin: %.php php2v
	v run build.v $<

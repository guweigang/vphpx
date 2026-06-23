.PHONY: all clean test

all: php2v_bin

php2v_bin:
	v -o php2v_bin php2v

test: php2v_bin
	v test tests/

clean:
	rm -f php2v_bin
	rm -f tests/fixtures/*.v
	rm -f tests/fixtures/14_include

# 编译任意 PHP 文件为二进制
# 用法: make tests/fixtures/14_include.bin
%.bin: %.php php2v_bin
	v run build.v $<

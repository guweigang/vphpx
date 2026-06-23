.PHONY: all clean test

all: php2v

php2v:
	v -path "..:@vlib" -o php2v src

test: php2v
	v test ../tests/

clean:
	rm -f php2v
	rm -f ../tests/fixtures/*.v
	rm -f ../tests/fixtures/14_include

# 编译任意 PHP 文件为二进制
# 用法: make ../tests/fixtures/14_include.bin
%.bin: %.php php2v
	v run build.v $<

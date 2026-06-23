module rt

// echo_val 输出 PhpVal 的字符串形式到标准输出 (echo 语句)
pub fn echo_val(v PhpVal) {
	print(v.to_string())
}

// print_val 输出 PhpVal 字符串形式到标准输出，并返回 1 (print 表达式)
pub fn print_val(v PhpVal) PhpVal {
	print(v.to_string())
	return new_int(1)
}

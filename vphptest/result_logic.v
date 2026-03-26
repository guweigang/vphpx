module main
import os
// ============================================
// Result 桥接测试用例
// ============================================
// 本文件用于测试 V Result (!) → PHP Exception 自动桥接。
// 所有带 ! 返回类型的方法/函数由编译器自动生成 call_or_throw / call_or_throw_val 调用。

// --- Validator 类：测试实例方法 ---

@[heap]
@[php_class]
struct Validator {
pub mut:
	strict bool
}

@[php_method]
pub fn (mut v Validator) construct(strict bool) {
	v.strict = strict
}

// !bool: 返回验证结果，或在严格模式下遇到空字符串时报错
@[php_method]
pub fn (v &Validator) check(input string) !bool {
	if input == '' {
		return error('input must not be empty')
	}
	if v.strict && input.len < 3 {
		return error('input too short in strict mode')
	}
	return input.len >= 3
}

// !string: 返回净化后的字符串，或在输入非法时报错
@[php_method]
pub fn (v &Validator) sanitize(input string) !string {
	if input == '' {
		return error('cannot sanitize empty string')
	}
	return input.trim_space().to_lower()
}

// !void: 执行验证动作，成功无返回值，失败抛异常
@[php_method]
pub fn (v &Validator) assert_valid(input string) ! {
	if input == '' {
		return error('assertion failed: empty input')
	}
	if v.strict && input.contains('bad') {
		return error('assertion failed: contains forbidden word')
	}
}

// --- 静态方法测试 ---

// !int: 静态方法，解析字符串为整数
@[php_method]
pub fn Validator.parse_int(s string) !int {
	if s == '' {
		return error('cannot parse empty string')
	}
	val := s.int()
	if val == 0 && s != '0' {
		return error("invalid integer: '${s}'")
	}
	return val
}

// --- 全局函数测试 ---

// !int: 全局函数，安全除法
@[php_function]
fn v_safe_divide(a int, b int) !int {
	if b == 0 {
		return error('division by zero')
	}
	return a / b
}

// !string: 全局函数，首字母大写
@[php_function]
fn v_capitalize(input string) !string {
	if input == '' {
		return error('cannot capitalize empty string')
	}
	first := input[0..1].to_upper()
	rest := if input.len > 1 { input[1..] } else { '' }
	return first + rest
}

// !void: 全局函数，记录成功路径，失败时抛异常
@[php_function]
fn v_record_success(path string, label string) ! {
	if label == '' {
		return error('label must not be empty')
	}
	os.write_file(path, 'ok:' + label)!
}

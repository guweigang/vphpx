module main

import os
import vphp

// ============================================
// Option 桥接测试用例
// ============================================
// 本文件用于测试 V Option (?) → PHP null 自动桥接。
// 所有带 ? 返回类型的方法/函数由编译器自动生成 call_or_null / call_or_null_val 调用。

// --- Finder 类：测试实例方法 ---

@[heap]
@[php_class]
struct Finder {
pub mut:
	items []string
}

@[php_method]
pub fn (mut f Finder) construct(ctx vphp.Context) {
	count := ctx.arg[int](0)
	mut items := []string{}
	for i in 0 .. count {
		items << ctx.arg[string](i + 1)
	}
	f.items = items
}

// ?string: 查找包含 keyword 的第一个 item，找不到返回 none
@[php_method]
pub fn (f &Finder) find(keyword string) ?string {
	for item in f.items {
		if item.contains(keyword) {
			return item
		}
	}
	return none
}

// ?int: 返回 keyword 所在的索引，找不到返回 none
@[php_method]
pub fn (f &Finder) index_of(keyword string) ?int {
	for i, item in f.items {
		if item == keyword {
			return i
		}
	}
	return none
}

// ?bool: 检查是否为空，如果 items 为空返回 none（语义：无法判断）
@[php_method]
pub fn (f &Finder) has_match(keyword string) ?bool {
	if f.items.len == 0 {
		return none
	}
	for item in f.items {
		if item.contains(keyword) {
			return true
		}
	}
	return false
}

// --- 静态方法测试 ---

// ?int: 静态方法，安全解析整数，无效输入返回 none（而非抛异常）
@[php_method]
pub fn Finder.try_parse_int(s string) ?int {
	if s == '' {
		return none
	}
	val := s.int()
	if val == 0 && s != '0' {
		return none
	}
	return val
}

// --- 全局函数测试 ---

// ?string: 全局函数，查找 haystack 中首次出现 needle 后的内容
@[php_function]
fn v_find_after(haystack string, needle string) ?string {
	idx := haystack.index(needle) or { return none }
	start := idx + needle.len
	if start >= haystack.len {
		return none
	}
	return haystack[start..]
}

// ?int: 全局函数，安全除法，除以零返回 none
@[php_function]
fn v_try_divide(a int, b int) ?int {
	if b == 0 {
		return none
	}
	return a / b
}

// ?void: 全局函数，命中时记录片段，未命中返回 none
@[php_function]
fn v_record_match(path string, haystack string, needle string) ? {
	idx := haystack.index(needle) or { return none }
	os.write_file(path, haystack[idx..]) or { return none }
}

module emitter

import php2v.ast

// try_builtin_mapping 将常用 PHP 内置函数映射为 V 原生调用，消除运行时字符串 dispatch。
// 返回空字符串表示无匹配，需走 rt.call_function 通用路径。
pub fn (t &Transpiler) try_builtin_mapping(name string, args []string) string {
	if args.len == 0 {
		return ''
	}
	a0 := args[0]
	match name {
		// 字符串函数
		'strlen' {
			return 'rt.new_int(${a0}.to_string().len)'
		}
		'strtoupper' {
			return 'rt.new_string(${a0}.to_string().to_upper())'
		}
		'strtolower' {
			return 'rt.new_string(${a0}.to_string().to_lower())'
		}
		'trim' {
			return 'rt.new_string(${a0}.to_string().trim_space())'
		}
		'ltrim' {
			return 'rt.new_string(${a0}.to_string().trim_left(\' \\t\\n\\r\'))'
		}
		'rtrim', 'chop' {
			return 'rt.new_string(${a0}.to_string().trim_right(\' \\t\\n\\r\'))'
		}
		// 数组函数
		'count', 'sizeof' {
			return 'rt.new_int(${a0}.array_count())'
		}
		'array_push' {
			if args.len >= 2 {
				return '${a0}.array_push(${args[1]})'
			}
			return ''
		}
		'array_key_exists' {
			if args.len >= 2 {
				return 'rt.new_bool(${args[1]}.array_isset(${a0}))'
			}
			return ''
		}
		// 类型判断函数
		'is_null' {
			return 'rt.new_bool(${a0}.is_null())'
		}
		'is_array' {
			return 'rt.new_bool(${a0}.is_array())'
		}
		'is_int', 'is_integer', 'is_long' {
			return 'rt.new_bool(${a0}.is_long())'
		}
		'is_float', 'is_double' {
			return 'rt.new_bool(${a0}.is_double())'
		}
		'is_string' {
			return 'rt.new_bool(${a0}.is_string())'
		}
		'is_bool' {
			return 'rt.new_bool(${a0}.is_bool())'
		}
		'is_object' {
			return 'rt.new_bool(${a0}.is_object())'
		}
		'is_numeric' {
			return 'rt.new_bool(${a0}.is_long() || ${a0}.is_double())'
		}
		'isset' {
			return 'rt.new_bool(!${a0}.is_null())'
		}
		// 类型转换函数
		'intval' {
			return 'rt.new_int(${a0}.to_i64())'
		}
		'floatval', 'doubleval' {
			return 'rt.new_float(${a0}.to_f64())'
		}
		'strval' {
			return 'rt.new_string(${a0}.to_string())'
		}
		'boolval' {
			return 'rt.new_bool(rt.is_true(${a0}))'
		}
		// 输出/调试函数
		'var_dump' {
			return 'println(${a0}.to_string())'
		}
		'print_r' {
			return 'println(${a0}.to_string())'
		}
		else {
			return ''
		}
	}
}

// can_use_v_interpolation 检查 encapsed string 的所有 parts 是否可以安全使用 V 字符串插值
pub fn can_use_v_interpolation(parts []ast.AstNode) bool {
	for part in parts {
		match part.node_type {
			ast.node_scalar_encapsed_string_part, ast.node_scalar_interpolated_string_part {
				// 若字面文本含 $ 则可能与 V 插值冲突，回退 concat 链
				if part.value.contains('\$') {
					return false
				}
			}
			ast.node_expr_variable {
				// 简单变量引用可以安全插值
			}
			else {
				// 复杂表达式（数组下标、方法调用等）回退
				return false
			}
		}
	}
	return true
}

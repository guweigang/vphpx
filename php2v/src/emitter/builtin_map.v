module emitter

import ast

// get_builtin_return_tag 返回内置函数的已知推断返回类型
pub fn get_builtin_return_tag(name string) ?TypeTag {
	match name {
		'strlen', 'count', 'sizeof', 'intval' {
			return .t_int
		}
		'strtoupper', 'strtolower', 'trim', 'ltrim', 'rtrim', 'chop', 'strval', 'md5', 'sha1', 'json_encode' {
			return .t_string
		}
		'floatval', 'doubleval' {
			return .t_float
		}
		'is_null', 'is_array', 'is_int', 'is_integer', 'is_long', 'is_float', 'is_double',
		'is_string', 'is_bool', 'is_object', 'is_numeric', 'isset', 'boolval', 'array_key_exists' {
			return .t_bool
		}
		else {
			return none
		}
	}
}

// try_builtin_mapping_native 返回内置函数的原生 V 语言表达式。
pub fn (mut t Transpiler) try_builtin_mapping_native(name string, args []string, arg_nodes []ast.AstNode) string {
	if args.len == 0 {
		return ''
	}
	a0 := args[0]
	a0s := t.compile_builtin_arg(arg_nodes[0])
	match name {
		'strlen' {
			return '${a0s}.len'
		}
		'strtoupper' {
			return '${a0s}.to_upper()'
		}
		'strtolower' {
			return '${a0s}.to_lower()'
		}
		'trim' {
			return '${a0s}.trim_space()'
		}
		'count', 'sizeof' {
			a0_type := t.get_expr_type(arg_nodes[0])
			if a0_type.is_native_list || a0_type.is_native_map {
				return '${t.visit_expr_native(arg_nodes[0])}.len'
			}
			return '${a0}.array_count()'
		}
		'ltrim' {
			return '${a0s}.trim_left(\' \\t\\n\\r\')'
		}
		'rtrim', 'chop' {
			return '${a0s}.trim_right(\' \\t\\n\\r\')'
		}
		'array_push' {
			if args.len >= 2 {
				return '${a0}.array_push(${args[1]})'
			}
			return ''
		}
		'array_key_exists' {
			if args.len >= 2 {
				return '${args[1]}.array_isset(${a0})'
			}
			return ''
		}
		'is_null' {
			return '${a0}.is_null()'
		}
		'is_array' {
			return '${a0}.is_array()'
		}
		'is_int', 'is_integer', 'is_long' {
			return '${a0}.is_long()'
		}
		'is_float', 'is_double' {
			return '${a0}.is_double()'
		}
		'is_string' {
			return '${a0}.is_string()'
		}
		'is_bool' {
			return '${a0}.is_bool()'
		}
		'is_object' {
			return '${a0}.is_object()'
		}
		'is_numeric' {
			return '${a0}.is_long() || ${a0}.is_double()'
		}
		'isset' {
			return '!${a0}.is_null()'
		}
		'intval' {
			return '${a0}.to_i64()'
		}
		'floatval', 'doubleval' {
			return '${a0}.to_f64()'
		}
		'strval' {
			return '${a0}.to_string()'
		}
		'boolval' {
			return 'rt.is_true(${a0})'
		}
		'var_dump', 'print_r' {
			return 'println(${a0}.to_string())'
		}
		'md5' {
			t.extra_imports['crypto.md5'] = true
			return 'md5.hexhash(${a0s})'
		}
		'sha1' {
			t.extra_imports['crypto.sha1'] = true
			return 'sha1.hexhash(${a0s})'
		}
		'json_encode' {
			return 'rt.json_encode(${a0})'
		}
		else {
			return ''
		}
	}
}

// try_builtin_mapping 将常用 PHP 内置函数映射为 V 包装调用（返回 PhpVal）。
pub fn (mut t Transpiler) try_builtin_mapping(name string, args []string, arg_nodes []ast.AstNode) string {
	native := t.try_builtin_mapping_native(name, args, arg_nodes)
	if native == '' {
		return ''
	}
	if tag := get_builtin_return_tag(name) {
		match tag {
			.t_int { return 'rt.new_int(${native})' }
			.t_float { return 'rt.new_float(${native})' }
			.t_string { return 'rt.new_string(${native})' }
			.t_bool { return 'rt.new_bool(${native})' }
			else { return native }
		}
	}
	return native
}

// compile_builtin_arg 为接受字符串参数的内置函数智能编译参数表达式。
// 当参数类型已知为 .t_string 时，直接返回原生 V 字符串（避免多余 of 拆箱/装箱）；
// 否则返回 PhpVal 表达式并追加 .to_string() 做运行时转换。
pub fn (mut t Transpiler) compile_builtin_arg(node ast.AstNode) string {
	typ := t.get_expr_type(node)
	if typ.tag == .t_string {
		return t.visit_expr_native(node)
	}
	return '${t.compile_arg_simple(node)}.to_string()'
}

// can_use_v_interpolation 检查 encapsed string 的所有 parts 是否可以 safe 使用 V 字符串插值
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

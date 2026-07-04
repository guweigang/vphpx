module emitter

import ast

// ============================================================
// 公共辅助函数：消除 emit_expr.v / emit_stmt.v / emit_class.v 中的重复代码
// ============================================================

// ---- 字符串转义 ----

// escape_single_quoted 将原始字符串转义为 V 单引号字符串内容
// 替代原先分散在 8 处的重复 .replace 链
pub fn escape_single_quoted(s string) string {
	return s.replace('\\', '\\\\').replace('\'', '\\\'').replace('\n', '\\n').replace('\r', '\\r').replace('\t', '\\t')
}

// escape_double_quoted 将原始字符串转义为 V 双引号字符串内容（额外处理 $）
pub fn escape_double_quoted(s string) string {
	return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r').replace('\t', '\\t').replace('\$', '\\$')
}

// ---- 装箱 / 拆箱 ----

// box_expr 将原生 V 表达式包装为 rt.PhpVal
pub fn box_expr(code string, typ VarType) string {
	if typ.is_native_list {
		elem_func := match typ.element_type_tag {
			.t_int { 'create_array_from_list_int' }
			.t_float { 'create_array_from_list_float' }
			.t_string { 'create_array_from_list_string' }
			.t_bool { 'create_array_from_list_bool' }
			else { 'create_array_from_list' }
		}
		if code.starts_with('rt.' + elem_func) { return code }
		return 'rt.' + elem_func + '(${code})'
	}
	if typ.is_native_map {
		elem_func := match typ.element_type_tag {
			.t_int { 'create_array_from_native_map_int' }
			.t_float { 'create_array_from_native_map_float' }
			.t_string { 'create_array_from_native_map_string' }
			.t_bool { 'create_array_from_native_map_bool' }
			else { 'create_array_from_native_map' }
		}
		if code.starts_with('rt.' + elem_func) { return code }
		return 'rt.' + elem_func + '(${code})'
	}
	if typ.class_name.len > 0 || typ.tag == .t_object {
		if code.starts_with('rt.new_object') || code.starts_with('rt.new_null') {
			return code
		}
		cls := if typ.class_name.len > 0 { typ.class_name } else { 'WP_Error' }
		return "rt.new_object('${cls}', []string{}, ${code})"
	}
	match typ.tag {
		.t_int {
			if code.starts_with('rt.new_int(') { return code }
			return 'rt.new_int(${code})'
		}
		.t_float {
			if code.starts_with('rt.new_float(') { return code }
			return 'rt.new_float(${code})'
		}
		.t_string {
			if code.starts_with('rt.new_string(') { return code }
			// 如果代码已经是 PhpVal 表达式，先 .str() 转原生 string 再包装
			if code.starts_with('rt.') || code.starts_with('var_') || code.starts_with('if ') {
				return 'rt.new_string((${code}).str())'
			}
			return 'rt.new_string(${code})'
		}
		.t_bool {
			if code.starts_with('rt.new_bool(') { return code }
			return 'rt.new_bool(${code})'
		}
		else { return code }
	}
}

// unbox_expr 将 rt.PhpVal 表达式转换为原生 V 类型
pub fn unbox_expr(code string, typ VarType) string {
	match typ.tag {
		.t_int { return '(${code}).to_i64()' }
		.t_float { return '(${code}).to_f64()' }
		.t_string { return '(${code}).str()' }
		.t_bool { return '(${code}).to_bool()' }
		.t_object { return 'rt.cast_object_ptr[Class_${typ.class_name}](${code})' }
		else { return code }
	}
}

// ---- 表达式上下文 ----

pub enum ExprCtx {
	boxed  // 需要 PhpVal 包装（默认）
	native // 需要 V 原生类型
}

// ---- 参数传递 ----

// dup_suffix_for_var 返回变量的复制后缀：统一使用 .clone()（PhpVal、原生数组/映射均支持）
// 对象和原生参数不需要复制
pub fn (t Transpiler) dup_suffix_for_var(php_var_name string) string {
	v_var := t.get_v_var_name(php_var_name)
	typ := t.inferred_types[v_var] or { t.inferred_types[php_var_name] or { VarType{ tag: .t_unknown } } }
	if typ.tag == .t_object || typ.class_name.len > 0 {
		return ''
	}
	if t.native_params[php_var_name] || t.native_vars[php_var_name] || php_var_name.ends_with('_mutated') {
		return ''
	}
	return '.clone()'
}

// dup_if_needed 对 PhpVal 变量追加 .dup()，避免别名共享
// 非变量表达式直接返回原代码
pub fn (t Transpiler) dup_if_needed(code string, arg_node ast.AstNode) string {
	if arg_node.node_type == ast.node_expr_variable {
		suffix := t.dup_suffix_for_var(arg_node.name)
		return code + suffix
	}
	return code
}

// CallArgResult 统一参数编译结果
pub struct CallArgResult {
pub:
	code string   // 编译后的参数表达式
	typ  VarType  // 参数的源类型
}

// compile_expr 统一表达式编译入口
// 根据 ExprCtx 决定生成 PhpVal 包装代码还是 V 原生代码
// 当请求 .native 但节点不支持原生输出时，自动降级为 .boxed + 拆箱
pub fn (mut t Transpiler) compile_expr(node ast.AstNode, ctx ExprCtx) string {
	match ctx {
		.boxed {
			code := t.visit_expr(node)
			// concat 和 cast_string 在 visit_expr 中通常产生原生 string，
			// 但嵌套 concat 可能产生 PhpVal (rt.concat(...)) → 需要检测
			node_type := node.node_type
			if node_type == ast.node_bin_concat || node_type == ast.node_expr_cast_string {
				// 如果 code 已经是 PhpVal 表达式（以 rt. 开头），用 .str() 提取原生 string
				if code.starts_with('rt.') {
					return 'rt.new_string((${code}).str())'
				}
				return 'rt.new_string(${code})'
			}
			// unary minus/plus 对 int/float 产生原生 native 表达式（如 -1, -2.0），
			// 但 boxed 上下文需要 PhpVal → 自动装箱
			if node_type == ast.node_expr_unary_minus || node_type == ast.node_expr_unary_plus {
				expr_type := t.get_expr_type(node)
				if expr_type.tag == .t_int || expr_type.tag == .t_float {
					return box_expr(code, expr_type)
				}
			}
			// scalar int/float 字面量（如 1, 2.0）在部分路径下由 visit_expr 返回 native，
			// 需要识别并装箱
			if node_type == ast.node_scalar_int {
				if !code.starts_with('rt.') {
					return 'rt.new_int(${code})'
				}
			}
			if node_type == ast.node_scalar_float {
				if !code.starts_with('rt.') {
					return 'rt.new_float(${code})'
				}
			}
			return code
		}
		.native {
			return t.visit_expr_native(node)
		}
	}
}


// compile_arg 统一编译单个调用参数（4-way 矩阵）
// 根据源类型和目标类型决定装箱/拆箱策略
pub fn (mut t Transpiler) compile_arg(arg_node ast.AstNode, target_type VarType) CallArgResult {
	arg_type := t.get_expr_type(arg_node)
	target_is_native := target_type.is_scalar() || target_type.class_name.len > 0 || target_type.is_native_list || target_type.is_native_map
	arg_is_native := arg_type.is_scalar() || arg_type.class_name.len > 0 || arg_type.is_native_list || arg_type.is_native_map
	
	if target_is_native && arg_is_native {
		// 目标是原生，源也是原生 → 直接传递
		mut prefix := ''
		if target_type.tag == .t_object {
			prefix = 'mut '
		}
		return CallArgResult{ code: prefix + t.compile_expr(arg_node, .native), typ: arg_type }
	} else if target_is_native && !arg_is_native {
		// 目标是原生，源是包装 → 拆箱
		raw := t.compile_expr(arg_node, .boxed)
		mut prefix := ''
		if target_type.tag == .t_object {
			prefix = 'mut '
		}
		return CallArgResult{ code: prefix + unbox_expr(raw, target_type), typ: arg_type }
	} else if !target_is_native && arg_is_native {
		// 目标是包装，源是原生 → 装箱
		native_val := t.compile_expr(arg_node, .native)
		return CallArgResult{ code: box_expr(native_val, arg_type), typ: arg_type }
	} else {
		// 目标是包装，源是包装 → 直接传递，变量需 .dup()
		code := t.compile_expr(arg_node, .boxed)
		return CallArgResult{ code: t.dup_if_needed(code, arg_node), typ: arg_type }
	}
}

// compile_arg_simple 编译 PhpVal 参数（无类型推导，变量需 .dup()）
// 用于 funccall、call_method fallback 等不需要 4-way 矩阵的场景
pub fn (mut t Transpiler) compile_arg_simple(arg_node ast.AstNode) string {
	code := t.compile_expr(arg_node, .boxed)
	// 如果参数是原生数组/映射变量，需要包装为 PhpVal
	if arg_node.node_type == ast.node_expr_variable {
		v_var := t.get_v_var_name(arg_node.name)
		typ := t.inferred_types[v_var] or { t.inferred_types[arg_node.name] or { VarType{ tag: .t_unknown } } }
		if typ.is_native_list {
			return 'rt.create_array_from_list(${code})'
		}
		if typ.is_native_map {
			return 'rt.create_array_from_native_map(${code})'
		}
	}
	// 如果表达式类型是原生标量（int/float/bool）且生成代码不是 PhpVal，需要自动装箱
	// 比如：string.len + 1 → int/native → 需要 rt.new_int(...)
	// 注意：只在代码不以 'rt.' 开头时装箱，避免对已是 PhpVal 的表达式重复装箱
	arg_type := t.get_expr_type(arg_node)
	if arg_type.is_scalar() && !code.starts_with('rt.') {
		return box_expr(code, arg_type)
	}
	return t.dup_if_needed(code, arg_node)
}


// produces_native_string 判断 visit_expr 是否会生成 V 原生 string（而非 PhpVal）
// 用于 rt.concat() 等需要 PhpVal 参数的场景，决定是否需包装 rt.new_string()
pub fn (mut t Transpiler) produces_native_string(node ast.AstNode) bool {
	match node.node_type {
		ast.node_bin_concat {
			return true
		}
		ast.node_expr_cast_string {
			return true
		}
		else {
			return false
		}
	}
}

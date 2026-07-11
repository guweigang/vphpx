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
pub fn (t Transpiler) box_expr(code string, typ VarType) string {
	mut real_typ := typ
	if code.starts_with('var_') {
		php_name := code.all_after('var_')
		mut found := false
		if t.current_func_name != '' {
			lookup_key := '${t.current_func_name}::${php_name}'
			if lookup_key in t.inferred_types {
				real_typ = t.inferred_types[lookup_key] or { typ }
				found = true
			}
		}
		if !found && php_name in t.inferred_types {
			real_typ = t.inferred_types[php_name] or { typ }
		}
	}
	if real_typ.is_native_list {
		elem_func := match real_typ.element_type_tag {
			.t_int { 'create_array_from_list_int' }
			.t_float { 'create_array_from_list_float' }
			.t_string { 'create_array_from_list_string' }
			.t_bool { 'create_array_from_list_bool' }
			else { 'create_array_from_list' }
		}
		if code.starts_with('rt.' + elem_func) { return code }
		return 'rt.' + elem_func + '(${code})'
	}
	if real_typ.is_native_map {
		elem_func := match real_typ.element_type_tag {
			.t_int { 'create_array_from_native_map_int' }
			.t_float { 'create_array_from_native_map_float' }
			.t_string { 'create_array_from_native_map_string' }
			.t_bool { 'create_array_from_native_map_bool' }
			else { 'create_array_from_native_map' }
		}
		if code.starts_with('rt.' + elem_func) { return code }
		return 'rt.' + elem_func + '(${code})'
	}
	if real_typ.class_name.len > 0 || real_typ.tag == .t_object {
		if code.starts_with('rt.new_object') || code.starts_with('rt.new_null') {
			return code
		}
		cls := if real_typ.class_name.len > 0 { real_typ.class_name } else { 'WP_Error' }
		return "rt.new_object('${cls}', []string{}, ${code})"
	}
	match real_typ.tag {
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
pub fn (t Transpiler) unbox_expr(code string, typ VarType) string {
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
					return t.box_expr(code, expr_type)
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
			if node.node_type == ast.node_expr_variable {
				var_name := t.var_aliases[node.name] or { node.name }
				v_var := t.get_v_var_name(node.name)
				arg_type := t.inferred_types[v_var] or { t.inferred_types[var_name] or { VarType{ tag: .t_unknown } } }
				
				mut is_native := false
				if t.current_func_name == '' {
					is_native = arg_type.is_scalar()
				} else {
					is_native = t.native_params[node.name] || t.native_vars[v_var]
				}
				
				if arg_type.is_scalar() && !is_native {
					return t.unbox_expr(t.visit_expr(node), arg_type)
				}
			}
			return t.visit_expr_native(node)
		}
	}
}


// compile_arg 统一编译单个调用参数（4-way 矩阵）
// 根据源类型和目标类型决定装箱/拆箱策略
pub fn (mut t Transpiler) compile_arg(arg_node ast.AstNode, target_type VarType) CallArgResult {
	old_expect := t.expected_type
	t.expected_type = target_type
	
	arg_type := t.get_expr_type(arg_node)
	target_is_native := target_type.is_scalar() || target_type.class_name.len > 0 || target_type.is_native_list || target_type.is_native_map
	arg_is_native := arg_type.is_scalar() || arg_type.class_name.len > 0 || arg_type.is_native_list || arg_type.is_native_map
	
	mut res := CallArgResult{ typ: arg_type }
	if target_is_native && arg_is_native {
		// 目标是原生，源也是原生 → 直接传递
		mut prefix := ''
		if target_type.tag == .t_object {
			prefix = 'mut '
		}
		res = CallArgResult{ code: prefix + t.compile_expr(arg_node, .native), typ: arg_type }
	} else if target_is_native && !arg_is_native {
		// 目标是原生，源是包装 → 拆箱
		raw := t.compile_expr(arg_node, .boxed)
		mut prefix := ''
		if target_type.tag == .t_object {
			prefix = 'mut '
		}
		res = CallArgResult{ code: prefix + t.unbox_expr(raw, target_type), typ: arg_type }
	} else if !target_is_native && arg_is_native {
		// 目标是包装，源是原生 → 装箱
		native_val := t.compile_expr(arg_node, .native)
		res = CallArgResult{ code: t.box_expr(native_val, arg_type), typ: arg_type }
	} else {
		// 目标是包装，源是包装 → 直接传递，变量需 .dup()
		code := t.compile_expr(arg_node, .boxed)
		res = CallArgResult{ code: t.dup_if_needed(code, arg_node), typ: arg_type }
	}
	
	t.expected_type = old_expect
	return res
}

// compile_arg_simple 编译 PhpVal 参数（无类型推导，变量需 .dup()）
// 用于 funccall、call_method fallback 等不需要 4-way 矩阵的场景
pub fn (mut t Transpiler) compile_arg_simple(arg_node ast.AstNode) string {
	old_expect := t.expected_type
	t.expected_type = VarType{ tag: .t_unknown }
	
	code := t.compile_expr(arg_node, .boxed)
	// 如果参数是原生数组/映射变量，需要包装为 PhpVal
	if arg_node.node_type == ast.node_expr_variable {
		v_var := t.get_v_var_name(arg_node.name)
		lookup_key := if t.current_func_name != '' { '${t.current_func_name}::${arg_node.name}' } else { arg_node.name }
		typ := t.inferred_types[v_var] or { t.inferred_types[lookup_key] or { t.inferred_types[arg_node.name] or { VarType{ tag: .t_unknown } } } }
		if typ.is_native_list {
			t.expected_type = old_expect
			match typ.element_type_tag {
				.t_string { return 'rt.create_array_from_list_string(${code})' }
				.t_int { return 'rt.create_array_from_list_int(${code})' }
				.t_float { return 'rt.create_array_from_list_float(${code})' }
				.t_bool { return 'rt.create_array_from_list_bool(${code})' }
				else { return 'rt.create_array_from_list(${code})' }
			}
		}
		if typ.is_native_map {
			t.expected_type = old_expect
			return 'rt.create_array_from_native_map(${code})'
		}
	}
	// 如果表达式类型是原生标量（int/float/bool）或对象/类，且生成代码不是 PhpVal，需要自动装箱
	// 注意：只在代码不以 'rt.' 开头时装箱，避免对已是 PhpVal 的表达式重复装箱
	arg_type := t.get_expr_type(arg_node)
	mut res := code
	if (arg_type.is_scalar() || arg_type.class_name.len > 0 || arg_type.tag == .t_object) && !code.starts_with('rt.') {
		res = t.box_expr(code, arg_type)
	} else {
		res = t.dup_if_needed(code, arg_node)
	}
	
	t.expected_type = old_expect
	return res
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

pub fn (mut t Transpiler) emit_custom_funccall(node ast.AstNode, func_name string, ret_type VarType, is_native bool) string {
	mut arg_strs := []string{}
	mut info := ?MethodInfo(none)
	if func_name in t.custom_function_infos {
		info = t.custom_function_infos[func_name]
	}
	
	if func_info := info {
		if func_info.is_variadic {
			var_idx := func_info.param_count - 1
			for i := 0; i < var_idx; i++ {
				if i < node.args.len {
					arg := node.args[i]
					arg_val := arg.expr or { panic('Arg missing expr') }
					arg_typ := t.get_expr_type(arg_val)
					param_name := func_info.param_names[i]
					param_type := t.get_func_param_type(func_name, param_name)
					
					if param_type.is_scalar() && arg_typ.is_scalar() {
						arg_strs << t.visit_expr_native(arg_val)
					} else {
						arg_strs << t.compile_arg_simple(arg_val)
					}
				} else {
					param_name := func_info.param_names[i]
					param_type := t.get_func_param_type(func_name, param_name)
					if param_type.is_scalar() {
						match param_type.tag {
							.t_int { arg_strs << '0' }
							.t_float { arg_strs << '0.0' }
							.t_bool { arg_strs << 'false' }
							else { arg_strs << "''" }
						}
					} else {
						arg_strs << 'rt.new_null()'
					}
				}
			}
			for i := var_idx; i < node.args.len; i++ {
				arg := node.args[i]
				arg_val := arg.expr or { panic('Arg missing expr') }
				arg_strs << t.compile_arg_simple(arg_val)
			}
		} else {
			for i := 0; i < func_info.param_count; i++ {
				if i < node.args.len {
					arg := node.args[i]
					arg_val := arg.expr or { panic('Arg missing expr') }
					arg_typ := t.get_expr_type(arg_val)
					param_name := func_info.param_names[i]
					param_type := t.get_func_param_type(func_name, param_name)
					if param_type.is_scalar() && arg_typ.is_scalar() {
						arg_strs << t.visit_expr_native(arg_val)
					} else {
						arg_strs << t.compile_arg_simple(arg_val)
					}
				} else {
					param_name := func_info.param_names[i]
					param_type := t.get_func_param_type(func_name, param_name)
					if param_type.is_scalar() {
						match param_type.tag {
							.t_int { arg_strs << '0' }
							.t_float { arg_strs << '0.0' }
							.t_bool { arg_strs << 'false' }
							else { arg_strs << "''" }
						}
					} else {
						arg_strs << 'rt.new_null()'
					}
				}
			}
		}
	} else {
		for arg in node.args {
			arg_val := arg.expr or { panic('Arg missing expr') }
			arg_strs << t.compile_arg_simple(arg_val)
		}
	}
	
	call_expr := '${func_v_name(func_name)}(${arg_strs.join(", ")})'
	if !is_native && ret_type.is_scalar() {
		return t.box_expr(call_expr, ret_type)
	}
	return call_expr
}

// is_native_array_or_map 判定一个节点在 V 语言生成的实际代码中是否是原生数组/映射。
// 即使推导类型是 native_list/map，但如果是以 rt.PhpVal 传入的函数参数，其在 V 代码里依然不是原生数组。
pub fn (t Transpiler) is_native_array_or_map(node ast.AstNode) bool {
	if node.node_type != ast.node_expr_variable {
		return false
	}
	name := node.name
	if t.current_func_name != '' {
		if t.current_func_name in t.func_param_types {
			if params := t.func_param_types[t.current_func_name] {
				if name in params {
					return false
				}
			}
		}
	}
	v_var := t.get_v_var_name(name)
	lookup_key := if t.current_func_name != '' { '${t.current_func_name}::${name}' } else { name }
	typ := t.inferred_types[v_var] or { t.inferred_types[lookup_key] or { t.inferred_types[name] or { VarType{ tag: .t_unknown } } } }
	return typ.is_native_list || typ.is_native_map
}


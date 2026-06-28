module emitter

import strings
import ast

fn (mut t Transpiler) get_expr_type(node ast.AstNode) VarType {
	match node.node_type {
		ast.node_scalar_int { return VarType{ tag: .t_int } }
		ast.node_scalar_float { return VarType{ tag: .t_float } }
		ast.node_scalar_string { return VarType{ tag: .t_string } }
		ast.node_scalar_encapsed, ast.node_scalar_interpolated_string { return VarType{ tag: .t_string } }
		ast.node_expr_variable {
			if t.current_class != '' && t.current_func_name != '' {
				if m := t.find_method(t.current_class, t.current_func_name) {
					for pname in m.param_names {
						if pname == node.name {
							return t.get_method_param_type(t.current_class, t.current_func_name, pname)
						}
					}
				}
			}
			// 先检查函数参数类型
			if t.current_func_name != '' {
				if params := t.func_param_types[t.current_func_name] {
					if pt := params[node.name] {
						return pt
					}
				}
				// 再检查函数局部变量类型
				if vars := t.func_var_types[t.current_func_name] {
					if vt := vars[node.name] {
						return vt
					}
				}
			}
			return t.inferred_types[node.name] or { VarType{ tag: .t_unknown } }
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true', 'false' { return VarType{ tag: .t_bool } }
				'null' { return VarType{ tag: .t_null } }
				else {
					if gc := t.global_constants[node.name] {
						return gc.typ
					}
					return VarType{ tag: .t_unknown }
				}
			}
		}
		ast.node_bin_bitwise_and, ast.node_bin_bitwise_or, ast.node_bin_bitwise_xor,
		ast.node_bin_shift_left, ast.node_bin_shift_right, ast.node_expr_bitwise_not {
			return VarType{ tag: .t_int }
		}
		ast.node_bin_plus, ast.node_bin_minus, ast.node_bin_mul, ast.node_bin_div, ast.node_bin_mod {
			left := node.left or { return VarType{ tag: .t_unknown } }
			right := node.right or { return VarType{ tag: .t_unknown } }
			l_t := t.get_expr_type(*left)
			r_t := t.get_expr_type(*right)
			if l_t.tag == .t_int && r_t.tag == .t_int { return VarType{ tag: .t_int } }
			if l_t.tag == .t_float || r_t.tag == .t_float { return VarType{ tag: .t_float } }
			return VarType{ tag: .t_unknown }
		}
		ast.node_bin_concat {
			return VarType{ tag: .t_string }
		}
		ast.node_expr_array {
			mut is_list := true
			mut is_map := true
			mut elem_tags := []TypeTag{}
			for item in node.items {
				if key := item.key {
					if key.node_type == ast.node_scalar_string {
						is_list = false
					} else if key.node_type == ast.node_scalar_int {
						is_map = false
					} else {
						is_list = false
						is_map = false
					}
				} else {
					is_map = false
				}
				if val := item.expr {
					elem_tags << t.get_expr_type(*val).tag
				}
			}
			mut elem_tag := TypeTag.t_unknown
			if elem_tags.len > 0 {
				first := elem_tags[0]
				mut all_same := true
				for tag in elem_tags {
					if tag != first {
						all_same = false
						break
					}
				}
				if all_same && first in [.t_int, .t_float, .t_string, .t_bool] {
					elem_tag = first
				}
			}
			mut force_non_native := false
			if !t.expected_type.is_native_list && !t.expected_type.is_native_map {
				force_non_native = true
			}
			if is_list && !is_map && !force_non_native {
				return VarType{ tag: .t_array, is_native_list: true, element_type_tag: elem_tag }
			}
			if is_map && !is_list && !force_non_native {
				return VarType{ tag: .t_array, is_native_map: true, element_type_tag: elem_tag }
			}
			return VarType{ tag: .t_array }
		}
		ast.node_expr_funccall {
			// 优先使用已知内置函数的返回类型
			if tag := get_builtin_return_tag(node.name) {
				return VarType{ tag: tag }
			}
			// 检查用户自定义函数的返回值类型
			if ret_type := t.func_return_types[node.name] {
				return ret_type
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_expr_ternary {
			if if_node := node.@if {
				else_node := node.@else or { return VarType{ tag: .t_unknown } }
				if_type := t.get_expr_type(*if_node)
				else_type := t.get_expr_type(*else_node)
				if if_type.tag == else_type.tag {
					return if_type
				}
			} else {
				else_node := node.@else or { return VarType{ tag: .t_unknown } }
				cond := node.cond or { return VarType{ tag: .t_unknown } }
				cond_type := t.get_expr_type(*cond)
				else_type := t.get_expr_type(*else_node)
				if cond_type.tag == else_type.tag {
					return cond_type
				}
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_bin_coalesce {
			left := node.left or { return VarType{ tag: .t_unknown } }
			right := node.right or { return VarType{ tag: .t_unknown } }
			l_type := t.get_expr_type(*left)
			r_type := t.get_expr_type(*right)
			if l_type.tag == r_type.tag {
				return l_type
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_expr_method_call {
			obj_var_node := node.var or { return VarType{ tag: .t_unknown } }
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					return t.get_method_return_type(obj_type.class_name, node.name)
				}
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_expr_property_fetch {
			obj_var_node := node.var or { return VarType{ tag: .t_unknown } }
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					return t.get_class_prop_type(obj_type.class_name, node.name)
				}
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_bin_greater, ast.node_bin_smaller, ast.node_bin_greater_equal,
		ast.node_bin_smaller_equal, ast.node_bin_equal, ast.node_bin_identical {
			left := node.left or { return VarType{ tag: .t_unknown } }
			right := node.right or { return VarType{ tag: .t_unknown } }
			l_type := t.get_expr_type(*left)
			r_type := t.get_expr_type(*right)
			if l_type.tag in [.t_int, .t_float] && r_type.tag in [.t_int, .t_float] {
				return VarType{ tag: .t_bool }
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_bin_bool_and, ast.node_bin_logical_and, ast.node_bin_bool_or,
		ast.node_bin_logical_or, ast.node_expr_boolean_not {
			return VarType{ tag: .t_bool }
		}
		ast.node_scalar_magic_const_dir, ast.node_scalar_magic_const_file,
		ast.node_scalar_magic_const_function, ast.node_scalar_magic_const_method,
		ast.node_scalar_magic_const_class, ast.node_scalar_magic_const_namespace {
			return VarType{ tag: .t_string }
		}
		ast.node_scalar_magic_const_line {
			return VarType{ tag: .t_int }
		}
		ast.node_expr_array_dim_fetch {
			var_node := node.var or { return VarType{ tag: .t_unknown } }
			arr_type := t.get_expr_type(*var_node)
			if arr_type.is_native_list || arr_type.is_native_map {
				return VarType{ tag: arr_type.element_type_tag }
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_expr_class_const_fetch {
			mut cls := node.class_name
			if cls == 'self' {
				cls = t.current_class
			} else if cls == 'parent' {
				mut parent_cls := ''
				for c in t.classes {
					if c.name == t.current_class {
						parent_cls = c.extends
						break
					}
				}
				cls = parent_cls
			}
			resolved_cls := t.resolve_class_name(cls)
			for c_info in t.classes {
				if c_info.name.to_lower() == resolved_cls.to_lower() {
					if const_type := c_info.const_types[node.name] {
						return const_type
					}
				}
			}
			return VarType{ tag: .t_unknown }
		}
		ast.node_expr_cast_array {
			return VarType{ tag: .t_unknown }
		}
		else { return VarType{ tag: .t_unknown } }
	}
}

fn (mut t Transpiler) visit_expr_native(node ast.AstNode) string {
	match node.node_type {
		ast.node_scalar_int {
			t.last_expr_type = VarType{ tag: .t_int }
			return node.value
		}
		ast.node_scalar_float {
			t.last_expr_type = VarType{ tag: .t_float }
			return node.value
		}
		ast.node_scalar_string {
			t.last_expr_type = VarType{ tag: .t_string }
			escaped := escape_single_quoted(node.value)
			return "'${escaped}'"
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true' { t.last_expr_type = VarType{ tag: .t_bool }; return 'true' }
				'false' { t.last_expr_type = VarType{ tag: .t_bool }; return 'false' }
				'null' { t.last_expr_type = VarType{ tag: .t_null }; return 'none' }
				else {
					if gc := t.global_constants[node.name] {
						t.last_expr_type = gc.typ
						return gc.name
					}
					return t.visit_expr(node)
				}
			}
		}
		ast.node_expr_variable {
			if node.name == 'this' {
				t.last_expr_type = VarType{ tag: .t_object, class_name: t.current_class }
				return 'this'
			}
			var_name := t.var_aliases[node.name] or { node.name }
			// 闭包体内引用被捕获的原生变量：需要装箱为 PhpVal
			if t.is_in_closure_body {
				if cap_type := t.closure_captured_natives[var_name] {
					boxed := box_expr('var_${var_name}', cap_type)
					t.last_expr_type = VarType{ tag: .t_unknown }
					return boxed
				}
			}
			typ := t.inferred_types[var_name] or { VarType{ tag: .t_unknown } }
			t.last_expr_type = typ
			return t.get_v_var_name(node.name)
		}
		ast.node_bin_plus {
			left := node.left or { panic('plus missing left') }
			right := node.right or { panic('plus missing right') }
			l_code := t.visit_expr_native(*left)
			r_code := t.visit_expr_native(*right)
			t.last_expr_type = VarType{ tag: .t_int }
			return '${l_code} + ${r_code}'
		}
		ast.node_bin_minus {
			left := node.left or { panic('minus missing left') }
			right := node.right or { panic('minus missing right') }
			l_code := t.visit_expr_native(*left)
			r_code := t.visit_expr_native(*right)
			t.last_expr_type = VarType{ tag: .t_int }
			return '${l_code} - ${r_code}'
		}
		ast.node_bin_mul {
			left := node.left or { panic('mul missing left') }
			right := node.right or { panic('mul missing right') }
			l_code := t.visit_expr_native(*left)
			r_code := t.visit_expr_native(*right)
			t.last_expr_type = VarType{ tag: .t_int }
			return '${l_code} * ${r_code}'
		}
		ast.node_bin_div {
			left := node.left or { panic('div missing left') }
			right := node.right or { panic('div missing right') }
			l_code := t.visit_expr_native(*left)
			r_code := t.visit_expr_native(*right)
			t.last_expr_type = VarType{ tag: .t_int }
			return '${l_code} / ${r_code}'
		}
		ast.node_bin_mod {
			left := node.left or { panic('mod missing left') }
			right := node.right or { panic('mod missing right') }
			l_code := t.visit_expr_native(*left)
			r_code := t.visit_expr_native(*right)
			t.last_expr_type = VarType{ tag: .t_int }
			return '${l_code} % ${r_code}'
		}
		ast.node_bin_bool_and, ast.node_bin_logical_and {
			left := node.left or { panic('and missing left') }
			right := node.right or { panic('and missing right') }
			l_cond := t.get_native_bool_condition(*left)
			r_cond := t.get_native_bool_condition(*right)
			t.last_expr_type = VarType{ tag: .t_bool }
			return '${l_cond} && ${r_cond}'
		}
		ast.node_bin_bool_or, ast.node_bin_logical_or {
			left := node.left or { panic('or missing left') }
			right := node.right or { panic('or missing right') }
			l_cond := t.get_native_bool_condition(*left)
			r_cond := t.get_native_bool_condition(*right)
			t.last_expr_type = VarType{ tag: .t_bool }
			return '${l_cond} || ${r_cond}'
		}
		ast.node_expr_boolean_not {
			expr_node := node.expr or { panic('BooleanNot missing expr') }
			cond := t.get_native_bool_condition(*expr_node)
			t.last_expr_type = VarType{ tag: .t_bool }
			return '!(${cond})'
		}
		ast.node_bin_concat {
			left := node.left or { panic('concat missing left') }
			right := node.right or { panic('concat missing right') }
			l_type := t.get_expr_type(*left)
			r_type := t.get_expr_type(*right)
			l_code := if l_type.is_scalar() {
				t.native_to_str(*left, l_type)
			} else {
				'(${t.visit_expr(*left)}).str()'
			}
			r_code := if r_type.is_scalar() {
				t.native_to_str(*right, r_type)
			} else {
				'(${t.visit_expr(*right)}).str()'
			}
			t.last_expr_type = VarType{ tag: .t_string }
			return '${l_code} + ${r_code}'
		}
		ast.node_scalar_encapsed, ast.node_scalar_interpolated_string {
			// 原生字符串插值：使用 V 双引号插值
			if can_use_v_interpolation(node.parts) {
				t.last_expr_type = VarType{ tag: .t_string }
				return t.emit_v_interpolation(node.parts)
			}
			// 回退
			return t.visit_expr(node)
		}
		ast.node_scalar_encapsed_string_part, ast.node_scalar_interpolated_string_part {
			escaped := escape_single_quoted(node.value)
			t.last_expr_type = VarType{ tag: .t_string }
			return "'${escaped}'"
		}
		ast.node_expr_property_fetch {
			obj_var_node := node.var or { return t.visit_expr(node) }
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					mut has_prop := false
					for cls in t.classes {
						if cls.name.to_lower() == obj_type.class_name.to_lower() {
							if node.name in cls.all_props {
								has_prop = true
								break
							}
						}
					}
					if has_prop {
						prop_type := t.get_class_prop_type(obj_type.class_name, node.name)
						field_name := prop_v_name(node.name)
						t.last_expr_type = prop_type
						obj_var_name := if obj_var_node.name == 'this' { 'this' } else { t.visit_expr(*obj_var_node) }
						return '${obj_var_name}.${field_name}'
					}
				}
			}
			return t.visit_expr(node)
		}
		ast.node_expr_ternary {
			cond := node.cond or { panic('Ternary missing cond') }
			cond_str := t.get_native_bool_condition(*cond)
			ternary_type := t.get_expr_type(node)
			if ternary_type.is_scalar() {
				t.last_expr_type = ternary_type
				if if_node := node.@if {
					else_node := node.@else or { panic('Ternary missing else') }
					return 'if ${cond_str} { ${t.visit_expr_native(*if_node)} } else { ${t.visit_expr_native(*else_node)} }'
				} else {
					else_node := node.@else or { panic('Ternary missing else') }
					return 'if ${cond_str} { ${t.visit_expr_native(*cond)} } else { ${t.visit_expr_native(*else_node)} }'
				}
			} else {
				if if_node := node.@if {
					else_node := node.@else or { panic('Ternary missing else') }
					return 'if ${cond_str} { ${t.visit_expr(*if_node)} } else { ${t.visit_expr(*else_node)} }'
				} else {
					else_node := node.@else or { panic('Ternary missing else') }
					return 'if ${cond_str} { ${t.visit_expr(*cond)} } else { ${t.visit_expr(*else_node)} }'
				}
			}
		}
		ast.node_bin_coalesce {
			left := node.left or { panic('Coalesce missing left') }
			right := node.right or { panic('Coalesce missing right') }
			coalesce_type := t.get_expr_type(node)
			if coalesce_type.is_scalar() {
				t.last_expr_type = coalesce_type
				left_str := t.visit_expr(*left)
				// 对原生标量的 coalescing，依然利用 if !left.is_null()，但分支内进行原生解包
				return 'if !(${left_str}).is_null() { ${t.visit_expr_native(*left)} } else { ${t.visit_expr_native(*right)} }'
			} else {
				left_str := t.visit_expr(*left)
				return 'if !(${left_str}).is_null() { ${left_str} } else { ${t.visit_expr(*right)} }'
			}
		}
		ast.node_expr_method_call {
			// 已知对象类型的方法调用 → 直接生成原生调用
			obj_var_node := node.var or { return t.visit_expr(node) }
			if obj_var_node.node_type == ast.node_expr_variable {
				mut obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_var_node.name == 'this' {
					obj_type = VarType{ tag: .t_object, class_name: t.current_class }
				}
				if obj_type.is_object() {
					obj_var_name := t.visit_expr(*obj_var_node)
					ret_type := t.get_method_return_type(obj_type.class_name, node.name)
					t.last_expr_type = ret_type
					return t.compile_method_call_known(node, obj_type, *obj_var_node, obj_var_name)
				}
			}
			return t.visit_expr(node)
		}
		ast.node_expr_funccall {
			func_name := node.name
			// 如果是支持原生映射的内置函数，直接输出原生表达式
			if tag := get_builtin_return_tag(func_name) {
				if tag in [.t_int, .t_float, .t_string, .t_bool] {
					mut simple_args := []string{}
					for arg in node.args {
						arg_val := arg.expr or { panic('Arg missing expr') }
						simple_args << t.compile_arg_simple(arg_val)
					}
					mut arg_nodes := []ast.AstNode{}
					for arg in node.args {
						arg_val := arg.expr or { panic('Arg missing expr') }
						arg_nodes << *arg_val
					}
					builtin_native := t.try_builtin_mapping_native(func_name, simple_args, arg_nodes)
					if builtin_native != '' {
						t.last_expr_type = VarType{ tag: tag }
						return builtin_native
					}
				}
			}
			// 用户自定义函数有原生返回值时，直接返回原生调用
			if ret_type := t.func_return_types[func_name] {
				if ret_type.is_scalar() {
					mut arg_strs := []string{}
					for arg in node.args {
						arg_val := arg.expr or { panic('Arg missing expr') }
						arg_typ := t.get_expr_type(arg_val)
						if arg_typ.is_scalar() {
							arg_strs << t.visit_expr_native(arg_val)
						} else {
							arg_strs << t.compile_arg_simple(arg_val)
						}
					}
					t.last_expr_type = ret_type
					return '${func_v_name(func_name)}(${arg_strs.join(", ")})'
				}
			}
			return t.visit_expr(node)
		}
		ast.node_scalar_magic_const_dir {
			t.last_expr_type = VarType{ tag: .t_string }
			return '@DIR'
		}
		ast.node_scalar_magic_const_file {
			t.last_expr_type = VarType{ tag: .t_string }
			return '@FILE'
		}
		ast.node_scalar_magic_const_line {
			t.last_expr_type = VarType{ tag: .t_int }
			return '@LINE.int()'
		}
		ast.node_scalar_magic_const_function {
			t.last_expr_type = VarType{ tag: .t_string }
			return '@FN'
		}
		ast.node_scalar_magic_const_method {
			t.last_expr_type = VarType{ tag: .t_string }
			return '@METHOD'
		}
		ast.node_scalar_magic_const_class {
			t.last_expr_type = VarType{ tag: .t_string }
			return '@STRUCT'
		}
		ast.node_scalar_magic_const_namespace {
			t.last_expr_type = VarType{ tag: .t_string }
			ns := t.current_namespace.replace('\\', '\\\\')
			return "'${ns}'"
		}
		ast.node_expr_empty {
			expr_node := node.expr or { panic('Empty missing expr') }
			expr_type := t.get_expr_type(*expr_node)
			t.last_expr_type = VarType{ tag: .t_bool }
			if expr_type.is_scalar() {
				code := t.visit_expr_native(*expr_node)
				match expr_type.tag {
					.t_string { return "${code} == ''" }
					.t_int { return "${code} == 0" }
					.t_float { return "${code} == 0.0" }
					.t_bool { return "!(${code})" }
					.t_null { return 'true' }
					else {}
				}
			}
			expr_str := t.visit_expr(*expr_node)
			return '!rt.is_true(${expr_str})'
		}
		ast.node_expr_array_dim_fetch {
			var_node := node.var or { panic('ArrayDimFetch missing var') }
			var_type := t.get_expr_type(*var_node)
			var_str := t.visit_expr(*var_node)
			is_native_arr := var_type.is_native_list || var_type.is_native_map
			if is_native_arr {
				if dim_node := node.dim {
					dim_str := t.visit_expr_native(*dim_node)
					t.last_expr_type = VarType{ tag: var_type.element_type_tag }
					return '${var_str}[${dim_str}]'
				} else {
					panic('ArrayDimFetch missing dim in read context')
				}
			}
			return t.visit_expr(node)
		}
		else {
			return t.visit_expr(node)
		}
	}
}

// native_to_str 将原生类型表达式转为 V 字符串：string 直接用，int/float/bool 加 .str()
fn (mut t Transpiler) native_to_str(node ast.AstNode, typ VarType) string {
	code := t.visit_expr_native(node)
	if typ.tag == .t_string {
		return code
	}
	return '${code}.str()'
}

// emit_binop 统一的二元运算辅助：类型可知时生成原生 V 代码，否则回退运行时调用
fn (mut t Transpiler) emit_binop(node ast.AstNode, native_op string, rt_fn string) string {
	left := node.left or { panic('${rt_fn} missing left') }
	right := node.right or { panic('${rt_fn} missing right') }
	l_type := t.get_expr_type(*left)
	r_type := t.get_expr_type(*right)
	if l_type.tag == .t_int && r_type.tag == .t_int {
		t.last_expr_type = VarType{ tag: .t_int }
		l_code := t.visit_expr_native(*left)
		r_code := t.visit_expr_native(*right)
		return '${l_code} ${native_op} ${r_code}'
	}
	if l_type.tag == .t_float || r_type.tag == .t_float {
		t.last_expr_type = VarType{ tag: .t_float }
		l_code := t.visit_expr_native(*left)
		r_code := t.visit_expr_native(*right)
		return '${l_code} ${native_op} ${r_code}'
	}
	t.last_expr_type = VarType{ tag: .t_unknown }
	return '${rt_fn}(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
}

// emit_comparison 比较运算优化：操作数类型可知时生成原生 V 比较，否则回退 rt 函数
fn (mut t Transpiler) emit_comparison(node ast.AstNode, native_op string, rt_fn string) string {
	left := node.left or { panic('${rt_fn} missing left') }
	right := node.right or { panic('${rt_fn} missing right') }
	l_type := t.get_expr_type(*left)
	r_type := t.get_expr_type(*right)
	if l_type.tag in [.t_int, .t_float] && r_type.tag in [.t_int, .t_float] {
		t.last_expr_type = VarType{ tag: .t_bool }
		l_code := t.visit_expr_native(*left)
		r_code := t.visit_expr_native(*right)
		return 'rt.new_bool(${l_code} ${native_op} ${r_code})'
	}
	t.last_expr_type = VarType{ tag: .t_unknown }
	return '${rt_fn}(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
}

// emit_bitwise 位运算优化：操作数均为 int 时生成原生 V 位运算符，否则回退 rt 函数
fn (mut t Transpiler) emit_bitwise(node ast.AstNode, native_op string, rt_fn string) string {
	left := node.left or { panic('${rt_fn} missing left') }
	right := node.right or { panic('${rt_fn} missing right') }
	l_type := t.get_expr_type(*left)
	r_type := t.get_expr_type(*right)
	if l_type.tag == .t_int && r_type.tag == .t_int {
		t.last_expr_type = VarType{ tag: .t_int }
		l_code := t.visit_expr_native(*left)
		r_code := t.visit_expr_native(*right)
		return '${l_code} ${native_op} ${r_code}'
	}
	t.last_expr_type = VarType{ tag: .t_unknown }
	return '${rt_fn}(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
}

// emit_native_condition 对条件表达式尝试生成 V 原生布尔条件
// 对于已知操作数均为 int/float 的比较运算，直接生成 V 原生比较 (如 var_i < 3)
// 回退路径：返回空字符串，由调用方使用 rt.is_true()
fn (mut t Transpiler) emit_native_condition(node ast.AstNode) string {
	match node.node_type {
		ast.node_bin_greater, ast.node_bin_smaller, ast.node_bin_greater_equal,
		ast.node_bin_smaller_equal, ast.node_bin_equal, ast.node_bin_identical {
			left := node.left or { return '' }
			right := node.right or { return '' }
			l_type := t.get_expr_type(*left)
			r_type := t.get_expr_type(*right)
			if l_type.tag in [.t_int, .t_float] && r_type.tag in [.t_int, .t_float] {
				op := t.binop_native_symbol(node.node_type)
				l_code := t.visit_expr_native(*left)
				r_code := t.visit_expr_native(*right)
				return '${l_code} ${op} ${r_code}'
			}
			return ''
		}
		ast.node_bin_bool_and, ast.node_bin_logical_and {
			l_node := node.left or { return '' }
			r_node := node.right or { return '' }
			l := t.emit_native_condition(*l_node)
			r := t.emit_native_condition(*r_node)
			if l != '' && r != '' { return '${l} && ${r}' }
			return ''
		}
		ast.node_bin_bool_or, ast.node_bin_logical_or {
			l_node := node.left or { return '' }
			r_node := node.right or { return '' }
			l := t.emit_native_condition(*l_node)
			r := t.emit_native_condition(*r_node)
			if l != '' && r != '' { return '${l} || ${r}' }
			return ''
		}
		ast.node_expr_boolean_not {
			expr_node := node.expr or { return '' }
			// Try native condition first (handles comparisons, boolean ops, etc.)
			inner := t.emit_native_condition(*expr_node)
			if inner != '' { return '!(${inner})' }
			// Check if inner is a function call returning native bool
			if expr_node.node_type == ast.node_expr_funccall {
				if ret_type := t.func_return_types[expr_node.name] {
					if ret_type.tag == .t_bool {
						return '!(${t.visit_expr_native(*expr_node)})'
					}
				}
			}
			// Check if inner is a method call returning native bool
			if expr_node.node_type == ast.node_expr_method_call {
				obj_var_node := expr_node.var or { return '' }
				if obj_var_node.node_type == ast.node_expr_variable {
					mut obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
					if obj_var_node.name == 'this' {
						obj_type = VarType{ tag: .t_object, class_name: t.current_class }
					}
					if obj_type.is_object() {
						ret_type := t.get_method_return_type(obj_type.class_name, expr_node.name)
						if ret_type.tag == .t_bool {
							return '!(${t.visit_expr_native(*expr_node)})'
						}
					}
				}
			}
			return ''
		}
		ast.node_expr_isset {
			mut checks := []string{}
			for v in node.vars {
				if v.node_type == ast.node_expr_array_dim_fetch {
					arr_node := v.var or { return '' }
					dim_node := v.dim or { return '' }
					arr_str := t.visit_expr(*arr_node)
					dim_str := t.visit_expr(*dim_node)
					checks << '${arr_str}.array_isset(${dim_str})'
				} else {
					var_str := t.visit_expr(v)
					checks << '!(${var_str}).is_null()'
				}
			}
			if checks.len == 0 {
				return 'false'
			}
			return checks.join(' && ')
		}
		ast.node_expr_method_call {
			obj_var_node := node.var or { return '' }
			if obj_var_node.node_type == ast.node_expr_variable {
				mut obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_var_node.name == 'this' {
					obj_type = VarType{ tag: .t_object, class_name: t.current_class }
				}
				if obj_type.is_object() {
					ret_type := t.get_method_return_type(obj_type.class_name, node.name)
					if ret_type.tag == .t_bool {
						return t.visit_expr_native(node)
					}
				}
			}
			return ''
		}
		ast.node_expr_instanceof {
			expr_node := node.expr or { return '' }
			resolved_class := t.resolve_class_name(node.class_name)
			if expr_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[expr_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					// 编译时优化：检查类是否继承或实现目标
					if t.class_implements(obj_type.class_name, resolved_class) {
						return 'true'
					}
					if t.class_does_not_implement(obj_type.class_name, resolved_class) {
						return 'false'
					}
				}
			}
			return ''
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true' { return 'true' }
				'false' { return 'false' }
				else { return '' }
			}
		}
		ast.node_expr_variable {
			// 原生类型变量的 PHP truthiness 直接映射
			typ := t.inferred_types[node.name] or { VarType{ tag: .t_unknown } }
			match typ.tag {
				.t_int { return 'var_${node.name} != 0' }
				.t_float { return 'var_${node.name} != 0.0' }
				.t_bool { return 'var_${node.name}' }
				.t_string { return "var_${node.name}.len > 0 && var_${node.name} != '0'" }
				else { return '' }
			}
		}
		ast.node_expr_empty {
			expr_node := node.expr or { return '' }
			expr_type := t.get_expr_type(*expr_node)
			if expr_type.is_scalar() {
				code := t.visit_expr_native(*expr_node)
				match expr_type.tag {
					.t_string { return "${code} == ''" }
					.t_int { return "${code} == 0" }
					.t_float { return "${code} == 0.0" }
					.t_bool { return "!(${code})" }
					.t_null { return 'true' }
					else {}
				}
			}
			expr_str := t.visit_expr(*expr_node)
			return '!rt.is_true(${expr_str})'
		}
		else { return '' }
	}
}

// get_native_bool_condition always returns a native V bool expression suitable
// for wrapping in rt.new_bool(). It tries emit_native_condition first (which
// handles comparisons, boolean operators, constants, and typed variables),
// then checks for function calls returning native bool, and finally falls back
// to rt.is_true() for PhpVal expressions.
fn (mut t Transpiler) get_native_bool_condition(node ast.AstNode) string {
	// Try the existing native condition emitter first (handles comparisons,
	// boolean operators, constants, instanceof, typed variables)
	native := t.emit_native_condition(node)
	if native != '' {
		return native
	}
	// Function calls returning native bool
	if node.node_type == ast.node_expr_funccall {
		if ret_type := t.func_return_types[node.name] {
			if ret_type.tag == .t_bool {
				return t.visit_expr_native(node)
			}
		}
	}
	// Fallback: wrap the PhpVal expression with rt.is_true()
	return 'rt.is_true(${t.visit_expr(node)})'
}

fn (t Transpiler) binop_native_symbol(node_type string) string {
	match node_type {
		ast.node_bin_greater { return '>' }
		ast.node_bin_smaller { return '<' }
		ast.node_bin_greater_equal { return '>=' }
		ast.node_bin_smaller_equal { return '<=' }
		ast.node_bin_equal { return '==' }
		ast.node_bin_identical { return '==' }
		ast.node_bin_plus { return '+' }
		ast.node_bin_minus { return '-' }
		ast.node_bin_mul { return '*' }
		ast.node_bin_div { return '/' }
		ast.node_bin_mod { return '%' }
		else { return '?' }
	}
}

// emit_v_interpolation 生成 V 原生插值字符串（双引号形式）
fn (mut t Transpiler) emit_v_interpolation(parts []ast.AstNode) string {
	mut interp_parts := []string{}
	for part in parts {
		match part.node_type {
			ast.node_scalar_encapsed_string_part, ast.node_scalar_interpolated_string_part {
				interp_parts << escape_double_quoted(part.value)
			}
			ast.node_expr_variable {
				typ := t.inferred_types[part.name] or { VarType{ tag: .t_unknown } }
				match typ.tag {
					.t_string {
						interp_parts << '\$' + '{var_${part.name}}'
					}
					.t_int, .t_float {
						interp_parts << '\$' + '{var_${part.name}.str()}'
					}
					else {
						interp_parts << '\$' + '{var_${part.name}.to_string()}'
					}
				}
			}
			else {}
		}
	}
	joined := interp_parts.join('')
	return '"${joined}"'
}

fn (mut t Transpiler) visit_expr(node ast.AstNode) string {
	match node.node_type {
		ast.node_expr_isset {
			mut checks := []string{}
			for v in node.vars {
				if v.node_type == ast.node_expr_array_dim_fetch {
					arr_node := v.var or { panic('ArrayDimFetch missing var') }
					dim_node := v.dim or { panic('ArrayDimFetch missing dim') }
					arr_str := t.visit_expr(*arr_node)
					dim_str := t.visit_expr(*dim_node)
					checks << '${arr_str}.array_isset(${dim_str})'
				} else {
					var_str := t.visit_expr(v)
					checks << '!(${var_str}).is_null()'
				}
			}
			if checks.len == 0 {
				return 'rt.new_bool(false)'
			}
			return 'rt.new_bool(${checks.join(" && ")})'
		}
		ast.node_expr_instanceof {
			expr_node := node.expr or { panic('InstanceOf missing expr') }
			resolved_class := t.resolve_class_name(node.class_name)
			// 如果表达式是已知类型的对象变量（现在是 struct 指针）
			if expr_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[expr_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					// 编译时优化：检查类是否继承或实现目标
					if t.class_implements(obj_type.class_name, resolved_class) {
						t.last_expr_type = VarType{ tag: .t_bool }
						return 'rt.new_bool(true)'
					}
					if t.class_does_not_implement(obj_type.class_name, resolved_class) {
						t.last_expr_type = VarType{ tag: .t_bool }
						return 'rt.new_bool(false)'
					}
					// 运行时检查
					expr_str := t.visit_expr(*expr_node)
					return 'rt.new_bool(rt.instance_of(rt.new_object(\'${obj_type.class_name}\', ${t.get_parents_expr(obj_type.class_name)}, ${expr_str}), \'${resolved_class}\'))'
				}
			}
			expr_str := t.visit_expr(*expr_node)
			return 'rt.new_bool(rt.instance_of(${expr_str}, \'${resolved_class}\'))'
		}
		ast.node_expr_variable {
			if node.name == 'this' {
				t.last_expr_type = VarType{ tag: .t_object, class_name: t.current_class }
				if t.expected_type.tag == .t_object && t.expected_type.class_name == t.current_class {
					return 'this'
				}
				return "rt.new_object('${t.current_class}', ${t.get_parents_expr(t.current_class)}, &this)"
			}
			if node.name in ['_GET', '_POST', '_SERVER', '_COOKIE', '_SESSION', '_REQUEST', '_ENV'] {
				t.last_expr_type = VarType{ tag: .t_unknown }
				return 'rt.get_superglobal(\'${node.name}\')'
			}
			var_name := t.var_aliases[node.name] or { node.name }
			typ := t.inferred_types[var_name] or { VarType{ tag: .t_unknown } }
			t.last_expr_type = typ
			
			v_var := t.get_v_var_name(node.name)
			if typ.is_scalar() {
				return box_expr(v_var, typ)
			}
			return v_var
		}
		ast.node_expr_throw {
			expr_node := node.expr or { panic('Throw missing expr') }
			// 如果抛出的是 new ClassName()，create_xxx 返回 &Class_Xxx，需要包装为 PhpVal
			if expr_node.node_type == ast.node_expr_new {
				class_name := t.resolve_class_name(expr_node.class_name)
				expr_str := t.visit_expr(*expr_node)
				parents := t.get_parents_expr(class_name)
				return 'rt.throw_exception(rt.new_object(\'${class_name}\', ${parents}, ${expr_str}))'
			}
			expr_str := t.visit_expr(*expr_node)
			return 'rt.throw_exception(${expr_str})'
		}
		ast.node_scalar_int {
			t.last_expr_type = VarType{ tag: .t_int }
			return 'rt.new_int(${node.value})'
		}
		ast.node_scalar_float {
			t.last_expr_type = VarType{ tag: .t_float }
			return 'rt.new_float(${node.value})'
		}
		ast.node_scalar_string {
			escaped := escape_single_quoted(node.value)
			t.last_expr_type = VarType{ tag: .t_string }
			return 'rt.new_string(\'${escaped}\')'
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true' { t.last_expr_type = VarType{ tag: .t_bool }; return 'rt.new_bool(true)' }
				'false' { t.last_expr_type = VarType{ tag: .t_bool }; return 'rt.new_bool(false)' }
				'null' { t.last_expr_type = VarType{ tag: .t_null }; return 'rt.new_null()' }
				else {
					if gc := t.global_constants[node.name] {
						t.last_expr_type = gc.typ
						match gc.typ.tag {
							.t_int { return 'rt.new_int(${gc.name})' }
							.t_float { return 'rt.new_float(${gc.name})' }
							.t_string { return 'rt.new_string(${gc.name})' }
							.t_bool { return 'rt.new_bool(${gc.name})' }
							else { return gc.name }
						}
					}
					t.last_expr_type = VarType{ tag: .t_unknown }
					return 'rt.get_constant(\'${node.name}\')'
				}
			}
		}
		ast.node_scalar_magic_const_dir {
			return 'rt.new_string(@DIR)'
		}
		ast.node_scalar_magic_const_file {
			return 'rt.new_string(@FILE)'
		}
		ast.node_scalar_magic_const_line {
			return 'rt.new_int(@LINE.int())'
		}
		ast.node_scalar_magic_const_function {
			return 'rt.new_string(@FN)'
		}
		ast.node_scalar_magic_const_method {
			return 'rt.new_string(@METHOD)'
		}
		ast.node_scalar_magic_const_class {
			return 'rt.new_string(@STRUCT)'
		}
		ast.node_scalar_magic_const_namespace {
			ns := t.current_namespace.replace('\\', '\\\\')
			return 'rt.new_string(\'${ns}\')'
		}
		ast.node_expr_assign {
			var_node := node.var or { panic('Assign node missing var') }
			
			if var_node.node_type == ast.node_expr_array_dim_fetch {
				arr_var_node := var_node.var or { panic('ArrayDimFetch missing var') }
				arr_var_type := t.get_expr_type(*arr_var_node)
				arr_var_name := t.visit_expr_write_dim(*arr_var_node)
				
				expr_node := node.expr or { panic('Assign node missing expr') }
				
				is_native_arr := arr_var_type.is_native_list || arr_var_type.is_native_map
				if is_native_arr {
					mut val_str := ''
					if arr_var_type.element_type_tag != .t_unknown {
						val_str = t.visit_expr_native(*expr_node)
					} else {
						val_str = t.visit_expr(*expr_node)
						if expr_node.node_type == ast.node_expr_variable {
							val_str += '.dup()'
						}
					}
					
					if dim_node := var_node.dim {
						dim_str := t.visit_expr_native(*dim_node)
						return '${arr_var_name}[${dim_str}] = ${val_str}'
					} else {
						return '${arr_var_name} << ${val_str}'
					}
				}
				
				expr_typ := t.get_expr_type(*expr_node)
				mut expr_str := if expr_typ.is_scalar() { t.visit_expr_native(*expr_node) } else { t.visit_expr(*expr_node) }
				if !expr_typ.is_scalar() && expr_node.node_type == ast.node_expr_variable {
					expr_str += '.dup()'
				}
				
				if dim_node := var_node.dim {
					dim_typ := t.get_expr_type(*dim_node)
					dim_str := if dim_typ.is_scalar() { t.visit_expr_native(*dim_node) } else { t.visit_expr(*dim_node) }
					return '${arr_var_name}.array_set(${dim_str}, ${expr_str})'
				} else {
					return '${arr_var_name}.array_push(${expr_str})'
				}
			}
			
			if var_node.node_type == ast.node_expr_property_fetch {
				obj_var_node := var_node.var or { panic('PropertyFetch missing var') }
				prop_name := var_node.name
				expr_node := node.expr or { panic('Assign node missing expr') }

				if obj_var_node.node_type == ast.node_expr_variable {
					obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
					if obj_type.is_object() {
						mut has_prop := false
						for cls in t.classes {
							if cls.name.to_lower() == obj_type.class_name.to_lower() {
								if prop_name in cls.all_props {
									has_prop = true
									break
								}
							}
						}
						
						if has_prop {
							prop_type := t.get_class_prop_type(obj_type.class_name, prop_name)
							field_name := prop_v_name(prop_name)
							
							mut rhs := ''
							if prop_type.is_scalar() {
								if expr_node.node_type == ast.node_expr_variable {
									src_type := t.inferred_types[expr_node.name] or { VarType{ tag: .t_unknown } }
									if src_type.is_scalar() {
										rhs = t.visit_expr_native(*expr_node)
									} else {
										rhs = unbox_expr(t.visit_expr(*expr_node), prop_type)
									}
								} else {
									rhs = t.visit_expr_native(*expr_node)
								}
							} else {
								rhs = t.visit_expr(*expr_node)
								if expr_node.node_type == ast.node_expr_variable {
									rhs += '.dup()'
								}
							}
							
							mut obj_name := if obj_var_node.name == 'this' { 'this' } else { t.visit_expr(*obj_var_node) }
							return '${obj_name}.${field_name} = ${rhs}'
						}
					}
				}

				// 回退：动态属性 set_property / dispatch_set_prop
				if obj_var_node.name == 'this' {
					mut expr_str := t.visit_expr(*expr_node)
					if expr_node.node_type == ast.node_expr_variable {
						if !t.native_params[expr_node.name] {
							expr_str += '.dup()'
						}
					}
					return 'this.dispatch_set_prop(\'${prop_name}\', ${expr_str})'
				}
				t.needs_prop_dispatch = true
				obj_var_name := t.visit_expr(*obj_var_node)
				mut expr_str := t.visit_expr(*expr_node)
				if expr_node.node_type == ast.node_expr_variable {
					if !t.native_params[expr_node.name] {
						expr_str += '.dup()'
					}
				}
				return '${obj_var_name}.dispatch_set_prop(\'${prop_name}\', ${expr_str})'
			}
			
			if var_node.node_type != ast.node_expr_variable {
				return '// unsupported assign target: ${var_node.node_type}'
			}
			var_name := var_node.name
			expr_node := node.expr or { panic('Assign node missing expr') }
			
			// 原生 int 变量的 inc/dec 赋值优化：$b = $a++ 或 $b = ++$a
			if expr_node.node_type in [ast.node_expr_post_inc, ast.node_expr_post_dec, ast.node_expr_pre_inc, ast.node_expr_pre_dec] {
				if inc_var := expr_node.var {
					if voidptr(inc_var) != 0 && inc_var.node_type == ast.node_expr_variable {
						inc_typ := t.inferred_types[inc_var.name] or { VarType{ tag: .t_unknown } }
						if inc_typ.tag == .t_int {
							var_type := t.inferred_types[var_name] or { VarType{ tag: .t_unknown } }
							// 仅当目标变量也是 native int 时才走纯原生路径
							if var_type.tag == .t_int {
								is_post := expr_node.node_type in [ast.node_expr_post_inc, ast.node_expr_post_dec]
								is_inc := expr_node.node_type in [ast.node_expr_post_inc, ast.node_expr_pre_inc]
								op := if is_inc { '+= 1' } else { '-= 1' }
								mut result := ''
								if is_post {
									// $b = $a++: 先赋值旧值，再自增
									if t.scope.has_var(var_name) {
										t.native_vars[var_name] = true
										result = 'var_${var_name} = var_${inc_var.name}'
									} else {
										t.scope.declare(var_name)
										t.native_vars[var_name] = true
										result = 'mut var_${var_name} := var_${inc_var.name}'
									}
									t.post_stmts << 'var_${inc_var.name} ${op}'
								} else {
									// $b = ++$a: 先自增，再赋值新值
									t.pre_stmts << 'var_${inc_var.name} ${op}'
									if t.scope.has_var(var_name) {
										t.native_vars[var_name] = true
										result = 'var_${var_name} = var_${inc_var.name}'
									} else {
										t.scope.declare(var_name)
										t.native_vars[var_name] = true
										result = 'mut var_${var_name} := var_${inc_var.name}'
									}
								}
								return result
							}
						}
					}
				}
			}
			
			v_var := t.get_v_var_name(var_name)
			var_type := t.inferred_types[v_var] or { t.inferred_types[var_name] or { VarType{ tag: .t_unknown } } }
			if var_type.is_scalar() {
				expr_typ := t.get_expr_type(*expr_node)
				mut expr_str := t.visit_expr_native(*expr_node)
				if !expr_typ.is_scalar() {
					expr_str = unbox_expr(expr_str, var_type)
				}
				if t.scope.has_var(var_name) {
					return '${v_var} = ${expr_str}'
				} else {
					t.scope.declare(var_name)
					return 'mut ${v_var} := ${expr_str}'
				}
			} else if var_type.is_native_list || var_type.is_native_map {
				old_expected := t.expected_type
				t.expected_type = var_type
				expr_str := t.visit_expr(*expr_node)
				t.expected_type = old_expected
				
				if t.scope.has_var(var_name) {
					return '${v_var} = ${expr_str}'
				} else {
					t.scope.declare(var_name)
					return 'mut ${v_var} := ${expr_str}'
				}
			} else {
				old_expected := t.expected_type
				t.expected_type = var_type
				mut expr_str := t.visit_expr(*expr_node)
				t.expected_type = old_expected
				
				expr_typ := t.get_expr_type(*expr_node)
				if expr_typ.is_scalar() || expr_typ.is_native_list || expr_typ.is_native_map {
					expr_str = box_expr(expr_str, expr_typ)
				}
				
				// P10: 仅为被原地修改的变量生成 .dup()
				if expr_node.node_type == ast.node_expr_variable && t.mutated_vars[expr_node.name] {
					expr_str += '.dup()'
				}
				
				if t.scope.has_var(var_name) {
					return '${v_var} = ${expr_str}'
				} else {
					t.scope.declare(var_name)
					return 'mut ${v_var} := ${expr_str}'
				}
			}
		}
		ast.node_expr_funccall {
			func_name := node.name
			
			if func_name == 'array_keys' {
				mut arg_strs := []string{}
				for arg in node.args {
					arg_val := arg.expr or { panic('Arg missing expr') }
					arg_strs << t.compile_arg_simple(arg_val)
				}
				t.last_expr_type = VarType{ tag: .t_unknown }
				return 'rt.func_array_keys(${arg_strs.join(", ")})'
			}
			
			// 检查是否是有原生类型或已登记的用户自定义函数
			is_custom := func_name in t.func_param_types || func_name in t.func_return_types || t.custom_functions[func_name]
			
			if is_custom {
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
						arg_typ := t.get_expr_type(arg_val)
						if arg_typ.is_scalar() {
							arg_strs << t.visit_expr_native(arg_val)
						} else {
							arg_strs << t.compile_arg_simple(arg_val)
						}
					}
				}
				ret_type := t.func_return_types[func_name] or { VarType{ tag: .t_unknown } }
				t.last_expr_type = ret_type
				// 如果返回值是原生标量，需要装箱为 PhpVal（因为调用上下文通常需要 PhpVal）
				if ret_type.is_scalar() {
					call_expr := '${func_v_name(func_name)}(${arg_strs.join(", ")})'
					return box_expr(call_expr, ret_type)
				}
				return '${func_v_name(func_name)}(${arg_strs.join(", ")})'
			}
			
			// 回退：标准 PhpVal 参数处理
			mut arg_strs := []string{}
			mut arg_nodes := []ast.AstNode{}
			for arg in node.args {
				arg_val := arg.expr or { panic('Arg missing expr') }
				arg_strs << t.compile_arg_simple(*arg_val)
				arg_nodes << *arg_val
			}
			
			if callable_expr_node := node.expr {
				if voidptr(callable_expr_node) != 0 {
					callable_expr := t.visit_expr(*callable_expr_node)
					if arg_strs.len == 0 {
						return 'rt.call_callable(${callable_expr}, []rt.PhpVal{})'
					} else {
						return 'rt.call_callable(${callable_expr}, [${arg_strs.join(", ")}])'
					}
				}
			}
			
			if func_name in t.custom_functions {
				return '${func_v_name(func_name)}(${arg_strs.join(", ")})'
			} else {
				// VLib 内置函数映射：转译阶段内联，消除运行时字符串 dispatch
				builtin := t.try_builtin_mapping(func_name, arg_strs, arg_nodes)
				if builtin != '' {
					return builtin
				}
				if arg_strs.len == 0 {
					return 'rt.call_function(\'${func_name}\', []rt.PhpVal{})'
				} else {
					return 'rt.call_function(\'${func_name}\', [${arg_strs.join(", ")}])'
				}
			}
		}
		// 二元运算：类型可知时生成原生 V 代码，否则回退运行时
		ast.node_bin_plus {
			return t.emit_binop(node, '+', 'rt.add')
		}
		ast.node_bin_minus {
			return t.emit_binop(node, '-', 'rt.sub')
		}
		ast.node_bin_mul {
			return t.emit_binop(node, '*', 'rt.mul')
		}
		ast.node_bin_div {
			return t.emit_binop(node, '/', 'rt.div')
		}
		ast.node_bin_mod {
			left := node.left or { panic('mod missing left') }
			right := node.right or { panic('mod missing right') }
			l_type := t.get_expr_type(*left)
			r_type := t.get_expr_type(*right)
			if l_type.tag == .t_int && r_type.tag == .t_int {
				t.last_expr_type = VarType{ tag: .t_int }
				l_code := t.visit_expr_native(*left)
				r_code := t.visit_expr_native(*right)
				return '${l_code} % ${r_code}'
			}
			return 'rt.mod_(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_concat {
			left := node.left or { panic('concat missing left') }
			right := node.right or { panic('concat missing right') }
			l_type := t.get_expr_type(*left)
			r_type := t.get_expr_type(*right)
			l_scalar := l_type.is_scalar()
			r_scalar := r_type.is_scalar()
			if l_scalar || r_scalar {
				// 至少一侧是原生标量，使用 V 原生 + 拼接
				t.last_expr_type = VarType{ tag: .t_string }
				l_code := if l_scalar {
					t.native_to_str(*left, l_type)
				} else {
					'(${t.visit_expr(*left)}).str()'
				}
				r_code := if r_scalar {
					t.native_to_str(*right, r_type)
				} else {
					'(${t.visit_expr(*right)}).str()'
				}
				return '${l_code} + ${r_code}'
			}
			return 'rt.concat(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_greater {
			return t.emit_comparison(node, '>', 'rt.greater')
		}
		ast.node_bin_smaller {
			return t.emit_comparison(node, '<', 'rt.less')
		}
		ast.node_bin_greater_equal {
			return t.emit_comparison(node, '>=', 'rt.greater_equal')
		}
		ast.node_bin_smaller_equal {
			return t.emit_comparison(node, '<=', 'rt.less_equal')
		}
		ast.node_bin_equal {
			return t.emit_comparison(node, '==', 'rt.equal')
		}
		ast.node_bin_identical {
			return t.emit_comparison(node, '==', 'rt.identical')
		}
		ast.node_expr_boolean_not {
			expr_node := node.expr or { panic('BooleanNot missing expr') }
			cond := t.get_native_bool_condition(*expr_node)
			return 'rt.new_bool(!(${cond}))'
		}
		ast.node_bin_bool_and, ast.node_bin_logical_and {
			left := node.left or { panic('and missing left') }
			right := node.right or { panic('and missing right') }
			l_cond := t.get_native_bool_condition(*left)
			r_cond := t.get_native_bool_condition(*right)
			return 'rt.new_bool(${l_cond} && ${r_cond})'
		}
		ast.node_bin_bool_or, ast.node_bin_logical_or {
			left := node.left or { panic('or missing left') }
			right := node.right or { panic('or missing right') }
			l_cond := t.get_native_bool_condition(*left)
			r_cond := t.get_native_bool_condition(*right)
			return 'rt.new_bool(${l_cond} || ${r_cond})'
		}
		ast.node_expr_ternary {
			cond := node.cond or { panic('Ternary missing cond') }
			cond_str := t.get_native_bool_condition(*cond)
			if if_node := node.@if {
				else_node := node.@else or { panic('Ternary missing else') }
				return 'if ${cond_str} { ${t.visit_expr(*if_node)} } else { ${t.visit_expr(*else_node)} }'
			} else {
				else_node := node.@else or { panic('Ternary missing else') }
				return 'if ${cond_str} { ${t.visit_expr(*cond)} } else { ${t.visit_expr(*else_node)} }'
			}
		}
		ast.node_bin_coalesce {
			left := node.left or { panic('Coalesce missing left') }
			right := node.right or { panic('Coalesce missing right') }
			left_str := t.visit_expr(*left)
			return 'if !(${left_str}).is_null() { ${left_str} } else { ${t.visit_expr(*right)} }'
		}
		ast.node_bin_bitwise_and {
			return t.emit_bitwise(node, '&', 'rt.bitwise_and')
		}
		ast.node_bin_bitwise_or {
			return t.emit_bitwise(node, '|', 'rt.bitwise_or')
		}
		ast.node_bin_bitwise_xor {
			return t.emit_bitwise(node, '^', 'rt.bitwise_xor')
		}
		ast.node_bin_shift_left {
			return t.emit_bitwise(node, '<<', 'rt.shift_left')
		}
		ast.node_bin_shift_right {
			return t.emit_bitwise(node, '>>', 'rt.shift_right')
		}
		ast.node_expr_bitwise_not {
			expr_node := node.expr or { panic('BitwiseNot missing expr') }
			e_type := t.get_expr_type(*expr_node)
			if e_type.tag == .t_int {
				t.last_expr_type = VarType{ tag: .t_int }
				e_code := t.visit_expr_native(*expr_node)
				return '~${e_code}'
			}
			return 'rt.bitwise_not(${t.visit_expr(*expr_node)})'
		}

		ast.node_expr_array {
			mut arr_type := t.get_expr_type(node)
			if t.expected_type.is_native_list || t.expected_type.is_native_map {
				arr_type = t.expected_type
			}
			if arr_type.is_native_list {
				mut elem_strs := []string{}
				for item in node.items {
					val_node := item.expr or { continue }
					val_typ := t.get_expr_type(*val_node)
					if val_typ.tag == arr_type.element_type_tag {
						elem_strs << t.visit_expr_native(*val_node)
					} else {
						elem_strs << t.visit_expr(*val_node)
					}
				}
				t.last_expr_type = arr_type
				if elem_strs.len == 0 {
					return '[]rt.PhpVal{}'
				}
				return '[${elem_strs.join(", ")}]'
			}
			if arr_type.is_native_map {
				mut pair_strs := []string{}
				for item in node.items {
					key_node := item.key or { continue }
					val_node := item.expr or { continue }
					key_str := t.visit_expr_native(*key_node)
					val_typ := t.get_expr_type(*val_node)
					mut val_str := ''
					if val_typ.tag == arr_type.element_type_tag {
						val_str = t.visit_expr_native(*val_node)
					} else {
						val_str = t.visit_expr(*val_node)
					}
					pair_strs << '${key_str}: ${val_str}'
				}
				t.last_expr_type = arr_type
				if pair_strs.len == 0 {
					return 'map[string]rt.PhpVal{}'
				}
				return '{ ${pair_strs.join(", ")} }'
			}
			
			mut item_strs := []string{}
			for item in node.items {
				val_node := item.expr or { panic('ArrayItem missing expr') }
				val_typ := t.get_expr_type(*val_node)
				val_str := if val_typ.is_scalar() { t.visit_expr_native(*val_node) } else { t.visit_expr(*val_node) }
				
				if key_node := item.key {
					key_typ := t.get_expr_type(*key_node)
					key_str := if key_typ.is_scalar() { t.visit_expr_native(*key_node) } else { t.visit_expr(*key_node) }
					item_strs << 'rt.ArrayItem{ key: ${key_str}, val: ${val_str} }'
				} else {
					item_strs << 'rt.ArrayItem{ key: none, val: ${val_str} }'
				}
			}
			if item_strs.len == 0 {
				return 'rt.new_array()'
			} else {
				return 'rt.create_array([${item_strs.join(", ")}])'
			}
		}
		ast.node_expr_array_dim_fetch {
			var_node := node.var or { panic('ArrayDimFetch missing var') }
			var_type := t.get_expr_type(*var_node)
			var_str := t.visit_expr(*var_node)
			is_native_arr := (var_type.is_native_list || var_type.is_native_map) && (t.native_params[var_node.name] || t.native_vars[var_node.name] || var_node.name.ends_with('_mutated'))
			if is_native_arr {
				if dim_node := node.dim {
					dim_str := t.visit_expr_native(*dim_node)
					elem_type := VarType{ tag: var_type.element_type_tag }
					t.last_expr_type = elem_type
					return box_expr('${var_str}[${dim_str}]', elem_type)
				} else {
					panic('ArrayDimFetch missing dim in read context')
				}
			}
			if dim_node := node.dim {
				dim_typ := t.get_expr_type(*dim_node)
				dim_str := if dim_typ.is_scalar() { t.visit_expr_native(*dim_node) } else { t.visit_expr(*dim_node) }
				return '${var_str}.array_get(${dim_str})'
			} else {
				panic('ArrayDimFetch missing dim in read context')
			}
		}
		ast.node_expr_new {
			if class_expr_node := node.class_expr {
				mut arg_strs := []string{}
				for arg in node.args {
					arg_val := arg.expr or { panic('Arg missing expr') }
					arg_strs << t.compile_arg_simple(*arg_val)
				}
				class_expr_str := t.visit_expr_native(*class_expr_node)
				if arg_strs.len == 0 {
					return 'rt.create_object_dynamically(${class_expr_str}, []rt.PhpVal{})'
				} else {
					return 'rt.create_object_dynamically(${class_expr_str}, [${arg_strs.join(", ")}])'
				}
			}
			class_name := t.resolve_class_name(node.class_name)
			t.undeclared_classes[class_name] = true
			// 查找构造函数的参数类型，以便传递原生类型
			mut ctor_param_types := []VarType{}
			for cls in t.classes {
				if cls.name.to_lower() == class_name.to_lower() {
					if pm := cls.param_types['__construct'] {
						for pname, ptype in pm {
							_ = pname
							ctor_param_types << ptype
						}
					}
					break
				}
			}
			mut arg_strs := []string{}
			for i, arg in node.args {
				arg_val := arg.expr or { panic('Arg missing expr') }
				// 查找当前参数位置的目标类型
				mut target_type := VarType{ tag: .t_unknown }
				if i < ctor_param_types.len {
					target_type = ctor_param_types[i]
				}
				mut arg_str := ''
				if target_type.is_scalar() {
					// 构造函数参数期望原生类型 → 用 native 表达式
					arg_str = t.visit_expr_native(*arg_val)
				} else {
					php_val := t.visit_expr(*arg_val)
					if arg_val.node_type == ast.node_expr_variable {
						arg_str = '${php_val}.dup()'
					} else {
						arg_str = php_val
					}
				}
				arg_strs << arg_str
			}
			
			if m := t.find_method(class_name, '__construct') {
				if node.args.len < m.param_count {
					for i in node.args.len .. m.param_count {
						if i < m.param_names.len {
							pname := m.param_names[i]
							ptype := t.get_method_param_type(class_name, '__construct', pname)
							if ptype.is_scalar() {
								match ptype.tag {
									.t_string { arg_strs << "''" }
									.t_int { arg_strs << '0' }
									.t_float { arg_strs << '0.0' }
									.t_bool { arg_strs << 'false' }
									else { arg_strs << 'rt.new_null()' }
								}
							} else {
								arg_strs << 'rt.new_null()'
							}
						} else {
							arg_strs << 'rt.new_null()'
						}
					}
				}
			}
			return 'create_${class_name.to_lower()}(${arg_strs.join(", ")})'
		}
		ast.node_expr_method_call {
			obj_var_node := node.var or { panic('MethodCall missing var') }
			obj_var_name := t.visit_expr(*obj_var_node)

			if name_expr_node := node.name_expr {
				t.needs_method_dispatch = true
				mut arg_strs := []string{}
				for arg in node.args {
					arg_val := arg.expr or { panic('Arg missing expr') }
					arg_strs << t.compile_arg_simple(*arg_val)
				}
				method_name_expr := t.visit_expr_native(*name_expr_node)
				if arg_strs.len == 0 {
					return 'call_method(${obj_var_name}, ${method_name_expr}, []rt.PhpVal{})'
				} else {
					return 'call_method(${obj_var_name}, ${method_name_expr}, [${arg_strs.join(", ")}])'
				}
			}

			method_name := node.name

			// P7 Task 10: 已知对象类型 → 直接调用方法（无 IIFE）
			if obj_var_node.node_type == ast.node_expr_variable {
				mut obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_var_node.name == 'this' {
					obj_type = VarType{ tag: .t_object, class_name: t.current_class }
				}
				if obj_type.is_object() {
					return t.compile_method_call_known(node, obj_type, *obj_var_node, obj_var_name)
				}
			}
			// 回退: call_method
			t.needs_method_dispatch = true
			mut arg_strs := []string{}
			for arg in node.args {
				arg_val := arg.expr or { panic('Arg missing expr') }
				arg_strs << t.compile_arg_simple(*arg_val)
			}
			if arg_strs.len == 0 {
				return 'call_method(${obj_var_name}, \'${method_name}\', []rt.PhpVal{})'
			} else {
				return 'call_method(${obj_var_name}, \'${method_name}\', [${arg_strs.join(", ")}])'
			}
		}
		ast.node_expr_property_fetch {
			obj_var_node := node.var or { panic('PropertyFetch missing var') }
			obj_var_name := t.visit_expr(*obj_var_node)
			prop_name := node.name
			// P7 Task 8/10: 已知对象类型 + 属性已定义 → 直接访问原生字段
			if obj_var_node.node_type == ast.node_expr_variable {
				mut obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_var_node.name == 'this' {
					obj_type = VarType{ tag: .t_object, class_name: t.current_class }
				}
				if obj_type.is_object() {
					mut has_prop := false
					for cls in t.classes {
						if cls.name.to_lower() == obj_type.class_name.to_lower() {
							if prop_name in cls.all_props {
								has_prop = true
								break
							}
						}
					}
					
					if has_prop {
						prop_type := t.get_class_prop_type(obj_type.class_name, prop_name)
						field_name := prop_v_name(prop_name)
						if obj_var_node.name == 'this' {
							return 'this.${field_name}'
						}
						if prop_type.is_scalar() {
							match prop_type.tag {
								.t_string { return 'rt.new_string(${obj_var_name}.${field_name})' }
								.t_int { return 'rt.new_int(${obj_var_name}.${field_name})' }
								.t_float { return 'rt.new_float(${obj_var_name}.${field_name})' }
								.t_bool { return 'rt.new_bool(${obj_var_name}.${field_name})' }
								else { return '${obj_var_name}.${field_name}' }
							}
						} else {
							return '${obj_var_name}.${field_name}'
						}
					}
				}
			}
			t.needs_prop_dispatch = true
			return 'get_property(${obj_var_name}, \'${prop_name}\')'
		}
		ast.node_expr_eval {
			expr_node := node.expr or { panic('Eval missing expr') }
			expr_str := t.visit_expr(*expr_node)
			return 'rt.call_function(\'eval\', [${expr_str}])'
		}
		ast.node_expr_match {
			cond_node := node.cond or { panic('Match expression missing cond') }

			// 检查是否可以使用 V 原生 match
			cond_type := t.get_expr_type(*cond_node)
			mut can_native := cond_type.tag == .t_int
			if can_native {
				for arm in node.arms {
					for c_node in arm.conds {
						if c_node.node_type != ast.node_scalar_int {
							can_native = false
							break
						}
					}
					if !can_native { break }
				}
			}

			if can_native {
				// V 原生 match 表达式
				cond_str := t.visit_expr_native(*cond_node)
				mut match_expr := strings.new_builder(128)
				match_expr.write_string('match ${cond_str} { ')

				mut has_default := false
				mut default_body := ''
				mut non_default_arms := []ast.AstNode{}
				for arm in node.arms {
					if arm.conds.len == 0 {
						has_default = true
						body_node := arm.body or { panic('MatchArm missing body') }
						default_body = t.visit_expr(*body_node)
					} else {
						non_default_arms << arm
					}
				}

				for arm in non_default_arms {
					body_node := arm.body or { panic('MatchArm missing body') }
					body_val := t.visit_expr(*body_node)
					mut case_vals := []string{}
					for c_node in arm.conds {
						case_vals << c_node.value
					}
					match_expr.write_string('${case_vals.join(", ")} { ${body_val} } ')
				}

				if has_default {
					match_expr.write_string('else { ${default_body} } ')
				} else {
					match_expr.write_string('else { rt.new_null() } ')
				}
				match_expr.write_string('}')
				return match_expr.str()
			}

			// 回退：使用 if-else 链
			cond_val_expr := t.visit_expr(*cond_node)

			t.switch_count++
			match_var := 'match_val_${t.switch_count}'

			t.pre_stmts << 'mut ${match_var} := ${cond_val_expr}'


			mut if_else_expr := strings.new_builder(128)

			mut has_default := false
			mut default_body := ''

			mut non_default_arms := []ast.AstNode{}
			for arm in node.arms {
				if arm.conds.len == 0 {
					has_default = true
					body_node := arm.body or { panic('MatchArm missing body') }
					default_body = t.visit_expr(*body_node)
				} else {
					non_default_arms << arm
				}
			}

			for idx, arm in non_default_arms {
				body_node := arm.body or { panic('MatchArm missing body') }
				body_val := t.visit_expr(*body_node)

				if idx == 0 {
					if_else_expr.write_string('if ')
				} else {
					if_else_expr.write_string(' else if ')
				}

				for c_idx, c_node in arm.conds {
					if c_idx > 0 {
						if_else_expr.write_string(' || ')
					}
					if_else_expr.write_string('rt.is_true(rt.equal(${match_var}, ')
					if_else_expr.write_string(t.visit_expr(c_node))
					if_else_expr.write_string('))')
				}
				if_else_expr.write_string(' { ${body_val} }')
			}

			if has_default {
				if non_default_arms.len > 0 {
					if_else_expr.write_string(' else { ${default_body} }')
				} else {
					if_else_expr.write_string('if true { ${default_body} } else { rt.new_null() }')
				}
			} else {
				if_else_expr.write_string(' else { rt.new_null() }')
			}

			return if_else_expr.str()
		}
		ast.node_expr_post_inc {
			var_node := node.var or { panic('PostInc missing var') }
			var_str := t.visit_expr(*var_node)
			return 'rt.post_inc(${var_str})'
		}
		ast.node_expr_post_dec {
			var_node := node.var or { panic('PostDec missing var') }
			var_str := t.visit_expr(*var_node)
			return 'rt.post_dec(${var_str})'
		}
		ast.node_expr_pre_inc {
			var_node := node.var or { panic('PreInc missing var') }
			var_str := t.visit_expr(*var_node)
			return 'rt.pre_inc(${var_str})'
		}
		ast.node_expr_pre_dec {
			var_node := node.var or { panic('PreDec missing var') }
			var_str := t.visit_expr(*var_node)
			return 'rt.pre_dec(${var_str})'
		}
		ast.node_expr_error_suppress {
			expr_node := node.expr or { panic('ErrorSuppress missing expr') }
			return t.visit_expr(*expr_node)
		}
		ast.node_expr_class_const_fetch {
			mut cls := node.class_name
			if cls == 'self' {
				cls = t.current_class
			} else if cls == 'parent' {
				mut parent_cls := ''
				for c in t.classes {
					if c.name == t.current_class {
						parent_cls = c.extends
						break
					}
				}
				cls = parent_cls
			}
			resolved_cls := t.resolve_class_name(cls)
			return 'Class_${resolved_cls}.${node.name.to_lower()}()'
		}

		ast.node_expr_closure {
			t.closure_count++
			
			mut captured_vars := []string{}
			mut ref_captured := map[string]bool{}
			mut captured_types := map[string]VarType{}
			for use_node in node.uses {
				use_var := use_node.var or { continue }
				captured_vars << use_var.name
				captured_types[use_var.name] = t.inferred_types[use_var.name] or { VarType{ tag: .t_unknown } }
				if use_node.by_ref == 'true' {
					ref_captured[use_var.name] = true
				}
			}
			
			// 创建临时 builder 生成闭包体
			old_body_builder := t.closure_body_builder
			old_is_in_closure_body := t.is_in_closure_body
			t.closure_body_builder = strings.new_builder(256)
			t.is_in_closure_body = true
			old_indent := t.indent
			t.indent = 1
			old_scope := t.scope
			t.scope = VarScope.new()
			mut old_captured_natives := t.closure_captured_natives.clone()
			t.closure_captured_natives = map[string]VarType{}
			
			mut param_names := []string{}
			for param in node.params {
				param_var := param.var or { panic('Param missing var') }
				param_name := param_var.name
				t.scope.declare(param_name)
				param_names << param_name
			}
			
			// 参数从 args 提取
			for i, param_name in param_names {
				t.write_indent()
				t.write_line('mut var_${param_name} := if args.len > ${i} { args[${i}].dup() } else { rt.new_null() }')
			}
			
			// 捕获变量由 V 原生 [x] 机制处理，声明到 scope 供 body 使用
			for var_name in captured_vars {
				t.scope.declare(var_name)
				if ct := captured_types[var_name] {
					if ct.tag != .t_unknown {
						t.closure_captured_natives[var_name] = ct
					}
				}
			}
			
			ref_vars, ass_vars := t.collect_vars_in_scope(node.stmts)
			for v in ref_vars {
				if v !in ass_vars && !t.scope.has_var(v) {
					t.write_indent()
					t.write_line('mut var_${v} := rt.new_null()')
					t.scope.declare(v)
				}
			}
			
			for stmt in node.stmts {
				t.visit_stmt(stmt)
			}
			
			if node.stmts.len == 0 || node.stmts[node.stmts.len - 1].node_type != ast.node_stmt_return {
				t.write_indent()
				t.write_line('return rt.new_null()')
			}
			
			// 恢复状态
			body_str := t.closure_body_builder.str()
			t.indent = old_indent
			t.scope = old_scope
			t.is_in_closure_body = old_is_in_closure_body
			t.closure_body_builder = old_body_builder
			t.closure_captured_natives = old_captured_natives.clone()
			for var_name in captured_vars {
				if ct := captured_types[var_name] {
					t.inferred_types[var_name] = ct
				}
			}
			
			// 构建 V 捕获列表
			mut capture_parts := []string{}
			for var_name in captured_vars {
				if ref_captured[var_name] {
					capture_parts << 'mut var_${var_name}'
				} else {
					capture_parts << 'var_${var_name}'
				}
			}
			capture_str := if capture_parts.len > 0 { '[${capture_parts.join(", ")}] ' } else { '' }
			
			// 生成 V 原生 fn，签名：fn (this_ptr PhpVal, args []PhpVal) PhpVal
			closure_fn_name := 'closure_${t.closure_count}_fn'
			closure_fn_def := '${closure_fn_name} := fn ${capture_str}(this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {\n${body_str}\t}'
			t.pre_stmts << closure_fn_def
			
			return 'rt.new_closure(${closure_fn_name})'
		}
		ast.node_expr_arrow_function {
			t.closure_count++
			
			expr_node := node.expr or { panic('ArrowFunction missing expr') }
			
			mut param_names := []string{}
			for param in node.params {
				param_var := param.var or { panic('Param missing var') }
				param_names << param_var.name
			}
			
			mut captured_vars := []string{}
			t.find_captured_vars_rec(*expr_node, param_names, mut captured_vars)
			mut captured_types := map[string]VarType{}
			for var_name in captured_vars {
				captured_types[var_name] = t.inferred_types[var_name] or { VarType{ tag: .t_unknown } }
			}
			
			// 创建临时 builder 生成闭包体
			old_body_builder := t.closure_body_builder
			old_is_in_closure_body := t.is_in_closure_body
			t.closure_body_builder = strings.new_builder(256)
			t.is_in_closure_body = true
			old_indent := t.indent
			t.indent = 1
			old_scope := t.scope
			t.scope = VarScope.new()
			mut old_captured_natives := t.closure_captured_natives.clone()
			t.closure_captured_natives = map[string]VarType{}
			
			for param_name in param_names {
				t.scope.declare(param_name)
			}
			
			for i, param_name in param_names {
				t.write_indent()
				t.write_line('mut var_${param_name} := if args.len > ${i} { args[${i}].dup() } else { rt.new_null() }')
			}
			
			for var_name in captured_vars {
				t.scope.declare(var_name)
				if ct := captured_types[var_name] {
					if ct.tag != .t_unknown {
						t.closure_captured_natives[var_name] = ct
					}
				}
			}
			
			expr_str := t.visit_expr(*expr_node)
			t.write_indent()
			t.write_line('return ${expr_str}')
			
			// 恢复状态
			body_str := t.closure_body_builder.str()
			t.indent = old_indent
			t.scope = old_scope
			t.is_in_closure_body = old_is_in_closure_body
			t.closure_body_builder = old_body_builder
			t.closure_captured_natives = old_captured_natives.clone()
			for var_name in captured_vars {
				if ct := captured_types[var_name] {
					t.inferred_types[var_name] = ct
				}
			}
			
			// 箭头函数只读捕获
			mut capture_parts := []string{}
			for var_name in captured_vars {
				capture_parts << 'var_${var_name}'
			}
			capture_str := if capture_parts.len > 0 { '[${capture_parts.join(", ")}] ' } else { '' }
			
			// 生成 V 原生 fn，签名：fn (this_ptr PhpVal, args []PhpVal) PhpVal
			closure_fn_name := 'closure_${t.closure_count}_fn'
			closure_fn_def := '${closure_fn_name} := fn ${capture_str}(this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {\n${body_str}\t}'
			t.pre_stmts << closure_fn_def
			
			return 'rt.new_closure(${closure_fn_name})'
		}
		ast.node_expr_include {
			path_node := node.expr or { panic('Include missing expr') }
			if voidptr(path_node) != 0 {
				path_typ := t.get_expr_type(*path_node)
				path_str := if path_typ.tag == .t_string {
					t.visit_expr_native(*path_node)
				} else {
					'(${t.visit_expr(*path_node)}).to_string()'
				}
				return 'rt.include_file(${path_str}, \'${node.incl_type}\')'
			}
			return 'rt.new_null()'
		}
		ast.node_expr_static_call {
			// parent::method(...) 的转译
			if node.class_name == 'parent' {
				// 查找当前类的父类名称
				mut parent_class := ''
				for c in t.classes {
					if c.name == t.current_class {
						parent_class = c.extends
						break
					}
				}
				if parent_class.len == 0 {
					return '// error: parent:: used without extends'
				}

				// 查找父类方法的参数类型
				mut parent_param_types := []VarType{}
				method_name := node.name
				if pm := t.param_types_for_method(parent_class, method_name) {
					for pn, pt in pm {
						_ = pn
						parent_param_types << pt
					}
				}

				mut arg_strs := []string{}
				for i, arg in node.args {
					arg_val := arg.expr or { panic('Arg missing expr') }
						mut target_type := VarType{ tag: .t_unknown }
						if i < parent_param_types.len {
							target_type = parent_param_types[i]
						}
						result := t.compile_arg(*arg_val, target_type)
						arg_strs << result.code
				}
				// V struct embedding: this.Class_Parent.method_name() 直接调用父类方法
				return 'this.Class_${parent_class}.${method_v_name(node.name)}(${arg_strs.join(", ")})'
			}
			
			// self/static 或普通类名的静态调用
			mut class_name := node.class_name
			if class_name == 'self' || class_name == 'static' {
				class_name = t.current_class
			} else {
				class_name = t.resolve_class_name(class_name)
			}
			t.undeclared_classes[class_name] = true
			
			// 查找目标方法的参数类型
			mut target_param_types := []VarType{}
			method_name := node.name
			if pm := t.param_types_for_method(class_name, method_name) {
				for pn, pt in pm {
					_ = pn
					target_param_types << pt
				}
			}
			
			mut arg_strs := []string{}
			mut arg_formals := []string{}
			mut arg_calls := []string{}
			for i, arg in node.args {
				arg_val := arg.expr or { panic('Arg missing expr') }
					arg_type := t.get_expr_type(*arg_val)
					mut target_type := VarType{ tag: .t_unknown }
					if i < target_param_types.len {
						target_type = target_param_types[i]
					}
					
					mut arg_str := ''
					mut formal_type := 'rt.PhpVal'
					mut call_expr := ''

					target_is_native := target_type.is_scalar() || target_type.class_name.len > 0
					arg_is_native := arg_type.is_scalar() || arg_type.class_name.len > 0

					mut prefix := ''
					if target_type.tag == .t_object {
						prefix = 'mut '
					}

					if target_is_native && arg_is_native {
						// 实参和目标都是原生类型 → 直接传递
						arg_str = prefix + t.compile_expr(*arg_val, .native)
						formal_type = target_type.to_v_type()
						call_expr = prefix + 'arg_${i}'
					} else if target_is_native && !arg_is_native {
						// 实参是 PhpVal，目标期望原生类型 → 拆箱
						raw := t.compile_expr(*arg_val, .boxed)
						unboxed := unbox_expr(raw, target_type)
						arg_str = prefix + unboxed
						formal_type = target_type.to_v_type()
						call_expr = prefix + 'arg_${i}'
					} else if !target_is_native && arg_is_native {
						// 实参是原生，目标期望 PhpVal → 装箱
						result := t.compile_arg(*arg_val, VarType{ tag: .t_unknown })
						arg_str = result.code
						formal_type = 'rt.PhpVal'
						call_expr = 'arg_${i}'
					} else {
						// 目标期望 PhpVal，源也是包装 → 直接传递
						result := t.compile_arg(*arg_val, VarType{ tag: .t_unknown })
						arg_str = result.code
						formal_type = 'rt.PhpVal'
						call_expr = 'arg_${i}'
					}

					arg_strs << arg_str
					if target_type.tag == .t_object {
						arg_formals << 'mut arg_${i} ${formal_type}'
					} else {
						arg_formals << 'arg_${i} ${formal_type}'
					}
					arg_calls << call_expr
			}
			
			is_static_method := if m := t.find_method(class_name, node.name) { m.is_static } else { false }
			ret_type := t.get_method_return_type(class_name, node.name)

			if is_static_method {
				return 'Class_${class_name}.${method_v_name(node.name)}(${arg_strs.join(", ")})'
			}

			if arg_strs.len == 0 {
				if ret_type.tag == .t_void {
					return 'fn () rt.PhpVal { mut temp := Class_${class_name}{}; temp.${method_v_name(node.name)}(); return rt.new_null() }()'
				}
				return 'fn () rt.PhpVal { mut temp := Class_${class_name}{}; return temp.${method_v_name(node.name)}() }()'
			} else {
				if ret_type.tag == .t_void {
					return 'fn (${arg_formals.join(", ")}) rt.PhpVal { mut temp := Class_${class_name}{}; temp.${method_v_name(node.name)}(${arg_calls.join(", ")}); return rt.new_null() }(${arg_strs.join(", ")})'
				}
				return 'fn (${arg_formals.join(", ")}) rt.PhpVal { mut temp := Class_${class_name}{}; return temp.${method_v_name(node.name)}(${arg_calls.join(", ")}) }(${arg_strs.join(", ")})'
			}
		}
		ast.node_scalar_encapsed, ast.node_scalar_interpolated_string {
			if node.parts.len == 0 {
				return "rt.new_string('')"
			}
			// 尝试 V 字符串插值优化
			if can_use_v_interpolation(node.parts) {
				joined := t.emit_v_interpolation(node.parts)
				return 'rt.new_string(${joined})'
			}
			// 回退到 concat 链
			mut res := t.visit_expr(node.parts[0])
			for i in 1 .. node.parts.len {
				part_str := t.visit_expr(node.parts[i])
				res = 'rt.concat(${res}, ${part_str})'
			}
			return res
		}
		ast.node_scalar_encapsed_string_part, ast.node_scalar_interpolated_string_part {
			escaped := escape_single_quoted(node.value)
			return 'rt.new_string(\'${escaped}\')'
		}
		ast.node_expr_empty {
			expr_node := node.expr or { panic('Empty missing expr') }
			expr_type := t.get_expr_type(*expr_node)
			if expr_type.is_scalar() {
				native_expr := t.visit_expr_native(*expr_node)
				match expr_type.tag {
					.t_string { return 'rt.new_bool(${native_expr} == \'\')' }
					.t_int { return 'rt.new_bool(${native_expr} == 0)' }
					.t_float { return 'rt.new_bool(${native_expr} == 0.0)' }
					.t_bool { return 'rt.new_bool(!${native_expr})' }
					else {}
				}
			}
			expr_str := t.visit_expr(*expr_node)
			return 'rt.new_bool(!rt.is_true(${expr_str}))'
		}
		ast.node_expr_cast_array {
			expr_node := node.expr or { panic('CastArray missing expr') }
			expr_str := t.visit_expr(*expr_node)
			return 'rt.cast_array(${expr_str})'
		}
		else {
			return '// unsupported expression: ${node.node_type}'
		}
	}
}

// visit_expr_write_dim 专门用于写上下文下的嵌套数组获取，将只读的 array_get 递归转换为可写的 array_get_mut
fn (mut t Transpiler) visit_expr_write_dim(node ast.AstNode) string {
	if node.node_type == ast.node_expr_array_dim_fetch {
		var_node := node.var or { panic('ArrayDimFetch missing var') }
		dim_node := node.dim or { panic('ArrayDimFetch missing dim') }
		
		var_str := t.visit_expr_write_dim(*var_node)
		dim_typ := t.get_expr_type(*dim_node)
		dim_str := if dim_typ.is_scalar() { t.visit_expr_native(*dim_node) } else { t.visit_expr(*dim_node) }
		
		return '${var_str}.array_get_mut(${dim_str})'
	}
	return t.visit_expr(node)
}

// compile_method_call_known 编译已知对象类型的方法调用，自动根据目标方法参数类型应用 4-way 矩阵装箱/拆箱
fn (mut t Transpiler) compile_method_call_known(node ast.AstNode, obj_type VarType, obj_var_node ast.AstNode, obj_var_name string) string {
	method_name := node.name
	// 构建参数列表，按目标方法参数类型自动装箱/拆箱
	mut arg_strs := []string{}
	for i, arg in node.args {
		arg_val := arg.expr or { panic('Arg missing expr') }
		mut target_param_type := VarType{ tag: .t_unknown }
		mut pname := ''
		if m := t.find_method(obj_type.class_name, method_name) {
			if i < m.param_names.len {
				pname = m.param_names[i]
				target_param_type = t.get_method_param_type(obj_type.class_name, method_name, pname)
			}
		}
		result := t.compile_arg(*arg_val, target_param_type)
		arg_strs << result.code
		_ = i
	}
	
	if m := t.find_method(obj_type.class_name, method_name) {
		if node.args.len < m.param_count {
			for i in node.args.len .. m.param_count {
				if i < m.param_names.len {
					pname := m.param_names[i]
					ptype := t.get_method_param_type(obj_type.class_name, method_name, pname)
					if ptype.is_scalar() {
						match ptype.tag {
							.t_string { arg_strs << "''" }
							.t_int { arg_strs << '0' }
							.t_float { arg_strs << '0.0' }
							.t_bool { arg_strs << 'false' }
							else { arg_strs << 'rt.new_null()' }
						}
					} else {
						arg_strs << 'rt.new_null()'
					}
				} else {
					arg_strs << 'rt.new_null()'
				}
			}
		}
	}
	args_joined := arg_strs.join(', ')
	// 如果对象就是 this，直接调用
	if obj_var_node.node_type == ast.node_expr_variable && obj_var_node.name == 'this' {
		return 'this.${method_v_name(method_name)}(${args_joined})'
	}
	// 外部对象已知类型 → 直接调用方法（无需 IIFE 包装）
	call_expr := '${obj_var_name}.${method_v_name(method_name)}(${args_joined})'
	return call_expr
}

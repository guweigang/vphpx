module emitter

import strings
import os
import php2v.ast

fn (mut t Transpiler) get_expr_type(node ast.AstNode) VarType {
	match node.node_type {
		ast.node_scalar_int { return VarType{ tag: .t_int } }
		ast.node_scalar_float { return VarType{ tag: .t_float } }
		ast.node_scalar_string { return VarType{ tag: .t_string } }
		ast.node_scalar_encapsed, ast.node_scalar_interpolated_string { return VarType{ tag: .t_string } }
		ast.node_expr_variable { return t.inferred_types[node.name] or { VarType{ tag: .t_unknown } } }
		ast.node_expr_const {
			match node.name.to_lower() {
				'true', 'false' { return VarType{ tag: .t_bool } }
				'null' { return VarType{ tag: .t_null } }
				else { return VarType{ tag: .t_unknown } }
			}
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
			left := node.left or { return VarType{ tag: .t_unknown } }
			right := node.right or { return VarType{ tag: .t_unknown } }
			l_t := t.get_expr_type(*left)
			r_t := t.get_expr_type(*right)
			if l_t.tag == .t_string && r_t.tag == .t_string { return VarType{ tag: .t_string } }
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
			escaped := node.value
				.replace('\\', '\\\\')
				.replace('\'', '\\\'')
				.replace('\n', '\\n')
				.replace('\r', '\\r')
				.replace('\t', '\\t')
			return "'${escaped}'"
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true' { t.last_expr_type = VarType{ tag: .t_bool }; return 'true' }
				'false' { t.last_expr_type = VarType{ tag: .t_bool }; return 'false' }
				'null' { t.last_expr_type = VarType{ tag: .t_null }; return 'none' }
				else { return t.visit_expr(node) }
			}
		}
		ast.node_expr_variable {
			typ := t.inferred_types[node.name] or { VarType{ tag: .t_unknown } }
			t.last_expr_type = typ
			// 原生类型参数：直接用参数名，无 var_ 前缀
			if t.native_params[node.name] {
				return node.name
			}
			return 'var_${node.name}'
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
		ast.node_bin_concat {
			left := node.left or { panic('concat missing left') }
			right := node.right or { panic('concat missing right') }
			l_code := t.visit_expr_native(*left)
			r_code := t.visit_expr_native(*right)
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
			escaped := node.value
				.replace('\\', '\\\\')
				.replace('\'', '\\\'')
				.replace('\n', '\\n')
				.replace('\r', '\\r')
				.replace('\t', '\\t')
			t.last_expr_type = VarType{ tag: .t_string }
			return "'${escaped}'"
		}
		ast.node_expr_property_fetch {
			// 原生属性访问：返回原生字段值（非 PhpVal）
			obj_var_node := node.var or { return t.visit_expr(node) }
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					prop_type := t.get_class_prop_type(obj_type.class_name, node.name)
					if prop_type.is_scalar() {
						field_name := prop_v_name(node.name)
						t.last_expr_type = prop_type
						if obj_var_node.name == 'this' {
							return 'this.${field_name}'
						}
						obj_var_name := t.visit_expr(*obj_var_node)
						return '${obj_var_name}.${field_name}'
					}
				}
			}
			return t.visit_expr(node)
		}
		ast.node_expr_method_call {
			// 已知对象类型的方法调用 → 直接生成原生调用
			obj_var_node := node.var or { return t.visit_expr(node) }
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					obj_var_name := t.visit_expr(*obj_var_node)
					method_name := node.name
					mut arg_strs := []string{}
					for arg in node.args {
						arg_val := arg.expr or { panic('Arg missing expr') }
						arg_str := t.visit_expr(*arg_val)
						arg_strs << arg_str
					}
					ret_type := t.get_method_return_type(obj_type.class_name, method_name)
					t.last_expr_type = ret_type
					return '${obj_var_name}.${method_v_name(method_name)}(${arg_strs.join(", ")})'
				}
			}
			return t.visit_expr(node)
		}
		else {
			return t.visit_expr(node)
		}
	}
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
			inner := t.emit_native_condition(*expr_node)
			if inner != '' { return '!(${inner})' }
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
		else { return '' }
	}
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
				escaped := part.value
					.replace('\\', '\\\\')
					.replace('"', '\\"')
					.replace('\n', '\\n')
					.replace('\r', '\\r')
					.replace('\t', '\\t')
					.replace('\$', '\\$')
				interp_parts << escaped
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
			// 如果表达式是已知类型的对象变量（现在是 struct 指针），需要包装为 PhpVal
			if expr_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[expr_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					expr_str := t.visit_expr(*expr_node)
					return 'rt.new_bool(rt.instance_of(rt.new_object(\'${obj_type.class_name}\', ${t.get_parents_expr(obj_type.class_name)}, ${expr_str}), \'${resolved_class}\'))'
				}
			}
			expr_str := t.visit_expr(*expr_node)
			return 'rt.new_bool(rt.instance_of(${expr_str}, \'${resolved_class}\'))'
		}
		ast.node_expr_variable {
			if node.name in ['_GET', '_POST', '_SERVER', '_COOKIE', '_SESSION', '_REQUEST', '_ENV'] {
				t.last_expr_type = VarType{ tag: .t_unknown }
				return 'rt.get_superglobal(\'${node.name}\')'
			}
			typ := t.inferred_types[node.name] or { VarType{ tag: .t_unknown } }
			t.last_expr_type = typ
			// P7 Task 8: 原生类型参数（native_params）直接用参数名，无 var_ 前缀，无装箱
			if t.native_params[node.name] {
				return node.name
			}
			match typ.tag {
				.t_int { return 'rt.new_int(var_${node.name})' }
				.t_float { return 'rt.new_float(var_${node.name})' }
				.t_bool { return 'rt.new_bool(var_${node.name})' }
				.t_string { return 'rt.new_string(var_${node.name})' }
				else { return 'var_${node.name}' }
			}
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
			escaped := node.value
				.replace('\\', '\\\\')
				.replace('\'', '\\\'')
				.replace('\n', '\\n')
				.replace('\r', '\\r')
				.replace('\t', '\\t')
			t.last_expr_type = VarType{ tag: .t_string }
			return 'rt.new_string(\'${escaped}\')'
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true' { t.last_expr_type = VarType{ tag: .t_bool }; return 'rt.new_bool(true)' }
				'false' { t.last_expr_type = VarType{ tag: .t_bool }; return 'rt.new_bool(false)' }
				'null' { t.last_expr_type = VarType{ tag: .t_null }; return 'rt.new_null()' }
				else { t.last_expr_type = VarType{ tag: .t_unknown }; return 'rt.get_constant(\'${node.name}\')' }
			}
		}
		ast.node_scalar_magic_const_dir {
			dir_path := os.dir(os.real_path(t.current_file))
			escaped := dir_path.replace('\\', '\\\\').replace('\'', '\\\'')
			return 'rt.new_string(\'${escaped}\')'
		}
		ast.node_scalar_magic_const_file {
			file_path := os.real_path(t.current_file)
			escaped := file_path.replace('\\', '\\\\').replace('\'', '\\\'')
			return 'rt.new_string(\'${escaped}\')'
		}
		ast.node_scalar_magic_const_line {
			return 'rt.new_int(${node.line})'
		}
		ast.node_expr_assign {
			var_node := node.var or { panic('Assign node missing var') }
			
			if var_node.node_type == ast.node_expr_array_dim_fetch {
				arr_var_node := var_node.var or { panic('ArrayDimFetch missing var') }
				arr_var_name := t.visit_expr(*arr_var_node)
				
				expr_node := node.expr or { panic('Assign node missing expr') }
				mut expr_str := t.visit_expr(*expr_node)
				if expr_node.node_type == ast.node_expr_variable {
					expr_str += '.dup()'
				}
				
				if dim_node := var_node.dim {
					dim_str := t.visit_expr(*dim_node)
					return '${arr_var_name}.array_set(${dim_str}, ${expr_str})'
				} else {
					return '${arr_var_name}.array_push(${expr_str})'
				}
			}
			
			if var_node.node_type == ast.node_expr_property_fetch {
				obj_var_node := var_node.var or { panic('PropertyFetch missing var') }
				prop_name := var_node.name

				expr_node := node.expr or { panic('Assign node missing expr') }

				// P7 Task 8/10: 已知对象类型 + 原生属性 → 直连赋值
				if obj_var_node.node_type == ast.node_expr_variable {
					obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
					if obj_type.is_object() {
						prop_type := t.get_class_prop_type(obj_type.class_name, prop_name)
						if prop_type.is_scalar() {
							field_name := prop_v_name(prop_name)
							mut rhs := ''
							if expr_node.node_type == ast.node_expr_variable {
								// 变量 RHS：用 visit_expr，按类型匹配/拆箱
								rhs = t.visit_expr(*expr_node)
								src_type := t.inferred_types[expr_node.name] or { VarType{ tag: .t_unknown } }
								if src_type.tag == prop_type.tag {
									// 类型匹配：直接赋值
								} else if src_type.tag == .t_unknown {
									// 未知类型参数（var_xxx rt.PhpVal）：拆箱
									match prop_type.tag {
										.t_string { rhs = '${rhs}.to_string()' }
										.t_int { rhs = '${rhs}.to_int()' }
										.t_float { rhs = '${rhs}.to_float()' }
										.t_bool { rhs = '${rhs}.is_true()' }
										else {}
									}
								}
							} else {
								// 非变量 RHS（字面量、表达式等）：用 native 表达式
								rhs = t.visit_expr_native(*expr_node)
							}
							if obj_var_node.name == 'this' {
								return 'this.${field_name} = ${rhs}'
							} else {
								external_name := t.visit_expr(*obj_var_node)
								return '${external_name}.${field_name} = ${rhs}'
							}
						}
					}
				}

				// 回退： set_property / dispatch_set_prop
				if obj_var_node.name == 'this' {
					// $this 属性赋值：直接调用 dispatch_set_prop
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
										result = 'var_${var_name} = var_${inc_var.name}'
									} else {
										t.scope.declare(var_name)
										result = 'mut var_${var_name} := var_${inc_var.name}'
									}
									t.post_stmts << 'var_${inc_var.name} ${op}'
								} else {
									// $b = ++$a: 先自增，再赋值新值
									t.pre_stmts << 'var_${inc_var.name} ${op}'
									if t.scope.has_var(var_name) {
										result = 'var_${var_name} = var_${inc_var.name}'
									} else {
										t.scope.declare(var_name)
										result = 'mut var_${var_name} := var_${inc_var.name}'
									}
								}
								return result
							}
						}
					}
				}
			}
			
			var_type := t.inferred_types[var_name] or { VarType{ tag: .t_unknown } }
			if var_type.is_scalar() {
				expr_str := t.visit_expr_native(*expr_node)
				if t.scope.has_var(var_name) {
					return 'var_${var_name} = ${expr_str}'
				} else {
					t.scope.declare(var_name)
					return 'mut var_${var_name} := ${expr_str}'
				}
			} else {
				mut expr_str := t.visit_expr(*expr_node)
				// P10: 仅为被原地修改的变量生成 .dup()
				if expr_node.node_type == ast.node_expr_variable && t.mutated_vars[expr_node.name] {
					expr_str += '.dup()'
				}
				
				if t.scope.has_var(var_name) {
					return 'var_${var_name} = ${expr_str}'
				} else {
					t.scope.declare(var_name)
					return 'mut var_${var_name} := ${expr_str}'
				}
			}
		}
		ast.node_expr_funccall {
			mut arg_strs := []string{}
			for arg in node.args {
				arg_val := arg.expr or { panic('Arg missing expr') }
				arg_str := t.visit_expr(*arg_val)
				if arg_val.node_type == ast.node_expr_variable {
					arg_strs << '${arg_str}.dup()'
				} else {
					arg_strs << arg_str
				}
			}
			
			if callable_expr_node := node.expr {
				if voidptr(callable_expr_node) != 0 {
					t.needs_closure_dispatch = true
					callable_expr := t.visit_expr(*callable_expr_node)
					if arg_strs.len == 0 {
						return 'call_closure(${callable_expr}, []rt.PhpVal{})'
					} else {
						return 'call_closure(${callable_expr}, [${arg_strs.join(", ")}])'
					}
				}
			}
			
			func_name := node.name
			if func_name in t.custom_functions {
				return 'func_${func_name}(${arg_strs.join(", ")})'
			} else {
				// VLib 内置函数映射：转译阶段内联，消除运行时字符串 dispatch
				builtin := t.try_builtin_mapping(func_name, arg_strs)
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
			if l_type.tag == .t_string && r_type.tag == .t_string {
				// 原生字符串拼接：使用 V 的 + 运算符
				t.last_expr_type = VarType{ tag: .t_string }
				l_code := t.visit_expr_native(*left)
				r_code := t.visit_expr_native(*right)
				return '${l_code} + ${r_code}'
			}
			return 'rt.concat(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_greater {
			left := node.left or { panic('greater missing left') }
			right := node.right or { panic('greater missing right') }
			return 'rt.greater(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_smaller {
			left := node.left or { panic('smaller missing left') }
			right := node.right or { panic('smaller missing right') }
			return 'rt.less(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_greater_equal {
			left := node.left or { panic('greater_equal missing left') }
			right := node.right or { panic('greater_equal missing right') }
			return 'rt.greater_equal(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_smaller_equal {
			left := node.left or { panic('smaller_equal missing left') }
			right := node.right or { panic('smaller_equal missing right') }
			return 'rt.less_equal(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_equal {
			left := node.left or { panic('equal missing left') }
			right := node.right or { panic('equal missing right') }
			return 'rt.equal(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_identical {
			left := node.left or { panic('identical missing left') }
			right := node.right or { panic('identical missing right') }
			return 'rt.identical(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_expr_boolean_not {
			expr_node := node.expr or { panic('BooleanNot missing expr') }
			return 'rt.new_bool(!rt.is_true(${t.visit_expr(*expr_node)}))'
		}
		ast.node_bin_bool_and, ast.node_bin_logical_and {
			left := node.left or { panic('and missing left') }
			right := node.right or { panic('and missing right') }
			return 'rt.new_bool(rt.is_true(${t.visit_expr(*left)}) && rt.is_true(${t.visit_expr(*right)}))'
		}
		ast.node_bin_bool_or, ast.node_bin_logical_or {
			left := node.left or { panic('or missing left') }
			right := node.right or { panic('or missing right') }
			return 'rt.new_bool(rt.is_true(${t.visit_expr(*left)}) || rt.is_true(${t.visit_expr(*right)}))'
		}
		ast.node_expr_ternary {
			cond := node.cond or { panic('Ternary missing cond') }
			cond_str := t.visit_expr(*cond)
			if if_node := node.@if {
				else_node := node.@else or { panic('Ternary missing else') }
				return 'if rt.is_true(${cond_str}) { ${t.visit_expr(*if_node)} } else { ${t.visit_expr(*else_node)} }'
			} else {
				else_node := node.@else or { panic('Ternary missing else') }
				return 'if rt.is_true(${cond_str}) { ${cond_str} } else { ${t.visit_expr(*else_node)} }'
			}
		}
		ast.node_bin_coalesce {
			left := node.left or { panic('Coalesce missing left') }
			right := node.right or { panic('Coalesce missing right') }
			left_str := t.visit_expr(*left)
			return 'if !(${left_str}).is_null() { ${left_str} } else { ${t.visit_expr(*right)} }'
		}
		ast.node_bin_bitwise_and {
			left := node.left or { panic('BitwiseAnd missing left') }
			right := node.right or { panic('BitwiseAnd missing right') }
			return 'rt.bitwise_and(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_bitwise_or {
			left := node.left or { panic('BitwiseOr missing left') }
			right := node.right or { panic('BitwiseOr missing right') }
			return 'rt.bitwise_or(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_bitwise_xor {
			left := node.left or { panic('BitwiseXor missing left') }
			right := node.right or { panic('BitwiseXor missing right') }
			return 'rt.bitwise_xor(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_shift_left {
			left := node.left or { panic('ShiftLeft missing left') }
			right := node.right or { panic('ShiftLeft missing right') }
			return 'rt.shift_left(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_shift_right {
			left := node.left or { panic('ShiftRight missing left') }
			right := node.right or { panic('ShiftRight missing right') }
			return 'rt.shift_right(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_expr_bitwise_not {
			expr_node := node.expr or { panic('BitwiseNot missing expr') }
			return 'rt.bitwise_not(${t.visit_expr(*expr_node)})'
		}

		ast.node_expr_array {
			mut item_strs := []string{}
			for item in node.items {
				val_node := item.expr or { panic('ArrayItem missing expr') }
				val_str := t.visit_expr(*val_node)
				if key_node := item.key {
					key_str := t.visit_expr(*key_node)
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
			var_str := t.visit_expr(*var_node)
			if dim_node := node.dim {
				dim_str := t.visit_expr(*dim_node)
				return '${var_str}.array_get(${dim_str})'
			} else {
				panic('ArrayDimFetch missing dim in read context')
			}
		}
		ast.node_expr_new {
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
			return 'create_${class_name.to_lower()}(${arg_strs.join(", ")})'
		}
		ast.node_expr_method_call {
			obj_var_node := node.var or { panic('MethodCall missing var') }
			obj_var_name := t.visit_expr(*obj_var_node)
			method_name := node.name

			// P7 Task 10: 已知对象类型 → 直接调用方法（无 IIFE）
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					// 构建参数列表，按目标方法参数类型自动装箱/拆箱
					mut arg_strs := []string{}
					for i, arg in node.args {
						arg_val := arg.expr or { panic('Arg missing expr') }
						arg_type := t.get_expr_type(*arg_val)
						// 查找目标方法对应参数的类型
						mut target_param_type := VarType{ tag: .t_unknown }
						if obj_type.is_object() && i < node.args.len {
							// 尝试按顺序查找参数类型（通过 param_types map）
							if params_map := t.param_types_for_method(obj_type.class_name, method_name) {
								for pname, ptype in params_map {
									_ = pname
									target_param_type = ptype
									break
								}
							}
						}
						// 根据目标参数类型决定传递方式
						mut arg_str := if target_param_type.is_scalar() && arg_type.is_scalar() {
							// 目标期望原生类型，源也是原生类型 → 直接传递
							t.visit_expr_native(*arg_val)
						} else if target_param_type.is_scalar() && !arg_type.is_scalar() {
							// 目标期望原生类型，源是 PhpVal → 拆箱
							raw := t.visit_expr(*arg_val)
							match target_param_type.tag {
								.t_string { '${raw}.to_string()' }
								.t_int { '${raw}.to_int()' }
								.t_float { '${raw}.to_float()' }
								.t_bool { '${raw}.is_true()' }
								else { raw }
							}
						} else if !target_param_type.is_scalar() && arg_type.is_scalar() {
							// 目标期望 PhpVal，源是原生类型 → 装箱
							native_val := t.visit_expr_native(*arg_val)
							match arg_type.tag {
								.t_string { 'rt.new_string(${native_val})' }
								.t_int { 'rt.new_int(${native_val})' }
								.t_float { 'rt.new_float(${native_val})' }
								.t_bool { 'rt.new_bool(${native_val})' }
								else { native_val }
							}
						} else {
							// 目标期望 PhpVal 或类型未知 → 直接传递
							t.visit_expr(*arg_val)
						}
						// 如果源参数是未知类型的变量，需要 .dup()（原生参数除外）
						if arg_val.node_type == ast.node_expr_variable {
							src_type := t.inferred_types[arg_val.name] or { VarType{ tag: .t_unknown } }
							if src_type.tag == .t_unknown && !target_param_type.is_scalar() && !t.native_params[arg_val.name] {
								arg_str += '.dup()'
							}
						}
						arg_strs << arg_str
						_ = i
					}
					args_joined := arg_strs.join(', ')
					// 如果对象就是 this，直接调用
					if obj_var_node.name == 'this' {
						return 'this.${method_v_name(method_name)}(${args_joined})'
					}
					// 外部对象已知类型 → 直接调用方法（无需 IIFE 包装）
					call_expr := '${obj_var_name}.${method_v_name(method_name)}(${args_joined})'
					return call_expr
				}
			}
			// 回退: call_method
			t.needs_method_dispatch = true
			mut arg_strs := []string{}
			for arg in node.args {
				arg_val := arg.expr or { panic('Arg missing expr') }
				arg_str := t.visit_expr(*arg_val)
				if arg_val.node_type == ast.node_expr_variable {
					arg_strs << '${arg_str}.dup()'
				} else {
					arg_strs << arg_str
				}
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
			// P7 Task 8/10: 已知对象类型 + 原生属性 → 直接访问
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					prop_type := t.get_class_prop_type(obj_type.class_name, prop_name)
					if prop_type.is_scalar() {
						field_name := prop_v_name(prop_name)
						// $this->prop 内部直接 this.field
						if obj_var_node.name == 'this' {
							return 'this.${field_name}'
						}
						// 外部变量是 &Class_Xxx 结构体指针，直接访问字段并装箱
						match prop_type.tag {
							.t_string { return 'rt.new_string(${obj_var_name}.${field_name})' }
							.t_int { return 'rt.new_int(${obj_var_name}.${field_name})' }
							.t_float { return 'rt.new_float(${obj_var_name}.${field_name})' }
							.t_bool { return 'rt.new_bool(${obj_var_name}.${field_name})' }
							else { return '${obj_var_name}.${field_name}' }
						}
					} else {
						// PhpVal 属性
						if obj_var_node.name == 'this' {
							return 'this.prop_${prop_name}'
						}
						// 外部变量：通过 dispatch_get_prop 访问
						return '${obj_var_name}.dispatch_get_prop(\'${prop_name}\') or { rt.new_null() }'
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
			return 'class_${cls.to_lower()}_${node.name.to_lower()}'
		}

		ast.node_expr_closure {
			t.needs_closure_dispatch = true

			t.closure_count++
			class_name := 'Closure_${t.closure_count}'
			t.closure_names << class_name
			
			mut captured_vars := []string{}
			mut captured_types := map[string]VarType{}
			for use_node in node.uses {
				use_var := use_node.var or { continue }
				captured_vars << use_var.name
				// 在进入闭包作用域前，先保存捕获变量的类型
				captured_types[use_var.name] = t.inferred_types[use_var.name] or { VarType{ tag: .t_unknown } }
			}
			
			t.closures_code.writeln('struct ${class_name} {')
			t.closures_code.writeln('\trt.PhpObjectBase')
			t.closures_code.writeln('pub mut:')
			for var_name in captured_vars {
				t.closures_code.writeln('\tprop_${var_name} rt.PhpVal')
			}
			t.closures_code.writeln('}')
			t.closures_code.writeln('')
			
			old_is_in_closure := t.is_in_closure
			t.is_in_closure = true
			old_indent := t.indent
			t.indent = 0
			old_scope := t.scope
			t.scope = VarScope.new()
			
			mut param_names := []string{}
			for param in node.params {
				param_var := param.var or { panic('Param missing var') }
				param_name := param_var.name
				t.scope.declare(param_name)
				param_names << param_name
			}
			
			t.write_indent()
			t.write_line('fn (mut this ${class_name}) invoke(args []rt.PhpVal) rt.PhpVal {')
			t.indent++
			
			for i, param_name in param_names {
				t.write_indent()
				t.write_line('mut var_${param_name} := if args.len > ${i} { args[${i}].dup() } else { rt.new_null() }')
			}
			
			for var_name in captured_vars {
				t.scope.declare(var_name)
				// 闭包内捕获变量统一为 PhpVal，清除原生类型推断
				t.inferred_types.delete(var_name)
				t.write_indent()
				t.write_line('mut var_${var_name} := this.prop_${var_name}.dup()')
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
			
			t.indent--
			t.write_indent()
			t.write_line('}')
			t.write_line('')
			
			t.is_in_closure = old_is_in_closure
			t.indent = old_indent
			t.scope = old_scope
			// 恢复闭包捕获变量的类型推断（闭包内已清除为 PhpVal）
			for var_name in captured_vars {
				if ct := captured_types[var_name] {
					t.inferred_types[var_name] = ct
				}
			}
			
			mut init_fields := []string{}
			for var_name in captured_vars {
				cap_typ := captured_types[var_name] or { VarType{ tag: .t_unknown } }
				if cap_typ.is_scalar() {
					// 原生类型变量捕获时需装箱为 PhpVal
					match cap_typ.tag {
						.t_int { init_fields << 'prop_${var_name}: rt.new_int(var_${var_name})' }
						.t_float { init_fields << 'prop_${var_name}: rt.new_float(var_${var_name})' }
						.t_string { init_fields << 'prop_${var_name}: rt.new_string(var_${var_name})' }
						.t_bool { init_fields << 'prop_${var_name}: rt.new_bool(var_${var_name})' }
						else { init_fields << 'prop_${var_name}: var_${var_name}.dup()' }
					}
				} else {
					if t.mutated_vars[var_name] {
						init_fields << 'prop_${var_name}: var_${var_name}.dup()'
					} else {
						init_fields << 'prop_${var_name}: var_${var_name}'
					}
				}
			}
			return 'rt.new_object(\'${class_name}\', [\'Closure\'], &${class_name}{ ${init_fields.join(", ")} })'
		}
		ast.node_expr_arrow_function {
			t.needs_closure_dispatch = true
			t.closure_count++
			class_name := 'Closure_${t.closure_count}'
			t.closure_names << class_name
			
			mut captured_vars := []string{}
			mut captured_types := map[string]VarType{}
			expr_node := node.expr or { panic('ArrowFunction missing expr') }
			
			mut param_names := []string{}
			for param in node.params {
				param_var := param.var or { panic('Param missing var') }
				param_names << param_var.name
			}
			
			t.find_captured_vars_rec(*expr_node, param_names, mut captured_vars)
			// 在进入闭包作用域前，先保存捕获变量的类型
			for var_name in captured_vars {
				captured_types[var_name] = t.inferred_types[var_name] or { VarType{ tag: .t_unknown } }
			}
			
			t.closures_code.writeln('struct ${class_name} {')
			t.closures_code.writeln('\trt.PhpObjectBase')
			t.closures_code.writeln('pub mut:')
			for var_name in captured_vars {
				t.closures_code.writeln('\tprop_${var_name} rt.PhpVal')
			}
			t.closures_code.writeln('}')
			t.closures_code.writeln('')
			
			old_is_in_closure := t.is_in_closure
			t.is_in_closure = true
			old_indent := t.indent
			t.indent = 0
			old_scope := t.scope
			t.scope = VarScope.new()
			
			for param_name in param_names {
				t.scope.declare(param_name)
			}
			
			t.write_indent()
			t.write_line('fn (mut this ${class_name}) invoke(args []rt.PhpVal) rt.PhpVal {')
			t.indent++
			
			for i, param_name in param_names {
				t.write_indent()
				t.write_line('mut var_${param_name} := if args.len > ${i} { args[${i}].dup() } else { rt.new_null() }')
			}
			
			for var_name in captured_vars {
				t.scope.declare(var_name)
				// 闭包内捕获变量统一为 PhpVal，清除原生类型推断
				t.inferred_types.delete(var_name)
				t.write_indent()
				t.write_line('mut var_${var_name} := this.prop_${var_name}.dup()')
			}
			
			expr_str := t.visit_expr(*expr_node)
			t.write_indent()
			t.write_line('return ${expr_str}')
			
			t.indent--
			t.write_indent()
			t.write_line('}')
			t.write_line('')
			
			t.is_in_closure = old_is_in_closure
			t.indent = old_indent
			t.scope = old_scope
			// 恢复闭包捕获变量的类型推断（闭包内已清除为 PhpVal）
			for var_name in captured_vars {
				if ct := captured_types[var_name] {
					t.inferred_types[var_name] = ct
				}
			}
			
			mut init_fields := []string{}
			for var_name in captured_vars {
				cap_typ := captured_types[var_name] or { VarType{ tag: .t_unknown } }
				if cap_typ.is_scalar() {
					match cap_typ.tag {
						.t_int { init_fields << 'prop_${var_name}: rt.new_int(var_${var_name})' }
						.t_float { init_fields << 'prop_${var_name}: rt.new_float(var_${var_name})' }
						.t_string { init_fields << 'prop_${var_name}: rt.new_string(var_${var_name})' }
						.t_bool { init_fields << 'prop_${var_name}: rt.new_bool(var_${var_name})' }
						else { init_fields << 'prop_${var_name}: var_${var_name}.dup()' }
					}
				} else {
					if t.mutated_vars[var_name] {
						init_fields << 'prop_${var_name}: var_${var_name}.dup()'
					} else {
						init_fields << 'prop_${var_name}: var_${var_name}'
					}
				}
			}
			return 'rt.new_object(\'${class_name}\', [\'Closure\'], &${class_name}{ ${init_fields.join(", ")} })'
		}
		ast.node_expr_include {
			path_node := node.expr or { panic('Include missing expr') }
			if voidptr(path_node) != 0 {
				path_str := t.visit_expr(*path_node)
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
					arg_type := t.get_expr_type(*arg_val)
					mut target_type := VarType{ tag: .t_unknown }
					if i < parent_param_types.len {
						target_type = parent_param_types[i]
					}
					mut arg_str := ''
					if target_type.is_scalar() && arg_type.is_scalar() {
						arg_str = t.visit_expr_native(*arg_val)
					} else if target_type.is_scalar() && !arg_type.is_scalar() {
						raw := t.visit_expr(*arg_val)
						match target_type.tag {
							.t_string { arg_str = '${raw}.to_string()' }
							.t_int { arg_str = '${raw}.to_int()' }
							.t_float { arg_str = '${raw}.to_float()' }
							.t_bool { arg_str = '${raw}.is_true()' }
							else { arg_str = raw }
						}
					} else if !target_type.is_scalar() && arg_type.is_scalar() {
						native_val := t.visit_expr_native(*arg_val)
						match arg_type.tag {
							.t_string { arg_str = 'rt.new_string(${native_val})' }
							.t_int { arg_str = 'rt.new_int(${native_val})' }
							.t_float { arg_str = 'rt.new_float(${native_val})' }
							.t_bool { arg_str = 'rt.new_bool(${native_val})' }
							else { arg_str = native_val }
						}
					} else {
						arg_str = t.visit_expr(*arg_val)
						if arg_val.node_type == ast.node_expr_variable && !t.native_params[arg_val.name] {
							arg_str += '.dup()'
						}
					}
					arg_strs << arg_str
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
				
				if target_type.is_scalar() {
					// 目标参数是原生类型，需要解包
					if arg_type.is_scalar() {
						// 实参已经是原生类型，直接使用
						arg_str = t.visit_expr_native(*arg_val)
						formal_type = target_type.to_v_type()
						call_expr = 'arg_${i}'
					} else {
						// 实参是 PhpVal，需要解包
						raw := t.visit_expr(*arg_val)
						match target_type.tag {
							.t_string { 
								arg_str = '${raw}.to_string()'
								formal_type = 'rt.PhpVal'
								call_expr = '${raw}.to_string()'
							}
							.t_int { 
								arg_str = '${raw}.to_int()'
								formal_type = 'rt.PhpVal'
								call_expr = '${raw}.to_int()'
							}
							.t_float { 
								arg_str = '${raw}.to_float()'
								formal_type = 'rt.PhpVal'
								call_expr = '${raw}.to_float()'
							}
							.t_bool { 
								arg_str = '${raw}.is_true()'
								formal_type = 'rt.PhpVal'
								call_expr = '${raw}.is_true()'
							}
							else { 
								arg_str = raw
								call_expr = raw
							}
						}
					}
				} else {
					// 目标参数是 PhpVal
					if arg_type.is_scalar() {
						// 实参是原生类型，需要装箱
						native_val := t.visit_expr_native(*arg_val)
						match arg_type.tag {
							.t_string { arg_str = 'rt.new_string(${native_val})' }
							.t_int { arg_str = 'rt.new_int(${native_val})' }
							.t_float { arg_str = 'rt.new_float(${native_val})' }
							.t_bool { arg_str = 'rt.new_bool(${native_val})' }
							else { arg_str = native_val }
						}
					} else {
						// 实参已经是 PhpVal
						arg_str = t.visit_expr(*arg_val)
						if arg_val.node_type == ast.node_expr_variable && !t.native_params[arg_val.name] {
							arg_str += '.dup()'
						}
					}
					call_expr = 'arg_${i}'
				}
				
				arg_strs << arg_str
				arg_formals << 'arg_${i} ${formal_type}'
				arg_calls << call_expr
			}
			
			if arg_strs.len == 0 {
				return 'fn () rt.PhpVal { mut temp := Class_${class_name}{}; return temp.${method_v_name(node.name)}() }()'
			} else {
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
			escaped := node.value
				.replace('\\', '\\\\')
				.replace('\'', '\\\'')
				.replace('\n', '\\n')
				.replace('\r', '\\r')
				.replace('\t', '\\t')
			return 'rt.new_string(\'${escaped}\')'
		}
		ast.node_expr_empty {
			expr_node := node.expr or { panic('Empty missing expr') }
			expr_str := t.visit_expr(*expr_node)
			return 'rt.new_bool(!rt.is_true(${expr_str}))'
		}
		else {
			return '// unsupported expression: ${node.node_type}'
		}
	}
}

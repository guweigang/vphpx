module emitter

import ast

fn (mut t Transpiler) visit_stmt(node ast.AstNode) {
	t.active_depth++
	if t.active_depth > 100 {
		t.active_depth--
		return
	}
	match node.node_type {
		ast.node_stmt_echo {
			t.visit_echo(node)
		}
		ast.node_stmt_expression {
			if expr := node.expr {
				// 拦截并原生化全局 define 常量
				if expr.node_type == ast.node_expr_funccall && expr.name == 'define' {
					if expr.args.len >= 2 {
						name_node := expr.args[0].expr or { panic('define missing name') }
						if name_node.node_type == ast.node_scalar_string {
							if gc := t.global_constants[name_node.value] {
								val_node := expr.args[1].expr or { panic('define missing val') }
								val_str := t.visit_expr_native(*val_node)
								t.const_out.writeln('const ${gc.name} = ${val_str}')
								// 刷新副作用语句后返回
								if t.post_stmts.len > 0 {
									for s in t.post_stmts {
										t.write_indent()
										t.write_line(s)
									}
									t.post_stmts.clear()
								}
								return
							}
						}
					}
				}
				// 原生 int 变量的独立自增/自减语句优化
				if t.try_emit_native_incdec(*expr) {
					// 已处理
				} else {
					expr_str := t.visit_expr(*expr)
					// 跳过纯变量名（声明已提取到 pre_stmts）
					is_bare_var := expr_str.starts_with('var_') && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
					// 跳过 _mutated / _shadow 后缀的裸变量引用
					is_bare_mutated := (expr_str.ends_with('_mutated') || expr_str.ends_with('_shadow')) && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
					// 跳过 IIFE 结果变量（实际调用已在 pre_stmts 中完成）
					is_bare_iife := expr_str.starts_with('iife_result_') && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
					if !is_bare_var && !is_bare_iife && !is_bare_mutated {
						// 函数/方法调用等返回值的表达式作为语句时，需 _ = 丢弃返回值
						if t.expr_produces_value(*expr) {
							lines := expr_str.split('\n')
							for i, line in lines {
								t.write_indent()
								if i == 0 {
									t.write_line('_ = ${line}')
								} else {
									t.write_line(line)
								}
							}
						} else {
							for line in expr_str.split('\n') {
								t.write_indent()
								t.write_line(line)
							}
						}
					}
				}
				// 刷新赋值后的副作用语句
				if t.post_stmts.len > 0 {
					for s in t.post_stmts {
						t.write_indent()
						t.write_line(s)
					}
					t.post_stmts.clear()
				}
			}
		}

		ast.node_stmt_if {
			t.visit_if(node)
		}
		ast.node_stmt_function {
			t.visit_function(node)
		}
		ast.node_stmt_return {
			t.visit_return(node)
		}
		ast.node_stmt_foreach {
			t.visit_foreach(node)
		}
		ast.node_stmt_while {
			t.visit_while(node)
		}
		ast.node_stmt_do {
			t.visit_do(node)
		}

		ast.node_stmt_for {
			t.visit_for(node)
		}
		ast.node_stmt_class {
			t.visit_class(node)
		}
		ast.node_stmt_break {
			if !t.is_in_switch {
				t.write_indent()
				t.write_line('break')
			}
		}
		ast.node_stmt_continue {
			t.write_indent()
			t.write_line('continue')
		}
		ast.node_stmt_const {
			t.visit_const(node)
		}
		ast.node_stmt_try_catch {
			t.visit_try_catch(node)
		}
		ast.node_stmt_switch {
			t.visit_switch(node)
		}

		ast.node_stmt_namespace {
			old_ns := t.current_namespace
			t.current_namespace = node.name
			for stmt in node.stmts {
				t.visit_stmt(stmt)
			}
			t.current_namespace = old_ns
		}
		ast.node_stmt_use {
			for u in node.uses {
				mut alias := u.alias
				if alias == '' {
					parts := u.name.split('\\')
					alias = parts[parts.len - 1]
				}
				t.use_aliases[alias] = u.name
			}
		}
		ast.node_stmt_unset {
			for v in node.vars {
				if v.node_type == ast.node_expr_array_dim_fetch {
					arr_node := v.var or { panic('Unset array dim missing var') }
					dim_node := v.dim or { panic('Unset array dim missing dim') }
					arr_type := t.get_expr_type(*arr_node)
					arr_str := t.visit_expr(*arr_node)
					t.write_indent()
					if arr_type.is_native_map {
						dim_str_native := t.visit_expr_native(*dim_node)
						t.write_line('${arr_str}.delete(${dim_str_native})')
					} else {
						dim_str := t.visit_expr(*dim_node)
						t.write_line('${arr_str}.array_unset(${dim_str})')
					}
				} else if v.node_type == ast.node_expr_variable {
					typ := t.inferred_types[v.name] or { VarType{ tag: .t_unknown } }
					t.write_indent()
					match typ.tag {
						.t_int { t.write_line('var_${v.name} = 0') }
						.t_float { t.write_line('var_${v.name} = 0.0') }
						.t_string { t.write_line("var_${v.name} = ''") }
						.t_bool { t.write_line('var_${v.name} = false') }
						else {
							var_str := t.visit_expr(v)
							t.write_line('${var_str} = rt.new_null()')
						}
					}
				} else {
					var_str := t.visit_expr(v)
					t.write_indent()
					t.write_line('${var_str} = rt.new_null()')
				}
			}
		}
		ast.node_stmt_interface {
			// 生成 V 原生 interface 定义（顶层）
			old_is_in_func := t.is_in_func
			t.is_in_func = true
			t.write_line('interface ${node.name} {')
			t.indent++
			for stmt in node.stmts {
				if stmt.node_type == ast.node_stmt_class_method {
					// 收集参数
					mut param_strs := []string{}
					for param in stmt.params {
						param_name := param.name
						// 接口方法参数使用 PhpVal 类型（因为无法推断）
						param_strs << '${param_name} rt.PhpVal'
					}
					params_str := if param_strs.len > 0 { param_strs.join(', ') } else { '' }
					t.write_indent()
					t.write_line('${method_v_name(stmt.name)}(${params_str}) rt.PhpVal')
				}
			}
			t.indent--
			t.write_line('}')
			t.write_line('')
			t.is_in_func = old_is_in_func
		}
		ast.node_stmt_global {
			for v in node.vars {
				var_name := v.name
				v_var := t.get_v_var_name(var_name)
				if !t.scope.has_var(var_name) {
					t.scope.declare(var_name)
					t.write_indent()
					t.write_line('mut ${v_var} := rt.get_superglobal(\'${var_name}\')')
				}
			}
		}
		ast.node_stmt_nop {
			// PHP 的空语句（如单独的分号），无需生成代码
		}
		ast.node_stmt_declare {
			// PHP declare() 语句（如 declare(strict_types=1)），V 侧无需处理
		}
		ast.node_stmt_static {
			// PHP static 变量声明，简化为普通局部变量
			for v in node.vars {
				// StaticVar 节点的变量名在 v.var (Expr_Variable) 中
				var_node := v.var or { continue }
				var_name := var_node.name
				v_var := t.get_v_var_name(var_name)
				if !t.scope.has_var(var_name) {
					t.scope.declare(var_name)
					if def := v.default_val {
						def_type := t.get_expr_type(*def)
						if def_type.is_scalar() {
							def_str := t.visit_expr_native(*def)
							t.write_indent()
							t.write_line('mut ${v_var} := ${def_str}')
						} else {
							def_str := t.visit_expr(*def)
							t.write_indent()
							t.write_line('mut ${v_var} := ${def_str}')
						}
					} else {
						t.write_indent()
						t.write_line('mut ${v_var} := rt.new_null()')
					}
				}
			}
		}
		else {
			t.write_indent()
			t.write_line('// unsupported statement: ${node.node_type}')
		}
	}
	
	if t.current_catch_label != '' && node.node_type != ast.node_stmt_return && node.node_type != ast.node_stmt_try_catch {
		t.write_indent()
		t.write_line('if rt.has_exception() { unsafe { goto ${t.current_catch_label} } }')
	}
	t.active_depth--
}

// try_emit_native_incdec 检查是否为原生 int 变量的独立自增/自减语句，并直接生成 V 原生代码
fn (mut t Transpiler) try_emit_native_incdec(expr ast.AstNode) bool {
	incdec_op := match expr.node_type {
		ast.node_expr_post_inc, ast.node_expr_pre_inc { '+= 1' }
		ast.node_expr_post_dec, ast.node_expr_pre_dec { '-= 1' }
		else { '' }
	}
	if incdec_op == '' {
		return false
	}
	var_node := expr.var or { return false }
	if var_node.node_type != ast.node_expr_variable {
		return false
	}
	typ := t.inferred_types[var_node.name] or { VarType{ tag: .t_unknown } }
	if typ.tag != .t_int {
		return false
	}
	t.write_indent()
	t.write_line('var_${var_node.name} ${incdec_op}')
	return true
}

fn (mut t Transpiler) visit_echo(node ast.AstNode) {
	for expr in node.exprs {
		// 字符串字面量 echo 优化：跳过 PhpVal 装箱/拆箱，直接 print
		if expr.node_type == ast.node_scalar_string {
			escaped := escape_single_quoted(expr.value)
			t.write_indent()
			t.write_line('print(\'${escaped}\')')
			continue
		}
		// 原生类型变量 echo 优化：直接 print，避免装箱/拆箱
		if expr.node_type == ast.node_expr_variable {
			typ := t.inferred_types[expr.name] or { VarType{ tag: .t_unknown } }
			if typ.tag == .t_int {
				t.write_indent()
				t.write_line('print(var_${expr.name}.str())')
				continue
			}
			if typ.tag == .t_string {
				t.write_indent()
				t.write_line('print(var_${expr.name})')
				continue
			}
			if typ.tag == .t_bool {
				t.write_indent()
				t.write_line('print(if var_${expr.name} { \'1\' } else { \'\' })')
				continue
			}
		}
		// 原生字符串表达式 echo 优化：concat 等结果为 string 时直接 print
		expr_type := t.get_expr_type(expr)
		if expr_type.tag == .t_string {
			native_str := t.visit_expr_native(expr)
			t.write_indent()
			t.write_line('print(${native_str})')
			continue
		}
		// 原生 int 表达式 echo 优化
		if expr_type.tag == .t_int {
			native_int := t.visit_expr_native(expr)
			t.write_indent()
			t.write_line('print(${native_int}.str())')
			continue
		}
		expr_str := t.visit_expr(expr)
		t.write_indent()
		t.write_line('rt.echo_val(${expr_str})')
	}
}

fn (mut t Transpiler) visit_const(node ast.AstNode) {
	for c in node.consts {
		val_str := t.visit_expr_native(c.value)
		t.const_out.writeln('const global_const_${c.name.to_lower()} = ${val_str}')
	}
}

fn (mut t Transpiler) visit_try_catch(node ast.AstNode) {
	t.try_count++
	my_id := t.try_count
	catch_label := 'catch_label_${my_id}'
	finally_label := 'finally_label_${my_id}'
	end_label := 'end_label_${my_id}'

	old_catch := t.current_catch_label
	old_finally := t.current_finally_label

	t.current_catch_label = catch_label
	t.current_finally_label = finally_label

	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}

	t.write_indent()
	if node.finally != none {
		t.write_line('unsafe { goto ${finally_label} }')
	} else {
		t.write_line('unsafe { goto ${end_label} }')
	}

	t.current_catch_label = old_catch
	t.current_finally_label = old_finally

	t.write_line('')
	t.write_line('${catch_label}:')
	t.write_indent()
	t.write_line('mut var_e_${my_id} := rt.get_and_clear_exception()')

	mut is_first_catch := true
	for c in node.catches {
		mut type_checks := []string{}
		for typ in c.types {
			resolved_type := t.resolve_class_name(typ)
			type_checks << "rt.instance_of(var_e_${my_id}, '${resolved_type}')"
		}
		t.write_indent()
		if type_checks.len > 0 {
			type_expr := type_checks.join(" || ")
			if is_first_catch {
				t.write_string('if ${type_expr} {')
				is_first_catch = false
			} else {
				t.write_string('else if ${type_expr} {')
			}
		} else {
			if is_first_catch {
				t.write_string('if true {')
				is_first_catch = false
			} else {
				t.write_string('else if true {')
			}
		}
		t.write_line('')
		t.indent++

		if var_node := c.var {
			t.write_indent()
			if t.scope.has_var(var_node.name) {
				t.write_line('var_${var_node.name} = var_e_${my_id}.clone()')
			} else {
				t.scope.declare(var_node.name)
				t.write_line('mut var_${var_node.name} := var_e_${my_id}.clone()')
			}
		}

		for catch_stmt in c.stmts {
			t.visit_stmt(catch_stmt)
		}

		t.write_indent()
		if node.finally != none {
			t.write_line('unsafe { goto ${finally_label} }')
		} else {
			t.write_line('unsafe { goto ${end_label} }')
		}
		t.indent--
		t.write_indent()
		t.write_line('}')
	}

	if node.catches.len > 0 {
		t.write_indent()
		t.write_line('else {')
		t.indent++
		t.write_indent()
		t.write_line('rt.throw_exception(var_e_${my_id})')
		t.write_indent()
		if node.finally != none {
			t.write_line('unsafe { goto ${finally_label} }')
		} else {
			t.write_line('unsafe { goto ${end_label} }')
		}
		t.indent--
		t.write_indent()
		t.write_line('}')
	}

	if f_node := node.finally {
		t.write_line('')
		t.write_line('${finally_label}:')
		for f_stmt in f_node.stmts {
			t.visit_stmt(f_stmt)
		}
		t.write_indent()
		if t.current_func_ret_type.tag == .t_void {
			t.write_line('if rt.has_exception() { return }')
		} else {
			t.write_line('if rt.has_exception() { return rt.new_null() }')
		}
	}

	t.write_line('')
	t.write_line('${end_label}:')
}

fn (mut t Transpiler) visit_if(node ast.AstNode) {
	cond_node := node.cond or { panic('If statement missing cond') }
	native_cond := t.emit_native_condition(*cond_node)
	cond_str := if native_cond != '' { native_cond } else { 'rt.is_true(${t.visit_expr(*cond_node)})' }
	// 确保条件表达式不包含换行，否则 { 会跑到下一行
	mut one_line_cond := cond_str
	one_line_cond = one_line_cond.replace('\n', ' ')
	one_line_cond = one_line_cond.replace('\t', ' ')
	one_line_cond = one_line_cond.replace('\r', ' ')

	t.write_indent()
	t.write_string('if ${one_line_cond} {\n')
	
	t.indent++
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}
	t.indent--
	
	// 处理 elseifs
	for elseif_node in node.elseifs {
		elseif_cond := elseif_node.cond or { panic('Elseif statement missing cond') }
		elseif_native := t.emit_native_condition(*elseif_cond)
		elseif_cond_str := if elseif_native != '' { elseif_native } else { 'rt.is_true(${t.visit_expr(*elseif_cond)})' }
		elseif_one_line := elseif_cond_str.replace('\n', ' ').replace('\t', ' ').replace('\r', ' ')

		t.write_indent()
		t.write_line('} else if ${elseif_one_line} {')
		
		t.indent++
		for stmt in elseif_node.stmts {
			t.visit_stmt(stmt)
		}
		t.indent--
	}
	
	// 处理 else
	if else_node := node.@else {
		t.write_indent()
		t.write_line('} else {')
		
		t.indent++
		for stmt in else_node.stmts {
			t.visit_stmt(stmt)
		}
		t.indent--
	}
	
	t.write_indent()
	t.write_line('}')
	t.active_depth--
}

fn (mut t Transpiler) visit_function(node ast.AstNode) {
	t.is_in_func = true
	old_indent := t.indent
	t.indent = 0
	old_scope := t.scope
	t.scope = VarScope.new()

	// 设置当前函数上下文
	old_func_name := t.current_func_name
	old_func_ret := t.current_func_ret_type
	t.current_func_name = node.name
	ret_type := t.func_return_types[node.name] or { VarType{ tag: .t_unknown } }
	t.current_func_ret_type = ret_type

	// 设置当前函数的局部变量类型（供 get_expr_type 使用）
	old_inferred := t.inferred_types.clone()
	if func_vars := t.func_var_types[node.name] {
		for vname, vtype in func_vars {
			t.inferred_types[vname] = vtype
		}
	}

	mut has_variadic_param := false
	mut variadic_param_name := ''

	// 提前收集变量信息，用于判断参数是否需要 _arg 后缀
	ref_vars, ass_vars := t.collect_vars_in_scope(node.stmts)

	mut registered_native_params := []string{}
	mut param_names := []string{}
	for param in node.params {
		param_var := param.var or { panic('Param missing var') }
		param_name := param_var.name
		t.scope.declare(param_name)

		is_param_variadic := (param.variadic == 'true')
		if is_param_variadic {
			has_variadic_param = true
			variadic_param_name = param_name
			param_names << 'var_${param_name}_origin ...rt.PhpVal'
		} else {
			// 检查是否有推断的原生参数类型
			param_type := t.get_func_param_type(node.name, param_name)
			if param_type.is_scalar() {
				param_names << '${param_name} ${param_type.to_v_type()}'
				t.inferred_types[param_name] = param_type
				t.native_params[param_name] = true
				registered_native_params << param_name
				// 同时声明 var_xxx 以便 PHP 变量引用（$leavename → var_leavename）能正确解析
				t.scope.declare('var_${param_name}')
				t.inferred_types['var_${param_name}'] = param_type
				t.native_vars['var_${param_name}'] = true
			} else if param_type.is_object() {
				param_names << 'mut var_${param_name} ${param_type.to_v_type()}'
				t.inferred_types[param_name] = param_type
			} else {
				// PhpVal 参数：如果被重新赋值，用 _arg 后缀避免与可变 var_xxx 冲突
				will_reassign := param_name in ass_vars
				if will_reassign {
					param_names << 'var_${param_name}_arg rt.PhpVal'
				} else {
					param_names << 'var_${param_name} rt.PhpVal'
				}
			}
		}
	}

	has_native_ret := ret_type.is_scalar()
	ret_type_str := if ret_type.tag == .t_void {
		''
	} else if has_native_ret {
		' ${ret_type.to_v_type()}'
	} else {
		' rt.PhpVal'
	}
	t.write_indent()
	t.write_line('fn ${func_v_name(node.name)}(${param_names.join(", ")})${ret_type_str} {')

	t.indent++
	if has_variadic_param {
		t.write_indent()
		t.write_line('mut var_${variadic_param_name} := rt.create_array_from_list(var_${variadic_param_name}_origin)')
	}
	// 为原生标量参数生成 var_xxx 初始化（$leavename → var_leavename := leavename）
	for rp in registered_native_params {
		t.write_indent()
		t.write_line('mut var_${rp} := ${rp}')
		// 如果参数被重新赋值，让 get_v_var_name 返回 var_xxx 而非裸参数名
		if rp in ass_vars {
			t.reassigned_params[rp] = true
		}
	}
	// 为被重新赋值的 PhpVal 参数生成可变副本（PHP 允许修改参数值）
	for param in node.params {
		param_var := param.var or { continue }
		pname := param_var.name
		if pname in t.native_params { continue }
		pname_type := t.get_func_param_type(node.name, pname)
		if pname_type.is_scalar() || pname_type.is_object() { continue }
		pvar := 'var_${pname}'
		if pname in ass_vars {
			t.scope.declare(pname)
			t.write_indent()
			t.write_line('mut ${pvar} := var_${pname}_arg')
		}
	}
	// 先预声明所有被引用但未被赋值的变量（如 superglobal 引用）
	for v in ref_vars {
		if v !in ass_vars && !t.scope.has_var(v) {
			t.write_indent()
			v_var := t.get_v_var_name(v)
			v_type := t.inferred_types[v_var] or { t.inferred_types[v] or { VarType{ tag: .t_unknown } } }
			if t.native_params[v] {
				t.write_line('mut ${v_var} := ${v}')
			} else if v_type.is_native_list || v_type.is_native_map {
				t.write_line('mut ${v_var} := ' + t.get_empty_literal(v_type))
				t.native_arr_vars[v] = true
			} else if v_type.is_scalar() {
				match v_type.tag {
					.t_int { t.write_line('mut ${v_var} := i64(0)') }
					.t_float { t.write_line('mut ${v_var} := f64(0.0)') }
					.t_bool { t.write_line('mut ${v_var} := false') }
					else { t.write_line("mut ${v_var} := ''") }
				}
			} else {
				t.write_line('mut ${v_var} := rt.new_null()')
			}
			t.scope.declare(v)
		}
	}
	// 预声明所有被赋值的变量，确保在 if/else 分支内的赋值也能在函数作用域可见
	for v in ass_vars {
		if !t.scope.has_var(v) {
			t.scope.declare(v)
			t.write_indent()
			v_var := t.get_v_var_name(v)
			v_type := t.inferred_types[v_var] or { t.inferred_types[v] or { VarType{ tag: .t_unknown } } }
			// 如果变量是原生参数（如 $user_id → user_id bool），用参数值初始化
			if t.native_params[v] {
				t.write_line('mut ${v_var} := ${v}')
			} else if v_type.is_native_list || v_type.is_native_map {
				t.write_line('mut ${v_var} := ' + t.get_empty_literal(v_type))
				t.native_arr_vars[v] = true
			} else if v_type.is_scalar() {
				match v_type.tag {
					.t_int { t.write_line('mut ${v_var} := i64(0)') }
					.t_float { t.write_line('mut ${v_var} := f64(0.0)') }
					.t_bool { t.write_line('mut ${v_var} := false') }
					else { t.write_line("mut ${v_var} := ''") }
				}
			} else {
				t.write_line('mut ${v_var} := rt.new_null()')
			}
		}
	}
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}
	if node.stmts.len == 0 || node.stmts[node.stmts.len - 1].node_type != ast.node_stmt_return {
		if ret_type.tag != .t_void {
			t.write_indent()
			if has_native_ret {
				t.write_line('return ${t.get_native_default(ret_type)}')
			} else {
				t.write_line('return rt.new_null()')
			}
		}
	}
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.write_line('')

	// 清理当前函数上下文
	for p in registered_native_params {
		t.native_params.delete(p)
	}
	t.inferred_types = old_inferred.clone()
	t.current_func_name = old_func_name
	t.current_func_ret_type = old_func_ret

	t.is_in_func = false
	t.indent = old_indent
	t.scope = old_scope
}

fn (mut t Transpiler) visit_return(node ast.AstNode) {
	if t.is_in_construct {
		// construct 无返回值：return; → return（提前退出）
		t.write_indent()
		t.write_line('return')
		return
	}
	is_void := t.current_func_ret_type.tag == .t_void
	if expr := node.expr {
		if is_void {
			// void 函数有 return expr：先执行表达式副作用（pre_stmts），再 bare return
			// 不输出表达式本身，避免 "expression evaluated but not used" 错误
			_ := t.visit_expr(*expr)
			t.write_indent()
			t.write_line('return')
			return
		}
		// 检查是否是返回 void 方法调用
		if expr.node_type == ast.node_expr_method_call {
			if obj_var_node := expr.var {
				if obj_var_node.node_type == ast.node_expr_variable {
					obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
					if obj_type.is_object() {
						ret_type := t.get_method_return_type(obj_type.class_name, expr.name)
						if ret_type.tag == .t_void {
							// void 方法：先调用，再返回 null
							expr_str := t.visit_expr(*expr)
							t.write_indent()
							t.write_line('${expr_str}')
							t.write_indent()
							t.write_line('return rt.new_null()')
							return
						}
					}
				}
			}
		}
		// 检查是否返回 struct 实例（如 create_wp_error()）而函数期望 PhpVal
		if expr.node_type == ast.node_expr_new {
			if t.current_func_ret_type.tag == .t_unknown || t.current_func_ret_type.tag == .t_object {
				new_class := t.resolve_class_name(expr.class_name)
				mut resolved_new := new_class
				if resolved_new == 'self' || resolved_new == 'static' {
					resolved_new = t.current_class
				}
				expr_str := t.visit_expr(*expr)
				parents := t.get_parents_expr(resolved_new)
				t.write_indent()
				t.write_line('return rt.new_object(\'${resolved_new}\', ${parents}, ${expr_str})')
				return
			}
		}
		if expr.node_type == ast.node_expr_funccall {
			if t.current_func_ret_type.tag == .t_unknown || t.current_func_ret_type.tag == .t_object {
				expr_type := t.get_expr_type(*expr)
				// 如果表达式类型未知但函数名匹配 create_xxx 模式，检查是否有对应 struct
				if expr_type.tag == .t_unknown {
					factory_name := expr.name
					if factory_name.starts_with('create_') {
						// 推导 struct 名: create_wp_error → Class_WP_Error
						suffix := factory_name.trim_left('create_')
						struct_name := 'Class_' + suffix.split('_').map(it.capitalize()).join('_')
						// 检查是否存在该 struct
						for cls in t.classes {
							if cls.name == struct_name {
								result := t.compile_arg(*expr, t.current_func_ret_type)
								t.write_indent()
								t.write_line('return rt.new_object(\'${suffix.split('_').map(it.capitalize()).join('_')}\', []string{}, ${result.code})')
								return
							}
						}
					}
				} else if expr_type.tag == .t_object && expr_type.class_name.len > 0 {
					// 表达式类型已知是 object，compile_arg 的 box_expr 会处理
					result := t.compile_arg(*expr, t.current_func_ret_type)
					t.write_indent()
					t.write_line('return ${result.code}')
					return
				}
			}
		}
		result := t.compile_arg(*expr, t.current_func_ret_type)
		t.write_indent()
		t.write_line('return ${result.code}')
	} else {
		t.write_indent()
		if is_void {
			t.write_line('return')
		} else if t.current_func_ret_type.is_scalar() {
			t.write_line('return ${t.get_native_default(t.current_func_ret_type)}')
		} else {
			t.write_line('return rt.new_null()')
		}
	}
}

// get_func_param_type 获取函数参数的推断类型
fn (t &Transpiler) get_func_param_type(func_name string, param_name string) VarType {
	if params := t.func_param_types[func_name] {
		if pt := params[param_name] {
			return pt
		}
	}
	return VarType{ tag: .t_unknown }
}

// get_native_default 返回原生类型的默认零值
fn (t &Transpiler) get_native_default(typ VarType) string {
	return match typ.tag {
		.t_int { '0' }
		.t_float { '0.0' }
		.t_bool { 'false' }
		.t_string { "''" }
		else { 'rt.new_null()' }
	}
}

fn (mut t Transpiler) visit_foreach(node ast.AstNode) {
	expr_node := node.expr or { panic('Foreach statement missing expr') }
	arr_type := t.get_expr_type(*expr_node)
	
	val_var_node := node.value_var or { panic('Foreach missing valueVar') }
	mut val_var_name := val_var_node.name
	mut key_var_name := ''
	if key_var_node := node.key_var {
		key_var_name = key_var_node.name
	}

	old_aliases := t.var_aliases.clone()
	old_native_vars := t.native_vars.clone()
	if t.scope.has_var(val_var_name) {
		shadow_name := 'var_${val_var_name}_shadow'
		t.var_aliases[val_var_name] = shadow_name
		val_var_name = shadow_name
	}
	if key_var_name.len > 0 && t.scope.has_var(key_var_name) {
		shadow_name := 'var_${key_var_name}_shadow'
		t.var_aliases[key_var_name] = shadow_name
		key_var_name = shadow_name
	}
	
	if arr_type.is_native_list || arr_type.is_native_map {
		arr_str := t.visit_expr(*expr_node)
		old_scope := t.scope.clone()
		t.scope.declare(val_var_name)
		if arr_type.element_type_tag in [.t_int, .t_float, .t_bool, .t_string] {
			t.native_vars[val_var_name] = true
		}
		
		old_inferred := t.inferred_types.clone()
		t.inferred_types[val_var_name] = VarType{ tag: arr_type.element_type_tag }
		
		t.write_indent()
		if key_var_name.len > 0 {
			t.scope.declare(key_var_name)
			key_tag := if arr_type.is_native_list { TypeTag.t_int } else { TypeTag.t_string }
			t.inferred_types[key_var_name] = VarType{ tag: key_tag }
			t.native_vars[key_var_name] = true
			
			key_v := if key_var_name.starts_with('var_') { key_var_name } else { 'var_' + key_var_name }
			val_v := if val_var_name.starts_with('var_') { val_var_name } else { 'var_' + val_var_name }
			t.write_line('for ${key_v}, ${val_v} in ${arr_str} {')
		} else {
			val_v := if val_var_name.starts_with('var_') { val_var_name } else { 'var_' + val_var_name }
			if arr_type.is_native_list {
				t.write_line('for ${val_v} in ${arr_str} {')
			} else {
				t.write_line('for _, ${val_v} in ${arr_str} {')
			}
		}
		
		t.indent++
		for stmt in node.stmts {
			t.visit_stmt(stmt)
		}
		t.indent--
		
		t.inferred_types = old_inferred.clone()
		t.scope = old_scope
		t.var_aliases = old_aliases.clone()
		t.native_vars = old_native_vars.clone()
		t.write_indent()
		t.write_line('}')
		return
	}
	
	t.foreach_depth++
	iter_name := 'iter_${t.foreach_depth}'
	
	expr_str := t.visit_expr(*expr_node)
	
	// 迭代器变量已按 foreach_depth 唯一命名，无需额外作用域块
	// （裸 { } 会被 V 解析为 map 字面量导致语法错误）
	
	// 在本层局部作用域中隔离迭代器
	t.write_indent()
	t.write_line('mut ${iter_name} := ${expr_str}.iterator()')
	
	t.write_indent()
	t.write_line('for {')
	t.indent++
	
	item_var_name := 'item_${t.foreach_depth}'
	
	t.write_indent()
	t.write_line('${item_var_name} := ${iter_name}.next() or { break }')
	
	// 备份作用域，声明循环变量
	old_scope := t.scope.clone()
	old_inferred := t.inferred_types.clone()
	
	t.scope.declare(val_var_name)
	t.inferred_types[val_var_name] = VarType{ tag: .t_unknown }
	t.write_indent()
	val_v := if val_var_name.starts_with('var_') { val_var_name } else { 'var_' + val_var_name }
	t.write_line('mut ${val_v} := ${item_var_name}.val')
	
	if key_var_name.len > 0 {
		t.scope.declare(key_var_name)
		t.inferred_types[key_var_name] = VarType{ tag: .t_unknown }
		t.write_indent()
		key_v := if key_var_name.starts_with('var_') { key_var_name } else { 'var_' + key_var_name }
		t.write_line('mut ${key_v} := ${item_var_name}.key')
	}
	
	// 遍历执行循环体内的语句
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}
	
	// 还原作用域与别名表
	t.scope = old_scope
	t.inferred_types = old_inferred.clone()
	t.var_aliases = old_aliases.clone()
	t.native_vars = old_native_vars.clone()
	// 不再递减 foreach_depth，确保顺序 foreach 循环的迭代器变量名唯一
	
	t.indent--
	t.write_indent()
	t.write_line('}')
}

fn (mut t Transpiler) visit_while(node ast.AstNode) {
	cond_node := node.cond or { panic('While statement missing cond') }
	native_cond := t.emit_native_condition(*cond_node)
	cond_str := if native_cond != '' { native_cond } else { 'rt.is_true(${t.visit_expr(*cond_node)})' }
	one_line_cond := cond_str.replace('\n', ' ').replace('\t', ' ').replace('\r', ' ')

	t.write_indent()
	t.write_line('for ${one_line_cond} {')
	t.indent++
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}
	t.indent--
	t.write_indent()
	t.write_line('}')
}

fn (mut t Transpiler) visit_do(node ast.AstNode) {
	cond_node := node.cond or { panic('Do-while statement missing cond') }
	native_cond := t.emit_native_condition(*cond_node)
	cond_str := if native_cond != '' { native_cond } else { 'rt.is_true(${t.visit_expr(*cond_node)})' }

	t.write_indent()
	t.write_line('for {')
	t.indent++

	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}

	t.write_indent()
	t.write_line('if !(${cond_str}) {')
	t.indent++
	t.write_indent()
	t.write_line('break')
	t.indent--
	t.write_indent()
	t.write_line('}')

	t.indent--
	t.write_indent()
	t.write_line('}')
}

// expr_produces_value 判断表达式节点作为独立语句时是否产生需要丢弃的返回值。
// 用于在表达式语句和 for 循环的 init/loop 表达式中添加 `_ = ` 前缀。
fn (mut t Transpiler) expr_produces_value(expr ast.AstNode) bool {
	match expr.node_type {
		// 始终产生值的表达式类型
		ast.node_expr_post_inc, ast.node_expr_post_dec,
		ast.node_expr_pre_inc, ast.node_expr_pre_dec,
		ast.node_expr_include, ast.node_expr_ternary,
		ast.node_expr_match, ast.node_expr_array_dim_fetch,
		ast.node_expr_new, ast.node_expr_property_fetch,
		ast.node_expr_static_prop_fetch {
			return true
		}
		ast.node_expr_funccall {
			// 检查函数返回类型：若已知为 void 则不产生值
			if ret_type := t.func_return_types[expr.name] {
				return ret_type.tag != .t_void
			}
			// rt.call_function() 回退始终返回 PhpVal
			return true
		}
		ast.node_expr_method_call {
			// 已知对象类型时检查方法返回类型
			if obj_var_node := expr.var {
				if obj_var_node.node_type == ast.node_expr_variable {
					mut obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
					if obj_var_node.name == 'this' {
						obj_type = VarType{ tag: .t_object, class_name: t.current_class }
					}
					if obj_type.is_object() {
						ret_type := t.get_method_return_type(obj_type.class_name, expr.name)
						if ret_type.tag == .t_void {
							return false
						}
					}
				}
			}
			// rt.call_method() 回退返回 PhpVal
			return true
		}
		ast.node_expr_static_call {
			// 已知类名时检查方法返回类型
			if expr.class_name.len > 0 {
				mut class_name := expr.class_name
				if class_name == 'parent' {
					for cls in t.classes {
						if cls.name == t.current_class {
							class_name = cls.extends
							break
						}
					}
				} else if class_name == 'self' || class_name == 'static' {
					class_name = t.current_class
				} else {
					class_name = t.resolve_class_name(class_name)
				}
				if class_name.len > 0 {
					ret_type := t.get_method_return_type(class_name, expr.name)
					if ret_type.tag == .t_void {
						return false
					}
				}
			}
			return true
		}
		else {
			return false
		}
	}
}

fn (mut t Transpiler) visit_for(node ast.AstNode) {
	old_scope := t.scope
	
	// 1. 初始化表达式
	for init_node in node.init {
		expr_str := t.visit_expr(init_node)
		is_bare_var := expr_str.starts_with('var_') && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
		is_bare_mutated := (expr_str.ends_with('_mutated') || expr_str.ends_with('_shadow')) && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
		is_bare_iife := expr_str.starts_with('iife_result_') && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
		if !is_bare_var && !is_bare_iife && !is_bare_mutated {
			if t.expr_produces_value(init_node) {
				t.write_indent()
				t.write_line('_ = ${expr_str}')
			} else {
				t.write_indent()
				t.write_line(expr_str)
			}
		}
	}

	// 2. 无限循环主体
	t.write_indent()
	t.write_line('for {')
	t.indent++

	// 3. 条件判断，若不满足则跳出
	if node.conds.len > 0 {
		last_cond := node.conds[node.conds.len - 1]
		native_cond := t.emit_native_condition(last_cond)
		cond_str := if native_cond != '' { native_cond } else { 'rt.is_true(${t.visit_expr(last_cond)})' }
		t.write_indent()
		t.write_line('if !(${cond_str}) { break }')
	}

	// 4. 循环体语句
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}

	// 5. 循环后操作表达式
	for loop_node in node.loop {
		if !t.try_emit_native_incdec(loop_node) {
			expr_str := t.visit_expr(loop_node)
			is_bare_var := expr_str.starts_with('var_') && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
			is_bare_mutated := (expr_str.ends_with('_mutated') || expr_str.ends_with('_shadow')) && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
			is_bare_iife := expr_str.starts_with('iife_result_') && !expr_str.contains(' ') && !expr_str.contains('(') && !expr_str.contains('.')
			if !is_bare_var && !is_bare_iife && !is_bare_mutated {
				if t.expr_produces_value(loop_node) {
					t.write_indent()
					t.write_line('_ = ${expr_str}')
				} else {
					t.write_indent()
					t.write_line(expr_str)
				}
			}
		}
	}
	
	t.indent--
	t.write_indent()
	t.write_line('}')
	
	t.scope = old_scope
}

struct SwitchBranch {
	conds      []ast.AstNode
	stmts      []ast.AstNode
	is_default bool
}

// can_use_v_match 检查 switch 是否可以生成 V 原生 match 表达式
// 仅当所有 case 值都是 int 字面量且条件变量也是 int 类型时才安全
fn (mut t Transpiler) can_use_v_match(cond_node ast.AstNode, branches []SwitchBranch) bool {
	// 检查条件变量类型
	cond_type := t.get_expr_type(cond_node)
	if cond_type.tag != .t_int {
		return false
	}
	// 检查所有 case 值是否都是 int 字面量
	for branch in branches {
		for c_node in branch.conds {
			if c_node.node_type != ast.node_scalar_int {
				return false
			}
		}
	}
	return true
}

fn (mut t Transpiler) visit_switch(node ast.AstNode) {
	cond_node := node.cond or { return }

	t.switch_count++
	old_in_switch := t.is_in_switch
	t.is_in_switch = true
	defer { t.is_in_switch = old_in_switch }

	// 收集所有分支
	mut branches := []SwitchBranch{}
	mut current_conds := []ast.AstNode{}
	mut group_has_default := false

	for i, case_node in node.cases {
		if case_cond := case_node.cond {
			if voidptr(case_cond) != 0 {
				current_conds << *case_cond
			}
		} else {
			group_has_default = true
		}

		if case_node.stmts.len > 0 || i == node.cases.len - 1 {
			branches << SwitchBranch{
				conds:      current_conds.clone()
				stmts:      case_node.stmts
				is_default: group_has_default
			}
			current_conds.clear()
			group_has_default = false
		}
	}

	if branches.len == 0 {
		return
	}

	// 尝试 V 原生 match 优化
	if t.can_use_v_match(*cond_node, branches) {
		cond_str := t.visit_expr_native(*cond_node)
		t.write_indent()
		t.write_line('match ${cond_str} {')
		t.indent++
		for branch in branches {
			t.write_indent()
			if branch.is_default {
				t.write_string('else {')
			} else {
				mut case_vals := []string{}
				for c_node in branch.conds {
					case_vals << c_node.value
				}
				t.write_string('${case_vals.join(", ")} {')
			}
			t.write_line('')
			t.indent++
			for stmt in branch.stmts {
				if stmt.node_type == ast.node_stmt_break {
					continue
				}
				t.visit_stmt(stmt)
			}
			t.indent--
			t.write_indent()
			t.write_line('}')
		}
		t.indent--
		t.write_indent()
		t.write_line('}')
		return
	}

	// 回退：使用 if-else 链
	cond_val_expr := t.visit_expr(*cond_node)
	switch_var := 'switch_val_${t.switch_count}'

	t.write_indent()
	t.write_line('mut ${switch_var} := ${cond_val_expr}')

	for idx, branch in branches {
		if idx == 0 {
			t.write_indent()
			if branch.is_default {
				t.write_string('if true {')
			} else {
				t.write_string('if ')
				for c_idx, c_node in branch.conds {
					if c_idx > 0 {
						t.write_string(' || ')
					}
					t.write_string('rt.is_true(rt.equal(${switch_var}, ')
					t.write_string(t.visit_expr(c_node))
					t.write_string('))')
				}
				t.write_string(' {')
			}
		} else {
			if branch.is_default {
				t.write_indent()
				t.write_string('} else {')
			} else {
				t.write_indent()
				t.write_string('} else if ')
				for c_idx, c_node in branch.conds {
					if c_idx > 0 {
						t.write_string(' || ')
					}
					t.write_string('rt.is_true(rt.equal(${switch_var}, ')
					t.write_string(t.visit_expr(c_node))
					t.write_string('))')
				}
				t.write_string(' {')
			}
		}
		t.write_line('')
		t.indent++
		for stmt in branch.stmts {
			if stmt.node_type == ast.node_stmt_break {
				continue
			}
			t.visit_stmt(stmt)
		}
		t.indent--
	}
	t.write_indent()
	t.write_line('}')
}

module emitter

import php2v.ast

fn (mut t Transpiler) visit_stmt(node ast.AstNode) {
	match node.node_type {
		ast.node_stmt_echo {
			t.visit_echo(node)
		}
		ast.node_stmt_expression {
			if expr := node.expr {
				// 原生 int 变量的独立自增/自减语句优化
				if t.try_emit_native_incdec(*expr) {
					// 已处理
				} else {
					expr_str := t.visit_expr(*expr)
					t.write_indent()
					t.write_line(expr_str)
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
			t.write_indent()
			t.write_line('break')
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
					arr_str := t.visit_expr(*arr_node)
					dim_str := t.visit_expr(*dim_node)
					t.write_indent()
					t.write_line('${arr_str}.array_unset(${dim_str})')
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
			// 接口本身在代码生成中直接忽略
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
			escaped := expr.value
				.replace('\\', '\\\\')
				.replace('\'', '\\\'')
				.replace('\n', '\\n')
				.replace('\r', '\\r')
				.replace('\t', '\\t')
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
		val_str := t.visit_expr(c.value)
		t.write_indent()
		t.write_line("rt.define_constant('${c.name}', ${val_str})")
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
			t.scope.declare(var_node.name)
			t.write_indent()
			t.write_line('mut var_${var_node.name} := var_e_${my_id}.dup()')
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
		t.write_line('if rt.has_exception() { return rt.new_null() }')
	}

	t.write_line('')
	t.write_line('${end_label}:')
}

fn (mut t Transpiler) visit_if(node ast.AstNode) {
	cond_node := node.cond or { panic('If statement missing cond') }
	native_cond := t.emit_native_condition(*cond_node)
	cond_str := if native_cond != '' { native_cond } else { 'rt.is_true(${t.visit_expr(*cond_node)})' }
	
	t.write_indent()
	t.write_line('if ${cond_str} {')
	
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
		
		t.write_indent()
		t.write_line('} else if ${elseif_cond_str} {')
		
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
}

fn (mut t Transpiler) visit_function(node ast.AstNode) {
	t.is_in_func = true
	old_indent := t.indent
	t.indent = 0
	old_scope := t.scope
	t.scope = VarScope.new()

	mut param_names := []string{}
	for param in node.params {
		param_var := param.var or { panic('Param missing var') }
		param_name := param_var.name
		t.scope.declare(param_name)
		param_names << 'var_${param_name} rt.PhpVal'
	}

	t.write_indent()
	t.write_line('fn func_${node.name}(${param_names.join(", ")}) rt.PhpVal {')
	
	t.indent++
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
	if expr := node.expr {
		expr_str := t.visit_expr(*expr)
		t.write_indent()
		t.write_line('return ${expr_str}')
	} else {
		t.write_indent()
		t.write_line('return rt.new_null()')
	}
}

fn (mut t Transpiler) visit_foreach(node ast.AstNode) {
	expr_node := node.expr or { panic('Foreach statement missing expr') }
	expr_str := t.visit_expr(*expr_node)
	
	t.write_indent()
	t.write_line('{')
	t.indent++
	
	// 在本层局部作用域中隔离迭代器
	t.write_indent()
	t.write_line('mut iter := ${expr_str}.iterator()')
	
	t.write_indent()
	t.write_line('for {')
	t.indent++
	
	t.write_indent()
	t.write_line('item := iter.next() or { break }')
	
	// 备份作用域，声明循环变量
	old_scope := t.scope
	
	// 解析值变量名并声明为局部变量
	val_var_node := node.value_var or { panic('Foreach missing valueVar') }
	val_var_name := val_var_node.name
	t.scope.declare(val_var_name)
	t.write_indent()
	t.write_line('mut var_${val_var_name} := item.val')
	
	// 如果存在键变量，解析并声明
	if key_var_node := node.key_var {
		key_var_name := key_var_node.name
		t.scope.declare(key_var_name)
		t.write_indent()
		t.write_line('mut var_${key_var_name} := item.key')
	}
	
	// 遍历执行循环体内的语句
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}
	
	// 还原作用域
	t.scope = old_scope
	
	t.indent--
	t.write_indent()
	t.write_line('}')
	
	t.indent--
	t.write_indent()
	t.write_line('}')
}

fn (mut t Transpiler) visit_while(node ast.AstNode) {
	cond_node := node.cond or { panic('While statement missing cond') }
	native_cond := t.emit_native_condition(*cond_node)
	cond_str := if native_cond != '' { native_cond } else { 'rt.is_true(${t.visit_expr(*cond_node)})' }
	
	t.write_indent()
	t.write_line('for ${cond_str} {')
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

fn (mut t Transpiler) visit_for(node ast.AstNode) {
	t.write_indent()
	t.write_line('{')
	t.indent++
	
	old_scope := t.scope
	
	// 1. 初始化表达式
	for init_node in node.init {
		expr_str := t.visit_expr(init_node)
		t.write_indent()
		t.write_line(expr_str)
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
			t.write_indent()
			t.write_line(expr_str)
		}
	}
	
	t.indent--
	t.write_indent()
	t.write_line('}')
	
	t.scope = old_scope
	
	t.indent--
	t.write_indent()
	t.write_line('}')
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

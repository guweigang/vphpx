module emitter

import strings
import os
import php2v.ast

pub struct ClassInfo {
pub mut:
	name        string
	extends     string
	methods     []MethodInfo // 本类自身声明的方法
	props       []string     // 本类自身声明的属性
	all_props   []string     // 含继承的全部属性（用于 dispatch_get/set_prop）
	all_methods []MethodInfo // 含继承的全部方法（用于 dispatch_method）
}

pub struct MethodInfo {
pub:
	name        string
	param_count int
}

pub struct Transpiler {
pub mut:
	out              strings.Builder
	func_out         strings.Builder
	closures_code    strings.Builder
	is_in_closure    bool
	closure_count    int
	closure_names    []string
	is_in_func       bool
	indent           int
	scope            VarScope
	custom_functions map[string]bool
	classes          []ClassInfo
	current_class    string // 当前正在转译的类名（用于 parent:: 解析）
	current_file     string
	try_count        int
	current_catch_label string // 当前语句所属 of the try-catch block's catch label
	current_finally_label string // 当前语句所属 of the try-catch block's finally label
	undeclared_classes map[string]bool
	current_namespace string
	use_aliases map[string]string
	switch_count int
	pre_stmts []string
}

pub fn Transpiler.new() Transpiler {
	return Transpiler{
		out:              strings.new_builder(1024)
		func_out:         strings.new_builder(1024)
		closures_code:    strings.new_builder(1024)
		indent:           1
		scope:            VarScope.new()
		custom_functions: map[string]bool{}
		classes:          []ClassInfo{}
		current_file:     ''
		undeclared_classes: map[string]bool{}
		current_namespace: ''
		use_aliases: map[string]string{}
		switch_count: 0
		pre_stmts: []string{}
	}
}



// transpile 预扫描函数并遍历语句，返回生成的 V 代码
pub fn (mut t Transpiler) transpile(stmts []ast.AstNode) string {
	// 预扫描顶层自定义函数，登记到 custom_functions 中以支持任意顺序的调用
	for stmt in stmts {
		if stmt.node_type == ast.node_stmt_function {
			t.custom_functions[stmt.name] = true
		}
	}

	ref_vars, ass_vars := t.collect_vars_in_scope(stmts)
	for v in ref_vars {
		if v !in ass_vars && !t.scope.has_var(v) {
			t.write_indent()
			t.write_line('mut var_${v} := rt.new_null()')
			t.scope.declare(v)
		}
	}

	for stmt in stmts {
		t.visit_stmt(stmt)
	}

	// 补全在转译中遇到的未显式声明的类（如 Exception 等内置类）
	old_is_in_func := t.is_in_func
	t.is_in_func = true
	for name, _ in t.undeclared_classes {
		mut exists := false
		for cls in t.classes {
			if cls.name == name {
				exists = true
				break
			}
		}
		if !exists {
			mut new_cls := ClassInfo{
				name: name
				extends: ''
				methods: []MethodInfo{}
				props: []string{}
				all_props: []string{}
				all_methods: []MethodInfo{}
			}
			if name == 'Exception' {
				new_cls.props << ['message', 'code', 'file', 'line']
				new_cls.methods << MethodInfo{ name: '__construct', param_count: 1 }
				new_cls.methods << MethodInfo{ name: 'getMessage', param_count: 0 }
			}
			new_cls.all_props = new_cls.props.clone()
			new_cls.all_methods = new_cls.methods.clone()
			t.classes << new_cls
			
			t.write_line('struct Class_${name} {')
			t.write_line('\trt.PhpObjectBase')
			if new_cls.props.len > 0 {
				t.write_line('pub mut:')
				t.indent++
				for prop in new_cls.props {
					t.write_indent()
					t.write_line('prop_${prop} rt.PhpVal')
				}
				t.indent--
			}
			t.write_line('}')
			t.write_line('')

			if name == 'Exception' {
				old_indent := t.indent
				t.indent = 0
				t.write_line('fn (mut this Class_Exception) method___construct(var_message rt.PhpVal) rt.PhpVal {')
				t.indent++
				t.write_indent()
				t.write_line('this.prop_message = var_message')
				t.write_indent()
				t.write_line('return rt.new_null()')
				t.indent--
				t.write_line('}')
				t.write_line('')

				t.write_line('fn (mut this Class_Exception) method_getmessage() rt.PhpVal {')
				t.indent++
				t.write_indent()
				t.write_line('return this.prop_message')
				t.indent--
				t.write_line('}')
				t.write_line('')
				t.indent = old_indent
			}
		}
	}
	t.is_in_func = old_is_in_func
	
	t.generate_dispatchers()
	
	if t.closures_code.len > 0 {
		t.func_out.write_string(t.closures_code.str())
	}
	
	t.generate_call_closure()
	
	return t.out.str()
}

fn (mut t Transpiler) write_indent() {
	if t.pre_stmts.len > 0 {
		pre := t.pre_stmts.clone()
		t.pre_stmts.clear()

		for stmt in pre {
			indent_str := '\t'.repeat(t.indent)
			if t.is_in_closure {
				t.closures_code.writeln('${indent_str}${stmt}')
			} else if t.is_in_func {
				t.func_out.writeln('${indent_str}${stmt}')
			} else {
				t.out.writeln('${indent_str}${stmt}')
			}
		}
	}

	indent_str := '\t'.repeat(t.indent)
	if t.is_in_closure {
		t.closures_code.write_string(indent_str)
	} else if t.is_in_func {
		t.func_out.write_string(indent_str)
	} else {
		t.out.write_string(indent_str)
	}
}


fn (mut t Transpiler) write_line(s string) {
	if t.is_in_closure {
		t.closures_code.writeln(s)
	} else if t.is_in_func {
		t.func_out.writeln(s)
	} else {
		t.out.writeln(s)
	}
}

fn (mut t Transpiler) write_string(s string) {
	if t.is_in_closure {
		t.closures_code.write_string(s)
	} else if t.is_in_func {
		t.func_out.write_string(s)
	} else {
		t.out.write_string(s)
	}
}

fn (mut t Transpiler) visit_stmt(node ast.AstNode) {
	match node.node_type {
		ast.node_stmt_echo {
			t.visit_echo(node)
		}
		ast.node_stmt_expression {
			if expr := node.expr {
				expr_str := t.visit_expr(*expr)
				t.write_indent()
				t.write_line(expr_str)
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
				} else {
					var_str := t.visit_expr(v)
					t.write_indent()
					t.write_line('${var_str} = rt.new_null()')
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
		ast.node_expr_variable {
			if node.name in ['_GET', '_POST', '_SERVER', '_COOKIE', '_SESSION', '_REQUEST', '_ENV'] {
				return 'rt.get_superglobal(\'${node.name}\')'
			}
			return 'var_${node.name}'
		}
		ast.node_expr_throw {
			expr_node := node.expr or { panic('Throw missing expr') }
			expr_str := t.visit_expr(*expr_node)
			return 'rt.throw_exception(${expr_str})'
		}
		ast.node_scalar_int {
			return 'rt.new_int(${node.value})'
		}
		ast.node_scalar_float {
			return 'rt.new_float(${node.value})'
		}
		ast.node_scalar_string {
			escaped := node.value
				.replace('\\', '\\\\')
				.replace('\'', '\\\'')
				.replace('\n', '\\n')
				.replace('\r', '\\r')
				.replace('\t', '\\t')
			return 'rt.new_string(\'${escaped}\')'
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true' { return 'rt.new_bool(true)' }
				'false' { return 'rt.new_bool(false)' }
				'null' { return 'rt.new_null()' }
				else { return 'rt.get_constant(\'${node.name}\')' }
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
				obj_var_name := t.visit_expr(*obj_var_node)
				prop_name := var_node.name
				
				expr_node := node.expr or { panic('Assign node missing expr') }
				mut expr_str := t.visit_expr(*expr_node)
				if expr_node.node_type == ast.node_expr_variable {
					expr_str += '.dup()'
				}
				
				return 'set_property(${obj_var_name}, \'${prop_name}\', ${expr_str})'
			}
			
			if var_node.node_type != ast.node_expr_variable {
				return '// unsupported assign target: ${var_node.node_type}'
			}
			var_name := var_node.name
			expr_node := node.expr or { panic('Assign node missing expr') }
			
			mut expr_str := t.visit_expr(*expr_node)
			if expr_node.node_type == ast.node_expr_variable {
				expr_str += '.dup()'
			}
			
			if t.scope.has_var(var_name) {
				return 'var_${var_name} = ${expr_str}'
			} else {
				t.scope.declare(var_name)
				return 'mut var_${var_name} := ${expr_str}'
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
				if arg_strs.len == 0 {
					return 'rt.call_function(\'${func_name}\', []rt.PhpVal{})'
				} else {
					return 'rt.call_function(\'${func_name}\', [${arg_strs.join(", ")}])'
				}
			}
		}
		// 二元运算
		ast.node_bin_plus {
			left := node.left or { panic('plus missing left') }
			right := node.right or { panic('plus missing right') }
			return 'rt.add(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_minus {
			left := node.left or { panic('minus missing left') }
			right := node.right or { panic('minus missing right') }
			return 'rt.sub(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_mul {
			left := node.left or { panic('mul missing left') }
			right := node.right or { panic('mul missing right') }
			return 'rt.mul(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_div {
			left := node.left or { panic('div missing left') }
			right := node.right or { panic('div missing right') }
			return 'rt.div(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_mod {
			left := node.left or { panic('mod missing left') }
			right := node.right or { panic('mod missing right') }
			return 'rt.mod_(${t.visit_expr(*left)}, ${t.visit_expr(*right)})'
		}
		ast.node_bin_concat {
			left := node.left or { panic('concat missing left') }
			right := node.right or { panic('concat missing right') }
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
			return 'create_${class_name.to_lower()}(${arg_strs.join(", ")})'
		}
		ast.node_expr_method_call {
			obj_var_node := node.var or { panic('MethodCall missing var') }
			obj_var_name := t.visit_expr(*obj_var_node)
			method_name := node.name
			
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
			return 'get_property(${obj_var_name}, \'${prop_name}\')'
		}
		ast.node_expr_eval {
			expr_node := node.expr or { panic('Eval missing expr') }
			expr_str := t.visit_expr(*expr_node)
			return 'rt.call_function(\'eval\', [${expr_str}])'
		}
		ast.node_expr_match {
			cond_node := node.cond or { panic('Match expression missing cond') }
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


		ast.node_expr_closure {

			t.closure_count++
			class_name := 'Closure_${t.closure_count}'
			t.closure_names << class_name
			
			mut captured_vars := []string{}
			for use_node in node.uses {
				use_var := use_node.var or { continue }
				captured_vars << use_var.name
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
			
			mut init_fields := []string{}
			for var_name in captured_vars {
				init_fields << 'prop_${var_name}: var_${var_name}.dup()'
			}
			return 'rt.new_object(\'${class_name}\', [\'Closure\'], &${class_name}{ ${init_fields.join(", ")} })'
		}
		ast.node_expr_arrow_function {
			t.closure_count++
			class_name := 'Closure_${t.closure_count}'
			t.closure_names << class_name
			
			mut captured_vars := []string{}
			expr_node := node.expr or { panic('ArrowFunction missing expr') }
			
			mut param_names := []string{}
			for param in node.params {
				param_var := param.var or { panic('Param missing var') }
				param_names << param_var.name
			}
			
			t.find_captured_vars_rec(*expr_node, param_names, mut captured_vars)
			
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
			
			mut init_fields := []string{}
			for var_name in captured_vars {
				init_fields << 'prop_${var_name}: var_${var_name}.dup()'
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
				for cls in t.classes {
					if cls.name == t.current_class {
						parent_class = cls.extends
						break
					}
				}
				if parent_class.len == 0 {
					return '// error: parent:: used without extends'
				}
				
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
				// V struct embedding: this.Class_Parent.method_name() 直接调用父类方法
				return 'this.Class_${parent_class}.method_${node.name.to_lower()}(${arg_strs.join(", ")})'
			}
			
			// self/static 或普通类名的静态调用
			mut class_name := node.class_name
			if class_name == 'self' || class_name == 'static' {
				class_name = t.current_class
			} else {
				class_name = t.resolve_class_name(class_name)
			}
			t.undeclared_classes[class_name] = true
			
			mut arg_strs := []string{}
			mut arg_formals := []string{}
			mut arg_calls := []string{}
			for i, arg in node.args {
				arg_val := arg.expr or { panic('Arg missing expr') }
				arg_str := t.visit_expr(*arg_val)
				if arg_val.node_type == ast.node_expr_variable {
					arg_strs << '${arg_str}.dup()'
				} else {
					arg_strs << arg_str
				}
				arg_formals << 'arg_${i} rt.PhpVal'
				arg_calls << 'arg_${i}'
			}
			
			if arg_strs.len == 0 {
				return 'fn () rt.PhpVal { mut temp := Class_${class_name}{}; return temp.method_${node.name.to_lower()}() }()'
			} else {
				return 'fn (${arg_formals.join(", ")}) rt.PhpVal { mut temp := Class_${class_name}{}; return temp.method_${node.name.to_lower()}(${arg_calls.join(", ")}) }(${arg_strs.join(", ")})'
			}
		}
		ast.node_scalar_encapsed, ast.node_scalar_interpolated_string {
			if node.parts.len == 0 {
				return "rt.new_string('')"
			}
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

fn (mut t Transpiler) visit_echo(node ast.AstNode) {
	for expr in node.exprs {
		expr_str := t.visit_expr(expr)
		t.write_indent()
		t.write_line('rt.echo_val(${expr_str})')
	}
}


fn (mut t Transpiler) visit_if(node ast.AstNode) {
	cond_node := node.cond or { panic('If statement missing cond') }
	cond_str := t.visit_expr(*cond_node)
	
	t.write_indent()
	t.write_line('if rt.is_true(${cond_str}) {')
	
	t.indent++
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}
	t.indent--
	
	// 处理 elseifs
	for elseif_node in node.elseifs {
		elseif_cond := elseif_node.cond or { panic('Elseif statement missing cond') }
		elseif_cond_str := t.visit_expr(*elseif_cond)
		
		t.write_indent()
		t.write_line('} else if rt.is_true(${elseif_cond_str}) {')
		
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
	cond_str := t.visit_expr(*cond_node)
	
	t.write_indent()
	t.write_line('for rt.is_true(${cond_str}) {')
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
	cond_str := t.visit_expr(*cond_node)

	t.write_indent()
	t.write_line('for {')
	t.indent++

	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}

	t.write_indent()
	t.write_line('if !rt.is_true(${cond_str}) {')
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
		cond_str := t.visit_expr(last_cond)
		t.write_indent()
		t.write_line('if !rt.is_true(${cond_str}) { break }')
	}

	// 4. 循环体语句
	for stmt in node.stmts {
		t.visit_stmt(stmt)
	}

	// 5. 循环后操作表达式
	for loop_node in node.loop {
		expr_str := t.visit_expr(loop_node)
		t.write_indent()
		t.write_line(expr_str)
	}

	
	t.indent--
	t.write_indent()
	t.write_line('}')
	
	t.scope = old_scope
	
	t.indent--
	t.write_indent()
	t.write_line('}')
}

fn (mut t Transpiler) visit_class(node ast.AstNode) {
	t.is_in_func = true
	resolved_name := t.resolve_class_name(node.name)
	resolved_extends := t.resolve_class_name(node.extends)
	t.current_class = resolved_name
	
	// 收集 ClassInfo：只收集本类自身声明的属性和方法
	mut class_info := ClassInfo{
		name: resolved_name
		extends: resolved_extends
		methods: []MethodInfo{}
		props: []string{}
		all_props: []string{}
		all_methods: []MethodInfo{}
	}
	
	mut own_method_names := map[string]bool{}
	mut own_method_names_originally := map[string]bool{}
	for stmt in node.stmts {
		if stmt.node_type == ast.node_stmt_property {
			for prop in stmt.props {
				class_info.props << prop.name
			}
		} else if stmt.node_type == ast.node_stmt_class_method {
			class_info.methods << MethodInfo{
				name: stmt.name
				param_count: stmt.params.len
			}
			own_method_names[stmt.name] = true
			own_method_names_originally[stmt.name] = true
		}
	}
	
	// 检查是否继承了 Exception 内置类
	mut is_exception_subclass := false
	mut temp_extends := class_info.extends
	for temp_extends != '' {
		if temp_extends == 'Exception' {
			is_exception_subclass = true
			break
		}
		mut found := false
		for p_cls in t.classes {
			if p_cls.name == temp_extends {
				temp_extends = p_cls.extends
				found = true
				break
			}
		}
		if !found {
			t.undeclared_classes[temp_extends] = true
			break
		}
	}

	if is_exception_subclass {
		if 'message' !in class_info.props { class_info.props << 'message' }
		if 'code' !in class_info.props { class_info.props << 'code' }
		if 'file' !in class_info.props { class_info.props << 'file' }
		if 'line' !in class_info.props { class_info.props << 'line' }
		
		if '__construct' !in own_method_names {
			class_info.methods << MethodInfo{
				name: '__construct'
				param_count: 1
			}
			own_method_names['__construct'] = true
		}
		if 'getMessage' !in own_method_names {
			class_info.methods << MethodInfo{
				name: 'getMessage'
				param_count: 0
			}
			own_method_names['getMessage'] = true
		}
	}

	// 构建 all_props / all_methods（含继承），用于 dispatch 生成
	if class_info.extends.len > 0 {
		mut parent_exists := false
		for parent_cls in t.classes {
			if parent_cls.name == class_info.extends && class_info.extends !in t.undeclared_classes {
				parent_exists = true
				for p in parent_cls.all_props {
					class_info.all_props << p
				}
				for p in class_info.props {
					class_info.all_props << p
				}
				for m in class_info.methods {
					class_info.all_methods << m
				}
				for pm in parent_cls.all_methods {
					if pm.name !in own_method_names {
						class_info.all_methods << pm
					}
				}
				break
			}
		}
		if !parent_exists {
			class_info.all_props = class_info.props.clone()
			class_info.all_methods = class_info.methods.clone()
		}
	} else {
		class_info.all_props = class_info.props.clone()
		class_info.all_methods = class_info.methods.clone()
	}
	t.classes << class_info

	// 生成结构体定义（V struct embedding 方式）
	t.write_line('struct Class_${resolved_name} {')
	if class_info.extends.len > 0 {
		mut parent_exists := false
		for p_cls in t.classes {
			if p_cls.name == class_info.extends && class_info.extends !in t.undeclared_classes {
				parent_exists = true
				break
			}
		}
		if parent_exists {
			t.write_line('\tClass_${class_info.extends}')
		} else {
			t.write_line('\trt.PhpObjectBase')
		}
	} else {
		t.write_line('\trt.PhpObjectBase')
	}
	if class_info.props.len > 0 {
		t.write_line('pub mut:')
		t.indent++
		for prop in class_info.props {
			t.write_indent()
			t.write_line('prop_${prop} rt.PhpVal')
		}
		t.indent--
	}
	t.write_line('}')
	t.write_line('')

	// 遍历生成方法
	for stmt in node.stmts {
		if stmt.node_type == ast.node_stmt_class_method {
			t.visit_class_method(resolved_name, stmt)
		}
	}

	if is_exception_subclass {
		if '__construct' !in own_method_names_originally {
			t.write_indent()
			t.write_line('fn (mut this Class_${resolved_name}) method___construct(var_message rt.PhpVal) rt.PhpVal {')
			t.indent++
			t.write_indent()
			t.write_line('this.prop_message = var_message')
			t.write_indent()
			t.write_line('return rt.new_null()')
			t.indent--
			t.write_indent()
			t.write_line('}')
			t.write_line('')
		}
		if 'getMessage' !in own_method_names_originally {
			t.write_indent()
			t.write_line('fn (mut this Class_${resolved_name}) method_getmessage() rt.PhpVal {')
			t.indent++
			t.write_indent()
			t.write_line('return this.prop_message')
			t.indent--
			t.write_indent()
			t.write_line('}')
			t.write_line('')
		}
	}

	t.current_class = ''
	t.is_in_func = false
}

fn (mut t Transpiler) visit_class_method(class_name string, node ast.AstNode) {
	t.is_in_func = true
	old_indent := t.indent
	t.indent = 0
	old_scope := t.scope
	t.scope = VarScope.new()
	t.scope.declare('this')

	mut param_names := []string{}
	for param in node.params {
		param_var := param.var or { panic('Param missing var') }
		param_name := param_var.name
		t.scope.declare(param_name)
		param_names << 'var_${param_name} rt.PhpVal'
	}

	t.write_indent()
	t.write_line('fn (mut this Class_${class_name}) method_${node.name.to_lower()}(${param_names.join(", ")}) rt.PhpVal {')
	
	t.indent++
	
	// 声明 $this 代理变量以支持 $this->prop 的正常读写
	t.write_indent()
	t.write_line('mut var_this := rt.new_object(\'${class_name}\', ${t.get_parents_expr(class_name)}, &this)')
	
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

	t.indent = old_indent
	t.scope = old_scope
}

// 递归生成嵌套的结构体初始化代码
fn (mut t Transpiler) generate_struct_init(cls ClassInfo) {
	if cls.extends.len > 0 {
		mut parent_exists := false
		for parent_cls in t.classes {
			if parent_cls.name == cls.extends && cls.extends !in t.undeclared_classes {
				parent_exists = true
				t.write_indent()
				t.write_line('Class_${cls.extends}: Class_${cls.extends}{')
				t.indent++
				t.generate_struct_init(parent_cls)
				t.indent--
				t.write_indent()
				t.write_line('}')
				break
			}
		}
		if !parent_exists {
			t.write_indent()
			t.write_line('PhpObjectBase: rt.PhpObjectBase{}')
		}
	} else {
		// 最底层基类，初始化 rt.PhpObjectBase
		t.write_indent()
		t.write_line('PhpObjectBase: rt.PhpObjectBase{}')
	}
	// 初始化本类自身的属性
	for prop in cls.props {
		t.write_indent()
		t.write_line('prop_${prop}: rt.new_null()')
	}
}

fn (mut t Transpiler) generate_dispatchers() {
	t.is_in_func = true
	t.indent = 0

	if t.classes.len == 0 {
		t.write_line('fn call_method(obj rt.PhpVal, method_name string, args []rt.PhpVal) rt.PhpVal {')
		t.write_line('\treturn rt.new_null()')
		t.write_line('}')
		t.write_line('')
		t.write_line('fn get_property(obj rt.PhpVal, prop_name string) rt.PhpVal {')
		t.write_line('\treturn rt.new_null()')
		t.write_line('}')
		t.write_line('')
		t.write_line('fn set_property(obj rt.PhpVal, prop_name string, val rt.PhpVal) {}')
		t.write_line('')
		t.is_in_func = false
		return
	}

	// 1. 生成每个类的 create_ClassName 实例化辅助函数
	for cls in t.classes {
		// 在 all_methods 中查找构造函数
		mut construct_info := ?MethodInfo(none)
		for m in cls.all_methods {
			if m.name == '__construct' {
				construct_info = m
				break
			}
		}
		
		mut param_decls := []string{}
		mut param_pass := []string{}
		if info := construct_info {
			for i in 0 .. info.param_count {
				param_decls << 'arg_${i} rt.PhpVal'
				param_pass << 'arg_${i}'
			}
		}
		
		t.write_line('fn create_${cls.name.to_lower()}(${param_decls.join(", ")}) rt.PhpVal {')
		t.indent++
		t.write_indent()
		// 嵌套初始化
		t.write_line('mut obj := &Class_${cls.name}{')
		t.indent++
		t.generate_struct_init(cls)
		t.indent--
		t.write_indent()
		t.write_line('}')
		
		if construct_info != none {
			t.write_indent()
			// V struct embedding: 方法直接通过 promotion 调用，无需 unsafe
			t.write_line('obj.method___construct(${param_pass.join(", ")})')
		}
		
		t.write_indent()
		t.write_line('return rt.new_object(\'${cls.name}\', ${t.get_parents_expr(cls.name)}, obj)')
		t.indent--
		t.write_line('}')
		t.write_line('')
	}

	// 2. 生成每个类的 dispatch_method / dispatch_get_prop / dispatch_set_prop
	for cls in t.classes {
		// dispatch_method：使用 all_methods（含继承），V promotion 自动处理
		t.write_line('fn (mut this Class_${cls.name}) dispatch_method(method_name string, args []rt.PhpVal) rt.PhpVal {')
		t.indent++
		if cls.all_methods.len > 0 {
			t.write_indent()
			t.write_line('match method_name {')
			t.indent++
			for m in cls.all_methods {
				t.write_indent()
				mut args_pass := []string{}
				for i in 0 .. m.param_count {
					args_pass << 'if args.len > ${i} { args[${i}] } else { rt.new_null() }'
				}
				// 无论自身方法还是继承方法，都直接 this.method_name()，V promotion 处理
				t.write_line('\'${m.name}\' { return this.method_${m.name.to_lower()}(${args_pass.join(", ")}) }')
			}
			t.write_indent()
			t.write_line('else {}')
			t.indent--
			t.write_indent()
			t.write_line('}')
		}
		t.write_indent()
		t.write_line('return rt.new_null()')
		t.indent--
		t.write_line('}')
		t.write_line('')

		// dispatch_get_prop：使用 all_props（含继承），V promotion 自动处理
		t.write_line('fn (this &Class_${cls.name}) dispatch_get_prop(prop_name string) rt.PhpVal {')
		t.indent++
		if cls.all_props.len > 0 {
			t.write_indent()
			t.write_line('match prop_name {')
			t.indent++
			for prop in cls.all_props {
				t.write_indent()
				t.write_line('\'${prop}\' { return this.prop_${prop} }')
			}
			t.write_indent()
			t.write_line('else {}')
			t.indent--
			t.write_indent()
			t.write_line('}')
		}
		t.write_indent()
		t.write_line('return rt.new_null()')
		t.indent--
		t.write_line('}')
		t.write_line('')

		// dispatch_set_prop：使用 all_props（含继承），V promotion 自动处理
		t.write_line('fn (mut this Class_${cls.name}) dispatch_set_prop(prop_name string, val rt.PhpVal) {')
		t.indent++
		if cls.all_props.len > 0 {
			t.write_indent()
			t.write_line('match prop_name {')
			t.indent++
			for prop in cls.all_props {
				t.write_indent()
				t.write_line('\'${prop}\' { this.prop_${prop} = val }')
			}
			t.write_indent()
			t.write_line('else {}')
			t.indent--
			t.write_indent()
			t.write_line('}')
		}
		t.indent--
		t.write_line('}')
		t.write_line('')
	}

	// 3. 极简的全局路由分发器桥接
	t.write_line('fn call_method(obj rt.PhpVal, method_name string, args []rt.PhpVal) rt.PhpVal {')
	t.write_line('\treturn rt.call_method(obj, method_name, args)')
	t.write_line('}')
	t.write_line('')

	t.write_line('fn get_property(obj rt.PhpVal, prop_name string) rt.PhpVal {')
	t.write_line('\treturn rt.get_property(obj, prop_name)')
	t.write_line('}')
	t.write_line('')

	t.write_line('fn set_property(obj rt.PhpVal, prop_name string, val rt.PhpVal) {')
	t.write_line('\trt.set_property(obj, prop_name, val)')
	t.write_line('}')
	t.write_line('')

	t.is_in_func = false
}

fn (mut t Transpiler) generate_call_closure() {
	old_is_in_func := t.is_in_func
	t.is_in_func = true
	t.indent = 0
	
	t.write_line('fn call_closure(cb rt.PhpVal, args []rt.PhpVal) rt.PhpVal {')
	if t.closure_names.len == 0 {
		t.write_line('\treturn rt.new_null()')
		t.write_line('}')
		t.write_line('')
		t.is_in_func = old_is_in_func
		return
	}
	
	t.write_line('\tif !cb.is_object() { return rt.new_null() }')
	t.write_line('\tmut obj_info := cb.get_object()')
	t.write_line('\tmatch obj_info.class_name {')
	for name in t.closure_names {
		t.write_line('\t\t\'${name}\' {')
		t.write_line('\t\t\tif mut obj_info.obj is ${name} {')
		t.write_line('\t\t\t\treturn obj_info.obj.invoke(args)')
		t.write_line('\t\t\t}')
		t.write_line('\t\t}')
	}
	t.write_line('\t\telse {}')
	t.write_line('\t}')
	t.write_line('\treturn rt.new_null()')
	t.write_line('}')
	t.write_line('')
	
	t.is_in_func = old_is_in_func
}

fn (t &Transpiler) find_captured_vars_rec(node ast.AstNode, params []string, mut captured []string) {
	match node.node_type {
		ast.node_expr_variable {
			name := node.name
			if name !in params && name != 'this' && name != '' {
				if t.scope.has_var(name) {
					if name !in captured {
						captured << name
					}
				}
			}
		}
		ast.node_bin_plus, ast.node_bin_minus, ast.node_bin_mul, ast.node_bin_div,
		ast.node_bin_mod, ast.node_bin_concat, ast.node_bin_greater, ast.node_bin_smaller,
		ast.node_bin_greater_equal, ast.node_bin_smaller_equal, ast.node_bin_equal,
		ast.node_bin_identical {
			if n := node.left { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
			if n := node.right { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
		}
		ast.node_expr_funccall {
			if n := node.expr { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
			if node.args.len > 0 {
				for n in node.args {
					t.find_captured_vars_rec(n, params, mut captured)
				}
			}
		}
		ast.node_expr_method_call {
			if n := node.var { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
			if node.args.len > 0 {
				for n in node.args {
					t.find_captured_vars_rec(n, params, mut captured)
				}
			}
		}
		ast.node_expr_property_fetch {
			if n := node.var { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
		}
		ast.node_expr_array {
			if node.items.len > 0 {
				for n in node.items {
					t.find_captured_vars_rec(n, params, mut captured)
				}
			}
		}
		ast.node_expr_array_item {
			if n := node.key { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
			if n := node.expr { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
		}
		ast.node_expr_array_dim_fetch {
			if n := node.var { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
			if n := node.dim { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
		}
		ast.node_expr_new {
			if node.args.len > 0 {
				for n in node.args {
					t.find_captured_vars_rec(n, params, mut captured)
				}
			}
		}
		else {
			if n := node.expr { if voidptr(n) != 0 { t.find_captured_vars_rec(*n, params, mut captured) } }
		}
	}
}

fn (t Transpiler) get_parents_expr(class_name string) string {
	mut parents := []string{}
	mut curr := class_name
	for {
		mut found := false
		for cls in t.classes {
			if cls.name == curr && cls.extends != '' {
				parents << cls.extends
				curr = cls.extends
				found = true
				break
			}
		}
		if !found {
			break
		}
	}
	if parents.len == 0 {
		return '[]string{}'
	}
	mut elements := []string{}
	for p in parents {
		elements << "'${p}'"
	}
	return '[${elements.join(", ")}]'
}

fn (t Transpiler) resolve_class_name(name string) string {
	if name == '' {
		return ''
	}
	mut full_name := name
	if full_name.starts_with('\\') {
		full_name = full_name.substr(1, full_name.len)
	} else {
		parts := full_name.split('\\')
		first_part := parts[0]
		if first_part in t.use_aliases {
			resolved_first := t.use_aliases[first_part]
			if parts.len > 1 {
				full_name = resolved_first + '\\' + parts[1..].join('\\')
			} else {
				full_name = resolved_first
			}
		} else if t.current_namespace != '' {
			full_name = t.current_namespace + '\\' + full_name
		}
	}
	return full_name.replace('\\', '_')
}

fn (t Transpiler) collect_vars_in_scope(nodes []ast.AstNode) ([]string, []string) {
	mut referenced := map[string]bool{}
	mut assigned := map[string]bool{}
	for node in nodes {
		t.collect_vars_in_scope_rec(node, mut referenced, mut assigned)
	}
	mut ref_list := []string{}
	for k, _ in referenced { ref_list << k }
	mut ass_list := []string{}
	for k, _ in assigned { ass_list << k }
	return ref_list, ass_list
}

fn (t Transpiler) collect_vars_in_scope_rec(node ast.AstNode, mut referenced map[string]bool, mut assigned map[string]bool) {
	if node.node_type in [ast.node_stmt_function, ast.node_stmt_class, ast.node_expr_closure] {
		return
	}
	
	match node.node_type {
		ast.node_expr_variable {
			if node.name != 'this' && node.name !in ['_GET', '_POST', '_SERVER', '_COOKIE', '_SESSION', '_REQUEST', '_ENV'] {
				referenced[node.name] = true
			}
		}
		ast.node_expr_assign {
			var_node := node.var or { &ast.AstNode{} }
			if voidptr(var_node) != 0 && var_node.node_type == ast.node_expr_variable {
				assigned[var_node.name] = true
			}
		}
		ast.node_stmt_foreach {
			if vv := node.value_var {
				if voidptr(vv) != 0 && vv.node_type == ast.node_expr_variable {
					assigned[vv.name] = true
				}
			}
			if kv := node.key_var {
				if voidptr(kv) != 0 && kv.node_type == ast.node_expr_variable {
					assigned[kv.name] = true
				}
			}
		}
		ast.node_stmt_catch {
			if v := node.var {
				if voidptr(v) != 0 && v.node_type == ast.node_expr_variable {
					assigned[v.name] = true
				}
			}
		}
		else {}
	}
	
	for expr in node.exprs { t.collect_vars_in_scope_rec(expr, mut referenced, mut assigned) }
	if expr := node.expr { if voidptr(expr) != 0 { t.collect_vars_in_scope_rec(*expr, mut referenced, mut assigned) } }
	if val := node.var { if voidptr(val) != 0 { t.collect_vars_in_scope_rec(*val, mut referenced, mut assigned) } }
	if left := node.left { if voidptr(left) != 0 { t.collect_vars_in_scope_rec(*left, mut referenced, mut assigned) } }
	if right := node.right { if voidptr(right) != 0 { t.collect_vars_in_scope_rec(*right, mut referenced, mut assigned) } }
	if cond := node.cond { if voidptr(cond) != 0 { t.collect_vars_in_scope_rec(*cond, mut referenced, mut assigned) } }
	for stmt in node.stmts { t.collect_vars_in_scope_rec(stmt, mut referenced, mut assigned) }
	for elseif in node.elseifs { t.collect_vars_in_scope_rec(elseif, mut referenced, mut assigned) }
	if el := node.@else { if voidptr(el) != 0 { t.collect_vars_in_scope_rec(*el, mut referenced, mut assigned) } }
	if iff := node.@if { if voidptr(iff) != 0 { t.collect_vars_in_scope_rec(*iff, mut referenced, mut assigned) } }
	for c in node.catches { t.collect_vars_in_scope_rec(c, mut referenced, mut assigned) }
	if fin := node.finally { if voidptr(fin) != 0 { t.collect_vars_in_scope_rec(*fin, mut referenced, mut assigned) } }
	for param in node.params { t.collect_vars_in_scope_rec(param, mut referenced, mut assigned) }
	for arg in node.args { t.collect_vars_in_scope_rec(arg, mut referenced, mut assigned) }
	for item in node.items { t.collect_vars_in_scope_rec(item, mut referenced, mut assigned) }
	if k := node.key { if voidptr(k) != 0 { t.collect_vars_in_scope_rec(*k, mut referenced, mut assigned) } }
	if d := node.dim { if voidptr(d) != 0 { t.collect_vars_in_scope_rec(*d, mut referenced, mut assigned) } }
	if kv := node.key_var { if voidptr(kv) != 0 { t.collect_vars_in_scope_rec(*kv, mut referenced, mut assigned) } }
	if vv := node.value_var { if voidptr(vv) != 0 { t.collect_vars_in_scope_rec(*vv, mut referenced, mut assigned) } }
	for init in node.init { t.collect_vars_in_scope_rec(init, mut referenced, mut assigned) }
	for cond in node.conds { t.collect_vars_in_scope_rec(cond, mut referenced, mut assigned) }
	for loop in node.loop { t.collect_vars_in_scope_rec(loop, mut referenced, mut assigned) }
	for prop in node.props { t.collect_vars_in_scope_rec(prop, mut referenced, mut assigned) }
	for use in node.uses { t.collect_vars_in_scope_rec(use, mut referenced, mut assigned) }
	for v in node.vars { t.collect_vars_in_scope_rec(v, mut referenced, mut assigned) }
	for p in node.parts { t.collect_vars_in_scope_rec(p, mut referenced, mut assigned) }
	for cs in node.cases { t.collect_vars_in_scope_rec(cs, mut referenced, mut assigned) }
	for arm in node.arms { t.collect_vars_in_scope_rec(arm, mut referenced, mut assigned) }
	if body := node.body { if voidptr(body) != 0 { t.collect_vars_in_scope_rec(*body, mut referenced, mut assigned) } }
}


struct SwitchBranch {
	conds      []ast.AstNode
	stmts      []ast.AstNode
	is_default bool
}

fn (mut t Transpiler) visit_switch(node ast.AstNode) {
	cond_node := node.cond or { return }
	cond_val_expr := t.visit_expr(*cond_node)

	t.switch_count++
	switch_var := 'switch_val_${t.switch_count}'

	t.write_indent()
	t.write_line('mut ${switch_var} := ${cond_val_expr}')

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

	if branches.len > 0 {
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
}





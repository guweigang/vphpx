module emitter

import strings
import php2v.ast

pub struct ClassInfo {
pub mut:
	name    string
	methods []MethodInfo
	props   []string
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
	is_in_func       bool
	indent           int
	scope            VarScope
	custom_functions map[string]bool
	classes          []ClassInfo
}

pub fn Transpiler.new() Transpiler {
	return Transpiler{
		out:              strings.new_builder(1024)
		func_out:         strings.new_builder(1024)
		indent:           1
		scope:            VarScope.new()
		custom_functions: map[string]bool{}
		classes:          []ClassInfo{}
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

	for stmt in stmts {
		t.visit_stmt(stmt)
	}
	
	t.generate_dispatchers()
	
	return t.out.str()
}

fn (mut t Transpiler) write_indent() {
	indent_str := '\t'.repeat(t.indent)
	if t.is_in_func {
		t.func_out.write_string(indent_str)
	} else {
		t.out.write_string(indent_str)
	}
}

fn (mut t Transpiler) write_line(s string) {
	if t.is_in_func {
		t.func_out.writeln(s)
	} else {
		t.out.writeln(s)
	}
}

fn (mut t Transpiler) write_string(s string) {
	if t.is_in_func {
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
				t.write_indent()
				expr_str := t.visit_expr(*expr)
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
		else {
			t.write_indent()
			t.write_line('// unsupported statement: ${node.node_type}')
		}
	}
}

fn (mut t Transpiler) visit_expr(node ast.AstNode) string {
	match node.node_type {
		ast.node_expr_variable {
			return 'var_${node.name}'
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
				else { return 'rt.new_string(\'${node.name}\')' }
			}
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
			func_name := node.name
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
			class_name := node.class_name
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
		else {
			return '// unsupported expression: ${node.node_type}'
		}
	}
}

fn (mut t Transpiler) visit_echo(node ast.AstNode) {
	for expr in node.exprs {
		t.write_indent()
		expr_str := t.visit_expr(expr)
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
	t.write_indent()
	if expr := node.expr {
		expr_str := t.visit_expr(*expr)
		t.write_line('return ${expr_str}')
	} else {
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

fn (mut t Transpiler) visit_for(node ast.AstNode) {
	t.write_indent()
	t.write_line('{')
	t.indent++
	
	old_scope := t.scope
	
	// 1. 初始化表达式
	for init_node in node.init {
		t.write_indent()
		expr_str := t.visit_expr(init_node)
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
		t.write_indent()
		expr_str := t.visit_expr(loop_node)
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
	
	// 收集 ClassInfo
	mut class_info := ClassInfo{
		name: node.name
		methods: []MethodInfo{}
		props: []string{}
	}
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
		}
	}
	t.classes << class_info

	// 生成结构体定义
	t.write_line('struct Class_${node.name} {')
	t.write_line('pub mut:')
	t.indent++
	for prop in class_info.props {
		t.write_indent()
		t.write_line('prop_${prop} rt.PhpVal')
	}
	t.indent--
	t.write_line('}')
	t.write_line('')

	// 遍历生成方法
	for stmt in node.stmts {
		if stmt.node_type == ast.node_stmt_class_method {
			t.visit_class_method(node.name, stmt)
		}
	}

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
	t.write_line('mut var_this := rt.new_object(\'${class_name}\', &this)')
	
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
		mut construct_info := ?MethodInfo(none)
		for m in cls.methods {
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
		t.write_line('mut obj := &Class_${cls.name}{')
		t.indent++
		for prop in cls.props {
			t.write_indent()
			t.write_line('prop_${prop}: rt.new_null()')
		}
		t.indent--
		t.write_indent()
		t.write_line('}')
		
		if construct_info != none {
			t.write_indent()
			t.write_line('obj.method___construct(${param_pass.join(", ")})')
		}
		
		t.write_indent()
		t.write_line('return rt.new_object(\'${cls.name}\', obj)')
		t.indent--
		t.write_line('}')
		t.write_line('')
	}

	// 2. 生成 call_method 全局路由分发器
	t.write_line('fn call_method(obj rt.PhpVal, method_name string, args []rt.PhpVal) rt.PhpVal {')
	t.indent++
	t.write_indent()
	t.write_line('if !obj.is_object() { return rt.new_null() }')
	t.write_indent()
	t.write_line('obj_info := obj.get_object()')
	t.write_indent()
	t.write_line('match obj_info.class_name {')
	t.indent++
	for cls in t.classes {
		t.write_indent()
		t.write_line('\'${cls.name}\' {')
		t.indent++
		t.write_indent()
		t.write_line('mut c_obj := &Class_${cls.name}(obj_info.ptr)')
		t.write_indent()
		t.write_line('match method_name {')
		t.indent++
		for m in cls.methods {
			t.write_indent()
			t.write_line('\'${m.name}\' {')
			t.indent++
			
			mut args_pass := []string{}
			for i in 0 .. m.param_count {
				args_pass << 'if args.len > ${i} { args[${i}] } else { rt.new_null() }'
			}
			t.write_indent()
			t.write_line('return c_obj.method_${m.name.to_lower()}(${args_pass.join(", ")})')
			
			t.indent--
			t.write_indent()
			t.write_line('}')
		}
		t.write_indent()
		t.write_line('else {}')
		t.indent--
		t.write_indent()
		t.write_line('}')
		t.indent--
		t.write_indent()
		t.write_line('}')
	}
	t.write_indent()
	t.write_line('else {}')
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.write_indent()
	t.write_line('return rt.new_null()')
	t.indent--
	t.write_line('}')
	t.write_line('')

	// 3. 生成 get_property 全局路由分发器
	t.write_line('fn get_property(obj rt.PhpVal, prop_name string) rt.PhpVal {')
	t.indent++
	t.write_indent()
	t.write_line('if !obj.is_object() { return rt.new_null() }')
	t.write_indent()
	t.write_line('obj_info := obj.get_object()')
	t.write_indent()
	t.write_line('match obj_info.class_name {')
	t.indent++
	for cls in t.classes {
		t.write_indent()
		t.write_line('\'${cls.name}\' {')
		t.indent++
		t.write_indent()
		t.write_line('c_obj := &Class_${cls.name}(obj_info.ptr)')
		t.write_indent()
		t.write_line('match prop_name {')
		t.indent++
		for prop in cls.props {
			t.write_indent()
			t.write_line('\'${prop}\' { return c_obj.prop_${prop} }')
		}
		t.write_indent()
		t.write_line('else {}')
		t.indent--
		t.write_indent()
		t.write_line('}')
		t.indent--
		t.write_indent()
		t.write_line('}')
	}
	t.write_indent()
	t.write_line('else {}')
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.write_indent()
	t.write_line('return rt.new_null()')
	t.indent--
	t.write_line('}')
	t.write_line('')

	// 4. 生成 set_property 全局路由分发器
	t.write_line('fn set_property(obj rt.PhpVal, prop_name string, val rt.PhpVal) {')
	t.indent++
	t.write_indent()
	t.write_line('if !obj.is_object() { return }')
	t.write_indent()
	t.write_line('obj_info := obj.get_object()')
	t.write_indent()
	t.write_line('match obj_info.class_name {')
	t.indent++
	for cls in t.classes {
		t.write_indent()
		t.write_line('\'${cls.name}\' {')
		t.indent++
		t.write_indent()
		t.write_line('mut c_obj := &Class_${cls.name}(obj_info.ptr)')
		t.write_indent()
		t.write_line('match prop_name {')
		t.indent++
		for prop in cls.props {
			t.write_indent()
			t.write_line('\'${prop}\' { c_obj.prop_${prop} = val }')
		}
		t.write_indent()
		t.write_line('else {}')
		t.indent--
		t.write_indent()
		t.write_line('}')
		t.indent--
		t.write_indent()
		t.write_line('}')
	}
	t.write_indent()
	t.write_line('else {}')
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.indent--
	t.write_line('}')
	t.write_line('')

	t.is_in_func = false
}

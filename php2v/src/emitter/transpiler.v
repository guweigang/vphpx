module emitter

import strings
import os
import php2v.src.ast

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
	
	if t.closures_code.len > 0 {
		t.func_out.write_string(t.closures_code.str())
	}
	
	t.generate_call_closure()
	
	return t.out.str()
}

fn (mut t Transpiler) write_indent() {
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
		ast.node_stmt_const {
			t.visit_const(node)
		}
		else {
			t.write_indent()
			t.write_line('// unsupported statement: ${node.node_type}')
		}
	}
}

fn (mut t Transpiler) visit_const(node ast.AstNode) {
	for c in node.consts {
		val_str := t.visit_expr(c.value)
		t.write_indent()
		t.write_line("rt.define_constant('${c.name}', ${val_str})")
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
			return 'rt.new_object(\'${class_name}\', &${class_name}{ ${init_fields.join(", ")} })'
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
			return 'rt.new_object(\'${class_name}\', &${class_name}{ ${init_fields.join(", ")} })'
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
			return '// unsupported static call: ${node.class_name}::${node.name}'
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
	t.current_class = node.name
	
	// 收集 ClassInfo：只收集本类自身声明的属性和方法
	mut class_info := ClassInfo{
		name: node.name
		extends: node.extends
		methods: []MethodInfo{}
		props: []string{}
		all_props: []string{}
		all_methods: []MethodInfo{}
	}
	
	mut own_method_names := map[string]bool{}
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
		}
	}
	
	// 构建 all_props / all_methods（含继承），用于 dispatch 生成
	if class_info.extends.len > 0 {
		for parent_cls in t.classes {
			if parent_cls.name == class_info.extends {
				// all_props = 父类全部属性 + 子类自身属性
				for p in parent_cls.all_props {
					class_info.all_props << p
				}
				for p in class_info.props {
					class_info.all_props << p
				}
				// all_methods = 子类自身方法 + 父类未被覆写的方法
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
	} else {
		class_info.all_props = class_info.props.clone()
		class_info.all_methods = class_info.methods.clone()
	}
	t.classes << class_info

	// 生成结构体定义（V struct embedding 方式）
	t.write_line('struct Class_${node.name} {')
	if class_info.extends.len > 0 {
		// 有继承：嵌入父类 struct
		t.write_line('\tClass_${class_info.extends}')
	} else {
		// 无继承：嵌入基类
		t.write_line('\tPhpObjectBase')
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
			t.visit_class_method(node.name, stmt)
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

// 递归生成嵌套的结构体初始化代码
fn (mut t Transpiler) generate_struct_init(cls ClassInfo, outer_name string) {
	if cls.extends.len > 0 {
		// 有继承：先嵌套初始化父类
		for parent_cls in t.classes {
			if parent_cls.name == cls.extends {
				t.write_indent()
				t.write_line('Class_${cls.extends}: Class_${cls.extends}{')
				t.indent++
				t.generate_struct_init(parent_cls, outer_name)
				t.indent--
				t.write_indent()
				t.write_line('}')
				break
			}
		}
	} else {
		// 最底层基类，初始化 PhpObjectBase 函数指针，实现运行时多态委托
		t.write_indent()
		t.write_line('PhpObjectBase: PhpObjectBase{')
		t.indent++

		t.write_indent()
		t.write_line('dispatch_method: fn (ptr voidptr, method_name string, args []rt.PhpVal) rt.PhpVal {')
		t.indent++
		t.write_indent()
		t.write_line('mut c := &Class_${outer_name}(ptr)')
		t.write_indent()
		t.write_line('return c.dispatch_method(method_name, args)')
		t.indent--
		t.write_indent()
		t.write_line('}')

		t.write_indent()
		t.write_line('dispatch_get_prop: fn (ptr voidptr, prop_name string) rt.PhpVal {')
		t.indent++
		t.write_indent()
		t.write_line('c := &Class_${outer_name}(ptr)')
		t.write_indent()
		t.write_line('return c.dispatch_get_prop(prop_name)')
		t.indent--
		t.write_indent()
		t.write_line('}')

		t.write_indent()
		t.write_line('dispatch_set_prop: fn (ptr voidptr, prop_name string, val rt.PhpVal) {')
		t.indent++
		t.write_indent()
		t.write_line('mut c := &Class_${outer_name}(ptr)')
		t.write_indent()
		t.write_line('c.dispatch_set_prop(prop_name, val)')
		t.indent--
		t.write_indent()
		t.write_line('}')

		t.indent--
		t.write_indent()
		t.write_line('}')
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

	// 0. 生成 PhpObjectBase 基类，它包含用于多态派发的分发函数指针
	t.write_line('struct PhpObjectBase {')
	t.write_line('mut:')
	t.write_line('\tdispatch_method   fn (ptr voidptr, method_name string, args []rt.PhpVal) rt.PhpVal = unsafe { nil }')
	t.write_line('\tdispatch_get_prop fn (ptr voidptr, prop_name string) rt.PhpVal = unsafe { nil }')
	t.write_line('\tdispatch_set_prop fn (ptr voidptr, prop_name string, val rt.PhpVal) = unsafe { nil }')
	t.write_line('}')
	t.write_line('')

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
		t.generate_struct_init(cls, cls.name)
		t.indent--
		t.write_indent()
		t.write_line('}')
		
		if construct_info != none {
			t.write_indent()
			// V struct embedding: 方法直接通过 promotion 调用，无需 unsafe
			t.write_line('obj.method___construct(${param_pass.join(", ")})')
		}
		
		t.write_indent()
		t.write_line('return rt.new_object(\'${cls.name}\', obj)')
		t.indent--
		t.write_line('}')
		t.write_line('')
	}

	// 2. 生成每个类的 dispatch_method / dispatch_get_prop / dispatch_set_prop
	for cls in t.classes {
		// dispatch_method：使用 all_methods（含继承），V promotion 自动处理
		t.write_line('fn (mut this Class_${cls.name}) dispatch_method(method_name string, args []rt.PhpVal) rt.PhpVal {')
		t.indent++
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
		t.write_indent()
		t.write_line('return rt.new_null()')
		t.indent--
		t.write_line('}')
		t.write_line('')

		// dispatch_get_prop：使用 all_props（含继承），V promotion 自动处理
		t.write_line('fn (this &Class_${cls.name}) dispatch_get_prop(prop_name string) rt.PhpVal {')
		t.indent++
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
		t.write_indent()
		t.write_line('return rt.new_null()')
		t.indent--
		t.write_line('}')
		t.write_line('')

		// dispatch_set_prop：使用 all_props（含继承），V promotion 自动处理
		t.write_line('fn (mut this Class_${cls.name}) dispatch_set_prop(prop_name string, val rt.PhpVal) {')
		t.indent++
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
		t.indent--
		t.write_line('}')
		t.write_line('')
	}

	// 3. 全局路由分发器，利用基类函数指针实现极简的多态委托
	t.write_line('fn call_method(obj rt.PhpVal, method_name string, args []rt.PhpVal) rt.PhpVal {')
	t.indent++
	t.write_indent()
	t.write_line('if !obj.is_object() { return rt.new_null() }')
	t.write_indent()
	t.write_line('obj_info := obj.get_object()')
	t.write_indent()
	t.write_line('base := &PhpObjectBase(obj_info.ptr)')
	t.write_indent()
	t.write_line('if base.dispatch_method != unsafe { nil } {')
	t.indent++
	t.write_indent()
	t.write_line('return base.dispatch_method(obj_info.ptr, method_name, args)')
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.write_indent()
	t.write_line('return rt.new_null()')
	t.indent--
	t.write_line('}')
	t.write_line('')

	t.write_line('fn get_property(obj rt.PhpVal, prop_name string) rt.PhpVal {')
	t.indent++
	t.write_indent()
	t.write_line('if !obj.is_object() { return rt.new_null() }')
	t.write_indent()
	t.write_line('obj_info := obj.get_object()')
	t.write_indent()
	t.write_line('base := &PhpObjectBase(obj_info.ptr)')
	t.write_indent()
	t.write_line('if base.dispatch_get_prop != unsafe { nil } {')
	t.indent++
	t.write_indent()
	t.write_line('return base.dispatch_get_prop(obj_info.ptr, prop_name)')
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.write_indent()
	t.write_line('return rt.new_null()')
	t.indent--
	t.write_line('}')
	t.write_line('')

	t.write_line('fn set_property(obj rt.PhpVal, prop_name string, val rt.PhpVal) {')
	t.indent++
	t.write_indent()
	t.write_line('if !obj.is_object() { return }')
	t.write_indent()
	t.write_line('obj_info := obj.get_object()')
	t.write_indent()
	t.write_line('mut base := &PhpObjectBase(obj_info.ptr)')
	t.write_indent()
	t.write_line('if base.dispatch_set_prop != unsafe { nil } {')
	t.indent++
	t.write_indent()
	t.write_line('base.dispatch_set_prop(obj_info.ptr, prop_name, val)')
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.indent--
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
	t.write_line('\tobj_info := cb.get_object()')
	t.write_line('\tmatch obj_info.class_name {')
	for name in t.closure_names {
		t.write_line('\t\t\'${name}\' {')
		t.write_line('\t\t\tmut c_obj := &${name}(obj_info.ptr)')
		t.write_line('\t\t\treturn c_obj.invoke(args)')
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

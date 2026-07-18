module emitter

import strings
import ast
import os

pub struct ClassInfo {
pub mut:
	name        string
	extends     string
	implements  []string
	methods     []MethodInfo // 本类自身声明的方法
	props       []string     // 本类自身声明的属性
	all_props   []string     // 含继承的全部属性（用于 dispatch_get/set_prop）
	all_methods []MethodInfo // 含继承的全部方法（用于 dispatch_method）
	prop_types  map[string]VarType            // 属性名 → 推导出的 V 原生类型
	param_types map[string]map[string]VarType // 方法名 → 参数名 → 推导类型
	return_types map[string]VarType           // 方法名 → 返回值推导类型
	const_types  map[string]VarType           // 类常量名 → 初始值推导类型
	prop_defaults map[string]string           // 属性名 → V 侧的默认值表达式
}

pub struct MethodInfo {
pub:
	name        string
	param_count int
	param_names []string
	is_variadic bool
	is_static   bool
	param_by_ref []bool
	has_dynamic_args bool
}

// StaticPropInfo 记录类的静态属性声明
pub struct StaticPropInfo {
pub:
	name         string
	default_expr string
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
	scope            &VarScope
	custom_functions map[string]bool
	classes          []ClassInfo
	class_name_map   map[string]int
	current_class    string // 当前正在转译的类名（用于 parent:: 解析）
	current_file     string
	parser_php_path  string
	transpiled_includes   map[string]string // 绝对路径 -> 转译后的 V 函数名
	include_funcs_code    strings.Builder   // 已转译的 include 函数定义
	include_register_code strings.Builder   // 注册 include 的代码段
	try_count        int
	current_catch_label string // 当前语句所属 of the try-catch block's catch label
	current_finally_label string // 当前语句所属 of the try-catch block's finally label
	undeclared_classes map[string]bool
	current_namespace string
	use_aliases map[string]string
	switch_count int
	list_tmp_counter int
	pre_stmts []string
	post_stmts []string
	const_out strings.Builder
	traits    map[string]ast.AstNode
	needs_method_dispatch  bool
	needs_prop_dispatch    bool
	needs_closure_dispatch bool
	last_expr_type         VarType
	inferred_types         map[string]VarType
	mutated_vars           map[string]bool // P10: 被原地修改的变量（array_push/inc/dec/unset）
	ctor_arg_types         map[string][]TypeTag // P7: class_name → 构造函数实参类型列表（从调用点推断）
	method_call_arg_types  map[string][]TypeTag // "class_name::method_name" → 实参类型列表
	native_params          map[string]bool // P7: 当前方法的原生类型参数名（无 var_ 前缀，无装箱）
	reassigned_params      map[string]bool // 被重新赋值的原生参数名（需使用 var_xxx 副本）
	is_in_construct        bool            // 当前是否在 __construct 方法中（无返回值）
	is_in_switch         bool            // 当前是否在 switch/case 中（break 无需生成）
	collect_referenced   map[string]bool
	collect_assigned     map[string]bool
	collect_globals      map[string]bool
	collect_statics      map[string]bool
	global_constants       map[string]GlobalConst // 全局常量表
	closure_body_builder   strings.Builder // 当前闭包体的临时输出缓冲区
	is_in_closure_body     bool            // 是否正在生成闭包体代码
	closure_captured_natives map[string]VarType // 闭包中捕获的原生类型变量
	extra_imports          map[string]bool // 需要额外导入的 V 模块
	func_call_arg_types    map[string][]TypeTag         // 函数名 → 调用点实参类型列表
	func_param_types       map[string]map[string]VarType // 函数名 → 参数名 → 推导类型
	func_return_types      map[string]VarType            // 函数名 → 返回值推导类型
	current_func_name      string                         // 当前正在转译的函数名
	current_func_ret_type  VarType                        // 当前函数的返回值类型
	func_var_types         map[string]map[string]VarType // 函数名 → 局部变量名 → 推导类型
	declared_classes       map[string]bool               // 已声明的类
	declared_classes_in_file map[string]bool               // 在本文件中显式声明的类
	expected_type          VarType                       // 上下文期望类型
	var_aliases            map[string]string             // 变量重命名映射（处理局部变量遮蔽冲突）
	foreach_depth          int                           // 循环嵌套深度（用于生成唯一的迭代器变量名）
	native_vars            map[string]bool               // 本地声明的原生变量（用于精确判定是否需要装箱）
	native_arr_vars        map[string]bool               // 已知持有原生数组/map的变量（用于array_dim_fetch确认）
	custom_function_infos  map[string]MethodInfo         // 自定义全局函数签名信息（含可变参数状态）
	has_dynamic_new         bool
	has_dynamic_method_call bool
	has_dynamic_func_call   bool
	active_depth            int
	mode                    string
	is_entry_script         bool
	is_sub_transpiler       bool
	allowed_includes        []string
	method_param_v_types    map[string][]string
}

pub struct GlobalConst {
pub mut:
	name     string
	val_expr string
	typ      VarType
}

pub fn Transpiler.new() Transpiler {
	return Transpiler{
		mode:             'exe'
		out:              strings.new_builder(1024)
		func_out:         strings.new_builder(1024)
		closures_code:    strings.new_builder(1024)
		const_out:        strings.new_builder(1024)
		indent:           1
		scope:            &VarScope{ declared: map[string]bool{} }
		custom_functions: map[string]bool{}
		custom_function_infos: map[string]MethodInfo{}
		classes:          []ClassInfo{}
		class_name_map:   map[string]int{}
		current_file:     ''
		parser_php_path:  ''
		transpiled_includes:   map[string]string{}
		include_funcs_code:    strings.new_builder(1024)
		include_register_code: strings.new_builder(1024)
		foreach_depth:    0
		var_aliases:      map[string]string{}
		native_vars:      map[string]bool{}
		native_arr_vars:  map[string]bool{}
		undeclared_classes: map[string]bool{}
		current_namespace: ''
		use_aliases: map[string]string{}
		switch_count: 0
		pre_stmts: []string{}
		post_stmts: []string{}
		traits: map[string]ast.AstNode{}
		last_expr_type: VarType{ tag: .t_unknown }
		inferred_types: map[string]VarType{}
		mutated_vars: map[string]bool{}
		ctor_arg_types: map[string][]TypeTag{}
		native_params: map[string]bool{}
		reassigned_params: map[string]bool{}
		global_constants: map[string]GlobalConst{}
		method_param_v_types: map[string][]string{}
		collect_referenced: map[string]bool{}
		collect_assigned: map[string]bool{}
		collect_globals: map[string]bool{}
		collect_statics: map[string]bool{}
		closure_body_builder: strings.new_builder(64)
		closure_captured_natives: map[string]VarType{}
		extra_imports: map[string]bool{}
		func_call_arg_types: map[string][]TypeTag{}
		func_param_types: map[string]map[string]VarType{}
		func_return_types: map[string]VarType{}
		func_var_types: map[string]map[string]VarType{}
		declared_classes: map[string]bool{}
		declared_classes_in_file: map[string]bool{}
		expected_type: VarType{ tag: .t_unknown }
		has_dynamic_new:         false
		has_dynamic_method_call: false
		has_dynamic_func_call:   false
		allowed_includes: [
			'wp-includes/plugin.php',
			'wp-includes/class-wp-hook.php',
			'wp-includes/load.php',
			'wp-includes/default-filters.php',
			'wp-includes/version.php',
			'wp-includes/compat.php',
			'wp-blog-header.php',
			'wp-load.php',
			'wp-config.php',
			'wp-settings.php',
			'tests/fixtures/'
		]
	}
}

// transpile 预扫描函数并遍历语句，返回生成的 V 代码
pub fn (mut t Transpiler) transpile(stmts []ast.AstNode) string {
	println('Transpiling file start: ' + t.current_file)
	mut local_stmts := stmts.clone()
	t.collect_traits(mut local_stmts)
	t.apply_traits(mut local_stmts)

	// 前置扫描并登记全局常量
	println('  - scan_global_constants')
	t.scan_global_constants(local_stmts)

	// 前置扫描并登记全局类与 Exception
	println('  - scan_classes')
	t.scan_classes(local_stmts)
	t.rebuild_class_map()

	// 预扫描顶层及嵌套自定义函数，登记到 custom_functions 中
	println('  - scan_custom_functions')
	t.scan_custom_functions(local_stmts)

	// 前置类型分析
	println('  - analyze_types')
	t.analyze_types(local_stmts)

	// 扫描动态使用特征
	println('  - scan_dynamic_usages')
	t.scan_dynamic_usages(local_stmts)

	// 检测入口脚本：如果顶层代码包含 exit/die，标记为入口脚本
	if t.mode == 'lib' && t.has_exit_or_die(local_stmts) {
		t.is_entry_script = true
	}

	println('  - collect_vars_in_scope')
	ref_vars, ass_vars := t.collect_vars_in_scope(&local_stmts)
	for v in ref_vars {
		if v !in ass_vars && !t.scope.has_var(v) {
			t.write_indent()
			v_var := t.get_v_var_name(v)
			v_type := t.inferred_types[v_var] or { t.inferred_types[v] or { VarType{ tag: .t_unknown } } }
			if v_type.is_native_list || v_type.is_native_map {
				t.write_line('mut ${v_var} := ' + t.get_empty_literal(v_type))
				t.native_arr_vars[v] = true
			} else if (t.current_func_name != '' || !t.is_mixed_aot()) && v_type.is_scalar() {
				t.native_vars[v_var] = true
				match v_type.tag {
					.t_int { t.write_line('mut ${v_var} := i64(0)') }
					.t_float { t.write_line('mut ${v_var} := f64(0.0)') }
					.t_bool { t.write_line('mut ${v_var} := false') }
					else { t.write_line("mut ${v_var} := ''") }
				}
			} else if (t.current_func_name != '' || !t.is_mixed_aot()) && v_type.is_object() {
				cls := if v_type.class_name.len > 0 { v_type.class_name } else { 'WP_Error' }
				t.write_line('mut ${v_var} := &Class_${cls}(unsafe { nil })')
			} else {
				t.write_line('mut ${v_var} := rt.new_null()')
			}
			t.scope.declare(v)
		}
	}

	for v in ass_vars {
		if !t.scope.has_var(v) {
			t.scope.declare(v)
			t.write_indent()
			v_var := t.get_v_var_name(v)
			v_type := t.inferred_types[v_var] or { t.inferred_types[v] or { VarType{ tag: .t_unknown } } }
			if v_type.is_native_list || v_type.is_native_map {
				t.write_line('mut ${v_var} := ' + t.get_empty_literal(v_type))
				t.native_arr_vars[v] = true
			} else if (t.current_func_name != '' || !t.is_mixed_aot()) && v_type.is_scalar() {
				t.native_vars[v_var] = true
				match v_type.tag {
					.t_int { t.write_line('mut ${v_var} := i64(0)') }
					.t_float { t.write_line('mut ${v_var} := f64(0.0)') }
					.t_bool { t.write_line('mut ${v_var} := false') }
					else { t.write_line("mut ${v_var} := ''") }
				}
			} else if (t.current_func_name != '' || !t.is_mixed_aot()) && v_type.is_object() {
				cls := if v_type.class_name.len > 0 { v_type.class_name } else { 'WP_Error' }
				t.write_line('mut ${v_var} := &Class_${cls}(unsafe { nil })')
			} else {
				t.write_line('mut ${v_var} := rt.new_null()')
			}
		}
	}

	println('  - visit_stmt loop start')
	for stmt in local_stmts {
		t.visit_stmt(stmt)
	}
	println('  - visit_stmt loop end')

	// 补全在转译中遇到的未显式声明的类（如 Exception 等内置类）仅在最外层转译器中生成
	if !t.is_sub_transpiler {
		body_code := t.out.str()
		t.out.clear()
		
		old_is_in_func := t.is_in_func
		t.is_in_func = true
		eprintln('DECLARED CLASSES: ${t.declared_classes.keys()}')
		eprintln('UNDECLARED CLASSES: ${t.undeclared_classes.keys()}')
		for name, _ in t.undeclared_classes {
			if t.declared_classes[name] {
				continue
			}
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
					new_cls.prop_types['message'] = VarType{ tag: .t_string }
					new_cls.prop_types['code'] = VarType{ tag: .t_int }
					new_cls.prop_types['file'] = VarType{ tag: .t_string }
					new_cls.prop_types['line'] = VarType{ tag: .t_int }
					new_cls.methods << MethodInfo{ name: '__construct', param_count: 1, param_names: ['message'] }
					new_cls.methods << MethodInfo{ name: 'getMessage', param_count: 0, param_names: []string{} }
					new_cls.return_types['getMessage'] = VarType{ tag: .t_string }
				}
				new_cls.all_props = new_cls.props.clone()
				new_cls.all_methods = new_cls.methods.clone()
				
				mut cls_found := false
				for cls in t.classes {
					if cls.name == new_cls.name {
						cls_found = true
						break
					}
				}
				if !cls_found {
					t.classes << new_cls
				}
				
				t.write_line('struct Class_${name} {')
				t.write_line('\trt.PhpObjectBase')
				if new_cls.props.len > 0 {
					t.write_line('pub mut:')
					t.indent++
					for prop in new_cls.props {
						t.write_indent()
						if name == 'Exception' {
							match prop {
								'message', 'file' { t.write_line('${prop_v_name(prop)} string') }
								'code', 'line' { t.write_line('${prop_v_name(prop)} i64') }
								else { t.write_line('${prop_v_name(prop)} rt.PhpVal') }
							}
						} else {
							t.write_line('prop_${prop} rt.PhpVal')
						}
					}
					t.indent--
				} else {
					t.write_line('pub mut:')
					t.write_line('\t_dummy bool')
				}
				t.write_line('}')
				t.write_line('')

				if name == 'Exception' {
					old_indent := t.indent
					t.indent = 0
					t.write_line('fn (mut this Class_Exception) ${method_v_name("__construct")}(var_message rt.PhpVal) {')
					t.indent++
					t.write_indent()
					t.write_line('this.message = var_message.to_string()')
					t.indent--
					t.write_line('}')
					t.write_line('')

					t.write_line('fn (mut this Class_Exception) ${method_v_name("getMessage")}() string {')
					t.indent++
					t.write_indent()
					t.write_line('return this.message')
					t.indent--
					t.write_line('}')
					t.write_line('')
					t.indent = old_indent
				}
		}
		t.is_in_func = old_is_in_func
		
		stub_code := t.out.str()
		t.func_out.write_string(stub_code)
		t.out.clear()
		t.out.write_string(body_code)
	}
	
	mut class_names := []string{}
	for cls in t.classes {
		class_names << cls.name
	}
	eprintln('CLASSES IN TRANSPILER: ${class_names}')
	
	t.generate_dispatchers()
	t.generate_registry_initializers()
	
	if t.closures_code.len > 0 {
		t.func_out.write_string(t.closures_code.str())
	}

	if t.const_out.len > 0 {
		mut new_func_out := strings.new_builder(t.const_out.len + t.func_out.len)
		new_func_out.write_string(t.const_out.str())
		new_func_out.write_string(t.func_out.str())
		t.func_out = new_func_out
	}

	return t.out.str()
}

// has_exit_or_die 递归扫描 AST 检测是否存在 exit/die 语句
fn (t Transpiler) has_exit_or_die(stmts []ast.AstNode) bool {
	for stmt in stmts {
		if stmt.node_type == ast.node_expr_exit {
			return true
		}
		// 检查子节点
		if expr := stmt.expr {
			if t.has_exit_or_die([*expr]) {
				return true
			}
		}
		if stmt.stmts.len > 0 {
			if t.has_exit_or_die(stmt.stmts) {
				return true
			}
		}
		if stmt.elseifs.len > 0 {
			for ei in stmt.elseifs {
				if t.has_exit_or_die(ei.stmts) {
					return true
				}
			}
		}
		if else_node := stmt.@else {
			if t.has_exit_or_die(else_node.stmts) {
				return true
			}
		}
		if stmt.catches.len > 0 {
			for c in stmt.catches {
				if t.has_exit_or_die(c.stmts) {
					return true
				}
			}
		}
	}
	return false
}

fn (mut t Transpiler) current_builder() &strings.Builder {
	if t.is_in_closure_body {
		return &t.closure_body_builder
	} else if t.is_in_func {
		return &t.func_out
	} else {
		return &t.out
	}
}

fn (mut t Transpiler) flush_pre_stmts() {
	if t.pre_stmts.len > 0 {
		pre := t.pre_stmts.clone()
		t.pre_stmts.clear()
		mut b := t.current_builder()
		indent_str := '\t'.repeat(t.indent)
		for stmt in pre {
			for line in stmt.split('\n') {
				b.writeln('${indent_str}${line}')
			}
		}
	}
}

fn (mut t Transpiler) write_indent() {
	t.flush_pre_stmts()
	indent_str := '\t'.repeat(t.indent)
	mut b := t.current_builder()
	b.write_string(indent_str)
}

fn (mut t Transpiler) write_line(s string) {
	mut b := t.current_builder()
	b.writeln(s)
}

fn (mut t Transpiler) write_string(s string) {
	mut b := t.current_builder()
	b.write_string(s)
}

fn (mut t Transpiler) collect_traits(mut stmts []ast.AstNode) {
	mut filtered := []ast.AstNode{}
	for i in 0 .. stmts.len {
		mut stmt := stmts[i]
		if stmt.node_type == ast.node_stmt_trait {
			t.traits[stmt.name] = *stmt.clone()
		} else {
			if stmt.node_type == ast.node_stmt_namespace {
				t.collect_traits(mut stmts[i].stmts)
			}
			filtered << *stmts[i].clone()
		}
	}
	for stmts.len > 0 {
		stmts.delete(0)
	}
	for f in filtered {
		stmts << f
	}
}

fn (mut t Transpiler) apply_traits(mut stmts []ast.AstNode) {
	for i in 0 .. stmts.len {
		if stmts[i].node_type == ast.node_stmt_class {
			mut new_class_stmts := []ast.AstNode{}
			for j in 0 .. stmts[i].stmts.len {
				class_stmt := stmts[i].stmts[j]
				if class_stmt.node_type == ast.node_stmt_trait_use {
					for trait_name in class_stmt.traits {
						resolved_trait := t.resolve_class_name(trait_name)
						if tr := t.traits[resolved_trait] {
							for trait_member in tr.stmts {
								new_class_stmts << *trait_member.clone()
							}
						}
					}
				} else {
					new_class_stmts << *class_stmt.clone()
				}
			}
			for stmts[i].stmts.len > 0 {
				stmts[i].stmts.delete(0)
			}
			for ncs in new_class_stmts {
				stmts[i].stmts << ncs
			}
		} else if stmts[i].node_type == ast.node_stmt_namespace {
			t.apply_traits(mut stmts[i].stmts)
		}
	}
}

// ─── P7: 对象 V 原生化辅助方法 ─────────────────────────────

// V 保留字集合
fn is_v_keyword(name string) bool {
	return name in ['as', 'asm', 'assert', 'atomic', 'break', 'const', 'continue',
		'defer', 'else', 'enum', 'false', 'fn', 'for', 'go', 'goto', 'if',
		'implements', 'import', 'in', 'interface', 'is', 'lock', 'match',
		'module', 'mut', 'none', 'or', 'pub', 'return', 'rlock', 'select',
		'shared', 'sizeof', 'static', 'struct', 'true', 'type', 'typeof',
		'union', 'unsafe', 'volatile', 'this']
}

// 属性在 V 中的字段名（去掉 prop_ 前缀，V 关键字冲突时保留前缀）
fn prop_v_name(prop_name string) string {
	if is_v_keyword(prop_name) {
		return 'prop_${prop_name}'
	}
	return prop_name
}

// 全局函数在 V 中的命名（若跟 V 保留关键字冲突，加 func_ 前缀）
fn func_v_name(name string) string {
	lower_name := name.to_lower()
	if is_v_keyword(lower_name) || lower_name in ['print', 'println', 'error', 'panic', 'exit'] {
		return 'func_${lower_name}'
	}
	if lower_name.starts_with('_') {
		return 'f' + lower_name
	}
	return lower_name
}

// 方法在 V 中的方法名（去掉 method_ 前缀）
fn method_v_name(method_name string) string {
	// V 不允许方法名以 _ 开头，PHP 魔术方法 __xxx 需要特殊处理
	// __construct → construct（去掉下划线前缀）
	// 其他魔术方法：加 magic_ 前缀，如 __toString → magic_tostring
	if method_name.starts_with('__') {
		if method_name == '__construct' {
			return 'construct'
		}
		return 'magic_' + method_name[2..].to_lower()
	}
	return method_name.to_lower()
}

// 查找类属性的推导类型（含继承链查找）
fn (t &Transpiler) get_class_prop_type(class_name string, prop_name string) VarType {
	return t.get_class_prop_type_rec(class_name, prop_name, [])
}

fn (t &Transpiler) get_class_prop_type_rec(class_name string, prop_name string, visited []string) VarType {
	if class_name in visited {
		return VarType{ tag: .t_unknown }
	}
	mut next_visited := visited.clone()
	next_visited << class_name
	idx := t.class_name_map[class_name.to_lower()] or { -1 }
	if idx != -1 {
		cls := t.classes[idx]
		if typ := find_vartype_map_insensitive(cls.prop_types, prop_name) {
			return typ
		}
		if cls.extends.len > 0 {
			return t.get_class_prop_type_rec(cls.extends, prop_name, next_visited)
		}
	}
	return VarType{ tag: .t_unknown }
}

// 查找类方法的参数类型
fn (t &Transpiler) get_method_param_type(class_name string, method_name string, param_name string) VarType {
	return t.get_method_param_type_rec(class_name, method_name, param_name, [])
}

fn (t &Transpiler) get_method_param_type_rec(class_name string, method_name string, param_name string, visited []string) VarType {
	if class_name in visited {
		return VarType{ tag: .t_unknown }
	}
	mut next_visited := visited.clone()
	next_visited << class_name
	idx := t.class_name_map[class_name.to_lower()] or { -1 }
	if idx != -1 {
		cls := t.classes[idx]
		if params := find_param_map_insensitive(cls.param_types, method_name) {
			if typ := find_vartype_map_insensitive(params, param_name) {
				return typ
			}
		}
		if cls.extends.len > 0 {
			return t.get_method_param_type_rec(cls.extends, method_name, param_name, next_visited)
		}
	}
	return VarType{ tag: .t_unknown }
}

// 查找类方法的返回值类型
fn (t &Transpiler) get_method_return_type(class_name string, method_name string) VarType {
	return t.get_method_return_type_rec(class_name, method_name, [])
}

fn (t &Transpiler) get_method_return_type_rec(class_name string, method_name string, visited []string) VarType {
	if class_name in visited {
		return VarType{ tag: .t_unknown }
	}
	mut next_visited := visited.clone()
	next_visited << class_name
	idx := t.class_name_map[class_name.to_lower()] or { -1 }
	if idx != -1 {
		cls := t.classes[idx]
		if typ := find_vartype_map_insensitive(cls.return_types, method_name) {
			return typ
		}
		if cls.extends.len > 0 {
			return t.get_method_return_type_rec(cls.extends, method_name, next_visited)
		}
	}
	return VarType{ tag: .t_unknown }
}

// 查找类方法的参数类型映射（参数名 → 类型）
fn (t &Transpiler) param_types_for_method(class_name string, method_name string) ?map[string]VarType {
	return t.param_types_for_method_rec(class_name, method_name, [])
}

fn (t &Transpiler) param_types_for_method_rec(class_name string, method_name string, visited []string) ?map[string]VarType {
	if class_name in visited {
		return none
	}
	mut next_visited := visited.clone()
	next_visited << class_name
	idx := t.class_name_map[class_name.to_lower()] or { -1 }
	if idx != -1 {
		cls := t.classes[idx]
		if params := find_param_map_insensitive(cls.param_types, method_name) {
			return params
		}
		if cls.extends.len > 0 {
			return t.param_types_for_method_rec(cls.extends, method_name, next_visited)
		}
	}
	return none
}

// 检查类是否继承/实现指定的类或接口
fn (t &Transpiler) is_class_instance_of(child_class string, target string) bool {
	return t.is_class_instance_of_rec(child_class, target, [])
}

fn (t &Transpiler) is_class_instance_of_rec(child_class string, target string, visited []string) bool {
	if child_class == target {
		return true
	}
	if child_class in visited {
		return false
	}
	mut next_visited := visited.clone()
	next_visited << child_class
	idx := t.class_name_map[child_class.to_lower()] or { -1 }
	if idx != -1 {
		cls := t.classes[idx]
		// 检查 implements
		for iface in cls.implements {
			if iface == target {
				return true
			}
		}
		// 递归检查父类
		if cls.extends.len > 0 {
			return t.is_class_instance_of_rec(cls.extends, target, next_visited)
		}
	}
	return false
}

pub fn (mut t Transpiler) rebuild_class_map() {
	t.class_name_map.clear()
	for i, cls in t.classes {
		t.class_name_map[cls.name.to_lower()] = i
	}
}

// scan_global_constants 静态分析顶层 AST，提取全局 const 和全局 define() 并注册
pub fn (mut t Transpiler) scan_global_constants(stmts []ast.AstNode) {
	for stmt in stmts {
		t.scan_global_constants_rec(&stmt)
	}
}

fn (mut t Transpiler) scan_global_constants_rec(node &ast.AstNode) {
	match node.node_type {
		ast.node_stmt_const {
			for c in node.consts {
				val_type := t.get_expr_type(c.value)
				mut val_expr := ''
				if static_val := t.eval_static_path(c.value) {
					val_expr = "'" + static_val + "'"
				} else {
					val_expr = t.visit_expr(c.value)
				}
				t.global_constants[c.name] = GlobalConst{
					name: 'global_const_' + c.name.to_lower()
					val_expr: val_expr
					typ: val_type
				}
			}
		}
		ast.node_stmt_expression {
			if expr := node.expr {
				if expr.node_type == ast.node_expr_funccall && expr.name == 'define' {
					if expr.args.len >= 2 {
						name_node := expr.args[0].expr or { return }
						val_node := expr.args[1].expr or { return }
						if name_node.node_type == ast.node_scalar_string {
							val_type := t.get_expr_type(*val_node)
							mut val_expr := ''
							if static_val := t.eval_static_path(*val_node) {
								val_expr = "'" + static_val + "'"
							} else {
								val_expr = t.visit_expr(val_node)
							}
							t.global_constants[name_node.value] = GlobalConst{
								name: 'global_const_' + name_node.value.to_lower()
								val_expr: val_expr
								typ: val_type
							}
						}
					}
				}
			}
		}
		else {}
	}

	for i in 0 .. node.exprs.len { t.scan_global_constants_rec(&node.exprs[i]) }
	if expr := node.expr { t.scan_global_constants_rec(expr) }
	if val := node.var { t.scan_global_constants_rec(val) }
	if left := node.left { t.scan_global_constants_rec(left) }
	if right := node.right { t.scan_global_constants_rec(right) }
	if cond := node.cond { t.scan_global_constants_rec(cond) }
	for i in 0 .. node.stmts.len { t.scan_global_constants_rec(&node.stmts[i]) }
	for i in 0 .. node.elseifs.len { t.scan_global_constants_rec(&node.elseifs[i]) }
	if el := node.@else { t.scan_global_constants_rec(el) }
	if iff := node.@if { t.scan_global_constants_rec(iff) }
	for i in 0 .. node.catches.len { t.scan_global_constants_rec(&node.catches[i]) }
	if fin := node.finally { t.scan_global_constants_rec(fin) }
	for i in 0 .. node.params.len { t.scan_global_constants_rec(&node.params[i]) }
	for i in 0 .. node.args.len { t.scan_global_constants_rec(&node.args[i]) }
	for i in 0 .. node.items.len { t.scan_global_constants_rec(&node.items[i]) }
	if k := node.key { t.scan_global_constants_rec(k) }
	if d := node.dim { t.scan_global_constants_rec(d) }
	if kv := node.key_var { t.scan_global_constants_rec(kv) }
	if vv := node.value_var { t.scan_global_constants_rec(vv) }
	for i in 0 .. node.init.len { t.scan_global_constants_rec(&node.init[i]) }
	for i in 0 .. node.conds.len { t.scan_global_constants_rec(&node.conds[i]) }
	for i in 0 .. node.loop.len { t.scan_global_constants_rec(&node.loop[i]) }
	for i in 0 .. node.props.len { t.scan_global_constants_rec(&node.props[i]) }
	for i in 0 .. node.uses.len { t.scan_global_constants_rec(&node.uses[i]) }
	for i in 0 .. node.vars.len { t.scan_global_constants_rec(&node.vars[i]) }
	for i in 0 .. node.parts.len { t.scan_global_constants_rec(&node.parts[i]) }
	for i in 0 .. node.cases.len { t.scan_global_constants_rec(&node.cases[i]) }
	for i in 0 .. node.arms.len { t.scan_global_constants_rec(&node.arms[i]) }
	if body := node.body { t.scan_global_constants_rec(body) }
}

// 辅助提取属性默认值的 V 表达式
fn get_prop_default_expr(node &ast.AstNode) string {
	match node.node_type {
		ast.node_expr_array {
			mut is_list := true
			for item in node.items {
				if item.key != none {
					is_list = false
					break
				}
			}
			if is_list {
				mut val_strs := []string{}
				for item in node.items {
					if val_node := item.expr {
						val_strs << get_prop_default_expr(*val_node)
					}
				}
				return 'rt.create_array_from_list([ ${val_strs.join(", ")} ])'
			} else {
				mut item_strs := []string{}
				for item in node.items {
					if val_node := item.expr {
						val_expr := get_prop_default_expr(*val_node)
						if key_node := item.key {
							key_expr := get_prop_default_expr(*key_node)
							item_strs << 'rt.ArrayItem{ key: ${key_expr}, val: ${val_expr} }'
						} else {
							item_strs << 'rt.ArrayItem{ key: none, val: ${val_expr} }'
						}
					}
				}
				return 'rt.create_array([ ${item_strs.join(", ")} ])'
			}
		}
		ast.node_scalar_string { return "rt.new_string('${escape_single_quoted(node.value)}')" }
		ast.node_scalar_int { return 'rt.new_int(${node.value})' }
		ast.node_scalar_float { return 'rt.new_float(${node.value})' }
		ast.node_expr_const {
			if node.name.to_lower() == 'true' { return 'rt.new_bool(true)' }
			if node.name.to_lower() == 'false' { return 'rt.new_bool(false)' }
			if node.name.to_lower() == 'null' { return 'rt.new_null()' }
		}
		else {}
	}
	return 'rt.new_null()'
}

// scan_classes 静态扫描并登记全局 ClassInfo 到 t.classes，并前置注册 Exception 基类
pub fn (mut t Transpiler) scan_classes(stmts []ast.AstNode) {
	for stmt in stmts {
		if stmt.node_type == ast.node_stmt_class {
			resolved_name := t.resolve_class_name(stmt.name)
			mut methods := []MethodInfo{}
			mut props := []string{}
			mut prop_defaults := map[string]string{}
			mut const_types := map[string]VarType{}
			for member in stmt.stmts {
				match member.node_type {
					ast.node_stmt_property {
						for p in member.props {
							props << p.name
							if default_node := p.default_val {
								if voidptr(default_node) != 0 {
									prop_defaults[p.name] = get_prop_default_expr(*default_node)
								}
							}
						}
					}
					ast.node_stmt_class_method {
						mut p_names := []string{}
						mut p_by_ref := []bool{}
						for param in member.params {
							if param_var := param.var {
								p_names << param_var.name
							}
							p_by_ref << (param.by_ref == 'true')
						}
						is_meth_static := (member.flags.int() & 8) != 0
						has_dyn := has_dynamic_args_call(member.stmts)
						methods << MethodInfo{
							name: member.name
							param_count: member.params.len
							param_names: p_names
							is_static: is_meth_static
							param_by_ref: p_by_ref
							has_dynamic_args: has_dyn
						}
					}
					ast.node_stmt_class_const {
						for c in member.consts {
							const_types[c.name] = t.get_expr_type(c.value)
						}
					}
					else {}
				}
			}
			resolved_extends := if stmt.extends.len > 0 { t.resolve_class_name(stmt.extends) } else { '' }
			
			// 避免重复 append
			mut found := false
			for cls in t.classes {
				if cls.name == resolved_name {
					found = true
					break
				}
			}
			if !found {
				t.classes << ClassInfo{
					name: resolved_name
					extends: resolved_extends
					implements: stmt.implements.map(t.resolve_class_name(it))
					methods: methods
					props: props
					all_props: []string{}
					all_methods: []MethodInfo{}
					prop_types: map[string]VarType{}
					param_types: map[string]map[string]VarType{}
					return_types: map[string]VarType{}
					const_types: const_types
					prop_defaults: prop_defaults
				}
			}
		}
	}

	// 提前注册内置的 Exception 类到 t.classes 和 t.undeclared_classes 中
	mut has_exception := false
	for cls in t.classes {
		if cls.name == 'Exception' {
			has_exception = true
			break
		}
	}
	mut inherits_exception := false
	for cls in t.classes {
		if cls.extends == 'Exception' {
			inherits_exception = true
			break
		}
	}
	if inherits_exception && !has_exception {
		t.undeclared_classes['Exception'] = true
		
		mut new_cls := ClassInfo{
			name: 'Exception'
			extends: ''
			methods: []MethodInfo{}
			props: []string{}
			all_props: []string{}
			all_methods: []MethodInfo{}
			prop_types: map[string]VarType{}
			param_types: map[string]map[string]VarType{}
			return_types: map[string]VarType{}
		}
		new_cls.props << ['message', 'code', 'file', 'line']
		new_cls.prop_types['message'] = VarType{ tag: .t_string }
		new_cls.prop_types['code'] = VarType{ tag: .t_int }
		new_cls.prop_types['file'] = VarType{ tag: .t_string }
		new_cls.prop_types['line'] = VarType{ tag: .t_int }
		new_cls.methods << MethodInfo{ name: '__construct', param_count: 1, param_names: ['message'] }
		new_cls.methods << MethodInfo{ name: 'getMessage', param_count: 0, param_names: []string{} }
		new_cls.return_types['getMessage'] = VarType{ tag: .t_string }
		
		new_cls.all_props = new_cls.props.clone()
		new_cls.all_methods = new_cls.methods.clone()
		t.classes << new_cls
	}
}

// find_method 查找指定类（及继承的）的 MethodInfo
pub fn (t Transpiler) find_method(class_name string, method_name string) ?MethodInfo {
	for cls in t.classes {
		if cls.name.to_lower() == class_name.to_lower() {
			for m in cls.methods {
				if m.name.to_lower() == method_name.to_lower() {
					return m
				}
			}
			for m in cls.all_methods {
				if m.name.to_lower() == method_name.to_lower() {
					return m
				}
			}
		}
	}
	return none
}

pub fn (t &Transpiler) get_v_var_name(php_var_name string) string {
	if php_var_name in t.var_aliases {
		return t.var_aliases[php_var_name] or { '' }
	}
	if php_var_name in ['from', 'to', 'type', 'short', 'char', 'int', 'byte', 'struct', 'class', 'interface', 'fn', 'import', 'module', 'const', 'mut', 'pub', 'return', 'if', 'else', 'match', 'for', 'in', 'go', 'select', 'or', 'as', 'true', 'false', 'none'] {
		return 'var_' + php_var_name.to_lower()
	}
	if php_var_name in t.reassigned_params {
		return 'var_' + php_var_name.to_lower()
	}
	if php_var_name in t.native_params || php_var_name in t.native_vars {
		return php_var_name
	}
	return 'var_' + php_var_name.to_lower()
}

// scan_custom_functions 递归扫描并登记所有自定义函数（支持 if/foreach 嵌套）
pub fn (mut t Transpiler) scan_custom_functions(nodes []ast.AstNode) {
	for node in nodes {
		if node.node_type == ast.node_stmt_function {
			t.custom_functions[node.name] = true
			mut p_names := []string{}
			mut has_variadic := false
			for param in node.params {
				if param_var := param.var {
					p_names << param_var.name
				}
				if param.variadic == 'true' {
					has_variadic = true
				}
			}
			has_dyn := has_dynamic_args_call(node.stmts)
			t.custom_function_infos[node.name] = MethodInfo{
				name: node.name
				param_count: node.params.len
				param_names: p_names
				is_variadic: has_variadic
				has_dynamic_args: has_dyn
			}
		}
		if node.stmts.len > 0 {
			t.scan_custom_functions(node.stmts)
		}
		if node.node_type == ast.node_stmt_if {
			for elseif_node in node.elseifs {
				t.scan_custom_functions(elseif_node.stmts)
			}
		}
		if else_node := node.@else {
			t.scan_custom_functions(else_node.stmts)
		}
	}
}

fn find_param_map_insensitive(m map[string]map[string]VarType, key string) ?map[string]VarType {
	for k, v in m {
		if k.to_lower() == key.to_lower() {
			return v
		}
	}
	return none
}

fn find_vartype_map_insensitive(m map[string]VarType, key string) ?VarType {
	for k, v in m {
		if k.to_lower() == key.to_lower() {
			return v
		}
	}
	return none
}

fn (mut t Transpiler) scan_dynamic_usages(nodes []ast.AstNode) {
	for node in nodes {
		t.scan_dynamic_usages_node(node)
	}
}

fn (mut t Transpiler) scan_dynamic_usages_node(node &ast.AstNode) {
	match node.node_type {
		ast.node_expr_new {
			if _ := node.class_expr {
				t.has_dynamic_new = true
			}
		}
		ast.node_expr_method_call {
			if _ := node.name_expr {
				t.has_dynamic_method_call = true
			}
		}
		ast.node_expr_funccall {
			if _ := node.expr {
				t.has_dynamic_func_call = true
			}
		}
		else {}
	}

	// 递归子节点
	if expr := node.expr { t.scan_dynamic_usages_node(*expr) }
	if var_node := node.var { t.scan_dynamic_usages_node(*var_node) }
	if left := node.left { t.scan_dynamic_usages_node(*left) }
	if right := node.right { t.scan_dynamic_usages_node(*right) }
	if cond := node.cond { t.scan_dynamic_usages_node(*cond) }
	if @else := node.@else { t.scan_dynamic_usages_node(*@else) }
	if @if := node.@if { t.scan_dynamic_usages_node(*@if) }
	if finally := node.finally { t.scan_dynamic_usages_node(*finally) }
	if key := node.key { t.scan_dynamic_usages_node(*key) }
	if dim := node.dim { t.scan_dynamic_usages_node(*dim) }
	if key_var := node.key_var { t.scan_dynamic_usages_node(*key_var) }
	if value_var := node.value_var { t.scan_dynamic_usages_node(*value_var) }
	if body := node.body { t.scan_dynamic_usages_node(*body) }
	if default_val := node.default_val { t.scan_dynamic_usages_node(*default_val) }

	for e in node.exprs { t.scan_dynamic_usages_node(e) }
	for s in node.stmts { t.scan_dynamic_usages_node(s) }
	for ei in node.elseifs { t.scan_dynamic_usages_node(ei) }
	for c in node.catches { t.scan_dynamic_usages_node(c) }
	for p in node.params { t.scan_dynamic_usages_node(p) }
	for a in node.args {
		if a_expr := a.expr {
			t.scan_dynamic_usages_node(*a_expr)
		}
	}
	for it in node.items { t.scan_dynamic_usages_node(it) }
	for i in node.init { t.scan_dynamic_usages_node(i) }
	for cd in node.conds { t.scan_dynamic_usages_node(cd) }
	for cs in node.cases { t.scan_dynamic_usages_node(cs) }
	for am in node.arms { t.scan_dynamic_usages_node(am) }
	for l in node.loop { t.scan_dynamic_usages_node(l) }
	for p in node.props { t.scan_dynamic_usages_node(p) }
	for u in node.uses { t.scan_dynamic_usages_node(u) }
	for v in node.vars { t.scan_dynamic_usages_node(v) }
	for p in node.parts { t.scan_dynamic_usages_node(p) }
}

fn (mut t Transpiler) generate_registry_initializers() {
	if t.is_sub_transpiler {
		return
	}
	if !t.has_dynamic_new && !t.has_dynamic_method_call && !t.has_dynamic_func_call && t.classes.len == 0 {
		return
	}

	mut lines := []string{}
	lines << 'fn init_registry() {'

	// 1. 生成自定义函数的适配器（如果需要动态函数调用）
	if t.has_dynamic_func_call {
		// 生成自定义函数的适配器
		for fname, info in t.custom_function_infos {
			lines << "\trt.register_func('${fname}', fn(args []rt.PhpVal) rt.PhpVal {"
			
			// 1. 拆箱参数
			mut pass_args := []string{}
			for idx, pname in info.param_names {
				ptype := if fname in t.func_param_types { t.func_param_types[fname][pname] or { VarType{ tag: .t_unknown } } } else { VarType{ tag: .t_unknown } }
				arg_expr := 'if args.len > ${idx} { args[${idx}] } else { rt.new_null() }'
				mut unboxed_expr := ''
				if ptype.is_scalar() {
					unboxed_expr = t.unbox_expr(arg_expr, ptype)
				} else {
					unboxed_expr = arg_expr
				}
				lines << "\t\targ_${idx} := ${unboxed_expr}"
				pass_args << 'arg_${idx}'
			}

			// 2. 调用原生函数并装箱返回值
			ret_type := t.func_return_types[fname] or { VarType{ tag: .t_unknown } }
			call_stmt := '${func_v_name(fname)}(${pass_args.join(", ")})'
			if ret_type.tag == .t_void {
				lines << "\t\t${call_stmt}"
				lines << "\t\treturn rt.new_null()"
			} else if ret_type.is_scalar() {
				boxed := t.box_expr(call_stmt, ret_type)
				lines << "\t\treturn ${boxed}"
			} else {
				lines << "\t\treturn ${call_stmt}"
			}

			lines << "\t})"
		}
	}

	// 2. 生成类构造函数的适配器 (用于动态 new $className)
	if t.has_dynamic_new {
		for cls in t.classes {
			if t.declared_classes[cls.name] && !t.declared_classes_in_file[cls.name] {
				continue
			}
			parents_expr := t.get_parents_expr(cls.name)
			
			lines << "\trt.register_class_factory('${cls.name}', fn(args []rt.PhpVal) rt.PhpVal {"
			
			// 查找构造函数信息，拆箱参数
			mut construct_info := ?MethodInfo(none)
			for m in cls.all_methods {
				if m.name == '__construct' {
					construct_info = m
					break
				}
			}

			mut pass_args := []string{}
			if info := construct_info {
				if params_map := cls.param_types['__construct'] {
					mut param_idx := 0
					for _, ptype in params_map {
						if param_idx >= info.param_count { break }
						arg_expr := 'if args.len > ${param_idx} { args[${param_idx}] } else { rt.new_null() }'
						mut unboxed_expr := ''
						if ptype.is_scalar() {
							unboxed_expr = t.unbox_expr(arg_expr, ptype)
						} else {
							unboxed_expr = arg_expr
						}
						lines << "\t\tc_arg_${param_idx} := ${unboxed_expr}"
						pass_args << 'c_arg_${param_idx}'
						param_idx++
					}
					for param_idx < info.param_count {
						lines << "\t\tc_arg_${param_idx} := if args.len > ${param_idx} { args[${param_idx}] } else { rt.new_null() }"
						pass_args << 'c_arg_${param_idx}'
						param_idx++
					}
				} else {
					for i in 0 .. info.param_count {
						lines << "\t\tc_arg_${i} := if args.len > ${i} { args[${i}] } else { rt.new_null() }"
						pass_args << 'c_arg_${i}'
					}
				}
			}

			lines << "\t\tobj := create_${cls.name.to_lower()}(${pass_args.join(", ")})"
			lines << "\t\treturn rt.new_object('${cls.name}', ${parents_expr}, obj)"
			lines << "\t})"
		}
	}

	// 3. 注册类元数据（用于 method_exists / property_exists / is_a 等 AOT 查询）
	for cls in t.classes {
		if t.declared_classes[cls.name] && !t.declared_classes_in_file[cls.name] {
			continue
		}
		mut parent_list := []string{}
		if cls.extends.len > 0 {
			parent_list << "'${cls.extends}'"
		}
		for impl in cls.implements {
			parent_list << "'${impl}'"
		}
		
		mut method_list := []string{}
		for m in cls.all_methods {
			method_list << "'${m.name}'"
		}
		
		mut prop_list := []string{}
		for p in cls.all_props {
			prop_list << "'${p}'"
		}
		
		lines << "\trt.register_class_metadata('${cls.name}', [${parent_list.join(', ')}], [${method_list.join(', ')}], [${prop_list.join(', ')}])"
	}
	lines << '}'
	lines << ''
	lines << 'fn init() {'
	lines << '\tinit_registry()'
	lines << '}'
	lines << ''

	t.func_out.writeln(lines.join('\n'))
}

pub fn (t Transpiler) get_empty_literal(typ VarType) string {
	if typ.is_native_list {
		elem := match typ.element_type_tag {
			.t_int { 'i64' }
			.t_float { 'f64' }
			.t_string { 'string' }
			.t_bool { 'bool' }
			else { 'rt.PhpVal' }
		}
		return '[]' + elem + '{}'
	}
	if typ.is_native_map {
		elem := match typ.element_type_tag {
			.t_int { 'i64' }
			.t_float { 'f64' }
			.t_string { 'string' }
			.t_bool { 'bool' }
			else { 'rt.PhpVal' }
		}
		return 'map[string]' + elem + '{}'
	}
	return 'rt.new_null()'
}

pub fn (mut t Transpiler) transpile_include_file(path string) string {
	normalized := os.real_path(path)
	
	mut allowed := false
	for pattern in t.allowed_includes {
		if normalized.contains(pattern) {
			allowed = true
			break
		}
	}
	if !allowed {
		println('Skipping transpile of include: ' + normalized + ' (will execute via Zend)')
		func_name := t.get_safe_func_name(normalized)
		t.transpiled_includes[normalized] = func_name
		return func_name
	}

	println('Transpiling include: ' + normalized)
	if normalized in t.transpiled_includes {
		return t.transpiled_includes[normalized]
	}

	func_name := t.get_safe_func_name(normalized)
	t.transpiled_includes[normalized] = func_name

	if t.parser_php_path == '' {
		eprintln('Warning: parser_php_path not set, cannot transpile include: ' + path)
		return func_name
	}

	// 规范化路径以保证跨平台查找
	if !os.exists(normalized) {
		eprintln('Warning: include file not found: ' + normalized)
		return func_name
	}

	safe_name := normalized.replace('/', '_').replace(':', '_').replace('\\', '_')
	cache_dir := os.join_path(os.dir(t.parser_php_path), 'tmp/ast_cache')
	cache_path := os.join_path(cache_dir, safe_name + '.json')
	mut json_ast := ''
	if os.exists(cache_path) {
		json_ast = os.read_file(cache_path) or { '' }
	}
	if json_ast == '' {
		res := os.execute('php "' + t.parser_php_path + '" "' + normalized + '"')
		if res.exit_code != 0 {
			eprintln('PHP parsing failed for include ' + path + ': ' + res.output)
			return func_name
		}
		json_ast = res.output
		os.mkdir_all(cache_dir) or {}
		os.write_file(cache_path, json_ast) or {}
	}

	parsed_stmts := ast.parse_ast_json(json_ast) or {
		eprintln('Failed to parse AST JSON for include ' + path + ': ${err}')
		return func_name
	}
	mut stmts := []ast.AstNode{}
	for i in 0 .. parsed_stmts.len {
		stmts << *parsed_stmts[i].clone()
	}

	// 实例化子转译器
	mut sub_t := Transpiler.new()
	sub_t.is_sub_transpiler = true
	sub_t.current_file = normalized
	sub_t.parser_php_path = t.parser_php_path
	sub_t.classes = t.classes.clone()
	sub_t.rebuild_class_map()
	sub_t.custom_functions = t.custom_functions.clone()
	sub_t.custom_function_infos = t.custom_function_infos.clone()
	sub_t.global_constants = t.global_constants.clone()
	sub_t.transpiled_includes = t.transpiled_includes.clone()
	sub_t.declared_classes = t.declared_classes.clone()
	sub_t.undeclared_classes = t.undeclared_classes.clone()
	sub_t.func_param_types = t.func_param_types.clone()
	sub_t.func_return_types = t.func_return_types.clone()

	v_body := sub_t.transpile(stmts)

	// 同步回父转译器
	t.classes = sub_t.classes.clone()
	t.rebuild_class_map()
	t.custom_functions = sub_t.custom_functions.clone()
	t.custom_function_infos = sub_t.custom_function_infos.clone()
	t.global_constants = sub_t.global_constants.clone()
	t.transpiled_includes = sub_t.transpiled_includes.clone()
	t.declared_classes = sub_t.declared_classes.clone()
	t.undeclared_classes = sub_t.undeclared_classes.clone()
	t.func_param_types = sub_t.func_param_types.clone()
	t.func_return_types = sub_t.func_return_types.clone()

	t.include_funcs_code.write_string(sub_t.include_funcs_code.str())
	t.include_register_code.write_string(sub_t.include_register_code.str())

	mut final_body := v_body
	trimmed := final_body.trim_space()
	if !trimmed.ends_with('return') && !trimmed.all_after_last('\n').contains('return') {
		final_body += '\treturn rt.new_null()\n'
	}

	sub_funcs := sub_t.func_out.str()
	mut func_code := ''
	if sub_funcs != '' {
		func_code += sub_funcs + '\n'
	}
	func_code += 'fn ' + func_name + '() rt.PhpVal {\n' + final_body + '}\n'
	
	t.include_funcs_code.write_string(func_code)
	t.include_register_code.writeln('\trt.register_include(\'' + normalized + '\', ' + func_name + ')')

	return func_name
}

pub fn (t Transpiler) get_safe_func_name(path string) string {
	mut s := path.to_lower()
	s = s.replace('/', '_').replace('\\', '_').replace('.', '_').replace('-', '_').replace(':', '_')
	return 'run_transpiled_include_' + s
}

pub fn (t &Transpiler) eval_static_path(node &ast.AstNode) ?string {
	match node.node_type {
		ast.node_scalar_string {
			return node.value
		}
		ast.node_scalar_magic_const_dir {
			if t.current_file != '' {
				return os.dir(os.real_path(t.current_file))
			}
			return os.getwd()
		}
		ast.node_scalar_magic_const_file {
			if t.current_file != '' {
				return os.real_path(t.current_file)
			}
			return ''
		}
		ast.node_expr_const {
			name := node.name
			if gc := t.global_constants[name] {
				expr := gc.val_expr
				if (expr.starts_with("'") && expr.ends_with("'")) || (expr.starts_with('"') && expr.ends_with('"')) {
					return expr[1..expr.len - 1]
				}
			}
		}
		ast.node_bin_concat {
			left_node := node.left or { return none }
			right_node := node.right or { return none }
			left_val := t.eval_static_path(*left_node) or { return none }
			right_val := t.eval_static_path(*right_node) or { return none }
			return left_val + right_val
		}
		else {}
	}
	return none
}

fn has_dynamic_args_call(nodes []ast.AstNode) bool {
	for node in nodes {
		if node.node_type == ast.node_expr_funccall {
			if node.name in ['func_get_args', 'func_num_args', 'func_get_arg'] {
				return true
			}
		}
		if node.stmts.len > 0 {
			if has_dynamic_args_call(node.stmts) {
				return true
			}
		}
		if node.conds.len > 0 {
			if has_dynamic_args_call(node.conds) {
				return true
			}
		}
		if node.loop.len > 0 {
			if has_dynamic_args_call(node.loop) {
				return true
			}
		}
		if expr_node := node.expr {
			if has_dynamic_args_call([*expr_node]) {
				return true
			}
		}
		if left_node := node.left {
			if has_dynamic_args_call([*left_node]) {
				return true
			}
		}
		if right_node := node.right {
			if has_dynamic_args_call([*right_node]) {
				return true
			}
		}
		for arg in node.args {
			if val := arg.expr {
				if has_dynamic_args_call([*val]) {
					return true
				}
			}
		}
		for c in node.cases {
			if has_dynamic_args_call(c.stmts) {
				return true
			}
		}
		for c in node.catches {
			if has_dynamic_args_call(c.stmts) {
				return true
			}
		}
	}
	return false
}

// get_method_param_v_type 递归向上查找当初生成方法签名时，第 param_idx 个参数的实际 V 语言类型
pub fn (t &Transpiler) get_method_param_v_type(class_name string, method_name string, param_idx int) string {
	mut curr_class := class_name
	for curr_class != '' {
		key := '${curr_class}::${method_name}'
		if types := t.method_param_v_types[key] {
			if param_idx < types.len {
				return types[param_idx]
			}
		}
		// 查找父类
		idx := t.class_name_map[curr_class.to_lower()] or { -1 }
		if idx != -1 {
			curr_class = t.classes[idx].extends
		} else {
			break
		}
	}
	return 'rt.PhpVal'
}

// parse_v_type_str 将 V 语言的类型字符串解析回对应的 VarType
pub fn parse_v_type_str(v_type_str string) VarType {
	match v_type_str {
		'string' { return VarType{ tag: .t_string } }
		'i64' { return VarType{ tag: .t_int } }
		'f64' { return VarType{ tag: .t_float } }
		'bool' { return VarType{ tag: .t_bool } }
		else {
			if v_type_str.starts_with('Class_') {
				return VarType{ tag: .t_object, class_name: v_type_str.all_after('Class_') }
			}
		}
	}
	return VarType{ tag: .t_unknown }
}

pub fn (t Transpiler) is_mixed_aot() bool {
	// 如果当前转译的文件不在 tests/fixtures 里，那就是 mixed AOT 部署模式
	return !t.current_file.contains('tests/fixtures')
}




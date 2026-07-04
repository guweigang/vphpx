module emitter

import strings
import ast

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
	expected_type          VarType                       // 上下文期望类型
	var_aliases            map[string]string             // 变量重命名映射（处理局部变量遮蔽冲突）
	foreach_depth          int                           // 循环嵌套深度（用于生成唯一的迭代器变量名）
	native_vars            map[string]bool               // 本地声明的原生变量（用于精确判定是否需要装箱）
	native_arr_vars        map[string]bool               // 已知持有原生数组/map的变量（用于array_dim_fetch确认）
	custom_function_infos  map[string]MethodInfo         // 自定义全局函数签名信息（含可变参数状态）
	has_dynamic_new         bool
	has_dynamic_method_call bool
	has_dynamic_func_call   bool
	type_cache              map[voidptr]VarType
	codegen_cache           map[voidptr]CodegenCacheEntry
	active_depth            int
	mode                    string
	is_entry_script         bool
}

pub struct CodegenCacheEntry {
pub mut:
	code string
	typ  VarType
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
		scope:            VarScope.new()
		custom_functions: map[string]bool{}
		custom_function_infos: map[string]MethodInfo{}
		classes:          []ClassInfo{}
		current_file:     ''
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
		closure_body_builder: strings.new_builder(64)
		closure_captured_natives: map[string]VarType{}
		extra_imports: map[string]bool{}
		func_call_arg_types: map[string][]TypeTag{}
		func_param_types: map[string]map[string]VarType{}
		func_return_types: map[string]VarType{}
		func_var_types: map[string]map[string]VarType{}
		declared_classes: map[string]bool{}
		expected_type: VarType{ tag: .t_unknown }
		has_dynamic_new:         false
		has_dynamic_method_call: false
		has_dynamic_func_call:   false
	}
}

// transpile 预扫描函数并遍历语句，返回生成的 V 代码
pub fn (mut t Transpiler) transpile(stmts []ast.AstNode) string {
	mut local_stmts := stmts.clone()
	t.collect_traits(mut local_stmts)
	t.apply_traits(mut local_stmts)

	// 前置扫描并登记全局常量
	t.scan_global_constants(local_stmts)

	// 前置扫描并登记全局类与 Exception
	t.scan_classes(local_stmts)

	// 预扫描顶层及嵌套自定义函数，登记到 custom_functions 中
	t.scan_custom_functions(local_stmts)

	// 前置类型分析
	t.analyze_types(local_stmts)

	// 扫描动态使用特征
	t.scan_dynamic_usages(local_stmts)

	// 检测入口脚本：如果顶层代码包含 exit/die，标记为入口脚本
	if t.mode == 'lib' && t.has_exit_or_die(local_stmts) {
		t.is_entry_script = true
	}

	ref_vars, ass_vars := t.collect_vars_in_scope(local_stmts)
	for v in ref_vars {
		if v !in ass_vars && !t.scope.has_var(v) {
			t.write_indent()
			v_var := t.get_v_var_name(v)
			v_type := t.inferred_types[v_var] or { t.inferred_types[v] or { VarType{ tag: .t_unknown } } }
			if v_type.is_native_list || v_type.is_native_map {
				t.write_line('mut ${v_var} := ' + t.get_empty_literal(v_type))
				t.native_arr_vars[v] = true
			} else if v_type.is_scalar() {
				t.native_vars[v_var] = true
				match v_type.tag {
					.t_int { t.write_line('mut ${v_var} := i64(0)') }
					.t_float { t.write_line('mut ${v_var} := f64(0.0)') }
					.t_bool { t.write_line('mut ${v_var} := false') }
					else { t.write_line("mut ${v_var} := ''") }
				}
			} else if v_type.is_object() {
				cls := if v_type.class_name.len > 0 { v_type.class_name } else { 'WP_Error' }
				t.write_line('mut ${v_var} := &Class_${cls}(unsafe { nil })')
			} else {
				t.write_line('mut ${v_var} := rt.new_null()')
			}
			t.scope.declare(v)
		}
	}

	for stmt in local_stmts {
		t.visit_stmt(stmt)
	}

	// 补全在转译中遇到的未显式声明的类（如 Exception 等内置类）
	old_is_in_func := t.is_in_func
	t.is_in_func = true
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

fn (mut t Transpiler) write_indent() {
	if t.pre_stmts.len > 0 {
		pre := t.pre_stmts.clone()
		t.pre_stmts.clear()
		// pre_stmts 写到当前活跃的 builder（闭包体 or 外层函数）
		mut b := t.current_builder()
		indent_str := '\t'.repeat(t.indent)
		for stmt in pre {
			for line in stmt.split('\n') {
				b.writeln('${indent_str}${line}')
			}
		}
	}

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
	for cls in t.classes {
		if cls.name.to_lower() == class_name.to_lower() {
			if typ := find_vartype_map_insensitive(cls.prop_types, prop_name) {
				return typ
			}
			// 递归查父类
			if cls.extends.len > 0 {
				return t.get_class_prop_type(cls.extends, prop_name)
			}
			return VarType{ tag: .t_unknown }
		}
	}
	return VarType{ tag: .t_unknown }
}

// 查找类方法的参数类型
fn (t &Transpiler) get_method_param_type(class_name string, method_name string, param_name string) VarType {
	for cls in t.classes {
		if cls.name.to_lower() == class_name.to_lower() {
			if params := find_param_map_insensitive(cls.param_types, method_name) {
				if typ := find_vartype_map_insensitive(params, param_name) {
					return typ
				}
			}
			// 递归查父类
			if cls.extends.len > 0 {
				return t.get_method_param_type(cls.extends, method_name, param_name)
			}
			return VarType{ tag: .t_unknown }
		}
	}
	return VarType{ tag: .t_unknown }
}

// 查找类方法的返回值类型
fn (t &Transpiler) get_method_return_type(class_name string, method_name string) VarType {
	for cls in t.classes {
		if cls.name.to_lower() == class_name.to_lower() {
			if typ := find_vartype_map_insensitive(cls.return_types, method_name) {
				return typ
			}
			if cls.extends.len > 0 {
				return t.get_method_return_type(cls.extends, method_name)
			}
			return VarType{ tag: .t_unknown }
		}
	}
	return VarType{ tag: .t_unknown }
}

// 查找类方法的参数类型映射（参数名 → 类型）
fn (t &Transpiler) param_types_for_method(class_name string, method_name string) ?map[string]VarType {
	for cls in t.classes {
		if cls.name.to_lower() == class_name.to_lower() {
			if params := find_param_map_insensitive(cls.param_types, method_name) {
				return params
			}
			if cls.extends.len > 0 {
				return t.param_types_for_method(cls.extends, method_name)
			}
			return none
		}
	}
	return none
}

// 检查类是否继承/实现指定的类或接口
fn (t &Transpiler) is_class_instance_of(child_class string, target string) bool {
	if child_class == target {
		return true
	}
	for cls in t.classes {
		if cls.name == child_class {
			// 检查 implements
			for iface in cls.implements {
				if iface == target {
					return true
				}
			}
			// 递归检查父类
			if cls.extends.len > 0 {
				return t.is_class_instance_of(cls.extends, target)
			}
			return false
		}
	}
	return false
}

// scan_global_constants 静态分析顶层 AST，提取全局 const 和全局 define() 并注册
pub fn (mut t Transpiler) scan_global_constants(stmts []ast.AstNode) {
	for stmt in stmts {
		match stmt.node_type {
			ast.node_stmt_const {
				for c in stmt.consts {
					val_type := t.get_expr_type(c.value)
					t.global_constants[c.name] = GlobalConst{
						name: 'global_const_' + c.name.to_lower()
						typ: val_type
					}
				}
			}
			ast.node_stmt_expression {
				expr := stmt.expr or { continue }
				if expr.node_type == ast.node_expr_funccall && expr.name == 'define' {
					if expr.args.len >= 2 {
						name_node := expr.args[0].expr or { continue }
						val_node := expr.args[1].expr or { continue }
						if name_node.node_type == ast.node_scalar_string {
							val_type := t.get_expr_type(*val_node)
							t.global_constants[name_node.value] = GlobalConst{
								name: 'global_const_' + name_node.value.to_lower()
								typ: val_type
							}
						}
					}
				}
			}
			else {}
		}
	}
}

// 辅助提取属性默认值的 V 表达式
fn get_prop_default_expr(node ast.AstNode) string {
	match node.node_type {
		ast.node_expr_array { return 'rt.new_array()' }
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
						for param in member.params {
							if param_var := param.var {
								p_names << param_var.name
							}
						}
						is_meth_static := (member.flags.int() & 8) != 0
						methods << MethodInfo{
							name: member.name
							param_count: member.params.len
							param_names: p_names
							is_static: is_meth_static
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
			for m in cls.all_methods {
				if m.name.to_lower() == method_name.to_lower() {
					return m
				}
			}
		}
	}
	return none
}

pub fn (t Transpiler) get_v_var_name(php_var_name string) string {
	if php_var_name in t.var_aliases {
		return t.var_aliases[php_var_name] or { '' }
	}
	if php_var_name in t.reassigned_params {
		return 'var_${php_var_name}'
	}
	if php_var_name in t.native_params || php_var_name in t.native_vars {
		return php_var_name
	}
	return 'var_${php_var_name}'
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
			t.custom_function_infos[node.name] = MethodInfo{
				name: node.name
				param_count: node.params.len
				param_names: p_names
				is_variadic: has_variadic
			}
		}
		if node.stmts.len > 0 {
			t.scan_custom_functions(node.stmts)
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

fn (mut t Transpiler) scan_dynamic_usages_node(node ast.AstNode) {
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
	if !t.has_dynamic_new && !t.has_dynamic_method_call && !t.has_dynamic_func_call {
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
					unboxed_expr = unbox_expr(arg_expr, ptype)
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
				boxed := box_expr(call_stmt, ret_type)
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
							unboxed_expr = unbox_expr(arg_expr, ptype)
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




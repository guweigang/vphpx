module emitter

import strings
import php2v.ast

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
	is_in_construct        bool            // 当前是否在 __construct 方法中（无返回值）
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
}

pub struct GlobalConst {
pub mut:
	name     string
	val_expr string
	typ      VarType
}

pub fn Transpiler.new() Transpiler {
	return Transpiler{
		out:              strings.new_builder(1024)
		func_out:         strings.new_builder(1024)
		closures_code:    strings.new_builder(1024)
		const_out:        strings.new_builder(1024)
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
		post_stmts: []string{}
		traits: map[string]ast.AstNode{}
		last_expr_type: VarType{ tag: .t_unknown }
		inferred_types: map[string]VarType{}
		mutated_vars: map[string]bool{}
		ctor_arg_types: map[string][]TypeTag{}
		native_params: map[string]bool{}
		global_constants: map[string]GlobalConst{}
		closure_body_builder: strings.new_builder(64)
		closure_captured_natives: map[string]VarType{}
		extra_imports: map[string]bool{}
		func_call_arg_types: map[string][]TypeTag{}
		func_param_types: map[string]map[string]VarType{}
		func_return_types: map[string]VarType{}
		func_var_types: map[string]map[string]VarType{}
		declared_classes: map[string]bool{}
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

	// 预扫描顶层自定义函数，登记到 custom_functions 中以支持任意顺序的调用
	for stmt in local_stmts {
		if stmt.node_type == ast.node_stmt_function {
			t.custom_functions[stmt.name] = true
		}
	}

	// 前置类型分析
	t.analyze_types(local_stmts)

	ref_vars, ass_vars := t.collect_vars_in_scope(local_stmts)
	for v in ref_vars {
		if v !in ass_vars && !t.scope.has_var(v) {
			t.write_indent()
			t.write_line('mut var_${v} := rt.new_null()')
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
				new_cls.methods << MethodInfo{ name: '__construct', param_count: 1 }
				new_cls.methods << MethodInfo{ name: 'getMessage', param_count: 0 }
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
		mut b := t.current_builder()
		for stmt in pre {
			indent_str := '\t'.repeat(t.indent)
			b.writeln('${indent_str}${stmt}')
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
		if cls.name == class_name {
			if typ := cls.prop_types[prop_name] {
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
		if cls.name == class_name {
			if params := cls.param_types[method_name] {
				if typ := params[param_name] {
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
		if cls.name == class_name {
			if typ := cls.return_types[method_name] {
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
		if cls.name == class_name {
			if params := cls.param_types[method_name] {
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

// scan_classes 静态扫描并登记全局 ClassInfo 到 t.classes，并前置注册 Exception 基类
pub fn (mut t Transpiler) scan_classes(stmts []ast.AstNode) {
	for stmt in stmts {
		if stmt.node_type == ast.node_stmt_class {
			resolved_name := t.resolve_class_name(stmt.name)
			mut methods := []MethodInfo{}
			mut props := []string{}
			for member in stmt.stmts {
				match member.node_type {
					ast.node_stmt_property {
						for p in member.props {
							props << p.name
						}
					}
					ast.node_stmt_class_method {
						methods << MethodInfo{
							name: member.name
							param_count: member.params.len
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
		new_cls.methods << MethodInfo{ name: '__construct', param_count: 1 }
		new_cls.methods << MethodInfo{ name: 'getMessage', param_count: 0 }
		new_cls.return_types['getMessage'] = VarType{ tag: .t_string }
		
		new_cls.all_props = new_cls.props.clone()
		new_cls.all_methods = new_cls.methods.clone()
		t.classes << new_cls
	}
}



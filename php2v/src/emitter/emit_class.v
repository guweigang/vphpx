module emitter

import php2v.ast

// prop_field_path returns the correct field access path for a property,
// handling inheritance. For own props: "field_name". For inherited: "Class_Parent.field_name".
fn (t &Transpiler) prop_field_path(cls_name string, prop_name string) string {
	// Determine the actual struct field name (matches struct generation logic)
	field := prop_v_name(prop_name)
	for c in t.classes {
		if c.name == cls_name {
			if prop_name in c.props {
				return field
			}
			if c.extends != '' {
				parent_path := t.prop_field_path(c.extends, prop_name)
				if parent_path != '' {
					return 'Class_${c.extends}.${parent_path}'
				}
			}
			return ''
		}
	}
	return ''
}

fn (mut t Transpiler) visit_class(node ast.AstNode) {
	t.is_in_func = true
	resolved_name := t.resolve_class_name(node.name)
	resolved_extends := t.resolve_class_name(node.extends)
	t.current_class = resolved_name
	t.declared_classes[resolved_name] = true
	
	// 收集 ClassInfo：只收集本类自身声明的属性和方法
	mut class_info := ClassInfo{
		name: resolved_name
		extends: resolved_extends
		implements: node.implements.clone()
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
		} else if stmt.node_type == ast.node_stmt_class_const {
			for c in stmt.consts {
				val_type := t.get_expr_type(c.value)
				ret_type_str := val_type.to_v_type()
				val_str := t.visit_expr_native(c.value)
				t.func_out.writeln('pub fn Class_${resolved_name}.${c.name.to_lower()}() ${ret_type_str} {')
				t.func_out.writeln('\treturn ${val_str}')
				t.func_out.writeln('}')
			}
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
	mut found := false
	for mut cls in t.classes {
		if cls.name == class_info.name {
			cls.methods = class_info.methods.clone()
			cls.props = class_info.props.clone()
			cls.all_props = class_info.all_props.clone()
			cls.all_methods = class_info.all_methods.clone()
			// 注意：保留原有的 prop_types，因为它们可能已经在 analyze_types 阶段被推导好了
			if cls.prop_types.len == 0 {
				cls.prop_types = class_info.prop_types.clone()
			}
			if cls.return_types.len == 0 {
				cls.return_types = class_info.return_types.clone()
			}
			found = true
			break
		}
	}
	if !found {
		t.classes << class_info
	}

	// P7 Phase 1: 推断属性/参数/返回值类型
	t.infer_single_class_types(node, resolved_name)

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
		// 重新读取推断后的 ClassInfo（infer_single_class_types 已在上面调用）
		for prop in class_info.props {
			t.write_indent()
			prop_type := t.get_class_prop_type(resolved_name, prop)
			if prop_type.is_scalar() {
				t.write_line('${prop_v_name(prop)} ${prop_type.to_v_type()}')
			} else {
				t.write_line('${prop_v_name(prop)} rt.PhpVal')
			}
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
			t.write_line('fn (mut this Class_${resolved_name}) ${method_v_name("__construct")}(var_message rt.PhpVal) {')
			t.indent++
			t.write_indent()
			t.write_line('this.${prop_v_name("message")} = var_message.to_string()')
			t.indent--
			t.write_indent()
			t.write_line('}')
			t.write_line('')
		}
		if 'getMessage' !in own_method_names_originally {
			t.write_indent()
			t.write_line('fn (mut this Class_${resolved_name}) ${method_v_name("getMessage")}() string {')
			t.indent++
			t.write_indent()
			t.write_line('return this.${prop_v_name("message")}')
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
	old_func_name := t.current_func_name
	t.current_func_name = node.name
	
	old_func_ret := t.current_func_ret_type
	ret_type := t.get_method_return_type(class_name, node.name)
	t.current_func_ret_type = ret_type

	// P7: 注册 $this 的类型，使属性/方法访问可以直连
	t.inferred_types['this'] = VarType{ tag: .t_object, class_name: class_name }

	// P7 Task 7: 参数使用推断类型；无法推断则保持 rt.PhpVal
	mut param_names := []string{}
	mut registered_native_params := []string{}
	for param in node.params {
		param_var := param.var or { panic('Param missing var') }
		param_name := param_var.name
		t.scope.declare(param_name)
		param_type := t.get_method_param_type(class_name, node.name, param_name)
		if param_type.is_scalar() {
			// 原生类型参数：直接用参数名（无 var_ 前缀），登记到类型表和 native_params
			param_names << '${param_name} ${param_type.to_v_type()}'
			t.inferred_types[param_name] = param_type
			t.native_params[param_name] = true
			registered_native_params << param_name
		} else {
			param_names << 'var_${param_name} rt.PhpVal'
		}
	}

	// P7 Task 7: 返回值类型推断
	is_construct := node.name == '__construct'
	is_void := ret_type.tag == .t_void
	ret_type_str := if is_construct || is_void { '' } else if ret_type.is_scalar() { ret_type.to_v_type() } else { 'rt.PhpVal' }

	t.write_indent()
	// P7 Task 7: 去掉 method_ 前缀（仅内部调用）
	t.write_line('fn (mut this Class_${class_name}) ${method_v_name(node.name)}(${param_names.join(", ")}) ${ret_type_str} {')
	
	t.indent++
	
	// 标记当前在 construct 中，以便 visit_return 正确处理
	old_in_construct := t.is_in_construct
	t.is_in_construct = is_construct
	
	// P7 Task 8: 不再生成 var_this 代理变量，直接通过 this.field 访问
	
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
	
	if !is_construct && !is_void {
		if node.stmts.len == 0 || node.stmts[node.stmts.len - 1].node_type != ast.node_stmt_return {
			t.write_indent()
			if ret_type.is_scalar() {
				match ret_type.tag {
					.t_string { t.write_line("return ''") }
					.t_int { t.write_line('return i64(0)') }
					.t_float { t.write_line('return f64(0.0)') }
					.t_bool { t.write_line('return false') }
					else { t.write_line('return rt.new_null()') }
				}
			} else {
				t.write_line('return rt.new_null()')
			}
		}
	}
	
	t.is_in_construct = old_in_construct
	t.indent--
	t.write_indent()
	t.write_line('}')
	t.write_line('')

	t.indent = old_indent
	t.scope = old_scope
	t.current_func_name = old_func_name
	t.current_func_ret_type = old_func_ret
	// P7: 清理本方法注册的原生参数，避免污染后续方法
	for p in registered_native_params {
		t.native_params.delete(p)
	}
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
	// P7 Task 6: 初始化本类自身的属性，原生类型用零值
	for prop in cls.props {
		t.write_indent()
		prop_type := t.get_class_prop_type(cls.name, prop)
		if prop_type.is_scalar() {
			match prop_type.tag {
				.t_string { t.write_line("${prop_v_name(prop)}: ''") }
				.t_int { t.write_line('${prop_v_name(prop)}: i64(0)') }
				.t_float { t.write_line('${prop_v_name(prop)}: f64(0.0)') }
				.t_bool { t.write_line('${prop_v_name(prop)}: false') }
				else { t.write_line('${prop_v_name(prop)}: rt.new_null()') }
			}
		} else {
			t.write_line('${prop_v_name(prop)}: rt.new_null()')
		}
	}
}

fn (mut t Transpiler) generate_dispatchers() {
	t.is_in_func = true
	t.indent = 0

	if t.classes.len == 0 {
		// 按需生成：仅在代码实际使用了对应特性时才注入桩函数
		if t.needs_method_dispatch {
			t.write_line('fn call_method(obj rt.PhpVal, method_name string, args []rt.PhpVal) rt.PhpVal {')
			t.write_line('\treturn rt.call_method(obj, method_name, args)')
			t.write_line('}')
			t.write_line('')
		}
		if t.needs_prop_dispatch {
			t.write_line('fn get_property(obj rt.PhpVal, prop_name string) rt.PhpVal {')
			t.write_line('\treturn rt.get_property(obj, prop_name)')
			t.write_line('}')
			t.write_line('')
			t.write_line('fn set_property(obj rt.PhpVal, prop_name string, val rt.PhpVal) {')
			t.write_line('\trt.set_property(obj, prop_name, val)')
			t.write_line('}')
			t.write_line('')
		}
		t.is_in_func = false
		return
	}

	// 1. 生成每个类的工厂函数
	//    P7 Task 7: 生成 new_xxx(原生参数) 和 create_xxx(PhpVal 参数) 两套
	for cls in t.classes {
		// 在 all_methods 中查找构造函数
		mut construct_info := ?MethodInfo(none)
		for m in cls.all_methods {
			if m.name == '__construct' {
				construct_info = m
				break
			}
		}

		// --- 生成 new_xxx（V 原生类型参数版）---
		// 收集构造函数的原生参数声明
		mut native_param_decls := []string{}
		mut native_param_pass := []string{}
		mut has_native_construct := false
		if info := construct_info {
			has_native_construct = true
			if params_map := cls.param_types['__construct'] {
				// 按顺序构建参数列表，使用推断的类型
				mut param_idx := 0
				for pname, ptype in params_map {
					if param_idx >= info.param_count { break }
					if ptype.is_scalar() {
						native_param_decls << '${pname} ${ptype.to_v_type()}'
					} else {
						native_param_decls << 'arg_${param_idx} rt.PhpVal'
					}
					native_param_pass << if ptype.is_scalar() { pname } else { 'arg_${param_idx}' }
					param_idx++
				}
				// 处理未推断出类型的剩余参数
				for param_idx < info.param_count {
					native_param_decls << 'arg_${param_idx} rt.PhpVal'
					native_param_pass << 'arg_${param_idx}'
					param_idx++
				}
			} else {
				for i in 0 .. info.param_count {
					native_param_decls << 'arg_${i} rt.PhpVal'
					native_param_pass << 'arg_${i}'
				}
			}
		}

		// create_xxx：返回原生结构体指针，避免 PhpVal 装箱
		t.write_line('fn create_${cls.name.to_lower()}(${native_param_decls.join(", ")}) &Class_${cls.name} {')
		t.indent++
		t.write_indent()
		t.write_line('mut obj := &Class_${cls.name}{')
		t.indent++
		t.generate_struct_init(cls)
		t.indent--
		t.write_indent()
		t.write_line('}')
		if has_native_construct {
			t.write_indent()
			// 调用构造方法（使用 method_v_name 转换名称）
			t.write_line('obj.${method_v_name("__construct")}(${native_param_pass.join(", ")})')
		}
		t.write_indent()
		t.write_line('return obj')
		t.indent--
		t.write_line('}')
		t.write_line('')
	}

	// 2. 生成每个类的 dispatch_method / dispatch_get_prop / dispatch_set_prop
	// 注意：虽然有条件标志 needs_method_dispatch/needs_prop_dispatch，但由于标志是在
	// 表达式遍历时设置的，而类定义在此之前生成，所以暂时总是生成这些函数
	for cls in t.classes {
		// dispatch_method：使用 optional 返回值
		t.write_line('fn (mut this Class_${cls.name}) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {')
		t.indent++
		if cls.all_methods.len > 0 {
			t.write_indent()
			t.write_line('match method_name {')
			t.indent++
			for m in cls.all_methods {
				t.write_indent()
				// 查找该方法所属的类（可能是父类）
				mut args_pass := []string{}
				// 查找 param_types 以决定参数传递方式
				mut param_types_list := []VarType{}
				if pm := cls.param_types[m.name] {
					for pn, pt in pm {
						_ = pn
						param_types_list << pt
					}
				}
				for i in 0 .. m.param_count {
					raw_arg := 'if args.len > ${i} { args[${i}] } else { rt.new_null() }'
					if i < param_types_list.len && param_types_list[i].is_scalar() {
						// 目标参数是原生类型 → 拆箱
						args_pass << unbox_expr(raw_arg, param_types_list[i])
					} else {
						args_pass << raw_arg
					}
				}
				// P7 Task 12: 方法返回类型装箱
				ret_type := t.get_method_return_type(cls.name, m.name)
				method_call := 'this.${method_v_name(m.name)}(${args_pass.join(", ")})'
				if m.name == '__construct' || ret_type.tag == .t_void {
					// construct 和 void 方法无返回值：先调用，再返回 rt.new_null()
					t.write_line('\'${m.name}\' { ${method_call}; return rt.new_null() }')
				} else if ret_type.is_scalar() {
					match ret_type.tag {
						.t_string { t.write_line('\'${m.name}\' { return rt.new_string(${method_call}) }') }
						.t_int { t.write_line('\'${m.name}\' { return rt.new_int(${method_call}) }') }
						.t_float { t.write_line('\'${m.name}\' { return rt.new_float(${method_call}) }') }
						.t_bool { t.write_line('\'${m.name}\' { return rt.new_bool(${method_call}) }') }
						else { t.write_line('\'${m.name}\' { return ${method_call} }') }
					}
				} else {
					t.write_line('\'${m.name}\' { return ${method_call} }')
				}
			}
			t.write_indent()
			t.write_line('else { return none }')
			t.indent--
			t.write_indent()
			t.write_line('}')
		} else {
			t.write_indent()
			t.write_line('return none')
		}
		t.indent--
		t.write_line('}')
		t.write_line('')

		// dispatch_get_prop：P7 Task 12 原生属性装箱，使用 optional 返回值
		t.write_line('fn (this &Class_${cls.name}) dispatch_get_prop(prop_name string) ?rt.PhpVal {')
		t.indent++
		if cls.all_props.len > 0 {
			t.write_indent()
			t.write_line('match prop_name {')
			t.indent++
			for prop in cls.all_props {
				t.write_indent()
				prop_type := t.get_class_prop_type(cls.name, prop)
				field_path := t.prop_field_path(cls.name, prop)
				if prop_type.is_scalar() {
					match prop_type.tag {
						.t_string { t.write_line('\'${prop}\' { return rt.new_string(this.${field_path}) }') }
						.t_int { t.write_line('\'${prop}\' { return rt.new_int(this.${field_path}) }') }
						.t_float { t.write_line('\'${prop}\' { return rt.new_float(this.${field_path}) }') }
						.t_bool { t.write_line('\'${prop}\' { return rt.new_bool(this.${field_path}) }') }
						else { t.write_line('\'${prop}\' { return this.${field_path} }') }
					}
				} else {
					t.write_line('\'${prop}\' { return this.${field_path} }')
				}
			}
			t.write_indent()
			t.write_line('else { return none }')
			t.indent--
			t.write_indent()
			t.write_line('}')
		} else {
			t.write_indent()
			t.write_line('return none')
		}
		t.indent--
		t.write_line('}')
		t.write_line('')

		// dispatch_set_prop：P7 Task 12 原生属性拆箱，返回 bool 表示是否成功
		t.write_line('fn (mut this Class_${cls.name}) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {')
		t.indent++
		if cls.all_props.len > 0 {
			t.write_indent()
			t.write_line('match prop_name {')
			t.indent++
			for prop in cls.all_props {
				t.write_indent()
				prop_type := t.get_class_prop_type(cls.name, prop)
				field_path := t.prop_field_path(cls.name, prop)
				if prop_type.is_scalar() {
					unboxed := unbox_expr('val', prop_type)
					t.write_line('\'${prop}\' { this.${field_path} = ${unboxed}; return true }')
				} else {
					t.write_line('\'${prop}\' { this.${field_path} = val; return true }')
				}
			}
			t.write_indent()
			t.write_line('else { return false }')
			t.indent--
			t.write_indent()
			t.write_line('}')
		} else {
			t.write_indent()
			t.write_line('return false')
		}
		t.indent--
		t.write_line('}')
		t.write_line('')
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
	mut queue := []string{}
	queue << class_name

	mut visited := map[string]bool{}
	visited[class_name] = true

	for queue.len > 0 {
		curr := queue[0]
		queue.delete(0)

		for cls in t.classes {
			if cls.name == curr {
				if cls.extends != '' && cls.extends !in visited {
					parents << cls.extends
					visited[cls.extends] = true
					queue << cls.extends
				}
				for impl in cls.implements {
					if impl !in visited {
						parents << impl
						visited[impl] = true
						queue << impl
					}
				}
				break
			}
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

// class_implements 检查类是否在编译时已知实现了目标类/接口
fn (t &Transpiler) class_implements(class_name string, target string) bool {
	mut queue := []string{}
	queue << class_name
	mut visited := map[string]bool{}
	visited[class_name] = true

	for queue.len > 0 {
		curr := queue[0]
		queue.delete(0)

		if curr == target {
			return true
		}

		for cls in t.classes {
			if cls.name == curr {
				if cls.extends != '' && cls.extends !in visited {
					visited[cls.extends] = true
					queue << cls.extends
				}
				for impl in cls.implements {
					if impl !in visited {
						visited[impl] = true
						queue << impl
					}
				}
				break
			}
		}
	}
	return false
}

// class_does_not_implement 检查类是否在编译时已知不实现目标类/接口
// 只有当类已声明且我们已遍历完所有父类/接口后才能确定
fn (t &Transpiler) class_does_not_implement(class_name string, target string) bool {
	// 如果类未声明，无法确定
	mut class_exists := false
	for cls in t.classes {
		if cls.name == class_name {
			class_exists = true
			break
		}
	}
	if !class_exists {
		return false
	}
	// 如果目标在父类/接口链中，返回 false
	if t.class_implements(class_name, target) {
		return false
	}
	// 类存在但目标不在继承链中，返回 true
	return true
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

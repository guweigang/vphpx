module emitter

import php2v.ast

// analyze_types 统一类型分析入口
// 两阶段遍历：
// Phase 1: 类型推导 + 对象类型扫描 + 变异分析 → 解析到 t.inferred_types
// Phase 2: 构造函数/方法调用点扫描（依赖 t.inferred_types）
pub fn (mut t Transpiler) analyze_types(stmts []ast.AstNode) {
	mut ctx := AnalyzeCtx{}

	// Phase 1: 类型推导 + 对象扫描 + 变异分析
	t.analyze_stmts_phase1(stmts, mut ctx)

	// 先解析对象类型（Phase 2 的方法调用点扫描需要 inferred_types 中的对象类型）
	for name, classes in ctx.object_classes {
		if classes.len == 0 {
			continue
		}
		first_class := classes[0]
		mut all_same := true
		for cls in classes {
			if cls != first_class {
				all_same = false
				break
			}
		}
		if all_same && first_class != '' {
			t.inferred_types[name] = VarType{ tag: .t_object, class_name: first_class }
		}
	}

	// Phase 2: 调用点扫描（构造函数/方法，依赖对象类型）
	t.analyze_stmts_phase2(stmts)

	// Phase 3: 函数类型推断（参数类型 + 返回值类型 + 局部变量类型）
	t.analyze_func_types(stmts)

	// Phase 4: 重新推导标量变量类型（此时 func_return_types 已填充）
	// 只更新尚未确定类型的变量，避免覆盖已解析的对象类型
	mut ctx2 := AnalyzeCtx{}
	ctx2.infer_types = true
	t.analyze_stmts_phase1(stmts, mut ctx2)

	// 解析标量变量类型（仅当变量尚未在 inferred_types 中时）
	for name, tags in ctx2.var_assign_types {
		if tags.len == 0 {
			continue
		}
		// 如果变量已有类型（如对象类型），跳过
		if name in t.inferred_types {
			continue
		}
		first := tags[0]
		mut all_same := true
		for tag in tags {
			if tag != first {
				all_same = false
				break
			}
		}
		if all_same && first in [.t_int, .t_float, .t_bool, .t_string] {
			t.inferred_types[name] = VarType{ tag: first }
		} else {
			t.inferred_types[name] = VarType{ tag: .t_unknown }
		}
	}
}

// AnalyzeCtx 统一分析上下文，携带各 pass 需要的局部数据
struct AnalyzeCtx {
mut:
	var_assign_types map[string][]TypeTag
	object_classes   map[string][]string
	infer_types      bool = true
}

// analyze_stmts_phase1 第一阶段：类型推导 + 对象扫描 + 变异分析
fn (mut t Transpiler) analyze_stmts_phase1(stmts []ast.AstNode, mut ctx AnalyzeCtx) {
	for stmt in stmts {
		t.analyze_stmt_phase1(stmt, mut ctx)
	}
}

fn (mut t Transpiler) analyze_stmt_phase1(node ast.AstNode, mut ctx AnalyzeCtx) {
	match node.node_type {
		ast.node_stmt_expression {
			if expr := node.expr {
				if ctx.infer_types {
					t.infer_expr_types(*expr, mut ctx.var_assign_types)
				}
				t.scan_object_types_expr(*expr, mut ctx.object_classes)
				t.scan_mutations_expr(*expr)
			}
		}
		ast.node_stmt_if {
			if ctx.infer_types {
				if cond := node.cond { t.infer_expr_types(*cond, mut ctx.var_assign_types) }
			}
			t.analyze_stmts_phase1(node.stmts, mut ctx)
			for elseif in node.elseifs {
				if ctx.infer_types {
					if elseif_cond := elseif.cond { t.infer_expr_types(*elseif_cond, mut ctx.var_assign_types) }
				}
				t.analyze_stmts_phase1(elseif.stmts, mut ctx)
			}
			if el := node.@else {
				t.analyze_stmts_phase1(el.stmts, mut ctx)
			}
		}
		ast.node_stmt_while, ast.node_stmt_do {
			if ctx.infer_types {
				if cond := node.cond { t.infer_expr_types(*cond, mut ctx.var_assign_types) }
			}
			t.analyze_stmts_phase1(node.stmts, mut ctx)
		}
		ast.node_stmt_for {
			if ctx.infer_types {
				for init in node.init { t.infer_expr_types(init, mut ctx.var_assign_types) }
				for cond in node.conds { t.infer_expr_types(cond, mut ctx.var_assign_types) }
				for loop_expr in node.loop {
					t.infer_expr_types(loop_expr, mut ctx.var_assign_types)
					t.scan_mutations_expr(loop_expr)
				}
			} else {
				for loop_expr in node.loop {
					t.scan_mutations_expr(loop_expr)
				}
			}
			t.analyze_stmts_phase1(node.stmts, mut ctx)
		}
		ast.node_stmt_foreach {
			if ctx.infer_types {
				if expr := node.expr { t.infer_expr_types(*expr, mut ctx.var_assign_types) }
				if val_var := node.value_var {
					ctx.var_assign_types[val_var.name] << .t_unknown
				}
				if key_var := node.key_var {
					ctx.var_assign_types[key_var.name] << .t_unknown
				}
			}
			t.analyze_stmts_phase1(node.stmts, mut ctx)
		}
		ast.node_stmt_try_catch {
			t.analyze_stmts_phase1(node.stmts, mut ctx)
			for c in node.catches {
				if ctx.infer_types {
					if c_var := c.var {
						ctx.var_assign_types[c_var.name] << .t_unknown
					}
				}
				t.analyze_stmts_phase1(c.stmts, mut ctx)
			}
			if fin := node.finally {
				t.analyze_stmts_phase1(fin.stmts, mut ctx)
			}
		}
		ast.node_stmt_switch {
			if ctx.infer_types {
				if cond := node.cond { t.infer_expr_types(*cond, mut ctx.var_assign_types) }
			}
			for case_node in node.cases {
				if ctx.infer_types {
					if case_cond := case_node.cond { t.infer_expr_types(*case_cond, mut ctx.var_assign_types) }
				}
				t.analyze_stmts_phase1(case_node.stmts, mut ctx)
			}
		}
		ast.node_stmt_namespace {
			old_ns := t.current_namespace
			t.current_namespace = node.name
			t.analyze_stmts_phase1(node.stmts, mut ctx)
			t.current_namespace = old_ns
		}
		ast.node_stmt_unset {
			for v in node.vars {
				if v.node_type == ast.node_expr_variable {
					t.mutated_vars[v.name] = true
				}
			}
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
		// 函数/类：descend for object/mutation scans, 但不做顶层类型推导
		ast.node_stmt_function {
			old_infer := ctx.infer_types
			ctx.infer_types = false
			t.analyze_stmts_phase1(node.stmts, mut ctx)
			ctx.infer_types = old_infer
		}
		ast.node_stmt_class {
			old_infer := ctx.infer_types
			ctx.infer_types = false
			t.analyze_stmts_phase1(node.stmts, mut ctx)
			ctx.infer_types = old_infer
		}
		ast.node_stmt_class_method {
			old_infer := ctx.infer_types
			ctx.infer_types = false
			t.analyze_stmts_phase1(node.stmts, mut ctx)
			ctx.infer_types = old_infer
		}
		else {}
	}
}

// analyze_stmts_phase2 第二阶段：构造函数/方法调用点扫描（依赖 t.inferred_types）
fn (mut t Transpiler) analyze_stmts_phase2(stmts []ast.AstNode) {
	for stmt in stmts {
		t.analyze_stmt_phase2(stmt)
	}
}

fn (mut t Transpiler) analyze_stmt_phase2(node ast.AstNode) {
	match node.node_type {
		ast.node_stmt_expression {
			if expr := node.expr {
				t.scan_ctor_call_sites_expr(*expr)
				t.scan_method_call_sites_expr(*expr)
			}
		}
		ast.node_stmt_if {
			t.analyze_stmts_phase2(node.stmts)
			for elseif in node.elseifs { t.analyze_stmts_phase2(elseif.stmts) }
			if el := node.@else { t.analyze_stmts_phase2(el.stmts) }
		}
		ast.node_stmt_while, ast.node_stmt_do {
			t.analyze_stmts_phase2(node.stmts)
		}
		ast.node_stmt_for {
			for init in node.init { t.scan_ctor_call_sites_expr(init) }
			for cond in node.conds { t.scan_ctor_call_sites_expr(cond) }
			for loop_expr in node.loop {
				t.scan_ctor_call_sites_expr(loop_expr)
				t.scan_method_call_sites_expr(loop_expr)
			}
			t.analyze_stmts_phase2(node.stmts)
		}
		ast.node_stmt_foreach {
			t.analyze_stmts_phase2(node.stmts)
		}
		ast.node_stmt_try_catch {
			t.analyze_stmts_phase2(node.stmts)
			for c in node.catches { t.analyze_stmts_phase2(c.stmts) }
			if fin := node.finally { t.analyze_stmts_phase2(fin.stmts) }
		}
		ast.node_stmt_switch {
			for case_node in node.cases { t.analyze_stmts_phase2(case_node.stmts) }
		}
		ast.node_stmt_namespace {
			t.analyze_stmts_phase2(node.stmts)
		}
		ast.node_stmt_echo {
			for expr in node.exprs { t.scan_method_call_sites_expr(expr) }
		}
		ast.node_stmt_return {
			if expr := node.expr { t.scan_method_call_sites_expr(*expr) }
		}
		ast.node_stmt_function {
			t.analyze_stmts_phase2(node.stmts)
		}
		ast.node_stmt_class {
			t.analyze_stmts_phase2(node.stmts)
		}
		ast.node_stmt_class_method {
			t.analyze_stmts_phase2(node.stmts)
		}
		else {}
	}
}
fn (mut t Transpiler) infer_expr_types(node ast.AstNode, mut var_assign_types map[string][]TypeTag) TypeTag {
	match node.node_type {
		ast.node_scalar_int {
			return .t_int
		}
		ast.node_scalar_float {
			return .t_float
		}
		ast.node_scalar_string {
			return .t_string
		}
		ast.node_scalar_encapsed, ast.node_scalar_interpolated_string {
			return .t_string
		}
		ast.node_expr_const {
			match node.name.to_lower() {
				'true', 'false' { return .t_bool }
				'null' { return .t_null }
				else {
					if gc := t.global_constants[node.name] {
						return gc.typ.tag
					}
					return .t_unknown
				}
			}
		}
		ast.node_expr_variable {
			if node.name in ['_GET', '_POST', '_SERVER', '_COOKIE', '_SESSION', '_REQUEST', '_ENV'] {
				return .t_unknown
			}
			mut current_tag := TypeTag.t_unknown
			if tags := var_assign_types[node.name] {
				if tags.len > 0 {
					current_tag = tags[0]
					for tag in tags {
						if tag != current_tag {
							current_tag = .t_unknown
							break
						}
					}
				}
			}
			return current_tag
		}
		ast.node_expr_assign {
			var_node := node.var or { return .t_unknown }
			expr_node := node.expr or { return .t_unknown }
			val_type := t.infer_expr_types(*expr_node, mut var_assign_types)
			if var_node.node_type == ast.node_expr_variable {
				var_assign_types[var_node.name] << val_type
			}
			return val_type
		}
		ast.node_bin_plus, ast.node_bin_minus, ast.node_bin_mul, ast.node_bin_div,
		ast.node_bin_bitwise_and, ast.node_bin_bitwise_or, ast.node_bin_bitwise_xor,
		ast.node_bin_shift_left, ast.node_bin_shift_right {
			left := node.left or { return .t_unknown }
			right := node.right or { return .t_unknown }
			l_type := t.infer_expr_types(*left, mut var_assign_types)
			r_type := t.infer_expr_types(*right, mut var_assign_types)
			if l_type == .t_int && r_type == .t_int {
				return .t_int
			}
			if l_type == .t_float || r_type == .t_float {
				return .t_float
			}
			return .t_unknown
		}
		ast.node_bin_mod {
			left := node.left or { return .t_unknown }
			right := node.right or { return .t_unknown }
			l_type := t.infer_expr_types(*left, mut var_assign_types)
			r_type := t.infer_expr_types(*right, mut var_assign_types)
			if l_type == .t_int && r_type == .t_int {
				return .t_int
			}
			return .t_unknown
		}
		ast.node_bin_greater, ast.node_bin_smaller, ast.node_bin_greater_equal,
		ast.node_bin_smaller_equal, ast.node_bin_equal, ast.node_bin_identical {
			left := node.left or { return .t_unknown }
			right := node.right or { return .t_unknown }
			t.infer_expr_types(*left, mut var_assign_types)
			t.infer_expr_types(*right, mut var_assign_types)
			return .t_bool
		}
		ast.node_bin_bool_and, ast.node_bin_logical_and,
		ast.node_bin_bool_or, ast.node_bin_logical_or {
			left := node.left or { return .t_unknown }
			right := node.right or { return .t_unknown }
			t.infer_expr_types(*left, mut var_assign_types)
			t.infer_expr_types(*right, mut var_assign_types)
			return .t_bool
		}
		ast.node_expr_boolean_not {
			expr_node := node.expr or { return .t_unknown }
			t.infer_expr_types(*expr_node, mut var_assign_types)
			return .t_bool
		}
		ast.node_expr_ternary {
			cond := node.cond or { return .t_unknown }
			t.infer_expr_types(*cond, mut var_assign_types)
			if if_node := node.@if {
				else_node := node.@else or { return .t_unknown }
				if_type := t.infer_expr_types(*if_node, mut var_assign_types)
				else_type := t.infer_expr_types(*else_node, mut var_assign_types)
				if if_type == else_type {
					return if_type
				}
			} else {
				else_node := node.@else or { return .t_unknown }
				cond_type := t.infer_expr_types(*cond, mut var_assign_types)
				else_type := t.infer_expr_types(*else_node, mut var_assign_types)
				if cond_type == else_type {
					return cond_type
				}
			}
			return .t_unknown
		}
		ast.node_bin_coalesce {
			left := node.left or { return .t_unknown }
			right := node.right or { return .t_unknown }
			l_type := t.infer_expr_types(*left, mut var_assign_types)
			r_type := t.infer_expr_types(*right, mut var_assign_types)
			if l_type == r_type {
				return l_type
			}
			return .t_unknown
		}
		ast.node_expr_bitwise_not {
			expr_node := node.expr or { return .t_unknown }
			e_type := t.infer_expr_types(*expr_node, mut var_assign_types)
			if e_type == .t_int { return .t_int }
			return .t_unknown
		}
		ast.node_expr_funccall {
			// 递归推断参数表达式类型
			for arg in node.args {
				if arg_expr := arg.expr { t.infer_expr_types(*arg_expr, mut var_assign_types) }
			}
			// 如果是内置函数，使用其已知的返回类型
			if tag := get_builtin_return_tag(node.name) {
				return tag
			}
			// 如果函数有已知的原生返回值类型，使用它
			if ret_type := t.func_return_types[node.name] {
				return ret_type.tag
			}
			return .t_unknown
		}
		else {
			if expr := node.expr { t.infer_expr_types(*expr, mut var_assign_types) }
			if left := node.left { t.infer_expr_types(*left, mut var_assign_types) }
			if right := node.right { t.infer_expr_types(*right, mut var_assign_types) }
			for arg in node.args {
				if arg_expr := arg.expr { t.infer_expr_types(*arg_expr, mut var_assign_types) }
			}
			return .t_unknown
		}
	}
}

// ─── P7: 对象类型扫描 pass ───
// 独立扫描 $x = new ClassName() 赋值，填充 object_classes
fn (mut t Transpiler) scan_object_types_expr(node ast.AstNode, mut object_classes map[string][]string) {
	match node.node_type {
		ast.node_expr_assign {
			var_node := node.var or { return }
			expr_node := node.expr or { return }
			if expr_node.node_type == ast.node_expr_new && var_node.node_type == ast.node_expr_variable {
				class_name := t.resolve_class_name(expr_node.class_name)
				object_classes[var_node.name] << class_name
			} else {
				if var_node.node_type == ast.node_expr_variable {
					object_classes[var_node.name] << ''
				}
			}
			t.scan_object_types_expr(*expr_node, mut object_classes)
		}
		else {
			if expr := node.expr { t.scan_object_types_expr(*expr, mut object_classes) }
			if left := node.left { t.scan_object_types_expr(*left, mut object_classes) }
			if right := node.right { t.scan_object_types_expr(*right, mut object_classes) }
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_object_types_expr(*arg_expr, mut object_classes) }
			}
		}
	}
}

// ─── P10: 变异分析 pass ───
// 扫描哪些变量被原地修改（array dim fetch 赋值、inc/dec、unset、property 赋值）
fn (mut t Transpiler) scan_mutations_expr(node ast.AstNode) {
	match node.node_type {
		ast.node_expr_assign {
			var_node := node.var or { return }
			// 数组维度赋值：$arr[] = x 或 $arr['k'] = x → $arr 被修改
			if var_node.node_type == ast.node_expr_array_dim_fetch {
				if base := var_node.var {
					if base.node_type == ast.node_expr_variable {
						t.mutated_vars[base.name] = true
					}
				}
			}
			// 属性赋值：$obj->prop = x → $obj 被修改
			if var_node.node_type == ast.node_expr_property_fetch {
				if base := var_node.var {
					if base.node_type == ast.node_expr_variable {
						t.mutated_vars[base.name] = true
					}
				}
			}
			if expr := node.expr { t.scan_mutations_expr(*expr) }
		}
		ast.node_expr_post_inc, ast.node_expr_post_dec,
		ast.node_expr_pre_inc, ast.node_expr_pre_dec {
			if var_node := node.var {
				if var_node.node_type == ast.node_expr_variable {
					t.mutated_vars[var_node.name] = true
				}
			}
		}
		else {
			if expr := node.expr { t.scan_mutations_expr(*expr) }
			if left := node.left { t.scan_mutations_expr(*left) }
			if right := node.right { t.scan_mutations_expr(*right) }
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_mutations_expr(*arg_expr) }
			}
		}
	}
}

// ─── P7 Pass 0: new ClassName(args) 调用点扫描 ───────────────────────
// 扫描全局 AST 中所有 new ClassName(args)，用实参类型初始化 ctor_arg_types
fn (mut t Transpiler) scan_ctor_call_sites_expr(node ast.AstNode) {
	match node.node_type {
		ast.node_expr_new {
			class_name := t.resolve_class_name(node.class_name).to_lower()
			mut dummy_types := map[string][]TypeTag{}
			mut arg_types := []TypeTag{}
			for arg in node.args {
				arg_expr := arg.expr or { continue }
				arg_type := t.infer_expr_types(*arg_expr, mut dummy_types)
				arg_types << arg_type
			}
			// 如果已有记录则覆盖（保持最先扫描到的）
			if class_name !in t.ctor_arg_types {
				t.ctor_arg_types[class_name] = arg_types.clone()
			} else {
				// 多个调用点：只保留类型一致的部分
				existing := t.ctor_arg_types[class_name]
				for i in 0 .. existing.len {
					if i < arg_types.len && existing[i] != arg_types[i] {
						t.ctor_arg_types[class_name][i] = .t_unknown
					}
				}
			}
		}
		else {
			if expr := node.expr { t.scan_ctor_call_sites_expr(*expr) }
			if left := node.left { t.scan_ctor_call_sites_expr(*left) }
			if right := node.right { t.scan_ctor_call_sites_expr(*right) }
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_ctor_call_sites_expr(*arg_expr) }
			}
		}
	}
}

// ─── P7 Pass 0b: 方法调用点扫描 ───────────────────────
// 扫描全局 AST 中所有 $obj->method(args)，用实参类型填充 method_call_arg_types
fn (mut t Transpiler) scan_method_call_sites_expr(node ast.AstNode) {
	match node.node_type {
		ast.node_expr_method_call {
			obj_var_node := node.var or { return }
			// 只处理 $var->method() 形式
			if obj_var_node.node_type == ast.node_expr_variable {
				obj_type := t.inferred_types[obj_var_node.name] or { VarType{ tag: .t_unknown } }
				if obj_type.is_object() {
					class_name := obj_type.class_name.to_lower()
					method_name := node.name
					mut dummy_types := map[string][]TypeTag{}
					mut arg_types := []TypeTag{}
					for arg in node.args {
						arg_expr := arg.expr or { continue }
						arg_type := t.infer_expr_types(*arg_expr, mut dummy_types)
						arg_types << arg_type
					}
					key := '${class_name}::${method_name}'
					if key !in t.method_call_arg_types {
						t.method_call_arg_types[key] = arg_types.clone()
					} else {
						// 多个调用点：只保留类型一致的部分
						existing := t.method_call_arg_types[key]
						for i in 0 .. existing.len {
							if i < arg_types.len && existing[i] != arg_types[i] {
								t.method_call_arg_types[key][i] = .t_unknown
							}
						}
					}
				}
			}
			// 递归扫描子表达式
			if obj := node.var { t.scan_method_call_sites_expr(*obj) }
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_method_call_sites_expr(*arg_expr) }
			}
		}
		ast.node_expr_static_call {
			// 处理 Class::method() 形式的静态调用
			class_name := t.resolve_class_name(node.class_name).to_lower()
			method_name := node.name
			mut dummy_types := map[string][]TypeTag{}
			mut arg_types := []TypeTag{}
			for arg in node.args {
				arg_expr := arg.expr or { continue }
				arg_type := t.infer_expr_types(*arg_expr, mut dummy_types)
				arg_types << arg_type
			}
			key := '${class_name}::${method_name}'
			if key !in t.method_call_arg_types {
				t.method_call_arg_types[key] = arg_types.clone()
			} else {
				// 多个调用点：只保留类型一致的部分
				existing := t.method_call_arg_types[key]
				for i in 0 .. existing.len {
					if i < arg_types.len && existing[i] != arg_types[i] {
						t.method_call_arg_types[key][i] = .t_unknown
					}
				}
			}
			// 递归扫描参数表达式
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_method_call_sites_expr(*arg_expr) }
			}
		}
		else {
			if expr := node.expr { t.scan_method_call_sites_expr(*expr) }
			if left := node.left { t.scan_method_call_sites_expr(*left) }
			if right := node.right { t.scan_method_call_sites_expr(*right) }
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_method_call_sites_expr(*arg_expr) }
			}
		}
	}
}

// ─── P7 Phase 1: 属性 + 参数 + 返回值类型推断 ───────────────

// infer_class_types 推断所有类的属性类型、参数类型和返回值类型
pub fn (mut t Transpiler) infer_class_types(stmts []ast.AstNode) {
	for stmt in stmts {
		if stmt.node_type == ast.node_stmt_class {
			class_name := t.resolve_class_name(stmt.name)
			// 推断属性类型
			mut prop_tags := map[string][]TypeTag{}
			mut var_assign_types := map[string][]TypeTag{}
			for method_stmt in stmt.stmts {
				if method_stmt.node_type == ast.node_stmt_class_method {
					t.scan_prop_assignments(method_stmt.stmts, mut prop_tags, mut var_assign_types)
				}
			}
			// 确定每个属性的最终类型
			mut prop_types := map[string]VarType{}
			for prop_name, tags in prop_tags {
				if tags.len > 0 {
					first := tags[0]
					mut all_same := true
					for tag in tags {
						if tag != first {
							all_same = false
							break
						}
					}
					if all_same && first in [.t_int, .t_float, .t_bool, .t_string] {
						prop_types[prop_name] = VarType{ tag: first }
					}
				}
			}
			// 存储到对应的 ClassInfo
			for i, cls in t.classes {
				if cls.name == class_name {
					t.classes[i].prop_types = prop_types.clone()
					break
				}
			}

			// 推断参数类型
			mut param_types := map[string]map[string]VarType{}
			for method_stmt in stmt.stmts {
				if method_stmt.node_type == ast.node_stmt_class_method {
					method_name := method_stmt.name
					mut method_params := map[string]VarType{}
					for param in method_stmt.params {
						param_var := param.var or { continue }
						param_name := param_var.name
						// 1) PHP 类型提示优先
						mut param_type := VarType{ tag: .t_unknown }
						if param.incl_type != '' {
							hint_tag := php_type_to_tag(param.incl_type)
							if hint_tag != .t_unknown {
								param_type = VarType{ tag: hint_tag }
							}
						}
						// 2) 回退：分析参数使用
						if param_type.tag == .t_unknown {
							param_type = t.infer_param_type_from_usage(method_stmt.stmts, param_name, prop_types)
						}
						if param_type.tag != .t_unknown {
							method_params[param_name] = param_type
						}
					}
					if method_params.len > 0 {
						param_types[method_name] = method_params.clone()
					}
				}
			}
			for i, cls in t.classes {
				if cls.name == class_name {
					t.classes[i].param_types = param_types.clone()
					break
				}
			}

			// 推断返回值类型
			mut return_types := map[string]VarType{}
			for method_stmt in stmt.stmts {
				if method_stmt.node_type == ast.node_stmt_class_method {
					method_name := method_stmt.name
					// PHP 返回类型提示优先
					mut ret_type := VarType{ tag: .t_unknown }
					if method_stmt.return_type != '' {
						hint := method_stmt.return_type.trim_left('?')
						hint_tag := php_type_to_tag(hint)
						if hint_tag != .t_unknown {
							ret_type = VarType{ tag: hint_tag }
						} else if method_stmt.return_type.to_lower() == 'void' {
							ret_type = VarType{ tag: .t_void }
						}
					}
					if ret_type.tag == .t_unknown {
						ret_type = t.infer_method_return_type(method_stmt.stmts, prop_types)
					}
					if ret_type.tag != .t_unknown {
						return_types[method_name] = ret_type
					}
				}
			}
			for i, cls in t.classes {
				if cls.name == class_name {
					t.classes[i].return_types = return_types.clone()
					break
				}
			}
		} else if stmt.node_type == ast.node_stmt_namespace {
			t.infer_class_types(stmt.stmts)
		}
	}
}

// scan_prop_assignments 扫描方法体中的 $this->prop = expr 赋值
fn (mut t Transpiler) scan_prop_assignments(stmts []ast.AstNode, mut prop_tags map[string][]TypeTag, mut var_assign_types map[string][]TypeTag) {
	for stmt in stmts {
		t.scan_prop_assignments_expr(stmt, mut prop_tags, mut var_assign_types)
	}
}

fn (mut t Transpiler) scan_prop_assignments_expr(node ast.AstNode, mut prop_tags map[string][]TypeTag, mut var_assign_types map[string][]TypeTag) {
	match node.node_type {
		ast.node_expr_assign {
			var_node := node.var or { return }
			expr_node := node.expr or { return }
			// 检测 $this->prop = expr
			if var_node.node_type == ast.node_expr_property_fetch {
				obj := var_node.var or { return }
				if obj.node_type == ast.node_expr_variable && obj.name == 'this' {
					prop_name := var_node.name
					val_type := t.infer_expr_types(*expr_node, mut var_assign_types)
					prop_tags[prop_name] << val_type
				}
			}
			// 递归扫描右侧
			t.scan_prop_assignments_expr(*expr_node, mut prop_tags, mut var_assign_types)
		}
		else {
			// 递归子节点
			if expr := node.expr { t.scan_prop_assignments_expr(*expr, mut prop_tags, mut var_assign_types) }
			if left := node.left { t.scan_prop_assignments_expr(*left, mut prop_tags, mut var_assign_types) }
			if right := node.right { t.scan_prop_assignments_expr(*right, mut prop_tags, mut var_assign_types) }
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_prop_assignments_expr(*arg_expr, mut prop_tags, mut var_assign_types) }
			}
			for stmt in node.stmts {
				t.scan_prop_assignments_expr(stmt, mut prop_tags, mut var_assign_types)
			}
			for elseif in node.elseifs {
				t.scan_prop_assignments_expr(elseif, mut prop_tags, mut var_assign_types)
			}
			if el := node.@else { t.scan_prop_assignments_expr(*el, mut prop_tags, mut var_assign_types) }
		}
	}
}

// infer_param_type_from_usage 分析方法体中参数的使用方式，推断参数的原生类型
// 策略：如果参数仅被赋值给某原生类型属性，则参数也用该类型
fn (mut t Transpiler) infer_param_type_from_usage(stmts []ast.AstNode, param_name string, prop_types map[string]VarType) VarType {
	usage := t.scan_param_usage(stmts, param_name)
	assigned_props := usage.assigned_props
	// 如果参数有非属性赋值的使用（如传给函数、做运算），则保持 PhpVal
	if usage.other_uses {
		return VarType{ tag: .t_unknown }
	}
	// 如果参数只被赋值给属性，检查所有目标属性的类型是否一致
	if assigned_props.len == 0 {
		return VarType{ tag: .t_unknown }
	}
	mut first_type := VarType{ tag: .t_unknown }
	for i, prop in assigned_props {
		if typ := prop_types[prop] {
			if i == 0 {
				first_type = typ
			} else if typ.tag != first_type.tag {
				return VarType{ tag: .t_unknown }
			}
		} else {
			return VarType{ tag: .t_unknown }
		}
	}
	return first_type
}

struct ParamUsageResult {
	pub mut:
		assigned_props []string
		other_uses     bool
}

fn (mut t Transpiler) scan_param_usage(stmts []ast.AstNode, param_name string) ParamUsageResult {
	mut result := ParamUsageResult{}
	for stmt in stmts {
		t.scan_param_usage_expr(stmt, param_name, mut result)
	}
	return result
}

fn (mut t Transpiler) scan_param_usage_expr(node ast.AstNode, param_name string, mut result ParamUsageResult) {
	match node.node_type {
		ast.node_expr_assign {
			var_node := node.var or { return }
			expr_node := node.expr or { return }
			// 检查 $this->prop = $param
			if var_node.node_type == ast.node_expr_property_fetch {
				obj := var_node.var or { return }
				if obj.node_type == ast.node_expr_variable && obj.name == 'this' {
					if expr_node.node_type == ast.node_expr_variable && expr_node.name == param_name {
						result.assigned_props << var_node.name
						return
					}
				}
			}
			// 检查右侧是否引用了参数
			if t.expr_references_var(*expr_node, param_name) {
				result.other_uses = true
			}
		}
		else {
			// 检查是否在其他上下文中引用了参数
			if t.expr_references_var(node, param_name) {
				// 排除赋值左侧（已处理）
				if node.node_type != ast.node_expr_assign {
					result.other_uses = true
				}
			}
		}
	}
	// 递归
	if expr := node.expr {
		t.scan_param_usage_expr(*expr, param_name, mut result)
	}
	for stmt in node.stmts {
		t.scan_param_usage_expr(stmt, param_name, mut result)
	}
	for elseif in node.elseifs {
		t.scan_param_usage_expr(elseif, param_name, mut result)
	}
	if el := node.@else {
		t.scan_param_usage_expr(*el, param_name, mut result)
	}
}

// expr_references_var 检查表达式是否引用了指定变量
fn (t &Transpiler) expr_references_var(node ast.AstNode, var_name string) bool {
	if node.node_type == ast.node_expr_variable && node.name == var_name {
		return true
	}
	if expr := node.expr {
		if t.expr_references_var(*expr, var_name) { return true }
	}
	if left := node.left {
		if t.expr_references_var(*left, var_name) { return true }
	}
	if right := node.right {
		if t.expr_references_var(*right, var_name) { return true }
	}
	for arg in node.args {
		if arg_expr := arg.expr {
			if t.expr_references_var(*arg_expr, var_name) { return true }
		}
	}
	for stmt in node.stmts {
		if t.expr_references_var(stmt, var_name) { return true }
	}
	for elseif in node.elseifs {
		if t.expr_references_var(elseif, var_name) { return true }
	}
	if el := node.@else {
		if t.expr_references_var(*el, var_name) { return true }
	}
	return false
}

// infer_method_return_type 分析方法的返回值类型
// 策略：如果所有 return 语句都返回 $this->prop（原生类型），则返回值也是该类型
fn (mut t Transpiler) infer_method_return_type(stmts []ast.AstNode, prop_types map[string]VarType) VarType {
	mut return_tags := []TypeTag{}
	t.scan_return_types(stmts, prop_types, mut return_tags)
	if return_tags.len == 0 {
		// 没有 return 语句或只有 return; → void 函数
		return VarType{ tag: .t_void }
	}
	first := return_tags[0]
	mut all_same := true
	for tag in return_tags {
		if tag != first {
			all_same = false
			break
		}
	}
	if all_same && first in [.t_int, .t_float, .t_bool, .t_string] {
		return VarType{ tag: first }
	}
	return VarType{ tag: .t_unknown }
}

fn (mut t Transpiler) scan_return_types(stmts []ast.AstNode, prop_types map[string]VarType, mut return_tags []TypeTag) {
	for stmt in stmts {
		match stmt.node_type {
			ast.node_stmt_return {
				if expr := stmt.expr {
					// 检查 return $this->prop
					if expr.node_type == ast.node_expr_property_fetch {
						obj := expr.var or { continue }
						if obj.node_type == ast.node_expr_variable && obj.name == 'this' {
							if typ := prop_types[expr.name] {
								return_tags << typ.tag
							} else {
								return_tags << .t_unknown
							}
						} else {
							return_tags << .t_unknown
						}
					} else {
						return_tags << .t_unknown
					}
				}
			}
			else {
				t.scan_return_types(stmt.stmts, prop_types, mut return_tags)
				for elseif in stmt.elseifs {
					t.scan_return_types(elseif.stmts, prop_types, mut return_tags)
				}
				if el := stmt.@else {
					t.scan_return_types(el.stmts, prop_types, mut return_tags)
				}
			}
		}
	}
}

// infer_single_class_types 推断单个类的属性类型、参数类型和返回值类型
// 在 visit_class 中调用，class 已经添加到 t.classes 中
// P7 多 Pass 推断：
//   Pass 0: 已在 analyze_types 中扫描调用点，结果在 t.ctor_arg_types
//   Pass 1: 用实参类型在 var_assign_types 中初始化参数，再跑属性扫描
//   Pass 2: 用 prop_types 推断参数类型
//   Pass 3: 用 prop_types 推断返回值类型
pub fn (mut t Transpiler) infer_single_class_types(node ast.AstNode, class_name string) {
	// --- Pass 1: 用构造函数实参类型初始化 var_assign_types，再扫描属性 ---
	// 找到构造函数的 AST 节点
	mut ctor_node := ?ast.AstNode(none)
	for method_stmt in node.stmts {
		if method_stmt.node_type == ast.node_stmt_class_method && method_stmt.name == '__construct' {
			ctor_node = method_stmt
			break
		}
	}

	// 构建初始 var_assign_types：优先 PHP 类型提示，其次调用点实参类型
	mut var_assign_types := map[string][]TypeTag{}
	if ctor := ctor_node {
		for i, param in ctor.params {
			param_var := param.var or { continue }
			param_name := param_var.name
			// 1) PHP 类型提示优先
			if param.incl_type != '' {
				hint_tag := php_type_to_tag(param.incl_type)
				if hint_tag != .t_unknown {
					var_assign_types[param_name] << hint_tag
					continue
				}
			}
			// 2) 回退：调用点实参类型
			if arg_types := t.ctor_arg_types[class_name.to_lower()] {
				if i < arg_types.len {
					arg_tag := arg_types[i]
					if arg_tag in [.t_int, .t_float, .t_bool, .t_string] {
						var_assign_types[param_name] << arg_tag
					}
				}
			}
		}
	}

	// 扫描所有方法中的 $this->prop = expr 赋值，推断属性类型
	mut prop_tags := map[string][]TypeTag{}
	for method_stmt in node.stmts {
		if method_stmt.node_type == ast.node_stmt_class_method {
			// 每个方法都用公共的 var_assign_types（包含平级参数类型）
			t.scan_prop_assignments(method_stmt.stmts, mut prop_tags, mut var_assign_types)
		}
	}

	// 确定每个属性的最终类型
	mut prop_types := map[string]VarType{}
	for prop_name, tags in prop_tags {
		if tags.len > 0 {
			first := tags[0]
			mut all_same := true
			for tag in tags {
				if tag != first {
					all_same = false
					break
				}
			}
			if all_same && first in [.t_int, .t_float, .t_bool, .t_string] {
				prop_types[prop_name] = VarType{ tag: first }
			}
		}
	}

	// --- Pass 2: 用 prop_types 推断方法参数类型 ---
	mut param_types := map[string]map[string]VarType{}
	for method_stmt in node.stmts {
		if method_stmt.node_type == ast.node_stmt_class_method {
			method_name := method_stmt.name
			mut method_params := map[string]VarType{}
			// 查找方法调用点的实参类型
			call_key := '${class_name.to_lower()}::${method_name}'
			mut call_arg_types := []TypeTag{}
			if cat := t.method_call_arg_types[call_key] {
				call_arg_types = cat.clone()
			}
			for i, param in method_stmt.params {
				param_var := param.var or { continue }
				param_name := param_var.name
				// 0) PHP 类型提示优先
				mut param_type := VarType{ tag: .t_unknown }
				if param.incl_type != '' {
					hint_tag := php_type_to_tag(param.incl_type)
					if hint_tag != .t_unknown {
						param_type = VarType{ tag: hint_tag }
					}
				}
				// 1) 回退：分析参数使用
				if param_type.tag == .t_unknown {
					param_type = t.infer_param_type_from_usage(method_stmt.stmts, param_name, prop_types)
				}
				if param_type.tag != .t_unknown {
					method_params[param_name] = param_type
				} else if i < call_arg_types.len && call_arg_types[i] in [.t_int, .t_float, .t_bool, .t_string] {
					// 从方法调用点实参推断
					method_params[param_name] = VarType{ tag: call_arg_types[i] }
				} else {
					// 备用：构造函数参数从调用点推断
					if method_name == '__construct' {
						if tag := var_assign_types[param_name] {
							if tag.len > 0 && tag[0] in [.t_int, .t_float, .t_bool, .t_string] {
								method_params[param_name] = VarType{ tag: tag[0] }
							}
						}
					}
				}
			}
			if method_params.len > 0 {
				param_types[method_name] = method_params.clone()
			}
		}
	}

	// --- Pass 3: 用 prop_types 推断返回值类型 ---
	mut return_types := map[string]VarType{}
	for method_stmt in node.stmts {
		if method_stmt.node_type == ast.node_stmt_class_method {
			method_name := method_stmt.name
			// PHP 返回类型提示优先
			mut ret_type := VarType{ tag: .t_unknown }
			if method_stmt.return_type != '' {
				hint := method_stmt.return_type.trim_left('?')
				hint_tag := php_type_to_tag(hint)
				if hint_tag != .t_unknown {
					ret_type = VarType{ tag: hint_tag }
				} else if method_stmt.return_type.to_lower() == 'void' {
					ret_type = VarType{ tag: .t_void }
				}
			}
			if ret_type.tag == .t_unknown {
				ret_type = t.infer_method_return_type(method_stmt.stmts, prop_types)
			}
			if ret_type.tag != .t_unknown {
				return_types[method_name] = ret_type
			}
		}
	}

	// 存储到对应的 ClassInfo
	for i, cls in t.classes {
		if cls.name == class_name {
			t.classes[i].prop_types = prop_types.clone()
			t.classes[i].param_types = param_types.clone()
			t.classes[i].return_types = return_types.clone()
			break
		}
	}
}

// ─── Phase 3: 函数类型推断 ───────────────────────

// analyze_func_types 扫描所有函数定义和调用点，推断参数类型、返回值类型和局部变量类型
pub fn (mut t Transpiler) analyze_func_types(stmts []ast.AstNode) {
	// Step 1: 扫描函数调用点，收集实参类型
	t.scan_func_call_sites(stmts)

	// Step 2: 对每个函数，用调用点实参类型推断参数类型和返回值类型
	t.infer_func_types_from_stmts(stmts)
}

// scan_func_call_sites 递归扫描 AST 中所有函数调用，收集实参类型
fn (mut t Transpiler) scan_func_call_sites(stmts []ast.AstNode) {
	for stmt in stmts {
		t.scan_func_call_sites_expr(stmt)
	}
}

fn (mut t Transpiler) scan_func_call_sites_expr(node ast.AstNode) {
	match node.node_type {
		ast.node_expr_funccall {
			func_name := node.name
			if func_name in t.custom_functions {
				mut arg_types := []TypeTag{}
				mut dummy_types := map[string][]TypeTag{}
				for arg in node.args {
					arg_expr := arg.expr or { continue }
					arg_type := t.infer_expr_types(*arg_expr, mut dummy_types)
					arg_types << arg_type
				}
				if func_name !in t.func_call_arg_types {
					t.func_call_arg_types[func_name] = arg_types.clone()
				} else {
					existing := t.func_call_arg_types[func_name]
					for i in 0 .. existing.len {
						if i < arg_types.len && existing[i] != arg_types[i] {
							t.func_call_arg_types[func_name][i] = .t_unknown
						}
					}
				}
			}
			// 递归扫描子表达式
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_func_call_sites_expr(*arg_expr) }
			}
		}
		else {
			if expr := node.expr { t.scan_func_call_sites_expr(*expr) }
			if left := node.left { t.scan_func_call_sites_expr(*left) }
			if right := node.right { t.scan_func_call_sites_expr(*right) }
			for arg in node.args {
				if arg_expr := arg.expr { t.scan_func_call_sites_expr(*arg_expr) }
			}
			t.scan_func_call_sites(node.stmts)
			for elseif in node.elseifs {
				t.scan_func_call_sites(elseif.stmts)
			}
			if el := node.@else { t.scan_func_call_sites(el.stmts) }
		}
	}
}

// infer_func_types_from_stmts 递归扫描函数定义，推断参数/返回值/局部变量类型
fn (mut t Transpiler) infer_func_types_from_stmts(stmts []ast.AstNode) {
	for stmt in stmts {
		if stmt.node_type == ast.node_stmt_function {
			t.infer_single_func_types(stmt)
		} else if stmt.node_type == ast.node_stmt_namespace {
			t.infer_func_types_from_stmts(stmt.stmts)
		}
	}
}

// php_type_to_tag 将 PHP 类型提示字符串映射为 TypeTag。
// 仅处理简单标量类型；nullable (?string)、联合 (int|string)、类名等返回 .t_unknown。
fn php_type_to_tag(php_type string) TypeTag {
	match php_type.to_lower() {
		'string' { return .t_string }
		'int', 'integer' { return .t_int }
		'float', 'double' { return .t_float }
		'bool', 'boolean' { return .t_bool }
		else { return .t_unknown }
	}
}

// infer_single_func_types 推断单个函数的参数类型、返回值类型和局部变量类型
fn (mut t Transpiler) infer_single_func_types(node ast.AstNode) {
	func_name := node.name

	// 推断参数类型：PHP 类型提示优先，其次从调用点实参推断
	mut param_types := map[string]VarType{}
	mut var_assign_types := map[string][]TypeTag{}
	for i, param in node.params {
		param_var := param.var or { continue }
		param_name := param_var.name

		// 1) PHP 类型提示（如 string $name, int $age）
		mut resolved_tag := TypeTag.t_unknown
		if param.incl_type != '' {
			hint_tag := php_type_to_tag(param.incl_type)
			if hint_tag != .t_unknown {
				resolved_tag = hint_tag
			}
		}

		// 2) 无类型提示时，从调用点实参推断
		if resolved_tag == .t_unknown {
			if arg_types := t.func_call_arg_types[func_name] {
				if i < arg_types.len {
					arg_tag := arg_types[i]
					if arg_tag in [.t_int, .t_float, .t_bool, .t_string] {
						resolved_tag = arg_tag
					}
				}
			}
		}

		if resolved_tag != .t_unknown {
			param_types[param_name] = VarType{ tag: resolved_tag }
			var_assign_types[param_name] << resolved_tag
		}
	}

	// 用参数类型作为种子，对函数体跑类型推导，推断局部变量类型
	t.infer_expr_types_for_func(node.stmts, mut var_assign_types)

	// 解析局部变量类型
	mut local_var_types := map[string]VarType{}
	for vname, tags in var_assign_types {
		if tags.len == 0 { continue }
		first := tags[0]
		mut all_same := true
		for tag in tags {
			if tag != first {
				all_same = false
				break
			}
		}
		if all_same && first in [.t_int, .t_float, .t_bool, .t_string] {
			local_var_types[vname] = VarType{ tag: first }
		}
	}

	// 推断返回值类型：PHP 返回类型提示优先
	mut ret_type := VarType{ tag: .t_unknown }
	if node.return_type != '' {
		hint := node.return_type.trim_left('?')
		hint_tag := php_type_to_tag(hint)
		if hint_tag != .t_unknown {
			ret_type = VarType{ tag: hint_tag }
		} else if node.return_type.to_lower() == 'void' {
			ret_type = VarType{ tag: .t_void }
		}
	}
	if ret_type.tag == .t_unknown {
		ret_type = t.infer_func_return_type(node.stmts, mut var_assign_types)
	}
	if ret_type.tag != .t_unknown && ret_type.tag != .t_void {
		t.func_return_types[func_name] = ret_type
	}
	if param_types.len > 0 {
		t.func_param_types[func_name] = param_types.clone()
	}
	if local_var_types.len > 0 {
		t.func_var_types[func_name] = local_var_types.clone()
	}
}

// infer_expr_types_for_func 对函数体跑类型推导，结果写入 var_assign_types
fn (mut t Transpiler) infer_expr_types_for_func(stmts []ast.AstNode, mut var_assign_types map[string][]TypeTag) {
	for stmt in stmts {
		t.infer_expr_types_for_func_stmt(stmt, mut var_assign_types)
	}
}

fn (mut t Transpiler) infer_expr_types_for_func_stmt(node ast.AstNode, mut var_assign_types map[string][]TypeTag) {
	match node.node_type {
		ast.node_stmt_expression {
			if expr := node.expr {
				t.infer_expr_types(*expr, mut var_assign_types)
			}
		}
		ast.node_stmt_return {
			if expr := node.expr {
				t.infer_expr_types(*expr, mut var_assign_types)
			}
		}
		ast.node_stmt_if {
			if cond := node.cond { t.infer_expr_types(*cond, mut var_assign_types) }
			t.infer_expr_types_for_func(node.stmts, mut var_assign_types)
			for elseif in node.elseifs {
				if elseif_cond := elseif.cond { t.infer_expr_types(*elseif_cond, mut var_assign_types) }
				t.infer_expr_types_for_func(elseif.stmts, mut var_assign_types)
			}
			if el := node.@else {
				t.infer_expr_types_for_func(el.stmts, mut var_assign_types)
			}
		}
		ast.node_stmt_while, ast.node_stmt_do {
			if cond := node.cond { t.infer_expr_types(*cond, mut var_assign_types) }
			t.infer_expr_types_for_func(node.stmts, mut var_assign_types)
		}
		ast.node_stmt_for {
			for init in node.init { t.infer_expr_types(init, mut var_assign_types) }
			for cond in node.conds { t.infer_expr_types(cond, mut var_assign_types) }
			for loop_expr in node.loop { t.infer_expr_types(loop_expr, mut var_assign_types) }
			t.infer_expr_types_for_func(node.stmts, mut var_assign_types)
		}
		ast.node_stmt_foreach {
			if expr := node.expr { t.infer_expr_types(*expr, mut var_assign_types) }
			t.infer_expr_types_for_func(node.stmts, mut var_assign_types)
		}
		ast.node_stmt_echo {
			for expr in node.exprs {
				t.infer_expr_types(expr, mut var_assign_types)
			}
		}
		else {
			if expr := node.expr { t.infer_expr_types(*expr, mut var_assign_types) }
			for stmt in node.stmts {
				t.infer_expr_types_for_func_stmt(stmt, mut var_assign_types)
			}
		}
	}
}

// infer_func_return_type 推断函数的返回值类型
fn (mut t Transpiler) infer_func_return_type(stmts []ast.AstNode, mut var_assign_types map[string][]TypeTag) VarType {
	mut return_tags := []TypeTag{}
	t.scan_func_return_tags(stmts, mut var_assign_types, mut return_tags)
	if return_tags.len == 0 {
		return VarType{ tag: .t_void }
	}
	first := return_tags[0]
	mut all_same := true
	for tag in return_tags {
		if tag != first {
			all_same = false
			break
		}
	}
	if all_same && first in [.t_int, .t_float, .t_bool, .t_string] {
		return VarType{ tag: first }
	}
	return VarType{ tag: .t_unknown }
}

fn (mut t Transpiler) scan_func_return_tags(stmts []ast.AstNode, mut var_assign_types map[string][]TypeTag, mut return_tags []TypeTag) {
	for stmt in stmts {
		match stmt.node_type {
			ast.node_stmt_return {
				if expr := stmt.expr {
					tag := t.infer_expr_types(*expr, mut var_assign_types)
					return_tags << tag
				}
			}
			else {
				t.scan_func_return_tags(stmt.stmts, mut var_assign_types, mut return_tags)
				for elseif in stmt.elseifs {
					t.scan_func_return_tags(elseif.stmts, mut var_assign_types, mut return_tags)
				}
				if el := stmt.@else {
					t.scan_func_return_tags(el.stmts, mut var_assign_types, mut return_tags)
				}
			}
		}
	}
}

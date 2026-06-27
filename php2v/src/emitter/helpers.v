module emitter

import ast

// ============================================================
// 公共辅助函数：消除 emit_expr.v / emit_stmt.v / emit_class.v 中的重复代码
// ============================================================

// ---- 字符串转义 ----

// escape_single_quoted 将原始字符串转义为 V 单引号字符串内容
// 替代原先分散在 8 处的重复 .replace 链
pub fn escape_single_quoted(s string) string {
	return s.replace('\\', '\\\\').replace('\'', '\\\'').replace('\n', '\\n').replace('\r', '\\r').replace('\t', '\\t')
}

// escape_double_quoted 将原始字符串转义为 V 双引号字符串内容（额外处理 $）
pub fn escape_double_quoted(s string) string {
	return s.replace('\\', '\\\\').replace('"', '\\"').replace('\n', '\\n').replace('\r', '\\r').replace('\t', '\\t').replace('\$', '\\$')
}

// ---- 装箱 / 拆箱 ----

// box_expr 将原生 V 表达式包装为 rt.PhpVal
pub fn box_expr(code string, typ VarType) string {
	if typ.class_name.len > 0 || typ.tag == .t_object {
		if code.starts_with('rt.new_object') || code.starts_with('rt.new_null') {
			return code
		}
		cls := if typ.class_name.len > 0 { typ.class_name } else { 'WP_Error' }
		return "rt.new_object('${cls}', []string{}, ${code})"
	}
	match typ.tag {
		.t_int { return 'rt.new_int(${code})' }
		.t_float { return 'rt.new_float(${code})' }
		.t_string { return 'rt.new_string(${code})' }
		.t_bool { return 'rt.new_bool(${code})' }
		else { return code }
	}
}

// unbox_expr 将 rt.PhpVal 表达式转换为原生 V 类型
pub fn unbox_expr(code string, typ VarType) string {
	match typ.tag {
		.t_int { return '(${code}).to_i64()' }
		.t_float { return '(${code}).to_f64()' }
		.t_string { return '(${code}).str()' }
		.t_bool { return '(${code}).to_bool()' }
		else { return code }
	}
}

// ---- 表达式上下文 ----

pub enum ExprCtx {
	boxed  // 需要 PhpVal 包装（默认）
	native // 需要 V 原生类型
}

// ---- 参数传递 ----

// dup_if_needed 对 PhpVal 变量追加 .dup()，避免别名共享
// 非变量表达式直接返回原代码
pub fn (t Transpiler) dup_if_needed(code string, arg_node ast.AstNode) string {
	if arg_node.node_type == ast.node_expr_variable {
		var_name := arg_node.name
		typ := t.inferred_types[var_name] or { VarType{ tag: .t_unknown } }
		if typ.tag == .t_object || typ.class_name.len > 0 {
			return code
		}
		if t.native_params[var_name] || t.native_vars[var_name] || var_name.ends_with('_mutated') {
			return code
		}
		return '${code}.dup()'
	}
	return code
}

// CallArgResult 统一参数编译结果
pub struct CallArgResult {
pub:
	code string   // 编译后的参数表达式
	typ  VarType  // 参数的源类型
}

// compile_expr 统一表达式编译入口
// 根据 ExprCtx 决定生成 PhpVal 包装代码还是 V 原生代码
// 当请求 .native 但节点不支持原生输出时，自动降级为 .boxed + 拆箱
pub fn (mut t Transpiler) compile_expr(node ast.AstNode, ctx ExprCtx) string {
	match ctx {
		.boxed {
			return t.visit_expr(node)
		}
		.native {
			return t.visit_expr_native(node)
		}
	}
}

// compile_arg 统一编译单个调用参数（4-way 矩阵）
// 根据源类型和目标类型决定装箱/拆箱策略
pub fn (mut t Transpiler) compile_arg(arg_node ast.AstNode, target_type VarType) CallArgResult {
	arg_type := t.get_expr_type(arg_node)
	target_is_native := target_type.is_scalar() || target_type.class_name.len > 0
	arg_is_native := arg_type.is_scalar() || arg_type.class_name.len > 0
	
	if target_is_native && arg_is_native {
		// 目标是原生，源也是原生 → 直接传递
		return CallArgResult{ code: t.compile_expr(arg_node, .native), typ: arg_type }
	} else if target_is_native && !arg_is_native {
		// 目标是原生，源是包装 → 拆箱
		raw := t.compile_expr(arg_node, .boxed)
		return CallArgResult{ code: unbox_expr(raw, target_type), typ: arg_type }
	} else if !target_is_native && arg_is_native {
		// 目标是包装，源是原生 → 装箱
		native_val := t.compile_expr(arg_node, .native)
		return CallArgResult{ code: box_expr(native_val, arg_type), typ: arg_type }
	} else {
		// 目标是包装，源是包装 → 直接传递，变量需 .dup()
		code := t.compile_expr(arg_node, .boxed)
		return CallArgResult{ code: t.dup_if_needed(code, arg_node), typ: arg_type }
	}
}

// compile_arg_simple 编译 PhpVal 参数（无类型推导，变量需 .dup()）
// 用于 funccall、call_method fallback 等不需要 4-way 矩阵的场景
pub fn (mut t Transpiler) compile_arg_simple(arg_node ast.AstNode) string {
	code := t.compile_expr(arg_node, .boxed)
	return t.dup_if_needed(code, arg_node)
}

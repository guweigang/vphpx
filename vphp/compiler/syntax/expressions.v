module syntax

import v.flat

fn (d &Decoder) statements(ids []flat.NodeId) []Stmt {
	mut stmts := []Stmt{cap: ids.len}
	for id in ids {
		stmts << d.stmt(id)
	}
	return stmts
}

fn (d &Decoder) stmt(id flat.NodeId) Stmt {
	node := d.tree.node(id)
	return match node.kind {
		.return_stmt { Stmt(Return{d.tree.children_of(node).map(d.expr(it))}) }
		.assign, .decl_assign {
			if node.children_count == 2 {
				Stmt(AssignStmt{[d.expr(d.tree.child(node, 0))], [d.expr(d.tree.child(node, 1))]})
			} else {
				Stmt(Unknown{})
			}
		}
		.block { Stmt(Block{d.statements(d.tree.children_of(node))}) }
		.expr_stmt { Stmt(ExprStmt{d.expr(d.tree.child(node, 0))}) }
		else { Stmt(ExprStmt{d.expr(id)}) }
	}
}

fn (d &Decoder) expr(id flat.NodeId) Expr {
	n := d.tree.node(id)
	return match n.kind {
		.string_literal { Expr(StringLiteral{n.value}) }
		.int_literal { Expr(IntegerLiteral{n.value}) }
		.float_literal { Expr(FloatLiteral{n.value}) }
		.bool_literal { Expr(BoolLiteral{n.value == 'true'}) }
		.ident { Expr(Ident{n.value}) }
		.none_expr { Expr(Ident{'none'}) }
		.selector { Expr(SelectorExpr{boxed(d.expr(d.tree.child(n, 0))), n.value}) }
		.paren { Expr(ParExpr{boxed(d.expr(d.tree.child(n, 0)))}) }
		.cast_expr, .as_expr { Expr(CastExpr{boxed(d.expr(d.tree.child(n, 0)))}) }
		.prefix {
			op := match n.op {
				.minus { PrefixOp.minus }
				.amp { PrefixOp.amp }
				else { PrefixOp.other }
			}
			Expr(PrefixExpr{op, boxed(d.expr(d.tree.child(n, 0)))})
		}
		.struct_init, .assoc { Expr(StructInit{n.value_text(), d.value_fields(n)}) }
		.map_init { Expr(d.map_init(n)) }
		.array_literal { Expr(ArrayLiteral{d.tree.children_of(n).map(d.expr(it))}) }
		.array_init {
			if n.children_count == 0 && n.typ_text().starts_with('[]') {
				Expr(ArrayLiteral{})
			} else {
				Expr(Unknown{})
			}
		}
		.if_expr { Expr(d.if_expr(id)) }
		.match_stmt { Expr(d.match_expr(n)) }
		.call { Expr(d.call_expr(n, Block{})) }
		.or_expr {
			target := d.tree.child_node(n, 0)
			if target.kind == .call {
				fallback := d.tree.child_node(n, 1)
				Expr(d.call_expr(target, Block{d.statements(d.tree.children_of(fallback))}))
			} else {
				Expr(Unknown{})
			}
		}
		.block {
			if n.value == 'unsafe' && n.children_count == 1 {
				tail := d.tree.child(n, 0)
				Expr(UnsafeExpr{boxed(d.expr(tail))})
			} else {
				Expr(Unknown{})
			}
		}
		.expr_stmt { d.expr(d.tree.child(n, 0)) }
		else { Expr(Unknown{}) }
	}
}

fn (d &Decoder) call_expr(n &flat.Node, fallback Block) CallExpr {
	callee := d.tree.child_node(n, 0)
	mut left := Expr(Unknown{})
	if callee.kind == .selector {
		left = d.expr(d.tree.child(callee, 0))
	}
	mut args := []CallArg{}
	for i in 1 .. n.children_count {
		args << CallArg{d.expr(d.tree.child(n, i))}
	}
	return CallExpr{callee.value, boxed(left), args, fallback}
}

fn (d &Decoder) map_init(n &flat.Node) MapInit {
	mut keys := []Expr{}
	mut vals := []Expr{}
	for i := 0; i + 1 < n.children_count; i += 2 {
		keys << d.expr(d.tree.child(n, i))
		vals << d.expr(d.tree.child(n, i + 1))
	}
	return MapInit{keys, vals}
}

fn (d &Decoder) if_expr(id flat.NodeId) IfExpr {
	mut branches := []Branch{}
	mut next := id
	for d.tree.node(next).kind == .if_expr {
		node := d.tree.node(next)
		cond := d.tree.child(node, 0)
		body := d.tree.child_node(node, 1)
		branches << Branch{d.condition(cond), d.statements(d.tree.children_of(body))}
		next = d.tree.child(node, 2)
	}
	node := d.tree.node(next)
	if node.kind == .block {
		branches << Branch{Unknown{}, d.statements(d.tree.children_of(node))}
		return IfExpr{branches, true}
	}
	return IfExpr{branches, false}
}

fn (d &Decoder) condition(id flat.NodeId) Expr {
	n := d.tree.node(id)
	if n.kind != .decl_assign || n.children_count < 2 {
		return d.expr(id)
	}
	mut vars := []Ident{}
	for i in 0 .. n.children_count {
		if i != 1 {
			vars << Ident{d.tree.child_node(n, i).value}
		}
	}
	return IfGuardExpr{vars, boxed(d.expr(d.tree.child(n, 1)))}
}

fn (d &Decoder) match_expr(n &flat.Node) MatchExpr {
	mut branches := []Branch{}
	for child in d.tree.children_of(n) {
		branch := d.tree.node(child)
		if branch.kind == .match_branch {
			ids := d.tree.children_of(branch)
			first := branch.value.int()
			if first >= 0 && first <= ids.len {
				branches << Branch{Unknown{}, d.statements(ids[first..])}
			}
		}
	}
	return MatchExpr{branches}
}

fn boxed(expr Expr) &Expr {
	value := expr
	return &value
}

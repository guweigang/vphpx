module ast

pub struct AstNode {
pub mut:
	node_type string    @[json: 'nodeType']
	exprs     []AstNode @[json: 'exprs']
	expr      ?&AstNode @[json: 'expr']
	var       ?&AstNode @[json: 'var']
	left      ?&AstNode @[json: 'left']
	right     ?&AstNode @[json: 'right']
	cond      ?&AstNode @[json: 'cond']
	stmts     []AstNode @[json: 'stmts']
	elseifs   []AstNode @[json: 'elseifs']
	@else     ?&AstNode @[json: 'else']
	@if       ?&AstNode @[json: 'if']
	catches   []AstNode @[json: 'catches']
	finally   ?&AstNode @[json: 'finally']
	types     []string  @[json: 'types']
	value     string    @[json: 'value']
	name      string    @[json: 'name']
	params    []AstNode @[json: 'params']
	args      []AstNode @[json: 'args']
	by_ref    string    @[json: 'byRef']
	items     []AstNode @[json: 'items']
	key       ?&AstNode @[json: 'key']
	dim       ?&AstNode @[json: 'dim']
	key_var   ?&AstNode @[json: 'keyVar']
	value_var ?&AstNode @[json: 'valueVar']
	init      []AstNode @[json: 'init']
	conds     []AstNode @[json: 'conds']
	cases     []AstNode @[json: 'cases']
	arms      []AstNode @[json: 'arms']
	body      ?&AstNode @[json: 'body']
	loop      []AstNode @[json: 'loop']
	default_val  ?&AstNode @[json: 'default']
	variadic  string      @[json: 'variadic']


	props     []AstNode @[json: 'props']
	uses      []AstNode @[json: 'uses']
	incl_type   string   @[json: 'type']
	return_type string   @[json: 'returnType']
	class_name  string   @[json: 'class']
	class_expr  ?&AstNode @[json: 'class_expr']
	name_expr   ?&AstNode @[json: 'name_expr']
	extends    string   @[json: 'extends']
	implements []string @[json: 'implements']
	traits     []string @[json: 'traits']

	line       int      @[json: 'line']
	consts     []ConstItem @[json: 'consts']
	vars       []AstNode @[json: 'vars']
	parts      []AstNode @[json: 'parts']
	alias      string    @[json: 'alias']
	flags      string    @[json: 'flags']
}

pub struct ConstItem {
pub:
	node_type string   @[json: 'nodeType']
	name      string   @[json: 'name']
	value     AstNode  @[json: 'value']
}

fn clone_ptr(p ?&AstNode) ?&AstNode {
	if val := p {
		if voidptr(val) == 0 {
			return none
		}
		return val.clone()
	}
	return none
}

pub fn (n &AstNode) clone() &AstNode {
	mut exprs := []AstNode{}
	for e in n.exprs { exprs << *e.clone() }
	mut stmts := []AstNode{}
	for s in n.stmts { stmts << *s.clone() }
	mut elseifs := []AstNode{}
	for ei in n.elseifs { elseifs << *ei.clone() }
	mut catches := []AstNode{}
	for c in n.catches { catches << *c.clone() }
	mut params := []AstNode{}
	for p in n.params { params << *p.clone() }
	mut args := []AstNode{}
	for a in n.args { args << *a.clone() }
	mut items := []AstNode{}
	for it in n.items { items << *it.clone() }
	mut init := []AstNode{}
	for i in n.init { init << *i.clone() }
	mut conds := []AstNode{}
	for cd in n.conds { conds << *cd.clone() }
	mut cases := []AstNode{}
	for cs in n.cases { cases << *cs.clone() }
	mut arms := []AstNode{}
	for am in n.arms { arms << *am.clone() }
	mut loop_nodes := []AstNode{}
	for l in n.loop { loop_nodes << *l.clone() }
	mut props := []AstNode{}
	for p in n.props { props << *p.clone() }
	mut uses := []AstNode{}
	for u in n.uses { uses << *u.clone() }
	mut consts := []ConstItem{}
	for c in n.consts { consts << ConstItem{ node_type: c.node_type.clone(), name: c.name.clone(), value: *c.value.clone() } }
	mut vars := []AstNode{}
	for v in n.vars { vars << *v.clone() }
	mut parts := []AstNode{}
	for p in n.parts { parts << *p.clone() }

	return &AstNode{
		node_type: n.node_type.clone()
		exprs: exprs
		expr: clone_ptr(n.expr)
		var: clone_ptr(n.var)
		left: clone_ptr(n.left)
		right: clone_ptr(n.right)
		cond: clone_ptr(n.cond)
		stmts: stmts
		elseifs: elseifs
		@else: clone_ptr(n.@else)
		@if: clone_ptr(n.@if)
		catches: catches
		finally: clone_ptr(n.finally)
		types: n.types.clone()
		value: n.value.clone()
		name: n.name.clone()
		params: params
		args: args
		by_ref: n.by_ref.clone()
		items: items
		key: clone_ptr(n.key)
		dim: clone_ptr(n.dim)
		key_var: clone_ptr(n.key_var)
		value_var: clone_ptr(n.value_var)
		init: init
		conds: conds
		cases: cases
		arms: arms
		body: clone_ptr(n.body)
		loop: loop_nodes
		default_val: clone_ptr(n.default_val)
		variadic: n.variadic.clone()
		props: props
		uses: uses
		incl_type: n.incl_type.clone()
		return_type: n.return_type.clone()
		class_name: n.class_name.clone()
		class_expr: clone_ptr(n.class_expr)
		name_expr: clone_ptr(n.name_expr)
		extends: n.extends.clone()
		implements: n.implements.clone()
		traits: n.traits.clone()
		line: n.line
		consts: consts
		vars: vars
		parts: parts
		alias: n.alias.clone()
		flags: n.flags.clone()
	}
}

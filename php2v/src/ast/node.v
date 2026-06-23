module ast

pub struct AstNode {
pub:
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
	loop      []AstNode @[json: 'loop']
	props     []AstNode @[json: 'props']
	uses      []AstNode @[json: 'uses']
	incl_type string    @[json: 'type']
	class_name string   @[json: 'class']
	line       int      @[json: 'line']
	consts     []ConstItem @[json: 'consts']
}

pub struct ConstItem {
pub:
	node_type string   @[json: 'nodeType']
	name      string   @[json: 'name']
	value     AstNode  @[json: 'value']
}

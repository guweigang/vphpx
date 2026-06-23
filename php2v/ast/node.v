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
}

module main

import vphp

enum TemplateNodeKind {
	text
	value
	expression
	raw_value
	include_tpl
	asset
	slot
	call_helper
	call_helper_raw
	if_block
	for_block
	fill_block
}

struct TemplateNode {
	kind          TemplateNodeKind
	name          string
	value         string
	include_args  []TemplateIncludeArg
	has_include_args bool
	children      []TemplateNode
	else_children []TemplateNode
	arg_asts      []TemplateExprNode
	has_arg_asts  bool
	expr_ast      TemplateExprNode
	has_expr_ast  bool
	cond_ast      TemplateConditionNode
	has_cond_ast  bool
	line          int
	col           int
}

struct TemplateProgram {
	nodes []TemplateNode
}

enum TemplateTokenKind {
	text
	tag
}

struct TemplateToken {
	kind  TemplateTokenKind
	value string
	line  int
	col   int
}

struct TemplateParser {
	tokens []TemplateToken
mut:
	pos int
}

enum TemplateExprValueKind {
	scalar
	list
	map
	object
}

enum TemplateExprNodeKind {
	path
	literal
	call
	cast
	map_path
	method_call
}

struct TemplateExprNode {
	kind          TemplateExprNodeKind
	name          string
	value         string
	explicit_type string
	args          []TemplateExprNode
	raw           string
	line          int
	col           int
}

struct TemplateExprSegment {
	text string
	col  int
}

struct TemplateIncludeArg {
	name string
	expr TemplateExprNode
}

enum TemplateConditionNodeKind {
	expr
	not
	and
	or
	compare
}

struct TemplateConditionNode {
	kind     TemplateConditionNodeKind
	op       string
	expr     TemplateExprNode
	children []TemplateConditionNode
	left     TemplateExprNode
	right    TemplateExprNode
}

struct TemplateExprValue {
	kind          TemplateExprValueKind
	scalar        string
	list          []string
	explicit_type string
	map_path      string
	object        vphp.RequestOwnedZVal = vphp.RequestOwnedZVal.new_null()
}


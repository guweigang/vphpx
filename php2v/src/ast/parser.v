module ast

import json2

// parse_ast_json 解析 JSON 格式的 AST 并返回节点数组
pub fn parse_ast_json(json_str string) ![]AstNode {
	return json2.decode[[]AstNode](json_str)!
}

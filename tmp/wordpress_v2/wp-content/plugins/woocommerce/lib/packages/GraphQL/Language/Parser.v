import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	rt.PhpObjectBase
pub mut:
		lexer rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parse(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	return rt.call_method(create_automattic_woocommerce_vendor_graphql_language_self(var_source.clone(), var_options), 'parseDocument', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parsevalue(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	mut var_parser := create_automattic_woocommerce_vendor_graphql_language_parser(var_source.clone(), var_options)
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof()).str())
	mut var_value := var_parser.parsevalueliteral(false)
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof()).str())
	return var_value.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parsetype(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	mut var_parser := create_automattic_woocommerce_vendor_graphql_language_parser(var_source.clone(), var_options)
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof()).str())
	mut var_type := var_parser.parsetypereference()
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof()).str())
	return var_type.clone()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.magic_callstatic(name string, mut var_arguments Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	mut name_mutated := name
	mut var_parser := create_automattic_woocommerce_vendor_graphql_language_parser(var_arguments, rt.new_null())
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof()).str())
	mut switch_val_1 := rt.new_string(name_mutated)
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('arguments'))) {
	mut var_parsed := var_parser.parsearguments(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('valueLiteral'))) {
	var_parsed = var_parser.parsevalueliteral(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('array'))) {
	var_parsed = var_parser.parsearray(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('object'))) {
	var_parsed = var_parser.parseobject(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('objectField'))) {
	var_parsed = var_parser.parseobjectfield(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('directives'))) {
	var_parsed = var_parser.parsedirectives(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('directive'))) {
	var_parsed = var_parser.parsedirective(false)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('constArguments'))) {
	var_parsed = var_parser.parsearguments(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('constValueLiteral'))) {
	var_parsed = var_parser.parsevalueliteral(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('constArray'))) {
	var_parsed = var_parser.parsearray(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('constObject'))) {
	var_parsed = var_parser.parseobject(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('constObjectField'))) {
	var_parsed = var_parser.parseobjectfield(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('constDirectives'))) {
	var_parsed = var_parser.parsedirectives(true)
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('constDirective'))) {
	var_parsed = var_parser.parsedirective(true)
	} else {
	var_parsed = rt.call_method(var_parser, 'parse' + name_mutated, []rt.PhpVal{})
	}
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof()).str())
	return var_parsed.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) construct(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) {
	mut var_sourceObj := if rt.is_true(rt.new_bool(rt.instance_of(var_source, 'Automattic_WooCommerce_Vendor_GraphQL_Language_Source'))) { var_source } else { create_automattic_woocommerce_vendor_graphql_language_source(var_source.clone()) }
	this.lexer = create_automattic_woocommerce_vendor_graphql_language_lexer(var_sourceObj.clone(), var_options)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) loc(mut var_startToken Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(if !(rt.get_property(this.lexer, 'options').array_get(rt.new_string('noLocation'))).is_null() { rt.get_property(this.lexer, 'options').array_get(rt.new_string('noLocation')) } else { rt.new_bool(false) })))) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_location(var_startToken, rt.get_property(this.lexer, 'lastToken'), rt.get_property(this.lexer, 'source'))
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) peek(kind string) bool {
	return (rt.identical(rt.get_property(rt.get_property(this.lexer, 'token'), 'kind'), rt.new_string(kind))).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) skip(kind string) bool {
	mut var_match := rt.identical(rt.get_property(rt.get_property(this.lexer, 'token'), 'kind'), rt.new_string(kind))
	if rt.is_true(var_match) {
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
	}
	return (var_match).to_bool()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) expect(kind string) rt.PhpVal {
	mut var_token := rt.get_property(this.lexer, 'token')
	if rt.is_true(rt.identical(rt.get_property(var_token, 'kind'), rt.new_string(kind))) {
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
		return var_token.clone()
	}
	rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError', []string{}, create_automattic_woocommerce_vendor_graphql_error_syntaxerror(rt.get_property(this.lexer, 'source'), rt.get_property(var_token, 'start'), rt.concat(rt.concat(rt.concat(rt.new_string('Expected '), rt.new_string(kind)), rt.new_string(', found ')), rt.call_method(var_token, 'getDescription', []rt.PhpVal{})))))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) expectkeyword(value string) {
	mut value_mutated := value
	mut var_token := rt.get_property(this.lexer, 'token')
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_token, 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name())))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(var_token, 'value'), rt.new_string(value_mutated))))) {
		rt.throw_exception(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError', []string{}, create_automattic_woocommerce_vendor_graphql_error_syntaxerror(rt.get_property(this.lexer, 'source'), rt.get_property(var_token, 'start'), rt.concat(rt.concat(rt.concat(rt.new_string('Expected "'), rt.new_string(value_mutated)), rt.new_string('", found ')), rt.call_method(var_token, 'getDescription', []rt.PhpVal{})))))
	}
	rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) expectoptionalkeyword(value string) bool {
	mut value_mutated := value
	mut var_token := rt.get_property(this.lexer, 'token')
	if rt.is_true(rt.identical(rt.get_property(var_token, 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name())) && rt.is_true(rt.identical(rt.get_property(var_token, 'value'), rt.new_string(value_mutated))) {
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
		return true
	}
	return false
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) unexpected(mut var_atToken Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token) rt.PhpVal {
	mut var_token := if !(var_atToken).is_null() { var_atToken } else { rt.get_property(this.lexer, 'token') }
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError', []string{}, create_automattic_woocommerce_vendor_graphql_error_syntaxerror(rt.get_property(this.lexer, 'source'), rt.get_property(var_token, 'start'), 'Unexpected ' + (rt.call_method(var_token, 'getDescription', []rt.PhpVal{})).str()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) any(openKind string, mut var_parseFn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable, closeKind string) rt.PhpVal {
	mut var_parseFn_mutated := var_parseFn
	this.expect(openKind)
	mut var_nodes := rt.new_array()
	for !(this.skip(closeKind)) {
		var_nodes.array_push(rt.call_callable(var_parseFn_mutated, [rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_Parser', []string{}, &this)]))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_nodes.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) many(openKind string, mut var_parseFn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable, closeKind string) rt.PhpVal {
	mut var_parseFn_mutated := var_parseFn
	this.expect(openKind)
	mut var_nodes := rt.create_array([rt.ArrayItem{ key: none, val: rt.call_callable(var_parseFn_mutated, [rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_Parser', []string{}, &this)]) }])
	for !(this.skip(closeKind)) {
		var_nodes.array_push(rt.call_callable(var_parseFn_mutated, [rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_Parser', []string{}, &this)]))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_nodes.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsename() rt.PhpVal {
	mut var_token := this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name()).str())
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_namenode(rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_token, 'value') }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedocument() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parsedefinition()
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_documentnode(rt.create_array([rt.ArrayItem{ key: 'definitions', val: this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_1_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof()).str()) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedefinition() rt.PhpVal {
	if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name()).str()) {
		mut switch_val_2 := rt.get_property(rt.get_property(this.lexer, 'token'), 'value')
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('query'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('mutation'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('subscription'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('fragment'))) {
			return this.parseexecutabledefinition()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('schema'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('scalar'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('type'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('interface'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('union'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('enum'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('input'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('directive'))) {
			return this.parsetypesystemdefinition()
		} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('extend'))) {
			return this.parsetypesystemextension()
		}
	} else if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) {
		return this.parseexecutabledefinition()
	} else if this.peekdescription() {
		return this.parsetypesystemdefinition()
	}
	rt.throw_exception(this.unexpected(rt.new_null()))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseexecutabledefinition() rt.PhpVal {
	if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name()).str()) {
		mut switch_val_3 := rt.get_property(rt.get_property(this.lexer, 'token'), 'value')
		if rt.is_true(rt.equal(switch_val_3, rt.new_string('query'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('mutation'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('subscription'))) {
			return this.parseoperationdefinition()
		} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('fragment'))) {
			return this.parsefragmentdefinition()
		}
	} else if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) {
		return this.parseoperationdefinition()
	}
	rt.throw_exception(this.unexpected(rt.new_null()))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseoperationdefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_operationdefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: rt.new_null() }, rt.ArrayItem{ key: 'operation', val: 'query' }, rt.ArrayItem{ key: 'variableDefinitions', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }, rt.ArrayItem{ key: 'directives', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }, rt.ArrayItem{ key: 'selectionSet', val: this.parseselectionset() }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
	}
	mut var_operation := rt.new_string(this.parseoperationtype())
	mut var_name := rt.new_null()
	if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name()).str()) {
	var_name = this.parsename()
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_operationdefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'operation', val: var_operation }, rt.ArrayItem{ key: 'variableDefinitions', val: this.parsevariabledefinitions() }, rt.ArrayItem{ key: 'directives', val: this.parsedirectives(false) }, rt.ArrayItem{ key: 'selectionSet', val: this.parseselectionset() }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseoperationtype() string {
	mut var_operationToken := this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name()).str())
	mut switch_val_4 := rt.get_property(var_operationToken, 'value')
	if rt.is_true(rt.equal(switch_val_4, rt.new_string('query'))) {
		return 'query'
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('mutation'))) {
		return 'mutation'
	} else if rt.is_true(rt.equal(switch_val_4, rt.new_string('subscription'))) {
		return 'subscription'
	}
	rt.throw_exception(this.unexpected(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token](var_operationToken)))
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariabledefinitions() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parsevariabledefinition()
		}
	return if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l()).str()) { this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_2_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_r()).str()) } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariabledefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_var := this.parsevariable()
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str())
	mut var_type := this.parsetypereference()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_variabledefinitionnode(rt.create_array([rt.ArrayItem{ key: 'variable', val: var_var }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'defaultValue', val: if this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.equals()).str()) { this.parsevalueliteral(true) } else { rt.new_null() } }, rt.ArrayItem{ key: 'directives', val: this.parsedirectives(true) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariable() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.dollar()).str())
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_variablenode(rt.create_array([rt.ArrayItem{ key: 'name', val: this.parsename() }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseselectionset() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseselection()
		}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_selectionsetnode(rt.create_array([rt.ArrayItem{ key: 'selections', val: this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_3_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r()).str()) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseselection() rt.PhpVal {
	return if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.spread()).str()) { this.parsefragment() } else { this.parsefield() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefield() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_nameOrAlias := this.parsename()
	if this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str()) {
	mut var_alias := var_nameOrAlias.clone()
	mut var_name := this.parsename()
	} else {
	var_alias = rt.new_null()
	var_name = var_nameOrAlias.clone()
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_fieldnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'alias', val: var_alias }, rt.ArrayItem{ key: 'arguments', val: this.parsearguments(false) }, rt.ArrayItem{ key: 'directives', val: this.parsedirectives(false) }, rt.ArrayItem{ key: 'selectionSet', val: if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) { this.parseselectionset() } else { rt.new_null() } }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsearguments(isConst bool) rt.PhpVal {
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseconstargument()
		}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseargument()
		}
	mut var_parseFn := if var_isConst { rt.new_closure(closure_4_fn) } else { rt.new_closure(closure_5_fn) }
	return if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l()).str()) { this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](var_parseFn), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_r()).str()) } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseargument() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_name := this.parsename()
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str())
	mut var_value := this.parsevalueliteral(false)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_argumentnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'value', val: var_value }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseconstargument() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_name := this.parsename()
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str())
	mut var_value := this.parseconstvalue()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_argumentnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'value', val: var_value }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefragment() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.spread()).str())
	mut var_hasTypeCondition := rt.new_bool(this.expectoptionalkeyword('on'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_hasTypeCondition)))) && this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name()).str()) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_fragmentspreadnode(rt.create_array([rt.ArrayItem{ key: 'name', val: this.parsefragmentname() }, rt.ArrayItem{ key: 'directives', val: this.parsedirectives(false) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_inlinefragmentnode(rt.create_array([rt.ArrayItem{ key: 'typeCondition', val: if rt.is_true(var_hasTypeCondition) { this.parsenamedtype() } else { rt.new_null() } }, rt.ArrayItem{ key: 'directives', val: this.parsedirectives(false) }, rt.ArrayItem{ key: 'selectionSet', val: this.parseselectionset() }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefragmentdefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('fragment')
	mut var_name := this.parsefragmentname()
	mut var_variableDefinitions := if rt.get_property(this.lexer, 'options').array_isset(rt.new_string('experimentalFragmentVariables')) { this.parsevariabledefinitions() } else { rt.new_null() }
	this.expectkeyword('on')
	mut var_typeCondition := this.parsenamedtype()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_fragmentdefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'variableDefinitions', val: var_variableDefinitions }, rt.ArrayItem{ key: 'typeCondition', val: var_typeCondition }, rt.ArrayItem{ key: 'directives', val: this.parsedirectives(false) }, rt.ArrayItem{ key: 'selectionSet', val: this.parseselectionset() }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefragmentname() rt.PhpVal {
	if rt.is_true(rt.identical(rt.get_property(rt.get_property(this.lexer, 'token'), 'value'), rt.new_string('on'))) {
		rt.throw_exception(this.unexpected(rt.new_null()))
	}
	return this.parsename()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevalueliteral(isConst bool) rt.PhpVal {
	mut var_token := rt.get_property(this.lexer, 'token')
	mut switch_val_5 := rt.get_property(var_token, 'kind')
	if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_l())) {
		return this.parsearray(isConst)
	} else if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l())) {
		return this.parseobject(isConst)
	} else if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.int())) {
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_token, 'value') }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token)) }])))
	} else if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.float())) {
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_token, 'value') }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token)) }])))
	} else if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.string())) || rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.block_string())) {
		return this.parsestringliteral()
	} else if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name())) {
		if rt.is_true(rt.identical(rt.get_property(var_token, 'value'), rt.new_string('true'))) || rt.is_true(rt.identical(rt.get_property(var_token, 'value'), rt.new_string('false'))) {
			rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
			return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: rt.identical(rt.get_property(var_token, 'value'), rt.new_string('true')) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token)) }])))
		}
		if rt.is_true(rt.identical(rt.get_property(var_token, 'value'), rt.new_string('null'))) {
			rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
			return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode(rt.create_array([rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token)) }])))
		}
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_token, 'value') }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token)) }])))
	} else if rt.is_true(rt.equal(switch_val_5, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.dollar())) {
		if !(var_isConst) {
			return this.parsevariable()
		}
	}
	rt.throw_exception(this.unexpected(rt.new_null()))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsestringliteral() rt.PhpVal {
	mut var_token := rt.get_property(this.lexer, 'token')
	rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode(rt.create_array([rt.ArrayItem{ key: 'value', val: rt.get_property(var_token, 'value') }, rt.ArrayItem{ key: 'block', val: rt.identical(rt.get_property(var_token, 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.block_string()) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_token)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseconstvalue() rt.PhpVal {
	return this.parsevalueliteral(true)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariablevalue() rt.PhpVal {
	return this.parsevalueliteral(false)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsearray(isConst bool) rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseconstvalue()
		}
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parsevariablevalue()
		}
	mut var_parseFn := if var_isConst { rt.new_closure(closure_6_fn) } else { rt.new_closure(closure_7_fn) }
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode(rt.create_array([rt.ArrayItem{ key: 'values', val: this.any((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](var_parseFn), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_r()).str()) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobject(isConst bool) rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str())
	mut var_fields := rt.new_array()
	for !(this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r()).str())) {
		var_fields.array_push(this.parseobjectfield(isConst))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode(rt.create_array([rt.ArrayItem{ key: 'fields', val: create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_fields.clone()) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobjectfield(isConst bool) rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_name := this.parsename()
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str())
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'value', val: this.parsevalueliteral(isConst) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectives(isConst bool) rt.PhpVal {
	mut var_directives := rt.new_array()
	for this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.at()).str()) {
		var_directives.array_push(this.parsedirective(isConst))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_directives.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirective(isConst bool) rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.at()).str())
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_directivenode(rt.create_array([rt.ArrayItem{ key: 'name', val: this.parsename() }, rt.ArrayItem{ key: 'arguments', val: this.parsearguments(isConst) }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsetypereference() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	if this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_l()).str()) {
		mut var_type := this.parsetypereference()
		this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bracket_r()).str())
	var_type = create_automattic_woocommerce_vendor_graphql_language_ast_listtypenode(rt.create_array([rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }]))
	} else {
	var_type = this.parsenamedtype()
	}
	if this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.bang()).str()) {
		return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nonnulltypenode(rt.create_array([rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
	}
	return var_type.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsenamedtype() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_namedtypenode(rt.create_array([rt.ArrayItem{ key: 'name', val: this.parsename() }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsetypesystemdefinition() rt.PhpVal {
	mut var_keywordToken := if this.peekdescription() { rt.call_method(this.lexer, 'lookahead', []rt.PhpVal{}) } else { rt.get_property(this.lexer, 'token') }
	if rt.is_true(rt.identical(rt.get_property(var_keywordToken, 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name())) {
		mut switch_val_6 := rt.get_property(var_keywordToken, 'value')
		if rt.is_true(rt.equal(switch_val_6, rt.new_string('schema'))) {
			return this.parseschemadefinition()
		} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('scalar'))) {
			return this.parsescalartypedefinition()
		} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('type'))) {
			return this.parseobjecttypedefinition()
		} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('interface'))) {
			return this.parseinterfacetypedefinition()
		} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('union'))) {
			return this.parseuniontypedefinition()
		} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('enum'))) {
			return this.parseenumtypedefinition()
		} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('input'))) {
			return this.parseinputobjecttypedefinition()
		} else if rt.is_true(rt.equal(switch_val_6, rt.new_string('directive'))) {
			return this.parsedirectivedefinition()
		}
	}
	rt.throw_exception(this.unexpected(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token](var_keywordToken)))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) peekdescription() bool {
	return this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.string()).str()) || this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.block_string()).str())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedescription() rt.PhpVal {
	if this.peekdescription() {
		return this.parsestringliteral()
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseschemadefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('schema')
	mut var_directives := this.parsedirectives(true)
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseoperationtypedefinition()
		}
	mut var_operationTypes := this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_8_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r()).str())
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_schemadefinitionnode(rt.create_array([rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'operationTypes', val: var_operationTypes }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseoperationtypedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_operation := rt.new_string(this.parseoperationtype())
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str())
	mut var_type := this.parsenamedtype()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_operationtypedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'operation', val: var_operation }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsescalartypedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('scalar')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_scalartypedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobjecttypedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('type')
	mut var_name := this.parsename()
	mut var_interfaces := this.parseimplementsinterfaces()
	mut var_directives := this.parsedirectives(true)
	mut var_fields := this.parsefieldsdefinition()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_objecttypedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'interfaces', val: var_interfaces }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'fields', val: var_fields }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseimplementsinterfaces() rt.PhpVal {
	mut var_types := rt.new_array()
	if this.expectoptionalkeyword('implements') {
		this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.amp()).str())
		for {
			var_types.array_push(this.parsenamedtype())
			if !(this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.amp()).str()) || (rt.is_true(if !(rt.get_property(this.lexer, 'options').array_get(rt.new_string('allowLegacySDLImplementsInterfaces'))).is_null() { rt.get_property(this.lexer, 'options').array_get(rt.new_string('allowLegacySDLImplementsInterfaces')) } else { rt.new_bool(false) }) && this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name()).str()))) {
				break
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_types.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefieldsdefinition() rt.PhpVal {
	if rt.is_true(if !(rt.get_property(this.lexer, 'options').array_get(rt.new_string('allowLegacySDLEmptyFields'))).is_null() { rt.get_property(this.lexer, 'options').array_get(rt.new_string('allowLegacySDLEmptyFields')) } else { rt.new_bool(false) }) && this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) && rt.is_true(rt.identical(rt.get_property(rt.call_method(this.lexer, 'lookahead', []rt.PhpVal{}), 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r())) {
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
		rt.call_method(this.lexer, 'advance', []rt.PhpVal{})
	mut var_nodeList := create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array())
	} else {
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parsefielddefinition()
		}
	var_nodeList = if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) { this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_9_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r()).str()) } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }
	}
	return var_nodeList.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefielddefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	mut var_name := this.parsename()
	mut var_args := this.parseargumentsdefinition()
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str())
	mut var_type := this.parsetypereference()
	mut var_directives := this.parsedirectives(true)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_fielddefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'arguments', val: var_args }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseargumentsdefinition() rt.PhpVal {
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseinputvaluedefinition()
		}
	return if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l()).str()) { this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_10_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.paren_r()).str()) } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputvaluedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	mut var_name := this.parsename()
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.colon()).str())
	mut var_type := this.parsetypereference()
	mut var_defaultValue := rt.new_null()
	if this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.equals()).str()) {
	var_defaultValue = this.parseconstvalue()
	}
	mut var_directives := this.parsedirectives(true)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_inputvaluedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'type', val: var_type }, rt.ArrayItem{ key: 'defaultValue', val: var_defaultValue }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinterfacetypedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('interface')
	mut var_name := this.parsename()
	mut var_interfaces := this.parseimplementsinterfaces()
	mut var_directives := this.parsedirectives(true)
	mut var_fields := this.parsefieldsdefinition()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_interfacetypedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'interfaces', val: var_interfaces }, rt.ArrayItem{ key: 'fields', val: var_fields }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseuniontypedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('union')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	mut var_types := this.parseunionmembertypes()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_uniontypedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'types', val: var_types }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseunionmembertypes() rt.PhpVal {
	mut var_types := rt.new_array()
	if this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.equals()).str()) {
		this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.pipe()).str())
		for {
			var_types.array_push(this.parsenamedtype())
			if !(this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.pipe()).str())) {
				break
			}
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_types.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumtypedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('enum')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	mut var_values := this.parseenumvaluesdefinition()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_enumtypedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'values', val: var_values }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumvaluesdefinition() rt.PhpVal {
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseenumvaluedefinition()
		}
	return if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) { this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_11_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r()).str()) } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumvaluedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputobjecttypedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('input')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	mut var_fields := this.parseinputfieldsdefinition()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_inputobjecttypedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'fields', val: var_fields }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }, rt.ArrayItem{ key: 'description', val: var_description }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputfieldsdefinition() rt.PhpVal {
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseinputvaluedefinition()
		}
	return if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) { this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_12_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r()).str()) } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsetypesystemextension() rt.PhpVal {
	mut var_keywordToken := rt.call_method(this.lexer, 'lookahead', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.get_property(var_keywordToken, 'kind'), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.name())) {
		mut switch_val_7 := rt.get_property(var_keywordToken, 'value')
		if rt.is_true(rt.equal(switch_val_7, rt.new_string('schema'))) {
			return this.parseschematypeextension()
		} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('scalar'))) {
			return this.parsescalartypeextension()
		} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('type'))) {
			return this.parseobjecttypeextension()
		} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('interface'))) {
			return this.parseinterfacetypeextension()
		} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('union'))) {
			return this.parseuniontypeextension()
		} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('enum'))) {
			return this.parseenumtypeextension()
		} else if rt.is_true(rt.equal(switch_val_7, rt.new_string('input'))) {
			return this.parseinputobjecttypeextension()
		}
	}
	rt.throw_exception(this.unexpected(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token](var_keywordToken)))
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseschematypeextension() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('extend')
	this.expectkeyword('schema')
	mut var_directives := this.parsedirectives(true)
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		return this.parseoperationtypedefinition()
		}
	mut var_operationTypes := if this.peek((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str()) { this.many((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_l()).str(), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](rt.new_closure(closure_13_fn)), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.brace_r()).str()) } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }
	if var_directives.clone().array_count() == 0 && var_operationTypes.clone().array_count() == 0 {
		this.unexpected(rt.new_null())
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_schemaextensionnode(rt.create_array([rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'operationTypes', val: var_operationTypes }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsescalartypeextension() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('extend')
	this.expectkeyword('scalar')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	if var_directives.clone().array_count() == 0 {
		rt.throw_exception(this.unexpected(rt.new_null()))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_scalartypeextensionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobjecttypeextension() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('extend')
	this.expectkeyword('type')
	mut var_name := this.parsename()
	mut var_interfaces := this.parseimplementsinterfaces()
	mut var_directives := this.parsedirectives(true)
	mut var_fields := this.parsefieldsdefinition()
	if var_interfaces.clone().array_count() == 0 && var_directives.clone().array_count() == 0 && var_fields.clone().array_count() == 0 {
		rt.throw_exception(this.unexpected(rt.new_null()))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_objecttypeextensionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'interfaces', val: var_interfaces }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'fields', val: var_fields }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinterfacetypeextension() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('extend')
	this.expectkeyword('interface')
	mut var_name := this.parsename()
	mut var_interfaces := this.parseimplementsinterfaces()
	mut var_directives := this.parsedirectives(true)
	mut var_fields := this.parsefieldsdefinition()
	if var_interfaces.clone().array_count() == 0 && var_directives.clone().array_count() == 0 && var_fields.clone().array_count() == 0 {
		rt.throw_exception(this.unexpected(rt.new_null()))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_interfacetypeextensionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'interfaces', val: var_interfaces }, rt.ArrayItem{ key: 'fields', val: var_fields }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseuniontypeextension() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('extend')
	this.expectkeyword('union')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	mut var_types := this.parseunionmembertypes()
	if var_directives.clone().array_count() == 0 && var_types.clone().array_count() == 0 {
		rt.throw_exception(this.unexpected(rt.new_null()))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_uniontypeextensionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'types', val: var_types }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumtypeextension() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('extend')
	this.expectkeyword('enum')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	mut var_values := this.parseenumvaluesdefinition()
	if var_directives.clone().array_count() == 0 && var_values.clone().array_count() == 0 {
		rt.throw_exception(this.unexpected(rt.new_null()))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_enumtypeextensionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'values', val: var_values }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputobjecttypeextension() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	this.expectkeyword('extend')
	this.expectkeyword('input')
	mut var_name := this.parsename()
	mut var_directives := this.parsedirectives(true)
	mut var_fields := this.parseinputfieldsdefinition()
	if var_directives.clone().array_count() == 0 && var_fields.clone().array_count() == 0 {
		rt.throw_exception(this.unexpected(rt.new_null()))
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_inputobjecttypeextensionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'directives', val: var_directives }, rt.ArrayItem{ key: 'fields', val: var_fields }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectivedefinition() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_description := this.parsedescription()
	this.expectkeyword('directive')
	this.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.at()).str())
	mut var_name := this.parsename()
	mut var_args := this.parseargumentsdefinition()
	mut var_repeatable := rt.new_bool(this.expectoptionalkeyword('repeatable'))
	this.expectkeyword('on')
	mut var_locations := this.parsedirectivelocations()
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_directivedefinitionnode(rt.create_array([rt.ArrayItem{ key: 'name', val: var_name }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'arguments', val: var_args }, rt.ArrayItem{ key: 'repeatable', val: var_repeatable }, rt.ArrayItem{ key: 'locations', val: var_locations }, rt.ArrayItem{ key: 'loc', val: this.loc(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](var_start)) }])))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectivelocations() rt.PhpVal {
	this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.pipe()).str())
	mut var_locations := rt.new_array()
	for {
		var_locations.array_push(this.parsedirectivelocation())
		if !(this.skip((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.pipe()).str())) {
			break
		}
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList', []string{}, create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(var_locations.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectivelocation() rt.PhpVal {
	mut var_start := rt.get_property(this.lexer, 'token')
	mut var_name := this.parsename()
	mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation{}
	mut iife_result_13 := iife_temp_13.has(rt.get_property(var_name, 'value'))
	if rt.is_true(iife_result_13) {
		return var_name.clone()
	}
	rt.throw_exception(this.unexpected(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token](var_start)))
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_parser(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		lexer: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_self(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_source(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_lexer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_location(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_syntaxerror(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_namenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_documentnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_operationdefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_variabledefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_variablenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_selectionsetnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_fieldnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_argumentnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_fragmentspreadnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_inlinefragmentnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_fragmentdefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_intvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_floatvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_booleanvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nullvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_stringvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_listvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objectvaluenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objectfieldnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_directivenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_listtypenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nonnulltypenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_namedtypenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_schemadefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_operationtypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_scalartypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objecttypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_fielddefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_inputvaluedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_interfacetypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_uniontypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_enumtypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_enumvaluedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_inputobjecttypedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_schemaextensionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_scalartypeextensionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_objecttypeextensionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_interfacetypeextensionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_uniontypeextensionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_enumtypeextensionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_inputobjecttypeextensionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_directivedefinitionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_directivelocation(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'parse' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parse(dispatch_arg_0, mut dispatch_arg_1)
		}
		'parseValue' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parsevalue(dispatch_arg_0, mut dispatch_arg_1)
		}
		'parseType' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parsetype(dispatch_arg_0, mut dispatch_arg_1)
		}
		'__callStatic' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.magic_callstatic(dispatch_arg_0, mut dispatch_arg_1)
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'loc' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.loc(mut dispatch_arg_0)
		}
		'peek' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.peek(dispatch_arg_0))
		}
		'skip' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.skip(dispatch_arg_0))
		}
		'expect' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.expect(dispatch_arg_0)
		}
		'expectKeyword' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.expectkeyword(dispatch_arg_0)
			return rt.new_null()
		}
		'expectOptionalKeyword' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.expectoptionalkeyword(dispatch_arg_0))
		}
		'unexpected' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.unexpected(mut dispatch_arg_0)
		}
		'any' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.any(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'many' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.many(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'parseName' {
			return this.parsename()
		}
		'parseDocument' {
			return this.parsedocument()
		}
		'parseDefinition' {
			return this.parsedefinition()
		}
		'parseExecutableDefinition' {
			return this.parseexecutabledefinition()
		}
		'parseOperationDefinition' {
			return this.parseoperationdefinition()
		}
		'parseOperationType' {
			return rt.new_string(this.parseoperationtype())
		}
		'parseVariableDefinitions' {
			return this.parsevariabledefinitions()
		}
		'parseVariableDefinition' {
			return this.parsevariabledefinition()
		}
		'parseVariable' {
			return this.parsevariable()
		}
		'parseSelectionSet' {
			return this.parseselectionset()
		}
		'parseSelection' {
			return this.parseselection()
		}
		'parseField' {
			return this.parsefield()
		}
		'parseArguments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parsearguments(dispatch_arg_0)
		}
		'parseArgument' {
			return this.parseargument()
		}
		'parseConstArgument' {
			return this.parseconstargument()
		}
		'parseFragment' {
			return this.parsefragment()
		}
		'parseFragmentDefinition' {
			return this.parsefragmentdefinition()
		}
		'parseFragmentName' {
			return this.parsefragmentname()
		}
		'parseValueLiteral' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parsevalueliteral(dispatch_arg_0)
		}
		'parseStringLiteral' {
			return this.parsestringliteral()
		}
		'parseConstValue' {
			return this.parseconstvalue()
		}
		'parseVariableValue' {
			return this.parsevariablevalue()
		}
		'parseArray' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parsearray(dispatch_arg_0)
		}
		'parseObject' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parseobject(dispatch_arg_0)
		}
		'parseObjectField' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parseobjectfield(dispatch_arg_0)
		}
		'parseDirectives' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parsedirectives(dispatch_arg_0)
		}
		'parseDirective' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.parsedirective(dispatch_arg_0)
		}
		'parseTypeReference' {
			return this.parsetypereference()
		}
		'parseNamedType' {
			return this.parsenamedtype()
		}
		'parseTypeSystemDefinition' {
			return this.parsetypesystemdefinition()
		}
		'peekDescription' {
			return rt.new_bool(this.peekdescription())
		}
		'parseDescription' {
			return this.parsedescription()
		}
		'parseSchemaDefinition' {
			return this.parseschemadefinition()
		}
		'parseOperationTypeDefinition' {
			return this.parseoperationtypedefinition()
		}
		'parseScalarTypeDefinition' {
			return this.parsescalartypedefinition()
		}
		'parseObjectTypeDefinition' {
			return this.parseobjecttypedefinition()
		}
		'parseImplementsInterfaces' {
			return this.parseimplementsinterfaces()
		}
		'parseFieldsDefinition' {
			return this.parsefieldsdefinition()
		}
		'parseFieldDefinition' {
			return this.parsefielddefinition()
		}
		'parseArgumentsDefinition' {
			return this.parseargumentsdefinition()
		}
		'parseInputValueDefinition' {
			return this.parseinputvaluedefinition()
		}
		'parseInterfaceTypeDefinition' {
			return this.parseinterfacetypedefinition()
		}
		'parseUnionTypeDefinition' {
			return this.parseuniontypedefinition()
		}
		'parseUnionMemberTypes' {
			return this.parseunionmembertypes()
		}
		'parseEnumTypeDefinition' {
			return this.parseenumtypedefinition()
		}
		'parseEnumValuesDefinition' {
			return this.parseenumvaluesdefinition()
		}
		'parseEnumValueDefinition' {
			return this.parseenumvaluedefinition()
		}
		'parseInputObjectTypeDefinition' {
			return this.parseinputobjecttypedefinition()
		}
		'parseInputFieldsDefinition' {
			return this.parseinputfieldsdefinition()
		}
		'parseTypeSystemExtension' {
			return this.parsetypesystemextension()
		}
		'parseSchemaTypeExtension' {
			return this.parseschematypeextension()
		}
		'parseScalarTypeExtension' {
			return this.parsescalartypeextension()
		}
		'parseObjectTypeExtension' {
			return this.parseobjecttypeextension()
		}
		'parseInterfaceTypeExtension' {
			return this.parseinterfacetypeextension()
		}
		'parseUnionTypeExtension' {
			return this.parseuniontypeextension()
		}
		'parseEnumTypeExtension' {
			return this.parseenumtypeextension()
		}
		'parseInputObjectTypeExtension' {
			return this.parseinputobjecttypeextension()
		}
		'parseDirectiveDefinition' {
			return this.parsedirectivedefinition()
		}
		'parseDirectiveLocations' {
			return this.parsedirectivelocations()
		}
		'parseDirectiveLocation' {
			return this.parsedirectivelocation()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'lexer' { return this.lexer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'lexer' { this.lexer = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_SyntaxError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_DirectiveLocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}

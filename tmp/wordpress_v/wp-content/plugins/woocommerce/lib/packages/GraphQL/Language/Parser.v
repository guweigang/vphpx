import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	rt.PhpObjectBase
pub mut:
		lexer rt.PhpVal = rt.new_null()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parse(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	return rt.call_method(create_automattic_woocommerce_vendor_graphql_language_self(var_source.dup(), var_options.dup()), 'parseDocument', []rt.PhpVal{})
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parsevalue(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	mut var_parser := create_automattic_woocommerce_vendor_graphql_language_parser(var_source.dup(), var_options.dup())
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof()).str())
	mut var_value := var_parser.parsevalueliteral(false)
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof()).str())
	return var_value.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.parsetype(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	mut var_parser := create_automattic_woocommerce_vendor_graphql_language_parser(var_source.dup(), var_options.dup())
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.sof()).str())
	mut var_type := var_parser.parsetypereference()
	var_parser.expect((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token.eof()).str())
	return var_type.dup()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser.magic_callstatic(name string, mut var_arguments Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array) rt.PhpVal {
	mut name_mutated := name
	mut var_parser := create_automattic_woocommerce_vendor_graphql_language_parser(var_arguments.dup(), rt.new_null())
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
	return var_parsed.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) construct(var_source rt.PhpVal, mut var_options Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array)  {
	mut var_sourceObj := if rt.is_true(rt.new_bool(rt.instance_of(var_source, 'Automattic_WooCommerce_Vendor_GraphQL_Language_Source'))) { var_source } else { create_automattic_woocommerce_vendor_graphql_language_source(var_source.dup()) }
	this.lexer = create_automattic_woocommerce_vendor_graphql_language_lexer(var_sourceObj.dup(), var_options.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) loc(mut var_startToken Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Token) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(if !(rt.get_property(this.lexer, 'options').array_get('noLocation')).is_null() { rt.get_property(this.lexer, 'options').array_get('noLocation') } else { rt.new_bool(false) })))) {
		return create_automattic_woocommerce_vendor_graphql_language_ast_location(var_startToken.dup(), rt.get_property(this.lexer, 'lastToken'), rt.get_property(this.lexer, 'source'))
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
	mut var_token := rt.get_property(, 'token')
	if rt.is_true(rt.identical(, )) {
		
	}
	
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) expectkeyword(value string)  {
	mut value_mutated := value
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) expectoptionalkeyword(value string) bool {
	mut value_mutated := value
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) unexpected(mut var_atToken Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Token) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) any(openKind string, mut var_parseFn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable, closeKind string) rt.PhpVal {
	mut var_parseFn_mutated := var_parseFn
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) many(openKind string, mut var_parseFn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_callable, closeKind string) rt.PhpVal {
	mut var_parseFn_mutated := var_parseFn
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsename() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedocument() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedefinition() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseexecutabledefinition() rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseoperationdefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseoperationtype() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariabledefinitions() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariabledefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariable() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseselectionset() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseselection() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefield() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsearguments(isConst bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseargument() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseconstargument() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefragment() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefragmentdefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefragmentname() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevalueliteral(isConst bool)  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsestringliteral() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseconstvalue() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsevariablevalue() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsearray(isConst bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobject(isConst bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobjectfield(isConst bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectives(isConst bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirective(isConst bool) rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsetypereference() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsenamedtype() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsetypesystemdefinition()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) peekdescription() bool {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedescription() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseschemadefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseoperationtypedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsescalartypedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobjecttypedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseimplementsinterfaces() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefieldsdefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsefielddefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseargumentsdefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputvaluedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinterfacetypedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseuniontypedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseunionmembertypes() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumtypedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumvaluesdefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumvaluedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputobjecttypedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputfieldsdefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsetypesystemextension()  {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseschematypeextension() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsescalartypeextension() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseobjecttypeextension() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinterfacetypeextension() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseuniontypeextension() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseenumtypeextension() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parseinputobjecttypeextension() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectivedefinition() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectivelocations() rt.PhpVal {
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser) parsedirectivelocation() rt.PhpVal {
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

fn create_automattic_woocommerce_vendor_graphql_language_parser(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		lexer: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_self() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_source() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Source{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_lexer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Lexer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_location() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Location{
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
			this.parsevalueliteral(dispatch_arg_0)
			return rt.new_null()
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
			this.parsetypesystemdefinition()
			return rt.new_null()
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
			this.parsetypesystemextension()
			return rt.new_null()
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


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_parser_php() {
	// unsupported statement: Stmt_Declare
}

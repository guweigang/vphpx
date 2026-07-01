import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser {
	rt.PhpObjectBase
pub mut:
		tokenizer rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) construct(mut var_tokenizer Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_?Tokenizer)  {
	this.tokenizer = if !(var_tokenizer).is_null() { var_tokenizer } else { create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_tokenizer_tokenizer() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parse(source string) rt.PhpVal {
	mut var_reader := create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_reader(rt.new_string(source).dup())
	mut var_stream := rt.call_method(this.tokenizer, 'tokenize', [var_reader])
	return this.parseselectorlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](var_stream))
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser.parseseries(mut var_tokens Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_array) rt.PhpVal {
	{
		mut iter_1 := var_tokens.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_token := item_1.val
			if rt.is_true(rt.call_method(var_token, 'isString', []rt.PhpVal{})) {
				rt.throw_exception(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.stringasfunctionargument() }())
			}
		}
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
	}
	mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
	}
	mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
	}
	mut var_token := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
	}
	mut var_joined := rt.new_string(rt.new_string(rt.call_function('implode', [rt.new_string(''), rt.call_function('array_map', [rt.new_closure(closure_3_fn), var_tokens])]).to_string().trim_space()))
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_string := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_string.dup().is_long() || var_string.dup().is_double()))))) {
		rt.throw_exception(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.stringasfunctionargument() }())
	}
	return // unsupported expression: Expr_Cast_Int
	}
	mut var_int := rt.new_closure(closure_5_fn)
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.identical(rt.new_string('odd'), var_joined))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 1 }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.identical(rt.new_string('even'), var_joined))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 0 }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.identical(rt.new_string('n'), var_joined))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 1 }, rt.ArrayItem{ key: none, val: 0 }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_joined.dup(), rt.new_string('n')])))))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: rt.call_callable(var_int, [var_joined.dup()]) }])
	}
	mut var_split := rt.call_function('explode', [rt.new_string('n'), var_joined.dup()])
	mut var_first := if !(var_split.array_get(0)).is_null() { var_split.array_get(0) } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: none, val: if rt.is_true(var_first) { if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('-'), var_first)) || rt.is_true(rt.identical(rt.new_string('+'), var_first)))) { rt.call_callable(var_int, [(var_first).str() + '1']) } else { rt.call_callable(var_int, [var_first.dup()]) } } else { rt.new_int(1) } }, rt.ArrayItem{ key: none, val: if rt.is_true(rt.new_bool(var_split.array_isset(rt.new_int(1)) && rt.is_true(var_split.array_get(1)))) { rt.call_callable(var_int, [var_split.array_get(1)]) } else { rt.new_int(0) } }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parseselectorlist(mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) rt.PhpVal {
	mut var_stream_mutated := var_stream
	rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
	mut var_selectors := rt.new_array()
	for true {
		var_selectors.array_push(this.parserselectornode(mut var_stream_mutated))
		if rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ',' }])])) {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
		} else {
			break
		}
	}
	return var_selectors.dup()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parserselectornode(mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) rt.PhpVal {
	mut var_pseudoElement := rt.new_null()
	mut var_nextSelector := rt.new_null()
	mut var_stream_mutated := var_stream
	// unsupported assign target: Expr_List
	for true {
		rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
		mut var_peek := rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_peek, 'isFileEnd', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ',' }])])))) {
			break
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.pseudoelementfound(arg_0, arg_1) }(var_pseudoElement.dup(), rt.new_string('not at the end of a selector')))
		}
		if rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '~' }])])) {
			mut var_combinator := rt.call_method(rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{}), 'getValue', []rt.PhpVal{})
			rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
		} else {
			var_combinator = rt.new_string(rt.new_string(' '))
		}
		// unsupported assign target: Expr_List
		mut var_result := create_automattic_woocommerce_vendor_symfony_component_cssselector_node_combinedselectornode(var_result.dup(), var_combinator.dup(), var_nextSelector.dup())
	}
	return create_automattic_woocommerce_vendor_symfony_component_cssselector_node_selectornode(var_result.dup(), var_pseudoElement.dup())
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parsesimpleselector(mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream, insideNegation bool) rt.PhpVal {
	mut var_argument := rt.new_null()
	mut var_argumentPseudoElement := rt.new_null()
	mut var_stream_mutated := var_stream
	rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
	mut var_selectorStart := rt.new_int(rt.new_int(rt.call_method(var_stream_mutated, 'getUsed', []rt.PhpVal{}).array_count()))
	mut var_result := this.parseelementnode(mut var_stream_mutated)
	mut var_pseudoElement := rt.new_null()
	for true {
		mut var_peek := rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_peek, 'isWhitespace', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_peek, 'isFileEnd', []rt.PhpVal{})))) || rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ',' }, rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '~' }])])))) || rt.is_true(rt.new_bool(var_insideNegation && rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ')' }])])))))) {
			break
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.pseudoelementfound(arg_0, arg_1) }(var_pseudoElement.dup(), rt.new_string('not at the end of a selector')))
		}
		if rt.is_true(rt.call_method(var_peek, 'isHash', []rt.PhpVal{})) {
			var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_hashnode(var_result.dup(), rt.call_method(rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{}), 'getValue', []rt.PhpVal{}))
		} else if rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '.' }])])) {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_classnode(var_result.dup(), rt.call_method(var_stream_mutated, 'getNextIdentifier', []rt.PhpVal{}))
		} else if rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '[' }])])) {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			var_result = this.parseattributenode(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](var_result), mut var_stream_mutated)
		} else if rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ':' }])])) {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			if rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ':' }])])) {
				rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
				var_pseudoElement = rt.call_method(var_stream_mutated, 'getNextIdentifier', []rt.PhpVal{})
				continue
			}
			mut var_identifier := rt.call_method(var_stream_mutated, 'getNextIdentifier', []rt.PhpVal{})
			if rt.is_true(rt.call_function('in_array', [rt.new_string(var_identifier.dup().to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'first-line' }, rt.ArrayItem{ key: none, val: 'first-letter' }, rt.ArrayItem{ key: none, val: 'before' }, rt.ArrayItem{ key: none, val: 'after' }])])) {
				var_pseudoElement = var_identifier.dup()
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '(' }])]))))) {
				var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_pseudonode(var_result.dup(), var_identifier.dup())
				continue
			}
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
			if rt.is_true(rt.identical(rt.new_string('not'), rt.new_string(var_identifier.dup().to_string().to_lower()))) {
				if var_insideNegation {
					rt.throw_exception(fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.nestednot() }())
				}
				// unsupported assign target: Expr_List
				mut var_next := rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.pseudoelementfound(arg_0, arg_1) }(var_argumentPseudoElement.dup(), rt.new_string('inside ::not()')))
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ')' }])]))))) {
					rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.unexpectedtoken(arg_0, arg_1) }(rt.new_string('")"'), var_next.dup()))
				}
				var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_negationnode(var_result.dup(), var_argument.dup())
			} else {
				mut var_arguments := rt.new_array()
				var_next = rt.new_null()
				for true {
					rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
					var_next = rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_next, 'isIdentifier', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_next, 'isString', []rt.PhpVal{})))) || rt.is_true(rt.call_method(var_next, 'isNumber', []rt.PhpVal{})))) || rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '-' }])])))) {
						var_arguments.array_push(var_next.dup())
					} else if rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ')' }])])) {
						break
					} else {
						rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.unexpectedtoken(arg_0, arg_1) }(rt.new_string('an argument'), var_next.dup()))
					}
				}
				if !rt.is_true(var_arguments) {
					rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.unexpectedtoken(arg_0, arg_1) }(rt.new_string('at least one argument'), var_next.dup()))
				}
				var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_functionnode(var_result.dup(), var_identifier.dup(), var_arguments.dup())
			}
		} else {
			rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.unexpectedtoken(arg_0, arg_1) }(rt.new_string('selector'), var_peek.dup()))
		}
	}
	if rt.is_true(rt.identical(rt.new_int(rt.call_method(var_stream_mutated, 'getUsed', []rt.PhpVal{}).array_count()), var_selectorStart)) {
		rt.throw_exception(fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}; return temp.unexpectedtoken(arg_0, arg_1) }(rt.new_string('selector'), rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{})))
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_result }, rt.ArrayItem{ key: none, val: var_pseudoElement }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parseelementnode(mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) rt.PhpVal {
	mut var_stream_mutated := var_stream
	mut var_peek := rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_peek, 'isIdentifier', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '*' }])])))) {
		if rt.is_true(rt.call_method(var_peek, 'isIdentifier', []rt.PhpVal{})) {
			mut var_namespace := rt.call_method(rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{}), 'getValue', []rt.PhpVal{})
		} else {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			var_namespace = rt.new_null()
		}
		if rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '|' }])])) {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			mut var_element := rt.call_method(, 'getNextIdentifierOrStar', []rt.PhpVal{})
		} else {
			var_element = .dup()
			
		}
	} else {
		
	}
	return 
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parseattributenode(mut var_selector Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface, mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) rt.PhpVal {
	mut var_stream_mutated := var_stream
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_parser(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser{
		PhpObjectBase: rt.PhpObjectBase{}
		tokenizer: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_tokenizer_tokenizer() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_reader() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_syntaxerrorexception() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_combinedselectornode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_selectornode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_hashnode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_classnode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_pseudonode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_negationnode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_functionnode() &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_?Tokenizer](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'parse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse(dispatch_arg_0)
		}
		'parseSeries' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_array](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser.parseseries(mut dispatch_arg_0)
		}
		'parseSelectorList' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parseselectorlist(mut dispatch_arg_0)
		}
		'parserSelectorNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parserselectornode(mut dispatch_arg_0)
		}
		'parseSimpleSelector' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.parsesimpleselector(mut dispatch_arg_0, dispatch_arg_1)
		}
		'parseElementNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.parseelementnode(mut dispatch_arg_0)
		}
		'parseAttributeNode' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.parseattributenode(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tokenizer' { return this.tokenizer }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tokenizer' { this.tokenizer = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_content_plugins_woocommerce_lib_packages_symfony_component_cssselector_parser_parser_php() {
}

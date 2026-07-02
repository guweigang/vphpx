import rt

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser {
	rt.PhpObjectBase
pub mut:
		tokenizer rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) construct(mut var_tokenizer Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_?Tokenizer) {
	this.tokenizer = if !(var_tokenizer).is_null() { var_tokenizer } else { create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_tokenizer_tokenizer() }
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parse(source string) rt.PhpVal {
	mut var_reader := create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_reader(rt.new_string(source))
	mut var_stream := rt.call_method(this.tokenizer, 'tokenize', [var_reader])
	return this.parseselectorlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream](var_stream))
}

fn Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser.parseseries(mut var_tokens Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_array) rt.PhpVal {
	mut iter_1 := var_tokens.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_token := item_1.val
		if rt.is_true(rt.call_method(var_token, 'isString', []rt.PhpVal{})) {
			mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
			mut iife_result_0 := iife_temp_0.stringasfunctionargument()
			rt.throw_exception(iife_result_0)
		}
	}
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_token := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
		}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_token := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
		}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_token := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
		}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_token := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_token, 'getValue', []rt.PhpVal{})
		}
	mut var_joined := rt.new_string(rt.call_function('implode', [rt.new_string(''), rt.call_function('array_map', [rt.new_closure(closure_4_fn), var_tokens])]).to_string().trim_space())
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_string := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_string.clone().is_long() || var_string.clone().is_double()) {
			mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
			mut iife_result_6 := iife_temp_6.stringasfunctionargument()
			rt.throw_exception(iife_result_6)
		}
		return rt.new_int((var_string).to_i64())
		}
	mut var_int := rt.new_closure(closure_7_fn)
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.identical(rt.new_string('odd'), var_joined))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 1 }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.identical(rt.new_string('even'), var_joined))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 2 }, rt.ArrayItem{ key: none, val: 0 }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.identical(rt.new_string('n'), var_joined))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 1 }, rt.ArrayItem{ key: none, val: 0 }])
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_joined.clone(), rt.new_string('n')])))))) {
		return rt.create_array([rt.ArrayItem{ key: none, val: 0 }, rt.ArrayItem{ key: none, val: rt.call_callable(var_int, [var_joined.clone()]) }])
	}
	mut var_split := rt.call_function('explode', [rt.new_string('n'), var_joined.clone()])
	mut var_first := if !(var_split.array_get(rt.new_int(0))).is_null() { var_split.array_get(rt.new_int(0)) } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: none, val: if rt.is_true(var_first) { if rt.is_true(rt.identical(rt.new_string('-'), var_first)) || rt.is_true(rt.identical(rt.new_string('+'), var_first)) { rt.call_callable(var_int, [rt.new_string((var_first).str() + '1')]) } else { rt.call_callable(var_int, [var_first.clone()]) } } else { rt.new_int(1) } }, rt.ArrayItem{ key: none, val: if var_split.array_isset(rt.new_int(1)) && rt.is_true(var_split.array_get(rt.new_int(1))) { rt.call_callable(var_int, [var_split.array_get(rt.new_int(1))]) } else { rt.new_int(0) } }])
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
	return var_selectors.clone()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parserselectornode(mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) rt.PhpVal {
	mut var_pseudoElement := rt.new_null()
	mut var_nextSelector := rt.new_null()
	mut var_stream_mutated := var_stream
	mut list_tmp_1 := this.parsesimpleselector(mut var_stream_mutated, false)
	mut var_result := (list_tmp_1).array_get(0)
	var_pseudoElement = (list_tmp_1).array_get(1)
	for true {
		rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
		mut var_peek := rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{})
		if rt.is_true(rt.call_method(var_peek, 'isFileEnd', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ',' }])])) {
			break
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pseudoElement)))) {
			mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
			mut iife_result_7 := iife_temp_7.pseudoelementfound(var_pseudoElement.clone(), rt.new_string('not at the end of a selector'))
			rt.throw_exception(iife_result_7)
		}
		if rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '~' }])])) {
			mut var_combinator := rt.call_method(rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{}), 'getValue', []rt.PhpVal{})
			rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
		} else {
		var_combinator = rt.new_string(' ')
		}
		mut list_tmp_2 := this.parsesimpleselector(mut var_stream_mutated, false)
		var_nextSelector = (list_tmp_2).array_get(0)
		var_pseudoElement = (list_tmp_2).array_get(1)
	var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_combinedselectornode(var_result.clone(), var_combinator.clone(), var_nextSelector.clone())
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode', []string{}, create_automattic_woocommerce_vendor_symfony_component_cssselector_node_selectornode(var_result.clone(), var_pseudoElement.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parsesimpleselector(mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream, insideNegation bool) rt.PhpVal {
	mut var_argument := rt.new_null()
	mut var_argumentPseudoElement := rt.new_null()
	mut var_stream_mutated := var_stream
	rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
	mut var_selectorStart := rt.new_int(rt.call_method(var_stream_mutated, 'getUsed', []rt.PhpVal{}).array_count())
	mut var_result := this.parseelementnode(mut var_stream_mutated)
	mut var_pseudoElement := rt.new_null()
	for true {
		mut var_peek := rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{})
		if rt.is_true(rt.call_method(var_peek, 'isWhitespace', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_peek, 'isFileEnd', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ',' }, rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '>' }, rt.ArrayItem{ key: none, val: '~' }])])) || (var_insideNegation && rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ')' }])]))) {
			break
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pseudoElement)))) {
			mut iife_temp_8 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
			mut iife_result_8 := iife_temp_8.pseudoelementfound(var_pseudoElement.clone(), rt.new_string('not at the end of a selector'))
			rt.throw_exception(iife_result_8)
		}
		if rt.is_true(rt.call_method(var_peek, 'isHash', []rt.PhpVal{})) {
		var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_hashnode(var_result.clone(), rt.call_method(rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{}), 'getValue', []rt.PhpVal{}))
		} else if rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '.' }])])) {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
		var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_classnode(var_result.clone(), rt.call_method(var_stream_mutated, 'getNextIdentifier', []rt.PhpVal{}))
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
			if rt.is_true(rt.call_function('in_array', [rt.new_string(var_identifier.clone().to_string().to_lower()), rt.create_array([rt.ArrayItem{ key: none, val: 'first-line' }, rt.ArrayItem{ key: none, val: 'first-letter' }, rt.ArrayItem{ key: none, val: 'before' }, rt.ArrayItem{ key: none, val: 'after' }])])) {
				var_pseudoElement = var_identifier.clone()
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '(' }])]))))) {
				var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_pseudonode(var_result.clone(), var_identifier.clone())
				continue
			}
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
			rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
			if rt.is_true(rt.identical(rt.new_string('not'), rt.new_string(var_identifier.clone().to_string().to_lower()))) {
				if var_insideNegation {
					mut iife_temp_9 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
					mut iife_result_9 := iife_temp_9.nestednot()
					rt.throw_exception(iife_result_9)
				}
				mut list_tmp_3 := this.parsesimpleselector(mut var_stream_mutated, true)
				var_argument = (list_tmp_3).array_get(0)
				var_argumentPseudoElement = (list_tmp_3).array_get(1)
				mut var_next := rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_argumentPseudoElement)))) {
					mut iife_temp_10 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
					mut iife_result_10 := iife_temp_10.pseudoelementfound(var_argumentPseudoElement.clone(), rt.new_string('inside ::not()'))
					rt.throw_exception(iife_result_10)
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ')' }])]))))) {
					mut iife_temp_11 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
					mut iife_result_11 := iife_temp_11.unexpectedtoken(rt.new_string('")"'), var_next.clone())
					rt.throw_exception(iife_result_11)
				}
			var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_negationnode(var_result.clone(), var_argument.clone())
			} else {
				mut var_arguments := rt.new_array()
				var_next = rt.new_null()
				for true {
					rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
					var_next = rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
					if rt.is_true(rt.call_method(var_next, 'isIdentifier', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_next, 'isString', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_next, 'isNumber', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '+' }, rt.ArrayItem{ key: none, val: '-' }])])) {
						var_arguments.array_push(var_next.clone())
					} else if rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ')' }])])) {
						break
					} else {
						mut iife_temp_12 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
						mut iife_result_12 := iife_temp_12.unexpectedtoken(rt.new_string('an argument'), var_next.clone())
						rt.throw_exception(iife_result_12)
					}
				}
				if !rt.is_true(var_arguments) {
					mut iife_temp_13 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
					mut iife_result_13 := iife_temp_13.unexpectedtoken(rt.new_string('at least one argument'), var_next.clone())
					rt.throw_exception(iife_result_13)
				}
			var_result = create_automattic_woocommerce_vendor_symfony_component_cssselector_node_functionnode(var_result.clone(), var_identifier.clone(), var_arguments.clone())
			}
		} else {
			mut iife_temp_14 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
			mut iife_result_14 := iife_temp_14.unexpectedtoken(rt.new_string('selector'), var_peek.clone())
			rt.throw_exception(iife_result_14)
		}
	}
	if rt.is_true(rt.identical(rt.new_int(rt.call_method(var_stream_mutated, 'getUsed', []rt.PhpVal{}).array_count()), var_selectorStart)) {
		mut iife_temp_15 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
		mut iife_result_15 := iife_temp_15.unexpectedtoken(rt.new_string('selector'), rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}))
		rt.throw_exception(iife_result_15)
	}
	return rt.create_array([rt.ArrayItem{ key: none, val: var_result }, rt.ArrayItem{ key: none, val: var_pseudoElement }])
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parseelementnode(mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) rt.PhpVal {
	mut var_stream_mutated := var_stream
	mut var_peek := rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_peek, 'isIdentifier', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_peek, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '*' }])])) {
		if rt.is_true(rt.call_method(var_peek, 'isIdentifier', []rt.PhpVal{})) {
		mut var_namespace := rt.call_method(rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{}), 'getValue', []rt.PhpVal{})
		} else {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
		var_namespace = rt.new_null()
		}
		if rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '|' }])])) {
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
		mut var_element := rt.call_method(var_stream_mutated, 'getNextIdentifierOrStar', []rt.PhpVal{})
		} else {
		var_element = var_namespace.clone()
		var_namespace = rt.new_null()
		}
	} else {
	var_namespace = rt.new_null()
	var_element = var_namespace
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode', []string{}, create_automattic_woocommerce_vendor_symfony_component_cssselector_node_elementnode(var_namespace.clone(), var_element.clone()))
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Parser) parseattributenode(mut var_selector Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NodeInterface, mut var_stream Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_TokenStream) rt.PhpVal {
	mut var_stream_mutated := var_stream
	rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
	mut var_attribute := rt.call_method(var_stream_mutated, 'getNextIdentifierOrStar', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.new_null(), var_attribute)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '|' }])]))))) {
		mut iife_temp_16 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
		mut iife_result_16 := iife_temp_16.unexpectedtoken(rt.new_string('"|"'), rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}))
		rt.throw_exception(iife_result_16)
	}
	if rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '|' }])])) {
		rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
		if rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '=' }])])) {
			mut var_namespace := rt.new_null()
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
		mut var_operator := rt.new_string('|=')
		} else {
		var_namespace = var_attribute.clone()
		var_attribute = rt.call_method(var_stream_mutated, 'getNextIdentifier', []rt.PhpVal{})
		var_operator = rt.new_null()
		}
	} else {
	var_operator = rt.new_null()
	var_namespace = var_operator
	}
	if rt.is_true(rt.identical(rt.new_null(), var_operator)) {
		rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
		mut var_next := rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
		if rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ']' }])])) {
			return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode', []string{}, create_automattic_woocommerce_vendor_symfony_component_cssselector_node_attributenode(var_selector, var_namespace.clone(), var_attribute.clone(), rt.new_string('exists'), rt.new_null()))
		} else if rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '=' }])])) {
		var_operator = rt.new_string('=')
		} else if rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '^' }, rt.ArrayItem{ key: none, val: '$' }, rt.ArrayItem{ key: none, val: '*' }, rt.ArrayItem{ key: none, val: '~' }, rt.ArrayItem{ key: none, val: '|' }, rt.ArrayItem{ key: none, val: '!' }])])) && rt.is_true(rt.call_method(rt.call_method(var_stream_mutated, 'getPeek', []rt.PhpVal{}), 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: '=' }])])) {
			var_operator = rt.new_string((rt.call_method(var_next, 'getValue', []rt.PhpVal{})).str() + '=')
			rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
		} else {
			mut iife_temp_17 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
			mut iife_result_17 := iife_temp_17.unexpectedtoken(rt.new_string('operator'), var_next.clone())
			rt.throw_exception(iife_result_17)
		}
	}
	rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
	mut var_value := rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
	if rt.is_true(rt.call_method(var_value, 'isNumber', []rt.PhpVal{})) {
	var_value = create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_token(Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token.type_string(), (rt.call_method(var_value, 'getValue', []rt.PhpVal{})).str(), rt.call_method(var_value, 'getPosition', []rt.PhpVal{}))
	}
	if !(rt.is_true(rt.call_method(var_value, 'isIdentifier', []rt.PhpVal{})) || rt.is_true(rt.call_method(var_value, 'isString', []rt.PhpVal{}))) {
		mut iife_temp_18 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
		mut iife_result_18 := iife_temp_18.unexpectedtoken(rt.new_string('string or identifier'), var_value.clone())
		rt.throw_exception(iife_result_18)
	}
	rt.call_method(var_stream_mutated, 'skipWhitespace', []rt.PhpVal{})
	var_next = rt.call_method(var_stream_mutated, 'getNext', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_next, 'isDelimiter', [rt.create_array([rt.ArrayItem{ key: none, val: ']' }])]))))) {
		mut iife_temp_19 := Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{}
		mut iife_result_19 := iife_temp_19.unexpectedtoken(rt.new_string('"]"'), var_next.clone())
		rt.throw_exception(iife_result_19)
	}
	return rt.new_object('Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode', []string{}, create_automattic_woocommerce_vendor_symfony_component_cssselector_node_attributenode(var_selector, var_namespace.clone(), var_attribute.clone(), var_operator.clone(), rt.call_method(var_value, 'getValue', []rt.PhpVal{})))
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

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token {
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

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_tokenizer_tokenizer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Tokenizer_Tokenizer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_reader(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Reader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_exception_syntaxerrorexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Exception_SyntaxErrorException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_combinedselectornode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_CombinedSelectorNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_selectornode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_SelectorNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_hashnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_HashNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_classnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ClassNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_pseudonode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_PseudoNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_negationnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_NegationNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_functionnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_FunctionNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_elementnode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_node_attributenode(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_symfony_component_cssselector_parser_token(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token {
	mut obj := &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token{
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


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_ElementNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Node_AttributeNode) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_Symfony_Component_CssSelector_Parser_Token) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

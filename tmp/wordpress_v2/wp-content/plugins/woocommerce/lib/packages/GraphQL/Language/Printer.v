import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.doprint(mut var_ast Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut var_ast)).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut var_node Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node) string {
	if rt.is_true(rt.identical(var_node, rt.new_null())) {
		return ''
	}
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectFieldNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + ': ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'value')))).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_BooleanValueNode')))) {
		return if rt.is_true(rt.get_property(var_node, 'value')) { 'true' } else { 'false' }
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode')))) {
		mut var_argStrings := rt.new_array()
		mut iter_1 := rt.get_property(var_node, 'arguments').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg := item_1.val
			var_argStrings.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](var_arg)))
		}
		mut var_noIndent := rt.new_bool(true)
		mut iter_2 := var_argStrings.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_argString := item_2.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_argString.clone(), rt.new_string('\n')]), rt.new_bool(false))))) {
			var_noIndent = rt.new_bool(false)
			}
		}
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), 'directive @' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + (if rt.is_true(var_noIndent) { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_argStrings), ', ')), ')') } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(\n', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_argStrings), '\n')).str())), '\n') }).str() + if rt.is_true(rt.get_property(var_node, 'repeatable')) { ' repeatable' } else { '' } + ' on ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'locations')), ' | ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveNode')))) {
		return '@' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'arguments')), ', ')), ')')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DocumentNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'definitions')), '\n\n')).str() + '\n'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'enum' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'values'))) }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'extend enum' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'values'))) }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_EnumValueNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FloatValueNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_IntValueNode')))) || rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NameNode')))) {
		return (rt.get_property(var_node, 'value')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldDefinitionNode')))) {
		var_argStrings = rt.new_array()
		mut iter_3 := rt.get_property(var_node, 'arguments').iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_item := item_3.val
			var_argStrings.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](var_item)))
		}
		var_noIndent = rt.new_bool(true)
		mut iter_4 := var_argStrings.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_argString := item_4.val
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('strpos', [var_argString.clone(), rt.new_string('\n')]), rt.new_bool(false))))) {
			var_noIndent = rt.new_bool(false)
			}
		}
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + (if rt.is_true(var_noIndent) { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_argStrings), ', ')), ')') } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(\n', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_argStrings), '\n')).str())), '\n)') }).str() + ': ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'type')))).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(' ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ')))).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
		mut var_prefix := rt.new_string((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](if !(rt.get_property(rt.get_property(var_node, 'alias'), 'value')).is_null() { rt.get_property(rt.get_property(var_node, 'alias'), 'value') } else { rt.new_null() }), ': ')).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str())
		mut var_argsLine := rt.new_string((var_prefix).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'arguments')), ', ')), ')')).str())
		if var_argsLine.clone().to_string().len > 80 {
		var_argsLine = rt.new_string((var_prefix).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(\n', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'arguments')), '\n')).str())), '\n)')).str())
		}
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: var_argsLine }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'selectionSet'))) }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentDefinitionNode')))) {
		return 'fragment ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if !(rt.get_property(var_node, 'variableDefinitions')).is_null() { rt.get_property(var_node, 'variableDefinitions') } else { create_automattic_woocommerce_vendor_graphql_language_ast_nodelist(rt.new_array()) }), ', ')), ')')).str() + ' on ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(rt.get_property(var_node, 'typeCondition'), 'name')))).str() + ' ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ')), ' ')).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'selectionSet')))).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode')))) {
		return '...' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(' ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ')))).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: '...' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('on ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](if !(rt.get_property(rt.get_property(var_node, 'typeCondition'), 'name')).is_null() { rt.get_property(rt.get_property(var_node, 'typeCondition'), 'name') } else { rt.new_null() })))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'selectionSet'))) }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'input' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'fields'))) }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputObjectTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'extend input' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'fields'))) }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InputValueDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + ': ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'type')))).str() }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('= ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'defaultValue'))))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'interface' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('implements ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'interfaces')), ' & '))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'fields'))) }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InterfaceTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'extend interface' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('implements ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'interfaces')), ' & '))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'fields'))) }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListTypeNode')))) {
		return '[' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'type')))).str() + ']'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ListValueNode')))) {
		return '[' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'values')), ', ')).str() + ']'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NamedTypeNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'type')))).str() + '!'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NullValueNode')))) {
		return 'null'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'type' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('implements ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'interfaces')), ' & '))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'fields'))) }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'extend type' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('implements ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'interfaces')), ' & '))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'fields'))) }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ObjectValueNode')))) {
		return '{ ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'fields')), ', ')).str() + ' }'
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationDefinitionNode')))) {
		mut var_op := rt.get_property(var_node, 'operation')
		mut var_name := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))
		mut var_varDefs := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'variableDefinitions')), ', ')), ')')
		mut var_directives := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ')
		mut var_selectionSet := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'selectionSet')))
		return (if rt.is_true(rt.identical(var_name, rt.new_string(''))) && rt.is_true(rt.identical(var_directives, rt.new_string(''))) && rt.is_true(rt.identical(var_varDefs, rt.new_string(''))) && rt.is_true(rt.identical(var_op, rt.new_string('query'))) { var_selectionSet } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: var_op }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: var_name }, rt.ArrayItem{ key: none, val: var_varDefs }]))) }, rt.ArrayItem{ key: none, val: var_directives }, rt.ArrayItem{ key: none, val: var_selectionSet }])), ' ') }).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_OperationTypeDefinitionNode')))) {
		return (rt.get_property(var_node, 'operation')).str() + ': ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'type')))).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'scalar' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ScalarTypeExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'extend scalar' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'schema' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'operationTypes'))) }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'extend schema' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'operationTypes'))) }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SelectionSetNode')))) {
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'selections')))).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_StringValueNode')))) {
		if rt.is_true(rt.get_property(var_node, 'block')) {
			mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString{}
			mut iife_result_0 := iife_temp_0.print(rt.get_property(var_node, 'value'))
			return (iife_result_0).str()
		}
		return rt.json_encode(rt.get_property(var_node, 'value'))
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeDefinitionNode')))) {
		mut var_typesStr := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'types')), ' | ')
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'union' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_typesStr, rt.new_string(''))))) { "= ${var_typesStr.to_string()}" } else { '' } }])), ' ')).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_UnionTypeExtensionNode')))) {
		var_typesStr = Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'types')), ' | ')
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: 'extend union' }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name'))) }, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ') }, rt.ArrayItem{ key: none, val: if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_typesStr, rt.new_string(''))))) { "= ${var_typesStr.to_string()}" } else { '' } }])), ' ')).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableDefinitionNode')))) {
		return '$' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(rt.get_property(var_node, 'variable'), 'name')))).str() + ': ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'type')))).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(' = ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'defaultValue')))))).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(' ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ')))).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode')))) {
		return '$' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str()
	}
	return ''
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut var_list Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, separator string) string {
	mut var_parts := rt.new_array()
	mut iter_5 := var_list.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_item := item_5.val
		var_parts.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](var_item)))
	}
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_parts), separator)).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut var_list Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) string {
	if var_list.array_count() == 0 {
		return ''
	}
	mut var_parts := rt.new_array()
	mut iter_6 := var_list.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_item := item_6.val
		var_parts.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](var_item)))
	}
	return '{\n' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_parts), '\n')).str())).str() + '\n}'
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut var_description Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode, body string) string {
	return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](rt.create_array([rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut var_description) }, rt.ArrayItem{ key: none, val: body }])), '\n')).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(start string, mut var_maybeString Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string, end string) string {
	if rt.is_true(rt.identical(var_maybeString, rt.new_null())) || rt.is_true(rt.identical(var_maybeString, rt.new_string(''))) {
		return ''
	}
	return start + (var_maybeString).str() + end
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent(string string) string {
	if rt.is_true(rt.identical(rt.new_string(string), rt.new_string(''))) {
		return ''
	}
	return '  ' + (rt.call_function('str_replace', [rt.new_string('\n'), rt.new_string('\n  '), rt.new_string(string)])).str()
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut var_parts Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array, separator string) string {
	mut var_part := rt.new_null()
	mut var_parts_mutated := var_parts
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_part := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_part, rt.new_string(''))))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_part, rt.new_null())))))
		}
	return (rt.call_function('implode', [rt.new_string(separator), rt.call_function('array_filter', [var_parts_mutated, rt.new_closure(closure_2_fn)])])).str()
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_printer(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
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

fn create_automattic_woocommerce_vendor_graphql_language_blockstring(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'doPrint' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_Node](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.doprint(mut dispatch_arg_0))
		}
		'p' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut dispatch_arg_0))
		}
		'printList' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut dispatch_arg_0, dispatch_arg_1))
		}
		'printListBlock' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut dispatch_arg_0))
		}
		'addDescription' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut dispatch_arg_0, dispatch_arg_1))
		}
		'wrap' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'indent' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent(dispatch_arg_0))
		}
		'join' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_BlockString) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

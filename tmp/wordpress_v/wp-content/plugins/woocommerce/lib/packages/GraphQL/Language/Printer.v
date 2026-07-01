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
		{
			mut iter_1 := rt.get_property(var_node, 'arguments').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_arg := item_1.val
				var_argStrings.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](var_arg)))
			}
		}
		mut var_noIndent := rt.new_bool(rt.new_bool(true))
		{
			mut iter_1 := var_argStrings.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_argString := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_noIndent = rt.new_bool(rt.new_bool(false))
					break
				}
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
		{
			mut iter_1 := rt.get_property(var_node, 'arguments').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_item := item_1.val
				var_argStrings.array_push(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](var_item)))
			}
		}
		var_noIndent = rt.new_bool(rt.new_bool(true))
		{
			mut iter_1 := var_argStrings.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_argString := item_1.val
				if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
					var_noIndent = rt.new_bool(rt.new_bool(false))
					break
				}
			}
		}
		return (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode](rt.get_property(var_node, 'description')), (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))).str() + (if rt.is_true(var_noIndent) { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_argStrings), ', ')), ')') } else { Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(\n', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array](var_argStrings), '\n')).str())), '\n)') }).str() + ': ' + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'type')))).str() + (Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(' ', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'directives')), ' ')))).str())).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_bool(rt.instance_of(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Language_?Node', []string{}, var_node), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode')))) {
		mut var_prefix := rt.new_string(rt.concat(Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](if !(rt.get_property(rt.get_property(var_node, 'alias'), 'value')).is_null() { rt.get_property(rt.get_property(var_node, 'alias'), 'value') } else { rt.new_null() }), ': '), Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(var_node, 'name')))))
		mut var_argsLine := rt.new_string(rt.concat(var_prefix, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'arguments')), ', ')), ')')))
		if var_argsLine.dup().to_string().len > 80 {
			var_argsLine = rt.new_string(rt.concat(var_prefix, Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap('(\n', mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent((Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList](rt.get_property(var_node, 'arguments')), '\n')).str())), '\n)')))
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
		mut var_name := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.p(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?Node](rt.get_property(, 'name')))
		mut var_varDefs := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(, mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string](), )
		mut var_directives := 
		
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	} else if rt.is_true(rt.equal(switch_val_1, )) {
	}
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlist(mut var_list Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList, separator string) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.printlistblock(mut var_list Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.adddescription(mut var_description Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?StringValueNode, body string) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.wrap(start string, mut var_maybeString Class_Automattic_WooCommerce_Vendor_GraphQL_Language_?string, end string) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.indent(string string) string {
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer.join(mut var_parts Class_Automattic_WooCommerce_Vendor_GraphQL_Language_array, separator string) string {
	mut var_part := rt.new_null()
	mut var_parts_mutated := var_parts
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_language_printer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_ast_nodelist() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeList{
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




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_language_printer_php() {
	// unsupported statement: Stmt_Declare
}

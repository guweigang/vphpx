import rt

struct Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract_from_info(mut var_info Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo, mut var_args Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_result := Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](if !(rt.get_property(rt.get_property(var_info, 'fieldNodes').array_get(0), 'selectionSet')).is_null() { rt.get_property(rt.get_property(var_info, 'fieldNodes').array_get(0), 'selectionSet') } else { rt.new_null() }), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](rt.get_property(var_info, 'variableValues')), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](rt.get_property(var_info, 'fragments')))
	if !(!rt.is_true(var_args_mutated)) {
		var_result.array_set('__args', var_args_mutated.dup())
	}
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract(mut var_selection_set Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode, mut var_variable_values Class_Automattic_WooCommerce_Internal_Api_array, mut var_fragments Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), var_selection_set)) {
		return rt.new_array()
	}
	mut var_result := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_selection_set, 'selections').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_selection := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode'))) {
				mut var_field_name := rt.get_property(rt.get_property(var_selection, 'name'), 'value')
				var_result.array_set(var_field_name, Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.build_field_entry(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](var_selection), mut var_variable_values, mut var_fragments))
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_InlineFragmentNode'))) {
				mut var_type_name := rt.get_property(rt.get_property(rt.get_property(var_selection, 'typeCondition'), 'name'), 'value')
				mut var_key := rt.new_string('...' + (var_type_name).str())
				var_result.array_set(var_key, Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](rt.get_property(var_selection, 'selectionSet')), mut var_variable_values, mut var_fragments))
			} else if rt.is_true(rt.new_bool(rt.instance_of(var_selection, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FragmentSpreadNode'))) {
				mut var_fragment := if !(var_fragments.array_get(rt.get_property(rt.get_property(var_selection, 'name'), 'value'))).is_null() { var_fragments.array_get(rt.get_property(rt.get_property(var_selection, 'name'), 'value')) } else { rt.new_null() }
				if rt.is_true(rt.identical(rt.new_null(), var_fragment)) {
					continue
				}
				mut var_spread := Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](rt.get_property(var_fragment, 'selectionSet')), mut var_variable_values, mut var_fragments)
				var_result = Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.merge_selections(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_result), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_spread))
			}
		}
	}
	return var_result.dup()
}

fn Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.build_field_entry(mut var_field Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode, mut var_variable_values Class_Automattic_WooCommerce_Internal_Api_array, mut var_fragments Class_Automattic_WooCommerce_Internal_Api_array) bool {
	mut var_has_args := rt.new_bool(rt.new_bool(!(!rt.is_true(rt.get_property(var_field, 'arguments'))) && rt.get_property(var_field, 'arguments').array_count() > 0))
	mut var_has_sub_selection := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_has_args)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_has_sub_selection)))))) {
		return true
	}
	mut var_entry := rt.new_array()
	if rt.is_true(var_has_args) {
		mut var_args := rt.new_array()
		{
			mut iter_1 := rt.get_property(var_field, 'arguments').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_arg := item_1.val
				var_args.array_set(rt.get_property(rt.get_property(var_arg, 'name'), 'value'), Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.resolve_argument_value(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode](var_arg), mut var_variable_values))
			}
		}
		var_entry.array_set('__args', var_args.dup())
	}
	if rt.is_true(var_has_sub_selection) {
		mut var_sub := Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](rt.get_property(var_field, 'selectionSet')), mut var_variable_values, mut var_fragments)
		var_entry = Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.merge_selections(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_entry), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_sub))
	}
	return (var_entry).to_bool()
}

fn Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.merge_selections(mut var_a Class_Automattic_WooCommerce_Internal_Api_array, mut var_b Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	mut var_a_mutated := var_a
	{
		mut iter_1 := var_b.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_a_mutated.dup().array_isset(var_key.dup())))))) {
				var_a_mutated.array_set(var_key, var_value.dup())
				continue
			}
			mut var_existing := var_a_mutated.array_get(var_key)
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_existing.dup().is_array())) && rt.is_true(rt.new_bool(var_value.dup().is_array())))) {
				var_a_mutated.array_set(var_key, Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.merge_selections(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_existing), mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](var_value)))
			} else if rt.is_true(rt.new_bool(var_value.dup().is_array())) {
				var_a_mutated.array_set(var_key, var_value.dup())
			}
			// unsupported statement: Stmt_Nop
		}
	}
	return rt.new_object('Automattic_WooCommerce_Internal_Api_array', []string{}, var_a_mutated)
}

fn Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.resolve_argument_value(mut var_arg Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode, mut var_variable_values Class_Automattic_WooCommerce_Internal_Api_array) rt.PhpVal {
	mut var_value_node := rt.get_property(var_arg, 'value')
	if rt.is_true(rt.new_bool(rt.instance_of(var_value_node, 'Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_VariableNode'))) {
		return if !(var_variable_values.array_get(rt.get_property(rt.get_property(var_value_node, 'name'), 'value'))).is_null() { var_variable_values.array_get(rt.get_property(rt.get_property(var_value_node, 'name'), 'value')) } else { rt.new_null() }
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{}; return temp.valuefromastuntyped(arg_0, arg_1) }(var_value_node.dup(), rt.new_object('Automattic_WooCommerce_Internal_Api_array', []string{}, var_variable_values))
}

struct Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_api_queryinfoextractor() &Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_api_automattic_woocommerce_vendor_graphql_utils_ast() &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST {
	mut obj := &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'extract_from_info' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_ResolveInfo](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract_from_info(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'extract' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_?SelectionSetNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.extract(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'build_field_entry' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_FieldNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_bool(Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.build_field_entry(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'merge_selections' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.merge_selections(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		'resolve_argument_value' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ArgumentNode](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Api_array](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor.resolve_argument_value(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_QueryInfoExtractor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Api_Automattic_WooCommerce_Vendor_GraphQL_Utils_AST) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_api_queryinfoextractor_php() {
	// unsupported statement: Stmt_Declare
}

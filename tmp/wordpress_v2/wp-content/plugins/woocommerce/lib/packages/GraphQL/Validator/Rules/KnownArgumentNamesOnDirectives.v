import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives.unknowndirectiveargmessage(argName string, directiveName string, mut var_suggestedArgs Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array) string {
	mut var_message :=
		rt.new_string("Unknown argument \"${var_argName}\" on directive \"@${var_directiveName}\".")
	if var_suggestedArgs.array_isset(rt.new_int(0)) {
		mut iife_temp_0 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
		mut iife_result_0 := iife_temp_0.quotedorlist(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array',
			[]string{}, var_suggestedArgs))
		mut var_suggestions := iife_result_0
		var_message = rt.concat(var_message,
			rt.new_string(' Did you mean ${var_suggestions.to_string()}?'))
	}
	return var_message.str()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) getastvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext) rt.PhpVal {
	mut var_directiveArgs := rt.new_array()
	mut var_schema := var_context.getschema()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
	mut iife_result_1 := iife_temp_1.getinternaldirectives()
	mut var_definedDirectives := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_schema,
		rt.new_null()))))
	{
		rt.call_method(var_schema, 'getDirectives', []rt.PhpVal{})
	} else {
		iife_result_1
	}
	mut iter_1 := var_definedDirectives.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_directive := item_1.val
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_arg := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.get_property(var_arg, 'name')
		}
		closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_arg := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.get_property(var_arg, 'name')
		}
		var_directiveArgs.array_set(rt.get_property(var_directive, 'name'), rt.call_function('array_map', [
			rt.new_closure(closure_3_fn),
			rt.get_property(var_directive, 'args'),
		]))
	}
	mut var_astDefinitions := rt.get_property(var_context.getdocument(), 'definitions')
	mut iter_2 := var_astDefinitions.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_def := item_2.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_def,
			'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode')))
		{
			mut var_argNames := rt.new_array()
			mut iter_3 := rt.get_property(var_def, 'arguments').iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_arg := item_3.val
				var_argNames.array_push(rt.get_property(rt.get_property(var_arg, 'name'), 'value'))
			}
			var_directiveArgs.array_set(rt.get_property(rt.get_property(var_def, 'name'), 'value'),
				var_argNames.clone())
		}
	}
	closure_8_fn := fn [var_directiveArgs, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_directiveNode := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_directiveName := (rt.get_property(rt.get_property(var_directiveNode, 'name'),
			'value')).str()
		if !(var_directiveArgs.array_isset(rt.new_string(var_directiveName.str()))) {
			mut iife_temp_5 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
			mut iife_result_5 := iife_temp_5.skipnode()
			return iife_result_5
		}
		mut var_knownArgs := var_directiveArgs.array_get(rt.new_string(var_directiveName.str()))
		mut iter_4 := rt.get_property(var_directiveNode, 'arguments').iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_argNode := item_4.val
			mut var_argName :=
				(rt.get_property(rt.get_property(var_argNode, 'name'), 'value')).str()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				rt.new_string(var_argName.str()).clone(),
				var_knownArgs.clone(),
				rt.new_bool(true),
			])))))
			{
				mut iife_temp_6 := Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{}
				mut iife_result_6 := iife_temp_6.suggestionlist(rt.new_string(var_argName.str()),
					var_knownArgs.clone())
				mut var_suggestions := iife_result_6
				var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives.unknowndirectiveargmessage(var_argName,
					var_directiveName, mut
					rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](var_suggestions)), rt.create_array([
					rt.ArrayItem{ key: none, val: var_argNode },
				])))
			}
		}
		mut iife_temp_7 := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
		mut iife_result_7 := iife_temp_7.skipnode()
		return iife_result_7
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.directive()
			val: rt.new_closure(closure_8_fn)
		},
	])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_knownargumentnamesondirectives(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_utils_utils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitor(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'unknownDirectiveArgMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives.unknowndirectiveargmessage(dispatch_arg_0,
				dispatch_arg_1, mut dispatch_arg_2))
		}
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'getASTVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getastvisitor(mut dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_KnownArgumentNamesOnDirectives) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Utils_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

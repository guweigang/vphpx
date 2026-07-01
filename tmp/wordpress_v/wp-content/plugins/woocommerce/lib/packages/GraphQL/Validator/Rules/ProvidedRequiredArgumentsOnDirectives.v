import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives.missingdirectiveargmessage(directiveName string, argName string, type string) string {
	return "Directive \"@${var_directiveName}\" argument \"${var_argName}\" of type \"${var_type}\" is required but not provided."
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) getastvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext) rt.PhpVal {
	mut var_requiredArgsMap := rt.new_array()
	mut var_schema := var_context.getschema()
	mut var_definedDirectives := if rt.is_true(rt.identical(var_schema, rt.new_null())) {
		fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}
			return temp.getinternaldirectives()
		}()
	} else {
		rt.call_method(var_schema, 'getDirectives', []rt.PhpVal{})
	}
	{
		mut iter_1 := var_definedDirectives.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directive := item_1.val
			mut var_directiveArgs := rt.new_array()
			{
				mut iter_2 := rt.get_property(var_directive, 'args').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_arg := item_2.val
					if rt.is_true(rt.call_method(var_arg, 'isRequired', []rt.PhpVal{})) {
						var_directiveArgs.array_set(rt.get_property(var_arg, 'name'), var_arg.dup())
					}
				}
			}
			var_requiredArgsMap.array_set(rt.get_property(var_directive, 'name'),
				var_directiveArgs.dup())
		}
	}
	mut var_astDefinition := rt.get_property(var_context.getdocument(), 'definitions')
	{
		mut iter_1 := var_astDefinition.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_def := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_def,
				'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode')))
			{
				mut var_arguments := rt.get_property(var_def, 'arguments')
				mut var_requiredArgs := rt.new_array()
				{
					mut iter_2 := var_arguments.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_argument := item_2.val
						if rt.is_true(rt.new_bool(
							rt.is_true(rt.new_bool(rt.instance_of(rt.get_property(var_argument, 'type'), 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NonNullTypeNode')))
							&& !(!(rt.get_property(var_argument, 'defaultValue')).is_null())))
						{
							var_requiredArgs.array_set(rt.get_property(rt.get_property(var_argument,
								'name'), 'value'), var_argument.dup())
						}
					}
				}
				var_requiredArgsMap.array_set(rt.get_property(rt.get_property(var_def, 'name'),
					'value'), var_requiredArgs.dup())
			}
		}
	}
	closure_1_fn := fn [var_requiredArgsMap, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_directiveNode := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_directiveName := (rt.get_property(rt.get_property(var_directiveNode, 'name'),
			'value')).str()
		mut var_requiredArgs := if !(var_requiredArgsMap.array_get(var_directiveName)).is_null() {
			var_requiredArgsMap.array_get(var_directiveName)
		} else {
			rt.new_null()
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_requiredArgs, rt.new_null()))
			|| rt.is_true(rt.identical(var_requiredArgs, rt.new_array()))))
		{
			return rt.new_null()
		}
		mut var_argNodeMap := rt.new_array()
		{
			mut iter_1 := rt.get_property(var_directiveNode, 'arguments').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_arg := item_1.val
				var_argNodeMap.array_set(rt.get_property(rt.get_property(var_arg, 'name'), 'value'),
					var_arg.dup())
			}
		}
		{
			mut iter_1 := var_requiredArgs.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_arg := item_1.val
				mut var_argName := item_1.key
				if !(var_argNodeMap.array_isset(var_argName)) {
					mut var_argType := if rt.is_true(rt.new_bool(rt.instance_of(var_arg,
						'Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Argument')))
					{
						rt.call_method(rt.call_method(var_arg, 'getType', []rt.PhpVal{}),
							'toString', []rt.PhpVal{})
					} else {
						fn (arg_0 rt.PhpVal) rt.PhpVal {
							mut temp :=
								Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{}
							return temp.doprint(arg_0)
						}(rt.get_property(var_arg, 'type'))
					}
					var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives.missingdirectiveargmessage(var_directiveName,
						var_argName.str(), var_argType.str()), rt.create_array([
						rt.ArrayItem{ key: none, val: var_directiveNode },
					])))
				}
			}
		}
		return rt.new_null()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.directive()
			val: rt.create_array([
				rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_1_fn) },
			])
		},
	])
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_providedrequiredargumentsondirectives() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_directive() &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_printer() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'missingDirectiveArgMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives.missingdirectiveargmessage(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
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

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ProvidedRequiredArgumentsOnDirectives) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Printer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_providedrequiredargumentsondirectives_php() {
	// unsupported statement: Stmt_Declare
}

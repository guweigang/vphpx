import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation) getastvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext) rt.PhpVal {
	mut var_uniqueDirectiveMap := rt.new_array()
	mut var_schema := var_context.getschema()
	mut var_definedDirectives := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_method(var_schema, 'getDirectives', []rt.PhpVal{}) } else { fn () rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive{}; return temp.getinternaldirectives() }() }
	{
		mut iter_1 := var_definedDirectives.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directive := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_directive, 'isRepeatable'))))) {
				var_uniqueDirectiveMap.array_set(rt.get_property(var_directive, 'name'), true)
			}
		}
	}
	mut var_astDefinitions := rt.get_property(var_context.getdocument(), 'definitions')
	{
		mut iter_1 := var_astDefinitions.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_definition := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_DirectiveDefinitionNode'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_definition, 'repeatable'))))))) {
				var_uniqueDirectiveMap.array_set(rt.get_property(rt.get_property(var_definition, 'name'), 'value'), true)
			}
		}
	}
	closure_1_fn := fn [var_uniqueDirectiveMap, var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('property_exists', [var_node.dup(), rt.new_string('directives')]))))) {
		return rt.new_null()
	}
	mut var_knownDirectives := rt.new_array()
	{
		mut iter_1 := rt.get_property(var_node, 'directives').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_directive := item_1.val
			mut var_directiveName := rt.get_property(rt.get_property(var_directive, 'name'), 'value')
			if var_uniqueDirectiveMap.array_isset(var_directiveName) {
				if var_knownDirectives.array_isset(var_directiveName) {
					var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation.duplicatedirectivemessage((var_directiveName).str()), rt.create_array([rt.ArrayItem{ key: none, val: var_knownDirectives.array_get(var_directiveName) }, rt.ArrayItem{ key: none, val: var_directive }])))
				} else {
					var_knownDirectives.array_set(var_directiveName, var_directive.dup())
				}
			}
		}
	}
	return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'enter', val: rt.new_closure(closure_1_fn) }])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation.duplicatedirectivemessage(directiveName string) string {
	return "The directive \"${var_directiveName}\" can only be used once at this location."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Directive {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_uniquedirectivesperlocation() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation{
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

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getvisitor(mut dispatch_arg_0)
		}
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		'getASTVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext](if args.len > 0 { args[0] } else { rt.new_null() })
			return this.getastvisitor(mut dispatch_arg_0)
		}
		'duplicateDirectiveMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation.duplicatedirectivemessage(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueDirectivesPerLocation) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_uniquedirectivesperlocation_php() {
	// unsupported statement: Stmt_Declare
}

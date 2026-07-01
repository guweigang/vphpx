import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames {
	rt.PhpObjectBase
pub mut:
	knownVariableNames rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	this.knownVariableNames = rt.new_array()
	closure_2_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			this.knownVariableNames = rt.new_array()
			return rt.new_null()
		}
		mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_variableName := rt.get_property(rt.get_property(rt.get_property(var_node,
			'variable'), 'name'), 'value')
		if !(this.knownVariableNames.array_isset(var_variableName)) {
			this.knownVariableNames.array_set(var_variableName, rt.get_property(rt.get_property(var_node,
				'variable'), 'name'))
		} else {
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames.duplicatevariablemessage(var_variableName.str()), rt.create_array([
				rt.ArrayItem{ key: none, val: this.knownVariableNames.array_get(var_variableName) },
				rt.ArrayItem{ key: none, val: rt.get_property(rt.get_property(var_node, 'variable'),
					'name') },
			])))
		}
		return rt.new_null()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.operation_definition()
			val: rt.new_closure(closure_1_fn)
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.variable_definition()
			val: rt.new_closure(closure_2_fn)
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames.duplicatevariablemessage(variableName string) string {
	return "There can be only one variable named \"${var_variableName}\"."
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_uniquevariablenames() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames{
		PhpObjectBase:      rt.PhpObjectBase{}
		knownVariableNames: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_validationrule() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'duplicateVariableMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames.duplicatevariablemessage(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'knownVariableNames' { return this.knownVariableNames }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueVariableNames) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'knownVariableNames' {
			this.knownVariableNames = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_uniquevariablenames_php() {
	// unsupported statement: Stmt_Declare
}

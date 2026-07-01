import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		{
			mut iter_1 := rt.get_property(var_node, 'definitions').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_definition := item_1.val
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_definition,
					'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_ExecutableDefinitionNode'))))))
				{
					if rt.is_true(rt.new_bool(
						rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaDefinitionNode')))
						|| rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_SchemaExtensionNode')))))
					{
						mut var_defName := rt.new_string(rt.new_string('schema'))
					} else {
						rt.call_function('assert', [
							rt.new_bool(
								rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeDefinitionNode')))
								|| rt.is_true(rt.new_bool(rt.instance_of(var_definition, 'Automattic_WooCommerce_Vendor_GraphQL_Language_AST_TypeExtensionNode')))),
							rt.new_string('only other option'),
						])
						var_defName = rt.new_string(rt.concat(rt.concat(rt.new_string('"'), rt.get_property(rt.call_method(var_definition,
							'getName', []rt.PhpVal{}), 'value')), rt.new_string('"')))
					}
					var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions.nonexecutabledefinitionmessage(var_defName.str()), rt.create_array([
						rt.ArrayItem{ key: none, val: var_definition },
					])))
				}
			}
		}
		return fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
			return temp.skipnode()
		}()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.document()
			val: rt.new_closure(closure_1_fn)
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions.nonexecutabledefinitionmessage(defName string) string {
	return 'The ${var_defName} definition is not executable.'
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ValidationRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_executabledefinitions() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions{
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

fn create_automattic_woocommerce_vendor_graphql_error_error() &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_language_visitor() &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'nonExecutableDefinitionMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions.nonexecutabledefinitionmessage(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_ExecutableDefinitions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_executabledefinitions_php() {
	// unsupported statement: Stmt_Declare
}

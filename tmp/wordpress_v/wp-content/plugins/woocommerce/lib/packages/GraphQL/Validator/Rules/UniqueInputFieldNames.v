import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames {
	rt.PhpObjectBase
pub mut:
	knownNames     rt.PhpVal = rt.new_null()
	knownNameStack rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames) getsdlvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext) rt.PhpVal {
	return this.getastvisitor(mut var_context)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames) getastvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext) rt.PhpVal {
	this.knownNames = rt.new_array()
	this.knownNameStack = rt.new_array()
	closure_3_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				this.knownNameStack.array_push(this.knownNames)
				this.knownNames = rt.new_array()
				return rt.new_null()
			}
			mut var_knownNames := rt.call_function('array_pop', [this.knownNameStack])
			rt.call_function('assert', [rt.new_bool(var_knownNames.dup().is_array()),
				rt.new_string('should not happen if the visitor works correctly')])
			this.knownNames = var_knownNames.dup()
			return rt.new_null()
		}
		mut var_node := if args.len > 0 { args[0].dup() } else { rt.new_null() }
		mut var_fieldName := rt.get_property(rt.get_property(var_node, 'name'), 'value')
		if this.knownNames.array_isset(var_fieldName) {
			var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames.duplicateinputfieldmessage(var_fieldName.str()), rt.create_array([
				rt.ArrayItem{ key: none, val: this.knownNames.array_get(var_fieldName) },
				rt.ArrayItem{ key: none, val: rt.get_property(var_node, 'name') },
			])))
		} else {
			this.knownNames.array_set(var_fieldName, rt.get_property(var_node, 'name'))
		}
		return fn () rt.PhpVal {
			mut temp := Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor{}
			return temp.skipnode()
		}()
	}
	return rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object()
			val: rt.create_array([
				rt.ArrayItem{ key: 'enter', val: rt.new_closure(closure_1_fn) },
				rt.ArrayItem{ key: 'leave', val: rt.new_closure(closure_2_fn) },
			])
		},
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.object_field()
			val: rt.new_closure(closure_3_fn)
		},
	])
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames.duplicateinputfieldmessage(fieldName string) string {
	return "There can be only one input field named \"${var_fieldName}\"."
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

fn create_automattic_woocommerce_vendor_graphql_validator_rules_uniqueinputfieldnames() &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames{
		PhpObjectBase:  rt.PhpObjectBase{}
		knownNames:     rt.new_null()
		knownNameStack: rt.new_null()
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'getSDLVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_SDLValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getsdlvisitor(mut dispatch_arg_0)
		}
		'getASTVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_ValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getastvisitor(mut dispatch_arg_0)
		}
		'duplicateInputFieldMessage' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames.duplicateinputfieldmessage(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'knownNames' { return this.knownNames }
		'knownNameStack' { return this.knownNameStack }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_UniqueInputFieldNames) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'knownNames' {
			this.knownNames = val
			return true
		}
		'knownNameStack' {
			this.knownNameStack = val
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Language_Visitor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_validator_rules_uniqueinputfieldnames_php() {
	// unsupported statement: Stmt_Declare
}

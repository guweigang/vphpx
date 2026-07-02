import rt

pub fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection.enabled() i64 {
	return 1
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection {
	rt.PhpObjectBase
pub mut:
	isEnabled i64
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) construct(enabled i64) {
	this.setenabled(enabled)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) setenabled(enabled i64) {
	this.isEnabled = enabled
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) getvisitor(mut var_context Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext) rt.PhpVal {
	closure_1_fn := fn [var_context] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_node := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(rt.get_property(var_node, 'name'), 'value'), rt.new_string('__type')))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(rt.get_property(var_node, 'name'), 'value'), rt.new_string('__schema'))))) {
			return rt.new_null()
		}
		var_context.reporterror(create_automattic_woocommerce_vendor_graphql_error_error(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection.introspectiondisabledmessage(), rt.create_array([
			rt.ArrayItem{ key: none, val: var_node },
		])))
		return rt.new_null()
	}
	return this.invokeifneeded(rt.new_object('Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext',
		[]string{}, var_context), rt.create_array([
		rt.ArrayItem{
			key: Class_Automattic_WooCommerce_Vendor_GraphQL_Language_AST_NodeKind.field()
			val: rt.new_closure(closure_1_fn)
		},
	]))
}

fn Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection.introspectiondisabledmessage() string {
	return 'Automattic\\WooCommerce\\Vendor\\GraphQL introspection is not allowed, but the query contained __schema or __type'
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) isenabled() bool {
	return rt.new_bool(!rt.is_true(rt.identical(this.isEnabled,
		Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection.disabled())))
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Error_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_disableintrospection(enabled i64) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection{
		PhpObjectBase: rt.PhpObjectBase{}
		isEnabled:     i64(0)
	}
	obj.construct(enabled)
	return obj
}

fn create_automattic_woocommerce_vendor_graphql_validator_rules_querysecurityrule(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule{
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

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'setEnabled' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.setenabled(dispatch_arg_0)
			return rt.new_null()
		}
		'getVisitor' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_QueryValidationContext](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.getvisitor(mut dispatch_arg_0)
		}
		'introspectionDisabledMessage' {
			return rt.new_string(Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection.introspectiondisabledmessage())
		}
		'isEnabled' {
			return rt.new_bool(this.isenabled())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'isEnabled' { return rt.new_int(this.isEnabled) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_DisableIntrospection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'isEnabled' {
			this.isEnabled = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Validator_Rules_QuerySecurityRule) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

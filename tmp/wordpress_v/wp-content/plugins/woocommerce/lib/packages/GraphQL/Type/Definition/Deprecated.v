import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated {
	rt.PhpObjectBase
pub mut:
	reason string
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated) construct(reason string) {
	this.reason = reason
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_deprecated(reason string) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated{
		PhpObjectBase: rt.PhpObjectBase{}
		reason:        ''
	}
	obj.construct(reason)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'reason' { return rt.new_string(this.reason) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Deprecated) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'reason' {
			this.reason = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_deprecated_php() {
	// unsupported statement: Stmt_Declare
}

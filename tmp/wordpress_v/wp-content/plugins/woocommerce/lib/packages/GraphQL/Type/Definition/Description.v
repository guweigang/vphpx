import rt

struct Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description {
	rt.PhpObjectBase
pub mut:
	description string
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description) construct(description string) {
	this.description = description
}

fn create_automattic_woocommerce_vendor_graphql_type_definition_description(description string) &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description {
	mut obj := &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description{
		PhpObjectBase: rt.PhpObjectBase{}
		description:   ''
	}
	obj.construct(description)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'description' { return rt.new_string(this.description) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Vendor_GraphQL_Type_Definition_Description) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'description' {
			this.description = val.str()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_lib_packages_graphql_type_definition_description_php() {
	// unsupported statement: Stmt_Declare
}

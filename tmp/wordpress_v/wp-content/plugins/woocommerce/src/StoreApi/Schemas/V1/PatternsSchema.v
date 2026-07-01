import rt

pub fn Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema.identifier() string {
	return 'patterns'
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema {
	rt.PhpObjectBase
pub mut:
	title rt.PhpVal = rt.new_string('patterns')
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema) get_properties() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema) get_item_response(var_item rt.PhpVal) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'success', val: true }])
}

struct Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_storeapi_schemas_v1_patternsschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema{
		PhpObjectBase: rt.PhpObjectBase{}
		title:         rt.new_string('patterns')
	}
	return obj
}

fn create_automattic_woocommerce_storeapi_schemas_v1_abstractschema() &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema {
	mut obj := &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_properties' {
			return this.get_properties()
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_response(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'title' { return this.title }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_PatternsSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'title' {
			this.title = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_StoreApi_Schemas_V1_AbstractSchema) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_storeapi_schemas_v1_patternsschema_php() {
	// unsupported statement: Stmt_Declare
}

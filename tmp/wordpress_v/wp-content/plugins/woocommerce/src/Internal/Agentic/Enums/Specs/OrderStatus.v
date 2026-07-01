import rt

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.created() string {
	return 'created'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.manual_review() string {
	return 'manual_review'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.confirmed() string {
	return 'confirmed'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.canceled() string {
	return 'canceled'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.shipped() string {
	return 'shipped'
}

pub fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.fulfilled() string {
	return 'fulfilled'
}

struct Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.get_all() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.created()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.manual_review()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.confirmed()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.canceled()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.shipped()
		},
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.fulfilled()
		},
	])
}

fn Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.is_valid(var_status rt.PhpVal) rt.PhpVal {
	return rt.call_function('in_array', [var_status.dup(),
		Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.get_all(),
		rt.new_bool(true)])
}

fn create_automattic_woocommerce_internal_agentic_enums_specs_orderstatus() &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus {
	mut obj := &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_all' {
			return Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.get_all()
		}
		'is_valid' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus.is_valid(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Agentic_Enums_Specs_OrderStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_internal_agentic_enums_specs_orderstatus_php() {
	// unsupported statement: Stmt_Declare
}

import rt

struct Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution) construct()  {
	this.set_fields_and_prefix()
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution) format_meta_data(mut var_meta Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array)  {
	mut var_meta_mutated := var_meta
	if rt.is_true(rt.new_bool(var_meta_mutated.dup().array_isset(rt.new_string('device_type')))) {
		mut switch_val_1 := var_meta_mutated.array_get('device_type')
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('Mobile'))) {
			var_meta_mutated.array_set('device_type', rt.call_function('__', [rt.new_string('Mobile'), rt.new_string('woocommerce')]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('Tablet'))) {
			var_meta_mutated.array_set('device_type', rt.call_function('__', [rt.new_string('Tablet'), rt.new_string('woocommerce')]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('Desktop'))) {
			var_meta_mutated.array_set('device_type', rt.call_function('__', [rt.new_string('Desktop'), rt.new_string('woocommerce')]))
		} else {
			var_meta_mutated.array_set('device_type', rt.call_function('__', [rt.new_string('Unknown'), rt.new_string('woocommerce')]))
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution) output(mut var_order Class_WC_Order)  {
	mut var_meta := this.filter_meta_data(var_order.get_meta_data())
	this.format_meta_data(mut rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](var_meta))
	mut var_has_more_details := // unsupported expression: Expr_BinaryOp_NotIdentical
	mut var_simple_sources := rt.create_array([rt.ArrayItem{ key: none, val: 'typein' }, rt.ArrayItem{ key: none, val: 'admin' }, rt.ArrayItem{ key: none, val: 'mobile_app' }, rt.ArrayItem{ key: none, val: 'pos' }])
	if rt.is_true(rt.new_bool(var_meta.array_isset(rt.new_string('source_type')) && rt.is_true(rt.call_function('in_array', [var_meta.array_get('source_type'), var_simple_sources.dup(), rt.new_bool(true)])))) {
		var_has_more_details = rt.new_bool(rt.new_bool(false))
	}
	mut var_template_data := rt.create_array([rt.ArrayItem{ key: 'meta', val: var_meta }, rt.ArrayItem{ key: 'has_more_details', val: var_has_more_details }])
	rt.call_function('wc_get_template', [rt.new_string('order/attribution-details.php'), var_template_data.dup()])
}

fn create_automattic_woocommerce_internal_admin_orders_metaboxes_orderattribution() &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'format_meta_data' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_array](if args.len > 0 { args[0] } else { rt.new_null() })
			this.format_meta_data(mut dispatch_arg_0)
			return rt.new_null()
		}
		'output' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 { args[0] } else { rt.new_null() })
			this.output(mut dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_Orders_MetaBoxes_OrderAttribution) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_internal_admin_orders_metaboxes_orderattribution_php() {
	// unsupported statement: Stmt_Declare
}

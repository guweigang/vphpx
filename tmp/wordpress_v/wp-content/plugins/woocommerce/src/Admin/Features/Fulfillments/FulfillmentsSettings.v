import rt

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) register()  {
	rt.call_function('add_filter', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'init_settings_auto_fulfill' }])])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_processing'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'auto_fulfill_items_on_processing' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('woocommerce_order_status_completed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'auto_fulfill_items_on_completed' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) init_settings_auto_fulfill()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_settings_products'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_auto_fulfill_settings' }]), rt.new_int(10), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) add_auto_fulfill_settings(mut var_settings Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array, var_current_section rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_current_section)) {
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_array', []string{}, var_settings)
	}
	mut var_insertion_index := rt.new_null()
	{
		mut iter_1 := var_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_setting := item_1.val
			mut var_index := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_setting.array_isset(rt.new_string('type')) && var_setting.array_isset(rt.new_string('id')) && rt.is_true(rt.identical(rt.new_string('sectionend'), var_setting.array_get('type'))))) && rt.is_true(rt.identical(rt.new_string('catalog_options'), var_setting.array_get('id'))))) {
				var_insertion_index = rt.add(var_index, rt.new_int(1))
				break
			}
		}
	}
	if rt.is_true(rt.new_bool(var_insertion_index.dup().is_null())) {
		return rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_array', []string{}, var_settings)
		// unsupported statement: Stmt_Nop
	}
	mut var_auto_fulfill_settings := rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: 'Auto-fulfill items' }, rt.ArrayItem{ key: 'desc', val: '' }, rt.ArrayItem{ key: 'type', val: 'title' }, rt.ArrayItem{ key: 'id', val: 'auto_fulfill_options' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: 'Virtual and downloadable items' }, rt.ArrayItem{ key: 'desc', val: 'Automatically mark downloadable items as fulfilled when the order is created.' }, rt.ArrayItem{ key: 'id', val: 'auto_fulfill_downloadable' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'checkboxgroup', val: 'start' }, rt.ArrayItem{ key: 'default', val: 'yes' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'title', val: 'Auto-fulfill items' }, rt.ArrayItem{ key: 'desc', val: 'Automatically mark virtual (non-downloadable) items as fulfilled when the order is created.' }, rt.ArrayItem{ key: 'id', val: 'auto_fulfill_virtual' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'checkboxgroup', val: 'end' }, rt.ArrayItem{ key: 'default', val: 'no' }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'sectionend' }, rt.ArrayItem{ key: 'id', val: 'auto_fulfill_options' }]) }])
	rt.call_function('array_splice', [var_settings, var_insertion_index.dup(), rt.new_int(0), var_auto_fulfill_settings.dup()])
	return rt.new_object('Automattic_WooCommerce_Admin_Features_Fulfillments_array', []string{}, var_settings)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) auto_fulfill_items_on_processing(order_id i64, var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	var_order_mutated = if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) { var_order_mutated } else { rt.call_function('wc_get_order', [rt.new_int(order_id)]) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) || !rt.is_true(rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{})))) {
		return rt.new_null()
	}
	mut var_auto_fulfill_downloadable := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('auto_fulfill_downloadable'), rt.new_string('yes')]))
	mut var_auto_fulfill_virtual := rt.identical(rt.new_string('yes'), rt.call_function('get_option', [rt.new_string('auto_fulfill_virtual'), rt.new_string('no')]))
	mut var_auto_fulfill_product_ids := rt.call_function('apply_filters', [rt.new_string('woocommerce_fulfillments_auto_fulfill_products'), rt.new_array(), var_order_mutated.dup()])
	mut var_auto_fulfill_items := rt.new_array()
	{
		mut iter_1 := rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			mut var_product := rt.call_method(var_item, 'get_product', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_product)))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_downloadable', []rt.PhpVal{})) && rt.is_true(var_auto_fulfill_downloadable))) || rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_product, 'is_virtual', []rt.PhpVal{})) && rt.is_true(var_auto_fulfill_virtual))))) || rt.is_true(rt.call_function('in_array', [rt.call_method(var_product, 'get_id', []rt.PhpVal{}), var_auto_fulfill_product_ids.dup(), rt.new_bool(true)])))) {
				var_auto_fulfill_items.array_push(var_item.dup())
			}
		}
	}
	if !(!rt.is_true(var_auto_fulfill_items)) {
		mut var_fulfillment := create_automattic_woocommerce_admin_features_fulfillments_fulfillment()
		var_fulfillment.set_entity_type(Class_WC_Order.class())
		var_fulfillment.set_entity_id(// unsupported expression: Expr_Cast_String)
		var_fulfillment.set_status(rt.new_string('fulfilled'))
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'qty', val: rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}) }])
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.create_array([rt.ArrayItem{ key: 'item_id', val: rt.call_method(var_item, 'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'qty', val: rt.call_method(var_item, 'get_quantity', []rt.PhpVal{}) }])
	}
		var_fulfillment.set_items(rt.call_function('array_map', [rt.new_closure(closure_1_fn), var_auto_fulfill_items.dup()]))
		var_fulfillment.save()
	}
	rt.call_method(var_order_mutated, 'update_meta_data', [rt.new_string('_auto_fulfill_processed'), rt.new_bool(true)])
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) auto_fulfill_items_on_completed(order_id i64, var_order rt.PhpVal)  {
	mut var_order_mutated := var_order
	var_order_mutated = if rt.is_true(rt.new_bool(rt.instance_of(var_order_mutated, 'WC_Order'))) { var_order_mutated } else { rt.call_function('wc_get_order', [rt.new_int(order_id)]) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order_mutated)))) || !rt.is_true(rt.call_method(var_order_mutated, 'get_items', []rt.PhpVal{})))) {
		return rt.new_null()
	}
	if rt.is_true(rt.call_method(var_order_mutated, 'get_meta', [rt.new_string('_auto_fulfill_processed'), rt.new_bool(true)])) {
		return rt.new_null()
	}
	mut var_fulfillment_data_store := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{}; return temp.load(arg_0) }(rt.new_string('order-fulfillment'))
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	mut var_fulfillments := rt.call_method(var_fulfillment_data_store, 'read_fulfillments', [Class_WC_Order.class(), // unsupported expression: Expr_Cast_String])
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	if !(!rt.is_true(var_fulfillments)) {
		return rt.new_null()
	}
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Automattic_WooCommerce_Admin_Features_Fulfillments_Throwable') {
		mut var_e := var_e_1.dup()
		rt.call_method(rt.call_function('wc_get_logger', []rt.PhpVal{}), 'error', [rt.call_function('sprintf', [rt.new_string('Failed to load fulfillments for order %d: %s'), rt.new_int(order_id), rt.call_method(var_e, 'getMessage', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'source', val: 'fulfillments' }])])
		return rt.new_null()
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	this.auto_fulfill_items_on_processing(order_id, var_order_mutated.dup())
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillmentssettings() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_fulfillment() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_features_fulfillments_wc_data_store() &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store {
	mut obj := &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			this.register()
			return rt.new_null()
		}
		'init_settings_auto_fulfill' {
			this.init_settings_auto_fulfill()
			return rt.new_null()
		}
		'add_auto_fulfill_settings' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Admin_Features_Fulfillments_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_auto_fulfill_settings(mut dispatch_arg_0, dispatch_arg_1)
		}
		'auto_fulfill_items_on_processing' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.auto_fulfill_items_on_processing(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'auto_fulfill_items_on_completed' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.auto_fulfill_items_on_completed(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_FulfillmentsSettings) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_Fulfillment) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Features_Fulfillments_WC_Data_Store) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_features_fulfillments_fulfillmentssettings_php() {
	// unsupported statement: Stmt_Declare
}

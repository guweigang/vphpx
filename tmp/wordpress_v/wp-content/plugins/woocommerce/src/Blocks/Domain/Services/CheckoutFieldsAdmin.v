import rt

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin {
	rt.PhpObjectBase
pub mut:
		checkout_fields_controller rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) construct(mut var_checkout_fields_controller Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields)  {
	this.checkout_fields_controller = var_checkout_fields_controller.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) init()  {
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_billing_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_address_fields' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_billing_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_contact_fields' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shipping_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_address_fields' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('woocommerce_admin_shipping_fields'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'admin_order_fields' }]), rt.new_int(10), rt.new_int(3)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) format_field_for_meta_box(var_field rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_formatted_field := rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }, rt.ArrayItem{ key: 'label', val: var_field.array_get('label') }, rt.ArrayItem{ key: 'value', val: var_field.array_get('value') }, rt.ArrayItem{ key: 'type', val: var_field.array_get('type') }, rt.ArrayItem{ key: 'update_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'update_callback' }]) }, rt.ArrayItem{ key: 'show', val: true }, rt.ArrayItem{ key: 'wrapper_class', val: 'form-field-wide' }])
	if rt.is_true(rt.identical(rt.new_string('select'), var_field.array_get('type'))) {
		var_formatted_field.array_set('options', rt.call_function('array_column', [var_field.array_get('options'), rt.new_string('label'), rt.new_string('value')]))
	}
	if rt.is_true(rt.identical(rt.new_string('checkbox'), var_field.array_get('type'))) {
		var_formatted_field.array_set('checked_value', '1')
		var_formatted_field.array_set('unchecked_value', '0')
	}
	return var_formatted_field.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) update_callback(var_key rt.PhpVal, var_value rt.PhpVal, var_order rt.PhpVal)  {
	// unsupported assign target: Expr_List
	mut var_group := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{}; return temp.get_group_name(arg_0) }(var_group.dup())
	rt.call_method(this.checkout_fields_controller, 'persist_field_for_order', [var_key.dup(), var_value.dup(), var_order.dup(), var_group.dup(), rt.new_bool(false)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) admin_address_fields(var_fields rt.PhpVal, var_order rt.PhpVal, context string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'Automattic_WooCommerce_Blocks_Domain_Services_WC_Order')))))) {
		return var_fields.dup()
	}
	mut var_group_name := rt.new_string(if rt.is_true(rt.call_function('doing_action', [rt.new_string('woocommerce_admin_billing_fields')])) { rt.new_string('billing') } else { rt.new_string('shipping') })
	mut var_additional_fields := rt.call_method(this.checkout_fields_controller, 'get_order_additional_fields_with_values', [var_order.dup(), rt.new_string('address'), var_group_name.dup(), rt.new_string(context)])
	{
		mut iter_1 := var_additional_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			mut var_prefixed_key := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{}; return temp.get_group_key(arg_0) }(var_group_name.dup()), var_key))
			var_additional_fields.array_set(var_key, this.format_field_for_meta_box(var_field.dup(), var_prefixed_key.dup()))
		}
	}
	rt.call_function('array_splice', [var_fields.dup(), rt.add(rt.call_function('array_search', [rt.new_string('state'), rt.func_array_keys(var_fields.dup()), rt.new_bool(true)]), rt.new_int(1)), rt.new_int(0), var_additional_fields.dup()])
	return var_fields.dup()
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) admin_contact_fields(var_fields rt.PhpVal, var_order rt.PhpVal, context string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'Automattic_WooCommerce_Blocks_Domain_Services_WC_Order')))))) {
		return var_fields.dup()
	}
	mut var_additional_fields := rt.call_method(this.checkout_fields_controller, 'get_order_additional_fields_with_values', [var_order.dup(), rt.new_string('contact'), rt.new_string('other'), rt.new_string(context)])
	{
		mut iter_1 := var_additional_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			mut var_prefixed_key := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{}; return temp.get_group_key(arg_0) }(rt.new_string('other')), var_key))
			var_additional_fields.array_set(var_key, this.format_field_for_meta_box(var_field.dup(), var_prefixed_key.dup()))
		}
	}
	return rt.call_function('array_merge', [var_fields.dup(), var_additional_fields.dup()])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) admin_order_fields(var_fields rt.PhpVal, var_order rt.PhpVal, context string) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_order, 'Automattic_WooCommerce_Blocks_Domain_Services_WC_Order')))))) {
		return var_fields.dup()
	}
	mut var_additional_fields := rt.call_method(this.checkout_fields_controller, 'get_order_additional_fields_with_values', [var_order.dup(), rt.new_string('order'), rt.new_string('other'), rt.new_string(context)])
	{
		mut iter_1 := var_additional_fields.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_field := item_1.val
			mut var_key := item_1.key
			mut var_prefixed_key := rt.new_string(rt.concat(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{}; return temp.get_group_key(arg_0) }(rt.new_string('other')), var_key))
			var_additional_fields.array_set(var_key, this.format_field_for_meta_box(var_field.dup(), var_prefixed_key.dup()))
		}
	}
	return rt.call_function('array_merge', [var_fields.dup(), var_additional_fields.dup()])
}

struct Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfieldsadmin(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin{
		PhpObjectBase: rt.PhpObjectBase{}
		checkout_fields_controller: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_blocks_domain_services_checkoutfields() &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields](if args.len > 0 { args[0] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'format_field_for_meta_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.format_field_for_meta_box(dispatch_arg_0, dispatch_arg_1)
		}
		'update_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.update_callback(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'admin_address_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.admin_address_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'admin_contact_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.admin_contact_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'admin_order_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return this.admin_order_fields(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'checkout_fields_controller' { return this.checkout_fields_controller }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFieldsAdmin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'checkout_fields_controller' { this.checkout_fields_controller = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Domain_Services_CheckoutFields) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_blocks_domain_services_checkoutfieldsadmin_php() {
}

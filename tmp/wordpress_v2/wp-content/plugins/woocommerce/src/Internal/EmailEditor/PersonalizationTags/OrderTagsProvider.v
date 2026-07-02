import rt

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider) register_tags(mut var_registry Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry) {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Number'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-number'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_1_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parameters := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		mut var_format := if var_parameters.array_isset(rt.new_string('format'))
			&& var_parameters.array_get(rt.new_string('format')).is_string() {
			var_parameters.array_get(rt.new_string('format'))
		} else {
			rt.call_function('wc_date_format', []rt.PhpVal{})
		}
		mut var_date_created := rt.call_method(var_context.array_get(rt.new_string('order')),
			'get_date_created', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(!(rt.is_true(var_date_created)))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Date'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-date'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_2_fn), rt.create_array([
		rt.ArrayItem{ key: 'format', val: rt.call_function('wc_date_format', []rt.PhpVal{}) },
	]), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		mut var_items := rt.new_array()
		mut iter_1 := rt.call_method(var_context.array_get(rt.new_string('order')), 'get_items',
			[]rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_item := item_1.val
			var_items.array_push(rt.call_method(var_item, 'get_name', []rt.PhpVal{}))
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Items'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-items'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_3_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Subtotal'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-subtotal'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_4_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Tax'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-tax'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_5_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Discount'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-discount'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_6_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Shipping'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-shipping'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_7_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Total'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-total'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_8_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Payment Method'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-payment-method'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_9_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_10_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Payment URL'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-payment-url'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_10_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_11_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Transaction ID'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-transaction-id'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_11_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_12_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Shipping Method'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-shipping-method'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_12_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_13_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Shipping Address'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-shipping-address'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_13_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_14_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Billing Address'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-billing-address'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_14_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_15_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order View URL'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-view-url'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_15_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_16_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order'))) {
			return
		}
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Admin URL'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-admin-url'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_16_fn), rt.new_array(), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
	closure_17_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_context := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_parameters := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if !(var_context.array_isset(rt.new_string('order')))
			|| !(var_parameters.array_isset(rt.new_string('key'))) {
			return
		}
		mut var_field_key := rt.call_function('sanitize_text_field', [
			var_parameters.array_get(rt.new_string('key')),
		])
		return
	}
	var_registry.register(create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(rt.call_function('__', [
		rt.new_string('Order Custom Field'),
		rt.new_string('woocommerce'),
	]), rt.new_string('woocommerce/order-custom-field'), rt.call_function('__', [
		rt.new_string('Order'),
		rt.new_string('woocommerce'),
	]), rt.new_closure(closure_17_fn), rt.create_array([
		rt.ArrayItem{ key: 'key', val: '' },
	]), rt.new_null(), rt.create_array([
		rt.ArrayItem{
			key: none
			val: Class_Automattic_WooCommerce_Internal_EmailEditor_Integration.email_post_type()
		},
	])))
}

struct Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_ordertagsprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_emaileditor_personalizationtags_abstracttagprovider(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider {
	mut obj := &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_personalizationtags_personalization_tag(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_tags' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tags_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register_tags(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_OrderTagsProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_EmailEditor_PersonalizationTags_AbstractTagProvider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_PersonalizationTags_Personalization_Tag) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

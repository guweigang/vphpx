import rt

struct Class_Abstract_WC_Order_Data_Store_CPT {
	rt.PhpObjectBase
pub mut:
	meta_type                       rt.PhpVal = rt.new_string('post')
	internal_meta_keys              rt.PhpVal = rt.new_array()
	internal_data_store_key_getters rt.PhpVal = rt.new_array()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_internal_data_store_key_getters() rt.PhpVal {
	return this.internal_data_store_key_getters
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) create(var_order rt.PhpVal) {
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.get_constant(rt.new_string('WC_VERSION'))
	rt.call_method(var_order, 'set_version', [iife_result_0])
	rt.call_method(var_order, 'set_currency', [if rt.is_true(rt.call_method(var_order,
		'get_currency', []rt.PhpVal{}))
	{
		rt.call_method(var_order, 'get_currency', []rt.PhpVal{})
	} else {
		rt.call_function('get_woocommerce_currency', []rt.PhpVal{})
	}])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_date_created', [
		rt.new_string('edit'),
	])))))
	{
		rt.call_method(var_order, 'set_date_created', [
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	mut var_id := rt.call_function('wp_insert_post', [
		rt.call_function('apply_filters', [rt.new_string('woocommerce_new_order_data'),
			rt.create_array([
				rt.ArrayItem{ key: 'post_date', val: rt.call_function('gmdate', [
					rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_order, 'get_date_created', [
						rt.new_string('edit'),
					]), 'getOffsetTimestamp', []rt.PhpVal{}),
				]) },
				rt.ArrayItem{ key: 'post_date_gmt', val: rt.call_function('gmdate', [
					rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_order, 'get_date_created', [
						rt.new_string('edit'),
					]), 'getTimestamp', []rt.PhpVal{}),
				]) },
				rt.ArrayItem{ key: 'post_type', val: rt.call_method(var_order, 'get_type', [
					rt.new_string('edit'),
				]) },
				rt.ArrayItem{ key: 'post_status', val: this.get_post_status(var_order.clone()) },
				rt.ArrayItem{ key: 'ping_status', val: 'closed' },
				rt.ArrayItem{ key: 'post_author', val: 1 },
				rt.ArrayItem{ key: 'post_title', val: this.get_post_title() },
				rt.ArrayItem{ key: 'post_password', val: this.get_order_key(var_order.clone()) },
				rt.ArrayItem{ key: 'post_parent', val: rt.call_method(var_order, 'get_parent_id', [
					rt.new_string('edit'),
				]) },
				rt.ArrayItem{ key: 'post_excerpt', val: this.get_post_excerpt(var_order.clone()) },
			])]),
		rt.new_bool(true),
	])
	if rt.is_true(var_id)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_id.clone()]))))) {
		rt.call_method(var_order, 'set_id', [var_id.clone()])
		this.update_post_meta(var_order.clone())
		rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
		rt.call_method(var_order, 'apply_changes', []rt.PhpVal{})
		this.clear_caches(var_order.clone())
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) order_exists(var_order_id rt.PhpVal) bool {
	mut var_order_id_mutated := var_order_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id_mutated)))) {
		return false
	}
	mut var_post_object := rt.call_function('get_post', [var_order_id_mutated.clone()])
	return !(var_post_object.clone().is_null())
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_object, 'post_type'), rt.call_function('wc_get_order_types', []rt.PhpVal{}), rt.new_bool(true)]))
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) read(var_order rt.PhpVal) {
	rt.call_method(var_order, 'set_defaults', []rt.PhpVal{})
	mut var_post_object := rt.call_function('get_post', [
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{})))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_post_object))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_post_object, 'post_type'), rt.call_function('wc_get_order_types', []rt.PhpVal{}), rt.new_bool(true)]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.call_function('esc_html__', [
			rt.new_string('Invalid order.'),
			rt.new_string('woocommerce'),
		]))))
	}
	this.set_order_props(var_order.clone(), mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: 'parent_id', val: rt.get_property(var_post_object, 'post_parent') },
		rt.ArrayItem{ key: 'date_created', val: this.string_to_timestamp(rt.get_property(var_post_object,
			'post_date_gmt')) },
		rt.ArrayItem{ key: 'date_modified', val: this.string_to_timestamp(rt.get_property(var_post_object,
			'post_modified_gmt')) },
		rt.ArrayItem{ key: 'status', val: rt.get_property(var_post_object, 'post_status') },
	])))
	this.read_order_data(var_order.clone(), var_post_object.clone())
	rt.call_method(var_order, 'read_meta_data', []rt.PhpVal{})
	rt.call_method(var_order, 'set_object_read', [rt.new_bool(true)])
	if rt.is_true(rt.call_function('version_compare', [rt.call_method(var_order, 'get_version', [rt.new_string('edit')]), rt.new_string('2.3.7'), rt.new_string('<')]))
		&& rt.is_true(rt.call_method(var_order, 'get_prices_include_tax', [rt.new_string('edit')])) {
		rt.call_method(var_order, 'set_discount_total', [
			rt.new_float((rt.call_function('get_post_meta', [
				rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
				rt.new_string('_cart_discount'),
				rt.new_bool(true),
			])).to_f64()) - rt.new_float((rt.call_function('get_post_meta', [
				rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
				rt.new_string('_cart_discount_tax'),
				rt.new_bool(true),
			])).to_f64()),
		])
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) set_order_props(var_order rt.PhpVal, mut var_props Class_array) {
	mut var_errors := rt.call_method(var_order, 'set_props', [var_props])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_errors, 'WP_Error')))))) {
		return
	}
	mut var_order_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	mut var_logger := rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'call_function', [
		rt.new_string('wc_get_logger'),
	])
	mut iter_1 := rt.call_method(var_errors, 'get_error_codes', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_error_code := item_1.val
		mut var_property_name := if !(rt.call_method(var_errors, 'get_error_data', [
			var_error_code.clone(),
		]).array_get(rt.new_string('property_name'))).is_null() { rt.call_method(var_errors, 'get_error_data', [
				var_error_code.clone(),
			]).array_get(rt.new_string('property_name')) } else { rt.new_string('') }
		mut var_error_message := rt.call_method(var_errors, 'get_error_message', [
			var_error_code.clone(),
		])
		rt.call_method(var_logger, 'warning', [
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string("Error when setting property '%1$s' for order %2$d: %3$s"),
					rt.new_string('woocommerce'),
				]),
				var_property_name.clone(),
				var_order_id.clone(),
				var_error_message.clone(),
			]),
			rt.create_array([
				rt.ArrayItem{ key: 'error_code', val: var_error_code },
				rt.ArrayItem{ key: 'error_message', val: var_error_message },
				rt.ArrayItem{ key: 'order_id', val: var_order_id },
				rt.ArrayItem{ key: 'property_name', val: var_property_name },
			]),
		])
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update(var_order rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	rt.call_method(var_order, 'save_meta_data', []rt.PhpVal{})
	mut iife_temp_1 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_1 := iife_temp_1.get_constant(rt.new_string('WC_VERSION'))
	rt.call_method(var_order, 'set_version', [iife_result_1])
	if rt.is_true(rt.identical(rt.new_null(), rt.call_method(var_order, 'get_date_created', [
		rt.new_string('edit'),
	])))
	{
		rt.call_method(var_order, 'set_date_created', [
			rt.call_function('time', []rt.PhpVal{}),
		])
	}
	mut var_changes := rt.call_method(var_order, 'get_changes', []rt.PhpVal{})
	if rt.is_true(rt.call_function('array_intersect', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'date_created' },
			rt.ArrayItem{ key: none, val: 'date_modified' }, rt.ArrayItem{ key: none, val: 'status' },
			rt.ArrayItem{ key: none, val: 'parent_id' }, rt.ArrayItem{
				key: none
				val: 'post_excerpt'
			}]),
		rt.func_array_keys(var_changes.clone()),
	]))
	{
		mut var_post_data := {
			'post_date':         rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_order, 'get_date_created', [
					rt.new_string('edit'),
				]), 'getOffsetTimestamp', []rt.PhpVal{}),
			])
			'post_date_gmt':     rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_order, 'get_date_created', [
					rt.new_string('edit'),
				]), 'getTimestamp', []rt.PhpVal{}),
			])
			'post_status':       this.get_post_status(var_order.clone())
			'post_parent':       rt.call_method(var_order, 'get_parent_id', []rt.PhpVal{})
			'post_excerpt':      this.get_post_excerpt(var_order.clone())
			'post_modified':     if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [
					rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_order, 'get_date_modified', [
						rt.new_string('edit'),
					]), 'getOffsetTimestamp', []rt.PhpVal{}),
				]) } else { rt.call_function('current_time', [
					rt.new_string('mysql')]) }
			'post_modified_gmt': if var_changes.array_isset(rt.new_string('date_modified')) { rt.call_function('gmdate', [
					rt.new_string('Y-m-d H:i:s'),
					rt.call_method(rt.call_method(var_order, 'get_date_modified', [
						rt.new_string('edit'),
					]), 'getTimestamp', []rt.PhpVal{}),
				]) } else { rt.call_function('current_time', [
					rt.new_string('mysql'), rt.new_int(1)]) }
		}
		if rt.is_true(rt.call_function('doing_action', [rt.new_string('save_post')])) {
			rt.call_method(var_GLOBALS.array_get(rt.new_string('wpdb')), 'update', [
				rt.get_property(var_GLOBALS.array_get(rt.new_string('wpdb')), 'posts'),
				rt.create_array_from_native_map(var_post_data),
				rt.create_array([
					rt.ArrayItem{ key: 'ID', val: rt.call_method(var_order, 'get_id', []rt.PhpVal{}) },
				]),
			])
			rt.call_function('clean_post_cache', [
				rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
			])
		} else {
			rt.call_function('wp_update_post', [
				rt.call_function('array_merge', [
					rt.create_array([
						rt.ArrayItem{ key: 'ID', val: rt.call_method(var_order, 'get_id',
							[]rt.PhpVal{}) },
					]),
					rt.create_array_from_native_map(var_post_data),
				]),
			])
		}
		rt.call_method(var_order, 'read_meta_data', [rt.new_bool(true)])
	}
	this.update_post_meta(var_order.clone())
	rt.call_method(var_order, 'apply_changes', []rt.PhpVal{})
	this.clear_caches(var_order.clone())
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) delete(var_order rt.PhpVal, var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	mut var_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	var_args_mutated = rt.call_function('wp_parse_args', [var_args_mutated.clone(),
		rt.create_array([rt.ArrayItem{ key: 'force_delete', val: false },
			rt.ArrayItem{ key: 'suppress_filters', val: false }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		return
	}
	mut var_do_filters :=
		rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('suppress_filters')))))
	if rt.is_true(var_args_mutated.array_get(rt.new_string('force_delete'))) {
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_before_delete_order'),
				var_id.clone(),
				var_order.clone(),
			])
		}
		rt.call_function('wp_delete_post', [var_id.clone()])
		rt.call_method(var_order, 'set_id', [rt.new_int(0)])
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_delete_order'),
				var_id.clone()])
		}
	} else {
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [
				rt.new_string('woocommerce_before_trash_order'),
				var_id.clone(),
				var_order.clone(),
			])
		}
		rt.call_function('wp_trash_post', [var_id.clone()])
		rt.call_method(var_order, 'set_status', [
			Class_Automattic_WooCommerce_Enums_OrderStatus.trash(),
		])
		if rt.is_true(var_do_filters) {
			rt.call_function('do_action', [rt.new_string('woocommerce_trash_order'),
				var_id.clone()])
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_post_status(var_order rt.PhpVal) rt.PhpVal {
	mut var_order_status := rt.call_method(var_order, 'get_status', [
		rt.new_string('edit'),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_status)))) {
		var_order_status = rt.call_function('apply_filters', [
			rt.new_string('woocommerce_default_order_status'),
			Class_Automattic_WooCommerce_Enums_OrderStatus.pending(),
		])
	}
	mut var_post_status := var_order_status.clone()
	mut var_valid_statuses := rt.call_function('get_post_stati', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_status.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Enums_OrderStatus.auto_draft()
	}, rt.ArrayItem{ key: none, val: Class_Automattic_WooCommerce_Enums_OrderStatus.draft() }, rt.ArrayItem{
		key: none
		val: Class_Automattic_WooCommerce_Enums_OrderStatus.trash()
	}]), rt.new_bool(true)])))))
		&& rt.is_true(rt.call_function('in_array', [rt.new_string('wc-' + var_post_status.str()), var_valid_statuses.clone(), rt.new_bool(true)])) {
		var_post_status = rt.new_string('wc-' + var_post_status.str())
	}
	return var_post_status.clone()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_post_excerpt(var_order rt.PhpVal) string {
	return ''
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_post_title() rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.call_function('__', [rt.new_string('Order &ndash; %s'),
			rt.new_string('woocommerce')]),
		rt.call_method(create_datetime(rt.new_string('now')), 'format', [
			rt.call_function('_x', [rt.new_string('M d, Y @ h:i A'),
				rt.new_string('Order date parsed by DateTime::format'),
				rt.new_string('woocommerce')])]),
	])
	return rt.new_null()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_order_key(var_order rt.PhpVal) rt.PhpVal {
	return rt.call_function('wc_generate_order_key', []rt.PhpVal{})
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) read_order_data(var_order rt.PhpVal, var_post_object rt.PhpVal) {
	mut var_post_object_mutated := var_post_object
	mut var_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	mut var_meta_data := rt.call_function('get_post_meta', [var_id.clone()])
	mut var_prices_include_tax := if !(var_meta_data.array_get(rt.new_string('_prices_include_tax')).array_get(rt.new_int(0))).is_null() {
		var_meta_data.array_get(rt.new_string('_prices_include_tax')).array_get(rt.new_int(0))
	} else {
		rt.new_string('')
	}
	this.set_order_props(var_order.clone(), mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{
			key: 'currency'
			val: if !(var_meta_data.array_get(rt.new_string('_order_currency')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_order_currency')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'discount_total'
			val: if !(var_meta_data.array_get(rt.new_string('_cart_discount')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_cart_discount')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'discount_tax'
			val: if !(var_meta_data.array_get(rt.new_string('_cart_discount_tax')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_cart_discount_tax')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'shipping_total'
			val: if !(var_meta_data.array_get(rt.new_string('_order_shipping')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_order_shipping')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'shipping_tax'
			val: if !(var_meta_data.array_get(rt.new_string('_order_shipping_tax')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_order_shipping_tax')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'cart_tax'
			val: if !(var_meta_data.array_get(rt.new_string('_order_tax')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_order_tax')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'total'
			val: if !(var_meta_data.array_get(rt.new_string('_order_total')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_order_total')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'version'
			val: if !(var_meta_data.array_get(rt.new_string('_order_version')).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_order_version')).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}
		},
		rt.ArrayItem{
			key: 'prices_include_tax'
			val: if rt.is_true(rt.call_function('metadata_exists', [
				rt.new_string('post'),
				var_id.clone(),
				rt.new_string('_prices_include_tax'),
			]))
			{ rt.identical(rt.new_string('yes'), var_prices_include_tax) } else { rt.identical(rt.new_string('yes'), rt.call_function('get_option', [
					rt.new_string('woocommerce_prices_include_tax'),
				])) }
		},
	])))
	mut iter_2 := rt.call_method(var_order, 'get_extra_data_keys', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_key := item_2.val
		mut var_function := rt.new_string('set_' + var_key.str())
		if rt.is_true(rt.call_function('is_callable', [
			rt.create_array([rt.ArrayItem{ key: none, val: var_order },
				rt.ArrayItem{ key: none, val: var_function }]),
		]))
		{
			rt.call_method(var_order, var_function, [if !(var_meta_data.array_get(rt.new_string(
				'_' + var_key.str())).array_get(rt.new_int(0))).is_null() {
				var_meta_data.array_get(rt.new_string('_' + var_key.str())).array_get(rt.new_int(0))
			} else {
				rt.new_string('')
			}])
		}
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_post_meta(var_order rt.PhpVal) {
	mut var_updated_props := []rt.PhpVal{}
	mut var_meta_key_to_props := {
		'_order_currency':     'currency'
		'_cart_discount':      'discount_total'
		'_cart_discount_tax':  'discount_tax'
		'_order_shipping':     'shipping_total'
		'_order_shipping_tax': 'shipping_tax'
		'_order_tax':          'cart_tax'
		'_order_total':        'total'
		'_order_version':      'version'
		'_prices_include_tax': 'prices_include_tax'
	}
	mut var_props_to_update := this.get_props_to_update(var_order.clone(),
		var_meta_key_to_props.clone())
	mut iter_3 := var_props_to_update.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_prop := item_3.val
		mut var_meta_key := item_3.key
		mut var_value := rt.call_method(var_order, 'get_${var_prop.to_string()}', [
			rt.new_string('edit'),
		])
		var_value = if var_value.clone().is_string() { rt.call_function('wp_slash', [
				var_value.clone(),
			]) } else { var_value }
		if rt.is_true(rt.identical(rt.new_string('prices_include_tax'), var_prop)) {
			var_value = rt.new_string((if rt.is_true(var_value) { 'yes' } else { 'no' }).str())
		}
		mut var_updated := this.update_or_delete_post_meta(var_order.clone(), var_meta_key.clone(),
			var_value.clone())
		if rt.is_true(var_updated) {
			var_updated_props << var_prop.clone()
		}
	}
	rt.call_function('do_action', [
		rt.new_string('woocommerce_order_object_updated_props'),
		var_order.clone(),
		rt.create_array_from_list(var_updated_props),
	])
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) clear_caches(var_order rt.PhpVal) {
	rt.call_function('clean_post_cache', [
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	rt.call_function('wc_delete_shop_order_transients', [var_order.clone()])
	rt.call_function('wp_cache_delete', [
		rt.new_string('order-items-' + (rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()),
		rt.new_string('orders'),
	])
	mut iife_temp_2 := Class_Automattic_WooCommerce_Utilities_OrderUtil{}
	mut iife_result_2 := iife_temp_2.orders_cache_usage_is_enabled()
	if rt.is_true(iife_result_2) {
		mut var_order_cache := rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}),
			'get', [Class_Automattic_WooCommerce_Caches_OrderCache.class()])
		rt.call_method(var_order_cache, 'remove', [
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		])
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) read_items(var_order rt.PhpVal, var_type rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_order, 'get_id', []rt.PhpVal{}))) {
		return []rt.PhpVal{}
	}
	mut var_items := if rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_order, 'get_id', []rt.PhpVal{}))) { rt.call_function('wp_cache_get', [
			rt.new_string('order-items-' + (rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()),
			rt.new_string('orders'),
		]) } else { rt.new_bool(false) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_items)) {
		var_items = rt.call_method(var_wpdb, 'get_results', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT order_item_type, order_item_id, order_id, order_item_name FROM '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('woocommerce_order_items WHERE order_id = %d ORDER BY order_item_id;')),
				rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
			]),
		])
		mut iter_4 := var_items.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_item := item_4.val
			rt.call_function('wp_cache_set', [
				rt.new_string('item-' + (rt.get_property(var_item, 'order_item_id')).str()),
				var_item.clone(),
				rt.new_string('order-items'),
			])
		}
		if rt.is_true(rt.less(rt.new_int(0), rt.call_method(var_order, 'get_id', []rt.PhpVal{}))) {
			rt.call_function('wp_cache_set', [
				rt.new_string('order-items-' +
					(rt.call_method(var_order, 'get_id', []rt.PhpVal{})).str()),
				var_items.clone(),
				rt.new_string('orders'),
			])
		}
	}
	var_items = rt.call_function('wp_list_filter', [var_items.clone(),
		rt.create_array([rt.ArrayItem{ key: 'order_item_type', val: var_type }])])
	if !(!rt.is_true(var_items)) {
		var_items = rt.call_function('array_map', [
			rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Order_Factory' },
				rt.ArrayItem{ key: none, val: 'get_order_item' }]),
			rt.call_function('array_combine', [
				rt.call_function('wp_list_pluck', [var_items.clone(),
					rt.new_string('order_item_id')]),
				var_items.clone(),
			]),
		])
	} else {
		var_items = []rt.PhpVal{}
	}
	return var_items.clone()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_order_item_type(var_order rt.PhpVal, var_order_item_id rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	return rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT DISTINCT order_item_type FROM '), rt.get_property(var_wpdb,
				'prefix')),
				rt.new_string('woocommerce_order_items WHERE order_id = %d and order_item_id = %d;')),
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
			var_order_item_id.clone(),
		]),
	])
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_order_item_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if var_query_vars.array_isset(rt.new_string('fields'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_query_vars.array_get(rt.new_string('fields')))))) {
		mut var_line_items := ['line_items', 'shipping_lines', 'fee_lines', 'coupon_lines']
		if var_query_vars.array_get(rt.new_string('fields')).is_array()
			&& 0 == rt.call_function('array_intersect', [rt.create_array_from_list(var_line_items), var_query_vars.array_get(rt.new_string('fields'))]).array_count() {
			return
		}
	}
	closure_4_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return 'order-items-' + var_order_id.str()
	}
	closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return 'order-items-' + var_order_id.str()
	}
	mut var_cache_keys := rt.call_function('array_map', [rt.new_closure(closure_4_fn),
		var_order_ids.clone()])
	mut var_cache_values := rt.call_function('wc_cache_get_multiple', [
		var_cache_keys.clone(), rt.new_string('orders')])
	mut var_non_cached_ids := []rt.PhpVal{}
	mut iter_5 := var_order_ids.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_order_id := item_5.val
		if rt.is_true(rt.identical(rt.new_bool(false), var_cache_values.array_get(rt.new_string(
			'order-items-' + var_order_id.str()))))
		{
			var_non_cached_ids.array_push(var_order_id.clone())
		}
	}
	if !rt.is_true(var_non_cached_ids) {
		return
	}
	var_non_cached_ids = rt.call_function('esc_sql', [var_non_cached_ids.clone()])
	mut var_non_cached_ids_string := rt.call_function('implode', [
		rt.new_string(','), var_non_cached_ids.clone()])
	mut var_order_items := rt.call_method(var_wpdb, 'get_results', [
		rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT order_item_type, order_item_id, order_id, order_item_name FROM '), rt.get_property(var_wpdb,
			'prefix')), rt.new_string('woocommerce_order_items WHERE order_id in ( ')),
			var_non_cached_ids_string), rt.new_string(' ) ORDER BY order_item_id;')),
	])
	if !rt.is_true(var_order_items) {
		return
	}
	closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_order_items_collection := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_order_item := if args.len > 1 { args[1].clone() } else { rt.new_null() }
		if !(var_order_items_collection.array_isset(rt.get_property(var_order_item, 'order_id'))) {
			var_order_items_collection.array_set(rt.get_property(var_order_item, 'order_id'),
				[]rt.PhpVal{})
		}
		var_order_items_collection.array_get_mut(rt.get_property(var_order_item, 'order_id')).array_push(var_order_item.clone())
		return
	}
	mut var_order_items_for_all_orders := rt.call_function('array_reduce', [
		var_order_items.clone(), rt.new_closure(closure_6_fn)])
	mut iter_6 := var_order_items_for_all_orders.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_items := item_6.val
		mut var_order_id := item_6.key
		rt.call_function('wp_cache_set', [
			rt.new_string('order-items-' + var_order_id.str()),
			var_items.clone(),
			rt.new_string('orders'),
		])
	}
	mut iter_7 := var_order_items.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_item := item_7.val
		rt.call_function('wp_cache_set', [
			rt.new_string('item-' + (rt.get_property(var_item, 'order_item_id')).str()),
			var_item.clone(),
			rt.new_string('order-items'),
		])
	}
	mut var_order_item_ids := rt.call_function('wp_list_pluck', [
		var_order_items.clone(), rt.new_string('order_item_id')])
	rt.call_function('update_meta_cache', [rt.new_string('order_item'),
		var_order_item_ids.clone()])
	mut var_id_placeholders := rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_order_item_ids.clone().array_count()),
			rt.new_string('%d')])])
	mut var_raw_meta_data_array := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('SELECT order_item_id as object_id, meta_id, meta_key, meta_value FROM '), rt.get_property(var_wpdb,
				'prefix')), rt.new_string('woocommerce_order_itemmeta WHERE order_item_id IN (')),
				var_id_placeholders), rt.new_string(') ORDER BY meta_id')),
			var_order_item_ids.clone(),
		]),
	])
	if !(!rt.is_true(var_raw_meta_data_array)) {
		mut var_raw_meta_data_collection := []rt.PhpVal{}
		mut iter_8 := var_raw_meta_data_array.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_raw_meta_data := item_8.val
			if !(var_raw_meta_data_collection.array_isset(rt.get_property(var_raw_meta_data,
				'object_id'))) {
				var_raw_meta_data_collection.array_set(rt.get_property(var_raw_meta_data,
					'object_id'), []rt.PhpVal{})
			}
			var_raw_meta_data_collection.array_get_mut(rt.get_property(var_raw_meta_data,
				'object_id')).array_push(var_raw_meta_data.clone())
		}
		mut iife_temp_6 := Class_WC_Order_Item{}
		mut iife_result_6 := iife_temp_6.prime_raw_meta_data_cache(var_raw_meta_data_collection.clone(),
			rt.new_string('order-items'))
		this.prime_product_post_caches_for_order_items(mut rt.cast_object_ptr[Class_array](var_order_items), mut
			rt.cast_object_ptr[Class_array](var_raw_meta_data_collection))
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_product_post_caches_for_order_items(mut var_line_items_all Class_array, mut var_raw_meta_data_collection Class_array) {
	mut var_raw_meta_data_collection_mutated := var_raw_meta_data_collection
	mut var_product_ids := []rt.PhpVal{}
	mut iter_9 := var_line_items_all.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_line_item := item_9.val
		if rt.is_true(rt.identical(rt.new_string('line_item'), rt.get_property(var_line_item,
			'order_item_type')))
		{
			mut iter_10 := if !(var_raw_meta_data_collection_mutated.array_get(rt.get_property(var_line_item,
				'order_item_id'))).is_null() {
				var_raw_meta_data_collection_mutated.array_get(rt.get_property(var_line_item,
					'order_item_id'))
			} else {
				[]rt.PhpVal{}
			}.iterator()
			for {
				item_10 := iter_10.next() or { break }
				mut var_meta := item_10.val
				if rt.is_true(rt.identical(rt.new_string('_variation_id'), rt.get_property(var_meta, 'meta_key')))
					|| rt.is_true(rt.identical(rt.new_string('_product_id'), rt.get_property(var_meta, 'meta_key')))
					&& rt.is_true(rt.greater(rt.get_property(var_meta, 'meta_value'), rt.new_int(0))) {
					var_product_ids << rt.new_int((rt.get_property(var_meta, 'meta_value')).to_i64())
				}
			}
		}
	}
	rt.call_function('_prime_post_caches', [
		rt.call_function('array_unique', [rt.create_array_from_list(var_product_ids)]),
	])
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_refund_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal) {
	if var_query_vars.array_isset(rt.new_string('fields'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('all'), var_query_vars.array_get(rt.new_string('fields')))))) {
		if var_query_vars.array_get(rt.new_string('fields')).is_array()
			&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('refunds'), var_query_vars.array_get(rt.new_string('fields')), rt.new_bool(true)]))))) {
			return
		}
	}
	mut var_cache_keys_mapping := []rt.PhpVal{}
	mut iter_11 := var_order_ids.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_order_id := item_11.val
		mut iife_temp_7 := Class_WC_Cache_Helper{}
		mut iife_result_7 := iife_temp_7.get_cache_prefix(rt.new_string('orders'))
		var_cache_keys_mapping.array_set(var_order_id, iife_result_7.str() + 'refund_ids' +
			var_order_id.str())
	}
	mut var_non_cached_ids := []rt.PhpVal{}
	mut var_cache_values := rt.call_function('wc_cache_get_multiple', [
		rt.call_function('array_values', [var_cache_keys_mapping.clone()]),
		rt.new_string('orders'),
	])
	if !(var_cache_values.clone().is_array()) {
		var_non_cached_ids = var_order_ids
	} else {
		mut iter_12 := var_order_ids.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_order_id := item_12.val
			if rt.is_true(rt.identical(rt.new_bool(false),
				var_cache_values.array_get(var_cache_keys_mapping.array_get(var_order_id))))
			{
				var_non_cached_ids.array_push(var_order_id.clone())
			}
		}
	}
	if !rt.is_true(var_non_cached_ids) {
		return
	}
	mut var_refunds := rt.call_function('wc_get_orders', [
		rt.create_array([rt.ArrayItem{ key: 'type', val: 'shop_order_refund' },
			rt.ArrayItem{ key: 'post_parent__in', val: var_non_cached_ids },
			rt.ArrayItem{ key: 'limit', val: -1 }]),
	])
	mut var_order_refund_ids := rt.call_function('array_fill_keys', [
		var_non_cached_ids.clone(), []rt.PhpVal{}])
	mut iter_13 := var_refunds.iterator()
	for {
		item_13 := iter_13.next() or { break }
		mut var_refund := item_13.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_refund, 'WC_Order_Refund')))
			&& var_order_refund_ids.array_isset(rt.call_method(var_refund, 'get_parent_id', []rt.PhpVal{})) {
			var_order_refund_ids.array_get_mut(rt.call_method(var_refund, 'get_parent_id',
				[]rt.PhpVal{})).array_push(rt.call_method(var_refund, 'get_id', []rt.PhpVal{}))
		}
	}
	mut iter_14 := var_non_cached_ids.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_order_id := item_14.val
		rt.call_function('wp_cache_set', [var_cache_keys_mapping.array_get(var_order_id),
			var_order_refund_ids.array_get(var_order_id), rt.new_string('orders')])
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_needs_processing_transients(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal) {
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) delete_items(var_order rt.PhpVal, var_type rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut var_order_id := rt.call_method(var_order, 'get_id', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order_id)))) {
		return
	}
	if !(!rt.is_true(var_type)) {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE itemmeta FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_order_itemmeta as itemmeta INNER JOIN ')), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('woocommerce_order_items as items WHERE itemmeta.order_item_id = items.order_item_id AND items.order_id = %d AND items.order_item_type = %s')),
				var_order_id.clone(),
				var_type.clone(),
			]),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('woocommerce_order_items WHERE order_id = %d AND order_item_type = %s')),
				var_order_id.clone(),
				var_type.clone(),
			]),
		])
	} else {
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('DELETE itemmeta FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_order_itemmeta as itemmeta INNER JOIN ')), rt.get_property(var_wpdb,
					'prefix')),
					rt.new_string('woocommerce_order_items as items WHERE itemmeta.order_item_id = items.order_item_id and items.order_id = %d')),
				var_order_id.clone(),
			]),
		])
		rt.call_method(var_wpdb, 'query', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb,
					'prefix')), rt.new_string('woocommerce_order_items WHERE order_id = %d')),
				var_order_id.clone(),
			]),
		])
	}
	this.clear_caches(var_order.clone())
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_payment_token_ids(var_order rt.PhpVal) rt.PhpVal {
	mut var_token_ids := rt.call_function('array_filter', [
		rt.cast_array(rt.call_function('get_post_meta', [
			rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
			rt.new_string('_payment_tokens'),
			rt.new_bool(true),
		])),
	])
	return var_token_ids.clone()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_payment_token_ids(var_order rt.PhpVal, var_token_ids rt.PhpVal) {
	mut var_token_ids_mutated := var_token_ids
	rt.call_function('update_post_meta', [
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
		rt.new_string('_payment_tokens'),
		var_token_ids_mutated.clone(),
	])
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_title(mut var_order Class_WC_Order) rt.PhpVal {
	return rt.call_function('get_the_title', [var_order.get_id()])
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_order_from_object(var_order rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_order, 'get_id', []rt.PhpVal{}))))) {
		return false
	}
	this.update_order_meta_from_object(var_order.clone())
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Abstract_WC_Order_Data_Store_CPT', [
				'WC_Data_Store_WP',
				'WC_Abstract_Order_Data_Store_Interface',
				'WC_Object_Data_Store_Interface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_post_modified_data' },
		]),
		rt.new_int(10), rt.new_int(2)])
	mut var_post_data := {
		'ID':                 rt.call_method(var_order, 'get_id', []rt.PhpVal{})
		'post_date':          rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
			rt.call_method(rt.call_method(var_order, 'get_date_created', [
				rt.new_string('edit'),
			]), 'getOffsetTimestamp', []rt.PhpVal{})])
		'post_date_gmt':      rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'),
			rt.call_method(rt.call_method(var_order, 'get_date_created', [
				rt.new_string('edit'),
			]), 'getTimestamp', []rt.PhpVal{})])
		'post_status':        this.get_post_status(var_order.clone())
		'post_parent':        rt.call_method(var_order, 'get_parent_id', []rt.PhpVal{})
		'edit_date':          rt.new_bool(true)
		'post_excerpt':       if rt.is_true(rt.call_function('method_exists', [
			var_order.clone(),
			rt.new_string('get_customer_note'),
		]))
		{ rt.call_method(var_order, 'get_customer_note', []rt.PhpVal{}) } else { rt.new_string('') }
		'post_type':          rt.call_method(var_order, 'get_type', []rt.PhpVal{})
		'order_modified':     if !(rt.call_method(var_order, 'get_date_modified', []rt.PhpVal{}).is_null()) { rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_order, 'get_date_modified', [
					rt.new_string('edit'),
				]), 'getOffsetTimestamp', []rt.PhpVal{}),
			]) } else { rt.new_string('') }
		'order_modified_gmt': if !(rt.call_method(var_order, 'get_date_modified', []rt.PhpVal{}).is_null()) { rt.call_function('gmdate', [
				rt.new_string('Y-m-d H:i:s'),
				rt.call_method(rt.call_method(var_order, 'get_date_modified', [
					rt.new_string('edit'),
				]), 'getTimestamp', []rt.PhpVal{}),
			]) } else { rt.new_string('') }
	}
	mut var_updated := rt.call_function('wp_update_post', [
		rt.create_array_from_native_map(var_post_data),
	])
	rt.call_function('remove_filter', [rt.new_string('wp_insert_post_data'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Abstract_WC_Order_Data_Store_CPT', [
				'WC_Data_Store_WP',
				'WC_Abstract_Order_Data_Store_Interface',
				'WC_Object_Data_Store_Interface',
			], &this) },
			rt.ArrayItem{ key: none, val: 'update_post_modified_data' },
		])])
	return var_updated.to_bool()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_post_modified_data(var_data rt.PhpVal, var_postarr rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if !(var_postarr.array_isset(rt.new_string('order_modified')))
		|| !(var_postarr.array_isset(rt.new_string('order_modified_gmt'))) {
		return var_data_mutated.clone()
	}
	var_data_mutated.array_set('post_modified',
		var_postarr.array_get(rt.new_string('order_modified')))
	var_data_mutated.array_set('post_modified_gmt',
		var_postarr.array_get(rt.new_string('order_modified_gmt')))
	return var_data_mutated.clone()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) update_order_meta_from_object(var_order rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(rt.call_method(var_order, 'get_meta', []rt.PhpVal{}).is_null())) {
		return
	}
	mut var_existing_meta_data := rt.call_function('get_post_meta', [
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])
	mut iter_15 := rt.call_method(var_order, 'get_meta_data', []rt.PhpVal{}).iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_meta_data := item_15.val
		if var_existing_meta_data.array_isset(rt.get_property(var_meta_data, 'key')) {
			mut var_meta_value := if rt.get_property(var_meta_data, 'value').is_array() { rt.get_property(var_meta_data, 'value') } else { rt.create_array([
					rt.ArrayItem{ key: none, val: rt.get_property(var_meta_data, 'value') },
				]) }
			if rt.is_true(rt.identical(var_existing_meta_data.array_get(rt.get_property(var_meta_data,
				'key')), var_meta_value))
			{
				var_existing_meta_data.array_unset(rt.get_property(var_meta_data, 'key'))
				continue
			}
			if rt.is_true(rt.new_bool(var_existing_meta_data.array_get(rt.get_property(var_meta_data,
				'key')).is_array()))
			{
				mut var_value_index := rt.call_function('array_search', [
					rt.call_function('maybe_serialize', [
						rt.get_property(var_meta_data, 'value'),
					]),
					var_existing_meta_data.array_get(rt.get_property(var_meta_data, 'key')),
					rt.new_bool(true),
				])
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false),
					var_value_index))))
				{
					var_existing_meta_data.array_get(rt.get_property(var_meta_data, 'key')).array_unset(var_value_index)
					if 0 == var_existing_meta_data.array_get(rt.get_property(var_meta_data, 'key')).array_count() {
						var_existing_meta_data.array_unset(rt.get_property(var_meta_data, 'key'))
					}
					continue
				}
			}
		}
		if rt.get_property(var_meta_data, 'value').is_object()
			&& rt.is_true(rt.identical(rt.new_string('__PHP_Incomplete_Class'), rt.call_function('get_class', [rt.get_property(var_meta_data, 'value')]))) {
			var_meta_value = rt.call_function('maybe_serialize', [
				rt.get_property(var_meta_data, 'value'),
			])
			mut var_result := rt.call_method(var_wpdb, 'insert', [
				rt.call_function('_get_meta_table', [rt.new_string('post')]),
				rt.create_array([rt.ArrayItem{ key: 'post_id', val: rt.call_method(var_order,
					'get_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'meta_key', val: rt.get_property(var_meta_data,
					'key') }, rt.ArrayItem{ key: 'meta_value', val: var_meta_value }]),
				rt.create_array([rt.ArrayItem{ key: none, val: '%d' },
					rt.ArrayItem{ key: none, val: '%s' }, rt.ArrayItem{ key: none, val: '%s' }]),
			])
			rt.call_function('wp_cache_delete', [
				rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
				rt.new_string('post_meta'),
			])
			mut var_logger := rt.call_method(rt.call_method(rt.call_function('wc_get_container',
				[]rt.PhpVal{}), 'get', [
				Class_Automattic_WooCommerce_Proxies_LegacyProxy.class(),
			]), 'call_function', [rt.new_string('wc_get_logger')])
			rt.call_method(var_logger, 'warning', [
				rt.call_function('sprintf', [
					rt.new_string('encountered an order meta value of type __PHP_Incomplete_Class during `update_order_meta_from_object` in order with ID %d: "%s"'),
					rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
					rt.call_function('var_export', [var_meta_value.clone(),
						rt.new_bool(true)]),
				]),
			])
		} else {
			rt.call_function('add_post_meta', [
				rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
				rt.get_property(var_meta_data, 'key'),
				rt.get_property(var_meta_data, 'value'),
				rt.new_bool(false),
			])
		}
	}
	mut var_keys_to_delete := rt.call_function('array_diff', [
		rt.func_array_keys(var_existing_meta_data.clone()),
		this.internal_meta_keys,
		rt.func_array_keys(this.get_internal_data_store_key_getters()),
	])
	mut iter_16 := var_keys_to_delete.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_meta_key := item_16.val
		if var_existing_meta_data.array_isset(var_meta_key) {
			mut iter_17 := var_existing_meta_data.array_get(var_meta_key).iterator()
			for {
				item_17 := iter_17.next() or { break }
				mut var_meta_value := item_17.val
				rt.call_function('delete_post_meta', [
					rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
					var_meta_key.clone(),
					rt.call_function('maybe_unserialize', [var_meta_value.clone()]),
				])
			}
		}
	}
	this.update_post_meta(var_order.clone())
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refund_orders_join_clause(order_id i64) string {
	mut var_wpdb := rt.new_null()
	mut order_id_mutated := order_id
	return (rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('%i AS refunds ON ( refunds.post_type = %s AND refunds.post_parent = %d )'),
		rt.get_property(var_wpdb, 'posts'),
		rt.new_string('shop_order_refund'),
		rt.new_int(order_id_mutated).clone(),
	])).str()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refund_orders_batch_join_clause(mut var_order_ids Class_array) string {
	mut var_wpdb := rt.new_null()
	mut var_id_list := rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_map', [rt.new_string('absint'), var_order_ids])])
	return (rt.call_method(var_wpdb, 'prepare', [
		rt.new_string('%i AS refunds ON ( refunds.post_type = %s AND refunds.post_parent IN ( ${var_id_list.to_string()} ) )'),
		rt.get_property(var_wpdb, 'posts'),
		rt.new_string('shop_order_refund'),
	])).str()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refund_parent_column() string {
	return 'refunds.post_parent'
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_batch_refund_totals(mut var_order_ids Class_array) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_id_list := rt.call_function('implode', [rt.new_string(', '),
		rt.call_function('array_map', [rt.new_string('absint'), var_order_ids])])
	mut var_refund_totals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT posts.post_parent AS order_id, SUM( postmeta.meta_value ) AS total\n\t\t\t\tFROM %i AS postmeta\n\t\t\t\tINNER JOIN %i AS posts ON ( posts.post_type = 'shop_order_refund' AND posts.post_parent IN ( ${var_id_list.to_string()} ) )\n\t\t\t\tWHERE postmeta.meta_key = '_refund_amount'\n\t\t\t\tAND postmeta.post_id = posts.ID\n\t\t\t\tGROUP BY posts.post_parent"),
			rt.get_property(var_wpdb, 'postmeta'),
			rt.get_property(var_wpdb, 'posts'),
		]),
	])
	mut var_totals_by_order := []rt.PhpVal{}
	mut iter_18 := var_refund_totals.iterator()
	for {
		item_18 := iter_18.next() or { break }
		mut var_row := item_18.val
		var_totals_by_order.array_set(rt.get_property(var_row, 'order_id'), rt.get_property(var_row,
			'total').to_f64())
	}
	return var_totals_by_order.clone()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_refunded_item_meta_total(var_order rt.PhpVal, item_type string, mut var_meta_keys Class_array) f64 {
	mut var_wpdb := rt.new_null()
	mut var_refund_join := rt.new_string(this.get_refund_orders_join_clause((rt.call_method(var_order,
		'get_id', []rt.PhpVal{})).to_i64()))
	mut var_meta_placeholder := rt.call_function('implode', [
		rt.new_string(', '),
		rt.call_function('array_fill', [rt.new_int(0),
			rt.new_int(var_meta_keys.array_count()), rt.new_string('%s')])])
	mut var_total := if !(rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string('SELECT SUM( order_itemmeta.meta_value )\n\t\t\t\tFROM %i AS order_itemmeta\n\t\t\t\tINNER JOIN ${var_refund_join.to_string()}\n\t\t\t\tINNER JOIN %i AS order_items ON ( order_items.order_id = refunds.id AND order_items.order_item_type = %s )\n\t\t\t\tWHERE order_itemmeta.order_item_id = order_items.order_item_id\n\t\t\t\tAND order_itemmeta.meta_key IN ( ${var_meta_placeholder.to_string()} )'),
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_itemmeta'),
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items'),
			rt.new_string(item_type),
			var_meta_keys,
		]),
	])).is_null() { rt.call_method(var_wpdb, 'get_var', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.new_string('SELECT SUM( order_itemmeta.meta_value )\n\t\t\t\tFROM %i AS order_itemmeta\n\t\t\t\tINNER JOIN ${var_refund_join.to_string()}\n\t\t\t\tINNER JOIN %i AS order_items ON ( order_items.order_id = refunds.id AND order_items.order_item_type = %s )\n\t\t\t\tWHERE order_itemmeta.order_item_id = order_items.order_item_id\n\t\t\t\tAND order_itemmeta.meta_key IN ( ${var_meta_placeholder.to_string()} )'),
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_itemmeta'),
				rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items'),
				rt.new_string(item_type),
				var_meta_keys,
			]),
		]) } else { rt.new_int(0) }
	return (rt.call_function('abs', [var_total.clone()])).to_f64()
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_total_tax_refunded(var_order rt.PhpVal) rt.PhpVal {
	return rt.new_float(this.get_refunded_item_meta_total(var_order.clone(), 'tax', mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: 'tax_amount' },
		rt.ArrayItem{ key: none, val: 'shipping_tax_amount' },
	]))))
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_total_shipping_tax_refunded(var_order rt.PhpVal) rt.PhpVal {
	return rt.new_float(this.get_refunded_item_meta_total(var_order.clone(), 'tax', mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: 'shipping_tax_amount' },
	]))))
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) get_total_shipping_refunded(var_order rt.PhpVal) rt.PhpVal {
	return rt.new_float(this.get_refunded_item_meta_total(var_order.clone(), 'shipping', mut rt.cast_object_ptr[Class_array](rt.create_array([
		rt.ArrayItem{ key: none, val: 'cost' },
	]))))
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) prime_refund_total_caches_for_orders(var_order_ids rt.PhpVal, var_query_vars rt.PhpVal) {
	mut var_wpdb := rt.new_null()
	mut iife_temp_8 := Class_WC_Cache_Helper{}
	mut iife_result_8 := iife_temp_8.get_cache_prefix(rt.new_string('orders'))
	mut var_cache_prefix := iife_result_8
	mut var_total_keys := []rt.PhpVal{}
	mut var_tax_keys := []rt.PhpVal{}
	mut var_non_cached_ids := []rt.PhpVal{}
	mut iter_19 := var_order_ids.iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_order_id := item_19.val
		var_total_keys.array_set(var_order_id, var_cache_prefix.str() + 'total_refunded' +
			var_order_id.str())
		var_tax_keys.array_set(var_order_id, var_cache_prefix.str() + 'total_tax_refunded' +
			var_order_id.str())
	}
	mut var_all_keys := rt.call_function('array_merge', [
		rt.call_function('array_values', [var_total_keys.clone()]),
		rt.call_function('array_values', [var_tax_keys.clone()]),
	])
	mut var_cache_values := rt.call_function('wc_cache_get_multiple', [
		var_all_keys.clone(), rt.new_string('orders')])
	if !(var_cache_values.clone().is_array()) {
		var_non_cached_ids = var_order_ids
	} else {
		mut iter_20 := var_order_ids.iterator()
		for {
			item_20 := iter_20.next() or { break }
			mut var_order_id := item_20.val
			if rt.is_true(rt.identical(rt.new_bool(false), var_cache_values.array_get(var_total_keys.array_get(var_order_id))))
				|| rt.is_true(rt.identical(rt.new_bool(false), var_cache_values.array_get(var_tax_keys.array_get(var_order_id)))) {
				var_non_cached_ids.array_push(var_order_id.clone())
			}
		}
	}
	if !rt.is_true(var_non_cached_ids) {
		return
	}
	mut var_totals_by_order :=
		this.get_batch_refund_totals(mut rt.cast_object_ptr[Class_array](var_non_cached_ids))
	mut iter_21 := var_non_cached_ids.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_order_id := item_21.val
		rt.call_function('wp_cache_set', [var_total_keys.array_get(var_order_id), if !(var_totals_by_order.array_get(var_order_id)).is_null() {
			var_totals_by_order.array_get(var_order_id)
		} else {
			rt.new_float(0)
		}, rt.new_string('orders')])
	}
	mut var_refund_join :=
		rt.new_string(this.get_refund_orders_batch_join_clause(mut rt.cast_object_ptr[Class_array](var_non_cached_ids)))
	mut var_parent_col := rt.new_string(this.get_refund_parent_column())
	mut var_tax_totals := rt.call_method(var_wpdb, 'get_results', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.new_string("SELECT ${var_parent_col.to_string()} AS order_id, SUM( order_itemmeta.meta_value ) AS total\n\t\t\t\tFROM %i AS order_itemmeta\n\t\t\t\tINNER JOIN ${var_refund_join.to_string()}\n\t\t\t\tINNER JOIN %i AS order_items ON ( order_items.order_id = refunds.id AND order_items.order_item_type = 'tax' )\n\t\t\t\tWHERE order_itemmeta.order_item_id = order_items.order_item_id\n\t\t\t\tAND order_itemmeta.meta_key IN ('tax_amount', 'shipping_tax_amount')\n\t\t\t\tGROUP BY ${var_parent_col.to_string()}"),
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_itemmeta'),
			rt.new_string((rt.get_property(var_wpdb, 'prefix')).str() + 'woocommerce_order_items'),
		]),
	])
	mut var_tax_by_order := []rt.PhpVal{}
	mut iter_22 := var_tax_totals.iterator()
	for {
		item_22 := iter_22.next() or { break }
		mut var_row := item_22.val
		var_tax_by_order.array_set(rt.get_property(var_row, 'order_id'), rt.call_function('abs', [
			rt.new_float(rt.get_property(var_row, 'total').to_f64()),
		]))
	}
	mut iter_23 := var_non_cached_ids.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_order_id := item_23.val
		rt.call_function('wp_cache_set', [var_tax_keys.array_get(var_order_id), if !(var_tax_by_order.array_get(var_order_id)).is_null() {
			var_tax_by_order.array_get(var_order_id)
		} else {
			rt.new_float(0)
		}, rt.new_string('orders')])
	}
}

struct Class_WC_Data_Store_WP {
	rt.PhpObjectBase
}

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
	message string
	code    i64
	file    string
	line    i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_OrderUtil {
	rt.PhpObjectBase
}

struct Class_WC_Order_Item {
	rt.PhpObjectBase
}

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
}

fn create_abstract_wc_order_data_store_cpt(_args ...rt.PhpVal) &Class_Abstract_WC_Order_Data_Store_CPT {
	mut obj := &Class_Abstract_WC_Order_Data_Store_CPT{
		PhpObjectBase:                   rt.PhpObjectBase{}
		meta_type:                       rt.new_string('post')
		internal_meta_keys:              rt.new_array()
		internal_data_store_key_getters: rt.new_array()
	}
	return obj
}

fn create_wc_data_store_wp(_args ...rt.PhpVal) &Class_WC_Data_Store_WP {
	mut obj := &Class_WC_Data_Store_WP{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message:       ''
		code:          i64(0)
		file:          ''
		line:          i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_orderutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_OrderUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_OrderUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_order_item(_args ...rt.PhpVal) &Class_WC_Order_Item {
	mut obj := &Class_WC_Order_Item{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_cache_helper(_args ...rt.PhpVal) &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_internal_data_store_key_getters' {
			return this.get_internal_data_store_key_getters()
		}
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.create(dispatch_arg_0)
			return rt.new_null()
		}
		'order_exists' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.order_exists(dispatch_arg_0))
		}
		'read' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.read(dispatch_arg_0)
			return rt.new_null()
		}
		'set_order_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.set_order_props(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update(dispatch_arg_0)
			return rt.new_null()
		}
		'delete' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_post_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post_status(dispatch_arg_0)
		}
		'get_post_excerpt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_post_excerpt(dispatch_arg_0))
		}
		'get_post_title' {
			return this.get_post_title()
		}
		'get_order_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_key(dispatch_arg_0)
		}
		'read_order_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.read_order_data(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_post_meta' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_post_meta(dispatch_arg_0)
			return rt.new_null()
		}
		'clear_caches' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.clear_caches(dispatch_arg_0)
			return rt.new_null()
		}
		'read_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.read_items(dispatch_arg_0, dispatch_arg_1)
		}
		'get_order_item_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_order_item_type(dispatch_arg_0, dispatch_arg_1)
		}
		'prime_order_item_caches_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_order_item_caches_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prime_product_post_caches_for_order_items' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.prime_product_post_caches_for_order_items(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'prime_refund_caches_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_refund_caches_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'prime_needs_processing_transients' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_needs_processing_transients(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.delete_items(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_payment_token_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_payment_token_ids(dispatch_arg_0)
		}
		'update_payment_token_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.update_payment_token_ids(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_title' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WC_Order](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_title(mut dispatch_arg_0)
		}
		'update_order_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_order_from_object(dispatch_arg_0))
		}
		'update_post_modified_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update_post_modified_data(dispatch_arg_0, dispatch_arg_1)
		}
		'update_order_meta_from_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.update_order_meta_from_object(dispatch_arg_0)
			return rt.new_null()
		}
		'get_refund_orders_join_clause' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_string(this.get_refund_orders_join_clause(dispatch_arg_0))
		}
		'get_refund_orders_batch_join_clause' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_refund_orders_batch_join_clause(mut dispatch_arg_0))
		}
		'get_refund_parent_column' {
			return rt.new_string(this.get_refund_parent_column())
		}
		'get_batch_refund_totals' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.get_batch_refund_totals(mut dispatch_arg_0)
		}
		'get_refunded_item_meta_total' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_float(this.get_refunded_item_meta_total(dispatch_arg_0, dispatch_arg_1, mut
				dispatch_arg_2))
		}
		'get_total_tax_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_tax_refunded(dispatch_arg_0)
		}
		'get_total_shipping_tax_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_shipping_tax_refunded(dispatch_arg_0)
		}
		'get_total_shipping_refunded' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_total_shipping_refunded(dispatch_arg_0)
		}
		'prime_refund_total_caches_for_orders' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.prime_refund_total_caches_for_orders(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Abstract_WC_Order_Data_Store_CPT) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'meta_type' { return this.meta_type }
		'internal_meta_keys' { return this.internal_meta_keys }
		'internal_data_store_key_getters' { return this.internal_data_store_key_getters }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Abstract_WC_Order_Data_Store_CPT) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'meta_type' {
			this.meta_type = val
			return true
		}
		'internal_meta_keys' {
			this.internal_meta_keys = val
			return true
		}
		'internal_data_store_key_getters' {
			this.internal_data_store_key_getters = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Data_Store_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Data_Store_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Data_Store_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' {
			this.message = val.str()
			return true
		}
		'code' {
			this.code = val.to_i64()
			return true
		}
		'file' {
			this.file = val.str()
			return true
		}
		'line' {
			this.line = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_OrderUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Order_Item) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Order_Item) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Order_Item) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn init_registry() {
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}

import rt

struct Class_WC_REST_Coupons_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('coupons')
	post_type rt.PhpVal = rt.new_string('shop_coupon')
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) construct() {
	rt.call_function('add_filter', [
		rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type),
			rt.new_string('_query')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
				'WC_REST_Posts_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'query_args' },
		]),
		rt.new_int(10),
		rt.new_int(2),
	])
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [
					this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()),
					rt.create_array([
						rt.ArrayItem{ key: 'code', val: rt.create_array([
							rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
								rt.new_string('Coupon code.'),
								rt.new_string('woocommerce'),
							]) },
							rt.ArrayItem{ key: 'required', val: true },
							rt.ArrayItem{ key: 'type', val: 'string' },
						]) },
					]),
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
					'WC_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to bypass trash and force deletion.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
					'WC_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/batch'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
						'WC_REST_Posts_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
					'WC_REST_Posts_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_batch_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) query_args(var_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_request_mutated := var_request
	mut var_coupon_code := if !(var_request_mutated.array_get(rt.new_string('code'))).is_null() {
		var_request_mutated.array_get(rt.new_string('code'))
	} else {
		rt.new_null()
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
	mut iife_result_0 := iife_temp_0.is_null_or_whitespace(var_coupon_code.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		mut var_id := rt.call_function('wc_get_coupon_id_by_code', [
			var_coupon_code.clone()])
		var_args_mutated.array_set('post__in', rt.create_array([
			rt.ArrayItem{ key: none, val: var_id },
		]))
	}
	return var_args_mutated.clone()
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) prepare_item_for_response(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_request_mutated := var_request
	mut var_coupon :=
		create_wc_coupon(rt.new_int((rt.get_property(var_post_mutated, 'ID')).to_i64()))
	mut var__data := rt.call_method(var_coupon, 'get_data', []rt.PhpVal{})
	mut var_format_decimal := ['amount', 'minimum_amount', 'maximum_amount']
	mut var_format_date := ['date_created', 'date_modified']
	mut var_format_date_utc := ['date_expires']
	mut var_format_null := ['usage_limit', 'usage_limit_per_user']
	for var_key in var_format_decimal {
		var__data.array_set(key, rt.call_function('wc_format_decimal', [
			var__data.array_get(rt.new_string(key)),
			rt.new_int(2),
		]))
	}
	for var_key in var_format_date {
		var__data.array_set(key, if rt.is_true(var__data.array_get(rt.new_string(key))) { rt.call_function('wc_rest_prepare_date_response', [
				var__data.array_get(rt.new_string(key)),
				rt.new_bool(false),
			]) } else { rt.new_null() })
	}
	for var_key in var_format_date_utc {
		var__data.array_set(key, if rt.is_true(var__data.array_get(rt.new_string(key))) { rt.call_function('wc_rest_prepare_date_response', [
				var__data.array_get(rt.new_string(key)),
			]) } else { rt.new_null() })
	}
	for var_key in var_format_null {
		var__data.array_set(key, if rt.is_true(var__data.array_get(rt.new_string(key))) {
			var__data.array_get(rt.new_string(key))
		} else {
			rt.new_null()
		})
	}
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: var__data.array_get(rt.new_string('id')) },
		rt.ArrayItem{ key: 'code', val: var__data.array_get(rt.new_string('code')) },
		rt.ArrayItem{ key: 'date_created', val: var__data.array_get(rt.new_string('date_created')) },
		rt.ArrayItem{ key: 'date_modified', val: var__data.array_get(rt.new_string('date_modified')) },
		rt.ArrayItem{ key: 'discount_type', val: var__data.array_get(rt.new_string('discount_type')) },
		rt.ArrayItem{ key: 'description', val: var__data.array_get(rt.new_string('description')) },
		rt.ArrayItem{ key: 'amount', val: var__data.array_get(rt.new_string('amount')) },
		rt.ArrayItem{ key: 'expiry_date', val: var__data.array_get(rt.new_string('date_expires')) },
		rt.ArrayItem{ key: 'usage_count', val: var__data.array_get(rt.new_string('usage_count')) },
		rt.ArrayItem{
			key: 'individual_use'
			val: var__data.array_get(rt.new_string('individual_use'))
		},
		rt.ArrayItem{ key: 'product_ids', val: var__data.array_get(rt.new_string('product_ids')) },
		rt.ArrayItem{
			key: 'exclude_product_ids'
			val: var__data.array_get(rt.new_string('excluded_product_ids'))
		},
		rt.ArrayItem{ key: 'usage_limit', val: var__data.array_get(rt.new_string('usage_limit')) },
		rt.ArrayItem{
			key: 'usage_limit_per_user'
			val: var__data.array_get(rt.new_string('usage_limit_per_user'))
		},
		rt.ArrayItem{
			key: 'limit_usage_to_x_items'
			val: var__data.array_get(rt.new_string('limit_usage_to_x_items'))
		},
		rt.ArrayItem{ key: 'free_shipping', val: var__data.array_get(rt.new_string('free_shipping')) },
		rt.ArrayItem{
			key: 'product_categories'
			val: var__data.array_get(rt.new_string('product_categories'))
		},
		rt.ArrayItem{
			key: 'excluded_product_categories'
			val: var__data.array_get(rt.new_string('excluded_product_categories'))
		},
		rt.ArrayItem{
			key: 'exclude_sale_items'
			val: var__data.array_get(rt.new_string('exclude_sale_items'))
		},
		rt.ArrayItem{
			key: 'minimum_amount'
			val: var__data.array_get(rt.new_string('minimum_amount'))
		},
		rt.ArrayItem{
			key: 'maximum_amount'
			val: var__data.array_get(rt.new_string('maximum_amount'))
		},
		rt.ArrayItem{
			key: 'email_restrictions'
			val: var__data.array_get(rt.new_string('email_restrictions'))
		},
		rt.ArrayItem{ key: 'used_by', val: var__data.array_get(rt.new_string('used_by')) },
	])
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) {
		var_request_mutated.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_post_mutated.clone(), var_request_mutated.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('woocommerce_rest_prepare_'), this.post_type),
		var_response.clone(),
		var_post_mutated.clone(),
		var_request_mutated.clone(),
	])
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) filter_writable_props(var_schema rt.PhpVal) rt.PhpVal {
	mut var_schema_mutated := var_schema
	return rt.new_bool(!rt.is_true(var_schema_mutated.array_get(rt.new_string('readonly'))))
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_id := if var_request_mutated.array_isset(rt.new_string('id')) { rt.call_function('absint', [
			var_request_mutated.array_get(rt.new_string('id')),
		]) } else { rt.new_int(0) }
	mut var_coupon := create_wc_coupon(var_id.clone())
	mut var_schema := this.get_item_schema()
	mut var_data_keys := rt.func_array_keys(rt.call_function('array_filter', [
		var_schema.array_get(rt.new_string('properties')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Coupons_V1_Controller', [
				'WC_REST_Posts_Controller',
			], &this) },
			rt.ArrayItem{ key: none, val: 'filter_writable_props' },
		]),
	]))
	if rt.is_true(var_request_mutated.array_get(rt.new_string('exclude_product_ids'))) {
		var_request_mutated.array_set('excluded_product_ids',
			var_request_mutated.array_get(rt.new_string('exclude_product_ids')))
	}
	if rt.is_true(var_request_mutated.array_get(rt.new_string('expiry_date'))) {
		var_request_mutated.array_set('date_expires',
			var_request_mutated.array_get(rt.new_string('expiry_date')))
	}
	if rt.is_true(rt.identical(rt.new_string('POST'), rt.call_method(var_request_mutated, 'get_method', []rt.PhpVal{})))
		&& rt.is_true(rt.identical(rt.new_int(0), rt.call_method(var_coupon, 'get_id', []rt.PhpVal{}))) {
		mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_StringUtil{}
		mut iife_result_1 := iife_temp_1.is_null_or_whitespace(if !(var_request_mutated.array_get(rt.new_string('code'))).is_null() {
			var_request_mutated.array_get(rt.new_string('code'))
		} else {
			rt.new_null()
		})
		if rt.is_true(iife_result_1) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_empty_coupon_code'), rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The coupon code cannot be empty.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('code'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
	}
	mut iter_1 := var_data_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		mut var_value := var_request_mutated.array_get(var_key)
		if !(var_value.clone().is_null()) {
			mut switch_val_1 := var_key
			if rt.is_true(rt.equal(switch_val_1, rt.new_string('code'))) {
				mut var_coupon_code := rt.call_function('wc_format_coupon_code', [
					var_value.clone(),
				])
				var_id = if rt.is_true(rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})) {
					rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})
				} else {
					rt.new_int(0)
				}
				mut var_id_from_code := rt.call_function('wc_get_coupon_id_by_code', [
					var_coupon_code.clone(),
					var_id.clone(),
				])
				if rt.is_true(var_id_from_code) {
					return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_coupon_code_already_exists'), rt.call_function('__', [
						rt.new_string('The coupon code already exists'),
						rt.new_string('woocommerce'),
					]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
				}
				rt.call_method(var_coupon, 'set_code', [var_coupon_code.clone()])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('description'))) {
				rt.call_method(var_coupon, 'set_description', [
					rt.call_function('wp_filter_post_kses', [
						var_value.clone()]),
				])
			} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('expiry_date'))) {
				rt.call_method(var_coupon, 'set_date_expires', [
					var_value.clone()])
			} else {
				if rt.is_true(rt.call_function('is_callable', [
					rt.create_array([rt.ArrayItem{ key: none, val: var_coupon },
						rt.ArrayItem{ key: none, val: 'set_${var_key.to_string()}' }]),
				]))
				{
					rt.call_method(var_coupon, 'set_${var_key.to_string()}', [
						var_value.clone()])
				}
			}
		}
	}
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('woocommerce_rest_pre_insert_'), this.post_type),
		var_coupon.clone(),
		var_request_mutated.clone(),
	])
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Cannot create existing %s.'),
				rt.new_string('woocommerce')]),
			this.post_type,
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_coupon_id := this.save_coupon(var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_coupon_id.clone()])) {
		return var_coupon_id.clone()
	}
	mut var_post := rt.call_function('get_post', [var_coupon_id.clone()])
	this.update_additional_fields_for_object(var_post.clone(), var_request_mutated.clone())
	this.add_post_meta_fields(var_post.clone(), var_request_mutated.clone())
	rt.call_function('do_action', [
		rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type),
		var_post.clone(),
		var_request_mutated.clone(),
		rt.new_bool(true),
	])
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.clone(),
		var_request_mutated.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base,
				rt.get_property(var_post, 'ID')]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_post_id := rt.new_int((var_request_mutated.array_get(rt.new_string('id'))).to_i64())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if !rt.is_true(var_post_id)
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_post_type', [var_post_id.clone()]), this.post_type)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'),
			this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [
			rt.new_string('ID is invalid.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_coupon_id := this.save_coupon(var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_coupon_id.clone()])) {
		return var_coupon_id.clone()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_post := rt.call_function('get_post', [var_coupon_id.clone()])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	this.update_additional_fields_for_object(var_post.clone(), var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_function('do_action', [
		rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type),
		var_post.clone(),
		var_request_mutated.clone(),
		rt.new_bool(false),
	])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	rt.call_method(var_request_mutated, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut var_response := this.prepare_item_for_response(var_post.clone(),
		var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	return rt.call_function('rest_ensure_response', [var_response.clone()])
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'Exception') {
		mut var_e := var_e_1.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) save_coupon(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_coupon := this.prepare_item_for_database(var_request_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_coupon.clone()])) {
		return var_coupon.clone()
	}
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	rt.call_method(var_coupon, 'save', []rt.PhpVal{})
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	return rt.call_method(var_coupon, 'get_id', []rt.PhpVal{})
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'WC_Data_Exception') {
		mut var_e := var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.call_method(var_e,
			'getErrorData', []rt.PhpVal{})))
		unsafe {
			goto end_label_2
		}
	} else if rt.instance_of(var_e_2, 'WC_REST_Exception') {
		var_e = var_e_2.clone()
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.call_method(var_e,
			'getErrorCode', []rt.PhpVal{}), rt.call_method(var_e, 'getMessage', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_method(var_e, 'getCode', []rt.PhpVal{}) },
		])))
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return rt.new_null()
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: this.post_type },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the object.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'code', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Coupon code.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'date_created', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("The date the coupon was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'date_modified', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("The date the coupon was last modified, in the site's timezone."),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Coupon description.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'discount_type', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Determines the type of discount that will be applied.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: 'fixed_cart' },
				rt.ArrayItem{ key: 'enum', val: rt.func_array_keys(rt.call_function('wc_get_coupon_types',
					[]rt.PhpVal{})) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'amount', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The amount of discount. Should always be numeric, even if setting a percentage.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'expiry_date', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('UTC DateTime when the coupon expires.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usage_count', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Number of times the coupon has been used already.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'individual_use', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('If true, the coupon can only be used individually. Other applied coupons will be removed from the cart.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'default', val: false },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'product_ids', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of product IDs the coupon can be used on.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'exclude_product_ids', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of product IDs the coupon cannot be used on.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usage_limit', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('How many times the coupon can be used in total.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'usage_limit_per_user', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('How many times the coupon can be used per customer.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'limit_usage_to_x_items', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Max number of items in the cart the coupon can be applied to.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'free_shipping', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('If true and if the free shipping method requires a coupon, this coupon will enable free shipping.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'default', val: false },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'product_categories', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of category IDs the coupon applies to.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'excluded_product_categories', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of category IDs the coupon does not apply to.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'exclude_sale_items', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('If true, this coupon will not be applied to items that have sale prices.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'default', val: false },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'minimum_amount', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Minimum order amount that needs to be in the cart before coupon applies.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'maximum_amount', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Maximum order amount allowed when using the coupon.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'email_restrictions', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of email addresses that can use this coupon.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
			rt.ArrayItem{ key: 'used_by', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('List of user IDs (or guest email addresses) that have used the coupon.'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) get_collection_params() rt.PhpVal {
	mut var_params := this.Class_WC_REST_Posts_Controller.get_collection_params()
	var_params.array_set('code', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to resources with a specific code.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
		rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' },
	]))
	return var_params.clone()
}

struct Class_WC_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Utilities_StringUtil {
	rt.PhpObjectBase
}

struct Class_WC_Coupon {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_coupons_v1_controller() &Class_WC_REST_Coupons_V1_Controller {
	mut obj := &Class_WC_REST_Coupons_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('coupons')
		post_type:     rt.new_string('shop_coupon')
	}
	obj.construct()
	return obj
}

fn create_wc_rest_posts_controller(_args ...rt.PhpVal) &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_utilities_stringutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_StringUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_StringUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_coupon(_args ...rt.PhpVal) &Class_WC_Coupon {
	mut obj := &Class_WC_Coupon{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.query_args(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_writable_props' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_writable_props(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'save_coupon' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save_coupon(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Coupons_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Coupons_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		'post_type' {
			this.post_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_StringUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Coupon) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Coupon) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Coupon) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

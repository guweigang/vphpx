import rt

struct Class_WC_REST_Taxes_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('taxes')
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) construct() {
	this.initialize_rest_api_cache()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str()), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_tax_rates' }, rt.ArrayItem{ key: 'relevant_version_strings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'list_tax_rates' }]) }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as resource does not support trashing.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' + (this.rest_base).str() + '/batch'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('create')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('edit')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('delete')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [rt.new_string('settings'), rt.new_string('batch')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_prepared_args := rt.new_array()
	var_prepared_args.array_set('order', var_request.array_get(rt.new_string('order')))
	var_prepared_args.array_set('number', var_request.array_get(rt.new_string('per_page')))
	if !(!rt.is_true(var_request.array_get(rt.new_string('offset')))) {
		var_prepared_args.array_set('offset', var_request.array_get(rt.new_string('offset')))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request.array_get(rt.new_string('page')), rt.new_int(1)), var_prepared_args.array_get(rt.new_string('number'))))
	}
	mut var_orderby_possibles := rt.create_array([rt.ArrayItem{ key: 'id', val: 'tax_rate_id' }, rt.ArrayItem{ key: 'order', val: 'tax_rate_order' }, rt.ArrayItem{ key: 'priority', val: 'tax_rate_priority' }])
	var_prepared_args.array_set('orderby', var_orderby_possibles.array_get(var_request.array_get(rt.new_string('orderby'))))
	var_prepared_args.array_set('class', var_request.array_get(rt.new_string('class')))
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_tax_query'), var_prepared_args.clone(), var_request.clone()])
	mut var_orderby := rt.new_string((rt.call_function('sanitize_key', [var_prepared_args.array_get(rt.new_string('orderby'))])).str() + ' ' + (rt.call_function('sanitize_key', [var_prepared_args.array_get(rt.new_string('order'))])).str())
	mut var_query := rt.new_string((rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT *\n\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates\n\t\t\t%s\n\t\t\tORDER BY ')), var_orderby), rt.new_string('\n\t\t\tLIMIT %%d, %%d\n\t\t'))).str())
	mut var_wpdb_prepare_args := [var_prepared_args.array_get(rt.new_string('offset')), var_prepared_args.array_get(rt.new_string('number'))]
	if !rt.is_true(var_prepared_args.array_get(rt.new_string('class'))) {
	var_query = rt.call_function('sprintf', [var_query.clone(), rt.new_string('')])
	} else {
		mut var_class := if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('standard'), var_prepared_args.array_get(rt.new_string('class')))))) { rt.call_function('sanitize_title', [var_prepared_args.array_get(rt.new_string('class'))]) } else { rt.new_string('') }
		rt.call_function('array_unshift', [rt.create_array_from_list(var_wpdb_prepare_args), var_class.clone()])
	var_query = rt.call_function('sprintf', [var_query.clone(), rt.new_string('WHERE tax_rate_class = %s')])
	}
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [var_query.clone(), rt.create_array_from_list(var_wpdb_prepare_args)])])
	mut var_taxes := rt.new_array()
	mut iter_1 := var_results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_tax := item_1.val
		mut var_data := this.prepare_item_for_response(var_tax.clone(), var_request.clone())
		var_taxes << this.prepare_response_for_collection(var_data.clone())
	}
	mut var_response := rt.call_function('rest_ensure_response', [rt.create_array_from_list(var_taxes)])
	mut var_per_page := rt.new_int((var_prepared_args.array_get(rt.new_string('number'))).to_i64())
	mut var_page := rt.call_function('ceil', [rt.add(rt.div(rt.new_int((var_prepared_args.array_get(rt.new_string('offset'))).to_i64()), var_per_page), rt.new_int(1))])
	rt.call_function('array_splice', [rt.create_array_from_list(var_wpdb_prepare_args), rt.new_int(-2)])
	var_query = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'SELECT *' }, rt.ArrayItem{ key: none, val: 'LIMIT %d, %d' }]), rt.create_array([rt.ArrayItem{ key: none, val: 'SELECT COUNT(*)' }, rt.ArrayItem{ key: none, val: '' }]), var_query.clone()])
	mut var_total_taxes := rt.new_int((rt.call_method(var_wpdb, 'get_var', [if !rt.is_true(var_wpdb_prepare_args) { var_query } else { rt.call_method(var_wpdb, 'prepare', [var_query.clone(), rt.create_array_from_list(var_wpdb_prepare_args)]) }])).to_i64())
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total_taxes.clone()])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_taxes, var_per_page)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), rt.new_int((var_max_pages).to_i64())])
	mut var_base := rt.call_function('add_query_arg', [rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])])])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
		var_prev_page = var_max_pages.clone()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.clone()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.clone(), var_base.clone()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.clone()])
	}
	return var_response.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) create_or_update_tax(var_request rt.PhpVal, var_current rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_function('absint', [if var_request.array_isset(rt.new_string('id')) { var_request.array_get(rt.new_string('id')) } else { rt.new_int(0) }])
	mut var_data := rt.new_array()
	mut var_fields := ['tax_rate_country', 'tax_rate_state', 'tax_rate', 'tax_rate_name', 'tax_rate_priority', 'tax_rate_compound', 'tax_rate_shipping', 'tax_rate_order', 'tax_rate_class']
	for var_field in var_fields {
		mut var_key := if rt.is_true(rt.identical(rt.new_string('tax_rate'), rt.new_string(field))) { rt.new_string('rate') } else { rt.call_function('str_replace', [rt.new_string('tax_rate_'), rt.new_string(''), rt.new_string(field)]) }
		if !(var_request.array_isset(var_key)) {
			continue
		}
		if rt.is_true(var_current) && rt.is_true(rt.identical(rt.get_property(var_current, '{"nodeType":"Expr_Variable","line":373,"name":"field"}'), var_request.array_get(var_key))) {
			continue
		}
		mut switch_val_1 := rt.new_string(field)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_priority'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_compound'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_shipping'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_order'))) {
			var_data.array_set(field, rt.call_function('absint', [var_request.array_get(var_key)]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_class'))) {
			var_data.array_set(field, if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('standard'), var_request.array_get(var_key))))) { var_request.array_get(var_key) } else { rt.new_string('') })
		} else {
			var_data.array_set(field, rt.call_function('wc_clean', [var_request.array_get(var_key)]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
	mut iife_temp_0 := Class_WC_Tax{}
	mut iife_result_0 := iife_temp_0._insert_tax_rate(var_data.clone())
	var_id = iife_result_0
	} else if rt.is_true(var_data) {
	mut iife_temp_1 := Class_WC_Tax{}
	mut iife_result_1 := iife_temp_1._update_tax_rate(var_id.clone(), var_data.clone())
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('postcode')))) {
	mut iife_temp_2 := Class_WC_Tax{}
	mut iife_result_2 := iife_temp_2._update_tax_rate_postcodes(var_id.clone(), rt.call_function('wc_clean', [var_request.array_get(rt.new_string('postcode'))]))
	}
	if !(!rt.is_true(var_request.array_get(rt.new_string('city')))) {
	mut iife_temp_3 := Class_WC_Tax{}
	mut iife_result_3 := iife_temp_3._update_tax_rate_cities(var_id.clone(), rt.call_function('wc_clean', [var_request.array_get(rt.new_string('city'))]))
	}
	mut iife_temp_4 := Class_WC_Tax{}
	mut iife_result_4 := iife_temp_4._get_tax_rate(var_id.clone(), rt.get_constant('OBJECT'))
	return iife_result_4
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_tax_exists'), rt.call_function('__', [rt.new_string('Cannot create existing resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_tax := this.create_or_update_tax(var_request.clone(), rt.new_null())
	this.update_additional_fields_for_object(var_tax.clone(), var_request.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_tax'), var_tax.clone(), var_request.clone(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tax.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.get_property(var_tax, 'tax_rate_id')])])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut iife_temp_5 := Class_WC_Tax{}
	mut iife_result_5 := iife_temp_5._get_tax_rate(var_id.clone(), rt.get_constant('OBJECT'))
	mut var_tax_obj := iife_result_5
	if !rt.is_true(var_id) || !rt.is_true(var_tax_obj) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [rt.new_string('Invalid resource ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_tax := this.prepare_item_for_response(var_tax_obj.clone(), var_request.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_tax.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut iife_temp_6 := Class_WC_Tax{}
	mut iife_result_6 := iife_temp_6._get_tax_rate(var_id.clone(), rt.get_constant('OBJECT'))
	mut var_tax_obj := iife_result_6
	if !rt.is_true(var_id) || !rt.is_true(var_tax_obj) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [rt.new_string('Invalid resource ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_tax := this.create_or_update_tax(var_request.clone(), var_tax_obj.clone())
	this.update_additional_fields_for_object(var_tax.clone(), var_request.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_tax'), var_tax.clone(), var_request.clone(), rt.new_bool(false)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tax.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [var_response.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_id := rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64())
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) { (var_request.array_get(rt.new_string('force'))).to_bool() } else { false })
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('__', [rt.new_string('Taxes do not support trashing.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	mut iife_temp_7 := Class_WC_Tax{}
	mut iife_result_7 := iife_temp_7._get_tax_rate(var_id.clone(), rt.get_constant('OBJECT'))
	mut var_tax := iife_result_7
	if !rt.is_true(var_id) || !rt.is_true(var_tax) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [rt.new_string('Invalid resource ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tax.clone(), var_request.clone())
	mut iife_temp_8 := Class_WC_Tax{}
	mut iife_result_8 := iife_temp_8._delete_tax_rate(var_id.clone())
	if rt.is_true(rt.identical(rt.new_int(0), rt.get_property(var_wpdb, 'rows_affected'))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('The resource cannot be deleted.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_delete_tax'), var_tax.clone(), var_response.clone(), var_request.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) prepare_item_for_response(var_tax rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_tax_mutated := var_tax
	mut var_id := rt.new_int((rt.get_property(var_tax_mutated, 'tax_rate_id')).to_i64())
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }, rt.ArrayItem{ key: 'country', val: rt.get_property(var_tax_mutated, 'tax_rate_country') }, rt.ArrayItem{ key: 'state', val: rt.get_property(var_tax_mutated, 'tax_rate_state') }, rt.ArrayItem{ key: 'postcode', val: '' }, rt.ArrayItem{ key: 'city', val: '' }, rt.ArrayItem{ key: 'rate', val: rt.get_property(var_tax_mutated, 'tax_rate') }, rt.ArrayItem{ key: 'name', val: rt.get_property(var_tax_mutated, 'tax_rate_name') }, rt.ArrayItem{ key: 'priority', val: rt.new_int((rt.get_property(var_tax_mutated, 'tax_rate_priority')).to_i64()) }, rt.ArrayItem{ key: 'compound', val: (rt.get_property(var_tax_mutated, 'tax_rate_compound')).to_bool() }, rt.ArrayItem{ key: 'shipping', val: (rt.get_property(var_tax_mutated, 'tax_rate_shipping')).to_bool() }, rt.ArrayItem{ key: 'order', val: rt.new_int((rt.get_property(var_tax_mutated, 'tax_rate_order')).to_i64()) }, rt.ArrayItem{ key: 'class', val: if rt.is_true(rt.get_property(var_tax_mutated, 'tax_rate_class')) { rt.get_property(var_tax_mutated, 'tax_rate_class') } else { rt.new_string('standard') } }])
	var_data = this.add_tax_rate_locales(var_data.clone(), var_tax_mutated.clone())
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) { var_request.array_get(rt.new_string('context')) } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_tax_mutated.clone())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_tax'), var_response.clone(), var_tax_mutated.clone(), var_request.clone()])
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) prepare_links(var_tax rt.PhpVal) rt.PhpVal {
	mut var_tax_mutated := var_tax
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.get_property(var_tax_mutated, 'tax_rate_id')])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])]) } }
	return var_links.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) add_tax_rate_locales(var_data rt.PhpVal, var_tax rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	mut var_tax_mutated := var_tax
	mut var_locales := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('\n\t\t\t\tSELECT location_code, location_type\n\t\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rate_locations\n\t\t\t\tWHERE tax_rate_id = %d\n\t\t\t\t')), rt.get_property(var_tax_mutated, 'tax_rate_id')])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_tax_mutated.clone()]))))) && !(var_tax_mutated.clone().is_null()) {
		mut iter_2 := var_locales.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_locale := item_2.val
			var_data_mutated.array_set(rt.get_property(var_locale, 'location_type'), rt.get_property(var_locale, 'location_code'))
		}
	}
	return var_data_mutated.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_item_schema() rt.PhpVal {
	mut iife_temp_9 := Class_WC_Tax{}
	mut iife_result_9 := iife_temp_9.get_tax_class_slugs()
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('tax'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'country': { 'description': rt.call_function('__', [rt.new_string('Country ISO 3166 code.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'state': { 'description': rt.call_function('__', [rt.new_string('State code.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'postcode': { 'description': rt.call_function('__', [rt.new_string('Postcode / ZIP.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'city': { 'description': rt.call_function('__', [rt.new_string('City name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'rate': { 'description': rt.call_function('__', [rt.new_string('Tax rate.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'name': { 'description': rt.call_function('__', [rt.new_string('Tax rate name.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'priority': { 'description': rt.call_function('__', [rt.new_string('Tax priority.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'default': rt.new_int(1), 'context': map[string]rt.PhpVal{} }, 'compound': { 'description': rt.call_function('__', [rt.new_string('Whether or not this is a compound rate.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} }, 'shipping': { 'description': rt.call_function('__', [rt.new_string('Whether or not this tax rate also gets applied to shipping.'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(true), 'context': map[string]rt.PhpVal{} }, 'order': { 'description': rt.call_function('__', [rt.new_string('Indicates the order that will appear in queries.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{} }, 'class': { 'description': rt.call_function('__', [rt.new_string('Tax class.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'default': rt.new_string('standard'), 'enum': rt.call_function('array_merge', [map[string]rt.PhpVal{}, iife_result_9]), 'context': map[string]rt.PhpVal{} } } }
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_collection_params() rt.PhpVal {
	mut var_params := rt.new_array()
	var_params['context'] = this.get_context_param()
	var_params.array_get_mut('context').array_set('default', 'view')
	var_params['page'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Current page of the collection.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }, rt.ArrayItem{ key: 'minimum', val: 1 }])
	var_params['per_page'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Maximum number of items to be returned in result set.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: 10 }, rt.ArrayItem{ key: 'minimum', val: 1 }, rt.ArrayItem{ key: 'maximum', val: 100 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }])
	var_params['offset'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Offset the result set by a specific number of items.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }])
	var_params['order'] = rt.create_array([rt.ArrayItem{ key: 'default', val: 'asc' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order sort attribute ascending or descending.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'asc' }, rt.ArrayItem{ key: none, val: 'desc' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }])
	var_params['orderby'] = rt.create_array([rt.ArrayItem{ key: 'default', val: 'order' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sort collection by object attribute.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'order' }, rt.ArrayItem{ key: none, val: 'priority' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_key' }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }])
	mut iife_temp_10 := Class_WC_Tax{}
	mut iife_result_10 := iife_temp_10.get_tax_class_slugs()
	var_params['class'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Sort by tax class.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'enum', val: rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'standard' }]), iife_result_10]) }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_title' }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'validate_callback', val: 'rest_validate_request_arg' }])
	return var_params.clone()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_default_response_entity_type() string {
	return 'tax_rate'
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) response_cache_vary_by_user(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) bool {
	return false
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_hooks_relevant_to_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'woocommerce_rest_prepare_tax' }, rt.ArrayItem{ key: none, val: 'woocommerce_rest_tax_query' }])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_rest_taxes_v1_controller() &Class_WC_REST_Taxes_V1_Controller {
	mut obj := &Class_WC_REST_Taxes_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('taxes')
	}
	obj.construct()
	return obj
}

fn create_wc_rest_controller(_args ...rt.PhpVal) &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
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

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'batch_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.batch_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'create_or_update_tax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.create_or_update_tax(dispatch_arg_0, dispatch_arg_1)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'add_tax_rate_locales' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_tax_rate_locales(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_default_response_entity_type' {
			return rt.new_string(this.get_default_response_entity_type())
		}
		'response_cache_vary_by_user' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_bool(this.response_cache_vary_by_user(mut dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_hooks_relevant_to_caching' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.get_hooks_relevant_to_caching(mut dispatch_arg_0, mut dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Taxes_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		exit(0)
	}
}

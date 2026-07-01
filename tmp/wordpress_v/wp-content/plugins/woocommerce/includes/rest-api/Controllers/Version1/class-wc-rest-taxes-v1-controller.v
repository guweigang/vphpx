import rt

struct Class_WC_REST_Taxes_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('taxes')
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) construct()  {
	this.initialize_rest_api_cache()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]), rt.create_array([rt.ArrayItem{ key: 'endpoint_id', val: 'get_tax_rates' }, rt.ArrayItem{ key: 'relevant_version_strings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'list_tax_rates' }]) }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: this.with_cache(rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }])) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as resource does not support trashing.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/batch', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Taxes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_batch_schema' }]) }])])
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
	// unsupported statement: Stmt_Global
	mut var_prepared_args := rt.new_array()
	var_prepared_args.array_set('order', var_request.array_get('order'))
	var_prepared_args.array_set('number', var_request.array_get('per_page'))
	if !(!rt.is_true(var_request.array_get('offset'))) {
		var_prepared_args.array_set('offset', var_request.array_get('offset'))
	} else {
		var_prepared_args.array_set('offset', rt.mul(rt.sub(var_request.array_get('page'), rt.new_int(1)), var_prepared_args.array_get('number')))
	}
	mut var_orderby_possibles := rt.create_array([rt.ArrayItem{ key: 'id', val: 'tax_rate_id' }, rt.ArrayItem{ key: 'order', val: 'tax_rate_order' }, rt.ArrayItem{ key: 'priority', val: 'tax_rate_priority' }])
	var_prepared_args.array_set('orderby', var_orderby_possibles.array_get(var_request.array_get('orderby')))
	var_prepared_args.array_set('class', var_request.array_get('class'))
	var_prepared_args = rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_tax_query'), var_prepared_args.dup(), var_request.dup()])
	mut var_orderby := rt.new_string((rt.call_function('sanitize_key', [var_prepared_args.array_get('orderby')])).str() + ' ' + (rt.call_function('sanitize_key', [var_prepared_args.array_get('order')])).str())
	mut var_query := rt.new_string(rt.concat(rt.concat(rt.concat(rt.concat(rt.new_string('\n\t\t\tSELECT *\n\t\t\tFROM '), rt.get_property(var_wpdb, 'prefix')), rt.new_string('woocommerce_tax_rates\n\t\t\t%s\n\t\t\tORDER BY ')), var_orderby), rt.new_string('\n\t\t\tLIMIT %%d, %%d\n\t\t')))
	mut var_wpdb_prepare_args := [var_prepared_args.array_get('offset'), var_prepared_args.array_get('number')]
	if !rt.is_true(var_prepared_args.array_get('class')) {
		var_query = rt.call_function('sprintf', [var_query.dup(), rt.new_string('')])
	} else {
		mut var_class := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('sanitize_title', [var_prepared_args.array_get('class')]) } else { rt.new_string('') }
		rt.call_function('array_unshift', [var_wpdb_prepare_args.dup(), var_class.dup()])
		var_query = rt.call_function('sprintf', [var_query.dup(), rt.new_string('WHERE tax_rate_class = %s')])
	}
	mut var_results := rt.call_method(var_wpdb, 'get_results', [rt.call_method(var_wpdb, 'prepare', [var_query.dup(), var_wpdb_prepare_args.dup()])])
	mut var_taxes := rt.new_array()
	{
		mut iter_1 := var_results.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_tax := item_1.val
			mut var_data := this.prepare_item_for_response(var_tax.dup(), var_request.dup())
			var_taxes << this.prepare_response_for_collection(var_data.dup())
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_taxes.dup()])
	mut var_per_page := // unsupported expression: Expr_Cast_Int
	mut var_page := rt.call_function('ceil', [rt.add(rt.div(// unsupported expression: Expr_Cast_Int, var_per_page), rt.new_int(1))])
	rt.call_function('array_splice', [var_wpdb_prepare_args.dup(), // unsupported expression: Expr_UnaryMinus])
	var_query = rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{ key: none, val: 'SELECT *' }, rt.ArrayItem{ key: none, val: 'LIMIT %d, %d' }]), rt.create_array([rt.ArrayItem{ key: none, val: 'SELECT COUNT(*)' }, rt.ArrayItem{ key: none, val: '' }]), var_query.dup()])
	mut var_total_taxes := // unsupported expression: Expr_Cast_Int
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), var_total_taxes.dup()])
	mut var_max_pages := rt.call_function('ceil', [rt.div(var_total_taxes, var_per_page)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), // unsupported expression: Expr_Cast_Int])
	mut var_base := rt.call_function('add_query_arg', [rt.call_method(var_request, 'get_query_params', []rt.PhpVal{}), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, this.rest_base])])])
	if rt.is_true(rt.greater(var_page, rt.new_int(1))) {
		mut var_prev_page := rt.sub(var_page, rt.new_int(1))
		if rt.is_true(rt.greater(var_prev_page, var_max_pages)) {
			var_prev_page = var_max_pages.dup()
		}
		mut var_prev_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_prev_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('prev'), var_prev_link.dup()])
	}
	if rt.is_true(rt.greater(var_max_pages, var_page)) {
		mut var_next_page := rt.add(var_page, rt.new_int(1))
		mut var_next_link := rt.call_function('add_query_arg', [rt.new_string('page'), var_next_page.dup(), var_base.dup()])
		rt.call_method(var_response, 'link_header', [rt.new_string('next'), var_next_link.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) create_or_update_tax(var_request rt.PhpVal, var_current rt.PhpVal) rt.PhpVal {
	mut var_id := rt.call_function('absint', [if var_request.array_isset(rt.new_string('id')) { var_request.array_get('id') } else { rt.new_int(0) }])
	mut var_data := rt.new_array()
	mut var_fields := ['tax_rate_country', 'tax_rate_state', 'tax_rate', 'tax_rate_name', 'tax_rate_priority', 'tax_rate_compound', 'tax_rate_shipping', 'tax_rate_order', 'tax_rate_class']
	for var_field in var_fields {
		mut var_key := if rt.is_true(rt.identical(rt.new_string('tax_rate'), rt.new_string(field))) { rt.new_string('rate') } else { rt.call_function('str_replace', [rt.new_string('tax_rate_'), rt.new_string(''), rt.new_string(field)]) }
		if !(var_request.array_isset(var_key)) {
			continue
		}
		if rt.is_true(rt.new_bool(rt.is_true(var_current) && rt.is_true(rt.identical(rt.get_property(var_current, '{"nodeType":"Expr_Variable","line":373,"name":"field"}'), var_request.array_get(var_key))))) {
			continue
		}
		mut switch_val_1 := rt.new_string(field)
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_priority'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_compound'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_shipping'))) || rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_order'))) {
			var_data.array_set(field, rt.call_function('absint', [var_request.array_get(var_key)]))
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tax_rate_class'))) {
			var_data.array_set(field, if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { var_request.array_get(var_key) } else { rt.new_string('') })
		} else {
			var_data.array_set(field, rt.call_function('wc_clean', [var_request.array_get(var_key)]))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_id)))) {
		var_id = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._insert_tax_rate(arg_0) }(var_data.dup())
	} else if rt.is_true(var_data) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._update_tax_rate(arg_0, arg_1) }(var_id.dup(), var_data.dup())
	}
	if !(!rt.is_true(var_request.array_get('postcode'))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._update_tax_rate_postcodes(arg_0, arg_1) }(var_id.dup(), rt.call_function('wc_clean', [var_request.array_get('postcode')]))
	}
	if !(!rt.is_true(var_request.array_get('city'))) {
		fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._update_tax_rate_cities(arg_0, arg_1) }(var_id.dup(), rt.call_function('wc_clean', [var_request.array_get('city')]))
	}
	return fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._get_tax_rate(arg_0, arg_1) }(var_id.dup(), rt.get_constant('OBJECT'))
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return create_wp_error(rt.new_string('woocommerce_rest_tax_exists'), rt.call_function('__', [rt.new_string('Cannot create existing resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_tax := this.create_or_update_tax(var_request.dup(), rt.new_null())
	this.update_additional_fields_for_object(var_tax.dup(), var_request.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_tax'), var_tax.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tax.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, rt.get_property(var_tax, 'tax_rate_id')])])])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_tax_obj := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._get_tax_rate(arg_0, arg_1) }(var_id.dup(), rt.get_constant('OBJECT'))
	if !rt.is_true(var_id) || !rt.is_true(var_tax_obj) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [rt.new_string('Invalid resource ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_tax := this.prepare_item_for_response(var_tax_obj.dup(), var_request.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_tax.dup()])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_tax_obj := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WC_Tax{}; return temp._get_tax_rate(arg_0, arg_1) }(var_id.dup(), rt.get_constant('OBJECT'))
	if !rt.is_true(var_id) || !rt.is_true(var_tax_obj) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [rt.new_string('Invalid resource ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_tax := this.create_or_update_tax(var_request.dup(), var_tax_obj.dup())
	this.update_additional_fields_for_object(var_tax.dup(), var_request.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_tax'), var_tax.dup(), var_request.dup(), rt.new_bool(false)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := 
	
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) prepare_item_for_response(var_tax rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_tax_mutated := var_tax
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) prepare_links(var_tax rt.PhpVal) rt.PhpVal {
	mut var_tax_mutated := var_tax
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) add_tax_rate_locales(var_data rt.PhpVal, var_tax rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_data_mutated := var_data
	mut var_tax_mutated := var_tax
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_default_response_entity_type() string {
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) response_cache_vary_by_user(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) bool {
}

fn (mut this Class_WC_REST_Taxes_V1_Controller) get_hooks_relevant_to_caching(mut var_request Class_WP_REST_Request, mut var_endpoint_id Class_?string) rt.PhpVal {
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

fn create_wc_rest_controller() &Class_WC_REST_Controller {
	mut obj := &Class_WC_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wc_tax() &Class_WC_Tax {
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version1_class_wc_rest_taxes_v1_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}

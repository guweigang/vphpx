import rt

struct Class_WC_REST_Posts_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('')
		post_type rt.PhpVal = rt.new_string('')
		public rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WC_REST_Posts_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('create')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := rt.call_function('get_post', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read'), rt.get_property(var_post, 'ID')]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := rt.call_function('get_post', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('edit'), rt.get_property(var_post, 'ID')]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := rt.call_function('get_post', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('delete'), rt.get_property(var_post, 'ID')]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('batch')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_post := rt.call_function('get_post', [var_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post, 'post_type'))) && rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post, 'post_type'))))) && rt.is_true(rt.identical(rt.new_string('product'), this.post_type)))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'), this.post_type), rt.new_string('_id')), rt.call_function('__', [rt.new_string('To manipulate product variations you should use the /products/&lt;product_id&gt;/variations/&lt;id&gt; endpoint.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	} else if rt.is_true(rt.new_bool(!rt.is_true(var_id) || !rt.is_true(rt.get_property(var_post, 'ID')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'), this.post_type), rt.new_string('_id')), rt.call_function('__', [rt.new_string('Invalid ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_data := this.prepare_item_for_response(var_post.dup(), var_request.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(this.public) {
		rt.call_method(var_response, 'link_header', [rt.new_string('alternate'), rt.call_function('get_permalink', [var_id.dup()]), rt.create_array([rt.ArrayItem{ key: 'type', val: 'text/html' }])])
	}
	return var_response.dup()
}

fn (mut this Class_WC_REST_Posts_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cannot create existing %s.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_post := this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return var_post.dup()
	}
	rt.set_property(var_post, 'post_type', this.post_type)
	mut var_post_id := rt.call_function('wp_insert_post', [var_post.dup(), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.dup()])) {
		if rt.is_true(rt.call_function('in_array', [rt.call_method(var_post_id, 'get_error_code', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'db_insert_error' }])])) {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_post_id.dup()
	}
	rt.set_property(var_post, 'ID', var_post_id.dup())
	var_post = rt.call_function('get_post', [var_post_id.dup()])
	this.update_additional_fields_for_object(var_post.dup(), var_request.dup())
	mut var_meta_fields := rt.new_bool(this.add_post_meta_fields(var_post.dup(), var_request.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_meta_fields.dup()])) {
		this.delete_post(var_post.dup())
		return var_meta_fields.dup()
	}
	rt.call_function('do_action', [rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type), var_post.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, this.rest_base, var_post_id.dup()])])])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Posts_Controller) add_post_meta_fields(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
	return true
}

fn (mut this Class_WC_REST_Posts_Controller) delete_post(var_post rt.PhpVal)  {
	mut var_post_mutated := var_post
	rt.call_function('wp_delete_post', [rt.get_property(var_post_mutated, 'ID'), rt.new_bool(true)])
}

fn (mut this Class_WC_REST_Posts_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_post := rt.call_function('get_post', [var_id.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_post, 'post_type'))) && rt.is_true(rt.identical(rt.new_string('product_variation'), rt.get_property(var_post, 'post_type'))))) && rt.is_true(rt.identical(rt.new_string('product'), this.post_type)))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_invalid_'), this.post_type), rt.new_string('_id')), rt.call_function('__', [rt.new_string('To manipulate product variations you should use the /products/&lt;product_id&gt;/variations/&lt;id&gt; endpoint.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	} else if rt.is_true(rt.new_bool(!rt.is_true(var_id) || !rt.is_true(rt.get_property(var_post, 'ID')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('ID is invalid.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	var_post = this.prepare_item_for_database(var_request.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return var_post.dup()
	}
	mut var_post_id := rt.call_function('wp_update_post', [rt.cast_array(var_post), rt.new_bool(true)])
	if rt.is_true(rt.call_function('is_wp_error', [var_post_id.dup()])) {
		if rt.is_true(rt.call_function('in_array', [rt.call_method(var_post_id, 'get_error_code', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'db_update_error' }])])) {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		} else {
			rt.call_method(var_post_id, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		}
		return var_post_id.dup()
	}
	var_post = rt.call_function('get_post', [var_post_id.dup()])
	this.update_additional_fields_for_object(var_post.dup(), var_request.dup())
	mut var_meta_fields := rt.new_bool(this.update_post_meta_fields(var_post.dup(), var_request.dup()))
	if rt.is_true(rt.call_function('is_wp_error', [var_meta_fields.dup()])) {
		return var_meta_fields.dup()
	}
	rt.call_function('do_action', [rt.concat(rt.new_string('woocommerce_rest_insert_'), this.post_type), var_post.dup(), var_request.dup(), rt.new_bool(false)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_post.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_response.dup()])
}

fn (mut this Class_WC_REST_Posts_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_args := rt.new_array()
	var_args.array_set('offset', var_request.array_get('offset'))
	var_args.array_set('order', var_request.array_get('order'))
	var_args.array_set('orderby', var_request.array_get('orderby'))
	var_args.array_set('paged', var_request.array_get('page'))
	var_args.array_set('post__in', var_request.array_get('include'))
	var_args.array_set('post__not_in', var_request.array_get('exclude'))
	var_args.array_set('posts_per_page', var_request.array_get('per_page'))
	var_args.array_set('name', var_request.array_get('slug'))
	var_args.array_set('post_parent__in', var_request.array_get('parent'))
	var_args.array_set('post_parent__not_in', var_request.array_get('parent_exclude'))
	var_args.array_set('s', var_request.array_get('search'))
	var_args.array_set('date_query', rt.new_array())
	if var_request.array_isset(rt.new_string('before')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('before', var_request.array_get('before'))
	}
	if var_request.array_isset(rt.new_string('after')) {
		var_args.array_get_mut('date_query').array_get_mut(0).array_set('after', var_request.array_get('after'))
	}
	if rt.is_true(rt.identical(rt.new_string('wc/v1'), this.namespace)) {
		if rt.is_true(rt.new_bool(var_request.array_get('filter').is_array())) {
			var_args = rt.call_function('array_merge', [var_args.dup(), var_request.array_get('filter')])
			var_args.array_unset(rt.new_string('filter'))
		}
	}
	var_args.array_set('post_type', this.post_type)
	var_args = rt.call_function('apply_filters', [rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_query')), var_args.dup(), var_request.dup()])
	mut var_query_args := this.prepare_items_query(var_args.dup(), var_request.dup())
	mut var_posts_query := create_wp_query()
	mut var_query_result := var_posts_query.query(var_query_args.dup())
	mut var_posts := rt.new_array()
	{
		mut iter_1 := var_query_result.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read'), rt.get_property(var_post, 'ID')]))))) {
				continue
			}
			mut var_data := this.prepare_item_for_response(var_post.dup(), var_request.dup())
			var_posts << this.prepare_response_for_collection(var_data.dup())
		}
	}
	mut var_page := // unsupported expression: Expr_Cast_Int
	mut var_total_posts := rt.get_property(var_posts_query, 'found_posts')
	if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_total_posts, rt.new_int(1))) && rt.is_true(rt.greater(var_page, rt.new_int(1))))) {
		var_query_args.array_unset(rt.new_string('paged'))
		mut var_count_query := create_wp_query()
		.query(.dup())
		
	}
	
}

fn (mut this Class_WC_REST_Posts_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Posts_Controller) prepare_links(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
}

fn (mut this Class_WC_REST_Posts_Controller) prepare_items_query(var_prepared_args rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WC_REST_Posts_Controller) get_allowed_query_vars() rt.PhpVal {
	mut var_wp := rt.new_null()
}

fn (mut this Class_WC_REST_Posts_Controller) get_collection_params() rt.PhpVal {
}

fn (mut this Class_WC_REST_Posts_Controller) update_post_meta_fields(var_post rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_post_mutated := var_post
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wc_rest_posts_controller() &Class_WC_REST_Posts_Controller {
	mut obj := &Class_WC_REST_Posts_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('')
		post_type: rt.new_string('')
		public: rt.new_bool(false)
	}
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'add_post_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.add_post_meta_fields(dispatch_arg_0, dispatch_arg_1))
		}
		'delete_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.delete_post(dispatch_arg_0)
			return rt.new_null()
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_items_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_items_query(dispatch_arg_0, dispatch_arg_1)
		}
		'get_allowed_query_vars' {
			return this.get_allowed_query_vars()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'update_post_meta_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.update_post_meta_fields(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		'public' { return this.public }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
		'public' { this.public = val; return true }
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version3_class_wc_rest_posts_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}

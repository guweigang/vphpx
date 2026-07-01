import rt

struct Class_WC_REST_Order_Notes_V1_Controller {
	rt.PhpObjectBase
pub mut:
		namespace rt.PhpVal = rt.new_string('wc/v1')
		rest_base rt.PhpVal = rt.new_string('orders/(?P<order_id>[\\d]+)/notes')
		post_type rt.PhpVal = rt.new_string('shop_order')
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) register_routes()  {
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str(), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_function('array_merge', [this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable()), rt.create_array([rt.ArrayItem{ key: 'note', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Order note content.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_kses_post' }]) }])]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [this.namespace, '/' + (this.rest_base).str() + '/(?P<id>[\\d]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'order_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The order ID.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as resource does not support trashing.'), rt.new_string('woocommerce')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Order_Notes_V1_Controller', ['WC_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot list resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('create')]))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to create resources.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('read'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you cannot view this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(var_order) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [this.post_type, rt.new_string('delete'), rt.call_method(var_order, 'get_id', []rt.PhpVal{})]))))))) {
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this resource.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_invalid_id')), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_args := { 'post_id': rt.call_method(var_order, 'get_id', []rt.PhpVal{}), 'approve': rt.new_string('approve'), 'type': rt.new_string('order_note') }
	rt.call_function('remove_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }]), rt.new_int(10), rt.new_int(1)])
	mut var_notes := rt.call_function('get_comments', [var_args.dup()])
	rt.call_function('add_filter', [rt.new_string('comments_clauses'), rt.create_array([rt.ArrayItem{ key: none, val: 'WC_Comments' }, rt.ArrayItem{ key: none, val: 'exclude_order_comments' }]), rt.new_int(10), rt.new_int(1)])
	mut var_data := rt.new_array()
	{
		mut iter_1 := var_notes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_note := item_1.val
			mut var_order_note := this.prepare_item_for_response(var_note.dup(), var_request.dup())
			var_order_note = this.prepare_response_for_collection(var_order_note.dup())
			var_data.array_push(var_order_note.dup())
		}
	}
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get('id'))) {
		return create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), this.post_type), rt.new_string('_exists')), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Cannot create existing %s.'), rt.new_string('woocommerce')]), this.post_type]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_note_id := rt.call_method(var_order, 'add_order_note', [var_request.array_get('note'), var_request.array_get('customer_note')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note_id)))) {
		return create_wp_error(rt.new_string('woocommerce_api_cannot_create_order_note'), rt.call_function('__', [rt.new_string('Cannot create order note, please try again.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_note := rt.call_function('get_comment', [var_note_id.dup()])
	this.update_additional_fields_for_object(var_note.dup(), var_request.dup())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_order_note'), var_note.dup(), var_request.dup(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_note.dup(), var_request.dup())
	var_response = rt.call_function('rest_ensure_response', [var_response.dup()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, rt.call_function('str_replace', [rt.new_string('(?P<order_id>[\\d]+)'), rt.call_method(var_order, 'get_id', []rt.PhpVal{}), this.rest_base]), var_note_id.dup()])])])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_note := rt.call_function('get_comment', [var_id.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_id) || !rt.is_true(var_note) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [rt.new_string('Invalid resource ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_order_note := this.prepare_item_for_response(var_note.dup(), var_request.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_order_note.dup()])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_id := // unsupported expression: Expr_Cast_Int
	mut var_force := if var_request.array_isset(rt.new_string('force')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('__', [rt.new_string('Webhooks do not support trashing.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	mut var_order := rt.call_function('wc_get_order', [// unsupported expression: Expr_Cast_Int])
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('__', [rt.new_string('Invalid order ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_note := rt.call_function('get_comment', [var_id.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_id) || !rt.is_true(var_note) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [rt.new_string('Invalid resource ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'), rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_note.dup(), var_request.dup())
	mut var_result := rt.call_function('wc_delete_order_note', [rt.get_property(var_note, 'comment_ID')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The %s cannot be deleted.'), rt.new_string('woocommerce')]), rt.new_string('order_note')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_delete_order_note'), var_note.dup(), var_response.dup(), var_request.dup()])
	return var_response.dup()
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) prepare_item_for_response(var_note rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	mut var_data := rt.create_array([rt.ArrayItem{ key: 'id', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [rt.get_property(var_note_mutated, 'comment_date_gmt')]) }, rt.ArrayItem{ key: 'note', val: rt.get_property(var_note_mutated, 'comment_content') }, rt.ArrayItem{ key: 'customer_note', val: // unsupported expression: Expr_Cast_Bool }])
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	rt.call_method(var_response, 'add_links', [this.prepare_links(var_note_mutated.dup())])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_rest_prepare_order_note'), var_response.dup(), var_note_mutated.dup(), var_request.dup()])
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) prepare_links(var_note rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	mut var_order_id := // unsupported expression: Expr_Cast_Int
	mut var_base := rt.call_function('str_replace', [rt.new_string('(?P<order_id>[\\d]+)'), var_order_id.dup(), this.rest_base])
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace, var_base.dup(), rt.get_property(var_note_mutated, 'comment_ID')])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s'), this.namespace, var_base.dup()])]) }, 'up': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/orders/%d'), this.namespace, var_order_id.dup()])]) } }
	return var_links.dup()
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('order_note'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('Unique identifier for the resource.'), rt.new_string('woocommerce')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'date_created': { 'description': rt.call_function('__', [rt.new_string('The date the order note was created, in the site\'s timezone.'), rt.new_string('woocommerce')]), 'type': rt.new_string('date-time'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'note': { 'description': rt.call_function('__', [rt.new_string('Order note.'), rt.new_string('woocommerce')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'customer_note': { 'description': rt.call_function('__', [rt.new_string('Shows/define if the note is only for reference or for the customer (the user will be notified).'), rt.new_string('woocommerce')]), 'type': rt.new_string('boolean'), 'default': rt.new_bool(false), 'context': map[string]rt.PhpVal{} } } }
	return this.add_additional_fields_schema(var_schema.dup())
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }])
}

struct Class_WC_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_order_notes_v1_controller() &Class_WC_REST_Order_Notes_V1_Controller {
	mut obj := &Class_WC_REST_Order_Notes_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace: rt.new_string('wc/v1')
		rest_base: rt.new_string('orders/(?P<order_id>[\\d]+)/notes')
		post_type: rt.new_string('shop_order')
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

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
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
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WC_REST_Order_Notes_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		'post_type' { return this.post_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Order_Notes_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' { this.namespace = val; return true }
		'rest_base' { this.rest_base = val; return true }
		'post_type' { this.post_type = val; return true }
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




pub fn init_wp_content_plugins_woocommerce_includes_rest_api_controllers_version1_class_wc_rest_order_notes_v1_controller_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
}

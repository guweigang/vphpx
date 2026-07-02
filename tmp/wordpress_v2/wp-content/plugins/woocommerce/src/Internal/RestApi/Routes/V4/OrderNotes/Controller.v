import rt

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller {
	rt.PhpObjectBase
pub mut:
	rest_base   rt.PhpVal = rt.new_string('order-notes')
	item_schema rt.PhpVal = rt.new_null()
	query_utils rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) init(mut var_item_schema Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema, mut var_query_utils Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery) {
	this.item_schema = var_item_schema
	this.dispatch_set_prop('collection_query', var_query_utils)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_schema() rt.PhpVal {
	return rt.call_method(this.item_schema, 'get_item_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_query_schema() rt.PhpVal {
	return rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
	], &this), 'collection_query'), 'get_query_schema', []rt.PhpVal{})
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) register_routes() {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_value := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'order_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The order ID that notes belong to.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
					rt.ArrayItem{ key: 'validate_callback', val: rt.new_closure(closure_1_fn) },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
				},
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
			'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
		], &this), 'namespace'),
		rt.new_string('/' + (this.rest_base).str() + '/(?P<id>[\\d]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
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
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
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
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
			]) },
		]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) prepare_links(var_item rt.PhpVal, mut var_request Class_WP_REST_Request, mut var_response Class_WP_REST_Response) rt.PhpVal {
	mut var_response_mutated := var_response
	return rt.create_array([
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'),
					rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
						'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
					], &this), 'namespace'),
					this.rest_base, rt.new_int((rt.get_property(var_item, 'comment_ID')).to_i64())]),
			]) },
		]) },
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('add_query_arg', [
				rt.create_array([
					rt.ArrayItem{ key: 'order_id', val: rt.new_int((rt.get_property(var_item,
						'comment_post_ID')).to_i64()) },
				]),
				rt.call_function('rest_url', [
					rt.call_function('sprintf', [
						rt.new_string('/%s/%s'),
						rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
							'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
						], &this), 'namespace'),
						this.rest_base,
					]),
				]),
			]) },
		]) },
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_item_response(var_note rt.PhpVal, mut var_request Class_WP_REST_Request) rt.PhpVal {
	mut var_note_mutated := var_note
	return rt.call_method(this.item_schema, 'get_item_response', [
		var_note_mutated.clone(), var_request])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_order :=
		this.get_order_by_note_id(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return (this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.invalid_id())).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		rt.new_string('shop_order'),
		rt.new_string('read'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method',
			[]rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		rt.new_string('shop_order'),
		rt.new_string('read'),
		rt.new_int((var_request.array_get(rt.new_string('order_id'))).to_i64()),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method',
			[]rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		rt.new_string('shop_order'),
		rt.new_string('create'),
		rt.new_int((var_request.array_get(rt.new_string('order_id'))).to_i64()),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method',
			[]rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_order :=
		this.get_order_by_note_id(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return (this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.invalid_id())).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_post_permissions', [
		rt.new_string('shop_order'),
		rt.new_string('delete'),
		rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
	])))))
	{
		return (this.get_authentication_error_by_method(rt.call_method(var_request, 'get_method',
			[]rt.PhpVal{}))).to_bool()
	}
	return true
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_note :=
		this.get_note_by_id(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.invalid_id())
	}
	return this.prepare_item_for_response(var_note.clone(), var_request.clone())
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_order :=
		this.get_order_by_id(rt.new_int((var_request.array_get(rt.new_string('order_id'))).to_i64()))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.invalid_id())
	}
	mut var_query_args := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
	], &this), 'collection_query'), 'get_query_args', [var_request.clone()])
	mut var_results := rt.call_method(rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
		'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
	], &this), 'collection_query'), 'get_query_results', [var_query_args.clone(),
		var_request.clone()])
	mut var_items := rt.new_array()
	mut iter_1 := var_results.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_result := item_1.val
		var_items.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_result.clone(),
			var_request.clone())))
	}
	return rt.call_function('rest_ensure_response', [var_items.clone()])
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.resource_exists())
	}
	mut var_order :=
		this.get_order_by_id(rt.new_int((var_request.array_get(rt.new_string('order_id'))).to_i64()))
	mut var_note_id := if rt.is_true(var_order) { rt.call_method(var_order, 'add_order_note', [
			rt.call_function('wp_kses_post', [var_request.array_get(rt.new_string('note'))]),
			var_request.array_get(rt.new_string('is_customer_note')),
			rt.new_bool(true),
		]) } else { rt.new_null() }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note_id)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.cannot_create())
	}
	mut var_note := rt.call_function('get_comment', [var_note_id.clone()])
	this.update_additional_fields_for_object(var_note.clone(), var_request.clone())
	rt.call_function('do_action', [
		rt.new_string((this.get_hook_prefix()).str() + 'created'),
		var_note.clone(),
		var_request.clone(),
	])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_note.clone(), var_request.clone())
	rt.call_method(var_response, 'set_status', [Class_WP_Http.created()])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'),
				rt.get_property(rt.new_object('Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller', [
					'Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController',
				], &this), 'namespace'),
				this.rest_base, var_note_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_note :=
		this.get_note_by_id(rt.new_int((var_request.array_get(rt.new_string('id'))).to_i64()))
	if !rt.is_true(var_note) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.invalid_id())
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_note.clone(), var_request.clone())
	mut var_result := rt.call_function('wc_delete_order_note', [
		rt.new_int((rt.get_property(var_note, 'comment_ID')).to_i64()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return this.get_route_error_by_code(Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller.cannot_delete())
	}
	rt.call_function('do_action', [
		rt.new_string((this.get_hook_prefix()).str() + 'deleted'),
		var_note.clone(),
		var_response.clone(),
		var_request.clone(),
	])
	return var_response.clone()
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) is_valid_order_id(var_order_id rt.PhpVal) bool {
	mut var_order := this.get_order_by_id(rt.new_int(var_order_id.to_i64()))
	return rt.is_true(var_order) && rt.is_true(rt.new_bool(rt.instance_of(var_order, 'WC_Order')))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_order_by_id(order_id i64) rt.PhpVal {
	if !(var_order_id != 0) {
		return rt.new_null()
	}
	mut var_order := rt.call_function('wc_get_order', [rt.new_int(order_id)])
	return if rt.is_true(var_order)
		&& rt.is_true(rt.identical(rt.new_string('shop_order'), rt.call_method(var_order, 'get_type', []rt.PhpVal{}))) {
		var_order
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_order_by_note_id(var_note_id rt.PhpVal) rt.PhpVal {
	mut var_note_id_mutated := var_note_id
	mut var_note := if rt.is_true(rt.new_bool(rt.instance_of(var_note_id_mutated, 'WP_Comment'))) {
		var_note_id_mutated
	} else {
		this.get_note_by_id(rt.new_int(var_note_id_mutated.to_i64()))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return rt.new_null()
	}
	return this.get_order_by_id(rt.new_int((rt.get_property(var_note, 'comment_post_ID')).to_i64()))
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) get_note_by_id(note_id i64) rt.PhpVal {
	mut note_id_mutated := note_id
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_int(note_id_mutated))))) {
		return rt.new_null()
	}
	mut var_note := rt.call_function('get_comment', [rt.new_int(note_id_mutated).clone()])
	return if rt.is_true(var_note)
		&& rt.is_true(rt.identical(rt.new_string('order_note'), rt.get_property(var_note, 'comment_type'))) {
		var_note
	} else {
		rt.new_null()
	}
}

struct Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_ordernotes_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		rest_base:     rt.new_string('order-notes')
		item_schema:   rt.new_null()
		query_utils:   rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_internal_restapi_routes_v4_abstractcontroller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController {
	mut obj := &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Schema_OrderNoteSchema](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_CollectionQuery](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			this.init(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_schema' {
			return this.get_schema()
		}
		'get_query_schema' {
			return this.get_query_schema()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_WP_REST_Response](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return this.prepare_links(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
		}
		'get_item_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_REST_Request](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return this.get_item_response(dispatch_arg_0, mut dispatch_arg_1)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'is_valid_order_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_order_id(dispatch_arg_0))
		}
		'get_order_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_order_by_id(dispatch_arg_0)
		}
		'get_order_by_note_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_order_by_note_id(dispatch_arg_0)
		}
		'get_note_by_id' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.get_note_by_id(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'rest_base' { return this.rest_base }
		'item_schema' { return this.item_schema }
		'query_utils' { return this.query_utils }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_OrderNotes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'rest_base' {
			this.rest_base = val
			return true
		}
		'item_schema' {
			this.item_schema = val
			return true
		}
		'query_utils' {
			this.query_utils = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_RestApi_Routes_V4_AbstractController) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

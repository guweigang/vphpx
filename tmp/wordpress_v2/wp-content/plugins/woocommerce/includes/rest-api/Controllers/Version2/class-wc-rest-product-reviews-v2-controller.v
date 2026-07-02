import rt

struct Class_WC_REST_Product_Reviews_V2_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v2')
	rest_base rt.PhpVal = rt.new_string('products/(?P<product_id>[\\d]+)/reviews')
}

fn (mut this Class_WC_REST_Product_Reviews_V2_Controller) register_routes() {
	this.Class_WC_REST_Product_Reviews_V1_Controller.register_routes()
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/batch'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'product_id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique identifier for the variable product.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'integer' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V2_Controller', [
						'WC_REST_Product_Reviews_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V2_Controller', [
						'WC_REST_Product_Reviews_V1_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'batch_items_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Product_Reviews_V2_Controller', [
					'WC_REST_Product_Reviews_V1_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_batch_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Product_Reviews_V2_Controller) batch_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_product_reviews_permissions', [
		rt.new_string('batch'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_batch'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to batch manipulate this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Product_Reviews_V2_Controller) prepare_item_for_response(var_review rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_data := rt.create_array([
		rt.ArrayItem{
			key: 'id'
			val: rt.new_int((rt.get_property(var_review, 'comment_ID')).to_i64())
		},
		rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_review, 'comment_date'),
		]) },
		rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_review, 'comment_date_gmt'),
		]) },
		rt.ArrayItem{ key: 'review', val: rt.get_property(var_review, 'comment_content') },
		rt.ArrayItem{ key: 'rating', val: rt.new_int((rt.call_function('get_comment_meta', [
			rt.get_property(var_review, 'comment_ID'),
			rt.new_string('rating'),
			rt.new_bool(true),
		])).to_i64()) },
		rt.ArrayItem{ key: 'name', val: rt.get_property(var_review, 'comment_author') },
		rt.ArrayItem{ key: 'email', val: rt.get_property(var_review, 'comment_author_email') },
		rt.ArrayItem{ key: 'verified', val: rt.call_function('wc_review_is_from_verified_owner', [
			rt.get_property(var_review, 'comment_ID'),
		]) },
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
		this.prepare_links(var_review.clone(), var_request_mutated.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_product_review'),
		var_response.clone(),
		var_review.clone(),
		var_request_mutated.clone(),
	])
}

fn (mut this Class_WC_REST_Product_Reviews_V2_Controller) batch_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_items := rt.call_function('array_filter', [var_request_mutated.get_params()])
	mut var_params := var_request_mutated.get_url_params()
	mut var_product_id := var_params.array_get(rt.new_string('product_id'))
	mut var_body_params := rt.new_array()
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'update' },
		rt.ArrayItem{ key: none, val: 'create' }, rt.ArrayItem{ key: none, val: 'delete' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_batch_type := item_1.val
		if !(!rt.is_true(var_items.array_get(var_batch_type))) {
			mut var_injected_items := rt.new_array()
			mut iter_2 := var_items.array_get(var_batch_type).iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_item := item_2.val
				var_injected_items << if var_item.clone().is_array() { rt.call_function('array_merge', [
						rt.create_array([
							rt.ArrayItem{ key: 'product_id', val: var_product_id },
						]),
						var_item.clone(),
					]) } else { var_item }
			}
			var_body_params.array_set(var_batch_type, var_injected_items.clone())
		}
	}
	var_request_mutated = create_wp_rest_request(var_request_mutated.get_method())
	var_request_mutated.set_body_params(var_body_params.clone())
	return this.Class_WC_REST_Product_Reviews_V1_Controller.batch_items(var_request_mutated.clone())
}

fn (mut this Class_WC_REST_Product_Reviews_V2_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('product_review')
		'type':       rt.new_string('object')
		'properties': {
			'id':               {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'review':           {
				'description': rt.call_function('__', [
					rt.new_string('The content of the review.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'date_created':     {
				'description': rt.call_function('__', [
					rt.new_string("The date the review was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
			}
			'date_created_gmt': {
				'description': rt.call_function('__', [
					rt.new_string('The date the review was created, as GMT.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
			}
			'rating':           {
				'description': rt.call_function('__', [
					rt.new_string('Review rating (0 to 5).'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('integer')
				'context':     map[string]rt.PhpVal{}
			}
			'name':             {
				'description': rt.call_function('__', [rt.new_string('Reviewer name.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'email':            {
				'description': rt.call_function('__', [rt.new_string('Reviewer email.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'verified':         {
				'description': rt.call_function('__', [
					rt.new_string('Shows if the reviewer bought the product or not.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('boolean')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

struct Class_WC_REST_Product_Reviews_V1_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Request {
	rt.PhpObjectBase
}

fn create_wc_rest_product_reviews_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Reviews_V2_Controller {
	mut obj := &Class_WC_REST_Product_Reviews_V2_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v2')
		rest_base:     rt.new_string('products/(?P<product_id>[\\d]+)/reviews')
	}
	return obj
}

fn create_wc_rest_product_reviews_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Product_Reviews_V1_Controller {
	mut obj := &Class_WC_REST_Product_Reviews_V1_Controller{
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

fn create_wp_rest_request(_args ...rt.PhpVal) &Class_WP_REST_Request {
	mut obj := &Class_WP_REST_Request{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_Product_Reviews_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'batch_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.batch_items_permissions_check(dispatch_arg_0))
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'batch_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.batch_items(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Product_Reviews_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Product_Reviews_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		'rest_base' {
			this.rest_base = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Product_Reviews_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Product_Reviews_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_REST_Request) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Request) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Request) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

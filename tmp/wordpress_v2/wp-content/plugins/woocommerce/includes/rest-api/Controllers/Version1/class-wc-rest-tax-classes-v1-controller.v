import rt

struct Class_WC_REST_Tax_Classes_V1_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v1')
	rest_base rt.PhpVal = rt.new_string('taxes/classes')
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) register_routes() {
	rt.call_function('register_rest_route', [this.namespace, rt.new_string('/' +
		(this.rest_base).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.creatable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
	rt.call_function('register_rest_route', [this.namespace,
		rt.new_string('/' + (this.rest_base).str() + '/(?P<slug>\\w[\\w\\s\\-]*)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'slug', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Unique slug for the resource.'),
						rt.new_string('woocommerce'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
						'WC_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: false },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Required to be true, as resource does not support trashing.'),
							rt.new_string('woocommerce'),
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WC_REST_Tax_Classes_V1_Controller', [
					'WC_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		])])
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('read'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you cannot list resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('create'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_create'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to create resources.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_rest_check_manager_permissions', [
		rt.new_string('settings'),
		rt.new_string('delete'),
	])))))
	{
		return (create_wp_error(rt.new_string('woocommerce_rest_cannot_delete'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to delete this resource.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_tax_classes := []rt.PhpVal{}
	var_tax_classes << rt.create_array([rt.ArrayItem{ key: 'slug', val: 'standard' },
		rt.ArrayItem{ key: 'name', val: rt.call_function('__', [
			rt.new_string('Standard rate'),
			rt.new_string('woocommerce'),
		]) }])
	mut iife_temp_0 := Class_WC_Tax{}
	mut iife_result_0 := iife_temp_0.get_tax_classes()
	mut var_classes := iife_result_0
	mut iter_1 := var_classes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_class := item_1.val
		var_tax_classes << rt.create_array([
			rt.ArrayItem{ key: 'slug', val: rt.call_function('sanitize_title', [
				var_class.clone(),
			]) },
			rt.ArrayItem{ key: 'name', val: var_class },
		])
	}
	mut var_data := []rt.PhpVal{}
	for var_tax_class in var_tax_classes {
		mut var_class := this.prepare_item_for_response(var_tax_class.clone(), var_request.clone())
		var_class = this.prepare_response_for_collection(var_class.clone())
		var_data.array_push(var_class.clone())
	}
	mut var_total := rt.new_int(var_data.clone().array_count())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'),
		rt.new_int(var_total.to_i64())])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'),
		rt.new_int(if rt.is_true(var_total) { 1 } else { 0 })])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut iife_temp_1 := Class_WC_Tax{}
	mut iife_result_1 := iife_temp_1.create_tax_class(var_request.array_get(rt.new_string('name')))
	mut var_tax_class := iife_result_1
	if rt.is_true(rt.call_function('is_wp_error', [var_tax_class.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error('woocommerce_rest_' +
			(rt.call_method(var_tax_class, 'get_error_code', []rt.PhpVal{})).str(), rt.call_method(var_tax_class,
			'get_error_message', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 400 },
		])))
	}
	this.update_additional_fields_for_object(var_tax_class.clone(), var_request.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_tax_class'),
		rt.array_to_object(var_tax_class), var_request.clone(),
		rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tax_class.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), this.namespace, this.rest_base,
				var_tax_class.array_get(rt.new_string('slug'))]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut var_force := rt.new_bool(if var_request.array_isset(rt.new_string('force')) {
		(var_request.array_get(rt.new_string('force'))).to_bool()
	} else {
		false
	})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_trash_not_supported'), rt.call_function('__', [
			rt.new_string('Taxes do not support trashing.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }])))
	}
	mut iife_temp_2 := Class_WC_Tax{}
	mut iife_result_2 := iife_temp_2.get_tax_class_by(rt.new_string('slug'), rt.call_function('sanitize_title', [
		var_request.array_get(rt.new_string('slug')),
	]))
	mut var_tax_class := iife_result_2
	if rt.is_true(rt.new_bool(!(rt.is_true(var_tax_class)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_tax_class_invalid_slug'), rt.call_function('__', [
			rt.new_string('Invalid slug.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut iife_temp_3 := Class_WC_Tax{}
	mut iife_result_3 := iife_temp_3.delete_tax_class_by(rt.new_string('slug'), rt.call_function('sanitize_title', [
		var_request.array_get(rt.new_string('slug')),
	]))
	mut var_deleted := iife_result_3
	if rt.is_true(rt.new_bool(!(rt.is_true(var_deleted)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid resource id.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_deleted.clone()])) {
		return rt.new_object('WP_Error', []string{}, create_wp_error('woocommerce_rest_' +
			(rt.call_method(var_deleted, 'get_error_code', []rt.PhpVal{})).str(), rt.call_method(var_deleted,
			'get_error_message', []rt.PhpVal{}), rt.create_array([
			rt.ArrayItem{ key: 'status', val: 400 },
		])))
	}
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_tax_class.clone(), var_request.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_delete_tax'),
		rt.array_to_object(var_tax_class), var_response.clone(),
		var_request.clone()])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) prepare_item_for_response(var_tax_class rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_tax_class_mutated := var_tax_class
	mut var_data := var_tax_class_mutated.clone()
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [this.prepare_links()])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_tax'),
		var_response.clone(),
		rt.array_to_object(var_tax_class_mutated),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) prepare_links() rt.PhpVal {
	mut var_links := {
		'collection': {
			'href': rt.call_function('rest_url', [
				rt.call_function('sprintf',
					[rt.new_string('/%s/%s'), this.namespace, this.rest_base]),
			])
		}
	}
	return var_links.clone()
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('tax_class')
		'type':       rt.new_string('object')
		'properties': {
			'slug': {
				'description': rt.call_function('__', [
					rt.new_string('Unique identifier for the resource.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'name': {
				'description': rt.call_function('__', [rt.new_string('Tax class name.'),
					rt.new_string('woocommerce')])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'required':    rt.new_bool(true)
				'arg_options': {
					'sanitize_callback': rt.new_string('sanitize_text_field')
				}
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
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

fn create_wc_rest_tax_classes_v1_controller(_args ...rt.PhpVal) &Class_WC_REST_Tax_Classes_V1_Controller {
	mut obj := &Class_WC_REST_Tax_Classes_V1_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v1')
		rest_base:     rt.new_string('taxes/classes')
	}
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

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return this.prepare_links()
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

fn (this &Class_WC_REST_Tax_Classes_V1_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		'rest_base' { return this.rest_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Tax_Classes_V1_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}

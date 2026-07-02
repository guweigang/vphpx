import rt

struct Class_WC_REST_Order_Notes_Controller {
	rt.PhpObjectBase
pub mut:
	namespace rt.PhpVal = rt.new_string('wc/v3')
}

fn (mut this Class_WC_REST_Order_Notes_Controller) prepare_item_for_response(var_note rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_note_mutated := var_note
	mut var_data := rt.create_array([
		rt.ArrayItem{
			key: 'id'
			val: rt.new_int((rt.get_property(var_note_mutated, 'comment_ID')).to_i64())
		},
		rt.ArrayItem{
			key: 'author'
			val: if rt.is_true(rt.identical(rt.call_function('__', [
				rt.new_string('woocommerce'),
				rt.new_string('woocommerce'),
			]), rt.get_property(var_note_mutated, 'comment_author')))
			{ rt.new_string('system') } else { rt.get_property(var_note_mutated, 'comment_author') }
		},
		rt.ArrayItem{ key: 'date_created', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_note_mutated, 'comment_date'),
		]) },
		rt.ArrayItem{ key: 'date_created_gmt', val: rt.call_function('wc_rest_prepare_date_response', [
			rt.get_property(var_note_mutated, 'comment_date_gmt'),
		]) },
		rt.ArrayItem{ key: 'note', val: rt.get_property(var_note_mutated, 'comment_content') },
		rt.ArrayItem{ key: 'customer_note', val: (rt.call_function('get_comment_meta', [
			rt.get_property(var_note_mutated, 'comment_ID'),
			rt.new_string('is_customer_note'),
			rt.new_bool(true),
		])).to_bool() },
	])
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	rt.call_method(var_response, 'add_links', [
		this.prepare_links(var_note_mutated.clone()),
	])
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_rest_prepare_order_note'),
		var_response.clone(),
		var_note_mutated.clone(),
		var_request.clone(),
	])
}

fn (mut this Class_WC_REST_Order_Notes_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	if !(!rt.is_true(var_request.array_get(rt.new_string('id')))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.concat(rt.concat(rt.new_string('woocommerce_rest_'), rt.get_property(rt.new_object('WC_REST_Order_Notes_Controller', [
			'WC_REST_Order_Notes_V2_Controller',
		], &this), 'post_type')), rt.new_string('_exists')), rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Cannot create existing %s.'),
				rt.new_string('woocommerce')]),
			rt.get_property(rt.new_object('WC_REST_Order_Notes_Controller', [
				'WC_REST_Order_Notes_V2_Controller',
			], &this), 'post_type'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	mut var_order := rt.call_function('wc_get_order', [
		rt.new_int((var_request.array_get(rt.new_string('order_id'))).to_i64()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_order))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_property(rt.new_object('WC_REST_Order_Notes_Controller', ['WC_REST_Order_Notes_V2_Controller'], &this), 'post_type'), rt.call_method(var_order, 'get_type', []rt.PhpVal{}))))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_rest_order_invalid_id'), rt.call_function('__', [
			rt.new_string('Invalid order ID.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	mut var_note_id := rt.call_method(var_order, 'add_order_note', [
		var_request.array_get(rt.new_string('note')),
		var_request.array_get(rt.new_string('customer_note')),
		var_request.array_get(rt.new_string('added_by_user')),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note_id)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('woocommerce_api_cannot_create_order_note'), rt.call_function('__', [
			rt.new_string('Cannot create order note, please try again.'),
			rt.new_string('woocommerce'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_note := rt.call_function('get_comment', [var_note_id.clone()])
	this.update_additional_fields_for_object(var_note.clone(), var_request.clone())
	rt.call_function('do_action', [rt.new_string('woocommerce_rest_insert_order_note'),
		var_note.clone(), var_request.clone(), rt.new_bool(true)])
	rt.call_method(var_request, 'set_param', [rt.new_string('context'),
		rt.new_string('edit')])
	mut var_response := this.prepare_item_for_response(var_note.clone(), var_request.clone())
	var_response = rt.call_function('rest_ensure_response', [
		var_response.clone()])
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'),
		rt.call_function('rest_url', [
			rt.call_function('sprintf', [rt.new_string('/%s/%s/%d'), this.namespace,
				rt.call_function('str_replace', [rt.new_string('(?P<order_id>[\\d]+)'),
					rt.call_method(var_order, 'get_id', []rt.PhpVal{}),
					rt.get_property(rt.new_object('WC_REST_Order_Notes_Controller', [
						'WC_REST_Order_Notes_V2_Controller',
					], &this), 'rest_base')]),
				var_note_id.clone()]),
		])])
	return var_response.clone()
}

fn (mut this Class_WC_REST_Order_Notes_Controller) get_item_schema() rt.PhpVal {
	mut var_schema := {
		'$schema':    rt.new_string('http://json-schema.org/draft-04/schema#')
		'title':      rt.new_string('order_note')
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
			'author':           {
				'description': rt.call_function('__', [
					rt.new_string('Order note author.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created':     {
				'description': rt.call_function('__', [
					rt.new_string("The date the order note was created, in the site's timezone."),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'date_created_gmt': {
				'description': rt.call_function('__', [
					rt.new_string('The date the order note was created, as GMT.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('date-time')
				'context':     map[string]rt.PhpVal{}
				'readonly':    rt.new_bool(true)
			}
			'note':             {
				'description': rt.call_function('__', [
					rt.new_string('Order note content.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('string')
				'context':     map[string]rt.PhpVal{}
			}
			'customer_note':    {
				'description': rt.call_function('__', [
					rt.new_string('If true, the note will be shown to customers and they will be notified. If false, the note will be for admin reference only.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('boolean')
				'default':     rt.new_bool(false)
				'context':     map[string]rt.PhpVal{}
			}
			'added_by_user':    {
				'description': rt.call_function('__', [
					rt.new_string('If true, this note will be attributed to the current user. If false, the note will be attributed to the system.'),
					rt.new_string('woocommerce'),
				])
				'type':        rt.new_string('boolean')
				'default':     rt.new_bool(false)
				'context':     map[string]rt.PhpVal{}
			}
		}
	}
	return this.add_additional_fields_schema(var_schema.clone())
}

struct Class_WC_REST_Order_Notes_V2_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wc_rest_order_notes_controller(_args ...rt.PhpVal) &Class_WC_REST_Order_Notes_Controller {
	mut obj := &Class_WC_REST_Order_Notes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		namespace:     rt.new_string('wc/v3')
	}
	return obj
}

fn create_wc_rest_order_notes_v2_controller(_args ...rt.PhpVal) &Class_WC_REST_Order_Notes_V2_Controller {
	mut obj := &Class_WC_REST_Order_Notes_V2_Controller{
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

fn (mut this Class_WC_REST_Order_Notes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_REST_Order_Notes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'namespace' { return this.namespace }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_REST_Order_Notes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'namespace' {
			this.namespace = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_REST_Order_Notes_V2_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_Order_Notes_V2_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_Order_Notes_V2_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

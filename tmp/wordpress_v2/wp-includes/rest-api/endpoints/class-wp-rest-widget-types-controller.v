import rt

struct Class_WP_REST_Widget_Types_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Widget_Types_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('widget-types'))
}

fn (mut this Class_WP_REST_Widget_Types_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[a-zA-Z0-9_-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The widget type id.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_form_data := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_array := rt.new_array()
		rt.call_function('wp_parse_str', [var_form_data.clone(),
			var_array.clone()])
		return
	}
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[a-zA-Z0-9_-]+)/encode'),
		rt.create_array([
			rt.ArrayItem{ key: 'args', val: rt.create_array([
				rt.ArrayItem{ key: 'id', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('The widget type id.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'required', val: true },
				]) },
				rt.ArrayItem{ key: 'instance', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Current instance settings of the widget.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'object' },
				]) },
				rt.ArrayItem{ key: 'form_data', val: rt.create_array([
					rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
						rt.new_string('Serialized widget form data to encode into instance settings.'),
					]) },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_1_fn) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'encode_form_data' },
				]) },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[a-zA-Z0-9_-]+)/render'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'render' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The widget type id.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'required', val: true },
					]) },
					rt.ArrayItem{ key: 'instance', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Current instance settings of the widget.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'object' },
					]) },
				]) },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	return rt.new_bool(this.check_read_permission())
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	mut var_data := rt.new_array()
	mut iter_1 := this.get_widgets().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_widget := item_1.val
		mut var_widget_type := this.prepare_item_for_response(var_widget.clone(),
			var_request.clone())
		var_data.array_push(this.prepare_response_for_collection(var_widget_type.clone()))
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_check := rt.new_bool(this.check_read_permission())
	if rt.is_true(rt.call_function('is_wp_error', [var_check.clone()])) {
		return var_check.clone()
	}
	mut var_widget_id := var_request.array_get(rt.new_string('id'))
	mut var_widget_type := this.get_widget(var_widget_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_widget_type.clone()])) {
		return var_widget_type.clone()
	}
	return rt.new_bool(true)
}

fn (mut this Class_WP_REST_Widget_Types_Controller) check_read_permission() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_theme_options'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_cannot_manage_widgets'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to manage widgets on this site.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_widget(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut iter_2 := this.get_widgets().iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_widget := item_2.val
		if rt.is_true(rt.identical(var_id_mutated, var_widget.array_get(rt.new_string('id')))) {
			return var_widget.clone()
		}
	}
	return create_wp_error(rt.new_string('rest_widget_type_invalid'), rt.call_function('__', [
		rt.new_string('Invalid widget type.'),
	]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_widgets() rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_widgets := rt.new_array()
	mut iter_3 := var_wp_registered_widgets.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_widget := item_3.val
		mut var_parsed_id := rt.call_function('wp_parse_widget_id', [
			var_widget.array_get(rt.new_string('id')),
		])
		mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [
			var_parsed_id.array_get(rt.new_string('id_base')),
		])
		var_widget.array_set('id', var_parsed_id.array_get(rt.new_string('id_base')))
		var_widget.array_set('is_multi', var_widget_object.to_bool())
		if var_widget.array_isset(rt.new_string('name')) {
			var_widget.array_set('name', rt.call_function('html_entity_decode', [
				var_widget.array_get(rt.new_string('name')),
				rt.get_constant('ENT_QUOTES'),
				rt.call_function('get_bloginfo', [rt.new_string('charset')]),
			]))
		}
		if var_widget.array_isset(rt.new_string('description')) {
			var_widget.array_set('description', rt.call_function('html_entity_decode', [
				var_widget.array_get(rt.new_string('description')),
				rt.get_constant('ENT_QUOTES'),
				rt.call_function('get_bloginfo', [rt.new_string('charset')]),
			]))
		}
		var_widget.array_unset(rt.new_string('callback'))
		mut var_classname := rt.new_string('')
		mut iter_4 := rt.cast_array(var_widget.array_get(rt.new_string('classname'))).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_cn := item_4.val
			if rt.is_true(rt.new_bool(var_cn.clone().is_string())) {
				var_classname = rt.concat(var_classname, rt.new_string('_' + var_cn.str()))
			} else if rt.is_true(rt.new_bool(var_cn.clone().is_object())) {
				var_classname = rt.concat(var_classname, rt.new_string('_' +
					(rt.call_function('get_class', [var_cn.clone()])).str()))
			}
		}
		var_widget.array_set('classname', var_classname.clone().to_string().trim_left(' \t\n\r'))
		var_widgets.array_set(var_widget.array_get(rt.new_string('id')), var_widget.clone())
	}
	rt.call_function('ksort', [var_widgets.clone()])
	return var_widgets.clone()
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_widget_id := var_request.array_get(rt.new_string('id'))
	mut var_widget_type := this.get_widget(var_widget_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_widget_type.clone()])) {
		return var_widget_type.clone()
	}
	mut var_data := this.prepare_item_for_response(var_widget_type.clone(), var_request.clone())
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Widget_Types_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_widget_type := var_item
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [
			rt.new_string('rest_prepare_widget_type'),
			create_wp_rest_response(rt.new_array()),
			var_widget_type.clone(),
			var_request.clone(),
		])
	}
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_data := rt.create_array([
		rt.ArrayItem{ key: 'id', val: var_widget_type.array_get(rt.new_string('id')) },
	])
	mut var_schema := this.get_item_schema()
	mut var_extra_fields := ['name', 'description', 'is_multi', 'classname', 'widget_class',
		'option_name', 'customize_selective_refresh']
	for var_extra_field in var_extra_fields {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('rest_is_field_included', [
			rt.new_string(extra_field),
			var_fields.clone(),
		])))))
		{
			continue
		}
		if var_widget_type.array_isset(rt.new_string(extra_field)) {
			mut var_field := var_widget_type.array_get(rt.new_string(extra_field))
		} else if rt.is_true(rt.new_bool(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string(extra_field)).array_isset(rt.new_string('default')))) {
			var_field =
				var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string(extra_field)).array_get(rt.new_string('default'))
		} else {
			var_field = rt.new_string('')
		}
		var_data.array_set(extra_field, rt.call_function('rest_sanitize_value_from_schema', [
			var_field.clone(),
			var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string(extra_field)),
		]))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get(rt.new_string('context')))) {
		var_request.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [
			this.prepare_links(var_widget_type.clone()),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_widget_type'),
		var_response.clone(), var_widget_type.clone(), var_request.clone()])
}

fn (mut this Class_WP_REST_Widget_Types_Controller) prepare_links(var_widget_type rt.PhpVal) rt.PhpVal {
	mut var_widget_type_mutated := var_widget_type
	return rt.create_array([
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			]) },
		]) },
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					var_widget_type_mutated.array_get(rt.new_string('id'))]),
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'widget-type' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique slug identifying the widget type.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Human-readable name identifying the widget type.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description of the widget.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'is_multi', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Whether the widget supports multiple instances'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'boolean' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'classname', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Class name'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
		]) },
	])
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Widget_Types_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Widget_Types_Controller) encode_form_data(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_id := var_request.array_get(rt.new_string('id'))
	mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [
		var_id.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_widget_object)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
			rt.new_string('Cannot preview a widget that does not extend WP_Widget.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if var_request.array_isset(rt.new_string('number'))
		&& var_request.array_get(rt.new_string('number')).is_long()
		|| var_request.array_get(rt.new_string('number')).is_double() {
		rt.call_method(var_widget_object, '_set', [
			rt.new_int((var_request.array_get(rt.new_string('number'))).to_i64()),
		])
	} else {
		rt.call_method(var_widget_object, '_set', [rt.new_int(-1)])
	}
	if var_request.array_get(rt.new_string('instance')).array_isset(rt.new_string('encoded'))
		&& var_request.array_get(rt.new_string('instance')).array_isset(rt.new_string('hash')) {
		mut var_serialized_instance := rt.call_function('base64_decode', [
			var_request.array_get(rt.new_string('instance')).array_get(rt.new_string('encoded')),
		])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [
			rt.call_function('wp_hash', [var_serialized_instance.clone()]),
			var_request.array_get(rt.new_string('instance')).array_get(rt.new_string('hash')),
		])))))
		{
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
				rt.new_string('The provided instance is malformed.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		mut var_instance := rt.call_function('unserialize', [
			var_serialized_instance.clone()])
	} else {
		var_instance = rt.new_array()
	}
	if var_request.array_get(rt.new_string('form_data')).array_isset(rt.new_string('widget-${var_id.to_string()}'))
		&& var_request.array_get(rt.new_string('form_data')).array_get(rt.new_string('widget-${var_id.to_string()}')).is_array() {
		mut var_new_instance := rt.call_function('array_values', [
			var_request.array_get(rt.new_string('form_data')).array_get(rt.new_string('widget-${var_id.to_string()}')),
		]).array_get(rt.new_int(0))
		mut var_old_instance := var_instance.clone()
		var_instance = rt.call_method(var_widget_object, 'update', [
			var_new_instance.clone(), var_old_instance.clone()])
		var_instance = rt.call_function('apply_filters', [
			rt.new_string('widget_update_callback'),
			var_instance.clone(),
			var_new_instance.clone(),
			var_old_instance.clone(),
			var_widget_object.clone(),
		])
	}
	var_serialized_instance = rt.call_function('serialize', [
		var_instance.clone()])
	mut var_widget_key := rt.call_method(var_wp_widget_factory, 'get_widget_key', [
		var_id.clone(),
	])
	mut var_response := rt.create_array([
		rt.ArrayItem{ key: 'form', val: this.get_widget_form(var_widget_object.clone(),
			var_instance.clone()).to_string().trim_space() },
		rt.ArrayItem{ key: 'preview', val: this.get_widget_preview(var_widget_key.clone(),
			var_instance.clone()).to_string().trim_space() },
		rt.ArrayItem{ key: 'instance', val: rt.create_array([
			rt.ArrayItem{ key: 'encoded', val: rt.call_function('base64_encode', [
				var_serialized_instance.clone(),
			]) },
			rt.ArrayItem{ key: 'hash', val: rt.call_function('wp_hash', [
				var_serialized_instance.clone(),
			]) },
		]) },
	])
	if !(!rt.is_true(rt.get_property(var_widget_object, 'widget_options').array_get(rt.new_string('show_instance_in_rest')))) {
		var_response.array_get_mut('instance').array_set('raw', if !rt.is_true(var_instance) {
			create_stdclass()
		} else {
			var_instance
		})
	}
	return rt.call_function('rest_ensure_response', [var_response.clone()])
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_widget_preview(var_widget rt.PhpVal, var_instance rt.PhpVal) rt.PhpVal {
	mut var_widget_mutated := var_widget
	mut var_instance_mutated := var_instance
	rt.call_function('ob_start', []rt.PhpVal{})
	rt.call_function('the_widget', [var_widget_mutated.clone(),
		var_instance_mutated.clone()])
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_widget_form(var_widget_object rt.PhpVal, var_instance rt.PhpVal) rt.PhpVal {
	mut var_widget_object_mutated := var_widget_object
	mut var_instance_mutated := var_instance
	rt.call_function('ob_start', []rt.PhpVal{})
	var_instance_mutated = rt.call_function('apply_filters', [
		rt.new_string('widget_form_callback'),
		var_instance_mutated.clone(),
		var_widget_object_mutated.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_instance_mutated)))) {
		mut var_return := rt.call_method(var_widget_object_mutated, 'form', [
			var_instance_mutated.clone()])
		rt.call_function('do_action_ref_array', [rt.new_string('in_widget_form'),
			rt.create_array([rt.ArrayItem{ key: none, val: var_widget_object_mutated },
				rt.ArrayItem{ key: none, val: var_return }, rt.ArrayItem{
					key: none
					val: var_instance_mutated
				}])])
	}
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Widget_Types_Controller) render(var_request rt.PhpVal) rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'preview', val: this.render_legacy_widget_preview_iframe(var_request.array_get(rt.new_string('id')), if !(var_request.array_get(rt.new_string('instance'))).is_null() {
			var_request.array_get(rt.new_string('instance'))
		} else {
			rt.new_null()
		}) },
	])
}

fn (mut this Class_WP_REST_Widget_Types_Controller) render_legacy_widget_preview_iframe(var_id_base rt.PhpVal, var_instance rt.PhpVal) rt.PhpVal {
	mut var_instance_mutated := var_instance
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('IFRAME_REQUEST'),
	])))))
	{
		rt.call_function('define', [rt.new_string('IFRAME_REQUEST'),
			rt.new_bool(true)])
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('language_attributes', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('bloginfo', [rt.new_string('charset')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_head', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('body_class', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_1 := Class_WP_Block_Type_Registry{}
	mut iife_result_1 := iife_temp_1.get_instance()
	mut var_registry := iife_result_1
	mut var_block := rt.call_method(var_registry, 'get_registered', [
		rt.new_string('core/legacy-widget'),
	])
	rt.echo_val(rt.call_method(var_block, 'render', [
		rt.create_array([rt.ArrayItem{ key: 'idBase', val: var_id_base },
			rt.ArrayItem{ key: 'instance', val: var_instance_mutated }]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_footer', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WP_REST_Widget_Types_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
	])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Block_Type_Registry {
	rt.PhpObjectBase
}

fn create_wp_rest_widget_types_controller() &Class_WP_REST_Widget_Types_Controller {
	mut obj := &Class_WP_REST_Widget_Types_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
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

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_type_registry(_args ...rt.PhpVal) &Class_WP_Block_Type_Registry {
	mut obj := &Class_WP_Block_Type_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Widget_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return this.get_items_permissions_check(dispatch_arg_0)
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item_permissions_check(dispatch_arg_0)
		}
		'check_read_permission' {
			return rt.new_bool(this.check_read_permission())
		}
		'get_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_widget(dispatch_arg_0)
		}
		'get_widgets' {
			return this.get_widgets()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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
		'encode_form_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.encode_form_data(dispatch_arg_0)
		}
		'get_widget_preview' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_widget_preview(dispatch_arg_0, dispatch_arg_1)
		}
		'get_widget_form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_widget_form(dispatch_arg_0, dispatch_arg_1)
		}
		'render' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.render(dispatch_arg_0)
		}
		'render_legacy_widget_preview_iframe' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.render_legacy_widget_preview_iframe(dispatch_arg_0, dispatch_arg_1)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Widget_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Widget_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Type_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Type_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

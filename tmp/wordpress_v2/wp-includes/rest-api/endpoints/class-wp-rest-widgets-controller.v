import rt

struct Class_WP_REST_Widgets_Controller {
	rt.PhpObjectBase
pub mut:
	widgets_retrieved bool
	allow_batch       rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Widgets_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('widgets'))
}

fn (mut this Class_WP_REST_Widgets_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
			'WP_REST_Controller',
		], &this), 'rest_base'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'create_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema() },
			]) },
			rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string((
			rt.get_property(rt.new_object('WP_REST_Widgets_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[\\w\\-]+)').str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
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
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
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
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'force', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to force removal of the widget, or move it to the inactive sidebar.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Widgets_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Widgets_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	if var_request_mutated.array_isset(rt.new_string('sidebar'))
		&& this.check_read_sidebar_permission(var_request_mutated.array_get(rt.new_string('sidebar'))) {
		return true
	}
	mut iter_1 := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_widget_ids := item_1.val
		mut var_sidebar_id := item_1.key
		if this.check_read_sidebar_permission(var_sidebar_id.clone()) {
			return true
		}
	}
	return this.permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Widgets_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.call_method(var_request_mutated, 'is_method', [
		rt.new_string('HEAD'),
	]))
	{
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	this.retrieve_widgets()
	mut var_prepared := rt.new_array()
	mut var_permissions_check := rt.new_bool(this.permissions_check(var_request_mutated.clone()))
	mut iter_2 := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_widget_ids := item_2.val
		mut var_sidebar_id := item_2.key
		if var_request_mutated.array_isset(rt.new_string('sidebar'))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sidebar_id, var_request_mutated.array_get(rt.new_string('sidebar')))))) {
			continue
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_permissions_check.clone()]))
			&& !(this.check_read_sidebar_permission(var_sidebar_id.clone())) {
			continue
		}
		mut iter_3 := var_widget_ids.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_widget_id := item_3.val
			mut var_response := this.prepare_item_for_response(rt.call_function('compact', [
				rt.new_string('sidebar_id'),
				rt.new_string('widget_id'),
			]), var_request_mutated.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [
				var_response.clone(),
			])))))
			{
				var_prepared.array_push(this.prepare_response_for_collection(var_response.clone()))
			}
		}
	}
	return rt.new_object('WP_REST_Response', []string{},
		create_wp_rest_response(var_prepared.clone()))
}

fn (mut this Class_WP_REST_Widgets_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get(rt.new_string('id'))
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [
		var_widget_id.clone()])
	if rt.is_true(var_sidebar_id) && this.check_read_sidebar_permission(var_sidebar_id.clone()) {
		return true
	}
	return this.permissions_check(var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Widgets_Controller) check_read_sidebar_permission(var_sidebar_id rt.PhpVal) bool {
	mut var_sidebar_id_mutated := var_sidebar_id
	mut var_sidebar := rt.call_function('wp_get_sidebar', [var_sidebar_id_mutated.clone()])
	return !(!rt.is_true(var_sidebar.array_get(rt.new_string('show_in_rest'))))
}

fn (mut this Class_WP_REST_Widgets_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get(rt.new_string('id'))
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [
		var_widget_id.clone()])
	if rt.is_true(rt.new_bool(var_sidebar_id.clone().is_null())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_widget_not_found'), rt.call_function('__', [
			rt.new_string('No widget was found with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.prepare_item_for_response(rt.call_function('compact', [
		rt.new_string('widget_id'),
		rt.new_string('sidebar_id'),
	]), var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Widgets_Controller) create_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.clone()))
}

fn (mut this Class_WP_REST_Widgets_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	mut var_sidebar_id := var_request_mutated.array_get(rt.new_string('sidebar'))
	mut var_widget_id := this.save_widget(var_request_mutated.clone(), var_sidebar_id.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_widget_id.clone()])) {
		return var_widget_id.clone()
	}
	rt.call_function('wp_assign_widget_to_sidebar', [var_widget_id.clone(),
		var_sidebar_id.clone()])
	var_request_mutated.array_set('context', 'edit')
	mut var_response := this.prepare_item_for_response(rt.call_function('compact', [
		rt.new_string('sidebar_id'),
		rt.new_string('widget_id'),
	]), var_request_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		return var_response.clone()
	}
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Widgets_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.clone()))
}

fn (mut this Class_WP_REST_Widgets_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_request_mutated := var_request
	rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get(rt.new_string('id'))
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [
		var_widget_id.clone()])
	mut var_parsed_id := rt.call_function('wp_parse_widget_id', [
		var_widget_id.clone()])
	mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [
		var_parsed_id.array_get(rt.new_string('id_base')),
	])
	if var_sidebar_id.clone().is_null() && rt.is_true(var_widget_object) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_widget_not_found'), rt.call_function('__', [
			rt.new_string('No widget was found with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	if rt.is_true(rt.call_method(var_request_mutated, 'has_param', [rt.new_string('instance')]))
		|| rt.is_true(rt.call_method(var_request_mutated, 'has_param', [rt.new_string('form_data')])) {
		mut var_maybe_error := this.save_widget(var_request_mutated.clone(), var_sidebar_id.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_maybe_error.clone()])) {
			return var_maybe_error.clone()
		}
	}
	if rt.is_true(rt.call_method(var_request_mutated, 'has_param', [
		rt.new_string('sidebar'),
	]))
	{
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sidebar_id,
			var_request_mutated.array_get(rt.new_string('sidebar'))))))
		{
			var_sidebar_id = var_request_mutated.array_get(rt.new_string('sidebar'))
			rt.call_function('wp_assign_widget_to_sidebar', [
				var_widget_id.clone(), var_sidebar_id.clone()])
		}
	}
	var_request_mutated.array_set('context', 'edit')
	return this.prepare_item_for_response(rt.call_function('compact', [
		rt.new_string('widget_id'),
		rt.new_string('sidebar_id'),
	]), var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Widgets_Controller) delete_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.permissions_check(var_request_mutated.clone()))
}

fn (mut this Class_WP_REST_Widgets_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_request_mutated := var_request
	rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
	this.retrieve_widgets()
	mut var_widget_id := var_request_mutated.array_get(rt.new_string('id'))
	mut var_sidebar_id := rt.call_function('wp_find_widgets_sidebar', [
		var_widget_id.clone()])
	if rt.is_true(rt.new_bool(var_sidebar_id.clone().is_null())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_widget_not_found'), rt.call_function('__', [
			rt.new_string('No widget was found with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	var_request_mutated.array_set('context', 'edit')
	if rt.is_true(var_request_mutated.array_get(rt.new_string('force'))) {
		mut var_response := this.prepare_item_for_response(rt.call_function('compact', [
			rt.new_string('widget_id'),
			rt.new_string('sidebar_id'),
		]), var_request_mutated.clone())
		mut var_parsed_id := rt.call_function('wp_parse_widget_id', [
			var_widget_id.clone()])
		mut var_id_base := var_parsed_id.array_get(rt.new_string('id_base'))
		mut var_original_post := rt.get_superglobal('_POST').clone()
		mut var_original_request := rt.get_superglobal('_REQUEST').clone()
		mut var__POST := rt.create_array([
			rt.ArrayItem{ key: 'sidebar', val: var_sidebar_id },
			rt.ArrayItem{ key: 'widget-${var_id_base.to_string()}', val: rt.new_array() },
			rt.ArrayItem{ key: 'the-widget-id', val: var_widget_id },
			rt.ArrayItem{ key: 'delete_widget', val: '1' },
		])
		mut var__REQUEST := rt.get_superglobal('_POST').clone()
		rt.call_function('do_action', [rt.new_string('delete_widget'),
			var_widget_id.clone(), var_sidebar_id.clone(), var_id_base.clone()])
		mut var_callback :=
			var_wp_registered_widget_updates.array_get(var_id_base).array_get(rt.new_string('callback'))
		mut var_params :=
			var_wp_registered_widget_updates.array_get(var_id_base).array_get(rt.new_string('params'))
		if rt.is_true(rt.call_function('is_callable', [var_callback.clone()])) {
			rt.call_function('ob_start', []rt.PhpVal{})
			rt.call_function('call_user_func_array', [var_callback.clone(),
				var_params.clone()])
			rt.call_function('ob_end_clean', []rt.PhpVal{})
		}
		var__POST = var_original_post.clone()
		var__REQUEST = var_original_request.clone()
		mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [
			var_id_base.clone(),
		])
		if rt.is_true(var_widget_object) {
			rt.set_property(var_widget_object, 'updated', rt.new_bool(false))
		}
		rt.call_function('wp_assign_widget_to_sidebar', [var_widget_id.clone(),
			rt.new_string('')])
		rt.call_method(var_response, 'set_data', [
			rt.create_array([rt.ArrayItem{ key: 'deleted', val: true },
				rt.ArrayItem{ key: 'previous', val: rt.call_method(var_response, 'get_data',
					[]rt.PhpVal{}) }]),
		])
	} else {
		rt.call_function('wp_assign_widget_to_sidebar', [var_widget_id.clone(),
			rt.new_string('wp_inactive_widgets')])
		var_response = this.prepare_item_for_response(rt.create_array([
			rt.ArrayItem{ key: 'sidebar_id', val: 'wp_inactive_widgets' },
			rt.ArrayItem{ key: 'widget_id', val: var_widget_id },
		]), var_request_mutated.clone())
	}
	rt.call_function('do_action', [rt.new_string('rest_delete_widget'),
		var_widget_id.clone(), var_sidebar_id.clone(), var_response.clone(),
		var_request_mutated.clone()])
	return var_response.clone()
}

fn (mut this Class_WP_REST_Widgets_Controller) permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
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

fn (mut this Class_WP_REST_Widgets_Controller) retrieve_widgets() {
	if !(this.widgets_retrieved) {
		rt.call_function('retrieve_widgets', []rt.PhpVal{})
		this.widgets_retrieved = true
	}
}

fn (mut this Class_WP_REST_Widgets_Controller) save_widget(var_request rt.PhpVal, var_sidebar_id rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_wp_registered_widget_updates := rt.new_null()
	mut var_request_mutated := var_request
	mut var_sidebar_id_mutated := var_sidebar_id
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/widgets.php', '4')
	if var_request_mutated.array_isset(rt.new_string('id')) {
		mut var_id := var_request_mutated.array_get(rt.new_string('id'))
		mut var_parsed_id := rt.call_function('wp_parse_widget_id', [
			var_id.clone()])
		mut var_id_base := var_parsed_id.array_get(rt.new_string('id_base'))
		mut var_number := if !(var_parsed_id.array_get(rt.new_string('number'))).is_null() {
			var_parsed_id.array_get(rt.new_string('number'))
		} else {
			rt.new_null()
		}
		mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [
			var_id_base.clone(),
		])
		mut var_creating := rt.new_bool(false)
	} else if rt.is_true(var_request_mutated.array_get(rt.new_string('id_base'))) {
		var_id_base = var_request_mutated.array_get(rt.new_string('id_base'))
		var_widget_object = rt.call_method(var_wp_widget_factory, 'get_widget_object', [
			var_id_base.clone(),
		])
		var_number = if rt.is_true(var_widget_object) { rt.call_function('next_widget_id_number', [
				var_id_base.clone(),
			]) } else { rt.new_null() }
		var_id = if rt.is_true(var_widget_object) {
			var_id_base.str() + '-' + var_number.str()
		} else {
			var_id_base
		}
		var_creating = rt.new_bool(true)
	} else {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
			rt.new_string('Widget type (id_base) is required.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if !(var_wp_registered_widget_updates.array_isset(var_id_base)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
			rt.new_string('The provided widget type (id_base) cannot be updated.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
	}
	if var_request_mutated.array_isset(rt.new_string('instance')) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_widget_object)))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
				rt.new_string('Cannot set instance on a widget that does not extend WP_Widget.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		if var_request_mutated.array_get(rt.new_string('instance')).array_isset(rt.new_string('raw')) {
			if !rt.is_true(rt.get_property(var_widget_object, 'widget_options').array_get(rt.new_string('show_instance_in_rest'))) {
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
					rt.new_string('Widget type does not support raw instances.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
			}
			mut var_instance :=
				var_request_mutated.array_get(rt.new_string('instance')).array_get(rt.new_string('raw'))
		} else if
			var_request_mutated.array_get(rt.new_string('instance')).array_isset(rt.new_string('encoded'))
			&& var_request_mutated.array_get(rt.new_string('instance')).array_isset(rt.new_string('hash')) {
			mut var_serialized_instance := rt.call_function('base64_decode', [
				var_request_mutated.array_get(rt.new_string('instance')).array_get(rt.new_string('encoded')),
			])
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('hash_equals', [
				rt.call_function('wp_hash', [var_serialized_instance.clone()]),
				var_request_mutated.array_get(rt.new_string('instance')).array_get(rt.new_string('hash')),
			])))))
			{
				return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
					rt.new_string('The provided instance is malformed.'),
				]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
			}
			var_instance = rt.call_function('unserialize', [var_serialized_instance.clone()])
		} else {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
				rt.new_string('The provided instance is invalid. Must contain raw OR encoded and hash.'),
			]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])))
		}
		mut var_form_data := rt.create_array([
			rt.ArrayItem{ key: 'widget-${var_id_base.to_string()}', val: rt.create_array([
				rt.ArrayItem{ key: var_number, val: var_instance },
			]) },
			rt.ArrayItem{ key: 'sidebar', val: var_sidebar_id_mutated },
		])
	} else if var_request_mutated.array_isset(rt.new_string('form_data')) {
		var_form_data = var_request_mutated.array_get(rt.new_string('form_data'))
	} else {
		var_form_data = rt.new_array()
	}
	mut var_original_post := rt.get_superglobal('_POST').clone()
	mut var_original_request := rt.get_superglobal('_REQUEST').clone()
	mut iter_4 := var_form_data.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_value := item_4.val
		mut var_key := item_4.key
		mut var_slashed_value := rt.call_function('wp_slash', [
			var_value.clone()])
		rt.get_superglobal('_POST').array_set(var_key, var_slashed_value.clone())
		rt.get_superglobal('_REQUEST').array_set(var_key, var_slashed_value.clone())
	}
	mut var_callback :=
		var_wp_registered_widget_updates.array_get(var_id_base).array_get(rt.new_string('callback'))
	mut var_params :=
		var_wp_registered_widget_updates.array_get(var_id_base).array_get(rt.new_string('params'))
	if rt.is_true(rt.call_function('is_callable', [var_callback.clone()])) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('call_user_func_array', [var_callback.clone(),
			var_params.clone()])
		rt.call_function('ob_end_clean', []rt.PhpVal{})
	}
	mut var__POST := var_original_post.clone()
	mut var__REQUEST := var_original_request.clone()
	if rt.is_true(var_widget_object) {
		rt.call_method(var_widget_object, '_set', [var_number.clone()])
		rt.call_method(var_widget_object, '_register_one', [var_number.clone()])
		rt.set_property(var_widget_object, 'updated', rt.new_bool(false))
	}
	rt.call_function('do_action', [rt.new_string('rest_after_save_widget'),
		var_id.clone(), var_sidebar_id_mutated.clone(), var_request_mutated.clone(),
		var_creating.clone()])
	return var_id.clone()
}

fn (mut this Class_WP_REST_Widgets_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_widget_factory := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_request_mutated := var_request
	mut var_widget_id := var_item.array_get(rt.new_string('widget_id'))
	mut var_sidebar_id := var_item.array_get(rt.new_string('sidebar_id'))
	if !(var_wp_registered_widgets.array_isset(var_widget_id)) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_invalid_widget'), rt.call_function('__', [
			rt.new_string('The requested widget is invalid.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])))
	}
	mut var_widget := var_wp_registered_widgets.array_get(var_widget_id)
	if rt.is_true(rt.call_method(var_request_mutated, 'is_method', [
		rt.new_string('HEAD'),
	]))
	{
		return rt.call_function('apply_filters', [rt.new_string('rest_prepare_widget'),
			create_wp_rest_response(rt.new_array()), var_widget.clone(),
			var_request_mutated.clone()])
	}
	mut var_parsed_id := rt.call_function('wp_parse_widget_id', [
		var_widget_id.clone()])
	mut var_fields := this.get_fields_for_response(var_request_mutated.clone())
	mut var_prepared := rt.create_array([rt.ArrayItem{ key: 'id', val: var_widget_id },
		rt.ArrayItem{ key: 'id_base', val: var_parsed_id.array_get(rt.new_string('id_base')) },
		rt.ArrayItem{ key: 'sidebar', val: var_sidebar_id }, rt.ArrayItem{ key: 'rendered', val: '' },
		rt.ArrayItem{ key: 'rendered_form', val: rt.new_null() },
		rt.ArrayItem{ key: 'instance', val: rt.new_null() }])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('rendered'), var_fields.clone()]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp_inactive_widgets'), var_sidebar_id)))) {
		var_prepared.array_set('rendered', rt.call_function('wp_render_widget', [
			var_widget_id.clone(),
			var_sidebar_id.clone(),
		]).to_string().trim_space())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('rendered_form'),
		var_fields.clone(),
	]))
	{
		mut var_rendered_form := rt.call_function('wp_render_widget_control', [
			var_widget_id.clone(),
		])
		if !(var_rendered_form.clone().is_null()) {
			var_prepared.array_set('rendered_form',
				var_rendered_form.clone().to_string().trim_space())
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('instance'), var_fields.clone()]))
	{
		mut var_widget_object := rt.call_method(var_wp_widget_factory, 'get_widget_object', [
			var_parsed_id.array_get(rt.new_string('id_base')),
		])
		if rt.is_true(var_widget_object) && var_parsed_id.array_isset(rt.new_string('number')) {
			mut var_all_instances := rt.call_method(var_widget_object, 'get_settings',
				[]rt.PhpVal{})
			mut var_instance :=
				var_all_instances.array_get(var_parsed_id.array_get(rt.new_string('number')))
			mut var_serialized_instance := rt.call_function('serialize', [
				var_instance.clone()])
			var_prepared.array_get_mut('instance').array_set('encoded', rt.call_function('base64_encode', [
				var_serialized_instance.clone(),
			]))
			var_prepared.array_get_mut('instance').array_set('hash', rt.call_function('wp_hash', [
				var_serialized_instance.clone(),
			]))
			if !(!rt.is_true(rt.get_property(var_widget_object, 'widget_options').array_get(rt.new_string('show_instance_in_rest')))) {
				var_prepared.array_get_mut('instance').array_set('raw', if !rt.is_true(var_instance) {
					create_stdclass()
				} else {
					var_instance
				})
			}
		}
	}
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) {
		var_request_mutated.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_prepared = this.add_additional_fields_to_object(var_prepared.clone(),
		var_request_mutated.clone())
	var_prepared = this.filter_response_by_context(var_prepared.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_prepared.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [
			this.prepare_links(var_prepared.clone()),
		])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_widget'),
		var_response.clone(), var_widget.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WP_REST_Widgets_Controller) prepare_links(var_prepared rt.PhpVal) rt.PhpVal {
	mut var_prepared_mutated := var_prepared
	mut var_id_base := if !(!rt.is_true(var_prepared_mutated.array_get(rt.new_string('id_base')))) {
		var_prepared_mutated.array_get(rt.new_string('id_base'))
	} else {
		var_prepared_mutated.array_get(rt.new_string('id'))
	}
	return rt.create_array([
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					var_prepared_mutated.array_get(rt.new_string('id'))]),
			]) },
		]) },
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			]) },
		]) },
		rt.ArrayItem{ key: 'about', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('wp/v2/widget-types/%s'),
					var_id_base.clone()]),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		]) },
		rt.ArrayItem{ key: 'https://api.w.org/sidebar', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('wp/v2/sidebars/%s/'),
					var_prepared_mutated.array_get(rt.new_string('sidebar'))]),
			]) },
		]) },
	])
}

fn (mut this Class_WP_REST_Widgets_Controller) get_collection_params() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
			rt.ArrayItem{ key: 'default', val: 'view' },
		])) },
		rt.ArrayItem{ key: 'sidebar', val: rt.create_array([
			rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
				rt.new_string('The sidebar to return widgets for.'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'string' },
		]) },
	])
}

fn (mut this Class_WP_REST_Widgets_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_form_data := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		mut var_array := rt.new_array()
		rt.call_function('wp_parse_str', [var_form_data.clone(),
			var_array.clone()])
		return var_array.clone()
	}
	this.dispatch_set_prop('schema', rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'widget' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Unique identifier for the widget.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'id_base', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The type of the widget. Corresponds to ID in widget-types endpoint.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'sidebar', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The sidebar the widget belongs to.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'default', val: 'wp_inactive_widgets' },
				rt.ArrayItem{ key: 'required', val: true },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
			]) },
			rt.ArrayItem{ key: 'rendered', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML representation of the widget.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
					rt.ArrayItem{ key: none, val: 'embed' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'rendered_form', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML representation of the widget admin form.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'instance', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Instance settings of the widget, if supported.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'object' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_null() },
				rt.ArrayItem{ key: 'properties', val: rt.create_array([
					rt.ArrayItem{ key: 'encoded', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Base64 encoded representation of the instance settings.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'hash', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Cryptographic hash of the instance settings.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
					rt.ArrayItem{ key: 'raw', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Unencoded instance settings, if supported.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'object' },
						rt.ArrayItem{ key: 'context', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'edit' },
						]) },
					]) },
				]) },
			]) },
			rt.ArrayItem{ key: 'form_data', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('URL-encoded form data from the widget admin form. Used to update a widget that does not support instance. Write only.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.new_array() },
				rt.ArrayItem{ key: 'arg_options', val: rt.create_array([
					rt.ArrayItem{ key: 'sanitize_callback', val: rt.new_closure(closure_1_fn) },
				]) },
			]) },
		]) },
	]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Widgets_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
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

fn create_wp_rest_widgets_controller() &Class_WP_REST_Widgets_Controller {
	mut obj := &Class_WP_REST_Widgets_Controller{
		PhpObjectBase:     rt.PhpObjectBase{}
		widgets_retrieved: false
		allow_batch:       rt.new_array()
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

fn (mut this Class_WP_REST_Widgets_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'check_read_sidebar_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_read_sidebar_permission(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item_permissions_check(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item_permissions_check(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.permissions_check(dispatch_arg_0))
		}
		'retrieve_widgets' {
			this.retrieve_widgets()
			return rt.new_null()
		}
		'save_widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.save_widget(dispatch_arg_0, dispatch_arg_1)
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
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Widgets_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'widgets_retrieved' { return rt.new_bool(this.widgets_retrieved) }
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Widgets_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'widgets_retrieved' {
			this.widgets_retrieved = val.to_bool()
			return true
		}
		'allow_batch' {
			this.allow_batch = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

fn main() {
	defer {
		rt.shutdown()
	}
}

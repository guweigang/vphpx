import rt

struct Class_WP_REST_Sidebars_Controller {
	rt.PhpObjectBase
pub mut:
	widgets_retrieved bool
}

fn (mut this Class_WP_REST_Sidebars_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('sidebars'))
}

fn (mut this Class_WP_REST_Sidebars_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', ['WP_REST_Controller'], &this), 'rest_base')),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/(?P<id>[\\w-]+)'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The id of a registered sidebar'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
					]) },
					rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'view' },
					])) },
				]) },
			]) },
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'update_item_permissions_check' },
				]) },
				rt.ArrayItem{
					key: 'args'
					val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable())
				},
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Sidebars_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Sidebars_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	mut iter_1 := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{}).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_widgets := item_1.val
		mut var_id := item_1.key
		mut var_sidebar := this.get_sidebar(var_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_sidebar)))) {
			continue
		}
		if this.check_read_permission(var_sidebar.clone()) {
			return true
		}
	}
	return this.do_permissions_check()
}

fn (mut this Class_WP_REST_Sidebars_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if rt.is_true(rt.call_method(var_request_mutated, 'is_method', [
		rt.new_string('HEAD'),
	]))
	{
		return rt.new_object('WP_REST_Response', []string{},
			create_wp_rest_response(rt.new_array()))
	}
	this.retrieve_widgets()
	mut var_data := rt.new_array()
	mut var_permissions_check := rt.new_bool(this.do_permissions_check())
	mut iter_2 := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{}).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_widgets := item_2.val
		mut var_id := item_2.key
		mut var_sidebar := this.get_sidebar(var_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_sidebar)))) {
			continue
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_permissions_check.clone()]))
			&& !(this.check_read_permission(var_sidebar.clone())) {
			continue
		}
		var_data.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_sidebar.clone(),
			var_request_mutated.clone())))
	}
	return rt.call_function('rest_ensure_response', [var_data.clone()])
}

fn (mut this Class_WP_REST_Sidebars_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	mut var_sidebar := this.get_sidebar(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(var_sidebar) && this.check_read_permission(var_sidebar.clone()) {
		return true
	}
	return this.do_permissions_check()
}

fn (mut this Class_WP_REST_Sidebars_Controller) check_read_permission(var_sidebar rt.PhpVal) bool {
	mut var_sidebar_mutated := var_sidebar
	return !(!rt.is_true(var_sidebar_mutated.array_get(rt.new_string('show_in_rest'))))
}

fn (mut this Class_WP_REST_Sidebars_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	this.retrieve_widgets()
	mut var_sidebar := this.get_sidebar(var_request_mutated.array_get(rt.new_string('id')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sidebar)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('rest_sidebar_not_found'), rt.call_function('__', [
			rt.new_string('No sidebar exists with that id.'),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return this.prepare_item_for_response(var_sidebar.clone(), var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Sidebars_Controller) update_item_permissions_check(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	return rt.new_bool(this.do_permissions_check())
}

fn (mut this Class_WP_REST_Sidebars_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	if var_request_mutated.array_isset(rt.new_string('widgets')) {
		mut var_sidebars := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
		mut iter_3 := var_sidebars.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_widgets := item_3.val
			mut var_sidebar_id := item_3.key
			mut iter_4 := var_widgets.iterator()
			for {
				item_4 := iter_4.next() or { break }
				mut var_widget_id := item_4.val
				mut var_i := item_4.key
				if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_sidebar_id, var_request_mutated.array_get(rt.new_string('id'))))))
					&& rt.is_true(rt.call_function('in_array', [var_widget_id.clone(), var_request_mutated.array_get(rt.new_string('widgets')), rt.new_bool(true)])) {
					var_sidebars.array_get(var_sidebar_id).array_unset(var_i)
				}
				if rt.is_true(rt.identical(var_sidebar_id, var_request_mutated.array_get(rt.new_string('id'))))
					&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_widget_id.clone(), var_request_mutated.array_get(rt.new_string('widgets')), rt.new_bool(true)]))))) {
					var_sidebars.array_get_mut('wp_inactive_widgets').array_push(var_widget_id.clone())
				}
			}
		}
		var_sidebars.array_set(var_request_mutated.array_get(rt.new_string('id')),
			var_request_mutated.array_get(rt.new_string('widgets')))
		rt.call_function('wp_set_sidebars_widgets', [var_sidebars.clone()])
	}
	var_request_mutated.array_set('context', 'edit')
	mut var_sidebar := this.get_sidebar(var_request_mutated.array_get(rt.new_string('id')))
	rt.call_function('do_action', [rt.new_string('rest_save_sidebar'),
		var_sidebar.clone(), var_request_mutated.clone()])
	return this.prepare_item_for_response(var_sidebar.clone(), var_request_mutated.clone())
}

fn (mut this Class_WP_REST_Sidebars_Controller) do_permissions_check() bool {
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

fn (mut this Class_WP_REST_Sidebars_Controller) get_sidebar(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	return rt.call_function('wp_get_sidebar', [var_id_mutated.clone()])
}

fn (mut this Class_WP_REST_Sidebars_Controller) retrieve_widgets() {
	if !(this.widgets_retrieved) {
		rt.call_function('retrieve_widgets', []rt.PhpVal{})
		this.widgets_retrieved = true
	}
}

fn (mut this Class_WP_REST_Sidebars_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_registered_sidebars := rt.new_null()
	mut var_wp_registered_widgets := rt.new_null()
	mut var_request_mutated := var_request
	mut var_raw_sidebar := var_item
	if rt.is_true(rt.call_method(var_request_mutated, 'is_method', [
		rt.new_string('HEAD'),
	]))
	{
		return rt.call_function('apply_filters', [rt.new_string('rest_prepare_sidebar'),
			create_wp_rest_response(rt.new_array()), var_raw_sidebar.clone(),
			var_request_mutated.clone()])
	}
	mut var_id := var_raw_sidebar.array_get(rt.new_string('id'))
	mut var_sidebar := rt.create_array([rt.ArrayItem{ key: 'id', val: var_id }])
	if var_wp_registered_sidebars.array_isset(var_id) {
		mut var_registered_sidebar := var_wp_registered_sidebars.array_get(var_id)
		var_sidebar.array_set('status', 'active')
		var_sidebar.array_set('name', if !(var_registered_sidebar.array_get(rt.new_string('name'))).is_null() {
			var_registered_sidebar.array_get(rt.new_string('name'))
		} else {
			rt.new_string('')
		})
		var_sidebar.array_set('description', if var_registered_sidebar.array_isset(rt.new_string('description')) { rt.call_function('wp_sidebar_description', [
				var_id.clone(),
			]) } else { rt.new_string('') })
		var_sidebar.array_set('class', if !(var_registered_sidebar.array_get(rt.new_string('class'))).is_null() {
			var_registered_sidebar.array_get(rt.new_string('class'))
		} else {
			rt.new_string('')
		})
		var_sidebar.array_set('before_widget', if !(var_registered_sidebar.array_get(rt.new_string('before_widget'))).is_null() {
			var_registered_sidebar.array_get(rt.new_string('before_widget'))
		} else {
			rt.new_string('')
		})
		var_sidebar.array_set('after_widget', if !(var_registered_sidebar.array_get(rt.new_string('after_widget'))).is_null() {
			var_registered_sidebar.array_get(rt.new_string('after_widget'))
		} else {
			rt.new_string('')
		})
		var_sidebar.array_set('before_title', if !(var_registered_sidebar.array_get(rt.new_string('before_title'))).is_null() {
			var_registered_sidebar.array_get(rt.new_string('before_title'))
		} else {
			rt.new_string('')
		})
		var_sidebar.array_set('after_title', if !(var_registered_sidebar.array_get(rt.new_string('after_title'))).is_null() {
			var_registered_sidebar.array_get(rt.new_string('after_title'))
		} else {
			rt.new_string('')
		})
	} else {
		var_sidebar.array_set('status', 'inactive')
		var_sidebar.array_set('name', var_raw_sidebar.array_get(rt.new_string('name')))
		var_sidebar.array_set('description', '')
		var_sidebar.array_set('class', '')
	}
	if rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{})) {
		var_sidebar.array_set('status', 'inactive')
	}
	mut var_fields := this.get_fields_for_response(var_request_mutated.clone())
	if rt.is_true(rt.call_function('rest_is_field_included', [
		rt.new_string('widgets'), var_fields.clone()]))
	{
		mut var_sidebars := rt.call_function('wp_get_sidebars_widgets', []rt.PhpVal{})
		closure_1_fn := fn [var_wp_registered_widgets] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_widget_id := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(var_wp_registered_widgets.array_isset(var_widget_id))
		}
		mut var_widgets := rt.call_function('array_filter', [if !(var_sidebars.array_get(var_sidebar.array_get(rt.new_string('id')))).is_null() {
			var_sidebars.array_get(var_sidebar.array_get(rt.new_string('id')))
		} else {
			rt.new_array()
		}, rt.new_closure(closure_1_fn)])
		var_sidebar.array_set('widgets', rt.call_function('array_values', [
			var_widgets.clone()]))
	}
	mut var_schema := this.get_item_schema()
	mut var_data := rt.new_array()
	mut iter_5 := var_schema.array_get(rt.new_string('properties')).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_property := item_5.val
		mut var_property_id := item_5.key
		if var_sidebar.array_isset(var_property_id)
			&& rt.is_true(rt.identical(rt.new_bool(true), rt.call_function('rest_validate_value_from_schema', [var_sidebar.array_get(var_property_id), var_property.clone()]))) {
			var_data.array_set(var_property_id, var_sidebar.array_get(var_property_id))
		} else if var_property.array_isset(rt.new_string('default')) {
			var_data.array_set(var_property_id, var_property.array_get(rt.new_string('default')))
		}
	}
	mut var_context := if !(!rt.is_true(var_request_mutated.array_get(rt.new_string('context')))) {
		var_request_mutated.array_get(rt.new_string('context'))
	} else {
		rt.new_string('view')
	}
	var_data = this.add_additional_fields_to_object(var_data.clone(), var_request_mutated.clone())
	var_data = this.filter_response_by_context(var_data.clone(), var_context.clone())
	mut var_response := rt.call_function('rest_ensure_response', [
		var_data.clone()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_sidebar.clone())])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_sidebar'),
		var_response.clone(), var_raw_sidebar.clone(), var_request_mutated.clone()])
}

fn (mut this Class_WP_REST_Sidebars_Controller) prepare_links(var_sidebar rt.PhpVal) rt.PhpVal {
	mut var_sidebar_mutated := var_sidebar
	return rt.create_array([
		rt.ArrayItem{ key: 'collection', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base')]),
			]) },
		]) },
		rt.ArrayItem{ key: 'self', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.call_function('sprintf', [rt.new_string('%s/%s/%s'),
					rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this), 'namespace'),
					rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
						'WP_REST_Controller',
					], &this), 'rest_base'),
					var_sidebar_mutated.array_get(rt.new_string('id'))]),
			]) },
		]) },
		rt.ArrayItem{ key: 'https://api.w.org/widget', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('add_query_arg', [
				rt.new_string('sidebar'),
				var_sidebar_mutated.array_get(rt.new_string('id')),
				rt.call_function('rest_url', [rt.new_string('/wp/v2/widgets')]),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		]) },
	])
}

fn (mut this Class_WP_REST_Sidebars_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	mut var_schema := rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'sidebar' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('ID of sidebar.'),
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
					rt.new_string('Unique name identifying the sidebar.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Description of sidebar.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'class', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Extra CSS class to assign to the sidebar in the Widgets interface.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'before_widget', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("HTML content to prepend to each widget's HTML output when assigned to this sidebar. Default is an opening list item element."),
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
			rt.ArrayItem{ key: 'after_widget', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string("HTML content to append to each widget's HTML output when assigned to this sidebar. Default is a closing list item element."),
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
			rt.ArrayItem{ key: 'before_title', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML content to prepend to the sidebar title when displayed. Default is an opening h2 element.'),
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
			rt.ArrayItem{ key: 'after_title', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('HTML content to append to the sidebar title when displayed. Default is a closing h2 element.'),
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
			rt.ArrayItem{ key: 'status', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Status of sidebar.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'enum', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'active' },
					rt.ArrayItem{ key: none, val: 'inactive' },
				]) },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
				rt.ArrayItem{ key: 'readonly', val: true },
			]) },
			rt.ArrayItem{ key: 'widgets', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('Nested widgets.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'array' },
				rt.ArrayItem{ key: 'items', val: rt.create_array([
					rt.ArrayItem{ key: 'type', val: rt.create_array([
						rt.ArrayItem{ key: none, val: 'object' },
						rt.ArrayItem{ key: none, val: 'string' },
					]) },
				]) },
				rt.ArrayItem{ key: 'default', val: rt.new_array() },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'embed' },
					rt.ArrayItem{ key: none, val: 'view' },
					rt.ArrayItem{ key: none, val: 'edit' },
				]) },
			]) },
		]) },
	])
	this.dispatch_set_prop('schema', var_schema.clone())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Sidebars_Controller', [
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

fn create_wp_rest_sidebars_controller() &Class_WP_REST_Sidebars_Controller {
	mut obj := &Class_WP_REST_Sidebars_Controller{
		PhpObjectBase:     rt.PhpObjectBase{}
		widgets_retrieved: false
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

fn (mut this Class_WP_REST_Sidebars_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'check_read_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_read_permission(dispatch_arg_0))
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item_permissions_check(dispatch_arg_0)
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'do_permissions_check' {
			return rt.new_bool(this.do_permissions_check())
		}
		'get_sidebar' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_sidebar(dispatch_arg_0)
		}
		'retrieve_widgets' {
			this.retrieve_widgets()
			return rt.new_null()
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
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Sidebars_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'widgets_retrieved' { return rt.new_bool(this.widgets_retrieved) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Sidebars_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'widgets_retrieved' {
			this.widgets_retrieved = val.to_bool()
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

fn main() {
	defer {
		rt.shutdown()
	}
}

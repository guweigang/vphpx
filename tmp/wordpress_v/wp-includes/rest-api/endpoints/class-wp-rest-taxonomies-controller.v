import rt

struct Class_WP_REST_Taxonomies_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Taxonomies_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('taxonomies'))
}

fn (mut this Class_WP_REST_Taxonomies_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<taxonomy>[\\w-]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('An alphanumeric identifier for the taxonomy.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Taxonomies_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) {
		if !(!rt.is_true(var_request.array_get('type'))) {
			mut var_taxonomies := rt.call_function('get_object_taxonomies', [var_request.array_get('type'), rt.new_string('objects')])
		} else {
			var_taxonomies = rt.call_function('get_taxonomies', [rt.new_string(''), rt.new_string('objects')])
		}
		{
			mut iter_1 := var_taxonomies.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_taxonomy := item_1.val
				if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_property(var_taxonomy, 'show_in_rest'))) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_taxonomy, 'cap'), 'assign_terms')])))) {
					return true
				}
			}
		}
		return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage terms in this taxonomy.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Taxonomies_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return create_wp_rest_response(rt.new_array())
	}
	mut var_registered := this.get_collection_params()
	if var_registered.array_isset(rt.new_string('type')) && !(!rt.is_true(var_request.array_get('type'))) {
		mut var_taxonomies := rt.call_function('get_object_taxonomies', [var_request.array_get('type'), rt.new_string('objects')])
	} else {
		var_taxonomies = rt.call_function('get_taxonomies', [rt.new_string(''), rt.new_string('objects')])
	}
	mut var_data := rt.new_array()
	{
		mut iter_1 := var_taxonomies.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_tax_type := item_1.key
			if rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_value, 'show_in_rest')) || rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_value, 'cap'), 'assign_terms')]))))))))) {
				continue
			}
			mut var_tax := this.prepare_item_for_response(var_value.dup(), var_request.dup())
			var_tax = this.prepare_response_for_collection(var_tax.dup())
			var_data.array_set(var_tax_type, var_tax.dup())
		}
	}
	if !rt.is_true(var_data) {
		var_data = // unsupported expression: Expr_Cast_Object
	}
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WP_REST_Taxonomies_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_tax_obj := rt.call_function('get_taxonomy', [var_request.array_get('taxonomy')])
	if rt.is_true(var_tax_obj) {
		if !rt.is_true(rt.get_property(var_tax_obj, 'show_in_rest')) {
			return false
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_tax_obj, 'cap'), 'assign_terms')]))))))) {
			return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage terms in this taxonomy.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Taxonomies_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_tax_obj := rt.call_function('get_taxonomy', [var_request.array_get('taxonomy')])
	if !rt.is_true(var_tax_obj) {
		return create_wp_error(rt.new_string('rest_taxonomy_invalid'), rt.call_function('__', [rt.new_string('Invalid taxonomy.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_data := this.prepare_item_for_response(var_tax_obj.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WP_REST_Taxonomies_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_taxonomy := var_item
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return rt.call_function('apply_filters', [rt.new_string('rest_prepare_taxonomy'), create_wp_rest_response(rt.new_array()), var_taxonomy.dup(), var_request.dup()])
	}
	mut var_base := if !(!rt.is_true(rt.get_property(var_taxonomy, 'rest_base'))) { rt.get_property(var_taxonomy, 'rest_base') } else { rt.get_property(var_taxonomy, 'name') }
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('in_array', [rt.new_string('name'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('name', rt.get_property(var_taxonomy, 'label'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('slug'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('slug', rt.get_property(var_taxonomy, 'name'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('capabilities'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('capabilities', rt.get_property(var_taxonomy, 'cap'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('description'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('description', rt.get_property(var_taxonomy, 'description'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('labels'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('labels', rt.get_property(var_taxonomy, 'labels'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('types'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('types', rt.call_function('array_values', [rt.get_property(var_taxonomy, 'object_type')]))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('show_cloud'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('show_cloud', rt.get_property(var_taxonomy, 'show_tagcloud'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('hierarchical'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('hierarchical', rt.get_property(var_taxonomy, 'hierarchical'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('rest_base'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('rest_base', var_base.dup())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('rest_namespace'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('rest_namespace', rt.get_property(var_taxonomy, 'rest_namespace'))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('visibility'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('visibility', rt.create_array([rt.ArrayItem{ key: 'public', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'publicly_queryable', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'show_admin_column', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'show_in_nav_menus', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'show_in_quick_edit', val: // unsupported expression: Expr_Cast_Bool }, rt.ArrayItem{ key: 'show_ui', val: // unsupported expression: Expr_Cast_Bool }]))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_taxonomy.dup())])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_taxonomy'), var_response.dup(), var_taxonomy.dup(), var_request.dup()])
}

fn (mut this Class_WP_REST_Taxonomies_Controller) prepare_links(var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	return rt.create_array([rt.ArrayItem{ key: 'collection', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'rest_base')])]) }]) }, rt.ArrayItem{ key: 'https://api.w.org/items', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('rest_get_route_for_taxonomy_items', [rt.get_property(var_taxonomy_mutated, 'name')])]) }]) }])
}

fn (mut this Class_WP_REST_Taxonomies_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'schema'))
	}
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.new_string('taxonomy'), 'type': rt.new_string('object'), 'properties': { 'capabilities': { 'description': rt.call_function('__', [rt.new_string('All capabilities used by the taxonomy.')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'description': { 'description': rt.call_function('__', [rt.new_string('A human-readable description of the taxonomy.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'hierarchical': { 'description': rt.call_function('__', [rt.new_string('Whether or not the taxonomy should have children.')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'labels': { 'description': rt.call_function('__', [rt.new_string('Human-readable labels for the taxonomy for various contexts.')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'name': { 'description': rt.call_function('__', [rt.new_string('The title for the taxonomy.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'slug': { 'description': rt.call_function('__', [rt.new_string('An alphanumeric identifier for the taxonomy.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'show_cloud': { 'description': rt.call_function('__', [rt.new_string('Whether or not the term cloud should be displayed.')]), 'type': rt.new_string('boolean'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'types': { 'description': rt.call_function('__', [rt.new_string('Types associated with the taxonomy.')]), 'type': rt.new_string('array'), 'items': { 'type': rt.new_string('string') }, 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'rest_base': { 'description': rt.call_function('__', [rt.new_string('REST base route for the taxonomy.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'rest_namespace': { 'description': rt.call_function('__', [rt.new_string('REST namespace route for the taxonomy.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'visibility': { 'description': rt.call_function('__', [rt.new_string('The visibility settings for the taxonomy.')]), 'type': rt.new_string('object'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true), 'properties': { 'public': { 'description': rt.call_function('__', [rt.new_string('Whether a taxonomy is intended for use publicly either via the admin interface or by front-end users.')]), 'type': rt.new_string('boolean') }, 'publicly_queryable': { 'description': rt.call_function('__', [rt.new_string('Whether the taxonomy is publicly queryable.')]), 'type': rt.new_string('boolean') }, 'show_ui': { 'description': rt.call_function('__', [rt.new_string('Whether to generate a default UI for managing this taxonomy.')]), 'type': rt.new_string('boolean') }, 'show_admin_column': { 'description': rt.call_function('__', [rt.new_string('Whether to allow automatic creation of taxonomy columns on associated post-types table.')]), 'type': rt.new_string('boolean') }, 'show_in_nav_menus': { 'description': rt.call_function('__', [rt.new_string('Whether to make the taxonomy available for selection in navigation menus.')]), 'type': rt.new_string('boolean') }, 'show_in_quick_edit': { 'description': rt.call_function('__', [rt.new_string('Whether to show the taxonomy in the quick/bulk edit panel.')]), 'type': rt.new_string('boolean') } } } } }
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Taxonomies_Controller', ['WP_REST_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Taxonomies_Controller) get_collection_params() rt.PhpVal {
	mut var_new_params := rt.new_array()
	var_new_params['context'] = this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }]))
	var_new_params['type'] = rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Limit results to taxonomies associated with a specific post type.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }])
	return var_new_params.dup()
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_taxonomies_controller() &Class_WP_REST_Taxonomies_Controller {
	mut obj := &Class_WP_REST_Taxonomies_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Taxonomies_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_collection_params' {
			return this.get_collection_params()
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Taxonomies_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Taxonomies_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_taxonomies_controller_php() {
}

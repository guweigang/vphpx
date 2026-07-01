import rt

struct Class_WP_REST_Template_Revisions_Controller {
	rt.PhpObjectBase
pub mut:
		parent_post_type rt.PhpVal = rt.new_null()
		parent_controller rt.PhpVal = rt.new_null()
		parent_base rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) construct(var_parent_post_type rt.PhpVal)  {
	this.Class_WP_REST_Revisions_Controller.construct(var_parent_post_type.dup())
	this.parent_post_type = var_parent_post_type.dup()
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_parent_post_type.dup()])
	mut var_parent_controller := rt.call_method(var_post_type_object, 'get_rest_controller', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_controller)))) {
		var_parent_controller = create_wp_rest_templates_controller(var_parent_post_type.dup())
	}
	this.parent_controller = var_parent_controller.dup()
	this.dispatch_set_prop('rest_base', rt.new_string('revisions'))
	this.parent_base = if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_base'))) { rt.get_property(var_post_type_object, 'rest_base') } else { rt.get_property(var_post_type_object, 'name') }
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_namespace'))) { rt.get_property(var_post_type_object, 'rest_namespace') } else { rt.new_string('wp/v2') })
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'namespace'), rt.call_function('sprintf', [rt.new_string('/%s/(?P<parent>%s%s)/%s'), this.parent_base, rt.new_string('([^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?)'), rt.new_string('[\\/\\w%-]+'), rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base')]), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The id of a template')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.parent_controller }, rt.ArrayItem{ key: none, val: '_sanitize_template_id' }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'namespace'), rt.call_function('sprintf', [rt.new_string('/%s/(?P<parent>%s%s)/%s/%s'), this.parent_base, rt.new_string('([^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?)'), rt.new_string('[\\/\\w%-]+'), rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base'), rt.new_string('(?P<id>[\\d]+)')]), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The id of a template')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.parent_controller }, rt.ArrayItem{ key: none, val: '_sanitize_template_id' }]) }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'force', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'default', val: false }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Required to be true, as revisions do not support trashing.')]) }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) get_parent(var_parent_template_id rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_function('get_block_template', [var_parent_template_id.dup(), this.parent_post_type])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		return create_wp_error(rt.new_string('rest_post_invalid_parent'), rt.call_function('__', [rt.new_string('Invalid template parent ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: Class_WP_Http.not_found() }]))
	}
	mut var_parent_post_id := if !(rt.get_property(var_template, 'wp_id')).is_null() { // unsupported expression: Expr_Cast_Int } else { rt.new_int(0) }
	if rt.is_true(rt.less_equal(var_parent_post_id, rt.new_int(0))) {
		return create_wp_error(rt.new_string('rest_invalid_template'), rt.call_function('__', [rt.new_string('Templates based on theme files can\'t have revisions.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: Class_WP_Http.bad_request() }]))
	}
	return rt.call_function('get_post', [rt.get_property(var_template, 'wp_id')])
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_function('_build_block_template_result_from_post', [var_item.dup()])
	mut var_response := rt.call_method(this.parent_controller, 'prepare_item_for_response', [var_template.dup(), var_request.dup()])
	if rt.is_true(rt.call_method(var_request, 'is_method', [rt.new_string('HEAD')])) {
		return var_response.dup()
	}
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.call_method(var_response, 'get_data', []rt.PhpVal{})
	if rt.is_true(rt.call_function('in_array', [rt.new_string('parent'), var_fields.dup(), rt.new_bool(true)])) {
		var_data.array_set('parent', // unsupported expression: Expr_Cast_Int)
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	var_response = create_wp_rest_response(var_data.dup())
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		mut var_links := this.prepare_links(var_template.dup())
		rt.call_method(var_response, 'add_links', [var_links.dup()])
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.dup()])) {
		return (var_parent).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_post'), rt.get_property(var_parent, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete revisions of this post.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_revision := this.get_revision(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_revision.dup()])) {
		return (var_revision).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_delete'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete this revision.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) prepare_links(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%s/%s/%d'), rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'namespace'), this.parent_base, rt.get_property(var_template_mutated, 'id'), rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'rest_base'), rt.get_property(var_template_mutated, 'wp_id')])]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'namespace'), this.parent_base, rt.get_property(var_template_mutated, 'id')])]) }]) }])
	return var_links.dup()
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'schema'))
	}
	mut var_schema := rt.call_method(this.parent_controller, 'get_item_schema', []rt.PhpVal{})
	var_schema.array_get_mut('properties').array_set('parent', rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the parent of the revision.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]))
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Template_Revisions_Controller', ['WP_REST_Revisions_Controller'], &this), 'schema'))
}

struct Class_WP_REST_Revisions_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Templates_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_template_revisions_controller(arg_0 rt.PhpVal) &Class_WP_REST_Template_Revisions_Controller {
	mut obj := &Class_WP_REST_Template_Revisions_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		parent_post_type: rt.new_null()
		parent_controller: rt.new_null()
		parent_base: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_revisions_controller() &Class_WP_REST_Revisions_Controller {
	mut obj := &Class_WP_REST_Revisions_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_templates_controller() &Class_WP_REST_Templates_Controller {
	mut obj := &Class_WP_REST_Templates_Controller{
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

fn (mut this Class_WP_REST_Template_Revisions_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_parent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_parent(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Template_Revisions_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parent_post_type' { return this.parent_post_type }
		'parent_controller' { return this.parent_controller }
		'parent_base' { return this.parent_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Template_Revisions_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parent_post_type' { this.parent_post_type = val; return true }
		'parent_controller' { this.parent_controller = val; return true }
		'parent_base' { this.parent_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_REST_Revisions_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Revisions_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Revisions_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Templates_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Templates_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Templates_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_template_revisions_controller_php() {
}

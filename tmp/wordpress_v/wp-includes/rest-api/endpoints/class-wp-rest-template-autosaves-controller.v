import rt

struct Class_WP_REST_Template_Autosaves_Controller {
	rt.PhpObjectBase
pub mut:
		parent_post_type rt.PhpVal = rt.new_null()
		parent_controller rt.PhpVal = rt.new_null()
		revisions_controller rt.PhpVal = rt.new_null()
		parent_base rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) construct(var_parent_post_type rt.PhpVal)  {
	this.Class_WP_REST_Autosaves_Controller.construct(var_parent_post_type.dup())
	this.parent_post_type = var_parent_post_type.dup()
	mut var_post_type_object := rt.call_function('get_post_type_object', [var_parent_post_type.dup()])
	mut var_parent_controller := rt.call_method(var_post_type_object, 'get_rest_controller', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_parent_controller)))) {
		var_parent_controller = create_wp_rest_templates_controller(var_parent_post_type.dup())
	}
	this.parent_controller = var_parent_controller.dup()
	mut var_revisions_controller := rt.call_method(var_post_type_object, 'get_revisions_rest_controller', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_revisions_controller)))) {
		var_revisions_controller = create_wp_rest_revisions_controller(var_parent_post_type.dup())
	}
	this.revisions_controller = var_revisions_controller.dup()
	this.dispatch_set_prop('rest_base', rt.new_string('autosaves'))
	this.parent_base = if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_base'))) { rt.get_property(var_post_type_object, 'rest_base') } else { rt.get_property(var_post_type_object, 'name') }
	this.dispatch_set_prop('namespace', if !(!rt.is_true(rt.get_property(var_post_type_object, 'rest_namespace'))) { rt.get_property(var_post_type_object, 'rest_namespace') } else { rt.new_string('wp/v2') })
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'namespace'), rt.call_function('sprintf', [rt.new_string('/%s/(?P<id>%s%s)/%s'), this.parent_base, rt.new_string('([^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?)'), rt.new_string('[\\/\\w%-]+'), rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'rest_base')]), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The id of a template')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.parent_controller }, rt.ArrayItem{ key: none, val: '_sanitize_template_id' }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.call_method(this.parent_controller, 'get_endpoint_args_for_item_schema', [Class_WP_REST_Server.editable()]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'namespace'), rt.call_function('sprintf', [rt.new_string('/%s/(?P<parent>%s%s)/%s/%s'), this.parent_base, rt.new_string('([^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?)'), rt.new_string('[\\/\\w%-]+'), rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'rest_base'), rt.new_string('(?P<id>[\\d]+)')]), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The id of a template')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.parent_controller }, rt.ArrayItem{ key: none, val: '_sanitize_template_id' }]) }]) }, rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The ID for the autosave.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: this.revisions_controller }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
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

fn (mut this Class_WP_REST_Template_Autosaves_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_parent := this.get_parent(var_request.array_get('parent'))
	if rt.is_true(rt.call_function('is_wp_error', [var_parent.dup()])) {
		return var_parent.dup()
	}
	mut var_autosave := rt.call_function('wp_get_post_autosave', [rt.get_property(var_parent, 'ID')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_autosave)))) {
		return create_wp_error(rt.new_string('rest_post_no_autosave'), rt.call_function('__', [rt.new_string('There is no autosave revision for this template.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_response := this.prepare_item_for_response(var_autosave.dup(), var_request.dup())
	return var_response.dup()
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) get_parent(var_parent_id rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.revisions_controller, 'get_parent', [var_parent_id.dup()])
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) prepare_links(var_template rt.PhpVal) rt.PhpVal {
	mut var_template_mutated := var_template
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%s/%s/%d'), rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'namespace'), this.parent_base, rt.get_property(var_template_mutated, 'id'), rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'rest_base'), rt.get_property(var_template_mutated, 'wp_id')])]) }]) }, rt.ArrayItem{ key: 'parent', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('/%s/%s/%s'), rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'namespace'), this.parent_base, rt.get_property(var_template_mutated, 'id')])]) }]) }])
	return var_links.dup()
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'schema'))
	}
	this.dispatch_set_prop('schema', rt.call_method(this.revisions_controller, 'get_item_schema', []rt.PhpVal{}))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Template_Autosaves_Controller', ['WP_REST_Autosaves_Controller'], &this), 'schema'))
}

struct Class_WP_REST_Autosaves_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Templates_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Revisions_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_template_autosaves_controller(arg_0 rt.PhpVal) &Class_WP_REST_Template_Autosaves_Controller {
	mut obj := &Class_WP_REST_Template_Autosaves_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		parent_post_type: rt.new_null()
		parent_controller: rt.new_null()
		revisions_controller: rt.new_null()
		parent_base: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_rest_autosaves_controller() &Class_WP_REST_Autosaves_Controller {
	mut obj := &Class_WP_REST_Autosaves_Controller{
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

fn create_wp_rest_revisions_controller() &Class_WP_REST_Revisions_Controller {
	mut obj := &Class_WP_REST_Revisions_Controller{
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

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_parent' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_parent(dispatch_arg_0)
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

fn (this &Class_WP_REST_Template_Autosaves_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'parent_post_type' { return this.parent_post_type }
		'parent_controller' { return this.parent_controller }
		'revisions_controller' { return this.revisions_controller }
		'parent_base' { return this.parent_base }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Template_Autosaves_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'parent_post_type' { this.parent_post_type = val; return true }
		'parent_controller' { this.parent_controller = val; return true }
		'revisions_controller' { this.revisions_controller = val; return true }
		'parent_base' { this.parent_base = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_REST_Autosaves_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Autosaves_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Autosaves_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_REST_Revisions_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Revisions_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Revisions_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_template_autosaves_controller_php() {
}

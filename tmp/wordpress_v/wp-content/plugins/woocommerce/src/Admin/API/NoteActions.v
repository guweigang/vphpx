import rt

struct Class_Automattic_WooCommerce_Admin_API_NoteActions {
	rt.PhpObjectBase
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_NoteActions) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_NoteActions', ['Automattic_WooCommerce_Admin_API_Notes'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('Automattic_WooCommerce_Admin_API_NoteActions', ['Automattic_WooCommerce_Admin_API_Notes'], &this), 'rest_base')).str() + '/(?P<note_id>[\\d-]+)/action/(?P<action_id>[\\d-]+)', rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'note_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique ID for the Note.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }, rt.ArrayItem{ key: 'action_id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique ID for the Note Action.'), rt.new_string('woocommerce')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_Automattic_WooCommerce_Admin_API_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_NoteActions', ['Automattic_WooCommerce_Admin_API_Notes'], &this) }, rt.ArrayItem{ key: none, val: 'trigger_note_action' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_NoteActions', ['Automattic_WooCommerce_Admin_API_Notes'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Admin_API_NoteActions', ['Automattic_WooCommerce_Admin_API_Notes'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_NoteActions) trigger_note_action(var_request rt.PhpVal) rt.PhpVal {
	mut var_note := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_note(arg_0) }(rt.call_method(var_request, 'get_param', [rt.new_string('note_id')]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_note)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_invalid_id'), rt.call_function('__', [rt.new_string('Sorry, there is no resource with that ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	rt.call_method(var_note, 'set_is_read', [rt.new_bool(true)])
	rt.call_method(var_note, 'save', []rt.PhpVal{})
	mut var_triggered_action := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.get_action_by_id(arg_0, arg_1) }(var_note.dup(), rt.call_method(var_request, 'get_param', [rt.new_string('action_id')]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_triggered_action)))) {
		return create_automattic_woocommerce_admin_api_wp_error(rt.new_string('woocommerce_note_action_invalid_id'), rt.call_function('__', [rt.new_string('Sorry, there is no resource with that ID.'), rt.new_string('woocommerce')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_triggered_note := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_Automattic_WooCommerce_Admin_Notes_Notes{}; return temp.trigger_note_action(arg_0, arg_1) }(var_note.dup(), var_triggered_action.dup())
	mut var_data := rt.call_method(var_triggered_note, 'get_data', []rt.PhpVal{})
	var_data = this.prepare_item_for_response(var_data.dup(), var_request.dup())
	var_data = this.prepare_response_for_collection(var_data.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

struct Class_Automattic_WooCommerce_Admin_API_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_API_WP_Error {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_api_noteactions() &Class_Automattic_WooCommerce_Admin_API_NoteActions {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_NoteActions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_notes() &Class_Automattic_WooCommerce_Admin_API_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes() &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_api_wp_error() &Class_Automattic_WooCommerce_Admin_API_WP_Error {
	mut obj := &Class_Automattic_WooCommerce_Admin_API_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_NoteActions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'trigger_note_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.trigger_note_action(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_Automattic_WooCommerce_Admin_API_NoteActions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_NoteActions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_API_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_src_admin_api_noteactions_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
}

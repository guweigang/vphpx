import rt

const global_const_rest_api_version = '2.0'
fn register_rest_route(var_route_namespace rt.PhpVal, var_route rt.PhpVal, var_args rt.PhpVal, override bool) bool {
	if !rt.is_true(var_route_namespace) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Routes must be namespaced with plugin or theme name and version. Instead there seems to be an empty namespace \'%1$s\' for route \'%2$s\'.')]), '<code>' + (var_route_namespace).str() + '</code>', '<code>' + (var_route).str() + '</code>']), rt.new_string('4.4.0')])
		return false
	} else if !rt.is_true(var_route) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Route must be specified. Instead within the namespace \'%1$s\', there seems to be an empty route \'%2$s\'.')]), '<code>' + (var_route_namespace).str() + '</code>', '<code>' + (var_route).str() + '</code>']), rt.new_string('4.4.0')])
		return false
	}
	mut var_clean_namespace := var_route_namespace.dup().to_string().trim_space()
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Namespace must not start or end with a slash. Instead namespace \'%1$s\' for route \'%2$s\' seems to contain a slash.')]), '<code>' + (var_route_namespace).str() + '</code>', '<code>' + (var_route).str() + '</code>']), rt.new_string('5.4.2')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('rest_api_init')]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('REST API routes must be registered on the %1$s action. Instead route \'%2$s\' with namespace \'%3$s\' was not registered on this action.')]), rt.new_string('<code>rest_api_init</code>'), '<code>' + (var_route).str() + '</code>', '<code>' + (var_route_namespace).str() + '</code>']), rt.new_string('5.1.0')])
	}
	if var_args.array_isset(rt.new_string('args')) {
		mut var_common_args := var_args.array_get('args')
		var_args.array_unset(rt.new_string('args'))
	} else {
		var_common_args = rt.new_array()
	}
	if var_args.array_isset(rt.new_string('callback')) {
		var_args = rt.create_array([rt.ArrayItem{ key: none, val: var_args }])
	}
	mut var_defaults := { 'methods': rt.new_string('GET'), 'callback': rt.new_null(), 'args': rt.new_array() }
	{
		mut iter_1 := var_args.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_arg_group := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_key.dup().is_long() || var_key.dup().is_double()))))) {
				continue
			}
			var_arg_group = rt.call_function('array_merge', [var_defaults.dup(), var_arg_group.dup()])
			var_arg_group.array_set('args', rt.call_function('array_merge', [var_common_args.dup(), var_arg_group.array_get('args')]))
			if !(var_arg_group.array_isset(rt.new_string('permission_callback'))) {
				rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The REST API route definition for %1$s is missing the required %2$s argument. For REST API routes that are intended to be public, use %3$s as the permission callback.')]), '<code>' + var_clean_namespace + '/' + var_route.dup().to_string().trim_space() + '</code>', rt.new_string('<code>permission_callback</code>'), rt.new_string('<code>__return_true</code>')]), rt.new_string('5.5.0')])
			}
			{
				mut iter_2 := var_arg_group.array_get('args').iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_arg := item_2.val
					if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_arg.dup().is_array()))))) {
						rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('REST API %1$s should be an array of arrays. Non-array value detected for %2$s.')]), rt.new_string('<code>$args</code>'), '<code>' + var_clean_namespace + '/' + var_route.dup().to_string().trim_space() + '</code>']), rt.new_string('6.1.0')])
						break
						// unsupported statement: Stmt_Nop
					}
				}
			}
		}
	}
	mut var_full_route := rt.new_string('/' + var_clean_namespace + '/' + var_route.dup().to_string().trim_space())
	rt.call_method(rest_get_server(), 'register_route', [rt.new_string(var_clean_namespace).dup(), var_full_route.dup(), var_args.dup(), rt.new_bool(override)])
	return true
}

fn register_rest_field(var_object_type rt.PhpVal, var_attribute rt.PhpVal, var_args rt.PhpVal) {
	mut var_wp_rest_additional_fields := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_defaults := { 'get_callback': rt.new_null(), 'update_callback': rt.new_null(), 'schema': rt.new_null() }
	var_args = rt.call_function('wp_parse_args', [var_args.dup(), var_defaults.dup()])
	mut var_object_types := rt.cast_array(var_object_type)
	{
		mut iter_1 := var_object_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_object_type_shadow := item_1.val
			var_wp_rest_additional_fields.array_get_mut(var_object_type_shadow).array_set(var_attribute, var_args.dup())
		}
	}
}

fn rest_api_init() {
	mut var_wp := rt.new_null()
	rest_api_register_rewrites()
	// unsupported statement: Stmt_Global
	rt.call_method(var_wp, 'add_query_var', [rt.new_string('rest_route')])
}

fn rest_api_register_rewrites() {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	rt.call_function('add_rewrite_rule', ['^' + (rest_get_url_prefix()).str() + '/?$', rt.new_string('index.php?rest_route=/'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', ['^' + (rest_get_url_prefix()).str() + '/(.*)?', rt.new_string('index.php?rest_route=/$matches[1]'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', ['^' + (rt.get_property(var_wp_rewrite, 'index')).str() + '/' + (rest_get_url_prefix()).str() + '/?$', rt.new_string('index.php?rest_route=/'), rt.new_string('top')])
	rt.call_function('add_rewrite_rule', ['^' + (rt.get_property(var_wp_rewrite, 'index')).str() + '/' + (rest_get_url_prefix()).str() + '/(.*)?', rt.new_string('index.php?rest_route=/$matches[1]'), rt.new_string('top')])
}

fn rest_api_default_filters() {
	if rt.is_true(rt.call_function('wp_is_serving_rest_request', []rt.PhpVal{})) {
		rt.call_function('add_action', [rt.new_string('deprecated_function_run'), rt.new_string('rest_handle_deprecated_function'), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_filter', [rt.new_string('deprecated_function_trigger_error'), rt.new_string('__return_false')])
		rt.call_function('add_action', [rt.new_string('deprecated_argument_run'), rt.new_string('rest_handle_deprecated_argument'), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_filter', [rt.new_string('deprecated_argument_trigger_error'), rt.new_string('__return_false')])
		rt.call_function('add_action', [rt.new_string('doing_it_wrong_run'), rt.new_string('rest_handle_doing_it_wrong'), rt.new_int(10), rt.new_int(3)])
		rt.call_function('add_filter', [rt.new_string('doing_it_wrong_trigger_error'), rt.new_string('__return_false')])
	}
	rt.call_function('add_filter', [rt.new_string('rest_pre_serve_request'), rt.new_string('rest_send_cors_headers')])
	rt.call_function('add_filter', [rt.new_string('rest_post_dispatch'), rt.new_string('rest_send_allow_header'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('rest_post_dispatch'), rt.new_string('rest_filter_response_fields'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('rest_pre_dispatch'), rt.new_string('rest_handle_options_request'), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('rest_index'), rt.new_string('rest_add_application_passwords_to_index')])
}

fn create_initial_rest_routes() {
	{
		mut iter_1 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			mut var_controller := rt.call_method(var_post_type, 'get_rest_controller', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_controller)))) {
				continue
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_type, 'late_route_registration'))))) {
				rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
			}
			mut var_revisions_controller := rt.call_method(var_post_type, 'get_revisions_rest_controller', []rt.PhpVal{})
			if rt.is_true(var_revisions_controller) {
				rt.call_method(var_revisions_controller, 'register_routes', []rt.PhpVal{})
			}
			mut var_autosaves_controller := rt.call_method(var_post_type, 'get_autosave_rest_controller', []rt.PhpVal{})
			if rt.is_true(var_autosaves_controller) {
				rt.call_method(var_autosaves_controller, 'register_routes', []rt.PhpVal{})
			}
			if rt.is_true(rt.get_property(var_post_type, 'late_route_registration')) {
				rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
			}
		}
	}
	mut var_controller := create_wp_rest_post_types_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_post_statuses_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_taxonomies_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	{
		mut iter_1 := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('object')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_taxonomy := item_1.val
			var_controller = rt.call_method(var_taxonomy, 'get_rest_controller', []rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_controller)))) {
				continue
			}
			rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
		}
	}
	var_controller = create_wp_rest_users_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_application_passwords_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_comments_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	mut var_search_handlers := rt.create_array([rt.ArrayItem{ key: none, val: create_wp_rest_post_search_handler() }, rt.ArrayItem{ key: none, val: create_wp_rest_term_search_handler() }, rt.ArrayItem{ key: none, val: create_wp_rest_post_format_search_handler() }])
	var_search_handlers = rt.call_function('apply_filters', [rt.new_string('wp_rest_search_handlers'), var_search_handlers.dup()])
	var_controller = create_wp_rest_search_controller(var_search_handlers.dup())
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_block_renderer_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_block_types_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_settings_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_themes_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_plugins_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_sidebars_controller()
	rt.call_method(var_controller, 'register_routes', []rt.PhpVal{})
	var_controller = create_wp_rest_widget_types_controller()
	rt.call_method(, 'register_routes', []rt.PhpVal{})
	
}

struct Class_WP_REST_Post_Types_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Post_Statuses_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Taxonomies_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Users_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Application_Passwords_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Comments_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Post_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_REST_Term_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_REST_Post_Format_Search_Handler {
	rt.PhpObjectBase
}

struct Class_WP_REST_Search_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Block_Renderer_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Block_Types_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Settings_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Themes_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Plugins_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Sidebars_Controller {
	rt.PhpObjectBase
}

struct Class_WP_REST_Widget_Types_Controller {
	rt.PhpObjectBase
}

fn create_wp_rest_post_types_controller() &Class_WP_REST_Post_Types_Controller {
	mut obj := &Class_WP_REST_Post_Types_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_post_statuses_controller() &Class_WP_REST_Post_Statuses_Controller {
	mut obj := &Class_WP_REST_Post_Statuses_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_taxonomies_controller() &Class_WP_REST_Taxonomies_Controller {
	mut obj := &Class_WP_REST_Taxonomies_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_users_controller() &Class_WP_REST_Users_Controller {
	mut obj := &Class_WP_REST_Users_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_application_passwords_controller() &Class_WP_REST_Application_Passwords_Controller {
	mut obj := &Class_WP_REST_Application_Passwords_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_comments_controller() &Class_WP_REST_Comments_Controller {
	mut obj := &Class_WP_REST_Comments_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_post_search_handler() &Class_WP_REST_Post_Search_Handler {
	mut obj := &Class_WP_REST_Post_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_term_search_handler() &Class_WP_REST_Term_Search_Handler {
	mut obj := &Class_WP_REST_Term_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_post_format_search_handler() &Class_WP_REST_Post_Format_Search_Handler {
	mut obj := &Class_WP_REST_Post_Format_Search_Handler{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_search_controller() &Class_WP_REST_Search_Controller {
	mut obj := &Class_WP_REST_Search_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_block_renderer_controller() &Class_WP_REST_Block_Renderer_Controller {
	mut obj := &Class_WP_REST_Block_Renderer_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_block_types_controller() &Class_WP_REST_Block_Types_Controller {
	mut obj := &Class_WP_REST_Block_Types_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_settings_controller() &Class_WP_REST_Settings_Controller {
	mut obj := &Class_WP_REST_Settings_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_themes_controller() &Class_WP_REST_Themes_Controller {
	mut obj := &Class_WP_REST_Themes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_plugins_controller() &Class_WP_REST_Plugins_Controller {
	mut obj := &Class_WP_REST_Plugins_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_sidebars_controller() &Class_WP_REST_Sidebars_Controller {
	mut obj := &Class_WP_REST_Sidebars_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_rest_widget_types_controller() &Class_WP_REST_Widget_Types_Controller {
	mut obj := &Class_WP_REST_Widget_Types_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Post_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Post_Statuses_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Statuses_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Statuses_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Taxonomies_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Taxonomies_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Taxonomies_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Users_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Users_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Users_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Application_Passwords_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Application_Passwords_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Application_Passwords_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Comments_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Comments_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Comments_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Post_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Term_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Term_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Term_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Post_Format_Search_Handler) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Post_Format_Search_Handler) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Post_Format_Search_Handler) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Search_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Search_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Search_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Block_Renderer_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Block_Renderer_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Renderer_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Block_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Block_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Settings_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Settings_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Settings_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Themes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Themes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Themes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Plugins_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Plugins_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Plugins_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Sidebars_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Sidebars_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Sidebars_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_REST_Widget_Types_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Widget_Types_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Widget_Types_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_func('register_rest_route', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rt.new_bool(register_rest_route(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('register_rest_field', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return register_rest_field(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_api_init', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_init()
	})
	rt.register_func('rest_api_register_rewrites', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_register_rewrites()
	})
	rt.register_func('rest_api_default_filters', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_default_filters()
	})
	rt.register_func('create_initial_rest_routes', fn(args []rt.PhpVal) rt.PhpVal {
		return create_initial_rest_routes()
	})
	rt.register_func('rest_api_loaded', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_api_loaded()
	})
	rt.register_func('rest_get_url_prefix', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_url_prefix()
	})
	rt.register_func('get_rest_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return get_rest_url(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_url', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
		return rest_url(arg_0, arg_1)
	})
	rt.register_func('rest_do_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_do_request(arg_0)
	})
	rt.register_func('rest_get_server', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_server()
	})
	rt.register_func('rest_ensure_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_ensure_request(arg_0)
	})
	rt.register_func('rest_ensure_response', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_ensure_response(arg_0)
	})
	rt.register_func('rest_handle_deprecated_function', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_deprecated_function(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_handle_deprecated_argument', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_deprecated_argument(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_handle_doing_it_wrong', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_doing_it_wrong(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_send_cors_headers', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_send_cors_headers(arg_0)
	})
	rt.register_func('rest_handle_options_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_handle_options_request(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_send_allow_header', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_send_allow_header(arg_0, arg_1, arg_2)
	})
	rt.register_func('_rest_array_intersect_key_recursive', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _rest_array_intersect_key_recursive(arg_0, arg_1)
	})
	rt.register_func('rest_filter_response_fields', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_filter_response_fields(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_is_field_included', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_is_field_included(arg_0, arg_1))
	})
	rt.register_func('rest_output_rsd', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_output_rsd()
	})
	rt.register_func('rest_output_link_wp_head', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_output_link_wp_head()
	})
	rt.register_func('rest_output_link_header', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_output_link_header()
	})
	rt.register_func('rest_cookie_check_errors', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_cookie_check_errors(arg_0))
	})
	rt.register_func('rest_cookie_collect_status', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_cookie_collect_status()
	})
	rt.register_func('rest_application_password_collect_status', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_application_password_collect_status(arg_0, arg_1)
	})
	rt.register_func('rest_get_authenticated_app_password', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_authenticated_app_password()
	})
	rt.register_func('rest_application_password_check_errors', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_application_password_check_errors(arg_0))
	})
	rt.register_func('rest_add_application_passwords_to_index', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_add_application_passwords_to_index(arg_0)
	})
	rt.register_func('rest_get_avatar_urls', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_get_avatar_urls(arg_0)
	})
	rt.register_func('rest_get_avatar_sizes', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_avatar_sizes()
	})
	rt.register_func('rest_parse_date', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rt.new_bool(rest_parse_date(arg_0, arg_1))
	})
	rt.register_func('rest_parse_hex_color', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_parse_hex_color(arg_0))
	})
	rt.register_func('rest_get_date_with_gmt', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
		return rest_get_date_with_gmt(arg_0, arg_1)
	})
	rt.register_func('rest_authorization_required_code', fn(args []rt.PhpVal) rt.PhpVal {
		return rt.new_int(rest_authorization_required_code())
	})
	rt.register_func('rest_validate_request_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_request_arg(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_sanitize_request_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_sanitize_request_arg(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_parse_request_arg', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_parse_request_arg(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_is_ip_address', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_ip_address(arg_0))
	})
	rt.register_func('rest_sanitize_boolean', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_sanitize_boolean(arg_0)
	})
	rt.register_func('rest_is_boolean', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_boolean(arg_0))
	})
	rt.register_func('rest_is_integer', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_integer(arg_0))
	})
	rt.register_func('rest_is_array', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_is_array(arg_0)
	})
	rt.register_func('rest_sanitize_array', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_sanitize_array(arg_0)
	})
	rt.register_func('rest_is_object', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_is_object(arg_0))
	})
	rt.register_func('rest_sanitize_object', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_sanitize_object(arg_0)
	})
	rt.register_func('rest_get_best_type_for_value', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(rest_get_best_type_for_value(arg_0, arg_1))
	})
	rt.register_func('rest_handle_multi_type_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_string(rest_handle_multi_type_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_array_contains_unique_items', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_validate_array_contains_unique_items(arg_0))
	})
	rt.register_func('rest_stabilize_value', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_stabilize_value(arg_0)
	})
	rt.register_func('rest_validate_json_schema_pattern', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_validate_json_schema_pattern(arg_0, arg_1)
	})
	rt.register_func('rest_find_matching_pattern_property_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_find_matching_pattern_property_schema(arg_0, arg_1)
	})
	rt.register_func('rest_format_combining_operation_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_format_combining_operation_error(arg_0, arg_1)
	})
	rt.register_func('rest_get_combining_operation_error', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_get_combining_operation_error(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_find_any_matching_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_find_any_matching_schema(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_find_one_matching_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
		return rest_find_one_matching_schema(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('rest_are_values_equal', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_are_values_equal(arg_0, arg_1))
	})
	rt.register_func('rest_validate_enum', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_enum(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_get_allowed_schema_keywords', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_allowed_schema_keywords()
	})
	rt.register_func('rest_validate_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rt.new_bool(rest_validate_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_null_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_validate_null_value_from_schema(arg_0, arg_1))
	})
	rt.register_func('rest_validate_boolean_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(rest_validate_boolean_value_from_schema(arg_0, arg_1))
	})
	rt.register_func('rest_validate_object_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_object_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_array_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_array_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_number_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_number_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_string_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_string_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_validate_integer_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rt.new_bool(rest_validate_integer_value_from_schema(arg_0, arg_1, arg_2))
	})
	rt.register_func('rest_sanitize_value_from_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
		return rest_sanitize_value_from_schema(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_preload_api_request', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_preload_api_request(arg_0, arg_1)
	})
	rt.register_func('rest_parse_embed_param', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(rest_parse_embed_param(arg_0))
	})
	rt.register_func('rest_filter_response_by_context', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		return rest_filter_response_by_context(arg_0, arg_1, arg_2)
	})
	rt.register_func('rest_default_additional_properties_to_false', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_default_additional_properties_to_false(arg_0)
	})
	rt.register_func('rest_get_route_for_post', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_post(arg_0))
	})
	rt.register_func('rest_get_route_for_post_type_items', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_post_type_items(arg_0))
	})
	rt.register_func('rest_get_route_for_term', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_term(arg_0))
	})
	rt.register_func('rest_get_route_for_taxonomy_items', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(rest_get_route_for_taxonomy_items(arg_0))
	})
	rt.register_func('rest_get_queried_resource_route', fn(args []rt.PhpVal) rt.PhpVal {
		return rest_get_queried_resource_route()
	})
	rt.register_func('rest_get_endpoint_args_for_schema', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rest_get_endpoint_args_for_schema(arg_0, arg_1)
	})
	rt.register_func('rest_convert_error_to_response', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rest_convert_error_to_response(arg_0)
	})
	rt.register_func('wp_is_rest_endpoint', fn(args []rt.PhpVal) rt.PhpVal {
		return wp_is_rest_endpoint()
	})
	rt.register_class_factory('WP_REST_Post_Types_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_types_controller()
		return rt.new_object('WP_REST_Post_Types_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Post_Statuses_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_statuses_controller()
		return rt.new_object('WP_REST_Post_Statuses_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Taxonomies_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_taxonomies_controller()
		return rt.new_object('WP_REST_Taxonomies_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Users_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_users_controller()
		return rt.new_object('WP_REST_Users_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Application_Passwords_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_application_passwords_controller()
		return rt.new_object('WP_REST_Application_Passwords_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Comments_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_comments_controller()
		return rt.new_object('WP_REST_Comments_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Post_Search_Handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_search_handler()
		return rt.new_object('WP_REST_Post_Search_Handler', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Term_Search_Handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_term_search_handler()
		return rt.new_object('WP_REST_Term_Search_Handler', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Post_Format_Search_Handler', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_post_format_search_handler()
		return rt.new_object('WP_REST_Post_Format_Search_Handler', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Search_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_search_controller()
		return rt.new_object('WP_REST_Search_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Block_Renderer_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_block_renderer_controller()
		return rt.new_object('WP_REST_Block_Renderer_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Block_Types_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_block_types_controller()
		return rt.new_object('WP_REST_Block_Types_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Settings_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_settings_controller()
		return rt.new_object('WP_REST_Settings_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Themes_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_themes_controller()
		return rt.new_object('WP_REST_Themes_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Plugins_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_plugins_controller()
		return rt.new_object('WP_REST_Plugins_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Sidebars_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_sidebars_controller()
		return rt.new_object('WP_REST_Sidebars_Controller', []string{}, obj)
	})
	rt.register_class_factory('WP_REST_Widget_Types_Controller', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_rest_widget_types_controller()
		return rt.new_object('WP_REST_Widget_Types_Controller', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_rest_api_php() {
}

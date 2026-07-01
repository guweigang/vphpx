import rt

pub fn Class_WP_REST_Plugins_Controller.pattern() string {
	return '[^.\\/]+(?:\\/[^.\\/]+)?'
}
struct Class_WP_REST_Plugins_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Plugins_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('plugins'))
}

fn (mut this Class_WP_REST_Plugins_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.creatable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'create_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('WordPress.org plugin directory slug.')]) }, rt.ArrayItem{ key: 'pattern', val: '[\\w\\-]+' }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The plugin activation status.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) { rt.create_array([rt.ArrayItem{ key: none, val: 'inactive' }, rt.ArrayItem{ key: none, val: 'active' }, rt.ArrayItem{ key: none, val: 'network-active' }]) } else { rt.create_array([rt.ArrayItem{ key: none, val: 'inactive' }, rt.ArrayItem{ key: none, val: 'active' }]) } }, rt.ArrayItem{ key: 'default', val: 'inactive' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this), 'rest_base') + '/(?P<plugin>' + Class_WP_REST_Plugins_Controller.pattern() + ')', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.deletable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'delete_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'context', val: this.get_context_param(rt.create_array([rt.ArrayItem{ key: 'default', val: 'view' }])) }, rt.ArrayItem{ key: 'plugin', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'pattern', val: Class_WP_REST_Plugins_Controller.pattern() }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'validate_plugin_param' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'sanitize_plugin_param' }]) }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Plugins_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_view_plugins'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage plugins for this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Plugins_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_plugins := rt.new_array()
	{
		mut iter_1 := rt.call_function('get_plugins', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_file := item_1.key
			if rt.is_true(rt.call_function('is_wp_error', [this.check_read_permission(var_file.dup())])) {
				continue
			}
			var_data.array_set('_file', var_file.dup())
			if !(this.does_plugin_match_request(var_request_mutated.dup(), var_data.dup())) {
				continue
			}
			var_plugins.array_push(this.prepare_response_for_collection(this.prepare_item_for_response(var_data.dup(), var_request_mutated.dup())))
		}
	}
	return create_wp_rest_response(var_plugins.dup())
}

fn (mut this Class_WP_REST_Plugins_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_view_plugin'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage plugins for this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_can_read := rt.new_bool(this.check_read_permission(var_request_mutated.array_get('plugin')))
	if rt.is_true(rt.call_function('is_wp_error', [var_can_read.dup()])) {
		return (var_can_read).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Plugins_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_data := this.get_plugin_data(var_request_mutated.array_get('plugin'))
	if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
		return var_data.dup()
	}
	return this.prepare_item_for_response(var_data.dup(), var_request_mutated.dup())
}

fn (mut this Class_WP_REST_Plugins_Controller) check_read_permission(var_plugin rt.PhpVal) bool {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_plugin_installed(var_plugin.dup()))))) {
		return (create_wp_error(rt.new_string('rest_plugin_not_found'), rt.call_function('__', [rt.new_string('Plugin not found.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_network_only_plugin', [var_plugin.dup()]))))) || rt.is_true(rt.call_function('is_plugin_active', [var_plugin.dup()])))) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_plugins')])))) {
		return true
	}
	return (create_wp_error(rt.new_string('rest_cannot_view_plugin'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage this plugin.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Plugins_Controller) create_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_install_plugin'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to install plugins on this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))))) {
		return (create_wp_error(rt.new_string('rest_cannot_activate_plugin'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to activate plugins.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Plugins_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_filesystem := rt.new_null()
	mut var_request_mutated := var_request
	// unsupported statement: Stmt_Global
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/class-wp-upgrader.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php', '4')
	mut var_slug := var_request_mutated.array_get('slug')
	mut var_filesystem_available := rt.new_bool(this.is_filesystem_available())
	if rt.is_true(rt.call_function('is_wp_error', [var_filesystem_available.dup()])) {
		return var_filesystem_available.dup()
	}
	mut var_api := rt.call_function('plugins_api', [rt.new_string('plugin_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: var_slug }, rt.ArrayItem{ key: 'fields', val: rt.create_array([rt.ArrayItem{ key: 'sections', val: false }, rt.ArrayItem{ key: 'language_packs', val: true }]) }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_api.dup()])) {
		if rt.is_true(rt.call_function('str_contains', [rt.call_method(var_api, 'get_error_message', []rt.PhpVal{}), rt.new_string('Plugin not found.')])) {
			rt.call_method(var_api, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])])
		} else {
			rt.call_method(var_api, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		}
		return var_api.dup()
	}
	mut var_skin := create_wp_ajax_upgrader_skin()
	mut var_upgrader := create_plugin_upgrader(var_skin.dup())
	mut var_result := var_upgrader.install(rt.get_property(var_api, 'download_link'))
	if rt.is_true(rt.call_function('is_wp_error', [var_result.dup()])) {
		rt.call_method(var_result, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		return var_result.dup()
	}
	if rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_skin, 'result')])) {
		rt.call_method(rt.get_property(var_skin, 'result'), 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		return rt.get_property(var_skin, 'result')
	}
	if rt.is_true(rt.call_method(var_skin.get_errors(), 'has_errors', []rt.PhpVal{})) {
		mut var_error := var_skin.get_errors()
		rt.call_method(var_error, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }])])
		return var_error.dup()
	}
	if rt.is_true(rt.new_bool(var_result.dup().is_null())) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.instance_of(var_wp_filesystem, 'WP_Filesystem_Base'))) && rt.is_true(rt.call_function('is_wp_error', [rt.get_property(var_wp_filesystem, 'errors')])))) && rt.is_true(rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'has_errors', []rt.PhpVal{})))) {
			return create_wp_error(rt.new_string('unable_to_connect_to_filesystem'), rt.call_method(rt.get_property(var_wp_filesystem, 'errors'), 'get_error_message', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
		}
		return create_wp_error(rt.new_string('unable_to_connect_to_filesystem'), rt.call_function('__', [rt.new_string('Unable to connect to the filesystem. Please confirm your credentials.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	mut var_file := var_upgrader.plugin_info()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_file)))) {
		return create_wp_error(rt.new_string('unable_to_determine_installed_plugin'), rt.call_function('__', [rt.new_string('Unable to determine what plugin was installed.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_can_change_status := rt.new_bool(this.plugin_status_permission_check(var_file.dup(), var_request_mutated.array_get('status'), rt.new_string('inactive')))
		if rt.is_true(rt.call_function('is_wp_error', [var_can_change_status.dup()])) {
			return var_can_change_status.dup()
		}
		mut var_changed_status := rt.new_bool(this.handle_plugin_status(var_file.dup(), var_request_mutated.array_get('status'), rt.new_string('inactive')))
		if rt.is_true(rt.call_function('is_wp_error', [var_changed_status.dup()])) {
			return var_changed_status.dup()
		}
	}
	mut var_installed_locales := rt.call_function('array_values', [rt.call_function('get_available_languages', []rt.PhpVal{})])
	var_installed_locales = rt.call_function('apply_filters', [rt.new_string('plugins_update_check_locales'), var_installed_locales.dup()])
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_Cast_Object
	}
	mut var_item := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return // unsupported expression: Expr_Cast_Object
	}
	mut var_language_packs := rt.call_function('array_map', [rt.new_closure(closure_1_fn), rt.get_property(var_api, 'language_packs')])
	closure_3_fn := fn [var_installed_locales] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_pack := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('in_array', [rt.get_property(var_pack, 'language'), var_installed_locales.dup(), rt.new_bool(true)])
	}
	var_language_packs = rt.call_function('array_filter', [var_language_packs.dup(), rt.new_closure(closure_3_fn)])
	if rt.is_true(var_language_packs) {
		mut var_lp_upgrader := create_language_pack_upgrader(var_skin.dup())
		var_lp_upgrader.bulk_upgrade(var_language_packs.dup())
	}
	mut var_path := rt.new_string((rt.get_constant('WP_PLUGIN_DIR')).str() + '/' + (var_file).str())
	mut var_data := rt.call_function('get_plugin_data', [var_path.dup(), rt.new_bool(false), rt.new_bool(false)])
	var_data.array_set('_file', var_file.dup())
	mut var_response := this.prepare_item_for_response(var_data.dup(), var_request_mutated.dup())
	rt.call_method(var_response, 'set_status', [rt.new_int(201)])
	rt.call_method(var_response, 'header', [rt.new_string('Location'), rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%s'), rt.get_property(rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Plugins_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.call_function('substr', [var_file.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])])])])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Plugins_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_manage_plugins'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage plugins for this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_can_read := rt.new_bool(this.check_read_permission(var_request_mutated.array_get('plugin')))
	if rt.is_true(rt.call_function('is_wp_error', [var_can_read.dup()])) {
		return (var_can_read).to_bool()
	}
	mut var_status := rt.new_string(this.get_plugin_status(var_request_mutated.array_get('plugin')))
	if rt.is_true(rt.new_bool(rt.is_true(var_request_mutated.array_get('status')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_can_change_status := rt.new_bool(this.plugin_status_permission_check(var_request_mutated.array_get('plugin'), var_request_mutated.array_get('status'), var_status.dup()))
		if rt.is_true(rt.call_function('is_wp_error', [var_can_change_status.dup()])) {
			return (var_can_change_status).to_bool()
		}
	}
	return true
}

fn (mut this Class_WP_REST_Plugins_Controller) update_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_data := this.get_plugin_data(var_request_mutated.array_get('plugin'))
	if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
		return var_data.dup()
	}
	mut var_status := rt.new_string(this.get_plugin_status(var_request_mutated.array_get('plugin')))
	if rt.is_true(rt.new_bool(rt.is_true(var_request_mutated.array_get('status')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_handled := rt.new_bool(this.handle_plugin_status(var_request_mutated.array_get('plugin'), var_request_mutated.array_get('status'), var_status.dup()))
		if rt.is_true(rt.call_function('is_wp_error', [var_handled.dup()])) {
			return var_handled.dup()
		}
	}
	this.update_additional_fields_for_object(var_data.dup(), var_request_mutated.dup())
	var_request_mutated.array_set('context', 'edit')
	return this.prepare_item_for_response(var_data.dup(), var_request_mutated.dup())
}

fn (mut this Class_WP_REST_Plugins_Controller) delete_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_request_mutated := var_request
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_manage_plugins'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to manage plugins for this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_plugins')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_manage_plugins'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to delete plugins for this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	mut var_can_read := rt.new_bool(this.check_read_permission(.array_get()))
	if rt.is_true(rt.call_function('is_wp_error', [var_can_read.dup()])) {
		return (var_can_read).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Plugins_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_request_mutated := var_request
	
}

fn (mut this Class_WP_REST_Plugins_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
	mut var_request_mutated := var_request
}

fn (mut this Class_WP_REST_Plugins_Controller) prepare_links(var_item rt.PhpVal) rt.PhpVal {
	mut var_item_mutated := var_item
}

fn (mut this Class_WP_REST_Plugins_Controller) get_plugin_data(var_plugin rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Plugins_Controller) get_plugin_status(var_plugin rt.PhpVal) string {
}

fn (mut this Class_WP_REST_Plugins_Controller) plugin_status_permission_check(var_plugin rt.PhpVal, var_new_status rt.PhpVal, var_current_status rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Plugins_Controller) handle_plugin_status(var_plugin rt.PhpVal, var_new_status rt.PhpVal, var_current_status rt.PhpVal) bool {
}

fn (mut this Class_WP_REST_Plugins_Controller) validate_plugin_param(var_file rt.PhpVal) bool {
	mut var_file_mutated := var_file
}

fn (mut this Class_WP_REST_Plugins_Controller) sanitize_plugin_param(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
}

fn (mut this Class_WP_REST_Plugins_Controller) does_plugin_match_request(var_request rt.PhpVal, var_item rt.PhpVal) bool {
	mut var_request_mutated := var_request
	mut var_item_mutated := var_item
}

fn (mut this Class_WP_REST_Plugins_Controller) is_plugin_installed(var_plugin rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Plugins_Controller) is_filesystem_available() bool {
}

fn (mut this Class_WP_REST_Plugins_Controller) get_item_schema() rt.PhpVal {
}

fn (mut this Class_WP_REST_Plugins_Controller) get_collection_params() rt.PhpVal {
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

struct Class_WP_Ajax_Upgrader_Skin {
	rt.PhpObjectBase
}

struct Class_Plugin_Upgrader {
	rt.PhpObjectBase
}

struct Class_Language_Pack_Upgrader {
	rt.PhpObjectBase
}

fn create_wp_rest_plugins_controller() &Class_WP_REST_Plugins_Controller {
	mut obj := &Class_WP_REST_Plugins_Controller{
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

fn create_wp_ajax_upgrader_skin() &Class_WP_Ajax_Upgrader_Skin {
	mut obj := &Class_WP_Ajax_Upgrader_Skin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_plugin_upgrader() &Class_Plugin_Upgrader {
	mut obj := &Class_Plugin_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_language_pack_upgrader() &Class_Language_Pack_Upgrader {
	mut obj := &Class_Language_Pack_Upgrader{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Plugins_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'check_read_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.check_read_permission(dispatch_arg_0))
		}
		'create_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.create_item_permissions_check(dispatch_arg_0))
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'update_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_item(dispatch_arg_0)
		}
		'delete_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.delete_item_permissions_check(dispatch_arg_0))
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
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'get_plugin_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_plugin_data(dispatch_arg_0)
		}
		'get_plugin_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_plugin_status(dispatch_arg_0))
		}
		'plugin_status_permission_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.plugin_status_permission_check(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'handle_plugin_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.handle_plugin_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'validate_plugin_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_plugin_param(dispatch_arg_0))
		}
		'sanitize_plugin_param' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_plugin_param(dispatch_arg_0)
		}
		'does_plugin_match_request' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.does_plugin_match_request(dispatch_arg_0, dispatch_arg_1))
		}
		'is_plugin_installed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_plugin_installed(dispatch_arg_0)
		}
		'is_filesystem_available' {
			return rt.new_bool(this.is_filesystem_available())
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

fn (this &Class_WP_REST_Plugins_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Plugins_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Ajax_Upgrader_Skin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Ajax_Upgrader_Skin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Ajax_Upgrader_Skin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Plugin_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Plugin_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Plugin_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Language_Pack_Upgrader) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Language_Pack_Upgrader) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Language_Pack_Upgrader) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_plugins_controller_php() {
}

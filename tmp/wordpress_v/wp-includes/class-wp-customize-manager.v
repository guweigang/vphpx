import rt

struct Class_WP_Customize_Manager {
	rt.PhpObjectBase
pub mut:
		theme rt.PhpVal = rt.new_null()
		original_stylesheet rt.PhpVal = rt.new_null()
		previewing bool
		widgets rt.PhpVal = rt.new_null()
		nav_menus rt.PhpVal = rt.new_null()
		selective_refresh rt.PhpVal = rt.new_null()
		settings rt.PhpVal = rt.new_array()
		containers rt.PhpVal = rt.new_array()
		panels rt.PhpVal = rt.new_array()
		components rt.PhpVal = rt.new_array()
		sections rt.PhpVal = rt.new_array()
		controls rt.PhpVal = rt.new_array()
		registered_panel_types rt.PhpVal = rt.new_array()
		registered_section_types rt.PhpVal = rt.new_array()
		registered_control_types rt.PhpVal = rt.new_array()
		preview_url rt.PhpVal = rt.new_null()
		return_url rt.PhpVal = rt.new_null()
		autofocus rt.PhpVal = rt.new_array()
		messenger_channel rt.PhpVal = rt.new_null()
		autosaved rt.PhpVal = rt.new_bool(false)
		branching rt.PhpVal = rt.new_bool(true)
		settings_previewed rt.PhpVal = rt.new_bool(true)
		saved_starter_content_changeset bool
		_post_values rt.PhpVal = rt.new_null()
		_changeset_uuid rt.PhpVal = rt.new_null()
		_changeset_post_id rt.PhpVal = rt.new_null()
		_changeset_data rt.PhpVal = rt.new_null()
		pending_starter_content_settings_ids rt.PhpVal = rt.new_array()
		store_changeset_revision rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) construct(var_args rt.PhpVal)  {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('array_merge', [rt.call_function('array_fill_keys', [rt.create_array([rt.ArrayItem{ key: none, val: 'changeset_uuid' }, rt.ArrayItem{ key: none, val: 'theme' }, rt.ArrayItem{ key: none, val: 'messenger_channel' }, rt.ArrayItem{ key: none, val: 'settings_previewed' }, rt.ArrayItem{ key: none, val: 'autosaved' }, rt.ArrayItem{ key: none, val: 'branching' }]), rt.new_null()]), var_args_mutated.dup()])
	if !(var_args_mutated.array_isset(rt.new_string('changeset_uuid'))) {
		var_args_mutated.array_set('changeset_uuid', rt.call_function('wp_generate_uuid4', []rt.PhpVal{}))
	}
	if !(var_args_mutated.array_isset(rt.new_string('theme'))) {
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('customize_theme')) {
			var_args_mutated.array_set('theme', rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('customize_theme')]))
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('theme')) {
			var_args_mutated.array_set('theme', rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('theme')]))
		}
	}
	if !(var_args_mutated.array_isset(rt.new_string('messenger_channel'))) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('customize_messenger_channel')) {
		var_args_mutated.array_set('messenger_channel', rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('customize_messenger_channel')])]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		this.components.array_push('widgets')
	}
	this.original_stylesheet = rt.call_function('get_stylesheet', []rt.PhpVal{})
	this.theme = rt.call_function('wp_get_theme', [if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_args_mutated.array_get('theme')]))) { var_args_mutated.array_get('theme') } else { rt.new_null() }])
	this.messenger_channel = var_args_mutated.array_get('messenger_channel')
	this._changeset_uuid = var_args_mutated.array_get('changeset_uuid')
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'settings_previewed' }, rt.ArrayItem{ key: none, val: 'autosaved' }, rt.ArrayItem{ key: none, val: 'branching' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if var_args_mutated.array_isset(var_key) {
				this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":301,"name":"key"}', // unsupported expression: Expr_Cast_Bool)
			}
		}
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-setting.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-panel.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-section.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-color-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-media-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-upload-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-image-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-background-image-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-background-position-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-cropped-image-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-site-icon-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-header-image-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-theme-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-code-editor-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-widget-area-customize-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-widget-form-customize-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-item-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-location-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-name-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-locations-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-auto-add-control.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menus-panel.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-themes-panel.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-themes-section.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-sidebar-section.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-section.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-custom-css-setting.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-filter-setting.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-header-image-setting.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-background-image-setting.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-item-setting.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-setting.php', '4')
	mut var_components := rt.call_function('apply_filters', [rt.new_string('customize_loaded_components'), this.components, rt.new_object('WP_Customize_Manager', []string{}, &this)])
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-selective-refresh.php', '4')
	this.selective_refresh = create_wp_customize_selective_refresh(rt.new_object('WP_Customize_Manager', []string{}, &this).dup())
	if rt.is_true(rt.call_function('in_array', [rt.new_string('widgets'), var_components.dup(), rt.new_bool(true)])) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-widgets.php', '4')
		this.widgets = create_wp_customize_widgets(rt.new_object('WP_Customize_Manager', []string{}, &this).dup())
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('nav_menus'), var_components.dup(), rt.new_bool(true)])) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-nav-menus.php', '4')
		this.nav_menus = create_wp_customize_nav_menus(rt.new_object('WP_Customize_Manager', []string{}, &this).dup())
	}
	rt.call_function('add_action', [rt.new_string('setup_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'setup_theme' }])])
	rt.call_function('add_action', [rt.new_string('wp_loaded'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'wp_loaded' }])])
	rt.call_function('remove_action', [rt.new_string('init'), rt.new_string('wp_cron')])
	rt.call_function('remove_action', [rt.new_string('admin_init'), rt.new_string('_maybe_update_core')])
	rt.call_function('remove_action', [rt.new_string('admin_init'), rt.new_string('_maybe_update_plugins')])
	rt.call_function('remove_action', [rt.new_string('admin_init'), rt.new_string('_maybe_update_themes')])
	rt.call_function('add_action', [rt.new_string('wp_ajax_customize_save'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'save' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_customize_trash'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_changeset_trash_request' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_customize_refresh_nonces'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'refresh_nonces' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_customize_load_themes'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_load_themes_request' }])])
	rt.call_function('add_filter', [rt.new_string('heartbeat_settings'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_customize_screen_to_heartbeat_settings' }])])
	rt.call_function('add_filter', [rt.new_string('heartbeat_received'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'check_changeset_lock_with_heartbeat' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('wp_ajax_customize_override_changeset_lock'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_override_changeset_lock_request' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_customize_dismiss_autosave_or_lock'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'handle_dismiss_autosave_or_lock_request' }])])
	rt.call_function('add_action', [rt.new_string('customize_register'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_controls' }])])
	rt.call_function('add_action', [rt.new_string('customize_register'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'register_dynamic_settings' }]), rt.new_int(11)])
	rt.call_function('add_action', [rt.new_string('customize_controls_init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'prepare_controls' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'enqueue_control_scripts' }])])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_panel_templates' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_section_templates' }]), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'render_control_templates' }]), rt.new_int(1)])
	rt.call_function('add_filter', [rt.new_string('customize_render_partials_response'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'export_header_video_settings' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_pane_settings' }]), rt.new_int(1000)])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/update.php', '4')
		rt.call_function('add_action', [rt.new_string('customize_controls_print_footer_scripts'), rt.new_string('wp_print_admin_notice_templates')])
	}
}

fn (mut this Class_WP_Customize_Manager) doing_ajax(var_action rt.PhpVal) bool {
	mut var_action_mutated := var_action
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_action_mutated)))) {
		return true
	} else {
		return rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('action')]), var_action_mutated))
	}
	return false
}

fn (mut this Class_WP_Customize_Manager) wp_die(var_ajax_message rt.PhpVal, var_message rt.PhpVal)  {
	mut var_message_mutated := var_message
	if this.doing_ajax(rt.new_null()) {
		rt.call_function('wp_die', [var_ajax_message.dup()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_message_mutated)))) {
		var_message_mutated = rt.call_function('__', [rt.new_string('An error occurred while customizing. Please refresh the page and try again.')])
	}
	if rt.is_true(this.messenger_channel) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wp_enqueue_scripts', []rt.PhpVal{})
		rt.call_function('wp_print_scripts', [rt.create_array([rt.ArrayItem{ key: none, val: 'customize-base' }])])
		mut var_settings := rt.create_array([rt.ArrayItem{ key: 'messengerArgs', val: rt.create_array([rt.ArrayItem{ key: 'channel', val: this.messenger_channel }, rt.ArrayItem{ key: 'url', val: rt.call_function('wp_customize_url', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'error', val: var_ajax_message }])
		// unsupported expression: Expr_AssignOp_Concat
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_json_encode', [var_settings.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
		// unsupported statement: Stmt_InlineHTML
		// unsupported expression: Expr_AssignOp_Concat
	}
	rt.call_function('wp_die', [var_message_mutated.dup()])
}

fn (mut this Class_WP_Customize_Manager) wp_die_handler() string {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0')])
	if this.doing_ajax(rt.new_null()) || rt.get_superglobal('_POST').array_isset(rt.new_string('customized')) {
		return '_ajax_wp_die_handler'
	}
	return '_default_wp_die_handler'
}

fn (mut this Class_WP_Customize_Manager) setup_theme()  {
	mut var_pagenow := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true() {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP_Customize_Manager) establish_loaded_changeset()  {
	mut var_pagenow := rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) after_setup_theme()  {
}

fn (mut this Class_WP_Customize_Manager) start_previewing_theme()  {
}

fn (mut this Class_WP_Customize_Manager) stop_previewing_theme()  {
}

fn (mut this Class_WP_Customize_Manager) settings_previewed() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) autosaved() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) branching() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) changeset_uuid() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) theme() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) settings() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) controls() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) containers() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) sections() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) panels() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) is_theme_active() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) wp_loaded()  {
}

fn (mut this Class_WP_Customize_Manager) wp_redirect_status(var_status rt.PhpVal) i64 {
}

fn (mut this Class_WP_Customize_Manager) find_changeset_post_id(var_uuid rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_changeset_posts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) dismiss_user_auto_draft_changesets() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) changeset_post_id() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_changeset_post_data(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
}

fn (mut this Class_WP_Customize_Manager) changeset_data() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) import_theme_starter_content(var_starter_content rt.PhpVal)  {
	mut var_id_base := rt.new_null()
	mut var_instance := rt.new_null()
	mut var_starter_content_mutated := var_starter_content
}

fn (mut this Class_WP_Customize_Manager) prepare_starter_content_attachments(var_attachments rt.PhpVal) rt.PhpVal {
	mut var_attachments_mutated := var_attachments
}

fn (mut this Class_WP_Customize_Manager) _save_starter_content_changeset()  {
}

fn (mut this Class_WP_Customize_Manager) unsanitized_post_values(var_args rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) post_value(var_setting rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_setting_mutated := var_setting
}

fn (mut this Class_WP_Customize_Manager) set_post_value(var_setting_id rt.PhpVal, var_value rt.PhpVal)  {
	mut var_setting_id_mutated := var_setting_id
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Manager) customize_preview_init()  {
}

fn (mut this Class_WP_Customize_Manager) filter_iframe_security_headers(var_headers rt.PhpVal) rt.PhpVal {
	mut var_headers_mutated := var_headers
}

fn (mut this Class_WP_Customize_Manager) add_state_query_params(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
}

fn (mut this Class_WP_Customize_Manager) customize_preview_override_404_status()  {
}

fn (mut this Class_WP_Customize_Manager) customize_preview_base()  {
}

fn (mut this Class_WP_Customize_Manager) customize_preview_html5()  {
}

fn (mut this Class_WP_Customize_Manager) customize_preview_loading_style()  {
}

fn (mut this Class_WP_Customize_Manager) remove_frameless_preview_messenger_channel()  {
}

fn (mut this Class_WP_Customize_Manager) customize_preview_settings()  {
}

fn (mut this Class_WP_Customize_Manager) customize_preview_signature()  {
}

fn (mut this Class_WP_Customize_Manager) remove_preview_signature(var_callback rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) is_preview() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_template() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_stylesheet() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_template_root() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_stylesheet_root() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) current_theme(var_current_theme rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) validate_setting_values(var_setting_values rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
}

fn (mut this Class_WP_Customize_Manager) prepare_setting_validity_for_js(var_validity rt.PhpVal) rt.PhpVal {
	mut var_validity_mutated := var_validity
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) save()  {
}

fn (mut this Class_WP_Customize_Manager) save_changeset_post(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) preserve_insert_changeset_post_content(var_data rt.PhpVal, var_postarr rt.PhpVal, var_unsanitized_postarr rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

fn (mut this Class_WP_Customize_Manager) trash_changeset_post(var_post rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Customize_Manager) handle_changeset_trash_request()  {
}

fn (mut this Class_WP_Customize_Manager) grant_edit_post_capability_for_changeset(var_caps rt.PhpVal, var_cap rt.PhpVal, var_user_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_caps_mutated := var_caps
	mut var_user_id_mutated := var_user_id
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) set_changeset_lock(var_changeset_post_id rt.PhpVal, take_over bool)  {
	mut var_changeset_post_id_mutated := var_changeset_post_id
}

fn (mut this Class_WP_Customize_Manager) refresh_changeset_lock(var_changeset_post_id rt.PhpVal)  {
	mut var_changeset_post_id_mutated := var_changeset_post_id
}

fn (mut this Class_WP_Customize_Manager) add_customize_screen_to_heartbeat_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_pagenow := rt.new_null()
	mut var_settings_mutated := var_settings
}

fn (mut this Class_WP_Customize_Manager) get_lock_user_data(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
}

fn (mut this Class_WP_Customize_Manager) check_changeset_lock_with_heartbeat(var_response rt.PhpVal, var_data rt.PhpVal, var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_data_mutated := var_data
}

fn (mut this Class_WP_Customize_Manager) handle_override_changeset_lock_request()  {
}

fn (mut this Class_WP_Customize_Manager) _filter_revision_post_has_changed(var_post_has_changed rt.PhpVal, var_latest_revision rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_has_changed_mutated := var_post_has_changed
	mut var_latest_revision_mutated := var_latest_revision
	mut var_post_mutated := var_post
}

fn (mut this Class_WP_Customize_Manager) _publish_changeset_values(var_changeset_post_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_changeset_post_id_mutated := var_changeset_post_id
}

fn (mut this Class_WP_Customize_Manager) update_stashed_theme_mod_settings(var_inactive_theme_mod_settings rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) refresh_nonces()  {
}

fn (mut this Class_WP_Customize_Manager) handle_dismiss_autosave_or_lock_request()  {
}

fn (mut this Class_WP_Customize_Manager) add_setting(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) add_dynamic_settings(var_setting_ids rt.PhpVal) rt.PhpVal {
	mut var_setting_ids_mutated := var_setting_ids
}

fn (mut this Class_WP_Customize_Manager) get_setting(var_id rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_setting(var_id rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Manager) add_panel(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) get_panel(var_id rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_panel(var_id rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Manager) register_panel_type(var_panel rt.PhpVal)  {
	mut var_panel_mutated := var_panel
}

fn (mut this Class_WP_Customize_Manager) render_panel_templates()  {
}

fn (mut this Class_WP_Customize_Manager) add_section(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) get_section(var_id rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_section(var_id rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Manager) register_section_type(var_section rt.PhpVal)  {
	mut var_section_mutated := var_section
}

fn (mut this Class_WP_Customize_Manager) render_section_templates()  {
}

fn (mut this Class_WP_Customize_Manager) add_control(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
}

fn (mut this Class_WP_Customize_Manager) get_control(var_id rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_control(var_id rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Manager) register_control_type(var_control rt.PhpVal)  {
	mut var_control_mutated := var_control
}

fn (mut this Class_WP_Customize_Manager) render_control_templates()  {
}

fn (mut this Class_WP_Customize_Manager) _cmp_priority(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) prepare_controls()  {
}

fn (mut this Class_WP_Customize_Manager) enqueue_control_scripts()  {
}

fn (mut this Class_WP_Customize_Manager) is_ios() bool {
}

fn (mut this Class_WP_Customize_Manager) get_document_title_template() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) set_preview_url(var_preview_url rt.PhpVal)  {
	mut var_preview_url_mutated := var_preview_url
}

fn (mut this Class_WP_Customize_Manager) get_preview_url() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) is_cross_domain() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_allowed_urls() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_messenger_channel() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) set_return_url(var_return_url rt.PhpVal)  {
	mut var_return_url_mutated := var_return_url
}

fn (mut this Class_WP_Customize_Manager) get_return_url() rt.PhpVal {
	mut var__registered_pages := rt.new_null()
	mut var_query_vars := rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) set_autofocus(var_autofocus rt.PhpVal)  {
}

fn (mut this Class_WP_Customize_Manager) get_autofocus() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) get_nonces() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) customize_pane_settings()  {
}

fn (mut this Class_WP_Customize_Manager) get_previewable_devices() rt.PhpVal {
}

fn (mut this Class_WP_Customize_Manager) register_controls()  {
}

fn (mut this Class_WP_Customize_Manager) has_published_pages() bool {
}

fn (mut this Class_WP_Customize_Manager) register_dynamic_settings()  {
}

fn (mut this Class_WP_Customize_Manager) handle_load_themes_request()  {
}

fn (mut this Class_WP_Customize_Manager) _sanitize_header_textcolor(var_color rt.PhpVal) string {
	mut var_color_mutated := var_color
}

fn (mut this Class_WP_Customize_Manager) _sanitize_background_setting(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_setting_mutated := var_setting
}

fn (mut this Class_WP_Customize_Manager) export_header_video_settings(var_response rt.PhpVal, var_selective_refresh rt.PhpVal, var_partials rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
}

fn (mut this Class_WP_Customize_Manager) _validate_header_video(var_validity rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_validity_mutated := var_validity
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Manager) _validate_external_header_video(var_validity rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_validity_mutated := var_validity
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Manager) _sanitize_external_header_video(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Customize_Manager) _render_custom_logo_partial() rt.PhpVal {
}

struct Class_WP_Customize_Selective_Refresh {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Widgets {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Nav_Menus {
	rt.PhpObjectBase
}

fn create_wp_customize_manager(arg_0 rt.PhpVal) &Class_WP_Customize_Manager {
	mut obj := &Class_WP_Customize_Manager{
		PhpObjectBase: rt.PhpObjectBase{}
		theme: rt.new_null()
		original_stylesheet: rt.new_null()
		previewing: false
		widgets: rt.new_null()
		nav_menus: rt.new_null()
		selective_refresh: rt.new_null()
		settings: rt.new_array()
		containers: rt.new_array()
		panels: rt.new_array()
		components: rt.new_array()
		sections: rt.new_array()
		controls: rt.new_array()
		registered_panel_types: rt.new_array()
		registered_section_types: rt.new_array()
		registered_control_types: rt.new_array()
		preview_url: rt.new_null()
		return_url: rt.new_null()
		autofocus: rt.new_array()
		messenger_channel: rt.new_null()
		autosaved: rt.new_bool(false)
		branching: rt.new_bool(true)
		settings_previewed: rt.new_bool(true)
		saved_starter_content_changeset: false
		_post_values: rt.new_null()
		_changeset_uuid: rt.new_null()
		_changeset_post_id: rt.new_null()
		_changeset_data: rt.new_null()
		pending_starter_content_settings_ids: rt.new_array()
		store_changeset_revision: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_wp_customize_selective_refresh() &Class_WP_Customize_Selective_Refresh {
	mut obj := &Class_WP_Customize_Selective_Refresh{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_widgets() &Class_WP_Customize_Widgets {
	mut obj := &Class_WP_Customize_Widgets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_nav_menus() &Class_WP_Customize_Nav_Menus {
	mut obj := &Class_WP_Customize_Nav_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Manager) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'doing_ajax' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.doing_ajax(dispatch_arg_0))
		}
		'wp_die' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.wp_die(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'wp_die_handler' {
			return rt.new_string(this.wp_die_handler())
		}
		'setup_theme' {
			this.setup_theme()
			return rt.new_null()
		}
		'establish_loaded_changeset' {
			this.establish_loaded_changeset()
			return rt.new_null()
		}
		'after_setup_theme' {
			this.after_setup_theme()
			return rt.new_null()
		}
		'start_previewing_theme' {
			this.start_previewing_theme()
			return rt.new_null()
		}
		'stop_previewing_theme' {
			this.stop_previewing_theme()
			return rt.new_null()
		}
		'settings_previewed' {
			return this.settings_previewed()
		}
		'autosaved' {
			return this.autosaved()
		}
		'branching' {
			return this.branching()
		}
		'changeset_uuid' {
			return this.changeset_uuid()
		}
		'theme' {
			return this.theme()
		}
		'settings' {
			return this.settings()
		}
		'controls' {
			return this.controls()
		}
		'containers' {
			return this.containers()
		}
		'sections' {
			return this.sections()
		}
		'panels' {
			return this.panels()
		}
		'is_theme_active' {
			return this.is_theme_active()
		}
		'wp_loaded' {
			this.wp_loaded()
			return rt.new_null()
		}
		'wp_redirect_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.wp_redirect_status(dispatch_arg_0))
		}
		'find_changeset_post_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.find_changeset_post_id(dispatch_arg_0)
		}
		'get_changeset_posts' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_changeset_posts(dispatch_arg_0)
		}
		'dismiss_user_auto_draft_changesets' {
			return this.dismiss_user_auto_draft_changesets()
		}
		'changeset_post_id' {
			return this.changeset_post_id()
		}
		'get_changeset_post_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_changeset_post_data(dispatch_arg_0)
		}
		'changeset_data' {
			return this.changeset_data()
		}
		'import_theme_starter_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.import_theme_starter_content(dispatch_arg_0)
			return rt.new_null()
		}
		'prepare_starter_content_attachments' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_starter_content_attachments(dispatch_arg_0)
		}
		'_save_starter_content_changeset' {
			this._save_starter_content_changeset()
			return rt.new_null()
		}
		'unsanitized_post_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.unsanitized_post_values(dispatch_arg_0)
		}
		'post_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.post_value(dispatch_arg_0, dispatch_arg_1)
		}
		'set_post_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_post_value(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'customize_preview_init' {
			this.customize_preview_init()
			return rt.new_null()
		}
		'filter_iframe_security_headers' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_iframe_security_headers(dispatch_arg_0)
		}
		'add_state_query_params' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_state_query_params(dispatch_arg_0)
		}
		'customize_preview_override_404_status' {
			this.customize_preview_override_404_status()
			return rt.new_null()
		}
		'customize_preview_base' {
			this.customize_preview_base()
			return rt.new_null()
		}
		'customize_preview_html5' {
			this.customize_preview_html5()
			return rt.new_null()
		}
		'customize_preview_loading_style' {
			this.customize_preview_loading_style()
			return rt.new_null()
		}
		'remove_frameless_preview_messenger_channel' {
			this.remove_frameless_preview_messenger_channel()
			return rt.new_null()
		}
		'customize_preview_settings' {
			this.customize_preview_settings()
			return rt.new_null()
		}
		'customize_preview_signature' {
			this.customize_preview_signature()
			return rt.new_null()
		}
		'remove_preview_signature' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.remove_preview_signature(dispatch_arg_0)
		}
		'is_preview' {
			return this.is_preview()
		}
		'get_template' {
			return this.get_template()
		}
		'get_stylesheet' {
			return this.get_stylesheet()
		}
		'get_template_root' {
			return this.get_template_root()
		}
		'get_stylesheet_root' {
			return this.get_stylesheet_root()
		}
		'current_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.current_theme(dispatch_arg_0)
		}
		'validate_setting_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_setting_values(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_setting_validity_for_js' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_setting_validity_for_js(dispatch_arg_0)
		}
		'save' {
			this.save()
			return rt.new_null()
		}
		'save_changeset_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.save_changeset_post(dispatch_arg_0)
		}
		'preserve_insert_changeset_post_content' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.preserve_insert_changeset_post_content(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'trash_changeset_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.trash_changeset_post(dispatch_arg_0))
		}
		'handle_changeset_trash_request' {
			this.handle_changeset_trash_request()
			return rt.new_null()
		}
		'grant_edit_post_capability_for_changeset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.grant_edit_post_capability_for_changeset(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'set_changeset_lock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			this.set_changeset_lock(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'refresh_changeset_lock' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.refresh_changeset_lock(dispatch_arg_0)
			return rt.new_null()
		}
		'add_customize_screen_to_heartbeat_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_customize_screen_to_heartbeat_settings(dispatch_arg_0)
		}
		'get_lock_user_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_lock_user_data(dispatch_arg_0)
		}
		'check_changeset_lock_with_heartbeat' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.check_changeset_lock_with_heartbeat(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'handle_override_changeset_lock_request' {
			this.handle_override_changeset_lock_request()
			return rt.new_null()
		}
		'_filter_revision_post_has_changed' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this._filter_revision_post_has_changed(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'_publish_changeset_values' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this._publish_changeset_values(dispatch_arg_0))
		}
		'update_stashed_theme_mod_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update_stashed_theme_mod_settings(dispatch_arg_0)
		}
		'refresh_nonces' {
			this.refresh_nonces()
			return rt.new_null()
		}
		'handle_dismiss_autosave_or_lock_request' {
			this.handle_dismiss_autosave_or_lock_request()
			return rt.new_null()
		}
		'add_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_setting(dispatch_arg_0, dispatch_arg_1)
		}
		'add_dynamic_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_dynamic_settings(dispatch_arg_0)
		}
		'get_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_setting(dispatch_arg_0)
		}
		'remove_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_setting(dispatch_arg_0)
			return rt.new_null()
		}
		'add_panel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_panel(dispatch_arg_0, dispatch_arg_1)
		}
		'get_panel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_panel(dispatch_arg_0)
		}
		'remove_panel' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_panel(dispatch_arg_0)
			return rt.new_null()
		}
		'register_panel_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_panel_type(dispatch_arg_0)
			return rt.new_null()
		}
		'render_panel_templates' {
			this.render_panel_templates()
			return rt.new_null()
		}
		'add_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_section(dispatch_arg_0, dispatch_arg_1)
		}
		'get_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_section(dispatch_arg_0)
		}
		'remove_section' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_section(dispatch_arg_0)
			return rt.new_null()
		}
		'register_section_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_section_type(dispatch_arg_0)
			return rt.new_null()
		}
		'render_section_templates' {
			this.render_section_templates()
			return rt.new_null()
		}
		'add_control' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_control(dispatch_arg_0, dispatch_arg_1)
		}
		'get_control' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_control(dispatch_arg_0)
		}
		'remove_control' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_control(dispatch_arg_0)
			return rt.new_null()
		}
		'register_control_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register_control_type(dispatch_arg_0)
			return rt.new_null()
		}
		'render_control_templates' {
			this.render_control_templates()
			return rt.new_null()
		}
		'_cmp_priority' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._cmp_priority(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_controls' {
			this.prepare_controls()
			return rt.new_null()
		}
		'enqueue_control_scripts' {
			this.enqueue_control_scripts()
			return rt.new_null()
		}
		'is_ios' {
			return rt.new_bool(this.is_ios())
		}
		'get_document_title_template' {
			return this.get_document_title_template()
		}
		'set_preview_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_preview_url(dispatch_arg_0)
			return rt.new_null()
		}
		'get_preview_url' {
			return this.get_preview_url()
		}
		'is_cross_domain' {
			return this.is_cross_domain()
		}
		'get_allowed_urls' {
			return this.get_allowed_urls()
		}
		'get_messenger_channel' {
			return this.get_messenger_channel()
		}
		'set_return_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_return_url(dispatch_arg_0)
			return rt.new_null()
		}
		'get_return_url' {
			return this.get_return_url()
		}
		'set_autofocus' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_autofocus(dispatch_arg_0)
			return rt.new_null()
		}
		'get_autofocus' {
			return this.get_autofocus()
		}
		'get_nonces' {
			return this.get_nonces()
		}
		'customize_pane_settings' {
			this.customize_pane_settings()
			return rt.new_null()
		}
		'get_previewable_devices' {
			return this.get_previewable_devices()
		}
		'register_controls' {
			this.register_controls()
			return rt.new_null()
		}
		'has_published_pages' {
			return rt.new_bool(this.has_published_pages())
		}
		'register_dynamic_settings' {
			this.register_dynamic_settings()
			return rt.new_null()
		}
		'handle_load_themes_request' {
			this.handle_load_themes_request()
			return rt.new_null()
		}
		'_sanitize_header_textcolor' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this._sanitize_header_textcolor(dispatch_arg_0))
		}
		'_sanitize_background_setting' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._sanitize_background_setting(dispatch_arg_0, dispatch_arg_1)
		}
		'export_header_video_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.export_header_video_settings(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'_validate_header_video' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._validate_header_video(dispatch_arg_0, dispatch_arg_1)
		}
		'_validate_external_header_video' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._validate_external_header_video(dispatch_arg_0, dispatch_arg_1)
		}
		'_sanitize_external_header_video' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._sanitize_external_header_video(dispatch_arg_0)
		}
		'_render_custom_logo_partial' {
			return this._render_custom_logo_partial()
		}
		else { return none }
	}
}

fn (this &Class_WP_Customize_Manager) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'theme' { return this.theme }
		'original_stylesheet' { return this.original_stylesheet }
		'previewing' { return rt.new_bool(this.previewing) }
		'widgets' { return this.widgets }
		'nav_menus' { return this.nav_menus }
		'selective_refresh' { return this.selective_refresh }
		'settings' { return this.settings }
		'containers' { return this.containers }
		'panels' { return this.panels }
		'components' { return this.components }
		'sections' { return this.sections }
		'controls' { return this.controls }
		'registered_panel_types' { return this.registered_panel_types }
		'registered_section_types' { return this.registered_section_types }
		'registered_control_types' { return this.registered_control_types }
		'preview_url' { return this.preview_url }
		'return_url' { return this.return_url }
		'autofocus' { return this.autofocus }
		'messenger_channel' { return this.messenger_channel }
		'autosaved' { return this.autosaved }
		'branching' { return this.branching }
		'settings_previewed' { return this.settings_previewed }
		'saved_starter_content_changeset' { return rt.new_bool(this.saved_starter_content_changeset) }
		'_post_values' { return this._post_values }
		'_changeset_uuid' { return this._changeset_uuid }
		'_changeset_post_id' { return this._changeset_post_id }
		'_changeset_data' { return this._changeset_data }
		'pending_starter_content_settings_ids' { return this.pending_starter_content_settings_ids }
		'store_changeset_revision' { return this.store_changeset_revision }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Manager) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'theme' { this.theme = val; return true }
		'original_stylesheet' { this.original_stylesheet = val; return true }
		'previewing' { this.previewing = (val).to_bool(); return true }
		'widgets' { this.widgets = val; return true }
		'nav_menus' { this.nav_menus = val; return true }
		'selective_refresh' { this.selective_refresh = val; return true }
		'settings' { this.settings = val; return true }
		'containers' { this.containers = val; return true }
		'panels' { this.panels = val; return true }
		'components' { this.components = val; return true }
		'sections' { this.sections = val; return true }
		'controls' { this.controls = val; return true }
		'registered_panel_types' { this.registered_panel_types = val; return true }
		'registered_section_types' { this.registered_section_types = val; return true }
		'registered_control_types' { this.registered_control_types = val; return true }
		'preview_url' { this.preview_url = val; return true }
		'return_url' { this.return_url = val; return true }
		'autofocus' { this.autofocus = val; return true }
		'messenger_channel' { this.messenger_channel = val; return true }
		'autosaved' { this.autosaved = val; return true }
		'branching' { this.branching = val; return true }
		'settings_previewed' { this.settings_previewed = val; return true }
		'saved_starter_content_changeset' { this.saved_starter_content_changeset = (val).to_bool(); return true }
		'_post_values' { this._post_values = val; return true }
		'_changeset_uuid' { this._changeset_uuid = val; return true }
		'_changeset_post_id' { this._changeset_post_id = val; return true }
		'_changeset_data' { this._changeset_data = val; return true }
		'pending_starter_content_settings_ids' { this.pending_starter_content_settings_ids = val; return true }
		'store_changeset_revision' { this.store_changeset_revision = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Customize_Selective_Refresh) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Selective_Refresh) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Selective_Refresh) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Widgets) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Widgets) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Widgets) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Nav_Menus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Nav_Menus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Nav_Menus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
	rt.register_class_factory('WP_Customize_Manager', fn(args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_wp_customize_manager(c_arg_0)
		return rt.new_object('WP_Customize_Manager', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Selective_Refresh', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_selective_refresh()
		return rt.new_object('WP_Customize_Selective_Refresh', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Widgets', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_widgets()
		return rt.new_object('WP_Customize_Widgets', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Nav_Menus', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_nav_menus()
		return rt.new_object('WP_Customize_Nav_Menus', []string{}, obj)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_class_wp_customize_manager_php() {
}

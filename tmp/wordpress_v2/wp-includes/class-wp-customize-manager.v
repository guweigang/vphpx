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

fn (mut this Class_WP_Customize_Manager) construct(var_args rt.PhpVal) {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('array_merge', [rt.call_function('array_fill_keys', [rt.create_array([rt.ArrayItem{ key: none, val: 'changeset_uuid' }, rt.ArrayItem{ key: none, val: 'theme' }, rt.ArrayItem{ key: none, val: 'messenger_channel' }, rt.ArrayItem{ key: none, val: 'settings_previewed' }, rt.ArrayItem{ key: none, val: 'autosaved' }, rt.ArrayItem{ key: none, val: 'branching' }]), rt.new_null()]), var_args_mutated.clone()])
	if !(var_args_mutated.array_isset(rt.new_string('changeset_uuid'))) {
		var_args_mutated.array_set('changeset_uuid', rt.call_function('wp_generate_uuid4', []rt.PhpVal{}))
	}
	if !(var_args_mutated.array_isset(rt.new_string('theme'))) {
		if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('customize_theme')) {
			var_args_mutated.array_set('theme', rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('customize_theme'))]))
		} else if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('theme')) {
			var_args_mutated.array_set('theme', rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme'))]))
		}
	}
	if !(var_args_mutated.array_isset(rt.new_string('messenger_channel'))) && rt.get_superglobal('_REQUEST').array_isset(rt.new_string('customize_messenger_channel')) {
		var_args_mutated.array_set('messenger_channel', rt.call_function('sanitize_key', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('customize_messenger_channel'))])]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		this.components.array_push('widgets')
	}
	this.original_stylesheet = rt.call_function('get_stylesheet', []rt.PhpVal{})
	this.theme = rt.call_function('wp_get_theme', [if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('validate_file', [var_args_mutated.array_get(rt.new_string('theme'))]))) { var_args_mutated.array_get(rt.new_string('theme')) } else { rt.new_null() }])
	this.messenger_channel = var_args_mutated.array_get(rt.new_string('messenger_channel'))
	this._changeset_uuid = var_args_mutated.array_get(rt.new_string('changeset_uuid'))
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'settings_previewed' }, rt.ArrayItem{ key: none, val: 'autosaved' }, rt.ArrayItem{ key: none, val: 'branching' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if var_args_mutated.array_isset(var_key) {
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":301,"name":"key"}', (var_args_mutated.array_get(var_key)).to_bool())
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
	this.selective_refresh = create_wp_customize_selective_refresh(rt.new_object('WP_Customize_Manager', []string{}, &this))
	if rt.is_true(rt.call_function('in_array', [rt.new_string('widgets'), var_components.clone(), rt.new_bool(true)])) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-widgets.php', '4')
		this.widgets = create_wp_customize_widgets(rt.new_object('WP_Customize_Manager', []string{}, &this))
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('nav_menus'), var_components.clone(), rt.new_bool(true)])) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/class-wp-customize-nav-menus.php', '4')
		this.nav_menus = create_wp_customize_nav_menus(rt.new_object('WP_Customize_Manager', []string{}, &this))
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
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) {
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
		return rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action')) && rt.is_true(rt.identical(rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('action'))]), var_action_mutated))
	}
	return false
}

fn (mut this Class_WP_Customize_Manager) wp_die(var_ajax_message rt.PhpVal, var_message rt.PhpVal) {
	mut var_message_mutated := var_message
	if this.doing_ajax(rt.new_null()) {
		rt.call_function('wp_die', [var_ajax_message.clone()])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_message_mutated)))) {
	var_message_mutated = rt.call_function('__', [rt.new_string('An error occurred while customizing. Please refresh the page and try again.')])
	}
	if rt.is_true(this.messenger_channel) {
		rt.call_function('ob_start', []rt.PhpVal{})
		rt.call_function('wp_enqueue_scripts', []rt.PhpVal{})
		rt.call_function('wp_print_scripts', [rt.create_array([rt.ArrayItem{ key: none, val: 'customize-base' }])])
		mut var_settings := rt.create_array([rt.ArrayItem{ key: 'messengerArgs', val: rt.create_array([rt.ArrayItem{ key: 'channel', val: this.messenger_channel }, rt.ArrayItem{ key: 'url', val: rt.call_function('wp_customize_url', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'error', val: var_ajax_message }])
		var_message_mutated = rt.concat(var_message_mutated, rt.call_function('ob_get_clean', []rt.PhpVal{}))
		rt.call_function('ob_start', []rt.PhpVal{})
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_json_encode', [var_settings.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
		// unsupported statement: Stmt_InlineHTML
		var_message_mutated = rt.concat(var_message_mutated, rt.call_function('wp_get_inline_script_tag', [rt.new_string((rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])).str() + '\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@METHOD)])).str())]))
	}
	rt.call_function('wp_die', [var_message_mutated.clone()])
}

fn (mut this Class_WP_Customize_Manager) wp_die_handler() string {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0')])
	if this.doing_ajax(rt.new_null()) || rt.get_superglobal('_POST').array_isset(rt.new_string('customized')) {
		return '_ajax_wp_die_handler'
	}
	return '_default_wp_die_handler'
}

fn (mut this Class_WP_Customize_Manager) setup_theme() {
	mut var_pagenow := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('customize.php'), var_pagenow)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')]))))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
			rt.call_function('auth_redirect', []rt.PhpVal{})
		} else {
			rt.call_function('wp_die', [rt.new_string('<h1>' + (rt.call_function('__', [rt.new_string('You need a higher level of permission.')])).str() + '</h1>' + '<p>' + (rt.call_function('__', [rt.new_string('Sorry, you are not allowed to customize this site.')])).str() + '</p>'), rt.new_int(403)])
		}
		return
	}
	if !(this._changeset_uuid).is_null() && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), this._changeset_uuid)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_uuid', [this._changeset_uuid]))))) {
		this.wp_die(rt.new_int(-1), rt.call_function('__', [rt.new_string('Invalid changeset UUID')]))
	}
	mut var_has_post_data_nonce := rt.new_bool(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('preview-customize_' + (this.get_stylesheet()).str()), rt.new_string('nonce'), rt.new_bool(false)])) || rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('save-customize_' + (this.get_stylesheet()).str()), rt.new_string('nonce'), rt.new_bool(false)])) || rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('preview-customize_' + (this.get_stylesheet()).str()), rt.new_string('customize_preview_nonce'), rt.new_bool(false)])))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_has_post_data_nonce)))) {
		rt.get_superglobal('_POST').array_unset(rt.new_string('customized'))
		rt.get_superglobal('_REQUEST').array_unset(rt.new_string('customized'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(this.changeset_post_id())))) {
		this.wp_die(rt.new_int(if rt.is_true(this.messenger_channel) { 0 } else { -1 }), rt.call_function('__', [rt.new_string('Non-existent changeset UUID.')]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('send_origin_headers', []rt.PhpVal{})
	}
	if rt.is_true(this.messenger_channel) {
		rt.call_function('show_admin_bar', [rt.new_bool(false)])
	}
	if rt.is_true(this.is_theme_active()) {
		rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'after_setup_theme' }])])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))))) {
			this.wp_die(rt.new_int(-1), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit theme options on this site.')]))
		}
		if rt.is_true(rt.call_method(this.theme(), 'errors', []rt.PhpVal{})) {
			this.wp_die(rt.new_int(-1), rt.call_method(rt.call_method(this.theme(), 'errors', []rt.PhpVal{}), 'get_error_message', []rt.PhpVal{}))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(this.theme(), 'is_allowed', []rt.PhpVal{}))))) {
			this.wp_die(rt.new_int(-1), rt.call_function('__', [rt.new_string('The requested theme does not exist.')]))
		}
	}
	rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'establish_loaded_changeset' }]), rt.new_int(5)])
	if rt.is_true(rt.call_function('get_option', [rt.new_string('fresh_site')])) && rt.is_true(rt.identical(rt.new_string('customize.php'), var_pagenow)) {
		rt.call_function('add_action', [rt.new_string('after_setup_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'import_theme_starter_content' }]), rt.new_int(100)])
	}
	this.start_previewing_theme()
}

fn (mut this Class_WP_Customize_Manager) establish_loaded_changeset() {
	mut var_pagenow := rt.new_null()
	if !rt.is_true(this._changeset_uuid) {
		mut var_changeset_uuid := rt.new_null()
		if rt.is_true(rt.new_bool(!(rt.is_true(this.branching())))) && rt.is_true(this.is_theme_active()) {
			mut var_unpublished_changeset_posts := this.get_changeset_posts(rt.create_array([rt.ArrayItem{ key: 'post_status', val: rt.call_function('array_diff', [rt.call_function('get_post_stati', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'auto-draft' }, rt.ArrayItem{ key: none, val: 'publish' }, rt.ArrayItem{ key: none, val: 'trash' }, rt.ArrayItem{ key: none, val: 'inherit' }, rt.ArrayItem{ key: none, val: 'private' }])]) }, rt.ArrayItem{ key: 'exclude_restore_dismissed', val: false }, rt.ArrayItem{ key: 'author', val: 'any' }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'order', val: 'DESC' }, rt.ArrayItem{ key: 'orderby', val: 'date' }]))
			mut var_unpublished_changeset_post := rt.call_function('array_shift', [var_unpublished_changeset_posts.clone()])
			if !(!rt.is_true(var_unpublished_changeset_post)) && rt.is_true(rt.call_function('wp_is_uuid', [rt.get_property(var_unpublished_changeset_post, 'post_name')])) {
			var_changeset_uuid = rt.get_property(var_unpublished_changeset_post, 'post_name')
			}
		}
		if !rt.is_true(var_changeset_uuid) {
		var_changeset_uuid = rt.call_function('wp_generate_uuid4', []rt.PhpVal{})
		}
		this._changeset_uuid = var_changeset_uuid.clone()
	}
	if rt.is_true(rt.call_function('is_admin', []rt.PhpVal{})) && rt.is_true(rt.identical(rt.new_string('customize.php'), var_pagenow)) {
		this.set_changeset_lock(this.changeset_post_id(), false)
	}
}

fn (mut this Class_WP_Customize_Manager) after_setup_theme() {
	mut var_doing_ajax_or_is_customized := rt.new_bool(this.doing_ajax(rt.new_null()) || rt.get_superglobal('_POST').array_isset(rt.new_string('customized')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_doing_ajax_or_is_customized)))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('validate_current_theme', []rt.PhpVal{}))))) {
		rt.call_function('wp_redirect', [rt.new_string('themes.php?broken=true')])
		exit(0)
	}
}

fn (mut this Class_WP_Customize_Manager) start_previewing_theme() {
	if this.is_preview() {
		return
	}
	this.previewing = true
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_theme_active())))) {
		rt.call_function('add_filter', [rt.new_string('template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_template' }])])
		rt.call_function('add_filter', [rt.new_string('stylesheet'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_stylesheet' }])])
		rt.call_function('add_filter', [rt.new_string('pre_option_current_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'current_theme' }])])
		rt.call_function('add_filter', [rt.new_string('pre_option_stylesheet'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_stylesheet' }])])
		rt.call_function('add_filter', [rt.new_string('pre_option_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_template' }])])
		rt.call_function('add_filter', [rt.new_string('pre_option_stylesheet_root'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_stylesheet_root' }])])
		rt.call_function('add_filter', [rt.new_string('pre_option_template_root'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_template_root' }])])
	}
	rt.call_function('do_action', [rt.new_string('start_previewing_theme'), rt.new_object('WP_Customize_Manager', []string{}, &this)])
}

fn (mut this Class_WP_Customize_Manager) stop_previewing_theme() {
	if !(this.is_preview()) {
		return
	}
	this.previewing = false
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_theme_active())))) {
		rt.call_function('remove_filter', [rt.new_string('template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_template' }])])
		rt.call_function('remove_filter', [rt.new_string('stylesheet'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_stylesheet' }])])
		rt.call_function('remove_filter', [rt.new_string('pre_option_current_theme'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'current_theme' }])])
		rt.call_function('remove_filter', [rt.new_string('pre_option_stylesheet'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_stylesheet' }])])
		rt.call_function('remove_filter', [rt.new_string('pre_option_template'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_template' }])])
		rt.call_function('remove_filter', [rt.new_string('pre_option_stylesheet_root'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_stylesheet_root' }])])
		rt.call_function('remove_filter', [rt.new_string('pre_option_template_root'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'get_template_root' }])])
	}
	rt.call_function('do_action', [rt.new_string('stop_previewing_theme'), rt.new_object('WP_Customize_Manager', []string{}, &this)])
}

fn (mut this Class_WP_Customize_Manager) settings_previewed() rt.PhpVal {
	return this.settings_previewed
}

fn (mut this Class_WP_Customize_Manager) autosaved() rt.PhpVal {
	return this.autosaved
}

fn (mut this Class_WP_Customize_Manager) branching() rt.PhpVal {
	this.branching = rt.call_function('apply_filters', [rt.new_string('customize_changeset_branching'), this.branching, rt.new_object('WP_Customize_Manager', []string{}, &this)])
	return this.branching
}

fn (mut this Class_WP_Customize_Manager) changeset_uuid() rt.PhpVal {
	if !rt.is_true(this._changeset_uuid) {
		this.establish_loaded_changeset()
	}
	return this._changeset_uuid
}

fn (mut this Class_WP_Customize_Manager) theme() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.theme)))) {
		this.theme = rt.call_function('wp_get_theme', []rt.PhpVal{})
	}
	return this.theme
}

fn (mut this Class_WP_Customize_Manager) settings() rt.PhpVal {
	return this.settings
}

fn (mut this Class_WP_Customize_Manager) controls() rt.PhpVal {
	return this.controls
}

fn (mut this Class_WP_Customize_Manager) containers() rt.PhpVal {
	return this.containers
}

fn (mut this Class_WP_Customize_Manager) sections() rt.PhpVal {
	return this.sections
}

fn (mut this Class_WP_Customize_Manager) panels() rt.PhpVal {
	return this.panels
}

fn (mut this Class_WP_Customize_Manager) is_theme_active() rt.PhpVal {
	return rt.identical(this.get_stylesheet(), this.original_stylesheet)
}

fn (mut this Class_WP_Customize_Manager) wp_loaded() {
	this.register_panel_type(rt.new_string('WP_Customize_Panel'))
	this.register_panel_type(rt.new_string('WP_Customize_Themes_Panel'))
	this.register_section_type(rt.new_string('WP_Customize_Section'))
	this.register_section_type(rt.new_string('WP_Customize_Sidebar_Section'))
	this.register_section_type(rt.new_string('WP_Customize_Themes_Section'))
	this.register_control_type(rt.new_string('WP_Customize_Color_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Media_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Upload_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Image_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Background_Image_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Background_Position_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Cropped_Image_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Site_Icon_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Theme_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Code_Editor_Control'))
	this.register_control_type(rt.new_string('WP_Customize_Date_Time_Control'))
	rt.call_function('do_action', [rt.new_string('customize_register'), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	if rt.is_true(this.settings_previewed()) {
		mut iter_2 := this.settings.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_setting := item_2.val
			rt.call_method(var_setting, 'preview', []rt.PhpVal{})
		}
	}
	if this.is_preview() && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		this.customize_preview_init()
	}
}

fn (mut this Class_WP_Customize_Manager) wp_redirect_status(var_status rt.PhpVal) i64 {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('4.7.0')])
	if this.is_preview() && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		return 200
	}
	return (var_status).to_i64()
}

fn (mut this Class_WP_Customize_Manager) find_changeset_post_id(var_uuid rt.PhpVal) rt.PhpVal {
	mut var_cache_group := rt.new_string('customize_changeset_post')
	mut var_changeset_post_id := rt.call_function('wp_cache_get', [var_uuid.clone(), var_cache_group.clone()])
	if rt.is_true(var_changeset_post_id) && rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.call_function('get_post_type', [var_changeset_post_id.clone()]))) {
		return var_changeset_post_id.clone()
	}
	mut var_changeset_post_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: 'customize_changeset' }, rt.ArrayItem{ key: 'post_status', val: rt.call_function('get_post_stati', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'name', val: var_uuid }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'no_found_rows', val: true }, rt.ArrayItem{ key: 'cache_results', val: true }, rt.ArrayItem{ key: 'update_post_meta_cache', val: false }, rt.ArrayItem{ key: 'update_post_term_cache', val: false }, rt.ArrayItem{ key: 'lazy_load_term_meta', val: false }]))
	if !(!rt.is_true(rt.get_property(var_changeset_post_query, 'posts'))) {
		var_changeset_post_id = rt.get_property(rt.get_property(var_changeset_post_query, 'posts').array_get(rt.new_int(0)), 'ID')
		rt.call_function('wp_cache_set', [var_uuid.clone(), var_changeset_post_id.clone(), var_cache_group.clone()])
		return var_changeset_post_id.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) get_changeset_posts(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	mut var_default_args := { 'exclude_restore_dismissed': rt.new_bool(true), 'posts_per_page': -1, 'post_type': rt.new_string('customize_changeset'), 'post_status': rt.new_string('auto-draft'), 'order': rt.new_string('DESC'), 'orderby': rt.new_string('date'), 'no_found_rows': rt.new_bool(true), 'cache_results': rt.new_bool(true), 'update_post_meta_cache': rt.new_bool(false), 'update_post_term_cache': rt.new_bool(false), 'lazy_load_term_meta': rt.new_bool(false) }
	if rt.is_true(rt.call_function('get_current_user_id', []rt.PhpVal{})) {
		var_default_args['author'] = rt.call_function('get_current_user_id', []rt.PhpVal{})
	}
	var_args_mutated = rt.call_function('array_merge', [rt.create_array_from_native_map(var_default_args), var_args_mutated.clone()])
	if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('exclude_restore_dismissed')))) {
		var_args_mutated.array_unset(rt.new_string('exclude_restore_dismissed'))
		var_args_mutated.array_set('meta_query', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'key', val: '_customize_restore_dismissed' }, rt.ArrayItem{ key: 'compare', val: 'NOT EXISTS' }]) }]))
	}
	return rt.call_function('get_posts', [var_args_mutated.clone()])
}

fn (mut this Class_WP_Customize_Manager) dismiss_user_auto_draft_changesets() rt.PhpVal {
	mut var_changeset_autodraft_posts := this.get_changeset_posts(rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'auto-draft' }, rt.ArrayItem{ key: 'exclude_restore_dismissed', val: true }, rt.ArrayItem{ key: 'posts_per_page', val: -1 }]))
	mut var_dismissed := rt.new_int(0)
	mut iter_3 := var_changeset_autodraft_posts.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_autosave_autodraft_post := item_3.val
		if rt.is_true(rt.identical(rt.get_property(var_autosave_autodraft_post, 'ID'), this.changeset_post_id())) {
			continue
		}
		if rt.is_true(rt.call_function('update_post_meta', [rt.get_property(var_autosave_autodraft_post, 'ID'), rt.new_string('_customize_restore_dismissed'), rt.new_bool(true)])) {
			rt.pre_inc(var_dismissed)
		}
	}
	return var_dismissed.clone()
}

fn (mut this Class_WP_Customize_Manager) changeset_post_id() rt.PhpVal {
	if !(!(this._changeset_post_id).is_null()) {
		mut var_post_id := this.find_changeset_post_id(this.changeset_uuid())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id)))) {
		var_post_id = rt.new_bool(false)
		}
		this._changeset_post_id = var_post_id.clone()
	}
	if rt.is_true(rt.identical(rt.new_bool(false), this._changeset_post_id)) {
		return rt.new_null()
	}
	return this._changeset_post_id
}

fn (mut this Class_WP_Customize_Manager) get_changeset_post_data(var_post_id rt.PhpVal) rt.PhpVal {
	mut var_post_id_mutated := var_post_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_id_mutated)))) {
		return create_wp_error(rt.new_string('empty_post_id'))
	}
	mut var_changeset_post := rt.call_function('get_post', [var_post_id_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_changeset_post)))) {
		return create_wp_error(rt.new_string('missing_post'))
	}
	if rt.is_true(rt.identical(rt.new_string('revision'), rt.get_property(var_changeset_post, 'post_type'))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.call_function('get_post_type', [rt.get_property(var_changeset_post, 'post_parent')]))))) {
			return create_wp_error(rt.new_string('wrong_post_type'))
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.get_property(var_changeset_post, 'post_type'))))) {
		return create_wp_error(rt.new_string('wrong_post_type'))
	}
	mut var_changeset_data := rt.call_function('json_decode', [rt.get_property(var_changeset_post, 'post_content'), rt.new_bool(true)])
	mut var_last_error := rt.call_function('json_last_error', []rt.PhpVal{})
	if rt.is_true(var_last_error) {
		return create_wp_error(rt.new_string('json_parse_error'), rt.new_string(''), var_last_error.clone())
	}
	if !(var_changeset_data.clone().is_array()) {
		return create_wp_error(rt.new_string('expected_array'))
	}
	return var_changeset_data.clone()
}

fn (mut this Class_WP_Customize_Manager) changeset_data() rt.PhpVal {
	if !(this._changeset_data).is_null() {
		return this._changeset_data
	}
	mut var_changeset_post_id := this.changeset_post_id()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_changeset_post_id)))) {
		this._changeset_data = rt.new_array()
	} else {
		if rt.is_true(this.autosaved()) && rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			mut var_autosave_post := rt.call_function('wp_get_post_autosave', [var_changeset_post_id.clone(), rt.call_function('get_current_user_id', []rt.PhpVal{})])
			if rt.is_true(var_autosave_post) {
				mut var_data := this.get_changeset_post_data(rt.get_property(var_autosave_post, 'ID'))
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_data.clone()]))))) {
					this._changeset_data = var_data.clone()
				}
			}
		}
		if !(!(this._changeset_data).is_null()) {
			var_data = this.get_changeset_post_data(var_changeset_post_id.clone())
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_data.clone()]))))) {
				this._changeset_data = var_data.clone()
			} else {
				this._changeset_data = rt.new_array()
			}
		}
	}
	return this._changeset_data
}

fn (mut this Class_WP_Customize_Manager) import_theme_starter_content(var_starter_content rt.PhpVal) {
	mut var_id_base := rt.new_null()
	mut var_instance := rt.new_null()
	mut var_starter_content_mutated := var_starter_content
	if !rt.is_true(var_starter_content_mutated) {
	var_starter_content_mutated = rt.call_function('get_theme_starter_content', []rt.PhpVal{})
	}
	mut var_changeset_data := rt.new_array()
	if rt.is_true(this.changeset_post_id()) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_function('get_post_status', [this.changeset_post_id()]))))) {
			return
		}
	var_changeset_data = this.get_changeset_post_data(this.changeset_post_id())
	}
	mut var_sidebars_widgets := if var_starter_content_mutated.array_isset(rt.new_string('widgets')) && !(!rt.is_true(this.widgets)) { var_starter_content_mutated.array_get(rt.new_string('widgets')) } else { rt.new_array() }
	mut var_attachments := if var_starter_content_mutated.array_isset(rt.new_string('attachments')) && !(!rt.is_true(this.nav_menus)) { var_starter_content_mutated.array_get(rt.new_string('attachments')) } else { rt.new_array() }
	mut var_posts := if var_starter_content_mutated.array_isset(rt.new_string('posts')) && !(!rt.is_true(this.nav_menus)) { var_starter_content_mutated.array_get(rt.new_string('posts')) } else { rt.new_array() }
	mut var_options := if !(var_starter_content_mutated.array_get(rt.new_string('options'))).is_null() { var_starter_content_mutated.array_get(rt.new_string('options')) } else { rt.new_array() }
	mut var_nav_menus := if var_starter_content_mutated.array_isset(rt.new_string('nav_menus')) && !(!rt.is_true(this.nav_menus)) { var_starter_content_mutated.array_get(rt.new_string('nav_menus')) } else { rt.new_array() }
	mut var_theme_mods := if !(var_starter_content_mutated.array_get(rt.new_string('theme_mods'))).is_null() { var_starter_content_mutated.array_get(rt.new_string('theme_mods')) } else { rt.new_array() }
	mut var_max_widget_numbers := rt.new_array()
	mut iter_4 := var_sidebars_widgets.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_widgets := item_4.val
		mut var_sidebar_id := item_4.key
		mut var_sidebar_widget_ids := rt.new_array()
		mut iter_5 := var_widgets.iterator()
		for {
			item_5 := iter_5.next() or { break }
			mut var_widget := item_5.val
			mut list_tmp_1 := var_widget
			var_id_base = (list_tmp_1).array_get(0)
			var_instance = (list_tmp_1).array_get(1)
			if !(var_max_widget_numbers.array_isset(var_id_base)) {
				mut var_settings := rt.call_function('get_option', [rt.new_string("widget_${var_id_base.to_string()}"), rt.new_array()])
				if rt.is_true(rt.new_bool(rt.instance_of(var_settings, 'ArrayObject'))) || rt.is_true(rt.new_bool(rt.instance_of(var_settings, 'ArrayIterator'))) {
				var_settings = rt.call_method(var_settings, 'getArrayCopy', []rt.PhpVal{})
				}
				var_settings.array_unset(rt.new_string('_multiwidget'))
				mut var_widget_numbers := rt.func_array_keys(var_settings.clone())
				if var_widget_numbers.clone().array_count() > 0 {
					var_widget_numbers.array_push(1)
					var_max_widget_numbers.array_set(var_id_base, rt.call_function('max', [var_widget_numbers.clone()]))
				} else {
					var_max_widget_numbers.array_set(var_id_base, 1)
				}
			}
			var_max_widget_numbers.array_get(var_id_base) = rt.add(var_max_widget_numbers.array_get(var_id_base), rt.new_int(1))
			mut var_widget_id := rt.call_function('sprintf', [rt.new_string('%s-%d'), var_id_base.clone(), var_max_widget_numbers.array_get(var_id_base)])
			mut var_setting_id := rt.call_function('sprintf', [rt.new_string('widget_%s[%d]'), var_id_base.clone(), var_max_widget_numbers.array_get(var_id_base)])
			mut var_setting_value := rt.call_method(this.widgets, 'sanitize_widget_js_instance', [var_instance.clone()])
			if !rt.is_true(var_changeset_data.array_get(var_setting_id)) || !(!rt.is_true(var_changeset_data.array_get(var_setting_id).array_get(rt.new_string('starter_content')))) {
				this.set_post_value(var_setting_id.clone(), var_setting_value.clone())
				this.pending_starter_content_settings_ids.array_push(var_setting_id.clone())
			}
			var_sidebar_widget_ids << var_widget_id.clone()
		}
		mut var_setting_id := rt.call_function('sprintf', [rt.new_string('sidebars_widgets[%s]'), var_sidebar_id.clone()])
		if !rt.is_true(var_changeset_data.array_get(var_setting_id)) || !(!rt.is_true(var_changeset_data.array_get(var_setting_id).array_get(rt.new_string('starter_content')))) {
			this.set_post_value(var_setting_id.clone(), var_sidebar_widget_ids.clone())
			this.pending_starter_content_settings_ids.array_push(var_setting_id.clone())
		}
	}
	mut var_starter_content_auto_draft_post_ids := rt.new_array()
	if !(!rt.is_true(var_changeset_data.array_get(rt.new_string('nav_menus_created_posts')).array_get(rt.new_string('value')))) {
	var_starter_content_auto_draft_post_ids = rt.call_function('array_merge', [var_starter_content_auto_draft_post_ids.clone(), var_changeset_data.array_get(rt.new_string('nav_menus_created_posts')).array_get(rt.new_string('value'))])
	}
	mut var_needed_posts := rt.new_array()
	var_attachments = this.prepare_starter_content_attachments(var_attachments.clone())
	mut iter_6 := var_attachments.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_attachment := item_6.val
		mut var_key := rt.new_string('attachment:' + (var_attachment.array_get(rt.new_string('post_name'))).str())
		var_needed_posts.array_set(var_key, true)
	}
	mut iter_7 := rt.func_array_keys(var_posts.clone()).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_post_symbol := item_7.val
		if !rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_name'))) && !rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_title'))) {
			var_posts.array_unset(var_post_symbol)
			continue
		}
		if !rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_name'))) {
			var_posts.array_get_mut(var_post_symbol).array_set('post_name', rt.call_function('sanitize_title', [var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_title'))]))
		}
		if !rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_type'))) {
			var_posts.array_get_mut(var_post_symbol).array_set('post_type', 'post')
		}
		var_needed_posts.array_set((var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_type'))).str() + ':' + (var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_name'))).str(), true)
	}
	mut var_all_post_slugs := rt.call_function('array_merge', [rt.call_function('wp_list_pluck', [var_attachments.clone(), rt.new_string('post_name')]), rt.call_function('wp_list_pluck', [var_posts.clone(), rt.new_string('post_name')])])
	mut var_post_types := rt.call_function('array_filter', [rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'attachment' }]), rt.call_function('wp_list_pluck', [var_posts.clone(), rt.new_string('post_type')])])])
	mut var_existing_starter_content_posts := rt.new_array()
	if !(!rt.is_true(var_starter_content_auto_draft_post_ids)) {
		mut var_existing_posts_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post__in', val: var_starter_content_auto_draft_post_ids }, rt.ArrayItem{ key: 'post_status', val: 'auto-draft' }, rt.ArrayItem{ key: 'post_type', val: var_post_types }, rt.ArrayItem{ key: 'posts_per_page', val: -1 }]))
		mut iter_8 := rt.get_property(var_existing_posts_query, 'posts').iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_existing_post := item_8.val
			mut var_post_name := rt.get_property(var_existing_post, 'post_name')
			if !rt.is_true(var_post_name) {
			var_post_name = rt.call_function('get_post_meta', [rt.get_property(var_existing_post, 'ID'), rt.new_string('_customize_draft_post_name'), rt.new_bool(true)])
			}
			var_existing_starter_content_posts.array_set((rt.get_property(var_existing_post, 'post_type')).str() + ':' + (var_post_name).str(), var_existing_post.clone())
		}
	}
	if !(!rt.is_true(var_all_post_slugs)) {
		var_existing_posts_query = create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_name__in', val: var_all_post_slugs }, rt.ArrayItem{ key: 'post_status', val: rt.call_function('array_diff', [rt.call_function('get_post_stati', []rt.PhpVal{}), rt.create_array([rt.ArrayItem{ key: none, val: 'auto-draft' }])]) }, rt.ArrayItem{ key: 'post_type', val: 'any' }, rt.ArrayItem{ key: 'posts_per_page', val: -1 }]))
		mut iter_9 := rt.get_property(var_existing_posts_query, 'posts').iterator()
		for {
			item_9 := iter_9.next() or { break }
			mut var_existing_post := item_9.val
			mut var_key := rt.new_string((rt.get_property(var_existing_post, 'post_type')).str() + ':' + (rt.get_property(var_existing_post, 'post_name')).str())
			if var_needed_posts.array_isset(var_key) && !(var_existing_starter_content_posts.array_isset(var_key)) {
				var_existing_starter_content_posts.array_set(var_key, var_existing_post.clone())
			}
		}
	}
	if !(!rt.is_true(var_attachments)) {
		mut var_attachment_ids := rt.new_array()
		mut iter_10 := var_attachments.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_attachment := item_10.val
			mut var_symbol := item_10.key
			mut var_file_array := { 'name': var_attachment.array_get(rt.new_string('file_name')) }
			mut var_file_path := var_attachment.array_get(rt.new_string('file_path'))
			mut var_attachment_id := rt.new_null()
			mut var_attached_file := rt.new_null()
			if var_existing_starter_content_posts.array_isset('attachment:' + (var_attachment.array_get(rt.new_string('post_name'))).str()) {
				mut var_attachment_post := var_existing_starter_content_posts.array_get(rt.new_string('attachment:' + (var_attachment.array_get(rt.new_string('post_name'))).str()))
				var_attachment_id = rt.get_property(var_attachment_post, 'ID')
				var_attached_file = rt.call_function('get_attached_file', [var_attachment_id.clone()])
				if !rt.is_true(var_attached_file) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_attached_file.clone()]))))) {
				var_attachment_id = rt.new_null()
				var_attached_file = rt.new_null()
				} else if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.get_stylesheet(), rt.call_function('get_post_meta', [rt.get_property(var_attachment_post, 'ID'), rt.new_string('_starter_content_theme'), rt.new_bool(true)]))))) {
					mut var_metadata := rt.call_function('wp_generate_attachment_metadata', [rt.get_property(var_attachment_post, 'ID'), var_attached_file.clone()])
					rt.call_function('wp_update_attachment_metadata', [var_attachment_id.clone(), var_metadata.clone()])
					rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_starter_content_theme'), this.get_stylesheet()])
				}
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(var_attachment_id)))) {
				mut var_temp_file_name := rt.call_function('wp_tempnam', [rt.call_function('wp_basename', [var_file_path.clone()])])
				if rt.is_true(var_temp_file_name) && rt.is_true(rt.call_function('copy', [var_file_path.clone(), var_temp_file_name.clone()])) {
					var_file_array['tmp_name'] = var_temp_file_name.clone()
				}
				if !rt.is_true(var_file_array['tmp_name']) {
					continue
				}
				mut var_attachment_post_data := rt.call_function('array_merge', [rt.call_function('wp_array_slice_assoc', [var_attachment.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'post_title' }, rt.ArrayItem{ key: none, val: 'post_content' }, rt.ArrayItem{ key: none, val: 'post_excerpt' }])]), rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'auto-draft' }])])
				var_attachment_id = rt.call_function('media_handle_sideload', [rt.create_array_from_native_map(var_file_array), rt.new_int(0), rt.new_null(), var_attachment_post_data.clone()])
				if rt.is_true(rt.call_function('is_wp_error', [var_attachment_id.clone()])) {
					continue
				}
				rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_starter_content_theme'), this.get_stylesheet()])
				rt.call_function('update_post_meta', [var_attachment_id.clone(), rt.new_string('_customize_draft_post_name'), var_attachment.array_get(rt.new_string('post_name'))])
			}
			var_attachment_ids.array_set(var_symbol, var_attachment_id.clone())
		}
	var_starter_content_auto_draft_post_ids = rt.call_function('array_merge', [var_starter_content_auto_draft_post_ids.clone(), rt.call_function('array_values', [var_attachment_ids.clone()])])
	}
	if !(!rt.is_true(var_posts)) {
		mut iter_11 := rt.func_array_keys(var_posts.clone()).iterator()
		for {
			item_11 := iter_11.next() or { break }
			mut var_post_symbol := item_11.val
			if !rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_type'))) || !rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_name'))) {
				continue
			}
			mut var_post_type := var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_type'))
			if !(!rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_name')))) {
			mut var_post_name := var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_name'))
			} else if !(!rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_title')))) {
			var_post_name = rt.call_function('sanitize_title', [var_posts.array_get(var_post_symbol).array_get(rt.new_string('post_title'))])
			} else {
				continue
			}
			if var_existing_starter_content_posts.array_isset((var_post_type).str() + ':' + (var_post_name).str()) {
				var_posts.array_get_mut(var_post_symbol).array_set('ID', rt.get_property(var_existing_starter_content_posts.array_get(rt.new_string((var_post_type).str() + ':' + (var_post_name).str())), 'ID'))
				continue
			}
			if !(!rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('thumbnail')))) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^{{(?P<symbol>.+)}}$/'), var_posts.array_get(var_post_symbol).array_get(rt.new_string('thumbnail')), var_matches.clone()])) && var_attachment_ids.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
				var_posts.array_get_mut(var_post_symbol).array_get_mut('meta_input').array_set('_thumbnail_id', var_attachment_ids.array_get(var_matches.array_get(rt.new_string('symbol'))))
			}
			if !(!rt.is_true(var_posts.array_get(var_post_symbol).array_get(rt.new_string('template')))) {
				var_posts.array_get_mut(var_post_symbol).array_get_mut('meta_input').array_set('_wp_page_template', var_posts.array_get(var_post_symbol).array_get(rt.new_string('template')))
			}
			mut var_r := rt.call_method(this.nav_menus, 'insert_auto_draft_post', [var_posts.array_get(var_post_symbol)])
			if rt.is_true(rt.new_bool(rt.instance_of(var_r, 'WP_Post'))) {
				var_posts.array_get_mut(var_post_symbol).array_set('ID', rt.get_property(var_r, 'ID'))
			}
		}
	var_starter_content_auto_draft_post_ids = rt.call_function('array_merge', [var_starter_content_auto_draft_post_ids.clone(), rt.call_function('wp_list_pluck', [var_posts.clone(), rt.new_string('ID')])])
	}
	if !(!rt.is_true(this.nav_menus)) && !(!rt.is_true(var_starter_content_auto_draft_post_ids)) {
		mut var_setting_id := rt.new_string('nav_menus_created_posts')
		this.set_post_value(var_setting_id.clone(), rt.call_function('array_unique', [rt.call_function('array_values', [var_starter_content_auto_draft_post_ids.clone()])]))
		this.pending_starter_content_settings_ids.array_push(var_setting_id.clone())
	}
	mut var_placeholder_id := rt.new_int(-1)
	mut var_reused_nav_menu_setting_ids := rt.new_array()
	mut iter_12 := var_nav_menus.iterator()
	for {
		item_12 := iter_12.next() or { break }
		mut var_nav_menu := item_12.val
		mut var_nav_menu_location := item_12.key
		mut var_nav_menu_term_id := rt.new_null()
		mut var_nav_menu_setting_id := rt.new_null()
		mut var_matches := rt.new_array()
		mut iter_13 := var_changeset_data.iterator()
		for {
			item_13 := iter_13.next() or { break }
			mut var_setting_params := item_13.val
			mut var_setting_id_shadow := item_13.key
			mut var_can_reuse := rt.new_bool(!(!rt.is_true(var_setting_params.array_get(rt.new_string('starter_content')))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_setting_id_shadow.clone(), rt.create_array_from_list(var_reused_nav_menu_setting_ids), rt.new_bool(true)]))))) && rt.is_true(rt.call_function('preg_match', [rt.new_string('#^nav_menu\\[(?P<nav_menu_id>-?\\d+)\\]$#'), var_setting_id_shadow.clone(), var_matches.clone()])))
			if rt.is_true(var_can_reuse) {
				var_nav_menu_term_id = rt.new_int((var_matches.array_get(rt.new_string('nav_menu_id'))).to_i64())
				var_nav_menu_setting_id = var_setting_id_shadow.clone()
				var_reused_nav_menu_setting_ids << var_setting_id_shadow.clone()
				break
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_nav_menu_term_id)))) {
			for var_changeset_data.array_isset(rt.call_function('sprintf', [rt.new_string('nav_menu[%d]'), var_placeholder_id.clone()])) {
				rt.pre_dec(var_placeholder_id)
			}
		var_nav_menu_term_id = var_placeholder_id.clone()
		var_nav_menu_setting_id = rt.call_function('sprintf', [rt.new_string('nav_menu[%d]'), var_placeholder_id.clone()])
		}
		this.set_post_value(var_nav_menu_setting_id.clone(), rt.create_array([rt.ArrayItem{ key: 'name', val: if !(var_nav_menu.array_get(rt.new_string('name'))).is_null() { var_nav_menu.array_get(rt.new_string('name')) } else { var_nav_menu_location } }]))
		this.pending_starter_content_settings_ids.array_push(var_nav_menu_setting_id.clone())
		mut var_position := rt.new_int(0)
		mut iter_14 := var_nav_menu.array_get(rt.new_string('items')).iterator()
		for {
			item_14 := iter_14.next() or { break }
			mut var_nav_menu_item := item_14.val
			mut var_nav_menu_item_setting_id := rt.call_function('sprintf', [rt.new_string('nav_menu_item[%d]'), rt.post_dec(var_placeholder_id)])
			if !(var_nav_menu_item.array_isset(rt.new_string('position'))) {
				var_nav_menu_item.array_set('position', rt.post_inc(var_position))
			}
			var_nav_menu_item.array_set('nav_menu_term_id', var_nav_menu_term_id.clone())
			if var_nav_menu_item.array_isset(rt.new_string('object_id')) {
				if rt.is_true(rt.identical(rt.new_string('post_type'), var_nav_menu_item.array_get(rt.new_string('type')))) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/^{{(?P<symbol>.+)}}$/'), var_nav_menu_item.array_get(rt.new_string('object_id')), var_matches.clone()])) && var_posts.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
					var_nav_menu_item.array_set('object_id', var_posts.array_get(var_matches.array_get(rt.new_string('symbol'))).array_get(rt.new_string('ID')))
					if !rt.is_true(var_nav_menu_item.array_get(rt.new_string('title'))) {
						mut var_original_object := rt.call_function('get_post', [var_nav_menu_item.array_get(rt.new_string('object_id'))])
						var_nav_menu_item.array_set('title', rt.get_property(var_original_object, 'post_title'))
					}
				} else {
					continue
				}
			} else {
				var_nav_menu_item.array_set('object_id', 0)
			}
			if !rt.is_true(var_changeset_data.array_get(var_nav_menu_item_setting_id)) || !(!rt.is_true(var_changeset_data.array_get(var_nav_menu_item_setting_id).array_get(rt.new_string('starter_content')))) {
				this.set_post_value(var_nav_menu_item_setting_id.clone(), var_nav_menu_item.clone())
				this.pending_starter_content_settings_ids.array_push(var_nav_menu_item_setting_id.clone())
			}
		}
		var_setting_id = rt.call_function('sprintf', [rt.new_string('nav_menu_locations[%s]'), var_nav_menu_location.clone()])
		if !rt.is_true(var_changeset_data.array_get(var_setting_id)) || !(!rt.is_true(var_changeset_data.array_get(var_setting_id).array_get(rt.new_string('starter_content')))) {
			this.set_post_value(var_setting_id.clone(), var_nav_menu_term_id.clone())
			this.pending_starter_content_settings_ids.array_push(var_setting_id.clone())
		}
	}
	mut iter_15 := var_options.iterator()
	for {
		item_15 := iter_15.next() or { break }
		mut var_value := item_15.val
		mut var_name := item_15.key
		var_value = rt.call_function('maybe_serialize', [var_value.clone()])
		if rt.is_true(rt.call_function('is_serialized', [var_value.clone()])) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/s:\\d+:"{{(?P<symbol>.+)}}"/'), var_value.clone(), var_matches.clone()])) {
				if var_posts.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
				mut var_symbol_match := var_posts.array_get(var_matches.array_get(rt.new_string('symbol'))).array_get(rt.new_string('ID'))
				} else if var_attachment_ids.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
				var_symbol_match = var_attachment_ids.array_get(var_matches.array_get(rt.new_string('symbol')))
				}
				if !(var_symbol_match).is_null() {
				var_value = rt.call_function('str_replace', [var_matches.array_get(rt.new_int(0)), rt.new_string("i:${var_symbol_match.to_string()}"), var_value.clone()])
				} else {
					continue
				}
			}
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^{{(?P<symbol>.+)}}$/'), var_value.clone(), var_matches.clone()])) {
			if var_posts.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
			var_value = var_posts.array_get(var_matches.array_get(rt.new_string('symbol'))).array_get(rt.new_string('ID'))
			} else if var_attachment_ids.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
			var_value = var_attachment_ids.array_get(var_matches.array_get(rt.new_string('symbol')))
			} else {
				continue
			}
		}
		var_value = rt.call_function('maybe_unserialize', [var_value.clone()])
		if !rt.is_true(var_changeset_data.array_get(var_name)) || !(!rt.is_true(var_changeset_data.array_get(var_name).array_get(rt.new_string('starter_content')))) {
			this.set_post_value(var_name.clone(), var_value.clone())
			this.pending_starter_content_settings_ids.array_push(var_name.clone())
		}
	}
	mut iter_16 := var_theme_mods.iterator()
	for {
		item_16 := iter_16.next() or { break }
		mut var_value := item_16.val
		mut var_name := item_16.key
		var_value = rt.call_function('maybe_serialize', [var_value.clone()])
		if rt.is_true(rt.call_function('is_serialized', [var_value.clone()])) {
			if rt.is_true(rt.call_function('preg_match', [rt.new_string('/s:\\d+:"{{(?P<symbol>.+)}}"/'), var_value.clone(), var_matches.clone()])) {
				if var_posts.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
				mut var_symbol_match := var_posts.array_get(var_matches.array_get(rt.new_string('symbol'))).array_get(rt.new_string('ID'))
				} else if var_attachment_ids.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
				var_symbol_match = var_attachment_ids.array_get(var_matches.array_get(rt.new_string('symbol')))
				}
				if !(var_symbol_match).is_null() {
				var_value = rt.call_function('str_replace', [var_matches.array_get(rt.new_int(0)), rt.new_string("i:${var_symbol_match.to_string()}"), var_value.clone()])
				} else {
					continue
				}
			}
		} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^{{(?P<symbol>.+)}}$/'), var_value.clone(), var_matches.clone()])) {
			if var_posts.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
			var_value = var_posts.array_get(var_matches.array_get(rt.new_string('symbol'))).array_get(rt.new_string('ID'))
			} else if var_attachment_ids.array_isset(var_matches.array_get(rt.new_string('symbol'))) {
			var_value = var_attachment_ids.array_get(var_matches.array_get(rt.new_string('symbol')))
			} else {
				continue
			}
		}
		var_value = rt.call_function('maybe_unserialize', [var_value.clone()])
		if rt.is_true(rt.identical(rt.new_string('header_image'), var_name)) {
			var_name = rt.new_string('header_image_data')
			mut var_metadata := rt.call_function('wp_get_attachment_metadata', [var_value.clone()])
			if !rt.is_true(var_metadata) {
				continue
			}
		var_value = rt.create_array([rt.ArrayItem{ key: 'attachment_id', val: var_value }, rt.ArrayItem{ key: 'url', val: rt.call_function('wp_get_attachment_url', [var_value.clone()]) }, rt.ArrayItem{ key: 'height', val: var_metadata.array_get(rt.new_string('height')) }, rt.ArrayItem{ key: 'width', val: var_metadata.array_get(rt.new_string('width')) }])
		} else if rt.is_true(rt.identical(rt.new_string('background_image'), var_name)) {
		var_value = rt.call_function('wp_get_attachment_url', [var_value.clone()])
		}
		if !rt.is_true(var_changeset_data.array_get(var_name)) || !(!rt.is_true(var_changeset_data.array_get(var_name).array_get(rt.new_string('starter_content')))) {
			this.set_post_value(var_name.clone(), var_value.clone())
			this.pending_starter_content_settings_ids.array_push(var_name.clone())
		}
	}
	if !(!rt.is_true(this.pending_starter_content_settings_ids)) {
		if rt.is_true(rt.call_function('did_action', [rt.new_string('customize_register')])) {
			this._save_starter_content_changeset()
		} else {
			rt.call_function('add_action', [rt.new_string('customize_register'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_save_starter_content_changeset' }]), rt.new_int(1000)])
		}
	}
}

fn (mut this Class_WP_Customize_Manager) prepare_starter_content_attachments(var_attachments rt.PhpVal) rt.PhpVal {
	mut var_attachments_mutated := var_attachments
	mut var_prepared_attachments := rt.new_array()
	if !rt.is_true(var_attachments_mutated) {
		return var_prepared_attachments.clone()
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/file.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/media.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/image.php', '4')
	mut iter_17 := var_attachments_mutated.iterator()
	for {
		item_17 := iter_17.next() or { break }
		mut var_attachment := item_17.val
		mut var_symbol := item_17.key
		if !rt.is_true(var_attachment.array_get(rt.new_string('file'))) || rt.is_true(rt.call_function('preg_match', [rt.new_string('#^https?://$#'), var_attachment.array_get(rt.new_string('file'))])) {
			continue
		}
		mut var_file_path := rt.new_null()
		if rt.is_true(rt.call_function('file_exists', [var_attachment.array_get(rt.new_string('file'))])) {
		var_file_path = var_attachment.array_get(rt.new_string('file'))
		} else if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) && rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (var_attachment.array_get(rt.new_string('file'))).str())])) {
		var_file_path = rt.new_string((rt.call_function('get_stylesheet_directory', []rt.PhpVal{})).str() + '/' + (var_attachment.array_get(rt.new_string('file'))).str())
		} else if rt.is_true(rt.call_function('file_exists', [rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' + (var_attachment.array_get(rt.new_string('file'))).str())])) {
		var_file_path = rt.new_string((rt.call_function('get_template_directory', []rt.PhpVal{})).str() + '/' + (var_attachment.array_get(rt.new_string('file'))).str())
		} else {
			continue
		}
		mut var_file_name := rt.call_function('wp_basename', [var_attachment.array_get(rt.new_string('file'))])
		mut var_checked_filetype := rt.call_function('wp_check_filetype', [var_file_name.clone()])
		if !rt.is_true(var_checked_filetype.array_get(rt.new_string('type'))) {
			continue
		}
		if !rt.is_true(var_attachment.array_get(rt.new_string('post_name'))) {
			if !(!rt.is_true(var_attachment.array_get(rt.new_string('post_title')))) {
				var_attachment.array_set('post_name', rt.call_function('sanitize_title', [var_attachment.array_get(rt.new_string('post_title'))]))
			} else {
				var_attachment.array_set('post_name', rt.call_function('sanitize_title', [rt.call_function('preg_replace', [rt.new_string('/\\.\\w+$/'), rt.new_string(''), var_file_name.clone()])]))
			}
		}
		var_attachment.array_set('file_name', var_file_name.clone())
		var_attachment.array_set('file_path', var_file_path.clone())
		var_prepared_attachments.array_set(var_symbol, var_attachment.clone())
	}
	return var_prepared_attachments.clone()
}

fn (mut this Class_WP_Customize_Manager) _save_starter_content_changeset() {
	if !rt.is_true(this.pending_starter_content_settings_ids) {
		return
	}
	this.save_changeset_post(rt.create_array([rt.ArrayItem{ key: 'data', val: rt.call_function('array_fill_keys', [this.pending_starter_content_settings_ids, rt.create_array([rt.ArrayItem{ key: 'starter_content', val: true }])]) }, rt.ArrayItem{ key: 'starter_content', val: true }]))
	this.saved_starter_content_changeset = true
	this.pending_starter_content_settings_ids = rt.new_array()
}

fn (mut this Class_WP_Customize_Manager) unsanitized_post_values(var_args rt.PhpVal) rt.PhpVal {
	mut var_matches := rt.new_null()
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'exclude_changeset', val: false }, rt.ArrayItem{ key: 'exclude_post_data', val: !(rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')]))) }]), var_args_mutated.clone()])
	mut var_values := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_theme_active())))) {
		mut var_stashed_theme_mods := rt.call_function('get_option', [rt.new_string('customize_stashed_theme_mods')])
		mut var_stylesheet := this.get_stylesheet()
		if var_stashed_theme_mods.array_isset(var_stylesheet) {
		var_values = rt.call_function('array_merge', [var_values.clone(), rt.call_function('wp_list_pluck', [var_stashed_theme_mods.array_get(var_stylesheet), rt.new_string('value')])])
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('exclude_changeset')))))) {
		mut iter_18 := this.changeset_data().iterator()
		for {
			item_18 := iter_18.next() or { break }
			mut var_setting_params := item_18.val
			mut var_setting_id := item_18.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_setting_params.clone().array_isset(rt.new_string('value'))))))) {
				continue
			}
			if var_setting_params.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('theme_mod'), var_setting_params.array_get(rt.new_string('type')))) {
				mut var_namespace_pattern := rt.new_string('/^(?P<stylesheet>.+?)::(?P<setting_id>.+)$/')
				if rt.is_true(rt.call_function('preg_match', [var_namespace_pattern.clone(), var_setting_id.clone(), var_matches.clone()])) && rt.is_true(rt.identical(this.get_stylesheet(), var_matches.array_get(rt.new_string('stylesheet')))) {
					var_values.array_set(var_matches.array_get(rt.new_string('setting_id')), var_setting_params.array_get(rt.new_string('value')))
				}
			} else {
				var_values.array_set(var_setting_id, var_setting_params.array_get(rt.new_string('value')))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('exclude_post_data')))))) {
		if !(!(this._post_values).is_null()) {
			if rt.get_superglobal('_POST').array_isset(rt.new_string('customized')) {
			mut var_post_values := rt.call_function('json_decode', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('customized'))]), rt.new_bool(true)])
			} else {
			var_post_values = rt.new_array()
			}
			if rt.is_true(rt.new_bool(var_post_values.clone().is_array())) {
				this._post_values = var_post_values.clone()
			} else {
				this._post_values = rt.new_array()
			}
		}
	var_values = rt.call_function('array_merge', [var_values.clone(), this._post_values])
	}
	return var_values.clone()
}

fn (mut this Class_WP_Customize_Manager) post_value(var_setting rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_setting_mutated := var_setting
	mut var_post_values := this.unsanitized_post_values(rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_post_values.clone().array_isset(rt.get_property(var_setting_mutated, 'id'))))))) {
		return var_default_value.clone()
	}
	mut var_value := var_post_values.array_get(rt.get_property(var_setting_mutated, 'id'))
	mut var_valid := rt.call_method(var_setting_mutated, 'validate', [var_value.clone()])
	if rt.is_true(rt.call_function('is_wp_error', [var_valid.clone()])) {
		return var_default_value.clone()
	}
	var_value = rt.call_method(var_setting_mutated, 'sanitize', [var_value.clone()])
	if var_value.clone().is_null() || rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
		return var_default_value.clone()
	}
	return var_value.clone()
}

fn (mut this Class_WP_Customize_Manager) set_post_value(var_setting_id rt.PhpVal, var_value rt.PhpVal) {
	mut var_setting_id_mutated := var_setting_id
	mut var_value_mutated := var_value
	this.unsanitized_post_values(rt.new_null())
	this._post_values.array_set(var_setting_id_mutated, var_value_mutated.clone())
	rt.call_function('do_action', [rt.new_string("customize_post_value_set_${var_setting_id.to_string()}"), var_value_mutated.clone(), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	rt.call_function('do_action', [rt.new_string('customize_post_value_set'), var_setting_id_mutated.clone(), var_value_mutated.clone(), rt.new_object('WP_Customize_Manager', []string{}, &this)])
}

fn (mut this Class_WP_Customize_Manager) customize_preview_init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
		rt.call_function('nocache_headers', []rt.PhpVal{})
		rt.call_function('header', [rt.new_string('X-Robots: noindex, nofollow, noarchive')])
		rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex, nofollow, noarchive')])
	}
	rt.call_function('add_filter', [rt.new_string('wp_robots'), rt.new_string('wp_robots_no_robots')])
	rt.call_function('add_filter', [rt.new_string('wp_headers'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'filter_iframe_security_headers' }])])
	if rt.is_true(this.messenger_channel) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')]))))) {
		this.wp_die(rt.new_int(-1), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Unauthorized. You may remove the %s param to preview as frontend.')]), rt.new_string('<code>customize_messenger_channel<code>')]))
		return
	}
	this.prepare_controls()
	rt.call_function('add_filter', [rt.new_string('wp_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'add_state_query_params' }])])
	rt.call_function('wp_enqueue_script', [rt.new_string('customize-preview')])
	rt.call_function('wp_enqueue_style', [rt.new_string('customize-preview')])
	rt.call_function('add_action', [rt.new_string('wp_head'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_preview_loading_style' }])])
	rt.call_function('add_action', [rt.new_string('wp_head'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'remove_frameless_preview_messenger_channel' }])])
	rt.call_function('add_action', [rt.new_string('wp_footer'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'customize_preview_settings' }]), rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('get_edit_post_link'), rt.new_string('__return_empty_string')])
	rt.call_function('do_action', [rt.new_string('customize_preview_init'), rt.new_object('WP_Customize_Manager', []string{}, &this)])
}

fn (mut this Class_WP_Customize_Manager) filter_iframe_security_headers(var_headers rt.PhpVal) rt.PhpVal {
	mut var_headers_mutated := var_headers
	var_headers_mutated.array_set('X-Frame-Options', 'SAMEORIGIN')
	var_headers_mutated.array_set('Content-Security-Policy', 'frame-ancestors \'self\'')
	return var_headers_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) add_state_query_params(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_parsed_original_url := rt.call_function('wp_parse_url', [var_url_mutated.clone()])
	mut var_is_allowed := rt.new_bool(false)
	mut iter_19 := this.get_allowed_urls().iterator()
	for {
		item_19 := iter_19.next() or { break }
		mut var_allowed_url := item_19.val
		mut var_parsed_allowed_url := rt.call_function('wp_parse_url', [var_allowed_url.clone()])
		var_is_allowed = rt.new_bool(rt.is_true(rt.identical(var_parsed_allowed_url.array_get(rt.new_string('scheme')), var_parsed_original_url.array_get(rt.new_string('scheme')))) && rt.is_true(rt.identical(var_parsed_allowed_url.array_get(rt.new_string('host')), var_parsed_original_url.array_get(rt.new_string('host')))) && rt.is_true(rt.call_function('str_starts_with', [var_parsed_original_url.array_get(rt.new_string('path')), var_parsed_allowed_url.array_get(rt.new_string('path'))])))
		if rt.is_true(var_is_allowed) {
			break
		}
	}
	if rt.is_true(var_is_allowed) {
		mut var_query_params := { 'customize_changeset_uuid': this.changeset_uuid() }
		if rt.is_true(rt.new_bool(!(rt.is_true(this.is_theme_active())))) {
			var_query_params['customize_theme'] = this.get_stylesheet()
		}
		if rt.is_true(this.messenger_channel) {
			var_query_params['customize_messenger_channel'] = this.messenger_channel
		}
	var_url_mutated = rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_query_params), var_url_mutated.clone()])
	}
	return var_url_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) customize_preview_override_404_status() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0')])
}

fn (mut this Class_WP_Customize_Manager) customize_preview_base() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0')])
}

fn (mut this Class_WP_Customize_Manager) customize_preview_html5() {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('4.7.0')])
}

fn (mut this Class_WP_Customize_Manager) customize_preview_loading_style() {
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Manager) remove_frameless_preview_messenger_channel() {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.messenger_channel)))) {
		return
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_inline_script_tag', [rt.new_string((rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])).str() + '\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@METHOD)])).str())])
}

fn (mut this Class_WP_Customize_Manager) customize_preview_settings() {
	mut var_post_values := this.unsanitized_post_values(rt.create_array([rt.ArrayItem{ key: 'exclude_changeset', val: true }]))
	mut var_setting_validities := this.validate_setting_values(var_post_values.clone(), rt.new_null())
	mut var_exported_setting_validities := rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'prepare_setting_validity_for_js' }]), var_setting_validities.clone()])
	mut var_self_url := if !rt.is_true(rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))) { rt.call_function('home_url', [rt.new_string('/')]) } else { rt.call_function('sanitize_url', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get(rt.new_string('REQUEST_URI'))])]) }
	mut var_state_query_params := ['customize_theme', 'customize_changeset_uuid', 'customize_messenger_channel']
	var_self_url = rt.call_function('remove_query_arg', [rt.create_array_from_list(var_state_query_params), var_self_url.clone()])
	mut var_allowed_urls := this.get_allowed_urls()
	mut var_allowed_hosts := rt.new_array()
	mut iter_20 := var_allowed_urls.iterator()
	for {
		item_20 := iter_20.next() or { break }
		mut var_allowed_url := item_20.val
		mut var_parsed := rt.call_function('wp_parse_url', [var_allowed_url.clone()])
		if !rt.is_true(var_parsed.array_get(rt.new_string('host'))) {
			continue
		}
		mut var_host := var_parsed.array_get(rt.new_string('host'))
		if !(!rt.is_true(var_parsed.array_get(rt.new_string('port')))) {
			var_host = rt.concat(var_host, rt.new_string(':' + (var_parsed.array_get(rt.new_string('port'))).str()))
		}
		var_allowed_hosts << var_host.clone()
	}
	mut var_switched_locale := rt.call_function('switch_to_user_locale', [rt.call_function('get_current_user_id', []rt.PhpVal{})])
	mut var_l10n := { 'shiftClickToEdit': rt.call_function('__', [rt.new_string('Shift-click to edit this element.')]), 'linkUnpreviewable': rt.call_function('__', [rt.new_string('This link is not live-previewable.')]), 'formUnpreviewable': rt.call_function('__', [rt.new_string('This form is not live-previewable.')]) }
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'changeset', val: rt.create_array([rt.ArrayItem{ key: 'uuid', val: this.changeset_uuid() }, rt.ArrayItem{ key: 'autosaved', val: this.autosaved() }]) }, rt.ArrayItem{ key: 'timeouts', val: rt.create_array([rt.ArrayItem{ key: 'selectiveRefresh', val: 250 }, rt.ArrayItem{ key: 'keepAliveSend', val: 1000 }]) }, rt.ArrayItem{ key: 'theme', val: rt.create_array([rt.ArrayItem{ key: 'stylesheet', val: this.get_stylesheet() }, rt.ArrayItem{ key: 'active', val: this.is_theme_active() }, rt.ArrayItem{ key: 'isBlockTheme', val: rt.call_function('wp_is_block_theme', []rt.PhpVal{}) }]) }, rt.ArrayItem{ key: 'url', val: rt.create_array([rt.ArrayItem{ key: 'self', val: var_self_url }, rt.ArrayItem{ key: 'allowed', val: rt.call_function('array_map', [rt.new_string('sanitize_url'), this.get_allowed_urls()]) }, rt.ArrayItem{ key: 'allowedHosts', val: rt.call_function('array_unique', [rt.create_array_from_list(var_allowed_hosts)]) }, rt.ArrayItem{ key: 'isCrossDomain', val: this.is_cross_domain() }]) }, rt.ArrayItem{ key: 'channel', val: this.messenger_channel }, rt.ArrayItem{ key: 'activePanels', val: rt.new_array() }, rt.ArrayItem{ key: 'activeSections', val: rt.new_array() }, rt.ArrayItem{ key: 'activeControls', val: rt.new_array() }, rt.ArrayItem{ key: 'settingValidities', val: var_exported_setting_validities }, rt.ArrayItem{ key: 'nonce', val: if rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) { this.get_nonces() } else { rt.new_array() } }, rt.ArrayItem{ key: 'l10n', val: var_l10n }, rt.ArrayItem{ key: '_dirty', val: rt.func_array_keys(var_post_values.clone()) }])
	mut iter_21 := this.panels.iterator()
	for {
		item_21 := iter_21.next() or { break }
		mut var_panel := item_21.val
		mut var_panel_id := item_21.key
		if rt.is_true(rt.call_method(var_panel, 'check_capabilities', []rt.PhpVal{})) {
			var_settings.array_get_mut('activePanels').array_set(var_panel_id, rt.call_method(var_panel, 'active', []rt.PhpVal{}))
			mut iter_22 := rt.get_property(var_panel, 'sections').iterator()
			for {
				item_22 := iter_22.next() or { break }
				mut var_section := item_22.val
				mut var_section_id := item_22.key
				if rt.is_true(rt.call_method(var_section, 'check_capabilities', []rt.PhpVal{})) {
					var_settings.array_get_mut('activeSections').array_set(var_section_id, rt.call_method(var_section, 'active', []rt.PhpVal{}))
				}
			}
		}
	}
	mut iter_23 := this.sections.iterator()
	for {
		item_23 := iter_23.next() or { break }
		mut var_section := item_23.val
		mut var_id := item_23.key
		if rt.is_true(rt.call_method(var_section, 'check_capabilities', []rt.PhpVal{})) {
			var_settings.array_get_mut('activeSections').array_set(var_id, rt.call_method(var_section, 'active', []rt.PhpVal{}))
		}
	}
	mut iter_24 := this.controls.iterator()
	for {
		item_24 := iter_24.next() or { break }
		mut var_control := item_24.val
		mut var_id := item_24.key
		if rt.is_true(rt.call_method(var_control, 'check_capabilities', []rt.PhpVal{})) {
			var_settings.array_get_mut('activeControls').array_set(var_id, rt.call_method(var_control, 'active', []rt.PhpVal{}))
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [var_settings.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
	// unsupported statement: Stmt_InlineHTML
	mut iter_25 := this.settings.iterator()
	for {
		item_25 := iter_25.next() or { break }
		mut var_setting := item_25.val
		mut var_id := item_25.key
		if rt.is_true(rt.call_method(var_setting, 'check_capabilities', []rt.PhpVal{})) {
			rt.call_function('printf', [rt.new_string('v[%s] = %s;\n'), rt.call_function('wp_json_encode', [var_id.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [rt.call_method(var_setting, 'js_value', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_inline_script_tag', [rt.new_string((rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])).str() + '\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@METHOD)])).str())])
}

fn (mut this Class_WP_Customize_Manager) customize_preview_signature() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0')])
}

fn (mut this Class_WP_Customize_Manager) remove_preview_signature(var_callback rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0')])
	return var_callback.clone()
}

fn (mut this Class_WP_Customize_Manager) is_preview() bool {
	return this.previewing
}

fn (mut this Class_WP_Customize_Manager) get_template() rt.PhpVal {
	return rt.call_method(this.theme(), 'get_template', []rt.PhpVal{})
}

fn (mut this Class_WP_Customize_Manager) get_stylesheet() rt.PhpVal {
	return rt.call_method(this.theme(), 'get_stylesheet', []rt.PhpVal{})
}

fn (mut this Class_WP_Customize_Manager) get_template_root() rt.PhpVal {
	return rt.call_function('get_raw_theme_root', [this.get_template(), rt.new_bool(true)])
}

fn (mut this Class_WP_Customize_Manager) get_stylesheet_root() rt.PhpVal {
	return rt.call_function('get_raw_theme_root', [this.get_stylesheet(), rt.new_bool(true)])
}

fn (mut this Class_WP_Customize_Manager) current_theme(var_current_theme rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.theme(), 'display', [rt.new_string('Name')])
}

fn (mut this Class_WP_Customize_Manager) validate_setting_values(var_setting_values rt.PhpVal, var_options rt.PhpVal) rt.PhpVal {
	mut var_options_mutated := var_options
	var_options_mutated = rt.call_function('wp_parse_args', [var_options_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'validate_capability', val: false }, rt.ArrayItem{ key: 'validate_existence', val: false }])])
	mut var_validities := rt.new_array()
	mut iter_26 := var_setting_values.iterator()
	for {
		item_26 := iter_26.next() or { break }
		mut var_unsanitized_value := item_26.val
		mut var_setting_id := item_26.key
		mut var_setting := this.get_setting(var_setting_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_setting)))) {
			if rt.is_true(var_options_mutated.array_get(rt.new_string('validate_existence'))) {
				var_validities.array_set(var_setting_id, create_wp_error(rt.new_string('unrecognized'), rt.call_function('__', [rt.new_string('Setting does not exist or is unrecognized.')])))
			}
			continue
		}
		if rt.is_true(var_options_mutated.array_get(rt.new_string('validate_capability'))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(var_setting, 'capability')]))))) {
		mut var_validity := create_wp_error(rt.new_string('unauthorized'), rt.call_function('__', [rt.new_string('Unauthorized to modify setting due to capability.')]))
		} else {
			if rt.is_true(rt.new_bool(var_unsanitized_value.clone().is_null())) {
				continue
			}
		var_validity = rt.call_method(var_setting, 'validate', [var_unsanitized_value.clone()])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_validity.clone()]))))) {
			mut var_late_validity := rt.call_function('apply_filters', [rt.concat(rt.new_string('customize_validate_'), rt.get_property(var_setting, 'id')), create_wp_error(), var_unsanitized_value.clone(), var_setting.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_late_validity.clone()])) && rt.is_true(rt.call_method(var_late_validity, 'has_errors', []rt.PhpVal{})) {
			var_validity = var_late_validity.clone()
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_validity.clone()]))))) {
			mut var_value := rt.call_method(var_setting, 'sanitize', [var_unsanitized_value.clone()])
			if rt.is_true(rt.new_bool(var_value.clone().is_null())) {
			var_validity = rt.new_bool(false)
			} else if rt.is_true(rt.call_function('is_wp_error', [var_value.clone()])) {
			var_validity = var_value.clone()
			}
		}
		if rt.is_true(rt.identical(rt.new_bool(false), var_validity)) {
		var_validity = create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [rt.new_string('Invalid value.')]))
		}
		var_validities.array_set(var_setting_id, var_validity.clone())
	}
	return var_validities.clone()
}

fn (mut this Class_WP_Customize_Manager) prepare_setting_validity_for_js(var_validity rt.PhpVal) rt.PhpVal {
	mut var_validity_mutated := var_validity
	if rt.is_true(rt.call_function('is_wp_error', [var_validity_mutated.clone()])) {
		mut var_notification := rt.new_array()
		mut iter_27 := rt.get_property(var_validity_mutated, 'errors').iterator()
		for {
			item_27 := iter_27.next() or { break }
			mut var_error_messages := item_27.val
			mut var_error_code := item_27.key
			var_notification.array_set(var_error_code, rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('implode', [rt.new_string(' '), var_error_messages.clone()]) }, rt.ArrayItem{ key: 'data', val: rt.call_method(var_validity_mutated, 'get_error_data', [var_error_code.clone()]) }]))
		}
		return var_notification.clone()
	} else {
		return rt.new_bool(true)
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) save() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('unauthenticated')])
	}
	if !(this.is_preview()) {
		rt.call_function('wp_send_json_error', [rt.new_string('not_preview')])
	}
	mut var_action := rt.new_string('save-customize_' + (this.get_stylesheet()).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [var_action.clone(), rt.new_string('nonce'), rt.new_bool(false)]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('invalid_nonce')])
	}
	mut var_changeset_post_id := this.changeset_post_id()
	mut var_is_new_changeset := rt.new_bool(!rt.is_true(var_changeset_post_id))
	if rt.is_true(var_is_new_changeset) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'create_posts')]))))) {
			rt.call_function('wp_send_json_error', [rt.new_string('cannot_create_changeset_post')])
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'edit_post'), var_changeset_post_id.clone()]))))) {
			rt.call_function('wp_send_json_error', [rt.new_string('cannot_edit_changeset_post')])
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('customize_changeset_data')))) {
		mut var_input_changeset_data := rt.call_function('json_decode', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('customize_changeset_data'))]), rt.new_bool(true)])
		if !(var_input_changeset_data.clone().is_array()) {
			rt.call_function('wp_send_json_error', [rt.new_string('invalid_customize_changeset_data')])
		}
	} else {
	var_input_changeset_data = rt.new_array()
	}
	mut var_changeset_title := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('customize_changeset_title')) {
	var_changeset_title = rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('customize_changeset_title'))])])
	}
	mut var_is_publish := rt.new_null()
	mut var_changeset_status := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('customize_changeset_status')) {
		var_changeset_status = rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('customize_changeset_status'))])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_post_status_object', [var_changeset_status.clone()]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_changeset_status.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'draft' }, rt.ArrayItem{ key: none, val: 'pending' }, rt.ArrayItem{ key: none, val: 'publish' }, rt.ArrayItem{ key: none, val: 'future' }]), rt.new_bool(true)]))))) {
			rt.call_function('wp_send_json_error', [rt.new_string('bad_customize_changeset_status'), rt.new_int(400)])
		}
		var_is_publish = rt.new_bool(rt.is_true(rt.identical(rt.new_string('publish'), var_changeset_status)) || rt.is_true(rt.identical(rt.new_string('future'), var_changeset_status)))
		if rt.is_true(var_is_publish) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'publish_posts')]))))) {
			rt.call_function('wp_send_json_error', [rt.new_string('changeset_publish_unauthorized'), rt.new_int(403)])
		}
	}
	mut var_changeset_date_gmt := rt.new_null()
	if rt.get_superglobal('_POST').array_isset(rt.new_string('customize_changeset_date')) {
		mut var_changeset_date := rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('customize_changeset_date'))])
		if rt.is_true(rt.call_function('preg_match', [rt.new_string('/^\\d\\d\\d\\d-\\d\\d-\\d\\d \\d\\d:\\d\\d:\\d\\d$/'), var_changeset_date.clone()])) {
			mut var_mm := rt.call_function('substr', [var_changeset_date.clone(), rt.new_int(5), rt.new_int(2)])
			mut var_jj := rt.call_function('substr', [var_changeset_date.clone(), rt.new_int(8), rt.new_int(2)])
			mut var_aa := rt.call_function('substr', [var_changeset_date.clone(), rt.new_int(0), rt.new_int(4)])
			mut var_valid_date := rt.call_function('wp_checkdate', [var_mm.clone(), var_jj.clone(), var_aa.clone(), var_changeset_date.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_valid_date)))) {
				rt.call_function('wp_send_json_error', [rt.new_string('bad_customize_changeset_date'), rt.new_int(400)])
			}
		var_changeset_date_gmt = rt.call_function('get_gmt_from_date', [var_changeset_date.clone()])
		} else {
			mut var_timestamp := rt.call_function('strtotime', [var_changeset_date.clone()])
			if rt.is_true(rt.new_bool(!(rt.is_true(var_timestamp)))) {
				rt.call_function('wp_send_json_error', [rt.new_string('bad_customize_changeset_date'), rt.new_int(400)])
			}
		var_changeset_date_gmt = rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:s'), var_timestamp.clone()])
		}
	}
	mut var_lock_user_id := rt.new_null()
	mut var_autosave := rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('customize_changeset_autosave')))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_new_changeset)))) {
	var_lock_user_id = rt.call_function('wp_check_post_lock', [this.changeset_post_id()])
	}
	if rt.is_true(var_lock_user_id) && rt.is_true(rt.new_bool(!(rt.is_true(var_autosave)))) {
	var_autosave = rt.new_bool(true)
	var_changeset_status = rt.new_null()
	var_changeset_date_gmt = rt.new_null()
	}
	if rt.is_true(var_autosave) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AUTOSAVE')]))))) {
		rt.call_function('define', [rt.new_string('DOING_AUTOSAVE'), rt.new_bool(true)])
	}
	mut var_autosaved := rt.new_bool(false)
	mut var_r := this.save_changeset_post(rt.create_array([rt.ArrayItem{ key: 'status', val: var_changeset_status }, rt.ArrayItem{ key: 'title', val: var_changeset_title }, rt.ArrayItem{ key: 'date_gmt', val: var_changeset_date_gmt }, rt.ArrayItem{ key: 'data', val: var_input_changeset_data }, rt.ArrayItem{ key: 'autosave', val: var_autosave }]))
	if rt.is_true(var_autosave) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_r.clone()]))))) {
	var_autosaved = rt.new_bool(true)
	}
	if rt.is_true(var_lock_user_id) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_r.clone()]))))) {
	var_r = create_wp_error(rt.new_string('changeset_locked'), rt.call_function('__', [rt.new_string('Changeset is being edited by other user.')]), rt.create_array([rt.ArrayItem{ key: 'lock_user', val: this.get_lock_user_data(var_lock_user_id.clone()) }]))
	}
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		mut var_response := rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_method(var_r, 'get_error_message', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'code', val: rt.call_method(var_r, 'get_error_code', []rt.PhpVal{}) }])
		if rt.is_true(rt.new_bool(rt.call_method(var_r, 'get_error_data', []rt.PhpVal{}).is_array())) {
		var_response = rt.call_function('array_merge', [var_response.clone(), rt.call_method(var_r, 'get_error_data', []rt.PhpVal{})])
		} else {
			var_response.array_set('data', rt.call_method(var_r, 'get_error_data', []rt.PhpVal{}))
		}
	} else {
		var_response = var_r.clone()
		mut var_changeset_post := rt.call_function('get_post', [this.changeset_post_id()])
		if rt.is_true(var_is_new_changeset) {
			this.dismiss_user_auto_draft_changesets()
		}
		var_response.array_set('changeset_status', rt.get_property(var_changeset_post, 'post_status'))
		if rt.is_true(var_is_publish) && rt.is_true(rt.identical(rt.new_string('trash'), var_response.array_get(rt.new_string('changeset_status')))) {
			var_response.array_set('changeset_status', 'publish')
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('publish'), var_response.array_get(rt.new_string('changeset_status')))))) {
			this.set_changeset_lock(rt.get_property(var_changeset_post, 'ID'), false)
		}
		if rt.is_true(rt.identical(rt.new_string('future'), var_response.array_get(rt.new_string('changeset_status')))) {
			var_response.array_set('changeset_date', rt.get_property(var_changeset_post, 'post_date'))
		}
		if rt.is_true(rt.identical(rt.new_string('publish'), var_response.array_get(rt.new_string('changeset_status')))) || rt.is_true(rt.identical(rt.new_string('trash'), var_response.array_get(rt.new_string('changeset_status')))) {
			var_response.array_set('next_changeset_uuid', rt.call_function('wp_generate_uuid4', []rt.PhpVal{}))
		}
	}
	if rt.is_true(var_autosave) {
		var_response.array_set('autosaved', var_autosaved.clone())
	}
	if var_response.array_isset(rt.new_string('setting_validities')) {
		var_response.array_set('setting_validities', rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'prepare_setting_validity_for_js' }]), var_response.array_get(rt.new_string('setting_validities'))]))
	}
	var_response = rt.call_function('apply_filters', [rt.new_string('customize_save_response'), var_response.clone(), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		rt.call_function('wp_send_json_error', [var_response.clone()])
	} else {
		rt.call_function('wp_send_json_success', [var_response.clone()])
	}
}

fn (mut this Class_WP_Customize_Manager) save_changeset_post(var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	var_args_mutated = rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: 'status', val: rt.new_null() }, rt.ArrayItem{ key: 'title', val: rt.new_null() }, rt.ArrayItem{ key: 'data', val: rt.new_array() }, rt.ArrayItem{ key: 'date_gmt', val: rt.new_null() }, rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'starter_content', val: false }, rt.ArrayItem{ key: 'autosave', val: false }]), var_args_mutated.clone()])
	mut var_changeset_post_id := this.changeset_post_id()
	mut var_existing_changeset_data := rt.new_array()
	if rt.is_true(var_changeset_post_id) {
		mut var_existing_status := rt.call_function('get_post_status', [var_changeset_post_id.clone()])
		if rt.is_true(rt.identical(rt.new_string('publish'), var_existing_status)) || rt.is_true(rt.identical(rt.new_string('trash'), var_existing_status)) {
			return create_wp_error(rt.new_string('changeset_already_published'), rt.call_function('__', [rt.new_string('The previous set of changes has already been published. Please try saving your current set of changes again.')]), rt.create_array([rt.ArrayItem{ key: 'next_changeset_uuid', val: rt.call_function('wp_generate_uuid4', []rt.PhpVal{}) }]))
		}
		var_existing_changeset_data = this.get_changeset_post_data(var_changeset_post_id.clone())
		if rt.is_true(rt.call_function('is_wp_error', [var_existing_changeset_data.clone()])) {
			return var_existing_changeset_data.clone()
		}
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), var_args_mutated.array_get(rt.new_string('status')))) && rt.is_true(rt.identical(rt.new_bool(false), rt.call_function('has_action', [rt.new_string('transition_post_status'), rt.new_string('_wp_customize_publish_changeset')]))) {
		return create_wp_error(rt.new_string('missing_publish_callback'))
	}
	mut var_now := rt.call_function('gmdate', [rt.new_string('Y-m-d H:i:59')])
	if rt.is_true(var_args_mutated.array_get(rt.new_string('date_gmt'))) {
		mut var_is_future_dated := rt.greater(rt.call_function('mysql2date', [rt.new_string('U'), var_args_mutated.array_get(rt.new_string('date_gmt')), rt.new_bool(false)]), rt.call_function('mysql2date', [rt.new_string('U'), var_now.clone(), rt.new_bool(false)]))
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_future_dated)))) {
			return create_wp_error(rt.new_string('not_future_date'), rt.call_function('__', [rt.new_string('You must supply a future date to schedule.')]))
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(this.is_theme_active())))) && rt.is_true(rt.identical(rt.new_string('future'), var_args_mutated.array_get(rt.new_string('status')))) || rt.is_true(var_is_future_dated) {
			return create_wp_error(rt.new_string('cannot_schedule_theme_switches'))
		}
		mut var_will_remain_auto_draft := rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_args_mutated.array_get(rt.new_string('status')))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_changeset_post_id)))) || rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_function('get_post_status', [var_changeset_post_id.clone()]))))
		if rt.is_true(var_will_remain_auto_draft) {
			return create_wp_error(rt.new_string('cannot_supply_date_for_auto_draft_changeset'))
		}
	} else if rt.is_true(var_changeset_post_id) && rt.is_true(rt.identical(rt.new_string('future'), var_args_mutated.array_get(rt.new_string('status')))) {
		mut var_changeset_post := rt.call_function('get_post', [var_changeset_post_id.clone()])
		if rt.is_true(rt.less_equal(rt.call_function('mysql2date', [rt.new_string('U'), rt.get_property(var_changeset_post, 'post_date_gmt'), rt.new_bool(false)]), rt.call_function('mysql2date', [rt.new_string('U'), var_now.clone(), rt.new_bool(false)]))) {
			return create_wp_error(rt.new_string('not_future_date'), rt.call_function('__', [rt.new_string('You must supply a future date to schedule.')]))
		}
	}
	if !(!rt.is_true(var_is_future_dated)) && rt.is_true(rt.identical(rt.new_string('publish'), var_args_mutated.array_get(rt.new_string('status')))) {
		var_args_mutated.array_set('status', 'future')
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('autosave'))) {
		if rt.is_true(var_args_mutated.array_get(rt.new_string('date_gmt'))) {
			return create_wp_error(rt.new_string('illegal_autosave_with_date_gmt'))
		} else if rt.is_true(var_args_mutated.array_get(rt.new_string('status'))) {
			return create_wp_error(rt.new_string('illegal_autosave_with_status'))
		} else if rt.is_true(var_args_mutated.array_get(rt.new_string('user_id'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_args_mutated.array_get(rt.new_string('user_id')))))) {
			return create_wp_error(rt.new_string('illegal_autosave_with_non_current_user'))
		}
	}
	mut var_update_transactionally := rt.new_bool((var_args_mutated.array_get(rt.new_string('status'))).to_bool())
	mut var_allow_revision := rt.new_bool((var_args_mutated.array_get(rt.new_string('status'))).to_bool())
	mut iter_28 := var_args_mutated.array_get(rt.new_string('data')).iterator()
	for {
		item_28 := iter_28.next() or { break }
		mut var_setting_params := item_28.val
		mut var_setting_id := item_28.key
		if var_setting_params.clone().is_array() && rt.is_true(rt.new_bool(var_setting_params.clone().array_isset(rt.new_string('value')))) {
			this.set_post_value(var_setting_id.clone(), var_setting_params.array_get(rt.new_string('value')))
		}
	}
	mut var_post_values := this.unsanitized_post_values(rt.create_array([rt.ArrayItem{ key: 'exclude_changeset', val: true }, rt.ArrayItem{ key: 'exclude_post_data', val: false }]))
	this.add_dynamic_settings(rt.func_array_keys(var_post_values.clone()))
	mut var_changed_setting_ids := rt.new_array()
	mut iter_29 := var_post_values.iterator()
	for {
		item_29 := iter_29.next() or { break }
		mut var_setting_value := item_29.val
		mut var_setting_id := item_29.key
		mut var_setting := this.get_setting(var_setting_id.clone())
		if rt.is_true(var_setting) && rt.is_true(rt.identical(rt.new_string('theme_mod'), rt.get_property(var_setting, 'type'))) {
		mut var_prefixed_setting_id := rt.new_string((this.get_stylesheet()).str() + '::' + (rt.get_property(var_setting, 'id')).str())
		} else {
		var_prefixed_setting_id = var_setting_id.clone()
		}
		mut var_is_value_changed := rt.new_bool(!(var_existing_changeset_data.array_isset(var_prefixed_setting_id)) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_existing_changeset_data.array_get(var_prefixed_setting_id).array_isset(rt.new_string('value'))))))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_existing_changeset_data.array_get(var_prefixed_setting_id).array_get(rt.new_string('value')), var_setting_value)))))
		if rt.is_true(var_is_value_changed) {
			var_changed_setting_ids << var_setting_id.clone()
		}
	}
	rt.call_function('do_action', [rt.new_string('customize_save_validation_before'), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	mut var_validated_values := rt.call_function('array_merge', [rt.call_function('array_fill_keys', [rt.func_array_keys(var_args_mutated.array_get(rt.new_string('data'))), rt.new_null()]), var_post_values.clone()])
	mut var_setting_validities := this.validate_setting_values(var_validated_values.clone(), rt.create_array([rt.ArrayItem{ key: 'validate_capability', val: true }, rt.ArrayItem{ key: 'validate_existence', val: true }]))
	mut var_invalid_setting_count := rt.new_int(rt.call_function('array_filter', [var_setting_validities.clone(), rt.new_string('is_wp_error')]).array_count())
	if rt.is_true(var_update_transactionally) && rt.is_true(rt.greater(var_invalid_setting_count, rt.new_int(0))) {
		mut var_response := rt.create_array([rt.ArrayItem{ key: 'setting_validities', val: var_setting_validities }, rt.ArrayItem{ key: 'message', val: rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Unable to save due to %s invalid setting.'), rt.new_string('Unable to save due to %s invalid settings.'), var_invalid_setting_count.clone()]), rt.call_function('number_format_i18n', [var_invalid_setting_count.clone()])]) }])
		return create_wp_error(rt.new_string('transaction_fail'), rt.new_string(''), var_response.clone())
	}
	mut var_original_changeset_data := this.get_changeset_post_data(var_changeset_post_id.clone())
	mut var_data := var_original_changeset_data.clone()
	if rt.is_true(rt.call_function('is_wp_error', [var_data.clone()])) {
	var_data = rt.new_array()
	}
	mut iter_30 := var_post_values.iterator()
	for {
		item_30 := iter_30.next() or { break }
		mut var_post_value := item_30.val
		mut var_setting_id := item_30.key
		if !(var_args_mutated.array_get(rt.new_string('data')).array_isset(var_setting_id)) {
			var_args_mutated.array_get_mut('data').array_set(var_setting_id, rt.new_array())
		}
		if !(var_args_mutated.array_get(rt.new_string('data')).array_get(var_setting_id).array_isset(rt.new_string('value'))) {
			var_args_mutated.array_get_mut('data').array_get_mut(var_setting_id).array_set('value', var_post_value.clone())
		}
	}
	mut iter_31 := var_args_mutated.array_get(rt.new_string('data')).iterator()
	for {
		item_31 := iter_31.next() or { break }
		mut var_setting_params := item_31.val
		mut var_setting_id := item_31.key
		mut var_setting := this.get_setting(var_setting_id.clone())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_setting)))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_setting, 'check_capabilities', []rt.PhpVal{}))))) {
			continue
		}
		if var_setting_validities.array_isset(var_setting_id) && rt.is_true(rt.call_function('is_wp_error', [var_setting_validities.array_get(var_setting_id)])) {
			continue
		}
		mut var_changeset_setting_id := var_setting_id.clone()
		if rt.is_true(rt.identical(rt.new_string('theme_mod'), rt.get_property(var_setting, 'type'))) {
		var_changeset_setting_id = rt.call_function('sprintf', [rt.new_string('%s::%s'), this.get_stylesheet(), var_setting_id.clone()])
		}
		if rt.is_true(rt.identical(rt.new_null(), var_setting_params)) {
			var_data.array_unset(var_changeset_setting_id)
		} else {
			if !(var_data.array_isset(var_changeset_setting_id)) {
				var_data.array_set(var_changeset_setting_id, rt.new_array())
			}
			mut var_merged_setting_params := rt.call_function('array_merge', [var_data.array_get(var_changeset_setting_id), var_setting_params.clone()])
			if rt.is_true(rt.identical(var_data.array_get(var_changeset_setting_id), var_merged_setting_params)) {
				continue
			}
			var_data.array_set(var_changeset_setting_id, rt.call_function('array_merge', [var_merged_setting_params.clone(), rt.create_array([rt.ArrayItem{ key: 'type', val: rt.get_property(var_setting, 'type') }, rt.ArrayItem{ key: 'user_id', val: var_args_mutated.array_get(rt.new_string('user_id')) }, rt.ArrayItem{ key: 'date_modified_gmt', val: rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]) }])]))
			if !rt.is_true(var_args_mutated.array_get(rt.new_string('starter_content'))) {
				var_data.array_get(var_changeset_setting_id).array_unset(rt.new_string('starter_content'))
			}
		}
	}
	mut var_filter_context := { 'uuid': this.changeset_uuid(), 'title': var_args_mutated.array_get(rt.new_string('title')), 'status': var_args_mutated.array_get(rt.new_string('status')), 'date_gmt': var_args_mutated.array_get(rt.new_string('date_gmt')), 'post_id': var_changeset_post_id, 'previous_data': if rt.is_true(rt.call_function('is_wp_error', [var_original_changeset_data.clone()])) { rt.new_array() } else { var_original_changeset_data }, 'manager': rt.new_object('WP_Customize_Manager', []string{}, &this) }
	var_data = rt.call_function('apply_filters', [rt.new_string('customize_changeset_save_data'), var_data.clone(), rt.create_array_from_native_map(var_filter_context)])
	if rt.is_true(rt.identical(rt.new_string('publish'), var_args_mutated.array_get(rt.new_string('status')))) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_theme_active())))) {
		this.stop_previewing_theme()
		rt.call_function('switch_theme', [this.get_stylesheet()])
		rt.call_function('update_option', [rt.new_string('theme_switched_via_customizer'), rt.new_bool(true)])
		this.start_previewing_theme()
	}
	mut var_post_array := { 'post_content': rt.call_function('wp_json_encode', [var_data.clone(), rt.bitwise_or(rt.get_constant('JSON_UNESCAPED_SLASHES'), rt.get_constant('JSON_PRETTY_PRINT'))]) }
	if rt.is_true(var_args_mutated.array_get(rt.new_string('title'))) {
		var_post_array['post_title'] = var_args_mutated.array_get(rt.new_string('title'))
	}
	if rt.is_true(var_changeset_post_id) {
		var_post_array['ID'] = var_changeset_post_id.clone()
	} else {
		var_post_array['post_type'] = rt.new_string('customize_changeset')
		var_post_array['post_name'] = this.changeset_uuid()
		var_post_array['post_status'] = rt.new_string('auto-draft')
	}
	if rt.is_true(var_args_mutated.array_get(rt.new_string('status'))) {
		var_post_array['post_status'] = var_args_mutated.array_get(rt.new_string('status'))
	}
	if rt.is_true(rt.identical(rt.new_string('publish'), var_args_mutated.array_get(rt.new_string('status')))) {
		var_post_array['post_date_gmt'] = rt.new_string('0000-00-00 00:00:00')
		var_post_array['post_date'] = rt.new_string('0000-00-00 00:00:00')
	} else if rt.is_true(var_args_mutated.array_get(rt.new_string('date_gmt'))) {
		var_post_array['post_date_gmt'] = var_args_mutated.array_get(rt.new_string('date_gmt'))
		var_post_array['post_date'] = rt.call_function('get_date_from_gmt', [var_args_mutated.array_get(rt.new_string('date_gmt'))])
	} else if rt.is_true(var_changeset_post_id) && rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_function('get_post_status', [var_changeset_post_id.clone()]))) {
		var_post_array['post_date'] = rt.call_function('current_time', [rt.new_string('mysql')])
		var_post_array['post_date_gmt'] = rt.new_string('')
	}
	this.store_changeset_revision = var_allow_revision.clone()
	rt.call_function('add_filter', [rt.new_string('wp_save_post_revision_post_has_changed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_filter_revision_post_has_changed' }]), rt.new_int(5), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'preserve_insert_changeset_post_content' }]), rt.new_int(5), rt.new_int(3)])
	if rt.is_true(var_changeset_post_id) {
		if rt.is_true(var_args_mutated.array_get(rt.new_string('autosave'))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_function('get_post_status', [var_changeset_post_id.clone()]))))) {
			rt.call_function('add_filter', [rt.new_string('map_meta_cap'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'grant_edit_post_capability_for_changeset' }]), rt.new_int(10), rt.new_int(4)])
			var_post_array['post_ID'] = var_post_array['ID']
			var_post_array['post_type'] = rt.new_string('customize_changeset')
			mut var_r := rt.call_function('wp_create_post_autosave', [rt.call_function('wp_slash', [rt.create_array_from_native_map(var_post_array)])])
			rt.call_function('remove_filter', [rt.new_string('map_meta_cap'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'grant_edit_post_capability_for_changeset' }]), rt.new_int(10)])
		} else {
			var_post_array['edit_date'] = rt.new_bool(true)
			var_r = rt.call_function('wp_update_post', [rt.call_function('wp_slash', [rt.create_array_from_native_map(var_post_array)]), rt.new_bool(true)])
			if !(!rt.is_true(var_args_mutated.array_get(rt.new_string('user_id')))) {
				mut var_autosave_draft := rt.call_function('wp_get_post_autosave', [var_changeset_post_id.clone(), var_args_mutated.array_get(rt.new_string('user_id'))])
				if rt.is_true(var_autosave_draft) {
					rt.call_function('wp_delete_post', [rt.get_property(var_autosave_draft, 'ID'), rt.new_bool(true)])
				}
			}
		}
	} else {
		var_r = rt.call_function('wp_insert_post', [rt.call_function('wp_slash', [rt.create_array_from_native_map(var_post_array)]), rt.new_bool(true)])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_r.clone()]))))) {
			this._changeset_post_id = var_r.clone()
		}
	}
	rt.call_function('remove_filter', [rt.new_string('wp_insert_post_data'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'preserve_insert_changeset_post_content' }]), rt.new_int(5)])
	this._changeset_data = rt.new_null()
	rt.call_function('remove_filter', [rt.new_string('wp_save_post_revision_post_has_changed'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_filter_revision_post_has_changed' }])])
	var_response = rt.create_array([rt.ArrayItem{ key: 'setting_validities', val: var_setting_validities }])
	if rt.is_true(rt.call_function('is_wp_error', [var_r.clone()])) {
		var_response.array_set('changeset_post_save_failure', rt.call_method(var_r, 'get_error_code', []rt.PhpVal{}))
		return create_wp_error(rt.new_string('changeset_post_save_failure'), rt.new_string(''), var_response.clone())
	}
	return var_response.clone()
}

fn (mut this Class_WP_Customize_Manager) preserve_insert_changeset_post_content(var_data rt.PhpVal, var_postarr rt.PhpVal, var_unsanitized_postarr rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if (var_data_mutated.array_isset(rt.new_string('post_type')) && var_unsanitized_postarr.array_isset(rt.new_string('post_content')) && rt.is_true(rt.identical(rt.new_string('customize_changeset'), var_data_mutated.array_get(rt.new_string('post_type'))))) || (rt.is_true(rt.identical(rt.new_string('revision'), var_data_mutated.array_get(rt.new_string('post_type')))) && !(!rt.is_true(var_data_mutated.array_get(rt.new_string('post_parent')))) && rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.call_function('get_post_type', [var_data_mutated.array_get(rt.new_string('post_parent'))])))) {
		var_data_mutated.array_set('post_content', var_unsanitized_postarr.array_get(rt.new_string('post_content')))
	}
	return var_data_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) trash_changeset_post(var_post rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_post_mutated := var_post
	var_post_mutated = rt.call_function('get_post', [var_post_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_post_mutated, 'WP_Post')))))) {
		return (var_post_mutated).to_bool()
	}
	mut var_post_id := rt.get_property(var_post_mutated, 'ID')
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_constant('EMPTY_TRASH_DAYS'))))) {
		return (rt.call_function('wp_delete_post', [var_post_id.clone(), rt.new_bool(true)])).to_bool()
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_function('get_post_status', [var_post_mutated.clone()]))) {
		return false
	}
	mut var_previous_status := rt.get_property(var_post_mutated, 'post_status')
	mut var_check := rt.call_function('apply_filters', [rt.new_string('pre_trash_post'), rt.new_null(), var_post_mutated.clone(), var_previous_status.clone()])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_check)))) {
		return (var_check).to_bool()
	}
	rt.call_function('do_action', [rt.new_string('wp_trash_post'), var_post_id.clone(), var_previous_status.clone()])
	rt.call_function('add_post_meta', [var_post_id.clone(), rt.new_string('_wp_trash_meta_status'), var_previous_status.clone()])
	rt.call_function('add_post_meta', [var_post_id.clone(), rt.new_string('_wp_trash_meta_time'), rt.call_function('time', []rt.PhpVal{})])
	mut var_new_status := rt.new_string('trash')
	rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_status', val: var_new_status }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_post_mutated, 'ID') }])])
	rt.call_function('clean_post_cache', [rt.get_property(var_post_mutated, 'ID')])
	rt.set_property(var_post_mutated, 'post_status', var_new_status.clone())
	rt.call_function('wp_transition_post_status', [var_new_status.clone(), var_previous_status.clone(), var_post_mutated.clone()])
	rt.call_function('do_action', [rt.concat(rt.new_string('edit_post_'), rt.get_property(var_post_mutated, 'post_type')), rt.get_property(var_post_mutated, 'ID'), var_post_mutated.clone()])
	rt.call_function('do_action', [rt.new_string('edit_post'), rt.get_property(var_post_mutated, 'ID'), var_post_mutated.clone()])
	rt.call_function('do_action', [rt.concat(rt.new_string('save_post_'), rt.get_property(var_post_mutated, 'post_type')), rt.get_property(var_post_mutated, 'ID'), var_post_mutated.clone(), rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('save_post'), rt.get_property(var_post_mutated, 'ID'), var_post_mutated.clone(), rt.new_bool(true)])
	rt.call_function('do_action', [rt.new_string('wp_insert_post'), rt.get_property(var_post_mutated, 'ID'), var_post_mutated.clone(), rt.new_bool(true)])
	rt.call_function('wp_after_insert_post', [rt.call_function('get_post', [var_post_id.clone()]), rt.new_bool(true), var_post_mutated.clone()])
	rt.call_function('wp_trash_post_comments', [var_post_id.clone()])
	rt.call_function('do_action', [rt.new_string('trashed_post'), var_post_id.clone(), var_previous_status.clone()])
	return (var_post_mutated).to_bool()
}

fn (mut this Class_WP_Customize_Manager) handle_changeset_trash_request() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('unauthenticated')])
	}
	if !(this.is_preview()) {
		rt.call_function('wp_send_json_error', [rt.new_string('not_preview')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('trash_customize_changeset'), rt.new_string('nonce'), rt.new_bool(false)]))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'invalid_nonce' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('There was an authentication problem. Please reload and try again.')]) }])])
	}
	mut var_changeset_post_id := this.changeset_post_id()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_changeset_post_id)))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('No changes saved yet, so there is nothing to trash.')]) }, rt.ArrayItem{ key: 'code', val: 'non_existent_changeset' }])])
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'delete_post'), var_changeset_post_id.clone()]))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'changeset_trash_unauthorized' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Unable to trash changes.')]) }])])
	}
	mut var_lock_user := rt.new_int((rt.call_function('wp_check_post_lock', [var_changeset_post_id.clone()])).to_i64())
	if rt.is_true(var_lock_user) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.call_function('get_current_user_id', []rt.PhpVal{}), var_lock_user)))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'changeset_locked' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Changeset is being edited by other user.')]) }, rt.ArrayItem{ key: 'lockUser', val: this.get_lock_user_data(var_lock_user.clone()) }])])
	}
	if rt.is_true(rt.identical(rt.new_string('trash'), rt.call_function('get_post_status', [var_changeset_post_id.clone()]))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Changes have already been trashed.')]) }, rt.ArrayItem{ key: 'code', val: 'changeset_already_trashed' }])])
		return
	}
	mut var_r := rt.new_bool(this.trash_changeset_post(var_changeset_post_id.clone()))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_r, 'WP_Post')))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'changeset_trash_failure' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Unable to trash changes.')]) }])])
	}
	rt.call_function('wp_send_json_success', [rt.create_array([rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Changes trashed successfully.')]) }])])
}

fn (mut this Class_WP_Customize_Manager) grant_edit_post_capability_for_changeset(var_caps rt.PhpVal, var_cap rt.PhpVal, var_user_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_caps_mutated := var_caps
	mut var_user_id_mutated := var_user_id
	mut var_args_mutated := var_args
	if rt.is_true(rt.identical(rt.new_string('edit_post'), var_cap)) && !(!rt.is_true(var_args_mutated.array_get(rt.new_int(0)))) && rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.call_function('get_post_type', [var_args_mutated.array_get(rt.new_int(0))]))) {
	mut var_post_type_obj := rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')])
	var_caps_mutated = rt.call_function('map_meta_cap', [rt.get_property(rt.get_property(var_post_type_obj, 'cap'), '{"nodeType":"Expr_Variable","line":3242,"name":"cap"}'), var_user_id_mutated.clone()])
	}
	return var_caps_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) set_changeset_lock(var_changeset_post_id rt.PhpVal, take_over bool) {
	mut var_changeset_post_id_mutated := var_changeset_post_id
	if rt.is_true(var_changeset_post_id_mutated) {
		mut var_can_override := rt.new_bool(!(rt.is_true((rt.call_function('get_post_meta', [var_changeset_post_id_mutated.clone(), rt.new_string('_edit_lock'), rt.new_bool(true)])).to_bool())))
		if var_take_over {
		var_can_override = rt.new_bool(true)
		}
		if rt.is_true(var_can_override) {
			mut var_lock := rt.call_function('sprintf', [rt.new_string('%s:%s'), rt.call_function('time', []rt.PhpVal{}), rt.call_function('get_current_user_id', []rt.PhpVal{})])
			rt.call_function('update_post_meta', [var_changeset_post_id_mutated.clone(), rt.new_string('_edit_lock'), var_lock.clone()])
		} else {
			this.refresh_changeset_lock(var_changeset_post_id_mutated.clone())
		}
	}
}

fn (mut this Class_WP_Customize_Manager) refresh_changeset_lock(var_changeset_post_id rt.PhpVal) {
	mut var_changeset_post_id_mutated := var_changeset_post_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_changeset_post_id_mutated)))) {
		return
	}
	mut var_lock := rt.call_function('get_post_meta', [var_changeset_post_id_mutated.clone(), rt.new_string('_edit_lock'), rt.new_bool(true)])
	var_lock = rt.call_function('explode', [rt.new_string(':'), var_lock.clone()])
	if rt.is_true(var_lock) && !(!rt.is_true(var_lock.array_get(rt.new_int(1)))) {
		mut var_user_id := rt.new_int((var_lock.array_get(rt.new_int(1))).to_i64())
		mut var_current_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
		if rt.is_true(rt.identical(var_user_id, var_current_user_id)) {
			var_lock = rt.call_function('sprintf', [rt.new_string('%s:%s'), rt.call_function('time', []rt.PhpVal{}), var_user_id.clone()])
			rt.call_function('update_post_meta', [var_changeset_post_id_mutated.clone(), rt.new_string('_edit_lock'), var_lock.clone()])
		}
	}
}

fn (mut this Class_WP_Customize_Manager) add_customize_screen_to_heartbeat_settings(var_settings rt.PhpVal) rt.PhpVal {
	mut var_pagenow := rt.new_null()
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.identical(rt.new_string('customize.php'), var_pagenow)) {
		var_settings_mutated.array_set('screenId', 'customize')
	}
	return var_settings_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) get_lock_user_data(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_user_id_mutated := var_user_id
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user_id_mutated)))) {
		return rt.new_null()
	}
	mut var_lock_user := rt.call_function('get_userdata', [var_user_id_mutated.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_lock_user)))) {
		return rt.new_null()
	}
	mut var_user_details := { 'id': rt.get_property(var_lock_user, 'ID'), 'name': rt.get_property(var_lock_user, 'display_name') }
	if rt.is_true(rt.call_function('get_option', [rt.new_string('show_avatars')])) {
		var_user_details['avatar'] = rt.call_function('get_avatar_url', [rt.get_property(var_lock_user, 'ID'), rt.create_array([rt.ArrayItem{ key: 'size', val: 128 }])])
	}
	return var_user_details.clone()
}

fn (mut this Class_WP_Customize_Manager) check_changeset_lock_with_heartbeat(var_response rt.PhpVal, var_data rt.PhpVal, var_screen_id rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	mut var_data_mutated := var_data
	if var_data_mutated.array_isset(rt.new_string('changeset_uuid')) {
	mut var_changeset_post_id := this.find_changeset_post_id(var_data_mutated.array_get(rt.new_string('changeset_uuid')))
	} else {
	var_changeset_post_id = this.changeset_post_id()
	}
	if rt.is_true(rt.new_bool(var_data_mutated.clone().array_isset(rt.new_string('check_changeset_lock')))) && rt.is_true(rt.identical(rt.new_string('customize'), var_screen_id)) && rt.is_true(var_changeset_post_id) && rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'edit_post'), var_changeset_post_id.clone()])) {
		mut var_lock_user_id := rt.call_function('wp_check_post_lock', [var_changeset_post_id.clone()])
		if rt.is_true(var_lock_user_id) {
			var_response_mutated.array_set('customize_changeset_lock_user', this.get_lock_user_data(var_lock_user_id.clone()))
		} else {
			this.refresh_changeset_lock(var_changeset_post_id.clone())
		}
	}
	return var_response_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) handle_override_changeset_lock_request() {
	if !(this.is_preview()) {
		rt.call_function('wp_send_json_error', [rt.new_string('not_preview'), rt.new_int(400)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('customize_override_changeset_lock'), rt.new_string('nonce'), rt.new_bool(false)]))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'invalid_nonce' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Security check failed.')]) }])])
	}
	mut var_changeset_post_id := this.changeset_post_id()
	if !rt.is_true(var_changeset_post_id) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'no_changeset_found_to_take_over' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('No changeset found to take over')]) }])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'edit_post'), var_changeset_post_id.clone()]))))) {
		rt.call_function('wp_send_json_error', [rt.create_array([rt.ArrayItem{ key: 'code', val: 'cannot_remove_changeset_lock' }, rt.ArrayItem{ key: 'message', val: rt.call_function('__', [rt.new_string('Sorry, you are not allowed to take over.')]) }])])
	}
	this.set_changeset_lock(var_changeset_post_id.clone(), true)
	rt.call_function('wp_send_json_success', [rt.new_string('changeset_taken_over')])
}

fn (mut this Class_WP_Customize_Manager) _filter_revision_post_has_changed(var_post_has_changed rt.PhpVal, var_latest_revision rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_post_has_changed_mutated := var_post_has_changed
	mut var_latest_revision_mutated := var_latest_revision
	mut var_post_mutated := var_post
	var_latest_revision_mutated = rt.new_null()
	if rt.is_true(rt.identical(rt.new_string('customize_changeset'), rt.get_property(var_post_mutated, 'post_type'))) {
	var_post_has_changed_mutated = this.store_changeset_revision
	}
	return var_post_has_changed_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) _publish_changeset_values(var_changeset_post_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_changeset_post_id_mutated := var_changeset_post_id
	mut var_publishing_changeset_data := this.get_changeset_post_data(var_changeset_post_id_mutated.clone())
	if rt.is_true(rt.call_function('is_wp_error', [var_publishing_changeset_data.clone()])) {
		return (var_publishing_changeset_data).to_bool()
	}
	mut var_changeset_post := rt.call_function('get_post', [var_changeset_post_id_mutated.clone()])
	mut var_previous_changeset_post_id := this._changeset_post_id
	this._changeset_post_id = var_changeset_post_id_mutated.clone()
	mut var_previous_changeset_uuid := this._changeset_uuid
	this._changeset_uuid = rt.get_property(var_changeset_post, 'post_name')
	mut var_previous_changeset_data := this._changeset_data
	this._changeset_data = var_publishing_changeset_data.clone()
	mut var_setting_user_ids := rt.new_array()
	mut var_theme_mod_settings := rt.new_array()
	mut var_namespace_pattern := rt.new_string('/^(?P<stylesheet>.+?)::(?P<setting_id>.+)$/')
	mut var_matches := rt.new_array()
	mut iter_32 := this._changeset_data.iterator()
	for {
		item_32 := iter_32.next() or { break }
		mut var_setting_params := item_32.val
		mut var_raw_setting_id := item_32.key
		mut var_actual_setting_id := rt.new_null()
		mut var_is_theme_mod_setting := rt.new_bool(var_setting_params.array_isset(rt.new_string('value')) && var_setting_params.array_isset(rt.new_string('type')) && rt.is_true(rt.identical(rt.new_string('theme_mod'), var_setting_params.array_get(rt.new_string('type')))) && rt.is_true(rt.call_function('preg_match', [var_namespace_pattern.clone(), var_raw_setting_id.clone(), var_matches.clone()])))
		if rt.is_true(var_is_theme_mod_setting) {
			if !(var_theme_mod_settings.array_isset(var_matches.array_get(rt.new_string('stylesheet')))) {
				var_theme_mod_settings.array_set(var_matches.array_get(rt.new_string('stylesheet')), rt.new_array())
			}
			var_theme_mod_settings.array_get_mut(var_matches.array_get(rt.new_string('stylesheet'))).array_set(var_matches.array_get(rt.new_string('setting_id')), var_setting_params.clone())
			if rt.is_true(rt.identical(this.get_stylesheet(), var_matches.array_get(rt.new_string('stylesheet')))) {
			var_actual_setting_id = var_matches.array_get(rt.new_string('setting_id'))
			}
		} else {
		var_actual_setting_id = var_raw_setting_id
		}
		if rt.is_true(var_actual_setting_id) && var_setting_params.array_isset(rt.new_string('user_id')) {
			var_setting_user_ids.array_set(var_actual_setting_id, var_setting_params.array_get(rt.new_string('user_id')))
		}
	}
	mut var_changeset_setting_values := this.unsanitized_post_values(rt.create_array([rt.ArrayItem{ key: 'exclude_post_data', val: true }, rt.ArrayItem{ key: 'exclude_changeset', val: false }]))
	mut var_changeset_setting_ids := rt.func_array_keys(var_changeset_setting_values.clone())
	this.add_dynamic_settings(var_changeset_setting_ids.clone())
	rt.call_function('do_action', [rt.new_string('customize_save'), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	mut var_original_setting_capabilities := rt.new_array()
	mut iter_33 := var_changeset_setting_ids.iterator()
	for {
		item_33 := iter_33.next() or { break }
		mut var_setting_id := item_33.val
		mut var_setting := this.get_setting(var_setting_id.clone())
		if rt.is_true(var_setting) && !(var_setting_user_ids.array_isset(var_setting_id)) {
			var_original_setting_capabilities.array_set(rt.get_property(var_setting, 'id'), rt.get_property(var_setting, 'capability'))
			rt.set_property(var_setting, 'capability', rt.new_string('exist'))
		}
	}
	mut var_original_user_id := rt.call_function('get_current_user_id', []rt.PhpVal{})
	mut iter_34 := var_changeset_setting_ids.iterator()
	for {
		item_34 := iter_34.next() or { break }
		mut var_setting_id := item_34.val
		mut var_setting := this.get_setting(var_setting_id.clone())
		if rt.is_true(var_setting) {
			if var_setting_user_ids.array_isset(var_setting_id) {
				rt.call_function('wp_set_current_user', [var_setting_user_ids.array_get(var_setting_id)])
			} else {
				rt.call_function('wp_set_current_user', [var_original_user_id.clone()])
			}
			rt.call_method(var_setting, 'save', []rt.PhpVal{})
		}
	}
	rt.call_function('wp_set_current_user', [var_original_user_id.clone()])
	if rt.is_true(rt.call_function('did_action', [rt.new_string('switch_theme')])) {
		mut var_other_theme_mod_settings := var_theme_mod_settings.clone()
		var_other_theme_mod_settings.array_unset(this.get_stylesheet())
		this.update_stashed_theme_mod_settings(var_other_theme_mod_settings.clone())
	}
	rt.call_function('do_action', [rt.new_string('customize_save_after'), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	mut iter_35 := var_original_setting_capabilities.iterator()
	for {
		item_35 := iter_35.next() or { break }
		mut var_capability := item_35.val
		mut var_setting_id := item_35.key
		mut var_setting := this.get_setting(var_setting_id.clone())
		if rt.is_true(var_setting) {
			rt.set_property(var_setting, 'capability', var_capability.clone())
		}
	}
	this._changeset_data = var_previous_changeset_data.clone()
	this._changeset_post_id = var_previous_changeset_post_id.clone()
	this._changeset_uuid = var_previous_changeset_uuid.clone()
	mut var_revisions := rt.call_function('wp_get_post_revisions', [var_changeset_post_id_mutated.clone(), rt.create_array([rt.ArrayItem{ key: 'check_enabled', val: false }])])
	mut iter_36 := var_revisions.iterator()
	for {
		item_36 := iter_36.next() or { break }
		mut var_revision := item_36.val
		if rt.is_true(rt.call_function('str_contains', [rt.get_property(var_revision, 'post_name'), rt.new_string("${var_changeset_post_id.to_string()}-autosave")])) {
			rt.call_method(var_wpdb, 'update', [rt.get_property(var_wpdb, 'posts'), rt.create_array([rt.ArrayItem{ key: 'post_status', val: 'auto-draft' }, rt.ArrayItem{ key: 'post_type', val: 'customize_changeset' }, rt.ArrayItem{ key: 'post_name', val: rt.call_function('wp_generate_uuid4', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'post_parent', val: 0 }]), rt.create_array([rt.ArrayItem{ key: 'ID', val: rt.get_property(var_revision, 'ID') }])])
			rt.call_function('clean_post_cache', [rt.get_property(var_revision, 'ID')])
		}
	}
	return true
}

fn (mut this Class_WP_Customize_Manager) update_stashed_theme_mod_settings(var_inactive_theme_mod_settings rt.PhpVal) rt.PhpVal {
	mut var_stashed_theme_mod_settings := rt.call_function('get_option', [rt.new_string('customize_stashed_theme_mods')])
	if !rt.is_true(var_stashed_theme_mod_settings) {
	var_stashed_theme_mod_settings = rt.new_array()
	}
	var_stashed_theme_mod_settings.array_unset(this.get_stylesheet())
	mut iter_37 := var_inactive_theme_mod_settings.iterator()
	for {
		item_37 := iter_37.next() or { break }
		mut var_theme_mod_settings := item_37.val
		mut var_stylesheet := item_37.key
		if !(var_stashed_theme_mod_settings.array_isset(var_stylesheet)) {
			var_stashed_theme_mod_settings.array_set(var_stylesheet, rt.new_array())
		}
		var_stashed_theme_mod_settings.array_set(var_stylesheet, rt.call_function('array_merge', [var_stashed_theme_mod_settings.array_get(var_stylesheet), var_theme_mod_settings.clone()]))
	}
	mut var_autoload := rt.new_bool(false)
	mut var_result := rt.call_function('update_option', [rt.new_string('customize_stashed_theme_mods'), var_stashed_theme_mod_settings.clone(), var_autoload.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_result)))) {
		return rt.new_bool(false)
	}
	return var_stashed_theme_mod_settings.clone()
}

fn (mut this Class_WP_Customize_Manager) refresh_nonces() {
	if !(this.is_preview()) {
		rt.call_function('wp_send_json_error', [rt.new_string('not_preview')])
	}
	rt.call_function('wp_send_json_success', [this.get_nonces()])
}

fn (mut this Class_WP_Customize_Manager) handle_dismiss_autosave_or_lock_request() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('unauthenticated'), rt.new_int(401)])
	}
	if !(this.is_preview()) {
		rt.call_function('wp_send_json_error', [rt.new_string('not_preview'), rt.new_int(400)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('check_ajax_referer', [rt.new_string('customize_dismiss_autosave_or_lock'), rt.new_string('nonce'), rt.new_bool(false)]))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('invalid_nonce'), rt.new_int(403)])
	}
	mut var_changeset_post_id := this.changeset_post_id()
	mut var_dismiss_lock := rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('dismiss_lock')))))
	mut var_dismiss_autosave := rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('dismiss_autosave')))))
	if rt.is_true(var_dismiss_lock) {
		if !rt.is_true(var_changeset_post_id) && rt.is_true(rt.new_bool(!(rt.is_true(var_dismiss_autosave)))) {
			rt.call_function('wp_send_json_error', [rt.new_string('no_changeset_to_dismiss_lock'), rt.new_int(404)])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'edit_post'), var_changeset_post_id.clone()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_dismiss_autosave)))) {
			rt.call_function('wp_send_json_error', [rt.new_string('cannot_remove_changeset_lock'), rt.new_int(403)])
		}
		rt.call_function('delete_post_meta', [var_changeset_post_id.clone(), rt.new_string('_edit_lock')])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_dismiss_autosave)))) {
			rt.call_function('wp_send_json_success', [rt.new_string('changeset_lock_dismissed')])
		}
	}
	if rt.is_true(var_dismiss_autosave) {
		if !rt.is_true(var_changeset_post_id) || rt.is_true(rt.identical(rt.new_string('auto-draft'), rt.call_function('get_post_status', [var_changeset_post_id.clone()]))) {
			mut var_dismissed := this.dismiss_user_auto_draft_changesets()
			if rt.is_true(rt.greater(var_dismissed, rt.new_int(0))) {
				rt.call_function('wp_send_json_success', [rt.new_string('auto_draft_dismissed')])
			} else {
				rt.call_function('wp_send_json_error', [rt.new_string('no_auto_draft_to_delete'), rt.new_int(404)])
			}
		} else {
			mut var_revision := rt.call_function('wp_get_post_autosave', [var_changeset_post_id.clone(), rt.call_function('get_current_user_id', []rt.PhpVal{})])
			if rt.is_true(var_revision) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'delete_post'), var_changeset_post_id.clone()]))))) {
					rt.call_function('wp_send_json_error', [rt.new_string('cannot_delete_autosave_revision'), rt.new_int(403)])
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_delete_post', [rt.get_property(var_revision, 'ID'), rt.new_bool(true)]))))) {
					rt.call_function('wp_send_json_error', [rt.new_string('autosave_revision_deletion_failure'), rt.new_int(500)])
				} else {
					rt.call_function('wp_send_json_success', [rt.new_string('autosave_revision_deleted')])
				}
			} else {
				rt.call_function('wp_send_json_error', [rt.new_string('no_autosave_revision_to_delete'), rt.new_int(404)])
			}
		}
	}
	rt.call_function('wp_send_json_error', [rt.new_string('unknown_error'), rt.new_int(500)])
}

fn (mut this Class_WP_Customize_Manager) add_setting(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.instance_of(var_id, 'WP_Customize_Setting'))) {
	mut var_setting := var_id
	} else {
	mut var_class := rt.new_string('WP_Customize_Setting')
	var_args_mutated = rt.call_function('apply_filters', [rt.new_string('customize_dynamic_setting_args'), var_args_mutated.clone(), var_id.clone()])
	var_class = rt.call_function('apply_filters', [rt.new_string('customize_dynamic_setting_class'), var_class.clone(), var_id.clone(), var_args_mutated.clone()])
	var_setting = rt.create_object_dynamically(var_class, [rt.new_object('WP_Customize_Manager', []string{}, &this), var_id.clone(), var_args_mutated.clone()])
	}
	this.settings.array_set(rt.get_property(var_setting, 'id'), var_setting.clone())
	return var_setting.clone()
}

fn (mut this Class_WP_Customize_Manager) add_dynamic_settings(var_setting_ids rt.PhpVal) rt.PhpVal {
	mut var_setting_ids_mutated := var_setting_ids
	mut var_new_settings := rt.new_array()
	mut iter_38 := var_setting_ids_mutated.iterator()
	for {
		item_38 := iter_38.next() or { break }
		mut var_setting_id := item_38.val
		if rt.is_true(this.get_setting(var_setting_id.clone())) {
			continue
		}
		mut var_setting_args := rt.new_bool(false)
		mut var_setting_class := rt.new_string('WP_Customize_Setting')
		var_setting_args = rt.call_function('apply_filters', [rt.new_string('customize_dynamic_setting_args'), var_setting_args.clone(), var_setting_id.clone()])
		if rt.is_true(rt.identical(rt.new_bool(false), var_setting_args)) {
			continue
		}
		var_setting_class = rt.call_function('apply_filters', [rt.new_string('customize_dynamic_setting_class'), var_setting_class.clone(), var_setting_id.clone(), var_setting_args.clone()])
		mut var_setting := rt.create_object_dynamically(var_setting_class, [rt.new_object('WP_Customize_Manager', []string{}, &this), var_setting_id.clone(), var_setting_args.clone()])
		this.add_setting(var_setting.clone(), rt.new_null())
		var_new_settings << var_setting.clone()
	}
	return var_new_settings.clone()
}

fn (mut this Class_WP_Customize_Manager) get_setting(var_id rt.PhpVal) rt.PhpVal {
	if this.settings.array_isset(var_id) {
		return this.settings.array_get(var_id)
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_setting(var_id rt.PhpVal) {
	this.settings.array_unset(var_id)
}

fn (mut this Class_WP_Customize_Manager) add_panel(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.instance_of(var_id, 'WP_Customize_Panel'))) {
	mut var_panel := var_id
	} else {
	var_panel = create_wp_customize_panel(rt.new_object('WP_Customize_Manager', []string{}, &this), var_id.clone(), var_args_mutated.clone())
	}
	this.panels.array_set(rt.get_property(var_panel, 'id'), var_panel.clone())
	return var_panel.clone()
}

fn (mut this Class_WP_Customize_Manager) get_panel(var_id rt.PhpVal) rt.PhpVal {
	if this.panels.array_isset(var_id) {
		return this.panels.array_get(var_id)
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_panel(var_id rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array', [var_id.clone(), this.components, rt.new_bool(true)])) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Removing %1$s manually will cause PHP warnings. Use the %2$s filter instead.')]), var_id.clone(), rt.call_function('sprintf', [rt.new_string('<a href="%1$s">%2$s</a>'), rt.call_function('esc_url', [rt.new_string('https://developer.wordpress.org/reference/hooks/customize_loaded_components/')]), rt.new_string('<code>customize_loaded_components</code>')])]), rt.new_string('4.5.0')])
	}
	this.panels.array_unset(var_id)
}

fn (mut this Class_WP_Customize_Manager) register_panel_type(var_panel rt.PhpVal) {
	mut var_panel_mutated := var_panel
	this.registered_panel_types.array_push(var_panel_mutated.clone())
}

fn (mut this Class_WP_Customize_Manager) render_panel_templates() {
	mut iter_39 := this.registered_panel_types.iterator()
	for {
		item_39 := iter_39.next() or { break }
		mut var_panel_type := item_39.val
		mut var_panel := rt.create_object_dynamically(var_panel_type, [rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('temp'), rt.new_array()])
		rt.call_method(var_panel, 'print_template', []rt.PhpVal{})
	}
}

fn (mut this Class_WP_Customize_Manager) add_section(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.instance_of(var_id, 'WP_Customize_Section'))) {
	mut var_section := var_id
	} else {
	var_section = create_wp_customize_section(rt.new_object('WP_Customize_Manager', []string{}, &this), var_id.clone(), var_args_mutated.clone())
	}
	this.sections.array_set(rt.get_property(var_section, 'id'), var_section.clone())
	return var_section.clone()
}

fn (mut this Class_WP_Customize_Manager) get_section(var_id rt.PhpVal) rt.PhpVal {
	if this.sections.array_isset(var_id) {
		return this.sections.array_get(var_id)
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_section(var_id rt.PhpVal) {
	this.sections.array_unset(var_id)
}

fn (mut this Class_WP_Customize_Manager) register_section_type(var_section rt.PhpVal) {
	mut var_section_mutated := var_section
	this.registered_section_types.array_push(var_section_mutated.clone())
}

fn (mut this Class_WP_Customize_Manager) render_section_templates() {
	mut iter_40 := this.registered_section_types.iterator()
	for {
		item_40 := iter_40.next() or { break }
		mut var_section_type := item_40.val
		mut var_section := rt.create_object_dynamically(var_section_type, [rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('temp'), rt.new_array()])
		rt.call_method(var_section, 'print_template', []rt.PhpVal{})
	}
}

fn (mut this Class_WP_Customize_Manager) add_control(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.instance_of(var_id, 'WP_Customize_Control'))) {
	mut var_control := var_id
	} else {
	var_control = create_wp_customize_control(rt.new_object('WP_Customize_Manager', []string{}, &this), var_id.clone(), var_args_mutated.clone())
	}
	this.controls.array_set(rt.get_property(var_control, 'id'), var_control.clone())
	return var_control.clone()
}

fn (mut this Class_WP_Customize_Manager) get_control(var_id rt.PhpVal) rt.PhpVal {
	if this.controls.array_isset(var_id) {
		return this.controls.array_get(var_id)
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) remove_control(var_id rt.PhpVal) {
	this.controls.array_unset(var_id)
}

fn (mut this Class_WP_Customize_Manager) register_control_type(var_control rt.PhpVal) {
	mut var_control_mutated := var_control
	this.registered_control_types.array_push(var_control_mutated.clone())
}

fn (mut this Class_WP_Customize_Manager) render_control_templates() {
	if rt.is_true(this.branching()) {
	mut var_l10n := { 'locked': rt.call_function('__', [rt.new_string('%s is already customizing this changeset. Please wait until they are done to try customizing. Your latest changes have been autosaved.')]), 'locked_allow_override': rt.call_function('__', [rt.new_string('%s is already customizing this changeset. Do you want to take over?')]) }
	} else {
	var_l10n = { 'locked': rt.call_function('__', [rt.new_string('%s is already customizing this site. Please wait until they are done to try customizing. Your latest changes have been autosaved.')]), 'locked_allow_override': rt.call_function('__', [rt.new_string('%s is already customizing this site. Do you want to take over?')]) }
	}
	mut iter_41 := this.registered_control_types.iterator()
	for {
		item_41 := iter_41.next() or { break }
		mut var_control_type := item_41.val
		mut var_control := rt.create_object_dynamically(var_control_type, [rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('temp'), rt.create_array([rt.ArrayItem{ key: 'settings', val: rt.new_array() }])])
		rt.call_method(var_control, 'print_template', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Dismiss')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [var_l10n['locked_allow_override'], rt.new_string('{{ data.lockUser.name }}')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [rt.call_function('sprintf', [var_l10n['locked'], rt.new_string('{{ data.lockUser.name }}')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Go back')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html_x', [rt.new_string('Preview'), rt.new_string('verb')]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Take over')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Update anyway, even though it might break your site?')])
	// unsupported statement: Stmt_InlineHTML
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Share Preview Link')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('See how changes would look live on your website, and share the preview with people who can\'t access the Customizer.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Preview Link')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('(opens in a new tab)')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copy')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Copied')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Copy')])
	// unsupported statement: Stmt_InlineHTML
}

fn (mut this Class_WP_Customize_Manager) _cmp_priority(var_a rt.PhpVal, var_b rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0'), rt.new_string('wp_list_sort')])
	if rt.is_true(rt.identical(rt.get_property(var_a, 'priority'), rt.get_property(var_b, 'priority'))) {
		return rt.sub(rt.get_property(var_a, 'instance_number'), rt.get_property(var_b, 'instance_number'))
	} else {
		return rt.sub(rt.get_property(var_a, 'priority'), rt.get_property(var_b, 'priority'))
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Manager) prepare_controls() {
	mut var_controls := rt.new_array()
	this.controls = rt.call_function('wp_list_sort', [this.controls, rt.create_array([rt.ArrayItem{ key: 'priority', val: 'ASC' }, rt.ArrayItem{ key: 'instance_number', val: 'ASC' }]), rt.new_string('ASC'), rt.new_bool(true)])
	mut iter_42 := this.controls.iterator()
	for {
		item_42 := iter_42.next() or { break }
		mut var_control := item_42.val
		mut var_id := item_42.key
		if !(this.sections.array_isset(rt.get_property(var_control, 'section'))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_control, 'check_capabilities', []rt.PhpVal{}))))) {
			continue
		}
		rt.get_property(this.sections.array_get(rt.get_property(var_control, 'section')), 'controls').array_push(var_control.clone())
		var_controls.array_set(var_id, var_control.clone())
	}
	this.controls = var_controls.clone()
	this.sections = rt.call_function('wp_list_sort', [this.sections, rt.create_array([rt.ArrayItem{ key: 'priority', val: 'ASC' }, rt.ArrayItem{ key: 'instance_number', val: 'ASC' }]), rt.new_string('ASC'), rt.new_bool(true)])
	mut var_sections := rt.new_array()
	mut iter_43 := this.sections.iterator()
	for {
		item_43 := iter_43.next() or { break }
		mut var_section := item_43.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_section, 'check_capabilities', []rt.PhpVal{}))))) {
			continue
		}
		rt.set_property(var_section, 'controls', rt.call_function('wp_list_sort', [rt.get_property(var_section, 'controls'), rt.create_array([rt.ArrayItem{ key: 'priority', val: 'ASC' }, rt.ArrayItem{ key: 'instance_number', val: 'ASC' }])]))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_section, 'panel'))))) {
			var_sections.array_set(rt.get_property(var_section, 'id'), var_section.clone())
		} else {
			if this.panels.array_isset(rt.get_property(var_section, 'panel')) {
				rt.get_property(this.panels.array_get(rt.get_property(var_section, 'panel')), 'sections').array_set(rt.get_property(var_section, 'id'), var_section.clone())
			}
		}
	}
	this.sections = var_sections.clone()
	this.panels = rt.call_function('wp_list_sort', [this.panels, rt.create_array([rt.ArrayItem{ key: 'priority', val: 'ASC' }, rt.ArrayItem{ key: 'instance_number', val: 'ASC' }]), rt.new_string('ASC'), rt.new_bool(true)])
	mut var_panels := rt.new_array()
	mut iter_44 := this.panels.iterator()
	for {
		item_44 := iter_44.next() or { break }
		mut var_panel := item_44.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_panel, 'check_capabilities', []rt.PhpVal{}))))) {
			continue
		}
		rt.set_property(var_panel, 'sections', rt.call_function('wp_list_sort', [rt.get_property(var_panel, 'sections'), rt.create_array([rt.ArrayItem{ key: 'priority', val: 'ASC' }, rt.ArrayItem{ key: 'instance_number', val: 'ASC' }]), rt.new_string('ASC'), rt.new_bool(true)]))
		var_panels.array_set(rt.get_property(var_panel, 'id'), var_panel.clone())
	}
	this.panels = var_panels.clone()
	this.containers = rt.call_function('array_merge', [this.panels, this.sections])
	this.containers = rt.call_function('wp_list_sort', [this.containers, rt.create_array([rt.ArrayItem{ key: 'priority', val: 'ASC' }, rt.ArrayItem{ key: 'instance_number', val: 'ASC' }]), rt.new_string('ASC'), rt.new_bool(true)])
}

fn (mut this Class_WP_Customize_Manager) enqueue_control_scripts() {
	mut iter_45 := this.controls.iterator()
	for {
		item_45 := iter_45.next() or { break }
		mut var_control := item_45.val
		rt.call_method(var_control, 'enqueue', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) && rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('update_themes')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('delete_themes')])) {
		rt.call_function('wp_enqueue_script', [rt.new_string('updates')])
		rt.call_function('wp_localize_script', [rt.new_string('updates'), rt.new_string('_wpUpdatesItemCounts'), rt.create_array([rt.ArrayItem{ key: 'totals', val: rt.call_function('wp_get_update_data', []rt.PhpVal{}) }])])
	}
}

fn (mut this Class_WP_Customize_Manager) is_ios() bool {
	return rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/iPad|iPod|iPhone/'), rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_USER_AGENT'))]))
}

fn (mut this Class_WP_Customize_Manager) get_document_title_template() rt.PhpVal {
	if rt.is_true(this.is_theme_active()) {
	mut var_document_title_tmpl := rt.call_function('__', [rt.new_string('Customize: %s')])
	} else {
	var_document_title_tmpl = rt.call_function('__', [rt.new_string('Live Preview: %s')])
	}
	var_document_title_tmpl = rt.call_function('html_entity_decode', [var_document_title_tmpl.clone(), rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])
	return var_document_title_tmpl.clone()
}

fn (mut this Class_WP_Customize_Manager) set_preview_url(var_preview_url rt.PhpVal) {
	mut var_preview_url_mutated := var_preview_url
	var_preview_url_mutated = rt.call_function('sanitize_url', [var_preview_url_mutated.clone()])
	this.preview_url = rt.call_function('wp_validate_redirect', [var_preview_url_mutated.clone(), rt.call_function('home_url', [rt.new_string('/')])])
}

fn (mut this Class_WP_Customize_Manager) get_preview_url() rt.PhpVal {
	if !rt.is_true(this.preview_url) {
	mut var_preview_url := rt.call_function('home_url', [rt.new_string('/')])
	} else {
	var_preview_url = this.preview_url
	}
	return var_preview_url.clone()
}

fn (mut this Class_WP_Customize_Manager) is_cross_domain() rt.PhpVal {
	mut var_admin_origin := rt.call_function('wp_parse_url', [rt.call_function('admin_url', []rt.PhpVal{})])
	mut var_home_origin := rt.call_function('wp_parse_url', [rt.call_function('home_url', []rt.PhpVal{})])
	mut var_cross_domain := rt.new_bool(var_admin_origin.array_get(rt.new_string('host')).to_string().to_lower() != var_home_origin.array_get(rt.new_string('host')).to_string().to_lower())
	return var_cross_domain.clone()
}

fn (mut this Class_WP_Customize_Manager) get_allowed_urls() rt.PhpVal {
	mut var_allowed_urls := rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('home_url', [rt.new_string('/')]) }])
	if rt.is_true(rt.call_function('is_ssl', []rt.PhpVal{})) && rt.is_true(rt.new_bool(!(rt.is_true(this.is_cross_domain())))) {
		var_allowed_urls.array_push(rt.call_function('home_url', [rt.new_string('/'), rt.new_string('https')]))
	}
	var_allowed_urls = rt.call_function('array_unique', [rt.call_function('apply_filters', [rt.new_string('customize_allowed_urls'), var_allowed_urls.clone()])])
	return var_allowed_urls.clone()
}

fn (mut this Class_WP_Customize_Manager) get_messenger_channel() rt.PhpVal {
	return this.messenger_channel
}

fn (mut this Class_WP_Customize_Manager) set_return_url(var_return_url rt.PhpVal) {
	mut var_return_url_mutated := var_return_url
	var_return_url_mutated = rt.call_function('sanitize_url', [var_return_url_mutated.clone()])
	var_return_url_mutated = rt.call_function('remove_query_arg', [rt.call_function('wp_removable_query_args', []rt.PhpVal{}), var_return_url_mutated.clone()])
	var_return_url_mutated = rt.call_function('wp_validate_redirect', [var_return_url_mutated.clone()])
	this.return_url = var_return_url_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) get_return_url() rt.PhpVal {
	mut var__registered_pages := rt.new_null()
	mut var_query_vars := rt.new_null()
	mut var_referer := rt.call_function('wp_get_referer', []rt.PhpVal{})
	mut var_excluded_referer_basenames := ['customize.php', 'wp-login.php']
	if rt.is_true(this.return_url) {
		mut var_return_url := this.return_url
		mut var_return_url_basename := rt.call_function('wp_basename', [rt.call_function('parse_url', [this.return_url, rt.get_constant('PHP_URL_PATH')])])
		mut var_return_url_query := rt.call_function('parse_url', [this.return_url, rt.get_constant('PHP_URL_QUERY')])
		if rt.is_true(rt.identical(rt.new_string('themes.php'), var_return_url_basename)) && rt.is_true(var_return_url_query) {
			rt.call_function('parse_str', [var_return_url_query.clone(), var_query_vars.clone()])
			if var_query_vars.array_isset(rt.new_string('page')) && !(var__registered_pages.array_isset(rt.concat(rt.new_string('appearance_page_'), var_query_vars.array_get(rt.new_string('page'))))) {
			var_return_url = rt.call_function('admin_url', [rt.new_string('themes.php')])
			}
		}
	} else if rt.is_true(var_referer) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.call_function('wp_basename', [rt.call_function('parse_url', [var_referer.clone(), rt.get_constant('PHP_URL_PATH')])]), rt.create_array_from_list(var_excluded_referer_basenames), rt.new_bool(true)]))))) {
	var_return_url = var_referer.clone()
	} else if rt.is_true(this.preview_url) {
	var_return_url = this.preview_url
	} else {
	var_return_url = rt.call_function('home_url', [rt.new_string('/')])
	}
	return var_return_url.clone()
}

fn (mut this Class_WP_Customize_Manager) set_autofocus(var_autofocus rt.PhpVal) {
	this.autofocus = rt.call_function('array_filter', [rt.call_function('wp_array_slice_assoc', [var_autofocus.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'panel' }, rt.ArrayItem{ key: none, val: 'section' }, rt.ArrayItem{ key: none, val: 'control' }])]), rt.new_string('is_string')])
}

fn (mut this Class_WP_Customize_Manager) get_autofocus() rt.PhpVal {
	return this.autofocus
}

fn (mut this Class_WP_Customize_Manager) get_nonces() rt.PhpVal {
	mut var_nonces := rt.create_array([rt.ArrayItem{ key: 'save', val: rt.call_function('wp_create_nonce', [rt.new_string('save-customize_' + (this.get_stylesheet()).str())]) }, rt.ArrayItem{ key: 'preview', val: rt.call_function('wp_create_nonce', [rt.new_string('preview-customize_' + (this.get_stylesheet()).str())]) }, rt.ArrayItem{ key: 'switch_themes', val: rt.call_function('wp_create_nonce', [rt.new_string('switch_themes')]) }, rt.ArrayItem{ key: 'dismiss_autosave_or_lock', val: rt.call_function('wp_create_nonce', [rt.new_string('customize_dismiss_autosave_or_lock')]) }, rt.ArrayItem{ key: 'override_lock', val: rt.call_function('wp_create_nonce', [rt.new_string('customize_override_changeset_lock')]) }, rt.ArrayItem{ key: 'trash', val: rt.call_function('wp_create_nonce', [rt.new_string('trash_customize_changeset')]) }])
	var_nonces = rt.call_function('apply_filters', [rt.new_string('customize_refresh_nonces'), var_nonces.clone(), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	return var_nonces.clone()
}

fn (mut this Class_WP_Customize_Manager) customize_pane_settings() {
	mut var_login_url := rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'interim-login', val: 1 }, rt.ArrayItem{ key: 'customize-login', val: 1 }]), rt.call_function('wp_login_url', []rt.PhpVal{})])
	mut iter_46 := rt.func_array_keys(this.unsanitized_post_values(rt.new_null())).iterator()
	for {
		item_46 := iter_46.next() or { break }
		mut var_setting_id := item_46.val
		mut var_setting := this.get_setting(var_setting_id.clone())
		if rt.is_true(var_setting) {
			rt.set_property(var_setting, 'dirty', rt.new_bool(true))
		}
	}
	mut var_autosave_revision_post := rt.new_null()
	mut var_autosave_autodraft_post := rt.new_null()
	mut var_changeset_post_id := this.changeset_post_id()
	if !(this.saved_starter_content_changeset) && rt.is_true(rt.new_bool(!(rt.is_true(this.autosaved())))) {
		if rt.is_true(var_changeset_post_id) {
			if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
			var_autosave_revision_post = rt.call_function('wp_get_post_autosave', [var_changeset_post_id.clone(), rt.call_function('get_current_user_id', []rt.PhpVal{})])
			}
		} else {
			mut var_autosave_autodraft_posts := this.get_changeset_posts(rt.create_array([rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'post_status', val: 'auto-draft' }, rt.ArrayItem{ key: 'exclude_restore_dismissed', val: true }]))
			if !(!rt.is_true(var_autosave_autodraft_posts)) {
			var_autosave_autodraft_post = rt.call_function('array_shift', [var_autosave_autodraft_posts.clone()])
			}
		}
	}
	mut var_current_user_can_publish := rt.call_function('current_user_can', [rt.get_property(rt.get_property(rt.call_function('get_post_type_object', [rt.new_string('customize_changeset')]), 'cap'), 'publish_posts')])
	mut var_status_choices := rt.new_array()
	if rt.is_true(var_current_user_can_publish) {
		var_status_choices << rt.create_array([rt.ArrayItem{ key: 'status', val: 'publish' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Publish')]) }])
	}
	var_status_choices << rt.create_array([rt.ArrayItem{ key: 'status', val: 'draft' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Save Draft')]) }])
	if rt.is_true(var_current_user_can_publish) {
		var_status_choices << rt.create_array([rt.ArrayItem{ key: 'status', val: 'future' }, rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Schedule'), rt.new_string('customizer changeset action/button label')]) }])
	}
	mut var_changeset_post := rt.new_null()
	if rt.is_true(var_changeset_post_id) {
	var_changeset_post = rt.call_function('get_post', [var_changeset_post_id.clone()])
	}
	mut var_current_time := rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(false)])
	mut var_initial_date := var_current_time.clone()
	if rt.is_true(var_changeset_post) {
		var_initial_date = rt.call_function('get_the_time', [rt.new_string('Y-m-d H:i:s'), rt.get_property(var_changeset_post, 'ID')])
		if rt.is_true(rt.less(var_initial_date, var_current_time)) {
		var_initial_date = var_current_time.clone()
		}
	}
	mut var_lock_user_id := rt.new_bool(false)
	if rt.is_true(this.changeset_post_id()) {
	var_lock_user_id = rt.call_function('wp_check_post_lock', [this.changeset_post_id()])
	}
	mut var_settings := rt.create_array([rt.ArrayItem{ key: 'changeset', val: rt.create_array([rt.ArrayItem{ key: 'uuid', val: this.changeset_uuid() }, rt.ArrayItem{ key: 'branching', val: this.branching() }, rt.ArrayItem{ key: 'autosaved', val: this.autosaved() }, rt.ArrayItem{ key: 'hasAutosaveRevision', val: !(!rt.is_true(var_autosave_revision_post)) }, rt.ArrayItem{ key: 'latestAutoDraftUuid', val: if rt.is_true(var_autosave_autodraft_post) { rt.get_property(var_autosave_autodraft_post, 'post_name') } else { rt.new_null() } }, rt.ArrayItem{ key: 'status', val: if rt.is_true(var_changeset_post) { rt.get_property(var_changeset_post, 'post_status') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'currentUserCanPublish', val: var_current_user_can_publish }, rt.ArrayItem{ key: 'publishDate', val: var_initial_date }, rt.ArrayItem{ key: 'statusChoices', val: var_status_choices }, rt.ArrayItem{ key: 'lockUser', val: if rt.is_true(var_lock_user_id) { this.get_lock_user_data(var_lock_user_id.clone()) } else { rt.new_null() } }]) }, rt.ArrayItem{ key: 'initialServerDate', val: var_current_time }, rt.ArrayItem{ key: 'dateFormat', val: rt.call_function('get_option', [rt.new_string('date_format')]) }, rt.ArrayItem{ key: 'timeFormat', val: rt.call_function('get_option', [rt.new_string('time_format')]) }, rt.ArrayItem{ key: 'initialServerTimestamp', val: rt.call_function('floor', [rt.mul(rt.call_function('microtime', [rt.new_bool(true)]), rt.new_int(1000))]) }, rt.ArrayItem{ key: 'initialClientTimestamp', val: -1 }, rt.ArrayItem{ key: 'timeouts', val: rt.create_array([rt.ArrayItem{ key: 'windowRefresh', val: 250 }, rt.ArrayItem{ key: 'changesetAutoSave', val: rt.mul(rt.get_constant('AUTOSAVE_INTERVAL'), rt.new_int(1000)) }, rt.ArrayItem{ key: 'keepAliveCheck', val: 2500 }, rt.ArrayItem{ key: 'reflowPaneContents', val: 100 }, rt.ArrayItem{ key: 'previewFrameSensitivity', val: 2000 }]) }, rt.ArrayItem{ key: 'theme', val: rt.create_array([rt.ArrayItem{ key: 'stylesheet', val: this.get_stylesheet() }, rt.ArrayItem{ key: 'active', val: this.is_theme_active() }, rt.ArrayItem{ key: '_canInstall', val: rt.call_function('current_user_can', [rt.new_string('install_themes')]) }]) }, rt.ArrayItem{ key: 'url', val: rt.create_array([rt.ArrayItem{ key: 'preview', val: rt.call_function('sanitize_url', [this.get_preview_url()]) }, rt.ArrayItem{ key: 'return', val: rt.call_function('sanitize_url', [this.get_return_url()]) }, rt.ArrayItem{ key: 'parent', val: rt.call_function('sanitize_url', [rt.call_function('admin_url', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'activated', val: rt.call_function('sanitize_url', [rt.call_function('home_url', [rt.new_string('/')])]) }, rt.ArrayItem{ key: 'ajax', val: rt.call_function('sanitize_url', [rt.call_function('admin_url', [rt.new_string('admin-ajax.php'), rt.new_string('relative')])]) }, rt.ArrayItem{ key: 'allowed', val: rt.call_function('array_map', [rt.new_string('sanitize_url'), this.get_allowed_urls()]) }, rt.ArrayItem{ key: 'isCrossDomain', val: this.is_cross_domain() }, rt.ArrayItem{ key: 'home', val: rt.call_function('sanitize_url', [rt.call_function('home_url', [rt.new_string('/')])]) }, rt.ArrayItem{ key: 'login', val: rt.call_function('sanitize_url', [var_login_url.clone()]) }]) }, rt.ArrayItem{ key: 'browser', val: rt.create_array([rt.ArrayItem{ key: 'mobile', val: rt.call_function('wp_is_mobile', []rt.PhpVal{}) }, rt.ArrayItem{ key: 'ios', val: this.is_ios() }]) }, rt.ArrayItem{ key: 'panels', val: rt.new_array() }, rt.ArrayItem{ key: 'sections', val: rt.new_array() }, rt.ArrayItem{ key: 'nonce', val: this.get_nonces() }, rt.ArrayItem{ key: 'autofocus', val: this.get_autofocus() }, rt.ArrayItem{ key: 'documentTitleTmpl', val: this.get_document_title_template() }, rt.ArrayItem{ key: 'previewableDevices', val: this.get_previewable_devices() }, rt.ArrayItem{ key: 'l10n', val: rt.create_array([rt.ArrayItem{ key: 'confirmDeleteTheme', val: rt.call_function('__', [rt.new_string('Are you sure you want to delete this theme?')]) }, rt.ArrayItem{ key: 'themeSearchResults', val: rt.call_function('__', [rt.new_string('%d themes found')]) }, rt.ArrayItem{ key: 'announceThemeCount', val: rt.call_function('__', [rt.new_string('Displaying %d themes')]) }, rt.ArrayItem{ key: 'announceThemeDetails', val: rt.call_function('__', [rt.new_string('Showing details for theme: %s')]) }]) }])
	mut var_filesystem_method := rt.call_function('get_filesystem_method', []rt.PhpVal{})
	rt.call_function('ob_start', []rt.PhpVal{})
	mut var_filesystem_credentials_are_stored := rt.call_function('request_filesystem_credentials', [rt.call_function('self_admin_url', []rt.PhpVal{})])
	rt.call_function('ob_end_clean', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('direct'), var_filesystem_method)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_filesystem_credentials_are_stored)))) {
		var_settings.array_get_mut('theme').array_set('_filesystemCredentialsNeeded', true)
	}
	mut iter_47 := this.sections().iterator()
	for {
		item_47 := iter_47.next() or { break }
		mut var_section := item_47.val
		mut var_id := item_47.key
		if rt.is_true(rt.call_method(var_section, 'check_capabilities', []rt.PhpVal{})) {
			var_settings.array_get_mut('sections').array_set(var_id, rt.call_method(var_section, 'json', []rt.PhpVal{}))
		}
	}
	mut iter_48 := this.panels().iterator()
	for {
		item_48 := iter_48.next() or { break }
		mut var_panel := item_48.val
		mut var_panel_id := item_48.key
		if rt.is_true(rt.call_method(var_panel, 'check_capabilities', []rt.PhpVal{})) {
			var_settings.array_get_mut('panels').array_set(var_panel_id, rt.call_method(var_panel, 'json', []rt.PhpVal{}))
			mut iter_49 := rt.get_property(var_panel, 'sections').iterator()
			for {
				item_49 := iter_49.next() or { break }
				mut var_section := item_49.val
				mut var_section_id := item_49.key
				if rt.is_true(rt.call_method(var_section, 'check_capabilities', []rt.PhpVal{})) {
					var_settings.array_get_mut('sections').array_set(var_section_id, rt.call_method(var_section, 'json', []rt.PhpVal{}))
				}
			}
		}
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [var_settings.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]))
	// unsupported statement: Stmt_InlineHTML
	print('(function ( s ){\n')
	mut iter_50 := this.settings().iterator()
	for {
		item_50 := iter_50.next() or { break }
		mut var_setting := item_50.val
		if rt.is_true(rt.call_method(var_setting, 'check_capabilities', []rt.PhpVal{})) {
			rt.call_function('printf', [rt.new_string('s[%s] = %s;\n'), rt.call_function('wp_json_encode', [rt.get_property(var_setting, 'id'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [rt.call_method(var_setting, 'json', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])
		}
	}
	print('})( _wpCustomizeSettings.settings );\n')
	print('(function ( c ){\n')
	mut iter_51 := this.controls().iterator()
	for {
		item_51 := iter_51.next() or { break }
		mut var_control := item_51.val
		if rt.is_true(rt.call_method(var_control, 'check_capabilities', []rt.PhpVal{})) {
			rt.call_function('printf', [rt.new_string('c[%s] = %s;\n'), rt.call_function('wp_json_encode', [rt.get_property(var_control, 'id'), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))]), rt.call_function('wp_json_encode', [rt.call_method(var_control, 'json', []rt.PhpVal{}), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])
		}
	}
	print('})( _wpCustomizeSettings.controls );\n')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_print_inline_script_tag', [rt.new_string((rt.call_function('wp_remove_surrounding_empty_script_tags', [rt.call_function('ob_get_clean', []rt.PhpVal{})])).str() + '\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@METHOD)])).str())])
}

fn (mut this Class_WP_Customize_Manager) get_previewable_devices() rt.PhpVal {
	mut var_devices := rt.create_array([rt.ArrayItem{ key: 'desktop', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enter desktop preview mode')]) }, rt.ArrayItem{ key: 'default', val: true }]) }, rt.ArrayItem{ key: 'tablet', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enter tablet preview mode')]) }]) }, rt.ArrayItem{ key: 'mobile', val: rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Enter mobile preview mode')]) }]) }])
	var_devices = rt.call_function('apply_filters', [rt.new_string('customize_previewable_devices'), var_devices.clone()])
	return var_devices.clone()
}

fn (mut this Class_WP_Customize_Manager) register_controls() {
	this.add_panel(create_wp_customize_themes_panel(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('themes'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_method(this.theme(), 'display', [rt.new_string('Name')]) }, rt.ArrayItem{ key: 'description', val: '<p>' + (rt.call_function('__', [rt.new_string('Looking for a theme? You can search or browse the WordPress.org theme directory, install and preview themes, then activate them right here.')])).str() + '</p>' + '<p>' + (rt.call_function('__', [rt.new_string('While previewing a new theme, you can continue to tailor things like widgets and menus, and explore theme-specific options.')])).str() + '</p>' }, rt.ArrayItem{ key: 'capability', val: 'switch_themes' }, rt.ArrayItem{ key: 'priority', val: 0 }])), rt.new_null())
	this.add_section(create_wp_customize_themes_section(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('installed_themes'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Installed themes')]) }, rt.ArrayItem{ key: 'action', val: 'installed' }, rt.ArrayItem{ key: 'capability', val: 'switch_themes' }, rt.ArrayItem{ key: 'panel', val: 'themes' }, rt.ArrayItem{ key: 'priority', val: 0 }])), rt.new_null())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		this.add_section(create_wp_customize_themes_section(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('wporg_themes'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('WordPress.org themes')]) }, rt.ArrayItem{ key: 'action', val: 'wporg' }, rt.ArrayItem{ key: 'filter_type', val: 'remote' }, rt.ArrayItem{ key: 'capability', val: 'install_themes' }, rt.ArrayItem{ key: 'panel', val: 'themes' }, rt.ArrayItem{ key: 'priority', val: 5 }])), rt.new_null())
	}
	this.add_setting(create_wp_customize_filter_setting(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('active_theme'), rt.create_array([rt.ArrayItem{ key: 'capability', val: 'switch_themes' }])), rt.new_null())
	this.add_section(rt.new_string('title_tagline'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Site Identity')]) }, rt.ArrayItem{ key: 'priority', val: 20 }]))
	this.add_setting(rt.new_string('blogname'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_option', [rt.new_string('blogname')]) }, rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{ key: 'capability', val: 'manage_options' }]))
	this.add_control(rt.new_string('blogname'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Site Title')]) }, rt.ArrayItem{ key: 'section', val: 'title_tagline' }]))
	this.add_setting(rt.new_string('blogdescription'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_option', [rt.new_string('blogdescription')]) }, rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{ key: 'capability', val: 'manage_options' }]))
	this.add_control(rt.new_string('blogdescription'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Tagline')]) }, rt.ArrayItem{ key: 'section', val: 'title_tagline' }]))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('header-text')]))))) {
		this.add_setting(rt.new_string('header_text'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom-logo' }, rt.ArrayItem{ key: none, val: 'header-text' }]) }, rt.ArrayItem{ key: 'default', val: 1 }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }]))
		this.add_control(rt.new_string('header_text'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Display Site Title and Tagline')]) }, rt.ArrayItem{ key: 'section', val: 'title_tagline' }, rt.ArrayItem{ key: 'settings', val: 'header_text' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }]))
	}
	this.add_setting(rt.new_string('site_icon'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{ key: 'capability', val: 'manage_options' }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }]))
	this.add_control(create_wp_customize_site_icon_control(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('site_icon'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Site Icon')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('sprintf', [rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('The Site Icon is what you see in browser tabs, bookmark bars, and within the WordPress mobile apps. It should be square and at least <code>%1$s by %2$s</code> pixels.')])).str() + '</p>'), rt.new_int(512), rt.new_int(512)]) }, rt.ArrayItem{ key: 'section', val: 'title_tagline' }, rt.ArrayItem{ key: 'priority', val: 60 }, rt.ArrayItem{ key: 'height', val: 512 }, rt.ArrayItem{ key: 'width', val: 512 }])), rt.new_null())
	this.add_setting(rt.new_string('custom_logo'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom-logo' }]) }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }]))
	mut var_custom_logo_args := rt.call_function('get_theme_support', [rt.new_string('custom-logo')])
	this.add_control(create_wp_customize_cropped_image_control(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('custom_logo'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Logo')]) }, rt.ArrayItem{ key: 'section', val: 'title_tagline' }, rt.ArrayItem{ key: 'priority', val: 8 }, rt.ArrayItem{ key: 'height', val: if !(var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('height'))).is_null() { var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('height')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'width', val: if !(var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('width'))).is_null() { var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('width')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'flex_height', val: if !(var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('flex-height'))).is_null() { var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('flex-height')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'flex_width', val: if !(var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('flex-width'))).is_null() { var_custom_logo_args.array_get(rt.new_int(0)).array_get(rt.new_string('flex-width')) } else { rt.new_null() } }, rt.ArrayItem{ key: 'button_labels', val: rt.create_array([rt.ArrayItem{ key: 'select', val: rt.call_function('__', [rt.new_string('Select logo')]) }, rt.ArrayItem{ key: 'change', val: rt.call_function('__', [rt.new_string('Change logo')]) }, rt.ArrayItem{ key: 'remove', val: rt.call_function('__', [rt.new_string('Remove')]) }, rt.ArrayItem{ key: 'default', val: rt.call_function('__', [rt.new_string('Default')]) }, rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [rt.new_string('No logo selected')]) }, rt.ArrayItem{ key: 'frame_title', val: rt.call_function('__', [rt.new_string('Select logo')]) }, rt.ArrayItem{ key: 'frame_button', val: rt.call_function('__', [rt.new_string('Choose logo')]) }]) }])), rt.new_null())
	rt.call_method(this.selective_refresh, 'add_partial', [rt.new_string('custom_logo'), rt.create_array([rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom_logo' }]) }, rt.ArrayItem{ key: 'selector', val: '.custom-logo-link' }, rt.ArrayItem{ key: 'render_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_render_custom_logo_partial' }]) }, rt.ArrayItem{ key: 'container_inclusive', val: true }])])
	this.add_section(rt.new_string('colors'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Colors')]) }, rt.ArrayItem{ key: 'priority', val: 40 }]))
	this.add_setting(rt.new_string('header_textcolor'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom-header' }, rt.ArrayItem{ key: none, val: 'header-text' }]) }, rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('default-text-color')]) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_header_textcolor' }]) }, rt.ArrayItem{ key: 'sanitize_js_callback', val: 'maybe_hash_hex_color' }]))
	this.add_control(rt.new_string('display_header_text'), rt.create_array([rt.ArrayItem{ key: 'settings', val: 'header_textcolor' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Display Site Title and Tagline')]) }, rt.ArrayItem{ key: 'section', val: 'title_tagline' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }, rt.ArrayItem{ key: 'priority', val: 40 }]))
	this.add_control(create_wp_customize_color_control(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('header_textcolor'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Header Text Color')]) }, rt.ArrayItem{ key: 'section', val: 'colors' }])), rt.new_null())
	this.add_setting(rt.new_string('background_color'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-color')]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_hex_color_no_hash' }, rt.ArrayItem{ key: 'sanitize_js_callback', val: 'maybe_hash_hex_color' }]))
	this.add_control(create_wp_customize_color_control(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('background_color'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Background Color')]) }, rt.ArrayItem{ key: 'section', val: 'colors' }])), rt.new_null())
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('video')])) {
		mut var_title := rt.call_function('__', [rt.new_string('Header Media')])
		mut var_description := rt.new_string('<p>' + (rt.call_function('__', [rt.new_string('If you add a video, the image will be used as a fallback while the video loads.')])).str() + '</p>')
		mut var_width := rt.call_function('absint', [rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('width')])])
		mut var_height := rt.call_function('absint', [rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('height')])])
		if rt.is_true(var_width) && rt.is_true(var_height) {
		mut var_control_description := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Upload your video in %1$s format and minimize its file size for best results. Your theme recommends dimensions of %2$s pixels.')]), rt.new_string('<code>.mp4</code>'), rt.call_function('sprintf', [rt.new_string('<strong>%s &times; %s</strong>'), var_width.clone(), var_height.clone()])])
		} else if rt.is_true(var_width) {
		var_control_description = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Upload your video in %1$s format and minimize its file size for best results. Your theme recommends a width of %2$s pixels.')]), rt.new_string('<code>.mp4</code>'), rt.call_function('sprintf', [rt.new_string('<strong>%s</strong>'), var_width.clone()])])
		} else {
		var_control_description = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Upload your video in %1$s format and minimize its file size for best results. Your theme recommends a height of %2$s pixels.')]), rt.new_string('<code>.mp4</code>'), rt.call_function('sprintf', [rt.new_string('<strong>%s</strong>'), var_height.clone()])])
		}
	} else {
	var_title = rt.call_function('__', [rt.new_string('Header Image')])
	var_description = rt.new_string('')
	var_control_description = rt.new_string('')
	}
	this.add_section(rt.new_string('header_image'), rt.create_array([rt.ArrayItem{ key: 'title', val: var_title }, rt.ArrayItem{ key: 'description', val: var_description }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-header' }, rt.ArrayItem{ key: 'priority', val: 60 }]))
	this.add_setting(rt.new_string('header_video'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom-header' }, rt.ArrayItem{ key: none, val: 'video' }]) }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }, rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_validate_header_video' }]) }]))
	this.add_setting(rt.new_string('external_header_video'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom-header' }, rt.ArrayItem{ key: none, val: 'video' }]) }, rt.ArrayItem{ key: 'transport', val: 'postMessage' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_external_header_video' }]) }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_validate_external_header_video' }]) }]))
	this.add_setting(create_wp_customize_filter_setting(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('header_image'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('sprintf', [rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('default-image')]), rt.call_function('get_template_directory_uri', []rt.PhpVal{}), rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{})]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-header' }])), rt.new_null())
	this.add_setting(create_wp_customize_header_image_setting(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('header_image_data'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: 'custom-header' }])), rt.new_null())
	if rt.is_true(rt.call_function('current_theme_supports', [rt.new_string('custom-header'), rt.new_string('video')])) {
		rt.set_property(this.get_setting(rt.new_string('header_image')), 'transport', rt.new_string('postMessage'))
		rt.set_property(this.get_setting(rt.new_string('header_image_data')), 'transport', rt.new_string('postMessage'))
	}
	this.add_control(create_wp_customize_media_control(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('header_video'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom-header' }, rt.ArrayItem{ key: none, val: 'video' }]) }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Header Video')]) }, rt.ArrayItem{ key: 'description', val: var_control_description }, rt.ArrayItem{ key: 'section', val: 'header_image' }, rt.ArrayItem{ key: 'mime_type', val: 'video' }, rt.ArrayItem{ key: 'active_callback', val: 'is_header_video_active' }])), rt.new_null())
	this.add_control(rt.new_string('external_header_video'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: none, val: 'custom-header' }, rt.ArrayItem{ key: none, val: 'video' }]) }, rt.ArrayItem{ key: 'type', val: 'url' }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Or, enter a YouTube URL:')]) }, rt.ArrayItem{ key: 'section', val: 'header_image' }, rt.ArrayItem{ key: 'active_callback', val: 'is_header_video_active' }]))
	this.add_control(create_wp_customize_header_image_control(rt.new_object('WP_Customize_Manager', []string{}, &this)), rt.new_null())
	rt.call_method(this.selective_refresh, 'add_partial', [rt.new_string('custom_header'), rt.create_array([rt.ArrayItem{ key: 'selector', val: '#wp-custom-header' }, rt.ArrayItem{ key: 'render_callback', val: 'the_custom_header_markup' }, rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: none, val: 'header_video' }, rt.ArrayItem{ key: none, val: 'external_header_video' }, rt.ArrayItem{ key: none, val: 'header_image' }]) }, rt.ArrayItem{ key: 'container_inclusive', val: true }])])
	this.add_section(rt.new_string('background_image'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Background Image')]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'priority', val: 80 }]))
	this.add_setting(rt.new_string('background_image'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-image')]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }]))
	this.add_setting(create_wp_customize_background_image_setting(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('background_image_thumb'), rt.create_array([rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }])), rt.new_null())
	this.add_control(create_wp_customize_background_image_control(rt.new_object('WP_Customize_Manager', []string{}, &this)), rt.new_null())
	this.add_setting(rt.new_string('background_preset'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-preset')]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }]))
	this.add_control(rt.new_string('background_preset'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('_x', [rt.new_string('Preset'), rt.new_string('Background Preset')]) }, rt.ArrayItem{ key: 'section', val: 'background_image' }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'choices', val: rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('_x', [rt.new_string('Default'), rt.new_string('Default Preset')]) }, rt.ArrayItem{ key: 'fill', val: rt.call_function('__', [rt.new_string('Fill Screen')]) }, rt.ArrayItem{ key: 'fit', val: rt.call_function('__', [rt.new_string('Fit to Screen')]) }, rt.ArrayItem{ key: 'repeat', val: rt.call_function('_x', [rt.new_string('Repeat'), rt.new_string('Repeat Image')]) }, rt.ArrayItem{ key: 'custom', val: rt.call_function('_x', [rt.new_string('Custom'), rt.new_string('Custom Preset')]) }]) }]))
	this.add_setting(rt.new_string('background_position_x'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-position-x')]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }]))
	this.add_setting(rt.new_string('background_position_y'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-position-y')]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }]))
	this.add_control(create_wp_customize_background_position_control(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('background_position'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Image Position')]) }, rt.ArrayItem{ key: 'section', val: 'background_image' }, rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: 'x', val: 'background_position_x' }, rt.ArrayItem{ key: 'y', val: 'background_position_y' }]) }])), rt.new_null())
	this.add_setting(rt.new_string('background_size'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-size')]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }]))
	this.add_control(rt.new_string('background_size'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Image Size')]) }, rt.ArrayItem{ key: 'section', val: 'background_image' }, rt.ArrayItem{ key: 'type', val: 'select' }, rt.ArrayItem{ key: 'choices', val: rt.create_array([rt.ArrayItem{ key: 'auto', val: rt.call_function('_x', [rt.new_string('Original'), rt.new_string('Original Size')]) }, rt.ArrayItem{ key: 'contain', val: rt.call_function('__', [rt.new_string('Fit to Screen')]) }, rt.ArrayItem{ key: 'cover', val: rt.call_function('__', [rt.new_string('Fill Screen')]) }]) }]))
	this.add_setting(rt.new_string('background_repeat'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-repeat')]) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }]))
	this.add_control(rt.new_string('background_repeat'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Repeat Background Image')]) }, rt.ArrayItem{ key: 'section', val: 'background_image' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }]))
	this.add_setting(rt.new_string('background_attachment'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('default-attachment')]) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: '_sanitize_background_setting' }]) }, rt.ArrayItem{ key: 'theme_supports', val: 'custom-background' }]))
	this.add_control(rt.new_string('background_attachment'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Scroll with Page')]) }, rt.ArrayItem{ key: 'section', val: 'background_image' }, rt.ArrayItem{ key: 'type', val: 'checkbox' }]))
	if rt.is_true(rt.identical(rt.call_function('get_theme_support', [rt.new_string('custom-background'), rt.new_string('wp-head-callback')]), rt.new_string('_custom_background_cb'))) {
		mut iter_52 := rt.create_array([rt.ArrayItem{ key: none, val: 'color' }, rt.ArrayItem{ key: none, val: 'image' }, rt.ArrayItem{ key: none, val: 'preset' }, rt.ArrayItem{ key: none, val: 'position_x' }, rt.ArrayItem{ key: none, val: 'position_y' }, rt.ArrayItem{ key: none, val: 'size' }, rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'attachment' }]).iterator()
		for {
			item_52 := iter_52.next() or { break }
			mut var_prop := item_52.val
			rt.set_property(this.get_setting(rt.new_string('background_' + (var_prop).str())), 'transport', rt.new_string('postMessage'))
		}
	}
	this.add_section(rt.new_string('static_front_page'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Homepage Settings')]) }, rt.ArrayItem{ key: 'priority', val: 120 }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('You can choose what&#8217;s displayed on the homepage of your site. It can be posts in reverse chronological order (classic blog), or a fixed/static page. To set a static homepage, you first need to create two Pages. One will become the homepage, and the other will be where your posts are displayed.')]) }, rt.ArrayItem{ key: 'active_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Manager', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'has_published_pages' }]) }]))
	this.add_setting(rt.new_string('show_on_front'), rt.create_array([rt.ArrayItem{ key: 'default', val: rt.call_function('get_option', [rt.new_string('show_on_front')]) }, rt.ArrayItem{ key: 'capability', val: 'manage_options' }, rt.ArrayItem{ key: 'type', val: 'option' }]))
	this.add_control(rt.new_string('show_on_front'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Your homepage displays')]) }, rt.ArrayItem{ key: 'section', val: 'static_front_page' }, rt.ArrayItem{ key: 'type', val: 'radio' }, rt.ArrayItem{ key: 'choices', val: rt.create_array([rt.ArrayItem{ key: 'posts', val: rt.call_function('__', [rt.new_string('Your latest posts')]) }, rt.ArrayItem{ key: 'page', val: rt.call_function('__', [rt.new_string('A static page')]) }]) }]))
	this.add_setting(rt.new_string('page_on_front'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{ key: 'capability', val: 'manage_options' }]))
	this.add_control(rt.new_string('page_on_front'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Homepage')]) }, rt.ArrayItem{ key: 'section', val: 'static_front_page' }, rt.ArrayItem{ key: 'type', val: 'dropdown-pages' }, rt.ArrayItem{ key: 'allow_addition', val: true }]))
	this.add_setting(rt.new_string('page_for_posts'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'option' }, rt.ArrayItem{ key: 'capability', val: 'manage_options' }]))
	this.add_control(rt.new_string('page_for_posts'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Posts page')]) }, rt.ArrayItem{ key: 'section', val: 'static_front_page' }, rt.ArrayItem{ key: 'type', val: 'dropdown-pages' }, rt.ArrayItem{ key: 'allow_addition', val: true }]))
	mut var_section_description := rt.new_string('<p>')
	var_section_description = rt.concat(var_section_description, rt.call_function('__', [rt.new_string('Add your own CSS code here to customize the appearance and layout of your site.')]))
	var_section_description = rt.concat(var_section_description, rt.call_function('sprintf', [rt.new_string(' <a href="%1$s" class="external-link" target="_blank">%2$s<span class="screen-reader-text"> %3$s</span></a>'), rt.call_function('esc_url', [rt.call_function('__', [rt.new_string('https://developer.wordpress.org/advanced-administration/wordpress/css/')])]), rt.call_function('__', [rt.new_string('Learn more about CSS')]), rt.call_function('__', [rt.new_string('(opens in a new tab)')])]))
	var_section_description = rt.concat(var_section_description, rt.new_string('</p>'))
	var_section_description = rt.concat(var_section_description, rt.new_string('<p id="editor-keyboard-trap-help-1">' + (rt.call_function('__', [rt.new_string('When using a keyboard to navigate:')])).str() + '</p>'))
	var_section_description = rt.concat(var_section_description, rt.new_string('<ul>'))
	var_section_description = rt.concat(var_section_description, rt.new_string('<li id="editor-keyboard-trap-help-2">' + (rt.call_function('__', [rt.new_string('In the editing area, the Tab key enters a tab character.')])).str() + '</li>'))
	var_section_description = rt.concat(var_section_description, rt.new_string('<li id="editor-keyboard-trap-help-3">' + (rt.call_function('__', [rt.new_string('To move away from this area, press the Esc key followed by the Tab key.')])).str() + '</li>'))
	var_section_description = rt.concat(var_section_description, rt.new_string('<li id="editor-keyboard-trap-help-4">' + (rt.call_function('__', [rt.new_string('Screen reader users: when in forms mode, you may need to press the Esc key twice.')])).str() + '</li>'))
	var_section_description = rt.concat(var_section_description, rt.new_string('</ul>'))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('false'), rt.get_property(rt.call_function('wp_get_current_user', []rt.PhpVal{}), 'syntax_highlighting'))))) {
		var_section_description = rt.concat(var_section_description, rt.new_string('<p>'))
		var_section_description = rt.concat(var_section_description, rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('The edit field automatically highlights code syntax. You can disable this in your <a href="%1$s" %2$s>user profile%3$s</a> to work in plain text mode.')]), rt.call_function('esc_url', [rt.call_function('get_edit_profile_url', []rt.PhpVal{})]), rt.new_string('class="external-link" target="_blank"'), rt.call_function('sprintf', [rt.new_string('<span class="screen-reader-text"> %s</span>'), rt.call_function('__', [rt.new_string('(opens in a new tab)')])])]))
		var_section_description = rt.concat(var_section_description, rt.new_string('</p>'))
	}
	var_section_description = rt.concat(var_section_description, rt.new_string('<p class="section-description-buttons">'))
	var_section_description = rt.concat(var_section_description, rt.new_string('<button type="button" class="button-link section-description-close">' + (rt.call_function('__', [rt.new_string('Close')])).str() + '</button>'))
	var_section_description = rt.concat(var_section_description, rt.new_string('</p>'))
	this.add_section(rt.new_string('custom_css'), rt.create_array([rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Additional CSS')]) }, rt.ArrayItem{ key: 'priority', val: 200 }, rt.ArrayItem{ key: 'description_hidden', val: true }, rt.ArrayItem{ key: 'description', val: var_section_description }]))
	mut var_custom_css_setting := create_wp_customize_custom_css_setting(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.call_function('sprintf', [rt.new_string('custom_css[%s]'), rt.call_function('get_stylesheet', []rt.PhpVal{})]), rt.create_array([rt.ArrayItem{ key: 'capability', val: 'edit_css' }, rt.ArrayItem{ key: 'default', val: '' }]))
	this.add_setting(rt.new_object('WP_Customize_Custom_CSS_Setting', []string{}, var_custom_css_setting), rt.new_null())
	this.add_control(create_wp_customize_code_editor_control(rt.new_object('WP_Customize_Manager', []string{}, &this), rt.new_string('custom_css'), rt.create_array([rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('CSS code')]) }, rt.ArrayItem{ key: 'section', val: 'custom_css' }, rt.ArrayItem{ key: 'settings', val: rt.create_array([rt.ArrayItem{ key: 'default', val: rt.get_property(var_custom_css_setting, 'id') }]) }, rt.ArrayItem{ key: 'code_type', val: 'text/css' }, rt.ArrayItem{ key: 'input_attrs', val: rt.create_array([rt.ArrayItem{ key: 'aria-describedby', val: 'editor-keyboard-trap-help-1 editor-keyboard-trap-help-2 editor-keyboard-trap-help-3 editor-keyboard-trap-help-4' }]) }])), rt.new_null())
}

fn (mut this Class_WP_Customize_Manager) has_published_pages() bool {
	mut var_setting := this.get_setting(rt.new_string('nav_menus_created_posts'))
	if rt.is_true(var_setting) {
		mut iter_53 := rt.call_method(var_setting, 'value', []rt.PhpVal{}).iterator()
		for {
			item_53 := iter_53.next() or { break }
			mut var_post_id := item_53.val
			if rt.is_true(rt.identical(rt.new_string('page'), rt.call_function('get_post_type', [var_post_id.clone()]))) {
				return true
			}
		}
	}
	return rt.new_bool(0 != rt.call_function('get_pages', [rt.create_array([rt.ArrayItem{ key: 'number', val: 1 }, rt.ArrayItem{ key: 'hierarchical', val: 0 }])]).array_count())
}

fn (mut this Class_WP_Customize_Manager) register_dynamic_settings() {
	mut var_setting_ids := rt.func_array_keys(this.unsanitized_post_values(rt.new_null()))
	this.add_dynamic_settings(var_setting_ids.clone())
}

fn (mut this Class_WP_Customize_Manager) handle_load_themes_request() {
	rt.call_function('check_ajax_referer', [rt.new_string('switch_themes'), rt.new_string('nonce')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')]))))) {
		rt.call_function('wp_die', [rt.new_int(-1)])
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('theme_action'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_theme_action')])
	}
	mut var_theme_action := rt.call_function('sanitize_key', [rt.get_superglobal('_POST').array_get(rt.new_string('theme_action'))])
	mut var_themes := rt.new_array()
	mut var_args := rt.new_array()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').clone().array_isset(rt.new_string('search'))))))) {
		var_args.array_set('search', '')
	} else {
		var_args.array_set('search', rt.call_function('sanitize_text_field', [rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get(rt.new_string('search'))])]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').clone().array_isset(rt.new_string('tags'))))))) {
		var_args.array_set('tag', '')
	} else {
		var_args.array_set('tag', rt.call_function('array_map', [rt.new_string('sanitize_text_field'), rt.call_function('wp_unslash', [rt.cast_array(rt.get_superglobal('_POST').array_get(rt.new_string('tags')))])]))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').clone().array_isset(rt.new_string('page'))))))) {
		var_args.array_set('page', 1)
	} else {
		var_args.array_set('page', rt.call_function('absint', [rt.get_superglobal('_POST').array_get(rt.new_string('page'))]))
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/theme.php', '4')
	if rt.is_true(rt.identical(rt.new_string('installed'), var_theme_action)) {
		var_themes = rt.create_array([rt.ArrayItem{ key: 'themes', val: rt.new_array() }])
		mut iter_54 := rt.call_function('wp_prepare_themes_for_js', []rt.PhpVal{}).iterator()
		for {
			item_54 := iter_54.next() or { break }
			mut var_theme := item_54.val
			var_theme.array_set('type', 'installed')
			var_theme.array_set('active', rt.get_superglobal('_POST').array_isset(rt.new_string('customized_theme')) && rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get(rt.new_string('customized_theme')), var_theme.array_get(rt.new_string('id')))))
			var_themes.array_get_mut('themes').array_push(var_theme.clone())
		}
	} else if rt.is_true(rt.identical(rt.new_string('wporg'), var_theme_action)) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_themes')]))))) {
			rt.call_function('wp_die', [rt.new_int(-1)])
		}
		mut var_wporg_args := { 'per_page': rt.new_int(100), 'fields': { 'reviews_url': rt.new_bool(true) } }
		var_args = rt.call_function('array_merge', [rt.create_array_from_native_map(var_wporg_args), var_args.clone()])
		if rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('search')))) && rt.is_true(rt.identical(rt.new_string(''), var_args.array_get(rt.new_string('tag')))) {
			var_args.array_set('browse', 'new')
		}
		var_themes = rt.call_function('themes_api', [rt.new_string('query_themes'), var_args.clone()])
		if rt.is_true(rt.call_function('is_wp_error', [var_themes.clone()])) {
			rt.call_function('wp_send_json_error', []rt.PhpVal{})
		}
		mut var_themes_allowedtags := rt.call_function('array_fill_keys', [rt.create_array([rt.ArrayItem{ key: none, val: 'a' }, rt.ArrayItem{ key: none, val: 'abbr' }, rt.ArrayItem{ key: none, val: 'acronym' }, rt.ArrayItem{ key: none, val: 'code' }, rt.ArrayItem{ key: none, val: 'pre' }, rt.ArrayItem{ key: none, val: 'em' }, rt.ArrayItem{ key: none, val: 'strong' }, rt.ArrayItem{ key: none, val: 'div' }, rt.ArrayItem{ key: none, val: 'p' }, rt.ArrayItem{ key: none, val: 'ul' }, rt.ArrayItem{ key: none, val: 'ol' }, rt.ArrayItem{ key: none, val: 'li' }, rt.ArrayItem{ key: none, val: 'h1' }, rt.ArrayItem{ key: none, val: 'h2' }, rt.ArrayItem{ key: none, val: 'h3' }, rt.ArrayItem{ key: none, val: 'h4' }, rt.ArrayItem{ key: none, val: 'h5' }, rt.ArrayItem{ key: none, val: 'h6' }, rt.ArrayItem{ key: none, val: 'img' }]), rt.new_array()])
		var_themes_allowedtags.array_set('a', rt.call_function('array_fill_keys', [rt.create_array([rt.ArrayItem{ key: none, val: 'href' }, rt.ArrayItem{ key: none, val: 'title' }, rt.ArrayItem{ key: none, val: 'target' }]), rt.new_bool(true)]))
		var_themes_allowedtags.array_get_mut('acronym').array_set('title', true)
		var_themes_allowedtags.array_get_mut('abbr').array_set('title', true)
		var_themes_allowedtags.array_set('img', rt.call_function('array_fill_keys', [rt.create_array([rt.ArrayItem{ key: none, val: 'src' }, rt.ArrayItem{ key: none, val: 'class' }, rt.ArrayItem{ key: none, val: 'alt' }]), rt.new_bool(true)]))
		mut var_installed_themes := rt.new_array()
		mut var_wp_themes := rt.call_function('wp_get_themes', []rt.PhpVal{})
		mut iter_55 := var_wp_themes.iterator()
		for {
			item_55 := iter_55.next() or { break }
			mut var_theme := item_55.val
			var_installed_themes << rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{})
		}
		mut var_update_php := rt.call_function('network_admin_url', [rt.new_string('update.php?action=install-theme')])
		mut iter_56 := rt.get_property(var_themes, 'themes').iterator()
		for {
			item_56 := iter_56.next() or { break }
			mut var_theme := item_56.val
			rt.set_property(var_theme, 'install_url', rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'theme', val: rt.get_property(var_theme, 'slug') }, rt.ArrayItem{ key: '_wpnonce', val: rt.call_function('wp_create_nonce', [rt.new_string('install-theme_' + (rt.get_property(var_theme, 'slug')).str())]) }]), var_update_php.clone()]))
			rt.set_property(var_theme, 'name', rt.call_function('wp_kses', [rt.get_property(var_theme, 'name'), var_themes_allowedtags.clone()]))
			rt.set_property(var_theme, 'version', rt.call_function('wp_kses', [rt.get_property(var_theme, 'version'), var_themes_allowedtags.clone()]))
			rt.set_property(var_theme, 'description', rt.call_function('wp_kses', [rt.get_property(var_theme, 'description'), var_themes_allowedtags.clone()]))
			rt.set_property(var_theme, 'stars', rt.call_function('wp_star_rating', [rt.create_array([rt.ArrayItem{ key: 'rating', val: rt.get_property(var_theme, 'rating') }, rt.ArrayItem{ key: 'type', val: 'percent' }, rt.ArrayItem{ key: 'number', val: rt.get_property(var_theme, 'num_ratings') }, rt.ArrayItem{ key: 'echo', val: false }])]))
			rt.set_property(var_theme, 'num_ratings', rt.call_function('number_format_i18n', [rt.get_property(var_theme, 'num_ratings')]))
			rt.set_property(var_theme, 'preview_url', rt.call_function('set_url_scheme', [rt.get_property(var_theme, 'preview_url')]))
			if rt.is_true(rt.call_function('in_array', [rt.get_property(var_theme, 'slug'), rt.create_array_from_list(var_installed_themes), rt.new_bool(true)])) {
				rt.set_property(var_theme, 'type', rt.new_string('installed'))
			} else {
				rt.set_property(var_theme, 'type', var_theme_action.clone())
			}
			rt.set_property(var_theme, 'active', rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('customized_theme')) && rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get(rt.new_string('customized_theme')), rt.get_property(var_theme, 'slug')))))
			rt.set_property(var_theme, 'id', rt.get_property(var_theme, 'slug'))
			rt.set_property(var_theme, 'screenshot', rt.create_array([rt.ArrayItem{ key: none, val: rt.get_property(var_theme, 'screenshot_url') }]))
			rt.set_property(var_theme, 'authorAndUri', rt.call_function('wp_kses', [rt.get_property(var_theme, 'author').array_get(rt.new_string('display_name')), var_themes_allowedtags.clone()]))
			rt.set_property(var_theme, 'compatibleWP', rt.call_function('is_wp_version_compatible', [rt.get_property(var_theme, 'requires')]))
			rt.set_property(var_theme, 'compatiblePHP', rt.call_function('is_php_version_compatible', [rt.get_property(var_theme, 'requires_php')]))
			if !(rt.get_property(var_theme, 'parent')).is_null() {
				rt.set_property(var_theme, 'parent', rt.get_property(var_theme, 'parent').array_get(rt.new_string('slug')))
			} else {
				rt.set_property(var_theme, 'parent', rt.new_bool(false))
			}
			rt.get_property(var_theme, 'slug') = rt.new_null()
			rt.get_property(var_theme, 'screenshot_url') = rt.new_null()
			rt.get_property(var_theme, 'author') = rt.new_null()
		}
	}
	var_themes = rt.call_function('apply_filters', [rt.new_string('customize_load_themes'), var_themes.clone(), var_args.clone(), rt.new_object('WP_Customize_Manager', []string{}, &this)])
	rt.call_function('wp_send_json_success', [var_themes.clone()])
}

fn (mut this Class_WP_Customize_Manager) _sanitize_header_textcolor(var_color rt.PhpVal) string {
	mut var_color_mutated := var_color
	if rt.is_true(rt.identical(rt.new_string('blank'), var_color_mutated)) {
		return 'blank'
	}
	var_color_mutated = rt.call_function('sanitize_hex_color_no_hash', [var_color_mutated.clone()])
	if !rt.is_true(var_color_mutated) {
	var_color_mutated = rt.call_function('get_theme_support', [rt.new_string('custom-header'), rt.new_string('default-text-color')])
	}
	return (var_color_mutated).str()
}

fn (mut this Class_WP_Customize_Manager) _sanitize_background_setting(var_value rt.PhpVal, var_setting rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	mut var_setting_mutated := var_setting
	if rt.is_true(rt.identical(rt.new_string('background_repeat'), rt.get_property(var_setting_mutated, 'id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'repeat-x' }, rt.ArrayItem{ key: none, val: 'repeat-y' }, rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'no-repeat' }]), rt.new_bool(true)]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [rt.new_string('Invalid value for background repeat.')])))
		}
	} else if rt.is_true(rt.identical(rt.new_string('background_attachment'), rt.get_property(var_setting_mutated, 'id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'fixed' }, rt.ArrayItem{ key: none, val: 'scroll' }]), rt.new_bool(true)]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [rt.new_string('Invalid value for background attachment.')])))
		}
	} else if rt.is_true(rt.identical(rt.new_string('background_position_x'), rt.get_property(var_setting_mutated, 'id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'left' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'right' }]), rt.new_bool(true)]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [rt.new_string('Invalid value for background position X.')])))
		}
	} else if rt.is_true(rt.identical(rt.new_string('background_position_y'), rt.get_property(var_setting_mutated, 'id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'top' }, rt.ArrayItem{ key: none, val: 'center' }, rt.ArrayItem{ key: none, val: 'bottom' }]), rt.new_bool(true)]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [rt.new_string('Invalid value for background position Y.')])))
		}
	} else if rt.is_true(rt.identical(rt.new_string('background_size'), rt.get_property(var_setting_mutated, 'id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'auto' }, rt.ArrayItem{ key: none, val: 'contain' }, rt.ArrayItem{ key: none, val: 'cover' }]), rt.new_bool(true)]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [rt.new_string('Invalid value for background size.')])))
		}
	} else if rt.is_true(rt.identical(rt.new_string('background_preset'), rt.get_property(var_setting_mutated, 'id'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_value_mutated.clone(), rt.create_array([rt.ArrayItem{ key: none, val: 'default' }, rt.ArrayItem{ key: none, val: 'fill' }, rt.ArrayItem{ key: none, val: 'fit' }, rt.ArrayItem{ key: none, val: 'repeat' }, rt.ArrayItem{ key: none, val: 'custom' }]), rt.new_bool(true)]))))) {
			return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [rt.new_string('Invalid value for background size.')])))
		}
	} else if rt.is_true(rt.identical(rt.new_string('background_image'), rt.get_property(var_setting_mutated, 'id'))) || rt.is_true(rt.identical(rt.new_string('background_image_thumb'), rt.get_property(var_setting_mutated, 'id'))) {
	var_value_mutated = if !rt.is_true(var_value_mutated) { rt.new_string('') } else { rt.call_function('sanitize_url', [var_value_mutated.clone()]) }
	} else {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('unrecognized_setting'), rt.call_function('__', [rt.new_string('Unrecognized background setting.')])))
	}
	return var_value_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) export_header_video_settings(var_response rt.PhpVal, var_selective_refresh rt.PhpVal, var_partials rt.PhpVal) rt.PhpVal {
	mut var_response_mutated := var_response
	if var_partials.array_isset(rt.new_string('custom_header')) {
		var_response_mutated.array_set('custom_header_settings', rt.call_function('get_header_video_settings', []rt.PhpVal{}))
	}
	return var_response_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) _validate_header_video(var_validity rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_validity_mutated := var_validity
	mut var_value_mutated := var_value
	mut var_video := rt.call_function('get_attached_file', [rt.call_function('absint', [var_value_mutated.clone()])])
	if rt.is_true(var_video) {
		mut var_size := rt.call_function('filesize', [var_video.clone()])
		if rt.is_true(rt.greater(var_size, rt.mul(rt.new_int(8), rt.get_constant('MB_IN_BYTES')))) {
			rt.call_method(var_validity_mutated, 'add', [rt.new_string('size_too_large'), rt.call_function('__', [rt.new_string('This video file is too large to use as a header video. Try a shorter video or optimize the compression settings and re-upload a file that is less than 8MB. Or, upload your video to YouTube and link it with the option below.')])])
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [var_video.clone(), rt.new_string('.mp4')]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_ends_with', [var_video.clone(), rt.new_string('.mov')]))))) {
			rt.call_method(var_validity_mutated, 'add', [rt.new_string('invalid_file_type'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Only %1$s or %2$s files may be used for header video. Please convert your video file and try again, or, upload your video to YouTube and link it with the option below.')]), rt.new_string('<code>.mp4</code>'), rt.new_string('<code>.mov</code>')])])
		}
	}
	return var_validity_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) _validate_external_header_video(var_validity rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_validity_mutated := var_validity
	mut var_value_mutated := var_value
	mut var_video := rt.call_function('sanitize_url', [var_value_mutated.clone()])
	if rt.is_true(var_video) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('#^https?://(?:www\\.)?(?:youtube\\.com/watch|youtu\\.be/)#'), var_video.clone()]))))) {
			rt.call_method(var_validity_mutated, 'add', [rt.new_string('invalid_url'), rt.call_function('__', [rt.new_string('Please enter a valid YouTube URL.')])])
		}
	}
	return var_validity_mutated.clone()
}

fn (mut this Class_WP_Customize_Manager) _sanitize_external_header_video(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return rt.call_function('sanitize_url', [rt.new_string(var_value_mutated.clone().to_string().trim_space())])
}

fn (mut this Class_WP_Customize_Manager) _render_custom_logo_partial() rt.PhpVal {
	return rt.call_function('get_custom_logo', []rt.PhpVal{})
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

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Panel {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Section {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Themes_Panel {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Themes_Section {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Filter_Setting {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Site_Icon_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Cropped_Image_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Color_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Header_Image_Setting {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Media_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Header_Image_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Background_Image_Setting {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Background_Image_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Background_Position_Control {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Custom_CSS_Setting {
	rt.PhpObjectBase
}

struct Class_WP_Customize_Code_Editor_Control {
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

fn create_wp_customize_selective_refresh(_args ...rt.PhpVal) &Class_WP_Customize_Selective_Refresh {
	mut obj := &Class_WP_Customize_Selective_Refresh{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_widgets(_args ...rt.PhpVal) &Class_WP_Customize_Widgets {
	mut obj := &Class_WP_Customize_Widgets{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_nav_menus(_args ...rt.PhpVal) &Class_WP_Customize_Nav_Menus {
	mut obj := &Class_WP_Customize_Nav_Menus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn create_wp_customize_panel(_args ...rt.PhpVal) &Class_WP_Customize_Panel {
	mut obj := &Class_WP_Customize_Panel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_section(_args ...rt.PhpVal) &Class_WP_Customize_Section {
	mut obj := &Class_WP_Customize_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_control(_args ...rt.PhpVal) &Class_WP_Customize_Control {
	mut obj := &Class_WP_Customize_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_themes_panel(_args ...rt.PhpVal) &Class_WP_Customize_Themes_Panel {
	mut obj := &Class_WP_Customize_Themes_Panel{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_themes_section(_args ...rt.PhpVal) &Class_WP_Customize_Themes_Section {
	mut obj := &Class_WP_Customize_Themes_Section{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_filter_setting(_args ...rt.PhpVal) &Class_WP_Customize_Filter_Setting {
	mut obj := &Class_WP_Customize_Filter_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_site_icon_control(_args ...rt.PhpVal) &Class_WP_Customize_Site_Icon_Control {
	mut obj := &Class_WP_Customize_Site_Icon_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_cropped_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Cropped_Image_Control {
	mut obj := &Class_WP_Customize_Cropped_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_color_control(_args ...rt.PhpVal) &Class_WP_Customize_Color_Control {
	mut obj := &Class_WP_Customize_Color_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_header_image_setting(_args ...rt.PhpVal) &Class_WP_Customize_Header_Image_Setting {
	mut obj := &Class_WP_Customize_Header_Image_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_media_control(_args ...rt.PhpVal) &Class_WP_Customize_Media_Control {
	mut obj := &Class_WP_Customize_Media_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_header_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Header_Image_Control {
	mut obj := &Class_WP_Customize_Header_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_background_image_setting(_args ...rt.PhpVal) &Class_WP_Customize_Background_Image_Setting {
	mut obj := &Class_WP_Customize_Background_Image_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_background_image_control(_args ...rt.PhpVal) &Class_WP_Customize_Background_Image_Control {
	mut obj := &Class_WP_Customize_Background_Image_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_background_position_control(_args ...rt.PhpVal) &Class_WP_Customize_Background_Position_Control {
	mut obj := &Class_WP_Customize_Background_Position_Control{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_custom_css_setting(_args ...rt.PhpVal) &Class_WP_Customize_Custom_CSS_Setting {
	mut obj := &Class_WP_Customize_Custom_CSS_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_customize_code_editor_control(_args ...rt.PhpVal) &Class_WP_Customize_Code_Editor_Control {
	mut obj := &Class_WP_Customize_Code_Editor_Control{
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
			return rt.new_bool(this.is_preview())
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Customize_Panel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Panel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Panel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Themes_Panel) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Themes_Panel) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Themes_Panel) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Themes_Section) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Themes_Section) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Themes_Section) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Filter_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Filter_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Filter_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Site_Icon_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Site_Icon_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Site_Icon_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Cropped_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Cropped_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Cropped_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Color_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Color_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Color_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Header_Image_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Header_Image_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Header_Image_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Media_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Media_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Media_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Header_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Header_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Header_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Background_Image_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Background_Image_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Background_Image_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Background_Image_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Background_Image_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Background_Image_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Background_Position_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Background_Position_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Background_Position_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Custom_CSS_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Custom_CSS_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Custom_CSS_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Customize_Code_Editor_Control) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Code_Editor_Control) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Code_Editor_Control) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	rt.register_class_factory('WP_Query', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_query()
		return rt.new_object('WP_Query', []string{}, obj)
	})
	rt.register_class_factory('WP_Error', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_error()
		return rt.new_object('WP_Error', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Panel', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_panel()
		return rt.new_object('WP_Customize_Panel', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Section', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_section()
		return rt.new_object('WP_Customize_Section', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_control()
		return rt.new_object('WP_Customize_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Themes_Panel', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_themes_panel()
		return rt.new_object('WP_Customize_Themes_Panel', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Themes_Section', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_themes_section()
		return rt.new_object('WP_Customize_Themes_Section', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Filter_Setting', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_filter_setting()
		return rt.new_object('WP_Customize_Filter_Setting', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Site_Icon_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_site_icon_control()
		return rt.new_object('WP_Customize_Site_Icon_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Cropped_Image_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_cropped_image_control()
		return rt.new_object('WP_Customize_Cropped_Image_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Color_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_color_control()
		return rt.new_object('WP_Customize_Color_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Header_Image_Setting', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_header_image_setting()
		return rt.new_object('WP_Customize_Header_Image_Setting', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Media_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_media_control()
		return rt.new_object('WP_Customize_Media_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Header_Image_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_header_image_control()
		return rt.new_object('WP_Customize_Header_Image_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Background_Image_Setting', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_background_image_setting()
		return rt.new_object('WP_Customize_Background_Image_Setting', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Background_Image_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_background_image_control()
		return rt.new_object('WP_Customize_Background_Image_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Background_Position_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_background_position_control()
		return rt.new_object('WP_Customize_Background_Position_Control', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Custom_CSS_Setting', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_custom_css_setting()
		return rt.new_object('WP_Customize_Custom_CSS_Setting', []string{}, obj)
	})
	rt.register_class_factory('WP_Customize_Code_Editor_Control', fn(args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_customize_code_editor_control()
		return rt.new_object('WP_Customize_Code_Editor_Control', []string{}, obj)
	})
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

}

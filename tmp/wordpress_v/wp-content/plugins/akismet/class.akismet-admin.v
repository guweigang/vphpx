import rt

pub fn Class_Akismet_Admin.nonce() string {
	return 'akismet-update-key'
}
pub fn Class_Akismet_Admin.notice_existing_key_invalid() string {
	return 'existing-key-invalid'
}
struct Class_Akismet_Admin {
	rt.PhpObjectBase
pub mut:
		initiated rt.PhpVal = rt.new_bool(false)
		notices rt.PhpVal = rt.new_array()
		allowed rt.PhpVal = rt.new_array()
		activation_banner_pages rt.PhpVal = rt.new_array()
}

fn Class_Akismet_Admin.init()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(// unsupported expression: Expr_StaticPropertyFetch)))) {
		Class_Akismet_Admin.init_hooks()
	}
	if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(rt.new_string('action')) && rt.is_true(rt.equal(rt.get_superglobal('_POST').array_get('action'), rt.new_string('enter-key'))))) {
		Class_Akismet_Admin.enter_api_key()
	}
}

fn Class_Akismet_Admin.init_hooks()  {
	if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('page')) && rt.is_true(rt.equal(rt.new_string('akismet-stats-display'), rt.get_superglobal('_GET').array_get('page'))))) {
		rt.call_function('wp_safe_redirect', [rt.call_function('esc_url_raw', [Class_Akismet_Admin.get_page_url('stats')]), rt.new_int(301)])
		// unsupported expression: Expr_Exit
	}
	// unsupported assign target: Expr_StaticPropertyFetch
	rt.call_function('add_action', [rt.new_string('admin_init'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'admin_init' }])])
	rt.call_function('add_action', [rt.new_string('admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'admin_menu' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'display_notice' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'load_resources' }])])
	rt.call_function('add_action', [rt.new_string('activity_box_end'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'dashboard_stats' }])])
	rt.call_function('add_action', [rt.new_string('rightnow_end'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'rightnow_stats' }])])
	rt.call_function('add_action', [rt.new_string('manage_comments_nav'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'check_for_spam_button' }])])
	rt.call_function('add_action', [rt.new_string('admin_action_akismet_recheck_queue'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'recheck_queue' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_akismet_recheck_queue'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'recheck_queue' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_comment_author_deurl'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'remove_comment_author_url' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_comment_author_reurl'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'add_comment_author_url' }])])
	rt.call_function('add_action', [rt.new_string('jetpack_auto_activate_akismet'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'connect_jetpack_user' }])])
	rt.call_function('add_filter', [rt.new_string('plugin_action_links'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'plugin_action_links' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comment_row_actions'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'comment_row_action' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', ['plugin_action_links_' + (rt.call_function('plugin_basename', [(rt.call_function('plugin_dir_path', [rt.new_string(@FILE)])).str() + 'akismet.php'])).str(), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'admin_plugin_settings_link' }])])
	rt.call_function('add_filter', [rt.new_string('wxr_export_skip_commentmeta'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'exclude_commentmeta_from_export' }]), rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('all_plugins'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'modify_plugin_description' }])])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_erasers'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'register_personal_data_eraser' }]), rt.new_int(1)])
}

fn Class_Akismet_Admin.admin_init()  {
	if rt.is_true(rt.call_function('get_option', [rt.new_string('Activated_Akismet')])) {
		rt.call_function('delete_option', [rt.new_string('Activated_Akismet')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
			mut var_admin_url := Class_Akismet_Admin.get_page_url('init')
			rt.call_function('wp_redirect', [var_admin_url.dup()])
		}
	}
	rt.call_function('add_meta_box', [rt.new_string('akismet-status'), rt.call_function('__', [rt.new_string('Comment History'), rt.new_string('akismet')]), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'comment_status_meta_box' }]), rt.new_string('comment'), rt.new_string('normal')])
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('wp_add_privacy_policy_content')])) {
		rt.call_function('wp_add_privacy_policy_content', [rt.call_function('__', [rt.new_string('Akismet'), rt.new_string('akismet')]), rt.call_function('__', [rt.new_string('We collect information about visitors who comment on Sites that use our Akismet Anti-spam service. The information we collect depends on how the User sets up Akismet for the Site, but typically includes the commenter\'s IP address, user agent, referrer, and Site URL (along with other information directly provided by the commenter such as their name, username, email address, and the comment itself).'), rt.new_string('akismet')])])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.predefined_api_key() }())))) {
		rt.call_function('register_setting', [rt.new_string('connectors'), rt.new_string('wordpress_api_key'), rt.create_array([rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'label', val: rt.call_function('__', [rt.new_string('Akismet API Key'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('API key for Akismet.'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'show_in_rest', val: true }, rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }])])
	}
}

fn Class_Akismet_Admin.admin_menu()  {
	if rt.is_true(Class_Akismet_Admin.is_jetpack_active()) {
		rt.call_function('add_action', [rt.new_string('jetpack_admin_menu'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'load_menu' }])])
	} else {
		Class_Akismet_Admin.load_menu()
	}
}

fn Class_Akismet_Admin.is_jetpack_active() bool {
	return (rt.call_function('class_exists', [rt.new_string('Jetpack')])).to_bool()
}

fn Class_Akismet_Admin.admin_head()  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		return rt.new_null()
	}
}

fn Class_Akismet_Admin.admin_plugin_settings_link(var_links rt.PhpVal) rt.PhpVal {
	mut var_links_mutated := var_links
	mut var_settings_link := rt.new_string('<a href="' + (rt.call_function('esc_url', [Class_Akismet_Admin.get_page_url()])).str() + '">' + (rt.call_function('__', [rt.new_string('Settings'), rt.new_string('akismet')])).str() + '</a>')
	rt.call_function('array_unshift', [var_links_mutated.dup(), var_settings_link.dup()])
	return var_links_mutated.dup()
}

fn Class_Akismet_Admin.load_menu()  {
	if rt.is_true(Class_Akismet_Admin.is_jetpack_active()) {
		mut var_hook := rt.call_function('add_submenu_page', [rt.new_string('jetpack'), rt.call_function('__', [rt.new_string('Akismet Anti-spam'), rt.new_string('akismet')]), rt.call_function('__', [rt.new_string('Akismet Anti-spam'), rt.new_string('akismet')]), rt.new_string('manage_options'), rt.new_string('akismet-key-config'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'display_page' }])])
	} else {
		var_hook = rt.call_function('add_options_page', [rt.call_function('__', [rt.new_string('Akismet Anti-spam'), rt.new_string('akismet')]), rt.call_function('__', [rt.new_string('Akismet Anti-spam'), rt.new_string('akismet')]), rt.new_string('manage_options'), rt.new_string('akismet-key-config'), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'display_page' }])])
	}
	if rt.is_true(var_hook) {
		rt.call_function('add_action', [rt.new_string("load-${var_hook.to_string()}"), rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' }, rt.ArrayItem{ key: none, val: 'admin_help' }])])
	}
}

fn Class_Akismet_Admin.load_resources()  {
	mut var_hook_suffix := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.call_function('in_array', [var_hook_suffix.dup(), rt.call_function('apply_filters', [rt.new_string('akismet_admin_page_hook_suffixes'), rt.call_function('array_merge', [rt.create_array([rt.ArrayItem{ key: none, val: 'index.php' }, rt.ArrayItem{ key: none, val: 'comment.php' }, rt.ArrayItem{ key: none, val: 'post.php' }, rt.ArrayItem{ key: none, val: 'settings_page_akismet-key-config' }, rt.ArrayItem{ key: none, val: 'jetpack_page_akismet-key-config' }]), // unsupported expression: Expr_StaticPropertyFetch])])])) {
		mut var_akismet_css_path := rt.new_string(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { rt.new_string('_inc/rtl/akismet-rtl.css') } else { rt.new_string('_inc/akismet.css') })
		rt.call_function('wp_register_style', [rt.new_string('akismet'), rt.concat(rt.call_function('plugin_dir_url', [rt.new_string(@FILE)]), var_akismet_css_path), rt.new_array(), Class_Akismet_Admin.get_asset_file_version(var_akismet_css_path.dup())])
		rt.call_function('wp_enqueue_style', [rt.new_string('akismet')])
		rt.call_function('wp_register_style', [rt.new_string('akismet-font-inter'), (rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() + '_inc/fonts/inter.css', rt.new_array(), Class_Akismet_Admin.get_asset_file_version(rt.new_string('_inc/fonts/inter.css'))])
		rt.call_function('wp_enqueue_style', [rt.new_string('akismet-font-inter')])
		mut var_akismet_admin_css_path := rt.new_string(if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) { rt.new_string('_inc/rtl/akismet-admin-rtl.css') } else { rt.new_string('_inc/akismet-admin.css') })
		rt.call_function('wp_register_style', [rt.new_string('akismet-admin'), rt.concat(rt.call_function('plugin_dir_url', [rt.new_string(@FILE)]), var_akismet_admin_css_path), rt.new_array(), Class_Akismet_Admin.get_asset_file_version(var_akismet_admin_css_path.dup())])
		rt.call_function('wp_enqueue_style', [rt.new_string('akismet-admin')])
		rt.call_function('wp_add_inline_style', [rt.new_string('akismet-admin'), Class_Akismet_Admin.get_inline_css()])
		rt.call_function('wp_register_script', [rt.new_string('akismet.js'), (rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() + '_inc/akismet.js', rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]), Class_Akismet_Admin.get_asset_file_version(rt.new_string('_inc/akismet.js'))])
		rt.call_function('wp_enqueue_script', [rt.new_string('akismet.js')])
		rt.call_function('wp_register_script', [rt.new_string('akismet-admin.js'), (rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() + '_inc/akismet-admin.js', rt.new_array(), Class_Akismet_Admin.get_asset_file_version(rt.new_string('/_inc/akismet-admin.js'))])
		rt.call_function('wp_enqueue_script', [rt.new_string('akismet-admin.js')])
		mut var_inline_js := { 'comment_author_url_nonce': rt.call_function('wp_create_nonce', [rt.new_string('comment_author_url_nonce')]), 'strings': { 'Remove this URL': rt.call_function('__', [rt.new_string('Remove this URL'), rt.new_string('akismet')]), 'Removing...': rt.call_function('__', [rt.new_string('Removing...'), rt.new_string('akismet')]), 'URL removed': rt.call_function('__', [rt.new_string('URL removed'), rt.new_string('akismet')]), '(undo)': rt.call_function('__', [rt.new_string('(undo)'), rt.new_string('akismet')]), 'Re-adding...': rt.call_function('__', [rt.new_string('Re-adding...'), rt.new_string('akismet')]) }, 'manage_akismet_url': rt.call_function('admin_url', [rt.new_string('admin.php?page=akismet-key-config')]) }
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('akismet_recheck')) && rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_get('akismet_recheck').is_string())))) && rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_GET').array_get('akismet_recheck'), rt.new_string('akismet_recheck')])))) {
			var_inline_js['start_recheck'] = rt.new_bool(true)
		}
		if rt.is_true(rt.call_function('apply_filters', [rt.new_string('akismet_enable_mshots'), rt.new_bool(true)])) {
			var_inline_js['enable_mshots'] = rt.new_bool(true)
		}
		rt.call_function('wp_localize_script', [rt.new_string('akismet.js'), rt.new_string('WPAkismet'), var_inline_js.dup()])
	}
}

fn Class_Akismet_Admin.admin_help()  {
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')])) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }())))) || rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('view')) && rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get('view'), rt.new_string('start'))))))) {
			rt.call_method(var_current_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Akismet Setup'), rt.new_string('akismet')])).str() + '</strong></p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('Akismet filters out spam, so you can focus on more important things.'), rt.new_string('akismet')])).str() + '</p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('On this page, you are able to set up the Akismet plugin.'), rt.new_string('akismet')])).str() + '</p>' }])])
			rt.call_method(var_current_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'setup-signup' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('New to Akismet'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Akismet Setup'), rt.new_string('akismet')])).str() + '</strong></p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('You need to enter an API key to activate the Akismet service on your site.'), rt.new_string('akismet')])).str() + '</p>' + '<p>' + (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sign up for an account on %s to get an API Key.'), rt.new_string('akismet')]), rt.new_string('<a href="https://akismet.com/pricing/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=help_signup" target="_blank">Akismet.com</a>')])).str() + '</p>' }])])
			rt.call_method(var_current_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'setup-manual' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Enter an API Key'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Akismet Setup'), rt.new_string('akismet')])).str() + '</strong></p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('If you already have an API key'), rt.new_string('akismet')])).str() + '</p>' + '<ol>' + '<li>' + (rt.call_function('esc_html__', [rt.new_string('Copy and paste the API key into the text field.'), rt.new_string('akismet')])).str() + '</li>' + '<li>' + (rt.call_function('esc_html__', [rt.new_string('Click the Use this Key button.'), rt.new_string('akismet')])).str() + '</li>' + '</ol>' }])])
		} else if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(rt.new_string('view')) && rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get('view'), rt.new_string('stats'))))) {
			rt.call_method(var_current_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Akismet Stats'), rt.new_string('akismet')])).str() + '</strong></p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('Akismet filters out spam, so you can focus on more important things.'), rt.new_string('akismet')])).str() + '</p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('On this page, you are able to view stats on spam filtered on your site.'), rt.new_string('akismet')])).str() + '</p>' }])])
		} else {
			rt.call_method(var_current_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Overview'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Akismet Configuration'), rt.new_string('akismet')])).str() + '</strong></p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('Akismet filters out spam, so you can focus on more important things.'), rt.new_string('akismet')])).str() + '</p>' + '<p>' + (rt.call_function('esc_html__', [rt.new_string('On this page, you are able to update your Akismet settings and view spam stats.'), rt.new_string('akismet')])).str() + '</p>' }])])
			rt.call_method(var_current_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'settings' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Settings'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Akismet Configuration'), rt.new_string('akismet')])).str() + '</strong></p>' + if rt.is_true(fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.predefined_api_key() }()) { '' } else { '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('API Key'), rt.new_string('akismet')])).str() + '</strong> - ' + (rt.call_function('esc_html__', [rt.new_string('Enter/remove an API key.'), rt.new_string('akismet')])).str() + '</p>' } + '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Comments'), rt.new_string('akismet')])).str() + '</strong> - ' + (rt.call_function('esc_html__', [rt.new_string('Show the number of approved comments beside each comment author in the comments list page.'), rt.new_string('akismet')])).str() + '</p>' + '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Strictness'), rt.new_string('akismet')])).str() + '</strong> - ' + (rt.call_function('esc_html__', [rt.new_string('Choose to either discard the worst spam automatically or to always put all spam in spam folder.'), rt.new_string('akismet')])).str() + '</p>' }])])
			if rt.is_true(rt.new_bool(!(rt.is_true(fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.predefined_api_key() }())))) {
				rt.call_method(var_current_screen, 'add_help_tab', [rt.create_array([rt.ArrayItem{ key: 'id', val: 'account' }, rt.ArrayItem{ key: 'title', val: rt.call_function('__', [rt.new_string('Account'), rt.new_string('akismet')]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Akismet Configuration'), rt.new_string('akismet')])).str() + '</strong></p>' + '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Subscription Type'), rt.new_string('akismet')])).str() + '</strong> - ' + (rt.call_function('esc_html__', [rt.new_string('The Akismet subscription plan'), rt.new_string('akismet')])).str() + '</p>' + '<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('Status'), rt.new_string('akismet')])).str() + '</strong> - ' + (rt.call_function('esc_html__', [rt.new_string('The subscription status - active, cancelled or suspended'), rt.new_string('akismet')])).str() + '</p>' }])])
			}
		}
	}
	rt.call_method(var_current_screen, 'set_help_sidebar', ['<p><strong>' + (rt.call_function('esc_html__', [rt.new_string('For more information:'), rt.new_string('akismet')])).str() + '</strong></p>' + '<p><a href="https://akismet.com/resources/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=help_faq" target="_blank">' + (rt.call_function('esc_html__', [rt.new_string('Akismet FAQ'), rt.new_string('akismet')])).str() + '</a></p>' + '<p><a href="https://akismet.com/support/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=help_support" target="_blank">' + (rt.call_function('esc_html__', [rt.new_string('Akismet Support'), rt.new_string('akismet')])).str() + '</a></p>'])
}

fn Class_Akismet_Admin.enter_api_key() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')]))))) {
		// unsupported expression: Expr_Exit
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_POST').array_get('_wpnonce')) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_get('_wpnonce').is_string()))))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_POST').array_get('_wpnonce'), Class_Akismet_Admin.nonce()]))))))) {
		return false
	}
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'akismet_strictness' }, rt.ArrayItem{ key: none, val: 'akismet_show_user_comments_approved' }, rt.ArrayItem{ key: none, val: 'akismet_enable_mcp_access' }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_option := item_1.val
			rt.call_function('update_option', [var_option.dup(), if rt.is_true(rt.new_bool(rt.get_superglobal('_POST').array_isset(var_option) && rt.is_true(rt.equal(// unsupported expression: Expr_Cast_Int, rt.new_int(1))))) { rt.new_string('1') } else { rt.new_string('0') }])
		}
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get('akismet_comment_form_privacy_notice'))) {
		Class_Akismet_Admin.set_form_privacy_notice_option(rt.get_superglobal('_POST').array_get('akismet_comment_form_privacy_notice'))
	} else {
		Class_Akismet_Admin.set_form_privacy_notice_option(rt.new_string('hide'))
	}
	if rt.is_true(fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.predefined_api_key() }()) {
		return false
		// unsupported statement: Stmt_Nop
	}
	mut var_new_key := rt.call_function('preg_replace', [rt.new_string('/[^a-f0-9]/i'), rt.new_string(''), rt.get_superglobal('_POST').array_get('key')])
	mut var_old_key := fn () rt.PhpVal { mut temp := Class_Akismet{}; return temp.get_api_key() }()
	if !rt.is_true(var_new_key) {
		if !(!rt.is_true(var_old_key)) {
			rt.call_function('delete_option', [rt.new_string('wordpress_api_key')])
			// unsupported expression: Expr_StaticPropertyFetch.array_push('new-key-empty')
		}
	} else if rt.is_true(// unsupported expression: Expr_BinaryOp_NotEqual) {
		Class_Akismet_Admin.save_key(var_new_key.dup())
	}
	return true
}

fn Class_Akismet_Admin.save_key(var_api_key rt.PhpVal)  {
	mut var_api_key_mutated := var_api_key
	mut var_key_status := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_Akismet{}; return temp.verify_key(arg_0) }(var_api_key_mutated.dup())
	if rt.is_true(rt.equal(var_key_status, rt.new_string('valid'))) {
		mut var_akismet_user := Class_Akismet_Admin.get_akismet_user(var_api_key_mutated.dup())
		if rt.is_true(var_akismet_user) {
			if rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_active())) {
				rt.call_function('update_option', [rt.new_string('wordpress_api_key'), var_api_key_mutated.dup()])
			}
			if rt.is_true(rt.equal(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_active())) {
				// unsupported expression: Expr_StaticPropertyFetch.array_set('status', 'new-key-valid')
			} else if rt.is_true(rt.equal(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_no_sub())) {
				// unsupported expression: Expr_StaticPropertyFetch.array_set('status', 'no-sub')
			} else {
				// unsupported expression: Expr_StaticPropertyFetch.array_set('status', rt.get_property(var_akismet_user, 'status'))
			}
		} else {
			// unsupported expression: Expr_StaticPropertyFetch.array_set('status', 'new-key-invalid')
		}
	} else if rt.is_true(rt.call_function('in_array', [var_key_status.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'invalid' }, rt.ArrayItem{ key: none, val: 'failed' }])])) {
		var_akismet_user = Class_Akismet_Admin.get_akismet_user(var_api_key_mutated.dup())
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_akismet_user) && !(rt.get_property(var_akismet_user, 'status')).is_null())) && rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_suspended())))) {
			// unsupported expression: Expr_StaticPropertyFetch.array_set('status', Class_Akismet.user_status_suspended())
		} else {
			// unsupported expression: Expr_StaticPropertyFetch.array_set('status', 'new-key-' + (var_key_status).str())
		}
	}
}

fn Class_Akismet_Admin.dashboard_stats()  {
	mut var_submenu := rt.new_null()
	if rt.is_true(rt.call_function('did_action', [rt.new_string('rightnow_end')])) {
		return rt.new_null()
		// unsupported statement: Stmt_Nop
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(mut var_count := rt.call_function('get_option', [rt.new_string('akismet_spam_count')]))))) {
		return rt.new_null()
	}
	// unsupported statement: Stmt_Global
	print('<h3>' + (rt.call_function('esc_html', [rt.call_function('_x', [, , ])])).str() + '</h3>')
	print('<p>' + (rt.call_function('sprintf', [, , , ])).str() + '</p>')
}

fn Class_Akismet_Admin.rightnow_stats()  {
	if rt.is_true(mut var_count := rt.call_function('get_option', [])) {
		mut var_intro := 
	} else {
		
	}
	
}

fn Class_Akismet_Admin.check_for_spam_button(var_comment_status rt.PhpVal)  {
	mut var_comment_status_mutated := var_comment_status
}

fn Class_Akismet_Admin.recheck_queue()  {
	mut var_wpdb := rt.new_null()
}

fn Class_Akismet_Admin.recheck_queue_portion(start i64, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut start_mutated := start
	mut limit_mutated := limit
}

fn Class_Akismet_Admin.remove_comment_author_url()  {
}

fn Class_Akismet_Admin.add_comment_author_url()  {
}

fn Class_Akismet_Admin.comment_row_action(var_a rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_comment_mutated := var_comment
}

fn Class_Akismet_Admin.comment_status_meta_box(var_comment rt.PhpVal)  {
	mut var_comment_mutated := var_comment
}

fn Class_Akismet_Admin.plugin_action_links(var_links rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	mut var_links_mutated := var_links
}

fn Class_Akismet_Admin.get_spam_count(type bool) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut type_mutated := type
}

fn Class_Akismet_Admin.check_server_ip_connectivity() rt.PhpVal {
}

fn Class_Akismet_Admin.check_server_connectivity(cache_timeout i64) bool {
	mut var_GLOBALS := rt.new_null()
}

fn Class_Akismet_Admin.get_server_connectivity(cache_timeout i64) rt.PhpVal {
}

fn Class_Akismet_Admin.are_any_comments_waiting_to_be_checked() bool {
}

fn Class_Akismet_Admin.get_page_url(page string) rt.PhpVal {
	mut page_mutated := page
}

fn Class_Akismet_Admin.get_akismet_user(var_api_key rt.PhpVal) rt.PhpVal {
	mut var_api_key_mutated := var_api_key
}

fn Class_Akismet_Admin.get_stats(var_api_key rt.PhpVal) rt.PhpVal {
	mut var_api_key_mutated := var_api_key
}

fn Class_Akismet_Admin.verify_wpcom_key(var_api_key rt.PhpVal, var_user_id rt.PhpVal, var_extra rt.PhpVal) rt.PhpVal {
	mut var_api_key_mutated := var_api_key
	mut var_user_id_mutated := var_user_id
}

fn Class_Akismet_Admin.connect_jetpack_user() bool {
}

fn Class_Akismet_Admin.display_alert()  {
}

fn Class_Akismet_Admin.get_usage_limit_alert_data() rt.PhpVal {
}

fn Class_Akismet_Admin.display_usage_limit_alert()  {
}

fn Class_Akismet_Admin.display_spam_check_warning()  {
}

fn Class_Akismet_Admin.display_api_key_warning()  {
}

fn Class_Akismet_Admin.display_page()  {
}

fn Class_Akismet_Admin.display_start_page()  {
}

fn Class_Akismet_Admin.display_stats_page()  {
}

fn Class_Akismet_Admin.display_configuration_page()  {
}

fn Class_Akismet_Admin.display_notice()  {
	mut var_hook_suffix := rt.new_null()
}

fn Class_Akismet_Admin.display_status()  {
}

fn Class_Akismet_Admin.get_notice_by_key(var_key rt.PhpVal) rt.PhpVal {
}

fn Class_Akismet_Admin.get_jetpack_user() bool {
}

fn Class_Akismet_Admin.exclude_commentmeta_from_export(var_exclude rt.PhpVal, var_key rt.PhpVal, var_meta rt.PhpVal) bool {
}

fn Class_Akismet_Admin.modify_plugin_description(var_all_plugins rt.PhpVal) rt.PhpVal {
}

fn Class_Akismet_Admin.set_form_privacy_notice_option(var_state rt.PhpVal)  {
}

fn Class_Akismet_Admin.register_personal_data_eraser(var_erasers rt.PhpVal) rt.PhpVal {
	mut var_erasers_mutated := var_erasers
}

fn Class_Akismet_Admin.erase_personal_data(var_email_address rt.PhpVal, page i64) rt.PhpVal {
	mut page_mutated := page
}

fn Class_Akismet_Admin.get_notice_kses_allowed_elements() rt.PhpVal {
}

fn Class_Akismet_Admin.get_asset_file_version(var_relative_path rt.PhpVal) rt.PhpVal {
}

fn Class_Akismet_Admin.get_inline_css() string {
	mut var_hook_suffix := rt.new_null()
}

struct Class_Akismet {
	rt.PhpObjectBase
}

fn create_akismet_admin() &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
		initiated: rt.new_bool(false)
		notices: rt.new_array()
		allowed: rt.new_array()
		activation_banner_pages: rt.new_array()
	}
	return obj
}

fn create_akismet() &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Admin) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_Akismet_Admin.init()
			return rt.new_null()
		}
		'init_hooks' {
			Class_Akismet_Admin.init_hooks()
			return rt.new_null()
		}
		'admin_init' {
			Class_Akismet_Admin.admin_init()
			return rt.new_null()
		}
		'admin_menu' {
			Class_Akismet_Admin.admin_menu()
			return rt.new_null()
		}
		'is_jetpack_active' {
			return rt.new_bool(Class_Akismet_Admin.is_jetpack_active())
		}
		'admin_head' {
			Class_Akismet_Admin.admin_head()
			return rt.new_null()
		}
		'admin_plugin_settings_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Admin.admin_plugin_settings_link(dispatch_arg_0)
		}
		'load_menu' {
			Class_Akismet_Admin.load_menu()
			return rt.new_null()
		}
		'load_resources' {
			Class_Akismet_Admin.load_resources()
			return rt.new_null()
		}
		'admin_help' {
			Class_Akismet_Admin.admin_help()
			return rt.new_null()
		}
		'enter_api_key' {
			return rt.new_bool(Class_Akismet_Admin.enter_api_key())
		}
		'save_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet_Admin.save_key(dispatch_arg_0)
			return rt.new_null()
		}
		'dashboard_stats' {
			Class_Akismet_Admin.dashboard_stats()
			return rt.new_null()
		}
		'rightnow_stats' {
			Class_Akismet_Admin.rightnow_stats()
			return rt.new_null()
		}
		'check_for_spam_button' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet_Admin.check_for_spam_button(dispatch_arg_0)
			return rt.new_null()
		}
		'recheck_queue' {
			Class_Akismet_Admin.recheck_queue()
			return rt.new_null()
		}
		'recheck_queue_portion' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Akismet_Admin.recheck_queue_portion(dispatch_arg_0, dispatch_arg_1)
		}
		'remove_comment_author_url' {
			Class_Akismet_Admin.remove_comment_author_url()
			return rt.new_null()
		}
		'add_comment_author_url' {
			Class_Akismet_Admin.add_comment_author_url()
			return rt.new_null()
		}
		'comment_row_action' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Akismet_Admin.comment_row_action(dispatch_arg_0, dispatch_arg_1)
		}
		'comment_status_meta_box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet_Admin.comment_status_meta_box(dispatch_arg_0)
			return rt.new_null()
		}
		'plugin_action_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_Akismet_Admin.plugin_action_links(dispatch_arg_0, dispatch_arg_1)
		}
		'get_spam_count' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Akismet_Admin.get_spam_count(dispatch_arg_0)
		}
		'check_server_ip_connectivity' {
			return Class_Akismet_Admin.check_server_ip_connectivity()
		}
		'check_server_connectivity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return rt.new_bool(Class_Akismet_Admin.check_server_connectivity(dispatch_arg_0))
		}
		'get_server_connectivity' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return Class_Akismet_Admin.get_server_connectivity(dispatch_arg_0)
		}
		'are_any_comments_waiting_to_be_checked' {
			return rt.new_bool(Class_Akismet_Admin.are_any_comments_waiting_to_be_checked())
		}
		'get_page_url' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return Class_Akismet_Admin.get_page_url(dispatch_arg_0)
		}
		'get_akismet_user' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Admin.get_akismet_user(dispatch_arg_0)
		}
		'get_stats' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Admin.get_stats(dispatch_arg_0)
		}
		'verify_wpcom_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_Akismet_Admin.verify_wpcom_key(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'connect_jetpack_user' {
			return rt.new_bool(Class_Akismet_Admin.connect_jetpack_user())
		}
		'display_alert' {
			Class_Akismet_Admin.display_alert()
			return rt.new_null()
		}
		'get_usage_limit_alert_data' {
			return Class_Akismet_Admin.get_usage_limit_alert_data()
		}
		'display_usage_limit_alert' {
			Class_Akismet_Admin.display_usage_limit_alert()
			return rt.new_null()
		}
		'display_spam_check_warning' {
			Class_Akismet_Admin.display_spam_check_warning()
			return rt.new_null()
		}
		'display_api_key_warning' {
			Class_Akismet_Admin.display_api_key_warning()
			return rt.new_null()
		}
		'display_page' {
			Class_Akismet_Admin.display_page()
			return rt.new_null()
		}
		'display_start_page' {
			Class_Akismet_Admin.display_start_page()
			return rt.new_null()
		}
		'display_stats_page' {
			Class_Akismet_Admin.display_stats_page()
			return rt.new_null()
		}
		'display_configuration_page' {
			Class_Akismet_Admin.display_configuration_page()
			return rt.new_null()
		}
		'display_notice' {
			Class_Akismet_Admin.display_notice()
			return rt.new_null()
		}
		'display_status' {
			Class_Akismet_Admin.display_status()
			return rt.new_null()
		}
		'get_notice_by_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Admin.get_notice_by_key(dispatch_arg_0)
		}
		'get_jetpack_user' {
			return rt.new_bool(Class_Akismet_Admin.get_jetpack_user())
		}
		'exclude_commentmeta_from_export' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet_Admin.exclude_commentmeta_from_export(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'modify_plugin_description' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Admin.modify_plugin_description(dispatch_arg_0)
		}
		'set_form_privacy_notice_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_Akismet_Admin.set_form_privacy_notice_option(dispatch_arg_0)
			return rt.new_null()
		}
		'register_personal_data_eraser' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Admin.register_personal_data_eraser(dispatch_arg_0)
		}
		'erase_personal_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_Akismet_Admin.erase_personal_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_notice_kses_allowed_elements' {
			return Class_Akismet_Admin.get_notice_kses_allowed_elements()
		}
		'get_asset_file_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_Akismet_Admin.get_asset_file_version(dispatch_arg_0)
		}
		'get_inline_css' {
			return rt.new_string(Class_Akismet_Admin.get_inline_css())
		}
		else { return none }
	}
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'initiated' { return this.initiated }
		'notices' { return this.notices }
		'allowed' { return this.allowed }
		'activation_banner_pages' { return this.activation_banner_pages }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'initiated' { this.initiated = val; return true }
		'notices' { this.notices = val; return true }
		'allowed' { this.allowed = val; return true }
		'activation_banner_pages' { this.activation_banner_pages = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_Akismet) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Akismet) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_akismet_class_akismet_admin_php() {
}

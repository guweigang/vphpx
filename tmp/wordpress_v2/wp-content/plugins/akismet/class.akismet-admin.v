import rt

pub fn Class_Akismet_Admin.nonce() string {
	return 'akismet-update-key'
}

pub fn Class_Akismet_Admin.notice_existing_key_invalid() string {
	return 'existing-key-invalid'
}

struct Class_Akismet_Admin {
	rt.PhpObjectBase
}

fn init_static_akismet_admin() {
	rt.init_static_prop('Akismet_Admin', 'initiated', rt.new_bool(false))
	rt.init_static_prop('Akismet_Admin', 'notices', rt.new_array())
	rt.init_static_prop('Akismet_Admin', 'allowed', rt.create_array([
		rt.ArrayItem{ key: 'a', val: rt.create_array([
			rt.ArrayItem{ key: 'href', val: true },
			rt.ArrayItem{ key: 'title', val: true },
		]) },
		rt.ArrayItem{ key: 'b', val: rt.new_array() },
		rt.ArrayItem{ key: 'code', val: rt.new_array() },
		rt.ArrayItem{ key: 'del', val: rt.create_array([
			rt.ArrayItem{ key: 'datetime', val: true },
		]) },
		rt.ArrayItem{ key: 'em', val: rt.new_array() },
		rt.ArrayItem{ key: 'i', val: rt.new_array() },
		rt.ArrayItem{ key: 'q', val: rt.create_array([
			rt.ArrayItem{ key: 'cite', val: true },
		]) },
		rt.ArrayItem{ key: 'strike', val: rt.new_array() },
		rt.ArrayItem{ key: 'strong', val: rt.new_array() },
	]))
	rt.init_static_prop('Akismet_Admin', 'activation_banner_pages', rt.create_array([
		rt.ArrayItem{ key: none, val: 'edit-comments.php' },
		rt.ArrayItem{ key: none, val: 'options-discussion.php' },
		rt.ArrayItem{ key: none, val: 'plugins.php' },
	]))
}

fn Class_Akismet_Admin.init() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_static_prop('Akismet_Admin', 'initiated'))))) {
		Class_Akismet_Admin.init_hooks()
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.equal(rt.get_superglobal('_POST').array_get(rt.new_string('action')), rt.new_string('enter-key'))) {
		Class_Akismet_Admin.enter_api_key()
	}
}

fn Class_Akismet_Admin.init_hooks() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('page'))
		&& rt.is_true(rt.equal(rt.new_string('akismet-stats-display'), rt.get_superglobal('_GET').array_get(rt.new_string('page')))) {
		rt.call_function('wp_safe_redirect', [
			rt.call_function('esc_url_raw', [
				Class_Akismet_Admin.get_page_url('stats'),
			]),
			rt.new_int(301),
		])
		exit(0)
	}
	rt.set_static_prop('Akismet_Admin', 'initiated', rt.new_bool(true))
	rt.call_function('add_action', [rt.new_string('admin_init'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'admin_init' }])])
	rt.call_function('add_action', [rt.new_string('admin_menu'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'admin_menu' }]),
		rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('admin_notices'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'display_notice' }])])
	rt.call_function('add_action', [rt.new_string('admin_enqueue_scripts'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'load_resources' }])])
	rt.call_function('add_action', [rt.new_string('activity_box_end'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'dashboard_stats' }])])
	rt.call_function('add_action', [rt.new_string('rightnow_end'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'rightnow_stats' }])])
	rt.call_function('add_action', [rt.new_string('manage_comments_nav'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'check_for_spam_button' }])])
	rt.call_function('add_action', [rt.new_string('admin_action_akismet_recheck_queue'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'recheck_queue' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_akismet_recheck_queue'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'recheck_queue' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_comment_author_deurl'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'remove_comment_author_url' }])])
	rt.call_function('add_action', [rt.new_string('wp_ajax_comment_author_reurl'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'add_comment_author_url' }])])
	rt.call_function('add_action', [rt.new_string('jetpack_auto_activate_akismet'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'connect_jetpack_user' }])])
	rt.call_function('add_filter', [rt.new_string('plugin_action_links'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'plugin_action_links' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('comment_row_actions'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'comment_row_action' }]),
		rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [
		rt.new_string('plugin_action_links_' +
			(rt.call_function('plugin_basename', [rt.new_string((rt.call_function('plugin_dir_path', [rt.new_string(@FILE)])).str() +
			'akismet.php')])).str()),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'admin_plugin_settings_link' },
		]),
	])
	rt.call_function('add_filter', [rt.new_string('wxr_export_skip_commentmeta'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'exclude_commentmeta_from_export' }]),
		rt.new_int(10), rt.new_int(3)])
	rt.call_function('add_filter', [rt.new_string('all_plugins'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'modify_plugin_description' }])])
	rt.call_function('add_filter', [rt.new_string('wp_privacy_personal_data_erasers'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'register_personal_data_eraser' }]),
		rt.new_int(1)])
}

fn Class_Akismet_Admin.admin_init() {
	if rt.is_true(rt.call_function('get_option', [rt.new_string('Activated_Akismet')])) {
		rt.call_function('delete_option', [rt.new_string('Activated_Akismet')])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{}))))) {
			mut var_admin_url := Class_Akismet_Admin.get_page_url('init')
			rt.call_function('wp_redirect', [var_admin_url.clone()])
		}
	}
	rt.call_function('add_meta_box', [rt.new_string('akismet-status'),
		rt.call_function('__', [rt.new_string('Comment History'),
			rt.new_string('akismet')]),
		rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'comment_status_meta_box' }]),
		rt.new_string('comment'), rt.new_string('normal')])
	if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wp_add_privacy_policy_content'),
	]))
	{
		rt.call_function('wp_add_privacy_policy_content', [
			rt.call_function('__', [rt.new_string('Akismet'),
				rt.new_string('akismet')]),
			rt.call_function('__', [
				rt.new_string("We collect information about visitors who comment on Sites that use our Akismet Anti-spam service. The information we collect depends on how the User sets up Akismet for the Site, but typically includes the commenter's IP address, user agent, referrer, and Site URL (along with other information directly provided by the commenter such as their name, username, email address, and the comment itself)."),
				rt.new_string('akismet'),
			]),
		])
	}
	mut iife_temp_0 := Class_Akismet{}
	mut iife_result_0 := iife_temp_0.predefined_api_key()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0)))) {
		rt.call_function('register_setting', [rt.new_string('connectors'),
			rt.new_string('wordpress_api_key'),
			rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
					rt.new_string('Akismet API Key'),
					rt.new_string('akismet'),
				]) },
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('API key for Akismet.'),
					rt.new_string('akismet'),
				]) },
				rt.ArrayItem{ key: 'default', val: '' },
				rt.ArrayItem{ key: 'show_in_rest', val: true },
				rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' },
			])])
	}
}

fn Class_Akismet_Admin.admin_menu() {
	if rt.is_true(Class_Akismet_Admin.is_jetpack_active()) {
		rt.call_function('add_action', [rt.new_string('jetpack_admin_menu'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
				rt.ArrayItem{ key: none, val: 'load_menu' }])])
	} else {
		Class_Akismet_Admin.load_menu()
	}
}

fn Class_Akismet_Admin.is_jetpack_active() bool {
	return (rt.call_function('class_exists', [rt.new_string('Jetpack')])).to_bool()
}

fn Class_Akismet_Admin.admin_head() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		return
	}
}

fn Class_Akismet_Admin.admin_plugin_settings_link(var_links rt.PhpVal) rt.PhpVal {
	mut var_links_mutated := var_links
	mut var_settings_link := rt.new_string('<a href="' +
		(rt.call_function('esc_url', [Class_Akismet_Admin.get_page_url()])).str() + '">' +
		(rt.call_function('__', [rt.new_string('Settings'), rt.new_string('akismet')])).str() +
		'</a>')
	rt.call_function('array_unshift', [var_links_mutated.clone(),
		var_settings_link.clone()])
	return var_links_mutated.clone()
}

fn Class_Akismet_Admin.load_menu() {
	if rt.is_true(Class_Akismet_Admin.is_jetpack_active()) {
		mut var_hook := rt.call_function('add_submenu_page', [
			rt.new_string('jetpack'),
			rt.call_function('__', [
				rt.new_string('Akismet Anti-spam'),
				rt.new_string('akismet'),
			]),
			rt.call_function('__', [
				rt.new_string('Akismet Anti-spam'),
				rt.new_string('akismet'),
			]),
			rt.new_string('manage_options'), rt.new_string('akismet-key-config'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
				rt.ArrayItem{ key: none, val: 'display_page' },
			])])
	} else {
		var_hook = rt.call_function('add_options_page', [
			rt.call_function('__', [rt.new_string('Akismet Anti-spam'),
				rt.new_string('akismet')]),
			rt.call_function('__', [rt.new_string('Akismet Anti-spam'),
				rt.new_string('akismet')]),
			rt.new_string('manage_options'),
			rt.new_string('akismet-key-config'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
				rt.ArrayItem{ key: none, val: 'display_page' }]),
		])
	}
	if rt.is_true(var_hook) {
		rt.call_function('add_action', [rt.new_string('load-${var_hook.to_string()}'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
				rt.ArrayItem{ key: none, val: 'admin_help' }])])
	}
}

fn Class_Akismet_Admin.load_resources() {
	mut var_hook_suffix := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [var_hook_suffix.clone(),
		rt.call_function('apply_filters', [
			rt.new_string('akismet_admin_page_hook_suffixes'),
			rt.call_function('array_merge', [
				rt.create_array([rt.ArrayItem{ key: none, val: 'index.php' },
					rt.ArrayItem{ key: none, val: 'comment.php' },
					rt.ArrayItem{ key: none, val: 'post.php' },
					rt.ArrayItem{ key: none, val: 'settings_page_akismet-key-config' },
					rt.ArrayItem{ key: none, val: 'jetpack_page_akismet-key-config' }]),
				rt.get_static_prop('Akismet_Admin', 'activation_banner_pages'),
			]),
		])]))
	{
		mut var_akismet_css_path := rt.new_string((if rt.is_true(rt.call_function('is_rtl',
			[]rt.PhpVal{}))
		{
			'_inc/rtl/akismet-rtl.css'
		} else {
			'_inc/akismet.css'
		}).str())
		rt.call_function('wp_register_style', [rt.new_string('akismet'),
			rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() +
				var_akismet_css_path.str()),
			rt.new_array(), Class_Akismet_Admin.get_asset_file_version(var_akismet_css_path.clone())])
		rt.call_function('wp_enqueue_style', [rt.new_string('akismet')])
		rt.call_function('wp_register_style', [rt.new_string('akismet-font-inter'),
			rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() +
				'_inc/fonts/inter.css'),
			rt.new_array(),
			Class_Akismet_Admin.get_asset_file_version(rt.new_string('_inc/fonts/inter.css'))])
		rt.call_function('wp_enqueue_style', [rt.new_string('akismet-font-inter')])
		mut var_akismet_admin_css_path := rt.new_string((if rt.is_true(rt.call_function('is_rtl',
			[]rt.PhpVal{}))
		{
			'_inc/rtl/akismet-admin-rtl.css'
		} else {
			'_inc/akismet-admin.css'
		}).str())
		rt.call_function('wp_register_style', [rt.new_string('akismet-admin'),
			rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() +
				var_akismet_admin_css_path.str()),
			rt.new_array(),
			Class_Akismet_Admin.get_asset_file_version(var_akismet_admin_css_path.clone())])
		rt.call_function('wp_enqueue_style', [rt.new_string('akismet-admin')])
		rt.call_function('wp_add_inline_style', [rt.new_string('akismet-admin'),
			Class_Akismet_Admin.get_inline_css()])
		rt.call_function('wp_register_script', [rt.new_string('akismet.js'),
			rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() +
				'_inc/akismet.js'),
			rt.create_array([rt.ArrayItem{ key: none, val: 'jquery' }]),
			Class_Akismet_Admin.get_asset_file_version(rt.new_string('_inc/akismet.js'))])
		rt.call_function('wp_enqueue_script', [rt.new_string('akismet.js')])
		rt.call_function('wp_register_script', [rt.new_string('akismet-admin.js'),
			rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() +
				'_inc/akismet-admin.js'),
			rt.new_array(),
			Class_Akismet_Admin.get_asset_file_version(rt.new_string('/_inc/akismet-admin.js'))])
		rt.call_function('wp_enqueue_script', [rt.new_string('akismet-admin.js')])
		mut var_inline_js := {
			'comment_author_url_nonce': rt.call_function('wp_create_nonce', [
				rt.new_string('comment_author_url_nonce'),
			])
			'strings':                  {
				'Remove this URL': rt.call_function('__', [
					rt.new_string('Remove this URL'),
					rt.new_string('akismet'),
				])
				'Removing...':     rt.call_function('__', [rt.new_string('Removing...'),
					rt.new_string('akismet')])
				'URL removed':     rt.call_function('__', [rt.new_string('URL removed'),
					rt.new_string('akismet')])
				'(undo)':          rt.call_function('__', [rt.new_string('(undo)'),
					rt.new_string('akismet')])
				'Re-adding...':    rt.call_function('__', [rt.new_string('Re-adding...'),
					rt.new_string('akismet')])
			}
			'manage_akismet_url':       rt.call_function('admin_url', [
				rt.new_string('admin.php?page=akismet-key-config'),
			])
		}
		if rt.get_superglobal('_GET').array_isset(rt.new_string('akismet_recheck'))
			&& rt.get_superglobal('_GET').array_get(rt.new_string('akismet_recheck')).is_string()
			&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_GET').array_get(rt.new_string('akismet_recheck')), rt.new_string('akismet_recheck')])) {
			var_inline_js['start_recheck'] = rt.new_bool(true)
		}
		if rt.is_true(rt.call_function('apply_filters', [
			rt.new_string('akismet_enable_mshots'),
			rt.new_bool(true),
		]))
		{
			var_inline_js['enable_mshots'] = rt.new_bool(true)
		}
		rt.call_function('wp_localize_script', [rt.new_string('akismet.js'),
			rt.new_string('WPAkismet'), rt.create_array_from_native_map(var_inline_js)])
	}
}

fn Class_Akismet_Admin.admin_help() {
	mut var_current_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_options')])) {
		mut iife_temp_1 := Class_Akismet{}
		mut iife_result_1 := iife_temp_1.get_api_key()
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_1))))
			|| (rt.get_superglobal('_GET').array_isset(rt.new_string('view'))
			&& rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get(rt.new_string('view')), rt.new_string('start')))) {
			rt.call_method(var_current_screen, 'add_help_tab', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Overview'),
						rt.new_string('akismet'),
					]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet Setup'), rt.new_string('akismet')])).str() +
						'</strong></p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet filters out spam, so you can focus on more important things.'), rt.new_string('akismet')])).str() +
						'</p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('On this page, you are able to set up the Akismet plugin.'), rt.new_string('akismet')])).str() +
						'</p>' }]),
			])
			rt.call_method(var_current_screen, 'add_help_tab', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'setup-signup' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('New to Akismet'),
						rt.new_string('akismet'),
					]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet Setup'), rt.new_string('akismet')])).str() +
						'</strong></p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('You need to enter an API key to activate the Akismet service on your site.'), rt.new_string('akismet')])).str() +
						'</p>' + '<p>' +
						(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Sign up for an account on %s to get an API Key.'), rt.new_string('akismet')]), rt.new_string('<a href="https://akismet.com/pricing/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=help_signup" target="_blank">Akismet.com</a>')])).str() +
						'</p>' }]),
			])
			rt.call_method(var_current_screen, 'add_help_tab', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'setup-manual' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Enter an API Key'),
						rt.new_string('akismet'),
					]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet Setup'), rt.new_string('akismet')])).str() +
						'</strong></p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('If you already have an API key'), rt.new_string('akismet')])).str() +
						'</p>' + '<ol>' + '<li>' +
						(rt.call_function('esc_html__', [rt.new_string('Copy and paste the API key into the text field.'), rt.new_string('akismet')])).str() +
						'</li>' + '<li>' +
						(rt.call_function('esc_html__', [rt.new_string('Click the Use this Key button.'), rt.new_string('akismet')])).str() +
						'</li>' + '</ol>' }]),
			])
		} else if rt.get_superglobal('_GET').array_isset(rt.new_string('view'))
			&& rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get(rt.new_string('view')), rt.new_string('stats'))) {
			rt.call_method(var_current_screen, 'add_help_tab', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Overview'),
						rt.new_string('akismet'),
					]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet Stats'), rt.new_string('akismet')])).str() +
						'</strong></p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet filters out spam, so you can focus on more important things.'), rt.new_string('akismet')])).str() +
						'</p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('On this page, you are able to view stats on spam filtered on your site.'), rt.new_string('akismet')])).str() +
						'</p>' }]),
			])
		} else {
			rt.call_method(var_current_screen, 'add_help_tab', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'overview' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Overview'),
						rt.new_string('akismet'),
					]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet Configuration'), rt.new_string('akismet')])).str() +
						'</strong></p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet filters out spam, so you can focus on more important things.'), rt.new_string('akismet')])).str() +
						'</p>' + '<p>' +
						(rt.call_function('esc_html__', [rt.new_string('On this page, you are able to update your Akismet settings and view spam stats.'), rt.new_string('akismet')])).str() +
						'</p>' }]),
			])
			mut iife_temp_2 := Class_Akismet{}
			mut iife_result_2 := iife_temp_2.predefined_api_key()
			rt.call_method(var_current_screen, 'add_help_tab', [
				rt.create_array([rt.ArrayItem{ key: 'id', val: 'settings' },
					rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
						rt.new_string('Settings'),
						rt.new_string('akismet'),
					]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Akismet Configuration'), rt.new_string('akismet')])).str() +
						'</strong></p>' + if rt.is_true(iife_result_2) { '' } else { '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('API Key'), rt.new_string('akismet')])).str() +
						'</strong> - ' +
						(rt.call_function('esc_html__', [rt.new_string('Enter/remove an API key.'), rt.new_string('akismet')])).str() +
						'</p>' } + '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Comments'), rt.new_string('akismet')])).str() +
						'</strong> - ' +
						(rt.call_function('esc_html__', [rt.new_string('Show the number of approved comments beside each comment author in the comments list page.'), rt.new_string('akismet')])).str() +
						'</p>' + '<p><strong>' +
						(rt.call_function('esc_html__', [rt.new_string('Strictness'), rt.new_string('akismet')])).str() +
						'</strong> - ' +
						(rt.call_function('esc_html__', [rt.new_string('Choose to either discard the worst spam automatically or to always put all spam in spam folder.'), rt.new_string('akismet')])).str() +
						'</p>' }]),
			])
			mut iife_temp_3 := Class_Akismet{}
			mut iife_result_3 := iife_temp_3.predefined_api_key()
			if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_3)))) {
				rt.call_method(var_current_screen, 'add_help_tab', [
					rt.create_array([rt.ArrayItem{ key: 'id', val: 'account' },
						rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
							rt.new_string('Account'),
							rt.new_string('akismet'),
						]) }, rt.ArrayItem{ key: 'content', val: '<p><strong>' +
							(rt.call_function('esc_html__', [rt.new_string('Akismet Configuration'), rt.new_string('akismet')])).str() +
							'</strong></p>' + '<p><strong>' +
							(rt.call_function('esc_html__', [rt.new_string('Subscription Type'), rt.new_string('akismet')])).str() +
							'</strong> - ' +
							(rt.call_function('esc_html__', [rt.new_string('The Akismet subscription plan'), rt.new_string('akismet')])).str() +
							'</p>' + '<p><strong>' +
							(rt.call_function('esc_html__', [rt.new_string('Status'), rt.new_string('akismet')])).str() +
							'</strong> - ' +
							(rt.call_function('esc_html__', [rt.new_string('The subscription status - active, cancelled or suspended'), rt.new_string('akismet')])).str() +
							'</p>' }]),
				])
			}
		}
	}
	rt.call_method(var_current_screen, 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('esc_html__', [rt.new_string('For more information:'), rt.new_string('akismet')])).str() +
			'</strong></p>' +
			'<p><a href="https://akismet.com/resources/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=help_faq" target="_blank">' +
			(rt.call_function('esc_html__', [rt.new_string('Akismet FAQ'), rt.new_string('akismet')])).str() +
			'</a></p>' +
			'<p><a href="https://akismet.com/support/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=help_support" target="_blank">' +
			(rt.call_function('esc_html__', [rt.new_string('Akismet Support'), rt.new_string('akismet')])).str() +
			'</a></p>'),
	])
}

fn Class_Akismet_Admin.enter_api_key() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_options'),
	])))))
	{
		fn () {
			print((rt.call_function('__', [rt.new_string('Cheatin&#8217; uh?'),
				rt.new_string('akismet')])).str())
			exit(0)
		}()
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('_wpnonce')))
		|| !(rt.get_superglobal('_POST').array_get(rt.new_string('_wpnonce')).is_string())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_POST').array_get(rt.new_string('_wpnonce')), rt.new_string(Class_Akismet_Admin.nonce())]))))) {
		return false
	}
	mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: 'akismet_strictness' },
		rt.ArrayItem{ key: none, val: 'akismet_show_user_comments_approved' },
		rt.ArrayItem{ key: none, val: 'akismet_enable_mcp_access' }]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_option := item_1.val
		rt.call_function('update_option', [var_option.clone(),
			rt.new_string((if rt.get_superglobal('_POST').array_isset(var_option)
				&& rt.new_int((rt.get_superglobal('_POST').array_get(var_option)).to_i64()) == 1 {
				'1'
			} else {
				'0'
			}).str())])
	}
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('akismet_comment_form_privacy_notice')))) {
		Class_Akismet_Admin.set_form_privacy_notice_option(rt.get_superglobal('_POST').array_get(rt.new_string('akismet_comment_form_privacy_notice')))
	} else {
		Class_Akismet_Admin.set_form_privacy_notice_option(rt.new_string('hide'))
	}
	mut iife_temp_4 := Class_Akismet{}
	mut iife_result_4 := iife_temp_4.predefined_api_key()
	if rt.is_true(iife_result_4) {
		return false
	}
	mut var_new_key := rt.call_function('preg_replace', [rt.new_string('/[^a-f0-9]/i'),
		rt.new_string(''), rt.get_superglobal('_POST').array_get(rt.new_string('key'))])
	mut iife_temp_5 := Class_Akismet{}
	mut iife_result_5 := iife_temp_5.get_api_key()
	mut var_old_key := iife_result_5
	if !rt.is_true(var_new_key) {
		if !(!rt.is_true(var_old_key)) {
			rt.call_function('delete_option', [rt.new_string('wordpress_api_key')])
			rt.get_static_prop('Akismet_Admin', 'notices').array_push('new-key-empty')
		}
	} else if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_new_key, var_old_key)))) {
		Class_Akismet_Admin.save_key(var_new_key.clone())
	}
	return true
}

fn Class_Akismet_Admin.save_key(var_api_key rt.PhpVal) {
	mut var_api_key_mutated := var_api_key
	mut iife_temp_6 := Class_Akismet{}
	mut iife_result_6 := iife_temp_6.verify_key(var_api_key_mutated.clone())
	mut var_key_status := iife_result_6
	if rt.is_true(rt.equal(var_key_status, rt.new_string('valid'))) {
		mut var_akismet_user := Class_Akismet_Admin.get_akismet_user(var_api_key_mutated.clone())
		if rt.is_true(var_akismet_user) {
			if rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'status'),
				Class_Akismet.user_status_active()))
			{
				rt.call_function('update_option', [rt.new_string('wordpress_api_key'),
					var_api_key_mutated.clone()])
			}
			if rt.is_true(rt.equal(rt.get_property(var_akismet_user, 'status'),
				Class_Akismet.user_status_active()))
			{
				rt.get_static_prop('Akismet_Admin', 'notices').array_set('status', 'new-key-valid')
			} else if rt.is_true(rt.equal(rt.get_property(var_akismet_user, 'status'),
				Class_Akismet.user_status_no_sub()))
			{
				rt.get_static_prop('Akismet_Admin', 'notices').array_set('status', 'no-sub')
			} else {
				rt.get_static_prop('Akismet_Admin', 'notices').array_set('status', rt.get_property(var_akismet_user,
					'status'))
			}
		} else {
			rt.get_static_prop('Akismet_Admin', 'notices').array_set('status', 'new-key-invalid')
		}
	} else if rt.is_true(rt.call_function('in_array', [var_key_status.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'invalid' },
			rt.ArrayItem{ key: none, val: 'failed' }])]))
	{
		var_akismet_user = Class_Akismet_Admin.get_akismet_user(var_api_key_mutated.clone())
		if rt.is_true(var_akismet_user) && !(rt.get_property(var_akismet_user, 'status')).is_null()
			&& rt.is_true(rt.identical(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_suspended())) {
			rt.get_static_prop('Akismet_Admin', 'notices').array_set('status',
				Class_Akismet.user_status_suspended())
		} else {
			rt.get_static_prop('Akismet_Admin', 'notices').array_set('status', 'new-key-' +
				var_key_status.str())
		}
	}
}

fn Class_Akismet_Admin.dashboard_stats() {
	mut var_submenu := rt.new_null()
	if rt.is_true(rt.call_function('did_action', [rt.new_string('rightnow_end')])) {
		return
	}
	mut var_count := rt.call_function('get_option', [rt.new_string('akismet_spam_count')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_count)))) {
		return
	}
	print('<h3>' +
		(rt.call_function('esc_html', [rt.call_function('_x', [rt.new_string('Spam'), rt.new_string('comments'), rt.new_string('akismet')])])).str() +
		'</h3>')
	print('<p>' +
		(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('<a href="%1$s">Akismet</a> has protected your site from <a href="%2$s">%3$s spam comment</a>.'), rt.new_string('<a href="%1$s">Akismet</a> has protected your site from <a href="%2$s">%3$s spam comments</a>.'), var_count.clone(), rt.new_string('akismet')]), rt.new_string('https://akismet.com/wordpress/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=dashboard_stats'), rt.call_function('esc_url', [rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{
		key: 'page'
		val: 'akismet-admin'
	}]), rt.call_function('admin_url', [rt.new_string((if var_submenu.array_isset(rt.new_string('edit-comments.php')) { 'edit-comments.php' } else { 'edit.php' }).str())])])]), rt.call_function('number_format_i18n', [var_count.clone()])])).str() +
		'</p>')
}

fn Class_Akismet_Admin.rightnow_stats() {
	mut var_count := rt.call_function('get_option', [rt.new_string('akismet_spam_count')])
	if rt.is_true(var_count) {
		mut var_intro := rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('<a href="%1$s">Akismet</a> has protected your site from %2$s spam comment already. '),
				rt.new_string('<a href="%1$s">Akismet</a> has protected your site from %2$s spam comments already. '),
				var_count.clone(),
				rt.new_string('akismet'),
			]),
			rt.new_string('https://akismet.com/wordpress/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=dashboard_stats'),
			rt.call_function('number_format_i18n', [
				var_count.clone(),
			]),
		])
	} else {
		var_intro = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('<a href="%s">Akismet</a> blocks spam from getting to your blog. '),
				rt.new_string('akismet'),
			]),
			rt.new_string('https://akismet.com/wordpress/?utm_source=akismet_plugin&amp;utm_campaign=plugin_static_link&amp;utm_medium=in_plugin&amp;utm_content=dashboard_stats'),
		])
	}
	mut var_link := rt.call_function('add_query_arg', [
		rt.create_array([rt.ArrayItem{ key: 'comment_status', val: 'spam' }]),
		rt.call_function('admin_url', [rt.new_string('edit-comments.php')]),
	])
	mut var_queue_count := Class_Akismet_Admin.get_spam_count()
	if rt.is_true(var_queue_count) {
		mut var_queue_text := rt.call_function('sprintf', [
			rt.call_function('_n', [
				rt.new_string('There&#8217;s <a href="%2$s">%1$s comment</a> in your spam queue right now.'),
				rt.new_string('There are <a href="%2$s">%1$s comments</a> in your spam queue right now.'),
				var_queue_count.clone(),
				rt.new_string('akismet'),
			]),
			rt.call_function('number_format_i18n', [
				var_queue_count.clone(),
			]),
			rt.call_function('esc_url', [
				var_link.clone(),
			]),
		])
	} else {
		var_queue_text = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string("There&#8217;s nothing in your <a href='%s'>spam queue</a> at the moment."),
				rt.new_string('akismet'),
			]),
			rt.call_function('esc_url', [
				var_link.clone(),
			]),
		])
	}
	mut var_text := rt.new_string(var_intro.str() + '<br />' + var_queue_text.str())
	print("<p class='akismet-right-now'>${var_text.to_string()}</p>\n")
}

fn Class_Akismet_Admin.check_for_spam_button(var_comment_status rt.PhpVal) {
	mut var_comment_status_mutated := var_comment_status
	if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('all'), var_comment_status_mutated))))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.new_string('moderated'), var_comment_status_mutated)))) {
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('moderate_comments'),
	])))))
	{
		return
	}
	mut var_link := rt.new_string('')
	mut var_comments_count := rt.call_function('wp_count_comments', []rt.PhpVal{})
	print('</div>')
	print('<div class="alignleft actions">')
	mut var_classes := ['button', 'button-secondary', 'checkforspam', 'button-disabled']
	if rt.is_true(rt.greater(rt.get_property(var_comments_count, 'moderated'), rt.new_int(0))) {
		var_classes << 'enable-on-load'
		mut iife_temp_7 := Class_Akismet{}
		mut iife_result_7 := iife_temp_7.get_api_key()
		if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_7)))) {
			var_link = Class_Akismet_Admin.get_page_url()
			var_classes << 'ajax-disabled'
		}
	}
	print('<a\n\t\t\t\tclass="' +
		(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_classes)])])).str() +
		'"' + if !(!rt.is_true(var_link)) { ' href="' +
		(rt.call_function('esc_url', [var_link.clone()])).str() + '"' } else { '' } +
		' data-progress-label="' +
		(rt.call_function('esc_attr', [rt.call_function('__', [rt.new_string('Checking for Spam (%1$s%)'), rt.new_string('akismet')])])).str() +
		'"\n\t\t\t\tdata-success-url="' +
		(rt.call_function('esc_attr', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{
		key: none
		val: 'akismet_recheck'
	}, rt.ArrayItem{ key: none, val: 'akismet_recheck_error' }]), rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{
		key: 'akismet_recheck_complete'
		val: 1
	}, rt.ArrayItem{
		key: 'recheck_count'
		val: rt.call_function('urlencode', [rt.new_string('__recheck_count__')])
	}, rt.ArrayItem{
		key: 'spam_count'
		val: rt.call_function('urlencode', [rt.new_string('__spam_count__')])
	}])])])])).str() +
		'"\n\t\t\t\tdata-failure-url="' +
		(rt.call_function('esc_attr', [rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{
		key: none
		val: 'akismet_recheck'
	}, rt.ArrayItem{ key: none, val: 'akismet_recheck_complete' }]), rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{
		key: 'akismet_recheck_error'
		val: 1
	}])])])])).str() +
		'"\n\t\t\t\tdata-pending-comment-count="' +
		(rt.call_function('esc_attr', [rt.get_property(var_comments_count, 'moderated')])).str() +
		'"\n\t\t\t\tdata-nonce="' +
		(rt.call_function('esc_attr', [rt.call_function('wp_create_nonce', [rt.new_string('akismet_check_for_spam')])])).str() +
		'"\n\t\t\t\t' +
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('ajax-disabled'), rt.create_array_from_list(var_classes)]))))) { 'onclick="return false;"' } else { '' } +
		'\n\t\t\t\t>' +
		(rt.call_function('esc_html__', [rt.new_string('Check for Spam'), rt.new_string('akismet')])).str() +
		'</a>')
	print('<span class="checkforspam-spinner"></span>')
}

fn Class_Akismet_Admin.recheck_queue() {
	mut var_wpdb := rt.new_null()
	mut iife_temp_8 := Class_Akismet{}
	mut iife_result_8 := iife_temp_8.fix_scheduled_recheck()
	if !(rt.get_superglobal('_GET').array_isset(rt.new_string('recheckqueue'))
		|| (rt.get_superglobal('_REQUEST').array_isset(rt.new_string('action'))
		&& rt.is_true(rt.equal(rt.new_string('akismet_recheck_queue'), rt.get_superglobal('_REQUEST').array_get(rt.new_string('action')))))) {
		return
	}
	if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('nonce')))
		|| !(rt.get_superglobal('_POST').array_get(rt.new_string('nonce')).is_string())
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_POST').array_get(rt.new_string('nonce')), rt.new_string('akismet_check_for_spam')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('moderate_comments')]))))) {
		rt.call_function('wp_send_json', [
			rt.create_array([
				rt.ArrayItem{ key: 'error', val: rt.call_function('__', [
					rt.new_string('You don&#8217;t have permission to do that.'),
					rt.new_string('akismet'),
				]) },
			]),
		])
		return
	}
	mut var_result_counts := Class_Akismet_Admin.recheck_queue_portion((if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('offset'))) {
		rt.new_int(0)
	} else {
		rt.get_superglobal('_POST').array_get(rt.new_string('offset'))
	}).to_i64(), (if !rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('limit'))) {
		rt.new_int(100)
	} else {
		rt.get_superglobal('_POST').array_get(rt.new_string('limit'))
	}).to_i64())
	if rt.is_true(rt.call_function('defined', [rt.new_string('DOING_AJAX')]))
		&& rt.is_true(rt.get_constant('DOING_AJAX')) {
		rt.call_function('wp_send_json', [
			rt.create_array([rt.ArrayItem{ key: 'counts', val: var_result_counts }]),
		])
	} else {
		mut var_redirect_to := if rt.get_superglobal('_SERVER').array_isset(rt.new_string('HTTP_REFERER')) { rt.get_superglobal('_SERVER').array_get(rt.new_string('HTTP_REFERER')) } else { rt.call_function('admin_url', [
				rt.new_string('edit-comments.php'),
			]) }
		rt.call_function('wp_safe_redirect', [var_redirect_to.clone()])
		exit(0)
	}
}

fn Class_Akismet_Admin.recheck_queue_portion(start i64, limit i64) rt.PhpVal {
	mut var_wpdb := rt.new_null()
	mut start_mutated := start
	mut limit_mutated := limit
	mut var_paginate := rt.new_string('')
	if limit_mutated <= 0 {
		limit_mutated = 100
	}
	if start_mutated < 0 {
		start_mutated = 0
	}
	mut var_moderation := rt.call_method(var_wpdb, 'get_col', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
				'comments')), rt.new_string(" WHERE comment_approved = '0' LIMIT %d OFFSET %d")),
			rt.new_int(limit_mutated).clone(),
			rt.new_int(start_mutated).clone(),
		]),
	])
	mut var_result_counts := rt.create_array([
		rt.ArrayItem{
			key: 'processed'
			val: if rt.call_function('is_countable', [
				var_moderation.clone(),
			])
			{ var_moderation.clone().array_count() } else { 0 }
		},
		rt.ArrayItem{ key: 'spam', val: 0 },
		rt.ArrayItem{ key: 'ham', val: 0 },
		rt.ArrayItem{ key: 'error', val: 0 },
	])
	mut iter_2 := var_moderation.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_comment_id := item_2.val
		mut iife_temp_9 := Class_Akismet{}
		mut iife_result_9 := iife_temp_9.recheck_comment(var_comment_id.clone(),
			rt.new_string('recheck_queue'))
		mut var_api_response := iife_result_9
		if rt.is_true(rt.identical(rt.new_string('true'), var_api_response)) {
			rt.pre_inc(var_result_counts.array_get(rt.new_string('spam')))
		} else if rt.is_true(rt.identical(rt.new_string('false'), var_api_response)) {
			rt.pre_inc(var_result_counts.array_get(rt.new_string('ham')))
		} else {
			rt.pre_inc(var_result_counts.array_get(rt.new_string('error')))
		}
	}
	return var_result_counts.clone()
}

fn Class_Akismet_Admin.remove_comment_author_url() {
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('id'))))
		&& rt.is_true(rt.call_function('check_admin_referer', [rt.new_string('comment_author_url_nonce')])) {
		mut var_comment_id :=
			rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('id')).to_i64())
		mut var_comment := rt.call_function('get_comment', [var_comment_id.clone(),
			rt.get_constant('ARRAY_A')])
		if rt.is_true(var_comment)
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), var_comment.array_get(rt.new_string('comment_ID'))])) {
			var_comment.array_set('comment_author_url', '')
			rt.call_function('do_action', [rt.new_string('comment_remove_author_url')])
			fn () {
				print((rt.call_function('wp_update_comment', [
					var_comment.clone()])).str())
				return i64(1)
			}()
			exit(0)
		}
	}
}

fn Class_Akismet_Admin.add_comment_author_url() {
	if !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('id'))))
		&& !(!rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('url'))))
		&& rt.is_true(rt.call_function('check_admin_referer', [rt.new_string('comment_author_url_nonce')])) {
		mut var_comment_id :=
			rt.new_int(rt.get_superglobal('_POST').array_get(rt.new_string('id')).to_i64())
		mut var_comment := rt.call_function('get_comment', [var_comment_id.clone(),
			rt.get_constant('ARRAY_A')])
		if rt.is_true(var_comment)
			&& rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_comment'), var_comment.array_get(rt.new_string('comment_ID'))])) {
			var_comment.array_set('comment_author_url', rt.call_function('esc_url', [
				rt.get_superglobal('_POST').array_get(rt.new_string('url')),
			]))
			rt.call_function('do_action', [rt.new_string('comment_add_author_url')])
			fn () {
				print((rt.call_function('wp_update_comment', [
					var_comment.clone()])).str())
				return i64(1)
			}()
			exit(0)
		}
	}
}

fn Class_Akismet_Admin.comment_row_action(var_a rt.PhpVal, var_comment rt.PhpVal) rt.PhpVal {
	mut var_a_mutated := var_a
	mut var_comment_mutated := var_comment
	mut var_akismet_result := rt.call_function('get_comment_meta', [
		rt.get_property(var_comment_mutated, 'comment_ID'),
		rt.new_string('akismet_result'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_akismet_result))))
		&& rt.is_true(rt.call_function('get_comment_meta', [rt.get_property(var_comment_mutated, 'comment_ID'), rt.new_string('akismet_skipped'), rt.new_bool(true)])) {
		var_akismet_result = rt.new_string('skipped')
	}
	mut var_akismet_error := rt.call_function('get_comment_meta', [
		rt.get_property(var_comment_mutated, 'comment_ID'),
		rt.new_string('akismet_error'),
		rt.new_bool(true),
	])
	mut var_user_result := rt.call_function('get_comment_meta', [
		rt.get_property(var_comment_mutated, 'comment_ID'),
		rt.new_string('akismet_user_result'),
		rt.new_bool(true),
	])
	mut var_comment_status := rt.call_function('wp_get_comment_status', [
		rt.get_property(var_comment_mutated, 'comment_ID'),
	])
	mut var_desc := rt.new_null()
	if rt.is_true(var_akismet_error) {
		var_desc = rt.call_function('__', [rt.new_string('Awaiting spam check'),
			rt.new_string('akismet')])
	} else if rt.is_true(rt.new_bool(!(rt.is_true(var_user_result))))
		|| rt.is_true(rt.equal(var_user_result, var_akismet_result)) {
		if rt.is_true(rt.equal(var_akismet_result, rt.new_string('true')))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_comment_status, rt.new_string('spam')))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_comment_status, rt.new_string('trash'))))) {
			var_desc = rt.call_function('__', [
				rt.new_string('Flagged as spam by Akismet'),
				rt.new_string('akismet'),
			])
		} else if rt.is_true(rt.equal(var_akismet_result, rt.new_string('false')))
			&& rt.is_true(rt.equal(var_comment_status, rt.new_string('spam'))) {
			var_desc = rt.call_function('__', [rt.new_string('Cleared by Akismet'),
				rt.new_string('akismet')])
		}
	} else {
		mut var_who := rt.call_function('get_comment_meta', [
			rt.get_property(var_comment_mutated, 'comment_ID'),
			rt.new_string('akismet_user'),
			rt.new_bool(true),
		])
		if rt.is_true(rt.equal(var_user_result, rt.new_string('true'))) {
			var_desc = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Flagged as spam by %s'),
					rt.new_string('akismet')]),
				var_who.clone(),
			])
		} else {
			var_desc = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Un-spammed by %s'),
					rt.new_string('akismet')]),
				var_who.clone(),
			])
		}
	}
	if rt.is_true(var_akismet_result) && var_a_mutated.clone().is_array() {
		mut var_b := rt.new_array()
		mut iter_3 := var_a_mutated.iterator()
		for {
			item_3 := iter_3.next() or { break }
			mut var_item := item_3.val
			mut var_k := item_3.key
			var_b.array_set(var_k, var_item.clone())
			if rt.is_true(rt.equal(var_k, rt.new_string('edit')))
				|| rt.is_true(rt.equal(var_k, rt.new_string('unspam'))) {
				var_b.array_set('history', '<a href="comment.php?action=editcomment&amp;c=' +
					(rt.get_property(var_comment_mutated, 'comment_ID')).str() +
					'#akismet-status" title="' +
					(rt.call_function('esc_attr__', [rt.new_string('View comment history'), rt.new_string('akismet')])).str() +
					'"> ' +
					(rt.call_function('esc_html__', [rt.new_string('History'), rt.new_string('akismet')])).str() +
					'</a>')
			}
		}
		var_a_mutated = var_b.clone()
	}
	if rt.is_true(var_desc) {
		print('<span class="akismet-status" commentid="' +
			(rt.get_property(var_comment_mutated, 'comment_ID')).str() +
			'"><a href="comment.php?action=editcomment&amp;c=' +
			(rt.get_property(var_comment_mutated, 'comment_ID')).str() +
			'#akismet-status" title="' +
			(rt.call_function('esc_attr__', [rt.new_string('View comment history'), rt.new_string('akismet')])).str() +
			'">' + (rt.call_function('esc_html', [var_desc.clone()])).str() + '</a></span>')
	}
	mut var_show_user_comments_option := rt.call_function('get_option', [
		rt.new_string('akismet_show_user_comments_approved'),
	])
	if rt.is_true(rt.identical(var_show_user_comments_option, rt.new_bool(false))) {
		var_show_user_comments_option = rt.new_string('1')
	}
	mut var_show_user_comments := rt.call_function('apply_filters', [
		rt.new_string('akismet_show_user_comments_approved'),
		var_show_user_comments_option.clone(),
	])
	var_show_user_comments = if rt.is_true(rt.identical(var_show_user_comments,
		rt.new_string('false')))
	{
		rt.new_bool(false)
	} else {
		var_show_user_comments
	}
	if rt.is_true(var_show_user_comments) {
		mut iife_temp_10 := Class_Akismet{}
		mut iife_result_10 := iife_temp_10.get_user_comments_approved(rt.get_property(var_comment_mutated,
			'user_id'), rt.get_property(var_comment_mutated, 'comment_author_email'), rt.get_property(var_comment_mutated,
			'comment_author'), rt.get_property(var_comment_mutated, 'comment_author_url'))
		mut var_comment_count := iife_result_10
		var_comment_count = rt.new_int(var_comment_count.clone().to_i64())
		print('<span class="akismet-user-comment-count" commentid="' +
			(rt.get_property(var_comment_mutated, 'comment_ID')).str() +
			'" style="display:none;"><br><span class="akismet-user-comment-counts">')
		print(
			(rt.call_function('sprintf', [rt.call_function('esc_html', [rt.call_function('_n', [rt.new_string('%s approved'), rt.new_string('%s approved'), var_comment_count.clone(), rt.new_string('akismet')])]), rt.call_function('number_format_i18n', [var_comment_count.clone()])])).str() +
			'</span></span>')
	}
	return var_a_mutated.clone()
}

fn Class_Akismet_Admin.comment_status_meta_box(var_comment rt.PhpVal) {
	mut var_comment_mutated := var_comment
	mut iife_temp_11 := Class_Akismet{}
	mut iife_result_11 := iife_temp_11.get_comment_history(rt.get_property(var_comment_mutated,
		'comment_ID'))
	mut var_history := iife_result_11
	if rt.is_true(var_history) {
		mut iter_4 := var_history.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_row := item_4.val
			mut var_message := rt.new_string('')
			if !(!rt.is_true(var_row.array_get(rt.new_string('message')))) {
				var_message = rt.call_function('esc_html', [
					var_row.array_get(rt.new_string('message')),
				])
			} else if !(!rt.is_true(var_row.array_get(rt.new_string('event')))) {
				mut switch_val_1 := var_row.array_get(rt.new_string('event'))
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('recheck-spam'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet re-checked and caught this comment as spam.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('check-spam'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet caught this comment as spam.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recheck-ham'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet re-checked and cleared this comment.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('check-ham'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet cleared this comment.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('check-ham-pending'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet provisionally cleared this comment.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-blacklisted')))
					|| rt.is_true(rt.equal(switch_val_1, rt.new_string('wp-disallowed'))) {
					var_message = rt.call_function('sprintf', [
						rt.call_function('esc_html', [
							rt.call_function('__', [
								rt.new_string('Comment was caught by %s.'),
								rt.new_string('akismet'),
							]),
						]),
						rt.new_string((if rt.is_true(rt.call_function('function_exists', [
							rt.new_string('wp_check_comment_disallowed_list'),
						]))
						{
							'<code>wp_check_comment_disallowed_list</code>'
						} else {
							'<code>wp_blacklist_check</code>'
						}).str()),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('report-spam'))) {
					if var_row.array_isset(rt.new_string('user')) {
						var_message = rt.call_function('esc_html', [
							rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('%s reported this comment as spam.'),
									rt.new_string('akismet'),
								]),
								var_row.array_get(rt.new_string('user')),
							]),
						])
					} else if rt.is_true(rt.new_bool(!(rt.is_true(var_message)))) {
						var_message = rt.call_function('esc_html', [
							rt.call_function('__', [
								rt.new_string('This comment was reported as spam.'),
								rt.new_string('akismet'),
							]),
						])
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('report-ham'))) {
					if var_row.array_isset(rt.new_string('user')) {
						var_message = rt.call_function('esc_html', [
							rt.call_function('sprintf', [
								rt.call_function('__', [
									rt.new_string('%s reported this comment as not spam.'),
									rt.new_string('akismet'),
								]),
								var_row.array_get(rt.new_string('user')),
							]),
						])
					} else if rt.is_true(rt.new_bool(!(rt.is_true(var_message)))) {
						var_message = rt.call_function('esc_html', [
							rt.call_function('__', [
								rt.new_string('This comment was reported as not spam.'),
								rt.new_string('akismet'),
							]),
						])
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cron-retry-spam'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet caught this comment as spam during an automatic retry.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('cron-retry-ham'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet cleared this comment during an automatic retry.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('check-error'))) {
					if var_row.array_isset(rt.new_string('meta'))
						&& var_row.array_get(rt.new_string('meta')).array_isset(rt.new_string('response')) {
						var_message = rt.call_function('sprintf', [
							rt.call_function('esc_html', [
								rt.call_function('__', [
									rt.new_string('Akismet was unable to check this comment (response: %s) but will automatically retry later.'),
									rt.new_string('akismet'),
								]),
							]),
							rt.new_string('<code>' +
								(rt.call_function('esc_html', [var_row.array_get(rt.new_string('meta')).array_get(rt.new_string('response'))])).str() +
								'</code>'),
						])
					} else {
						var_message = rt.call_function('esc_html', [
							rt.call_function('__', [
								rt.new_string('Akismet was unable to check this comment but will automatically retry later.'),
								rt.new_string('akismet'),
							]),
						])
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('recheck-error'))) {
					if var_row.array_isset(rt.new_string('meta'))
						&& var_row.array_get(rt.new_string('meta')).array_isset(rt.new_string('response')) {
						var_message = rt.call_function('sprintf', [
							rt.call_function('esc_html', [
								rt.call_function('__', [
									rt.new_string('Akismet was unable to recheck this comment (response: %s).'),
									rt.new_string('akismet'),
								]),
							]),
							rt.new_string('<code>' +
								(rt.call_function('esc_html', [var_row.array_get(rt.new_string('meta')).array_get(rt.new_string('response'))])).str() +
								'</code>'),
						])
					} else {
						var_message = rt.call_function('esc_html', [
							rt.call_function('__', [
								rt.new_string('Akismet was unable to recheck this comment.'),
								rt.new_string('akismet'),
							]),
						])
					}
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('webhook-spam'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet caught this comment as spam and updated its status via webhook.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('webhook-ham'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet cleared this comment and updated its status via webhook.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('webhook-spam-noaction'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet determined this comment was spam during a recheck. It did not update the comment status because it had already been modified by another user or plugin.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('webhook-ham-noaction'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('Akismet cleared this comment during a recheck. It did not update the comment status because it had already been modified by another user or plugin.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('akismet-skipped'))) {
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('This comment was not sent to Akismet when it was submitted because it was caught by something else.'),
							rt.new_string('akismet'),
						]),
					])
				} else if rt.is_true(rt.equal(switch_val_1,
					rt.new_string('akismet-skipped-disallowed')))
				{
					var_message = rt.call_function('esc_html', [
						rt.call_function('__', [
							rt.new_string('This comment was not sent to Akismet when it was submitted because it was caught by the comment disallowed list.'),
							rt.new_string('akismet'),
						]),
					])
				} else {
					if rt.is_true(rt.call_function('preg_match', [
						rt.new_string('/^status-changed/'),
						var_row.array_get(rt.new_string('event')),
					]))
					{
						mut var_new_status := rt.call_function('preg_replace', [
							rt.new_string('/^status-changed-?/'),
							rt.new_string(''),
							var_row.array_get(rt.new_string('event')),
						])
						var_message = rt.call_function('sprintf', [
							rt.call_function('esc_html', [
								rt.call_function('__', [
									rt.new_string('Comment status was changed to %s'),
									rt.new_string('akismet'),
								]),
							]),
							rt.new_string('<code>' +
								(rt.call_function('esc_html', [var_new_status.clone()])).str() +
								'</code>'),
						])
					} else if rt.is_true(rt.call_function('preg_match', [
						rt.new_string('/^status-/'),
						var_row.array_get(rt.new_string('event')),
					]))
					{
						var_new_status = rt.call_function('preg_replace', [
							rt.new_string('/^status-/'),
							rt.new_string(''),
							var_row.array_get(rt.new_string('event')),
						])
						if var_row.array_isset(rt.new_string('user')) {
							var_message = rt.call_function('sprintf', [
								rt.call_function('esc_html', [
									rt.call_function('__', [
										rt.new_string('%1$s changed the comment status to %2$s.'),
										rt.new_string('akismet'),
									]),
								]),
								rt.call_function('esc_html', [
									var_row.array_get(rt.new_string('user')),
								]),
								rt.new_string('<code>' +
									(rt.call_function('esc_html', [var_new_status.clone()])).str() +
									'</code>'),
							])
						}
					}
				}
			}
			if !(!rt.is_true(var_message)) {
				print('<p>')
				if var_row.array_isset(rt.new_string('time')) {
					mut var_time := rt.new_string(
						(rt.call_function('gmdate', [rt.new_string('D d M Y @ h:i:s a'), rt.new_int((var_row.array_get(rt.new_string('time'))).to_i64())])).str() +
						' GMT')
					mut var_time_html := rt.new_string('<span style="color: #999;" alt="' +
						(rt.call_function('esc_attr', [var_time.clone()])).str() + '" title="' +
						(rt.call_function('esc_attr', [var_time.clone()])).str() + '">' +
						(rt.call_function('sprintf', [rt.call_function('esc_html__', [rt.new_string('%s ago'), rt.new_string('akismet')]), rt.call_function('human_time_diff', [var_row.array_get(rt.new_string('time'))])])).str() +
						'</span>')
					rt.call_function('printf', [
						rt.call_function('esc_html', [
							rt.call_function('__', [rt.new_string('%1$s - %2$s'),
								rt.new_string('akismet')]),
						]),
						var_time_html.clone(),
						var_message.clone(),
					])
				} else {
					rt.echo_val(var_message)
				}
				print('</p>')
			}
		}
	} else {
		print('<p>')
		rt.echo_val(rt.call_function('esc_html', [
			rt.call_function('__', [rt.new_string('No comment history.'),
				rt.new_string('akismet')]),
		]))
		print('</p>')
	}
}

fn Class_Akismet_Admin.plugin_action_links(var_links rt.PhpVal, var_file rt.PhpVal) rt.PhpVal {
	mut var_links_mutated := var_links
	if rt.is_true(rt.equal(var_file, rt.call_function('plugin_basename', [
		rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() +
			'/akismet.php'),
	])))
	{
		var_links_mutated.array_push('<a href="' +
			(rt.call_function('esc_url', [Class_Akismet_Admin.get_page_url()])).str() + '">' +
			(rt.call_function('esc_html__', [rt.new_string('Settings'), rt.new_string('akismet')])).str() +
			'</a>')
	}
	return var_links_mutated.clone()
}

fn Class_Akismet_Admin.get_spam_count(type bool) i64 {
	mut var_wpdb := rt.new_null()
	mut type_mutated := type
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(type_mutated))))) {
		mut var_count := rt.call_function('wp_cache_get', [
			rt.new_string('akismet_spam_count'),
			rt.new_string('widget'),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_count)) {
			var_count = rt.call_function('wp_count_comments', []rt.PhpVal{})
			var_count = rt.get_property(var_count, 'spam')
			rt.call_function('wp_cache_set', [rt.new_string('akismet_spam_count'),
				var_count.clone(), rt.new_string('widget'), rt.new_int(3600)])
		}
		return var_count.to_i64()
	} else if rt.is_true(rt.equal(rt.new_string('comments'), rt.new_bool(type_mutated)))
		|| rt.is_true(rt.equal(rt.new_string('comment'), rt.new_bool(type_mutated))) {
		type_mutated = ''
	}
	return rt.new_int((rt.call_method(var_wpdb, 'get_var', [
		rt.call_method(var_wpdb, 'prepare', [
			rt.concat(rt.concat(rt.new_string('SELECT COUNT(comment_ID) FROM '), rt.get_property(var_wpdb,
				'comments')),
				rt.new_string(" WHERE comment_approved = 'spam' AND comment_type = %s")),
			rt.new_bool(type_mutated).clone(),
		]),
	])).to_i64())
}

fn Class_Akismet_Admin.check_server_ip_connectivity() rt.PhpVal {
	mut var_ips := rt.new_array()
	mut var_servers := var_ips
	if rt.is_true(rt.call_function('function_exists', [rt.new_string('gethostbynamel')])) {
		var_ips = rt.call_function('gethostbynamel', [rt.new_string('rest.akismet.com')])
		if rt.is_true(var_ips) && var_ips.clone().is_array()
			&& rt.is_true(rt.new_int(var_ips.clone().array_count())) {
			mut iife_temp_12 := Class_Akismet{}
			mut iife_result_12 := iife_temp_12.get_api_key()
			mut var_api_key := iife_result_12
			mut iter_5 := var_ips.iterator()
			for {
				item_5 := iter_5.next() or { break }
				mut var_ip := item_5.val
				mut iife_temp_13 := Class_Akismet{}
				mut iife_result_13 := iife_temp_13.verify_key(var_api_key.clone(), var_ip.clone())
				mut var_response := iife_result_13
				if rt.is_true(rt.equal(var_response, rt.new_string('valid')))
					|| rt.is_true(rt.equal(var_response, rt.new_string('invalid'))) {
					var_servers.array_set(var_ip, 'connected')
				} else {
					var_servers.array_set(var_ip, if rt.is_true(var_response) {
						var_response
					} else {
						rt.new_string('unable to connect')
					})
				}
			}
		}
	}
	return var_servers.clone()
}

fn Class_Akismet_Admin.check_server_connectivity(cache_timeout i64) bool {
	mut var_GLOBALS := rt.new_null()
	mut var_debug := rt.new_array()
	var_debug['PHP_VERSION'] = rt.get_constant('PHP_VERSION')
	var_debug['WORDPRESS_VERSION'] = var_GLOBALS.array_get(rt.new_string('wp_version'))
	var_debug['AKISMET_VERSION'] = rt.get_constant('AKISMET_VERSION')
	var_debug['AKISMET__PLUGIN_DIR'] = rt.get_constant('AKISMET__PLUGIN_DIR')
	var_debug['SITE_URL'] = rt.call_function('site_url', []rt.PhpVal{})
	var_debug['HOME_URL'] = rt.call_function('home_url', []rt.PhpVal{})
	mut var_servers := rt.call_function('get_option', [
		rt.new_string('akismet_available_servers'),
	])
	if rt.is_true(rt.less(rt.sub(rt.call_function('time', []rt.PhpVal{}), rt.call_function('get_option', [rt.new_string('akismet_connectivity_time')])), rt.new_int(cache_timeout)))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_servers, rt.new_bool(false))))) {
		var_servers = Class_Akismet_Admin.check_server_ip_connectivity()
		rt.call_function('update_option', [rt.new_string('akismet_available_servers'),
			var_servers.clone()])
		rt.call_function('update_option', [rt.new_string('akismet_connectivity_time'),
			rt.call_function('time', []rt.PhpVal{})])
	}
	if rt.is_true(rt.call_function('wp_http_supports', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }]),
	]))
	{
		mut var_response := rt.call_function('wp_remote_get', [
			rt.new_string('https://rest.akismet.com/1.1/test'),
		])
	} else {
		var_response = rt.call_function('wp_remote_get', [
			rt.new_string('http://rest.akismet.com/1.1/test'),
		])
	}
	var_debug['gethostbynamel'] = if rt.is_true(rt.call_function('function_exists', [
		rt.new_string('gethostbynamel'),
	]))
	{ 'exists' } else { 'not here' }
	var_debug['Servers'] = var_servers.clone()
	var_debug['Test Connection'] = var_response.clone()
	mut iife_temp_14 := Class_Akismet{}
	mut iife_result_14 := iife_temp_14.log(var_debug.clone())
	if rt.is_true(var_response)
		&& rt.is_true(rt.equal(rt.new_string('connected'), rt.call_function('wp_remote_retrieve_body', [var_response.clone()]))) {
		return true
	}
	return false
}

fn Class_Akismet_Admin.get_server_connectivity(cache_timeout i64) rt.PhpVal {
	return Class_Akismet_Admin.check_server_connectivity(cache_timeout)
}

fn Class_Akismet_Admin.are_any_comments_waiting_to_be_checked() bool {
	return !(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_comments', [
		rt.create_array([rt.ArrayItem{ key: 'status', val: 'hold' },
			rt.ArrayItem{ key: 'meta_key', val: 'akismet_error' },
			rt.ArrayItem{ key: 'number', val: 1 }]),
	]))))))
}

fn Class_Akismet_Admin.get_page_url(page string) rt.PhpVal {
	mut page_mutated := page
	mut var_args := {
		'page': rt.new_string('akismet-key-config')
	}
	if rt.is_true(rt.equal(rt.new_string(page_mutated), rt.new_string('stats'))) {
		var_args = {
			'page': rt.new_string('akismet-key-config')
			'view': rt.new_string('stats')
		}
	} else if rt.is_true(rt.equal(rt.new_string(page_mutated), rt.new_string('delete_key'))) {
		var_args = {
			'page':     rt.new_string('akismet-key-config')
			'view':     rt.new_string('start')
			'action':   rt.new_string('delete-key')
			'_wpnonce': rt.call_function('wp_create_nonce', [
				rt.new_string(Class_Akismet_Admin.nonce()),
			])
		}
	} else if rt.is_true(rt.identical(rt.new_string(page_mutated), rt.new_string('init'))) {
		var_args = {
			'page': rt.new_string('akismet-key-config')
			'view': rt.new_string('start')
		}
	}
	return rt.call_function('add_query_arg', [rt.create_array_from_native_map(var_args),
		rt.call_function('menu_page_url', [rt.new_string('akismet-key-config'),
			rt.new_bool(false)])])
}

fn Class_Akismet_Admin.get_akismet_user(var_api_key rt.PhpVal) rt.PhpVal {
	mut var_api_key_mutated := var_api_key
	mut var_request_args := rt.create_array([
		rt.ArrayItem{ key: 'key', val: var_api_key_mutated },
		rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [
			rt.new_string('home'),
		]) },
	])
	var_request_args = rt.call_function('apply_filters', [
		rt.new_string('akismet_request_args'),
		var_request_args.clone(),
		rt.new_string('get-subscription'),
	])
	mut iife_temp_15 := Class_Akismet{}
	mut iife_result_15 := iife_temp_15.build_query(var_request_args.clone())
	mut iife_temp_16 := Class_Akismet{}
	mut iife_result_16 := iife_temp_16.http_post(iife_result_15, rt.new_string('get-subscription'))
	mut var_subscription_verification := iife_result_16
	mut var_akismet_user := rt.new_bool(false)
	if !(!rt.is_true(var_subscription_verification.array_get(rt.new_int(1)))) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('invalid'),
			var_subscription_verification.array_get(rt.new_int(1))))))
		{
			mut var_decoded := rt.call_function('json_decode', [
				var_subscription_verification.array_get(rt.new_int(1)),
			])
			if rt.is_true(rt.new_bool(var_decoded.clone().is_object())) {
				var_akismet_user = var_decoded.clone()
			}
		}
	}
	return var_akismet_user.clone()
}

fn Class_Akismet_Admin.get_stats(var_api_key rt.PhpVal) rt.PhpVal {
	mut var_api_key_mutated := var_api_key
	mut var_stat_totals := rt.new_array()
	mut iter_6 := rt.create_array([rt.ArrayItem{ key: none, val: '6-months' },
		rt.ArrayItem{ key: none, val: 'all' }]).iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_interval := item_6.val
		mut var_request_args := rt.create_array([
			rt.ArrayItem{ key: 'blog', val: rt.call_function('get_option', [
				rt.new_string('home'),
			]) },
			rt.ArrayItem{ key: 'key', val: var_api_key_mutated },
			rt.ArrayItem{ key: 'from', val: var_interval },
		])
		var_request_args = rt.call_function('apply_filters', [
			rt.new_string('akismet_request_args'),
			var_request_args.clone(),
			rt.new_string('get-stats'),
		])
		mut iife_temp_17 := Class_Akismet{}
		mut iife_result_17 := iife_temp_17.build_query(var_request_args.clone())
		mut iife_temp_18 := Class_Akismet{}
		mut iife_result_18 := iife_temp_18.http_post(iife_result_17, rt.new_string('get-stats'))
		mut var_response := iife_result_18
		if !(!rt.is_true(var_response.array_get(rt.new_int(1)))) {
			mut var_data := rt.call_function('json_decode', [
				var_response.array_get(rt.new_int(1))])
			if rt.is_true(rt.new_bool(var_data.clone().is_object())) {
				var_stat_totals.array_set(var_interval, var_data.clone())
			}
		}
	}
	return var_stat_totals.clone()
}

fn Class_Akismet_Admin.verify_wpcom_key(var_api_key rt.PhpVal, var_user_id rt.PhpVal, var_extra rt.PhpVal) rt.PhpVal {
	mut var_api_key_mutated := var_api_key
	mut var_user_id_mutated := var_user_id
	mut var_request_args := rt.call_function('array_merge', [
		rt.create_array([rt.ArrayItem{ key: 'user_id', val: var_user_id_mutated },
			rt.ArrayItem{ key: 'api_key', val: var_api_key_mutated },
			rt.ArrayItem{ key: 'get_account_type', val: 'true' }]),
		var_extra.clone(),
	])
	var_request_args = rt.call_function('apply_filters', [
		rt.new_string('akismet_request_args'),
		var_request_args.clone(),
		rt.new_string('verify-wpcom-key'),
	])
	mut iife_temp_19 := Class_Akismet{}
	mut iife_result_19 := iife_temp_19.build_query(var_request_args.clone())
	mut iife_temp_20 := Class_Akismet{}
	mut iife_result_20 := iife_temp_20.http_post(iife_result_19, rt.new_string('verify-wpcom-key'))
	mut var_akismet_account := iife_result_20
	if !(!rt.is_true(var_akismet_account.array_get(rt.new_int(1)))) {
		var_akismet_account = rt.call_function('json_decode', [
			var_akismet_account.array_get(rt.new_int(1)),
		])
	}
	mut iife_temp_21 := Class_Akismet{}
	mut iife_result_21 := iife_temp_21.log(rt.call_function('compact', [
		rt.new_string('akismet_account'),
	]))
	return var_akismet_account.clone()
}

fn Class_Akismet_Admin.connect_jetpack_user() bool {
	mut var_jetpack_user := Class_Akismet_Admin.get_jetpack_user()
	if rt.is_true(var_jetpack_user) {
		if var_jetpack_user.array_isset(rt.new_string('user_id'))
			&& var_jetpack_user.array_isset(rt.new_string('api_key')) {
			mut var_akismet_user := Class_Akismet_Admin.verify_wpcom_key(var_jetpack_user.array_get(rt.new_string('api_key')),
				var_jetpack_user.array_get(rt.new_string('user_id')), rt.create_array([
				rt.ArrayItem{ key: 'action', val: 'connect_jetpack_user' },
			]))
			if rt.is_true(rt.new_bool(var_akismet_user.clone().is_object())) {
				Class_Akismet_Admin.save_key(rt.get_property(var_akismet_user, 'api_key'))
				return (rt.call_function('in_array', [
					rt.get_property(var_akismet_user, 'status'),
					rt.create_array([
						rt.ArrayItem{ key: none, val: Class_Akismet.user_status_active() },
						rt.ArrayItem{ key: none, val: Class_Akismet.user_status_no_sub() },
					]),
				])).to_bool()
			}
		}
	}
	return false
}

fn Class_Akismet_Admin.display_alert() {
	mut iife_temp_22 := Class_Akismet{}
	mut iife_result_22 := iife_temp_22.view(rt.new_string('notice'), rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'alert' },
		rt.ArrayItem{ key: 'code', val: rt.new_int((rt.call_function('get_option', [
			rt.new_string('akismet_alert_code'),
		])).to_i64()) },
		rt.ArrayItem{ key: 'msg', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_msg'),
		]) },
	]))
}

fn Class_Akismet_Admin.get_usage_limit_alert_data() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'type', val: 'usage-limit' },
		rt.ArrayItem{ key: 'code', val: rt.new_int((rt.call_function('get_option', [
			rt.new_string('akismet_alert_code'),
		])).to_i64()) }, rt.ArrayItem{ key: 'msg', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_msg'),
		]) }, rt.ArrayItem{ key: 'api_calls', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_api_calls'),
		]) }, rt.ArrayItem{ key: 'usage_limit', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_usage_limit'),
		]) }, rt.ArrayItem{ key: 'upgrade_plan', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_upgrade_plan'),
		]) }, rt.ArrayItem{ key: 'upgrade_url', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_upgrade_url'),
		]) }, rt.ArrayItem{ key: 'upgrade_type', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_upgrade_type'),
		]) }, rt.ArrayItem{ key: 'upgrade_via_support', val: rt.identical(rt.call_function('get_option', [
			rt.new_string('akismet_alert_upgrade_via_support'),
		]), rt.new_string('true')) }, rt.ArrayItem{ key: 'recommended_plan_name', val: rt.call_function('get_option', [
			rt.new_string('akismet_alert_recommended_plan_name'),
		]) }])
}

fn Class_Akismet_Admin.display_usage_limit_alert() {
	mut iife_temp_23 := Class_Akismet{}
	mut iife_result_23 := iife_temp_23.view(rt.new_string('notice'),
		Class_Akismet_Admin.get_usage_limit_alert_data())
}

fn Class_Akismet_Admin.display_spam_check_warning() {
	mut iife_temp_24 := Class_Akismet{}
	mut iife_result_24 := iife_temp_24.fix_scheduled_recheck()
	if rt.is_true(rt.greater(rt.call_function('wp_next_scheduled', [rt.new_string('akismet_schedule_cron_recheck')]), rt.call_function('time', []rt.PhpVal{})))
		&& rt.is_true(Class_Akismet_Admin.are_any_comments_waiting_to_be_checked()) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('DISABLE_WP_CRON')]))
			&& rt.is_true(rt.get_constant('DISABLE_WP_CRON'))
			&& rt.is_true(rt.call_function('apply_filters', [rt.new_string('akismet_display_cron_disabled_notice'), rt.new_bool(true)])) {
			mut iife_temp_25 := Class_Akismet{}
			mut iife_result_25 := iife_temp_25.view(rt.new_string('notice'), rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'spam-check-cron-disabled' },
			]))
		} else {
			mut var_link_text := rt.call_function('apply_filters', [
				rt.new_string('akismet_spam_check_warning_link_text'),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Please check your <a href="%s">Akismet configuration</a> and contact your web host if problems persist.'),
						rt.new_string('akismet'),
					]),
					rt.call_function('esc_url', [
						Class_Akismet_Admin.get_page_url(),
					]),
				]),
			])
			mut iife_temp_26 := Class_Akismet{}
			mut iife_result_26 := iife_temp_26.view(rt.new_string('notice'), rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'spam-check' },
				rt.ArrayItem{ key: 'link_text', val: var_link_text },
			]))
		}
	}
}

fn Class_Akismet_Admin.display_api_key_warning() {
	mut iife_temp_27 := Class_Akismet{}
	mut iife_result_27 := iife_temp_27.view(rt.new_string('notice'), rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'plugin' },
	]))
}

fn Class_Akismet_Admin.display_page() {
	mut iife_temp_28 := Class_Akismet{}
	mut iife_result_28 := iife_temp_28.get_api_key()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_28))))
		|| (rt.get_superglobal('_GET').array_isset(rt.new_string('view'))
		&& rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get(rt.new_string('view')), rt.new_string('start')))) {
		Class_Akismet_Admin.display_start_page()
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('view'))
		&& rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get(rt.new_string('view')), rt.new_string('stats'))) {
		Class_Akismet_Admin.display_stats_page()
	} else {
		Class_Akismet_Admin.display_configuration_page()
	}
}

fn Class_Akismet_Admin.display_start_page() {
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) {
		if rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get(rt.new_string('action')),
			rt.new_string('delete-key')))
		{
			if rt.get_superglobal('_GET').array_isset(rt.new_string('_wpnonce'))
				&& rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce')).is_string()
				&& rt.is_true(rt.call_function('wp_verify_nonce', [rt.get_superglobal('_GET').array_get(rt.new_string('_wpnonce')), rt.new_string(Class_Akismet_Admin.nonce())])) {
				rt.call_function('delete_option', [rt.new_string('wordpress_api_key')])
			}
		}
	}
	mut iife_temp_29 := Class_Akismet{}
	mut iife_result_29 := iife_temp_29.get_api_key()
	mut var_api_key := iife_result_29
	mut var_existing_key_is_valid := rt.new_bool(!(rt.is_true(rt.identical(Class_Akismet_Admin.get_notice_by_key(rt.new_string('status')),
		Class_Akismet_Admin.notice_existing_key_invalid()))))
	if rt.is_true(var_api_key) && rt.is_true(var_existing_key_is_valid) {
		Class_Akismet_Admin.display_configuration_page()
		return
	}
	mut var_akismet_user := rt.new_bool(false)
	if rt.get_superglobal('_GET').array_isset(rt.new_string('token'))
		&& rt.is_true(rt.call_function('preg_match', [rt.new_string('/^(\\d+)-[0-9a-f]{20}$/'), rt.get_superglobal('_GET').array_get(rt.new_string('token'))])) {
		var_akismet_user = Class_Akismet_Admin.verify_wpcom_key(rt.new_string(''),
			rt.new_string(''), rt.create_array([
			rt.ArrayItem{
				key: 'token'
				val: rt.get_superglobal('_GET').array_get(rt.new_string('token'))
			},
		]))
	}
	if rt.is_true(rt.identical(rt.new_bool(false), var_akismet_user)) {
		mut var_jetpack_user := Class_Akismet_Admin.get_jetpack_user()
		if rt.is_true(rt.new_bool(var_jetpack_user.clone().is_array())) {
			var_akismet_user = Class_Akismet_Admin.verify_wpcom_key(var_jetpack_user.array_get(rt.new_string('api_key')),
				var_jetpack_user.array_get(rt.new_string('user_id')))
		}
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('action')) {
		if rt.is_true(rt.equal(rt.get_superglobal('_GET').array_get(rt.new_string('action')),
			rt.new_string('save-key')))
		{
			if rt.is_true(rt.new_bool(var_akismet_user.clone().is_object())) {
				Class_Akismet_Admin.save_key(rt.get_property(var_akismet_user, 'api_key'))
				Class_Akismet_Admin.display_configuration_page()
				return
			}
		}
	}
	mut iife_temp_30 := Class_Akismet{}
	mut iife_result_30 := iife_temp_30.view(rt.new_string('start'), rt.call_function('compact', [
		rt.new_string('akismet_user'),
	]))
}

fn Class_Akismet_Admin.display_stats_page() {
	mut iife_temp_31 := Class_Akismet{}
	mut iife_result_31 := iife_temp_31.view(rt.new_string('stats'))
}

fn Class_Akismet_Admin.display_configuration_page() {
	mut iife_temp_32 := Class_Akismet{}
	mut iife_result_32 := iife_temp_32.get_api_key()
	mut var_api_key := iife_result_32
	mut var_akismet_user := Class_Akismet_Admin.get_akismet_user(var_api_key.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_akismet_user)))) {
		rt.get_static_prop('Akismet_Admin', 'notices').array_set('status',
			Class_Akismet_Admin.notice_existing_key_invalid())
		Class_Akismet_Admin.display_start_page()
		return
	}
	mut var_stat_totals := Class_Akismet_Admin.get_stats(var_api_key.clone())
	if rt.is_true(rt.identical(rt.call_function('get_option', [
		rt.new_string('akismet_strictness'),
	]), rt.new_bool(false)))
	{
		rt.call_function('add_option', [rt.new_string('akismet_strictness'),
			rt.new_string((if rt.is_true(rt.identical(rt.call_function('get_option', [
				rt.new_string('akismet_discard_month'),
			]), rt.new_string('false')))
			{ '0' } else { '1' }).str())])
	}
	if var_stat_totals.array_isset(rt.new_string('all'))
		&& !(rt.get_property(var_stat_totals.array_get(rt.new_string('all')), 'spam')).is_null() {
		rt.call_function('update_option', [rt.new_string('akismet_spam_count'),
			rt.get_property(var_stat_totals.array_get(rt.new_string('all')), 'spam')])
	}
	mut var_notices := rt.new_array()
	if !rt.is_true(rt.get_static_prop('Akismet_Admin', 'notices')) {
		if !(!rt.is_true(var_stat_totals.array_get(rt.new_string('all'))))
			&& !(rt.get_property(var_stat_totals.array_get(rt.new_string('all')), 'time_saved')).is_null()
			&& rt.is_true(rt.equal(rt.get_property(var_akismet_user, 'status'), Class_Akismet.user_status_active()))
			&& rt.is_true(rt.equal(rt.get_property(var_akismet_user, 'account_type'), rt.new_string('free-api-key'))) {
			mut var_time_saved := rt.new_bool(false)
			if rt.is_true(rt.greater(rt.get_property(var_stat_totals.array_get(rt.new_string('all')),
				'time_saved'), rt.new_int(1800)))
			{
				mut var_total_in_minutes := rt.call_function('round', [
					rt.div(rt.get_property(var_stat_totals.array_get(rt.new_string('all')),
						'time_saved'), rt.new_int(60)),
				])
				mut var_total_in_hours := rt.call_function('round', [
					rt.div(var_total_in_minutes, rt.new_int(60)),
				])
				mut var_total_in_days := rt.call_function('round', [
					rt.div(var_total_in_hours, rt.new_int(8)),
				])
				mut var_cleaning_up := rt.call_function('__', [
					rt.new_string('Cleaning up spam takes time.'),
					rt.new_string('akismet'),
				])
				if rt.is_true(rt.greater(var_total_in_days, rt.new_int(1))) {
					var_time_saved =
						rt.new_string(var_cleaning_up.str() + ' ' +(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Akismet has saved you %s day!'), rt.new_string('Akismet has saved you %s days!'), var_total_in_days.clone(), rt.new_string('akismet')]), rt.call_function('number_format_i18n', [var_total_in_days.clone()])])).str())
				} else if rt.is_true(rt.greater(var_total_in_hours, rt.new_int(1))) {
					var_time_saved =
						rt.new_string(var_cleaning_up.str() + ' ' +(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Akismet has saved you %d hour!'), rt.new_string('Akismet has saved you %d hours!'), var_total_in_hours.clone(), rt.new_string('akismet')]), var_total_in_hours.clone()])).str())
				} else if rt.is_true(rt.greater_equal(var_total_in_minutes, rt.new_int(30))) {
					var_time_saved =
						rt.new_string(var_cleaning_up.str() + ' ' +(rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('Akismet has saved you %d minute!'), rt.new_string('Akismet has saved you %d minutes!'), var_total_in_minutes.clone(), rt.new_string('akismet')]), var_total_in_minutes.clone()])).str())
				}
			}
			var_notices << rt.create_array([
				rt.ArrayItem{ key: 'type', val: 'active-notice' },
				rt.ArrayItem{ key: 'time_saved', val: var_time_saved },
			])
		}
	}
	mut iife_temp_33 := Class_Akismet{}
	mut iife_result_33 := iife_temp_33.predefined_api_key()
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_33))))
		&& !(rt.get_static_prop('Akismet_Admin', 'notices').array_isset(rt.new_string('status')))
		&& rt.is_true(rt.call_function('in_array', [rt.get_property(var_akismet_user, 'status'), rt.create_array([rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_cancelled()
	}, rt.ArrayItem{ key: none, val: Class_Akismet.user_status_suspended() }, rt.ArrayItem{
		key: none
		val: Class_Akismet.user_status_missing()
	}, rt.ArrayItem{ key: none, val: Class_Akismet.user_status_no_sub() }])])) {
		var_notices << rt.create_array([
			rt.ArrayItem{ key: 'type', val: rt.get_property(var_akismet_user, 'status') },
		])
	}
	mut var_alert_code := rt.call_function('get_option', [
		rt.new_string('akismet_alert_code'),
	])
	if rt.get_static_prop('Akismet', 'limit_notices').array_isset(var_alert_code) {
		var_notices << Class_Akismet_Admin.get_usage_limit_alert_data()
	} else if rt.is_true(rt.greater(var_alert_code, rt.new_int(0))) {
		var_notices << rt.create_array([rt.ArrayItem{ key: 'type', val: 'alert' },
			rt.ArrayItem{ key: 'code', val: rt.new_int((rt.call_function('get_option', [
				rt.new_string('akismet_alert_code'),
			])).to_i64()) }, rt.ArrayItem{ key: 'msg', val: rt.call_function('get_option', [
				rt.new_string('akismet_alert_msg'),
			]) }])
	}
	mut iife_temp_34 := Class_Akismet{}
	mut iife_result_34 := iife_temp_34.log(rt.call_function('compact', [
		rt.new_string('stat_totals'),
		rt.new_string('akismet_user'),
	]))
	mut iife_temp_35 := Class_Akismet{}
	mut iife_result_35 := iife_temp_35.view(rt.new_string('config'), rt.call_function('compact', [
		rt.new_string('api_key'),
		rt.new_string('akismet_user'),
		rt.new_string('stat_totals'),
		rt.new_string('notices'),
	]))
}

fn Class_Akismet_Admin.display_notice() {
	mut var_hook_suffix := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [var_hook_suffix.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'jetpack_page_akismet-key-config' },
			rt.ArrayItem{ key: none, val: 'settings_page_akismet-key-config' },
		])]))
	{
		return
	}
	if rt.is_true(rt.call_function('in_array', [var_hook_suffix.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'edit-comments.php'
	}])]))
		&& rt.new_int((rt.call_function('get_option', [rt.new_string('akismet_alert_code')])).to_i64()) > 0 {
		mut iife_temp_36 := Class_Akismet{}
		mut iife_result_36 := iife_temp_36.get_api_key()
		mut iife_temp_37 := Class_Akismet{}
		mut iife_result_37 := iife_temp_37.verify_key(iife_result_36)
		mut var_alert_code := rt.call_function('get_option', [
			rt.new_string('akismet_alert_code'),
		])
		if rt.get_static_prop('Akismet', 'limit_notices').array_isset(var_alert_code) {
			Class_Akismet_Admin.display_usage_limit_alert()
		} else if rt.is_true(rt.greater(var_alert_code, rt.new_int(0))) {
			Class_Akismet_Admin.display_alert()
		}
		mut iife_temp_38 := Class_Akismet{}
		mut iife_result_38 := iife_temp_38.get_api_key()
	} else if
		rt.is_true(rt.call_function('in_array', [var_hook_suffix.clone(), rt.get_static_prop('Akismet_Admin', 'activation_banner_pages'), rt.new_bool(true)]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_38)))) {
		Class_Akismet_Admin.display_api_key_warning()
	} else if rt.is_true(rt.equal(var_hook_suffix, rt.new_string('edit-comments.php')))
		&& rt.is_true(rt.call_function('wp_next_scheduled', [rt.new_string('akismet_schedule_cron_recheck')])) {
		Class_Akismet_Admin.display_spam_check_warning()
	}
	if rt.get_superglobal('_GET').array_isset(rt.new_string('akismet_recheck_complete')) {
		mut var_recheck_count :=
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('recheck_count'))).to_i64())
		mut var_spam_count :=
			rt.new_int((rt.get_superglobal('_GET').array_get(rt.new_string('spam_count'))).to_i64())
		if rt.is_true(rt.identical(var_recheck_count, rt.new_int(0))) {
			mut var_message := rt.call_function('__', [
				rt.new_string('There were no comments to check. Akismet will only check comments awaiting moderation.'),
				rt.new_string('akismet'),
			])
		} else {
			var_message = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('Akismet checked %s comment.'),
					rt.new_string('Akismet checked %s comments.'),
					var_recheck_count.clone(), rt.new_string('akismet')]),
				rt.call_function('number_format', [var_recheck_count.clone()]),
			])
			var_message = rt.concat(var_message, rt.new_string(' '))
			if rt.is_true(rt.identical(var_spam_count, rt.new_int(0))) {
				var_message = rt.concat(var_message, rt.call_function('__', [
					rt.new_string('No comments were caught as spam.'),
					rt.new_string('akismet'),
				]))
			} else {
				var_message = rt.concat(var_message, rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%s comment was caught as spam.'),
						rt.new_string('%s comments were caught as spam.'),
						var_spam_count.clone(),
						rt.new_string('akismet'),
					]),
					rt.call_function('number_format', [
						var_spam_count.clone(),
					]),
				]))
			}
		}
		print('<div class="notice notice-success"><p>' +
			(rt.call_function('esc_html', [var_message.clone()])).str() + '</p></div>')
	} else if rt.get_superglobal('_GET').array_isset(rt.new_string('akismet_recheck_error')) {
		print('<div class="notice notice-error"><p>' +
			(rt.call_function('esc_html', [rt.call_function('__', [rt.new_string('Akismet could not recheck your comments for spam.'), rt.new_string('akismet')])])).str() +
			'</p></div>')
	}
}

fn Class_Akismet_Admin.display_status() {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet_Admin.get_server_connectivity())))) {
		mut iife_temp_39 := Class_Akismet{}
		mut iife_result_39 := iife_temp_39.view(rt.new_string('notice'), rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'servers-be-down' },
		]))
	} else if !(!rt.is_true(rt.get_static_prop('Akismet_Admin', 'notices'))) {
		mut iter_7 := rt.get_static_prop('Akismet_Admin', 'notices').iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_type := item_7.val
			mut var_index := item_7.key
			if rt.is_true(rt.new_bool(var_type.clone().is_object())) {
				mut var_notice_text := rt.new_string('')
				mut var_notice_header := var_notice_text
				if rt.is_true(rt.call_function('property_exists', [
					var_type.clone(), rt.new_string('notice_header')]))
				{
					var_notice_header = rt.call_function('wp_kses', [
						rt.get_property(var_type, 'notice_header'),
						rt.get_static_prop('Akismet_Admin', 'allowed'),
					])
				}
				if rt.is_true(rt.call_function('property_exists', [
					var_type.clone(), rt.new_string('notice_text')]))
				{
					var_notice_text = rt.call_function('wp_kses', [
						rt.get_property(var_type, 'notice_text'),
						rt.get_static_prop('Akismet_Admin', 'allowed'),
					])
				}
				if rt.is_true(rt.call_function('property_exists', [
					var_type.clone(), rt.new_string('status')]))
				{
					var_type = rt.call_function('wp_kses', [
						rt.get_property(var_type, 'status'),
						rt.get_static_prop('Akismet_Admin', 'allowed'),
					])
					mut iife_temp_40 := Class_Akismet{}
					mut iife_result_40 := iife_temp_40.view(rt.new_string('notice'), rt.call_function('compact', [
						rt.new_string('type'),
						rt.new_string('notice_header'),
						rt.new_string('notice_text'),
					]))
					rt.get_static_prop('Akismet_Admin', 'notices').array_unset(var_index)
				}
			} else {
				mut iife_temp_41 := Class_Akismet{}
				mut iife_result_41 := iife_temp_41.view(rt.new_string('notice'), rt.call_function('compact', [
					rt.new_string('type'),
				]))
				rt.get_static_prop('Akismet_Admin', 'notices').array_unset(var_index)
			}
		}
	}
}

fn Class_Akismet_Admin.get_notice_by_key(var_key rt.PhpVal) rt.PhpVal {
	return if !(rt.get_static_prop('Akismet_Admin', 'notices').array_get(var_key)).is_null() {
		rt.get_static_prop('Akismet_Admin', 'notices').array_get(var_key)
	} else {
		rt.new_null()
	}
}

fn Class_Akismet_Admin.get_jetpack_user() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Akismet_Admin.is_jetpack_active())))) {
		return false
	}
	if rt.is_true(rt.call_function('defined', [rt.new_string('JETPACK__VERSION')]))
		&& rt.is_true(rt.call_function('version_compare', [rt.get_constant('JETPACK__VERSION'), rt.new_string('7.7'), rt.new_string('<')])) {
		mut iife_temp_42 := Class_Jetpack{}
		mut iife_result_42 := iife_temp_42.load_xml_rpc_client()
	}
	mut var_xml := create_jetpack_ixr_clientmulticall(rt.create_array([
		rt.ArrayItem{ key: 'user_id', val: rt.call_function('get_current_user_id', []rt.PhpVal{}) },
	]))
	var_xml.addcall(rt.new_string('wpcom.getUserID'))
	var_xml.addcall(rt.new_string('akismet.getAPIKey'))
	var_xml.query()
	mut iife_temp_43 := Class_Akismet{}
	mut iife_result_43 := iife_temp_43.log(rt.call_function('compact', [
		rt.new_string('xml'),
	]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_xml.iserror())))) {
		mut var_responses := var_xml.getresponse()
		if if rt.call_function('is_countable', [var_responses.clone()]) {
			var_responses.clone().array_count()
		} else {
			0
		} > 1 {
			mut var_first_response_value := rt.call_function('array_shift', [
				var_responses.array_get(rt.new_int(0)),
			])
			mut var_second_response_value := rt.call_function('array_shift', [
				var_responses.array_get(rt.new_int(1)),
			])
			if rt.is_true(rt.call_function('preg_match', [
				rt.new_string('/^[a-f0-9]{12}$/i'),
				var_first_response_value.clone(),
			]))
			{
				mut var_api_key := var_first_response_value.clone()
				mut var_user_id := rt.new_int(var_second_response_value.to_i64())
			} else {
				var_api_key = var_second_response_value.clone()
				var_user_id = rt.new_int(var_first_response_value.to_i64())
			}
			return (rt.call_function('compact', [rt.new_string('api_key'),
				rt.new_string('user_id')])).to_bool()
		}
	}
	return false
}

fn Class_Akismet_Admin.exclude_commentmeta_from_export(var_exclude rt.PhpVal, var_key rt.PhpVal, var_meta rt.PhpVal) bool {
	if rt.is_true(rt.call_function('in_array', [var_key.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'akismet_as_submitted' },
			rt.ArrayItem{ key: none, val: 'akismet_delay_moderation_email' },
			rt.ArrayItem{ key: none, val: 'akismet_delayed_moderation_email' },
			rt.ArrayItem{ key: none, val: 'akismet_rechecking' },
			rt.ArrayItem{ key: none, val: 'akismet_schedule_approval_fallback' },
			rt.ArrayItem{ key: none, val: 'akismet_schedule_email_fallback' },
			rt.ArrayItem{ key: none, val: 'akismet_skipped_microtime' }])]))
	{
		return true
	}
	return var_exclude.to_bool()
}

fn Class_Akismet_Admin.modify_plugin_description(var_all_plugins rt.PhpVal) rt.PhpVal {
	if var_all_plugins.array_isset(rt.new_string('akismet/akismet.php')) {
		mut iife_temp_44 := Class_Akismet{}
		mut iife_result_44 := iife_temp_44.get_api_key()
		if rt.is_true(iife_result_44) {
			var_all_plugins.array_get_mut('akismet/akismet.php').array_set('Description', rt.call_function('__', [
				rt.new_string('Used by millions, Akismet is quite possibly the best way in the world to <strong>protect your blog from spam</strong>. Your site is fully configured and being protected, even while you sleep.'),
				rt.new_string('akismet'),
			]))
		} else {
			var_all_plugins.array_get_mut('akismet/akismet.php').array_set('Description', rt.call_function('__', [
				rt.new_string('Used by millions, Akismet is quite possibly the best way in the world to <strong>protect your blog from spam</strong>. It keeps your site protected even while you sleep. To get started, just go to <a href="admin.php?page=akismet-key-config">your Akismet Settings page</a> to set up your API key.'),
				rt.new_string('akismet'),
			]))
		}
	}
	return var_all_plugins.clone()
}

fn Class_Akismet_Admin.set_form_privacy_notice_option(var_state rt.PhpVal) {
	if rt.is_true(rt.call_function('in_array', [var_state.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'display' },
			rt.ArrayItem{ key: none, val: 'hide' }])]))
	{
		rt.call_function('update_option', [
			rt.new_string('akismet_comment_form_privacy_notice'),
			var_state.clone(),
		])
	}
}

fn Class_Akismet_Admin.register_personal_data_eraser(var_erasers rt.PhpVal) rt.PhpVal {
	mut var_erasers_mutated := var_erasers
	var_erasers_mutated.array_set('akismet', rt.create_array([
		rt.ArrayItem{ key: 'eraser_friendly_name', val: rt.call_function('__', [
			rt.new_string('Akismet'),
			rt.new_string('akismet'),
		]) },
		rt.ArrayItem{ key: 'callback', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'Akismet_Admin' },
			rt.ArrayItem{ key: none, val: 'erase_personal_data' },
		]) },
	]))
	return var_erasers_mutated.clone()
}

fn Class_Akismet_Admin.erase_personal_data(var_email_address rt.PhpVal, page i64) rt.PhpVal {
	mut page_mutated := page
	mut var_items_removed := rt.new_bool(false)
	mut var_number := rt.new_int(50)
	page_mutated = page_mutated
	mut var_comments := rt.call_function('get_comments', [
		rt.create_array([rt.ArrayItem{ key: 'author_email', val: var_email_address },
			rt.ArrayItem{ key: 'number', val: var_number }, rt.ArrayItem{
				key: 'paged'
				val: page_mutated
			}, rt.ArrayItem{ key: 'order_by', val: 'comment_ID' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }]),
	])
	mut iter_8 := rt.cast_array(var_comments).iterator()
	for {
		item_8 := iter_8.next() or { break }
		mut var_comment := item_8.val
		mut var_comment_as_submitted := rt.call_function('get_comment_meta', [
			rt.get_property(var_comment, 'comment_ID'),
			rt.new_string('akismet_as_submitted'),
			rt.new_bool(true),
		])
		if rt.is_true(var_comment_as_submitted) {
			rt.call_function('delete_comment_meta', [
				rt.get_property(var_comment, 'comment_ID'),
				rt.new_string('akismet_as_submitted'),
			])
			var_items_removed = rt.new_bool(true)
		}
	}
	mut var_done := rt.less(if rt.call_function('is_countable', [
		var_comments.clone()])
	{ var_comments.clone().array_count() } else { 0 }, var_number)
	return rt.create_array([rt.ArrayItem{ key: 'items_removed', val: var_items_removed },
		rt.ArrayItem{ key: 'items_retained', val: false }, rt.ArrayItem{
			key: 'messages'
			val: rt.new_array()
		}, rt.ArrayItem{ key: 'done', val: var_done }])
}

fn Class_Akismet_Admin.get_notice_kses_allowed_elements() rt.PhpVal {
	return rt.get_static_prop('Akismet_Admin', 'allowed')
}

fn Class_Akismet_Admin.get_asset_file_version(var_relative_path rt.PhpVal) rt.PhpVal {
	mut var_full_path := rt.new_string(
		(rt.get_constant('AKISMET__PLUGIN_DIR')).str() + var_relative_path.str())
	if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[a-z]/'), rt.get_constant('AKISMET_VERSION')]))
		&& rt.is_true(rt.call_function('file_exists', [var_full_path.clone()])) {
		return rt.call_function('filemtime', [var_full_path.clone()])
	}
	return rt.get_constant('AKISMET_VERSION')
}

fn Class_Akismet_Admin.get_inline_css() string {
	mut var_hook_suffix := rt.new_null()
	mut var_inline_css := rt.new_string('\n\t\t\t.akismet-compatible-plugins__card:nth-child(n+' +
		(rt.call_function('esc_attr', [rt.add(Class_Akismet_Compatible_Plugins.default_visible_plugin_count(), rt.new_int(1))])).str() +
		') {\n\t\t\t\tdisplay: none;\n\t\t\t}\n\n\t\t\t.akismet-compatible-plugins__list.is-expanded .akismet-compatible-plugins__card:nth-child(n+' +
		(rt.call_function('esc_attr', [rt.add(Class_Akismet_Compatible_Plugins.default_visible_plugin_count(), rt.new_int(1))])).str() +
		') {\n\t\t\t\tdisplay: flex;\n\t\t\t}\n\t\t')
	if rt.is_true(rt.call_function('in_array', [var_hook_suffix.clone(),
		rt.get_static_prop('Akismet_Admin', 'activation_banner_pages'),
		rt.new_bool(true)]))
	{
		mut var_activation_banner_url := rt.call_function('esc_url', [
			rt.new_string((rt.call_function('plugin_dir_url', [rt.new_string(@FILE)])).str() +
				'_inc/img/akismet-activation-banner-elements.png'),
		])
		var_inline_css = rt.concat(var_inline_css, rt.new_string('.akismet-activate {' +
			(rt.get_constant('PHP_EOL')).str() + 'background-image: url(' + var_activation_banner_url.str() +
			');' + (rt.get_constant('PHP_EOL')).str() + '}'))
	}
	return var_inline_css.str()
}

struct Class_Akismet {
	rt.PhpObjectBase
}

struct Class_Jetpack {
	rt.PhpObjectBase
}

struct Class_Jetpack_IXR_ClientMulticall {
	rt.PhpObjectBase
}

fn create_akismet_admin(_args ...rt.PhpVal) &Class_Akismet_Admin {
	mut obj := &Class_Akismet_Admin{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_akismet(_args ...rt.PhpVal) &Class_Akismet {
	mut obj := &Class_Akismet{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack(_args ...rt.PhpVal) &Class_Jetpack {
	mut obj := &Class_Jetpack{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_jetpack_ixr_clientmulticall(_args ...rt.PhpVal) &Class_Jetpack_IXR_ClientMulticall {
	mut obj := &Class_Jetpack_IXR_ClientMulticall{
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
			return rt.new_int(Class_Akismet_Admin.get_spam_count(dispatch_arg_0))
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
			return Class_Akismet_Admin.verify_wpcom_key(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
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
			return rt.new_bool(Class_Akismet_Admin.exclude_commentmeta_from_export(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2))
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
		else {
			return none
		}
	}
}

fn (this &Class_Akismet_Admin) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Admin) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

fn (mut this Class_Jetpack) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Jetpack_IXR_ClientMulticall) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Jetpack_IXR_ClientMulticall) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Jetpack_IXR_ClientMulticall) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

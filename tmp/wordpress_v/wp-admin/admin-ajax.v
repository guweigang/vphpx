import rt

const global_const_doing_ajax = true

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_ADMIN'),
	])))))
	{
		rt.call_function('define', [rt.new_string('WP_ADMIN'),
			rt.new_bool(true)])
	}
	rt.include_file((rt.call_function('dirname', [rt.new_string(@DIR)])).str() + '/wp-load.php',
		'4')
	rt.call_function('send_origin_headers', []rt.PhpVal{})
	rt.call_function('header', [
		'Content-Type: text/html; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str(),
	])
	rt.call_function('header', [rt.new_string('X-Robots-Tag: noindex')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.get_superglobal('_REQUEST').array_get('action'))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [rt.get_superglobal('_REQUEST').array_get('action')])))))))
	{
		rt.call_function('wp_die', [rt.new_string('0'), rt.new_int(400)])
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/admin.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/ajax-actions.php', '4')
	rt.call_function('send_nosniff_header', []rt.PhpVal{})
	rt.call_function('nocache_headers', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('admin_init')])
	mut var_core_actions_get := ['fetch-list', 'ajax-tag-search', 'wp-compression-test',
		'imgedit-preview', 'oembed-cache', 'autocomplete-user', 'dashboard-widgets', 'logged-in',
		'rest-nonce']
	mut var_core_actions_post := rt.create_array([
		rt.ArrayItem{ key: none, val: 'oembed-cache' },
		rt.ArrayItem{ key: none, val: 'image-editor' },
		rt.ArrayItem{ key: none, val: 'delete-comment' },
		rt.ArrayItem{ key: none, val: 'delete-tag' },
		rt.ArrayItem{ key: none, val: 'delete-link' },
		rt.ArrayItem{ key: none, val: 'delete-meta' },
		rt.ArrayItem{ key: none, val: 'delete-post' },
		rt.ArrayItem{ key: none, val: 'trash-post' },
		rt.ArrayItem{ key: none, val: 'untrash-post' },
		rt.ArrayItem{ key: none, val: 'delete-page' },
		rt.ArrayItem{ key: none, val: 'dim-comment' },
		rt.ArrayItem{ key: none, val: 'add-link-category' },
		rt.ArrayItem{ key: none, val: 'add-tag' },
		rt.ArrayItem{ key: none, val: 'get-tagcloud' },
		rt.ArrayItem{ key: none, val: 'get-comments' },
		rt.ArrayItem{ key: none, val: 'replyto-comment' },
		rt.ArrayItem{ key: none, val: 'edit-comment' },
		rt.ArrayItem{ key: none, val: 'add-menu-item' },
		rt.ArrayItem{ key: none, val: 'add-meta' },
		rt.ArrayItem{ key: none, val: 'add-user' },
		rt.ArrayItem{ key: none, val: 'closed-postboxes' },
		rt.ArrayItem{ key: none, val: 'hidden-columns' },
		rt.ArrayItem{ key: none, val: 'update-welcome-panel' },
		rt.ArrayItem{ key: none, val: 'menu-get-metabox' },
		rt.ArrayItem{ key: none, val: 'wp-link-ajax' },
		rt.ArrayItem{ key: none, val: 'menu-locations-save' },
		rt.ArrayItem{ key: none, val: 'menu-quick-search' },
		rt.ArrayItem{ key: none, val: 'meta-box-order' },
		rt.ArrayItem{ key: none, val: 'get-permalink' },
		rt.ArrayItem{ key: none, val: 'sample-permalink' },
		rt.ArrayItem{ key: none, val: 'inline-save' },
		rt.ArrayItem{ key: none, val: 'inline-save-tax' },
		rt.ArrayItem{ key: none, val: 'find_posts' },
		rt.ArrayItem{ key: none, val: 'widgets-order' },
		rt.ArrayItem{ key: none, val: 'save-widget' },
		rt.ArrayItem{ key: none, val: 'delete-inactive-widgets' },
		rt.ArrayItem{ key: none, val: 'set-post-thumbnail' },
		rt.ArrayItem{ key: none, val: 'date_format' },
		rt.ArrayItem{ key: none, val: 'time_format' },
		rt.ArrayItem{ key: none, val: 'wp-remove-post-lock' },
		rt.ArrayItem{ key: none, val: 'dismiss-wp-pointer' },
		rt.ArrayItem{ key: none, val: 'upload-attachment' },
		rt.ArrayItem{ key: none, val: 'get-attachment' },
		rt.ArrayItem{ key: none, val: 'query-attachments' },
		rt.ArrayItem{ key: none, val: 'save-attachment' },
		rt.ArrayItem{ key: none, val: 'save-attachment-compat' },
		rt.ArrayItem{ key: none, val: 'send-link-to-editor' },
		rt.ArrayItem{ key: none, val: 'send-attachment-to-editor' },
		rt.ArrayItem{ key: none, val: 'save-attachment-order' },
		rt.ArrayItem{ key: none, val: 'media-create-image-subsizes' },
		rt.ArrayItem{ key: none, val: 'heartbeat' },
		rt.ArrayItem{ key: none, val: 'get-revision-diffs' },
		rt.ArrayItem{ key: none, val: 'save-user-color-scheme' },
		rt.ArrayItem{ key: none, val: 'update-widget' },
		rt.ArrayItem{ key: none, val: 'query-themes' },
		rt.ArrayItem{ key: none, val: 'parse-embed' },
		rt.ArrayItem{ key: none, val: 'set-attachment-thumbnail' },
		rt.ArrayItem{ key: none, val: 'parse-media-shortcode' },
		rt.ArrayItem{ key: none, val: 'destroy-sessions' },
		rt.ArrayItem{ key: none, val: 'install-plugin' },
		rt.ArrayItem{ key: none, val: 'activate-plugin' },
		rt.ArrayItem{ key: none, val: 'update-plugin' },
		rt.ArrayItem{ key: none, val: 'crop-image' },
		rt.ArrayItem{ key: none, val: 'generate-password' },
		rt.ArrayItem{ key: none, val: 'save-wporg-username' },
		rt.ArrayItem{ key: none, val: 'delete-plugin' },
		rt.ArrayItem{ key: none, val: 'search-plugins' },
		rt.ArrayItem{ key: none, val: 'search-install-plugins' },
		rt.ArrayItem{ key: none, val: 'activate-plugin' },
		rt.ArrayItem{ key: none, val: 'update-theme' },
		rt.ArrayItem{ key: none, val: 'delete-theme' },
		rt.ArrayItem{ key: none, val: 'install-theme' },
		rt.ArrayItem{ key: none, val: 'get-post-thumbnail-html' },
		rt.ArrayItem{ key: none, val: 'get-community-events' },
		rt.ArrayItem{ key: none, val: 'edit-theme-plugin-file' },
		rt.ArrayItem{ key: none, val: 'wp-privacy-export-personal-data' },
		rt.ArrayItem{ key: none, val: 'wp-privacy-erase-personal-data' },
		rt.ArrayItem{ key: none, val: 'health-check-site-status-result' },
		rt.ArrayItem{ key: none, val: 'health-check-dotorg-communication' },
		rt.ArrayItem{ key: none, val: 'health-check-is-in-debug-mode' },
		rt.ArrayItem{ key: none, val: 'health-check-background-updates' },
		rt.ArrayItem{ key: none, val: 'health-check-loopback-requests' },
		rt.ArrayItem{ key: none, val: 'health-check-get-sizes' },
		rt.ArrayItem{ key: none, val: 'toggle-auto-updates' },
		rt.ArrayItem{ key: none, val: 'send-password-reset' },
	])
	mut var_core_actions_post_deprecated := ['wp-fullscreen-save-post', 'press-this-save-post',
		'press-this-add-category', 'health-check-dotorg-communication',
		'health-check-is-in-debug-mode', 'health-check-background-updates',
		'health-check-loopback-requests']
	var_core_actions_post = rt.call_function('array_merge', [
		var_core_actions_post.dup(), var_core_actions_post_deprecated.dup()])
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_GET').array_get('action')))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_GET').array_get('action'), var_core_actions_get.dup(), rt.new_bool(true)]))))
	{
		rt.call_function('add_action', [
			'wp_ajax_' + (rt.get_superglobal('_GET').array_get('action')).str(),
			'wp_ajax_' +(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), rt.get_superglobal('_GET').array_get('action')])).str(),
			rt.new_int(1),
		])
	}
	if rt.is_true(rt.new_bool(!(!rt.is_true(rt.get_superglobal('_POST').array_get('action')))
		&& rt.is_true(rt.call_function('in_array', [rt.get_superglobal('_POST').array_get('action'), var_core_actions_post.dup(), rt.new_bool(true)]))))
	{
		rt.call_function('add_action', [
			'wp_ajax_' + (rt.get_superglobal('_POST').array_get('action')).str(),
			'wp_ajax_' +(rt.call_function('str_replace', [rt.new_string('-'), rt.new_string('_'), rt.get_superglobal('_POST').array_get('action')])).str(),
			rt.new_int(1),
		])
	}
	rt.call_function('add_action', [rt.new_string('wp_ajax_nopriv_generate-password'),
		rt.new_string('wp_ajax_nopriv_generate_password')])
	rt.call_function('add_action', [rt.new_string('wp_ajax_nopriv_heartbeat'),
		rt.new_string('wp_ajax_nopriv_heartbeat'), rt.new_int(1)])
	rt.call_function('add_action', [rt.new_string('wp_ajax_check_plugin_dependencies'),
		rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Plugin_Dependencies' },
			rt.ArrayItem{ key: none, val: 'check_plugin_dependencies_during_ajax' }])])
	mut var_action := rt.get_superglobal('_REQUEST').array_get('action')
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
			rt.new_string('wp_ajax_${var_action.to_string()}'),
		])))))
		{
			rt.call_function('wp_die', [rt.new_string('0'), rt.new_int(400)])
		}
		rt.call_function('do_action', [
			rt.new_string('wp_ajax_${var_action.to_string()}'),
		])
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
			rt.new_string('wp_ajax_nopriv_${var_action.to_string()}'),
		])))))
		{
			rt.call_function('wp_die', [rt.new_string('0'), rt.new_int(400)])
		}
		rt.call_function('do_action', [
			rt.new_string('wp_ajax_nopriv_${var_action.to_string()}'),
		])
	}
	rt.call_function('wp_die', [rt.new_string('0')])
}

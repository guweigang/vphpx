import rt
import crypto.md5

fn plugins_api(action string, var_args rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(var_args.dup().is_array())) {
		var_args = // unsupported expression: Expr_Cast_Object
	}
	if rt.is_true(rt.identical(rt.new_string('query_plugins'), rt.new_string(action))) {
		if !(!(rt.get_property(var_args, 'per_page')).is_null()) {
			rt.set_property(var_args, 'per_page', rt.new_int(24))
		}
	}
	if !(!(rt.get_property(var_args, 'locale')).is_null()) {
		rt.set_property(var_args, 'locale', rt.call_function('get_user_locale', []rt.PhpVal{}))
	}
	if !(!(rt.get_property(var_args, 'wp_version')).is_null()) {
		rt.set_property(var_args, 'wp_version', rt.call_function('substr', [rt.call_function('wp_get_wp_version', []rt.PhpVal{}), rt.new_int(0), rt.new_int(3)]))
		// unsupported statement: Stmt_Nop
	}
	var_args = rt.call_function('apply_filters', [rt.new_string('plugins_api_args'), var_args.dup(), rt.new_string(action)])
	mut var_res := rt.call_function('apply_filters', [rt.new_string('plugins_api'), rt.new_bool(false), rt.new_string(action), var_args.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_res)) {
		mut var_url := rt.new_string(rt.new_string('http://api.wordpress.org/plugins/info/1.2/'))
		var_url = rt.call_function('add_query_arg', [rt.create_array([rt.ArrayItem{ key: 'action', val: action }, rt.ArrayItem{ key: 'request', val: var_args }]), var_url.dup()])
		mut var_http_url := var_url.dup()
		mut var_ssl := rt.call_function('wp_http_supports', [rt.create_array([rt.ArrayItem{ key: none, val: 'ssl' }])])
		if rt.is_true(var_ssl) {
			var_url = rt.call_function('set_url_scheme', [var_url.dup(), rt.new_string('https')])
		}
		mut var_http_args := { 'timeout': rt.new_int(15), 'user-agent': 'WordPress/' + (rt.call_function('wp_get_wp_version', []rt.PhpVal{})).str() + '; ' + (rt.call_function('home_url', [rt.new_string('/')])).str() }
		mut var_request := rt.call_function('wp_remote_get', [var_url.dup(), var_http_args.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(var_ssl) && rt.is_true(rt.call_function('is_wp_error', [var_request.dup()])))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_json_request', []rt.PhpVal{}))))) {
				rt.call_function('wp_trigger_error', [rt.new_string(@FN), (rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])])).str() + ' ' + (rt.call_function('__', [rt.new_string('(WordPress could not establish a secure connection to WordPress.org. Please contact your server administrator.)')])).str(), if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('headers_sent', []rt.PhpVal{})) || rt.is_true(rt.get_constant('WP_DEBUG')))) { rt.get_constant('E_USER_WARNING') } else { rt.get_constant('E_USER_NOTICE') }])
			}
			var_request = rt.call_function('wp_remote_get', [var_http_url.dup(), var_http_args.dup()])
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_request.dup()])) {
			var_res = create_wp_error(rt.new_string('plugins_api_failed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])]), rt.call_method(var_request, 'get_error_message', []rt.PhpVal{}))
		} else {
			var_res = rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_request.dup()]), rt.new_bool(true)])
			if rt.is_true(rt.new_bool(var_res.dup().is_array())) {
				var_res = // unsupported expression: Expr_Cast_Object
			} else if rt.is_true(rt.identical(rt.new_null(), var_res)) {
				var_res = create_wp_error(rt.new_string('plugins_api_failed'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('An unexpected error occurred. Something may be wrong with WordPress.org or this server&#8217;s configuration. If you continue to have problems, please try the <a href="%s">support forums</a>.')]), rt.call_function('__', [rt.new_string('https://wordpress.org/support/forums/')])]), rt.call_function('wp_remote_retrieve_body', [var_request.dup()]))
			}
			if !(rt.get_property(var_res, 'error')).is_null() {
				var_res = create_wp_error(rt.new_string('plugins_api_failed'), rt.get_property(var_res, 'error'))
			}
		}
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_res.dup()]))))) {
		rt.set_property(var_res, 'external', rt.new_bool(true))
	}
	return rt.call_function('apply_filters', [rt.new_string('plugins_api_result'), var_res.dup(), rt.new_string(action), var_args.dup()])
}

fn install_popular_tags(var_args rt.PhpVal) rt.PhpVal {
	mut var_key := md5.hexhash(rt.call_function('serialize', [var_args.dup()]).to_string())
	mut var_tags := rt.call_function('get_site_transient', ['poptags_' + var_key])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_tags.dup()
	}
	var_tags = plugins_api('hot_tags', var_args.dup())
	if rt.is_true(rt.call_function('is_wp_error', [var_tags.dup()])) {
		return var_tags.dup()
	}
	rt.call_function('set_site_transient', ['poptags_' + var_key, var_tags.dup(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	return var_tags.dup()
}

fn install_dashboard() {
	display_plugins_table()
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Popular tags')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('You may also browse based on the most popular tags in the Plugin Directory:')])
	// unsupported statement: Stmt_InlineHTML
	mut var_api_tags := install_popular_tags(rt.new_null())
	print('<p class="popular-tags">')
	if rt.is_true(rt.call_function('is_wp_error', [var_api_tags.dup()])) {
		rt.echo_val(rt.call_method(var_api_tags, 'get_error_message', []rt.PhpVal{}))
	} else {
		mut var_tags := rt.new_array()
		{
			mut iter_1 := rt.cast_array(var_api_tags).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_tag := item_1.val
				mut var_url := rt.call_function('self_admin_url', ['plugin-install.php?tab=search&type=tag&s=' + (rt.call_function('urlencode', [var_tag.array_get('name')])).str()])
				mut var_data := rt.create_array([rt.ArrayItem{ key: 'link', val: rt.call_function('esc_url', [var_url.dup()]) }, rt.ArrayItem{ key: 'name', val: var_tag.array_get('name') }, rt.ArrayItem{ key: 'slug', val: var_tag.array_get('slug') }, rt.ArrayItem{ key: 'id', val: rt.call_function('sanitize_title_with_dashes', [var_tag.array_get('name')]) }, rt.ArrayItem{ key: 'count', val: var_tag.array_get('count') }])
				var_tags.array_set(var_tag.array_get('name'), // unsupported expression: Expr_Cast_Object)
			}
		}
		rt.echo_val(rt.call_function('wp_generate_tag_cloud', [var_tags.dup(), rt.create_array([rt.ArrayItem{ key: 'single_text', val: rt.call_function('__', [rt.new_string('%s plugin')]) }, rt.ArrayItem{ key: 'multiple_text', val: rt.call_function('__', [rt.new_string('%s plugins')]) }])]))
	}
	print('</p><br class="clear" /></div>')
}

fn install_search_form(deprecated bool) {
	mut var_type := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('type')) { rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('type')]) } else { rt.new_string('term') }
	mut var_term := if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('urldecode', [rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get('s')])]) } else { rt.new_string('') }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search Plugins')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_term.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Search plugins by:')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('term'), var_type.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Keyword')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('author'), var_type.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Author')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [rt.new_string('tag'), var_type.dup()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Tag'), rt.new_string('Plugin Installer')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Search Plugins')]), rt.new_string('hide-if-js'), rt.new_bool(false), rt.new_bool(false), rt.create_array([rt.ArrayItem{ key: 'id', val: 'search-submit' }])])
	// unsupported statement: Stmt_InlineHTML
}

fn install_plugins_upload() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('If you have a plugin in a .zip format, you may install or update it by uploading it here.')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('update.php?action=upload-plugin')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('plugin-upload')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Plugin zip file')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('_x', [rt.new_string('Install Now'), rt.new_string('plugin')]), rt.new_string(''), rt.new_string('install-plugin-submit'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
}

fn install_plugins_favorites_form() {
	mut var_user := rt.call_function('get_user_option', [rt.new_string('wporg_favorites')])
	mut var_action := rt.new_string('save_wporg_username_' + (rt.call_function('get_current_user_id', []rt.PhpVal{})).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('If you have marked plugins as favorites on WordPress.org, you can browse them here.')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Your WordPress.org username:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_user.dup()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('Get Favorites')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wp_create_nonce', [.dup()])]))
	// unsupported statement: Stmt_InlineHTML
}

fn display_plugins_table() {
	mut var_wp_list_table := rt.new_null()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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




pub fn init_wp_admin_includes_plugin_install_php() {
}

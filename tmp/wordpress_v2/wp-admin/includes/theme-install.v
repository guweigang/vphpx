import rt

mut var_themes_allowedtags := { 'a': { 'href': map[string]rt.PhpVal{}, 'title': map[string]rt.PhpVal{}, 'target': map[string]rt.PhpVal{} }, 'abbr': { 'title': map[string]rt.PhpVal{} }, 'acronym': { 'title': map[string]rt.PhpVal{} }, 'code': map[string]rt.PhpVal{}, 'pre': map[string]rt.PhpVal{}, 'em': map[string]rt.PhpVal{}, 'strong': map[string]rt.PhpVal{}, 'div': map[string]rt.PhpVal{}, 'p': map[string]rt.PhpVal{}, 'ul': map[string]rt.PhpVal{}, 'ol': map[string]rt.PhpVal{}, 'li': map[string]rt.PhpVal{}, 'h1': map[string]rt.PhpVal{}, 'h2': map[string]rt.PhpVal{}, 'h3': map[string]rt.PhpVal{}, 'h4': map[string]rt.PhpVal{}, 'h5': map[string]rt.PhpVal{}, 'h6': map[string]rt.PhpVal{}, 'img': { 'src': map[string]rt.PhpVal{}, 'class': map[string]rt.PhpVal{}, 'alt': map[string]rt.PhpVal{} } }
mut var_theme_field_defaults := { 'description': true, 'sections': false, 'tested': true, 'requires': true, 'rating': true, 'downloaded': true, 'downloadlink': true, 'last_updated': true, 'homepage': true, 'tags': true, 'num_ratings': true }
fn install_themes_feature_list() rt.PhpVal {
	mut var_cache := rt.new_null()
	mut var_feature_list := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.1.0'), rt.new_string('get_theme_feature_list()')])
	var_cache = rt.call_function('get_transient', [rt.new_string('wporg_theme_feature_list')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_cache)))) {
		rt.call_function('set_transient', [rt.new_string('wporg_theme_feature_list'), map[string]rt.PhpVal{}, rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	}
	if rt.is_true(var_cache) {
		return var_cache.clone()
	}
	var_feature_list = rt.call_function('themes_api', [rt.new_string('feature_list'), map[string]rt.PhpVal{}])
	if rt.is_true(rt.call_function('is_wp_error', [var_feature_list.clone()])) {
		return map[string]rt.PhpVal{}
	}
	rt.call_function('set_transient', [rt.new_string('wporg_theme_feature_list'), var_feature_list.clone(), rt.mul(rt.new_int(3), rt.get_constant('HOUR_IN_SECONDS'))])
	return var_feature_list.clone()
}

fn install_theme_search_form(type_selector bool) {
	mut var_type_selector := type_selector
	mut var_type := rt.new_null()
	mut var_term := rt.new_null()
	var_type = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('type')) { rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('type'))]) } else { rt.new_string('term') }
	var_term = if rt.get_superglobal('_REQUEST').array_isset(rt.new_string('s')) { rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('s'))]) } else { rt.new_string('') }
	if !(var_type_selector) {
		print('<p class="install-help">' + (rt.call_function('__', [rt.new_string('Search for themes by keyword.')])).str() + '</p>')
	}
	// unsupported statement: Stmt_InlineHTML
	if var_type_selector {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Type of search')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [rt.new_string('term'), var_type.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Keyword')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [rt.new_string('author'), var_type.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Author')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('selected', [rt.new_string('tag'), var_type.clone()])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_ex', [rt.new_string('Tag'), rt.new_string('Theme Installer')])
		// unsupported statement: Stmt_InlineHTML
		mut switch_val_1 := var_type
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('term'))) {
			rt.call_function('_e', [rt.new_string('Search by keyword')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('author'))) {
			rt.call_function('_e', [rt.new_string('Search by author')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('tag'))) {
			rt.call_function('_e', [rt.new_string('Search by tag')])
		}
		// unsupported statement: Stmt_InlineHTML
	} else {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('_e', [rt.new_string('Search by keyword')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_term.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Search')]), rt.new_string(''), rt.new_string('search'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
}

fn install_themes_dashboard() {
	mut var_feature_list := rt.new_null()
	mut var_features := rt.new_null()
	mut var_feature_name := rt.new_null()
	mut var_feature := rt.new_null()
	install_theme_search_form(false)
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Feature Filter')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Find a theme based on specific features.')])
	// unsupported statement: Stmt_InlineHTML
	var_feature_list = rt.call_function('get_theme_feature_list', []rt.PhpVal{})
	print('<div class="feature-filter">')
	mut iter_1 := rt.cast_array(var_feature_list).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_features_shadow := item_1.val
		mut var_feature_name_shadow := item_1.key
		var_feature_name_shadow = rt.call_function('esc_html', [var_feature_name_shadow.clone()])
		print('<div class="feature-name">' + (var_feature_name_shadow).str() + '</div>')
		print('<ol class="feature-group">')
		mut iter_2 := var_features_shadow.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_feature_name_shadow := item_2.val
			mut var_feature_shadow := item_2.key
			var_feature_name_shadow = rt.call_function('esc_html', [var_feature_name_shadow.clone()])
			var_feature_shadow = rt.call_function('esc_attr', [var_feature_shadow.clone()])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_feature_shadow)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_feature_shadow)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_feature_shadow)
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(var_feature_name_shadow)
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('__', [rt.new_string('Find Themes')]), rt.new_string(''), rt.new_string('search')])
	// unsupported statement: Stmt_InlineHTML
}

fn install_themes_upload() {
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('If you have a theme in a .zip format, you may install or update it by uploading it here.')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [rt.call_function('self_admin_url', [rt.new_string('update.php?action=upload-theme')])]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_nonce_field', [rt.new_string('theme-upload')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Theme zip file')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('submit_button', [rt.call_function('_x', [rt.new_string('Install Now'), rt.new_string('theme')]), rt.new_string(''), rt.new_string('install-theme-submit'), rt.new_bool(false)])
	// unsupported statement: Stmt_InlineHTML
}

fn display_theme(var_theme rt.PhpVal) {
	mut var_wp_list_table := rt.new_null()
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.4.0')])
	if !(!(var_wp_list_table).is_null()) {
	var_wp_list_table = rt.call_function('_get_list_table', [rt.new_string('WP_Theme_Install_List_Table')])
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'single_row', [var_theme.clone()])
}

fn display_themes() {
	mut var_wp_list_table := rt.new_null()
	if !(!(var_wp_list_table).is_null()) {
	var_wp_list_table = rt.call_function('_get_list_table', [rt.new_string('WP_Theme_Install_List_Table')])
	}
	rt.call_method(var_wp_list_table, 'prepare_items', []rt.PhpVal{})
	rt.call_method(var_wp_list_table, 'display', []rt.PhpVal{})
}

fn install_theme_information() {
	mut var_theme := rt.new_null()
	mut var_wp_list_table := rt.new_null()
	var_theme = rt.call_function('themes_api', [rt.new_string('theme_information'), rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.call_function('wp_unslash', [rt.get_superglobal('_REQUEST').array_get(rt.new_string('theme'))]) }])])
	if rt.is_true(rt.call_function('is_wp_error', [var_theme.clone()])) {
		rt.call_function('wp_die', [var_theme.clone()])
	}
	rt.call_function('iframe_header', [rt.call_function('__', [rt.new_string('Theme Installation')])])
	if !(!(var_wp_list_table).is_null()) {
	var_wp_list_table = rt.call_function('_get_list_table', [rt.new_string('WP_Theme_Install_List_Table')])
	}
	rt.call_method(var_wp_list_table, 'theme_installer_single', [var_theme.clone()])
	rt.call_function('iframe_footer', []rt.PhpVal{})
	exit(0)
}


fn main() {
	defer {
		rt.shutdown()
	}

}

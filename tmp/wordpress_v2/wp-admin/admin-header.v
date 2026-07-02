import rt

fn main() {
	defer {
		rt.shutdown()
	}

	mut var_hook_suffix := rt.new_null()
	mut var_current_screen := rt.new_null()
	mut var_wp_locale := rt.new_null()
	mut var_pagenow := rt.new_null()
	mut var_update_title := rt.new_null()
	mut var_total_update_count := rt.new_null()
	mut var_parent_file := rt.new_null()
	mut var_typenow := rt.new_null()
	mut var_blog_name := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	rt.call_function('header', [
		rt.new_string('Content-Type: ' +
			(rt.call_function('get_option', [rt.new_string('html_type')])).str() + '; charset=' +
			(rt.call_function('get_option', [rt.new_string('blog_charset')])).str()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('WP_ADMIN'),
	])))))
	{
		rt.include_file(@DIR + '/admin.php', '4')
	}
	mut var_title := rt.get_superglobal('title')
	if !rt.is_true(var_current_screen) {
		rt.call_function('set_current_screen', []rt.PhpVal{})
	}
	rt.call_function('get_admin_page_title', []rt.PhpVal{})
	var_title = rt.call_function('strip_tags', [var_title.clone()])
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		mut var_admin_title := rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Network Admin: %s')]),
			rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
		])
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		var_admin_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('User Dashboard: %s')]),
			rt.get_property(rt.call_function('get_network', []rt.PhpVal{}), 'site_name'),
		])
	} else {
		var_admin_title = rt.call_function('get_bloginfo', [rt.new_string('name')])
	}
	if rt.is_true(rt.identical(var_admin_title, var_title)) {
		var_admin_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s &#8212; WordPress')]),
			var_title.clone(),
		])
	} else {
		mut var_screen_title := var_title.clone()
		if rt.is_true(rt.identical(rt.new_string('post'), rt.get_property(var_current_screen, 'base')))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('add'), rt.get_property(var_current_screen, 'action'))))) {
			mut var_post_title := rt.call_function('get_the_title', []rt.PhpVal{})
			if !(!rt.is_true(var_post_title)) {
				mut var_post_type_obj := rt.call_function('get_post_type_object', [
					var_typenow.clone(),
				])
				var_screen_title = rt.call_function('sprintf', [
					rt.call_function('__', [rt.new_string('%1$s &#8220;%2$s&#8221;')]),
					rt.get_property(rt.get_property(var_post_type_obj, 'labels'), 'edit_item'),
					var_post_title.clone(),
				])
			}
		}
		var_admin_title = rt.call_function('sprintf', [
			rt.call_function('__', [
				rt.new_string('%1$s &lsaquo; %2$s &#8212; WordPress'),
			]),
			var_screen_title.clone(),
			var_admin_title.clone(),
		])
	}
	if rt.is_true(rt.call_function('wp_is_recovery_mode', []rt.PhpVal{})) {
		var_admin_title = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Recovery Mode &#8212; %s')]),
			var_admin_title.clone(),
		])
	}
	var_admin_title = rt.call_function('apply_filters', [rt.new_string('admin_title'),
		var_admin_title.clone(), var_title.clone()])
	rt.call_function('wp_user_settings', []rt.PhpVal{})
	rt.call_function('_wp_admin_html_begin', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_admin_title.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('wp_enqueue_style', [rt.new_string('colors')])
	rt.call_function('wp_enqueue_script', [rt.new_string('utils')])
	rt.call_function('wp_enqueue_script', [rt.new_string('svg-painter')])
	mut var_admin_body_class := rt.call_function('preg_replace', [
		rt.new_string('/[^a-z0-9_-]+/i'),
		rt.new_string('-'),
		var_hook_suffix.clone(),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.call_function('admin_url', [rt.new_string('admin-ajax.php'),
			rt.new_string('relative')]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [rt.get_property(var_current_screen, 'id')]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [
		rt.get_property(var_current_screen, 'post_type'),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js', [var_admin_body_class.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[rt.get_property(var_wp_locale, 'number_format').array_get(rt.new_string('thousands_sep'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_js',
		[rt.get_property(var_wp_locale, 'number_format').array_get(rt.new_string('decimal_point'))]))
	// unsupported statement: Stmt_InlineHTML
	print(rt.new_int((rt.call_function('is_rtl', []rt.PhpVal{})).to_i64()).str())
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('admin_enqueue_scripts'),
		var_hook_suffix.clone()])
	rt.call_function('do_action', [
		rt.new_string('admin_print_styles-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_print_styles')])
	rt.call_function('do_action', [
		rt.new_string('admin_print_scripts-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_print_scripts')])
	rt.call_function('do_action', [
		rt.new_string('admin_head-${var_hook_suffix.to_string()}'),
	])
	rt.call_function('do_action', [rt.new_string('admin_head')])
	if rt.is_true(rt.identical(rt.new_string('f'), rt.call_function('get_user_setting', [
		rt.new_string('mfold'),
	])))
	{
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' folded'))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_setting', [
		rt.new_string('unfold'),
	])))))
	{
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' auto-fold'))
	}
	if rt.is_true(rt.call_function('is_admin_bar_showing', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' admin-bar'))
	}
	if rt.is_true(rt.call_function('is_rtl', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' rtl'))
	}
	if rt.is_true(rt.get_property(var_current_screen, 'post_type')) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' post-type-' +
			(rt.get_property(var_current_screen, 'post_type')).str()))
	}
	if rt.is_true(rt.get_property(var_current_screen, 'taxonomy')) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' taxonomy-' +
			(rt.get_property(var_current_screen, 'taxonomy')).str()))
	}
	var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' branch-' +(rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
		key: none
		val: '.'
	}, rt.ArrayItem{ key: none, val: ',' }]), rt.new_string('-'), rt.new_float((rt.call_function('get_bloginfo', [rt.new_string('version')])).to_f64())])).str()))
	var_admin_body_class = rt.concat(var_admin_body_class,
		rt.new_string(' version-' +(rt.call_function('str_replace', [rt.new_string('.'), rt.new_string('-'), rt.call_function('preg_replace', [rt.new_string('/^([.0-9]+).*/'), rt.new_string('$1'), rt.call_function('get_bloginfo', [rt.new_string('version')])])])).str()))
	var_admin_body_class = rt.concat(var_admin_body_class,
		rt.new_string(' admin-color-' +(rt.call_function('sanitize_html_class', [rt.call_function('get_user_option', [rt.new_string('admin_color')]), rt.new_string('modern')])).str()))
	var_admin_body_class = rt.concat(var_admin_body_class,
		rt.new_string(' locale-' +(rt.call_function('sanitize_html_class', [rt.new_string(rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.call_function('get_user_locale', []rt.PhpVal{})]).to_string().to_lower())])).str()))
	if rt.is_true(rt.call_function('wp_is_mobile', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' mobile'))
	}
	if rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' multisite'))
	}
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' network-admin'))
	}
	var_admin_body_class = rt.concat(var_admin_body_class,
		rt.new_string(' no-customize-support svg'))
	if rt.is_true(rt.call_method(var_current_screen, 'is_block_editor', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class,
			rt.new_string(' block-editor-page wp-embed-responsive'))
	}
	var_admin_body_class = rt.concat(var_admin_body_class,
		rt.new_string(' wp-theme-' +(rt.call_function('sanitize_html_class', [rt.call_function('get_template', []rt.PhpVal{})])).str()))
	if rt.is_true(rt.call_function('is_child_theme', []rt.PhpVal{})) {
		var_admin_body_class = rt.concat(var_admin_body_class,
			rt.new_string(' wp-child-theme-' +(rt.call_function('sanitize_html_class', [rt.call_function('get_stylesheet', []rt.PhpVal{})])).str()))
	}
	mut var_error_get_last := rt.call_function('error_get_last', []rt.PhpVal{})
	if rt.is_true(var_error_get_last) && rt.is_true(rt.get_constant('WP_DEBUG'))
		&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))
		&& rt.is_true(rt.call_function('ini_get', [rt.new_string('display_errors')]))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.get_constant('E_NOTICE'), var_error_get_last.array_get(rt.new_string('type'))))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('wp-config.php'), rt.call_function('wp_basename', [var_error_get_last.array_get(rt.new_string('file'))]))))) {
		var_admin_body_class = rt.concat(var_admin_body_class, rt.new_string(' php-error'))
	}
	var_error_get_last = rt.new_null()
	// unsupported statement: Stmt_InlineHTML
	mut var_admin_body_classes := rt.call_function('apply_filters', [
		rt.new_string('admin_body_class'),
		rt.new_string(''),
	])
	var_admin_body_classes = rt.new_string(var_admin_body_classes.str() + ' ' +
		var_admin_body_class.str().trim_left(' \t\n\r'))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_admin_body_classes.clone()]))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('customize')])) {
		rt.call_function('wp_customize_support_script', []rt.PhpVal{})
	}
	// unsupported statement: Stmt_InlineHTML
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/menu-header.php', '3')
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('do_action', [rt.new_string('in_admin_header')])
	// unsupported statement: Stmt_InlineHTML
	var_blog_name = rt.new_null()
	var_total_update_count = rt.new_null()
	var_update_title = rt.new_null()
	rt.call_method(var_current_screen, 'set_parentage', [var_parent_file.clone()])
	// unsupported statement: Stmt_InlineHTML
	rt.call_method(var_current_screen, 'render_screen_meta', []rt.PhpVal{})
	if rt.is_true(rt.call_function('is_network_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('network_admin_notices')])
	} else if rt.is_true(rt.call_function('is_user_admin', []rt.PhpVal{})) {
		rt.call_function('do_action', [rt.new_string('user_admin_notices')])
	} else {
		rt.call_function('do_action', [rt.new_string('admin_notices')])
	}
	rt.call_function('do_action', [rt.new_string('all_admin_notices')])
	if rt.is_true(rt.identical(rt.new_string('options-general.php'), var_parent_file)) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/options-head.php', '3')
	}
}

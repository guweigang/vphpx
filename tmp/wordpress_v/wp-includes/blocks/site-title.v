import rt

fn render_block_core_site_title(var_attributes rt.PhpVal) string {
	mut var_site_title := rt.call_function('get_bloginfo', [rt.new_string('name')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_site_title.dup().to_string().trim_space()))))) {
		return ''
	}
	mut var_tag_name := rt.new_string(rt.new_string('h1'))
	mut var_classes := if !rt.is_true(var_attributes.array_get('textAlign')) { '' } else { rt.concat(rt.new_string('has-text-align-'), var_attributes.array_get('textAlign')) }
	if var_attributes.array_get('style').array_get('elements').array_get('link').array_get('color').array_isset(rt.new_string('text')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if var_attributes.array_isset(rt.new_string('level')) {
		var_tag_name = rt.new_string(if rt.is_true(rt.identical(rt.new_int(0), var_attributes.array_get('level'))) { rt.new_string('p') } else { 'h' + (// unsupported expression: Expr_Cast_Int).str() })
	}
	if rt.is_true(var_attributes.array_get('isLink')) {
		mut var_aria_current := if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{}))))) && rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{})) || rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_home', []rt.PhpVal{})) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))))) { ' aria-current="page"' } else { '' }
		mut var_link_target := if !(!rt.is_true(var_attributes.array_get('linkTarget'))) { var_attributes.array_get('linkTarget') } else { rt.new_string('_self') }
		var_site_title = rt.call_function('sprintf', [rt.new_string('<a href="%1$s" target="%2$s" rel="home"%3$s>%4$s</a>'), rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})]), rt.call_function('esc_attr', [var_link_target.dup()]), rt.new_string(var_aria_current).dup(), rt.call_function('esc_html', [var_site_title.dup()])])
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes.trim_space() }])])
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'), var_tag_name.dup(), var_wrapper_attributes.dup(), if rt.is_true(var_attributes.array_get('isLink')) { var_site_title } else { rt.call_function('esc_html', [var_site_title.dup()]) }])).str()
}

fn register_block_core_site_title() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/site-title', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_site_title' }])])
}



pub fn init_wp_includes_blocks_site_title_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_site_title')])
}

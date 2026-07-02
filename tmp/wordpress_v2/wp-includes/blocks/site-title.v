import rt

fn render_block_core_site_title(var_attributes rt.PhpVal) string {
	mut var_site_title := rt.new_null()
	mut var_tag_name := rt.new_null()
	mut var_classes := ''
	mut var_aria_current := ''
	mut var_link_target := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	var_site_title = rt.call_function('get_bloginfo', [rt.new_string('name')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_string(var_site_title.clone().to_string().trim_space()))))) {
		return ''
	}
	var_tag_name = rt.new_string('h1')
	var_classes = if !rt.is_true(var_attributes.array_get(rt.new_string('textAlign'))) {
		''
	} else {
		rt.concat(rt.new_string('has-text-align-'),
			var_attributes.array_get(rt.new_string('textAlign')))
	}
	if var_attributes.array_get(rt.new_string('style')).array_get(rt.new_string('elements')).array_get(rt.new_string('link')).array_get(rt.new_string('color')).array_isset(rt.new_string('text')) {
		var_classes = var_classes + ' has-link-color'
	}
	if var_attributes.array_isset(rt.new_string('level')) {
		var_tag_name = rt.new_string((if rt.is_true(rt.identical(rt.new_int(0),
			var_attributes.array_get(rt.new_string('level'))))
		{
			'p'
		} else {
			'h' + rt.new_int((var_attributes.array_get(rt.new_string('level'))).to_i64()).str()
		}).str())
	}
	if rt.is_true(var_attributes.array_get(rt.new_string('isLink'))) {
		var_aria_current = if
			rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_paged', []rt.PhpVal{})))))
			&& rt.is_true(rt.call_function('is_front_page', []rt.PhpVal{}))
			|| (rt.is_true(rt.call_function('is_home', []rt.PhpVal{}))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int((rt.call_function('get_option', [rt.new_string('page_for_posts')])).to_i64()), rt.call_function('get_queried_object_id', []rt.PhpVal{})))))) {
			' aria-current="page"'
		} else {
			''
		}
		var_link_target = if !(!rt.is_true(var_attributes.array_get(rt.new_string('linkTarget')))) {
			var_attributes.array_get(rt.new_string('linkTarget'))
		} else {
			rt.new_string('_self')
		}
		var_site_title = rt.call_function('sprintf', [
			rt.new_string('<a href="%1$s" target="%2$s" rel="home"%3$s>%4$s</a>'),
			rt.call_function('esc_url', [rt.call_function('home_url', []rt.PhpVal{})]),
			rt.call_function('esc_attr', [var_link_target.clone()]),
			rt.new_string(var_aria_current.str()).clone(),
			rt.call_function('esc_html', [var_site_title.clone()]),
		])
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes.trim_space() }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
		var_tag_name.clone(), var_wrapper_attributes.clone(), if rt.is_true(var_attributes.array_get(rt.new_string('isLink'))) { var_site_title } else { rt.call_function('esc_html', [
				var_site_title.clone(),
			]) }])).str()
}

fn register_block_core_site_title() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/site-title'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_site_title' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_site_title')])
}

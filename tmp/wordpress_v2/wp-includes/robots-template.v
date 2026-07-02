import rt

fn wp_robots() {
	mut var_robots := rt.new_null()
	mut var_robots_strings := []rt.PhpVal{}
	mut var_value := rt.new_null()
	mut var_directive := rt.new_null()
	var_robots = rt.call_function('apply_filters', [rt.new_string('wp_robots'),
		rt.new_array()])
	var_robots_strings = rt.new_array()
	mut iter_1 := var_robots.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value_shadow := item_1.val
		mut var_directive_shadow := item_1.key
		if rt.is_true(rt.new_bool(var_value_shadow.clone().is_string())) {
			var_robots_strings << rt.new_string('${var_directive.to_string()}:${var_value.to_string()}')
		} else if rt.is_true(var_value_shadow) {
			var_robots_strings << var_directive_shadow.clone()
		}
	}
	if !rt.is_true(var_robots_strings) {
		return
	}
	print("<meta name='robots' content='" +
		(rt.call_function('esc_attr', [rt.call_function('implode', [rt.new_string(', '), rt.create_array_from_list(var_robots_strings)])])).str() +
		"' />\n")
}

fn wp_robots_noindex(var_robots rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [
		rt.new_string('blog_public'),
	])))))
	{
		return wp_robots_no_robots(var_robots.clone())
	}
	return var_robots.clone()
}

fn wp_robots_noindex_embeds(var_robots rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_embed', []rt.PhpVal{})) {
		return wp_robots_no_robots(var_robots.clone())
	}
	return var_robots.clone()
}

fn wp_robots_noindex_search(var_robots rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_search', []rt.PhpVal{})) {
		return wp_robots_no_robots(var_robots.clone())
	}
	return var_robots.clone()
}

fn wp_robots_no_robots(var_robots rt.PhpVal) rt.PhpVal {
	var_robots.array_set('noindex', true)
	if rt.is_true(rt.call_function('get_option', [rt.new_string('blog_public')])) {
		var_robots.array_set('follow', true)
	} else {
		var_robots.array_set('nofollow', true)
	}
	return var_robots.clone()
}

fn wp_robots_sensitive_page(var_robots rt.PhpVal) rt.PhpVal {
	var_robots.array_set('noindex', true)
	var_robots.array_set('noarchive', true)
	return var_robots.clone()
}

fn wp_robots_max_image_preview_large(var_robots rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('get_option', [rt.new_string('blog_public')])) {
		var_robots.array_set('max-image-preview', 'large')
	}
	return var_robots.clone()
}

fn main() {
	defer {
		rt.shutdown()
	}
}

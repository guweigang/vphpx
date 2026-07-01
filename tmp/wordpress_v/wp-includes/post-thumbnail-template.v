import rt

fn has_post_thumbnail(var_post rt.PhpVal) rt.PhpVal {
	mut var_thumbnail_id := rt.new_bool(rt.new_bool(get_post_thumbnail_id(var_post.dup())))
	mut var_has_thumbnail := // unsupported expression: Expr_Cast_Bool
	return // unsupported expression: Expr_Cast_Bool
}

fn get_post_thumbnail_id(var_post rt.PhpVal) bool {
	var_post = rt.call_function('get_post', [var_post.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	mut var_thumbnail_id := // unsupported expression: Expr_Cast_Int
	return (// unsupported expression: Expr_Cast_Int).to_bool()
}

fn the_post_thumbnail(size string, attr string) {
	print(get_the_post_thumbnail(rt.new_null(), size, attr))
}

fn update_post_thumbnail_cache(var_wp_query rt.PhpVal) {
	mut var_GLOBALS := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_query)))) {
		var_wp_query = var_GLOBALS.array_get('wp_query')
	}
	if rt.is_true(rt.get_property(var_wp_query, 'thumbnails_cached')) {
		return rt.new_null()
	}
	mut var_thumb_ids := []rt.PhpVal{}
	mut var_parent_post_ids := []rt.PhpVal{}
	{
		mut iter_1 := rt.get_property(var_wp_query, 'posts').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			if rt.is_true(rt.new_bool(rt.instance_of(var_post, 'WP_Post'))) {
				var_parent_post_ids << rt.get_property(var_post, 'ID')
			} else if rt.is_true(rt.new_bool(var_post.dup().is_long())) {
				var_parent_post_ids << var_post.dup()
			}
		}
	}
	rt.call_function('_prime_post_caches', [var_parent_post_ids.dup(), rt.new_bool(false), rt.new_bool(true)])
	{
		mut iter_1 := rt.get_property(var_wp_query, 'posts').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post := item_1.val
			mut var_id := get_post_thumbnail_id(var_post.dup())
			if var_id {
				var_thumb_ids << rt.new_bool(var_id).dup()
			}
		}
	}
	if !(!rt.is_true(var_thumb_ids)) {
		rt.call_function('_prime_post_caches', [var_thumb_ids.dup(), rt.new_bool(false), rt.new_bool(true)])
	}
	rt.set_property(var_wp_query, 'thumbnails_cached', rt.new_bool(true))
}

fn get_the_post_thumbnail(var_post rt.PhpVal, size string, attr string) string {
	var_post = rt.call_function('get_post', [var_post.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return ''
	}
	mut var_post_thumbnail_id := get_post_thumbnail_id(var_post.dup())
	size = (rt.call_function('apply_filters', [rt.new_string('post_thumbnail_size'), rt.new_string(size), rt.get_property(var_post, 'ID')])).str()
	if var_post_thumbnail_id {
		rt.call_function('do_action', [rt.new_string('begin_fetch_post_thumbnail_html'), rt.get_property(var_post, 'ID'), rt.new_bool(var_post_thumbnail_id).dup(), rt.new_string(size)])
		if rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})) {
			update_post_thumbnail_cache(rt.new_null())
		}
		mut var_html := rt.call_function('wp_get_attachment_image', [rt.new_bool(var_post_thumbnail_id).dup(), rt.new_string(size), rt.new_bool(false), rt.new_string(attr)])
		rt.call_function('do_action', [rt.new_string('end_fetch_post_thumbnail_html'), rt.get_property(var_post, 'ID'), rt.new_bool(var_post_thumbnail_id).dup(), rt.new_string(size)])
	} else {
		var_html = rt.new_string(rt.new_string(''))
	}
	return (rt.call_function('apply_filters', [rt.new_string('post_thumbnail_html'), var_html.dup(), rt.get_property(var_post, 'ID'), rt.new_bool(var_post_thumbnail_id).dup(), rt.new_string(size), rt.new_string(attr)])).str()
}

fn get_the_post_thumbnail_url(var_post rt.PhpVal, size string) bool {
	mut var_post_thumbnail_id := get_post_thumbnail_id(var_post.dup())
	if !(var_post_thumbnail_id) {
		return false
	}
	mut var_thumbnail_url := rt.call_function('wp_get_attachment_image_url', [rt.new_bool(var_post_thumbnail_id).dup(), rt.new_string(size)])
	return (rt.call_function('apply_filters', [rt.new_string('post_thumbnail_url'), var_thumbnail_url.dup(), var_post.dup(), rt.new_string(size)])).to_bool()
}

fn the_post_thumbnail_url(size string) {
	mut var_url := get_the_post_thumbnail_url(rt.new_null(), size)
	if var_url {
		rt.echo_val(rt.call_function('esc_url', [rt.new_bool(var_url).dup()]))
	}
}

fn get_the_post_thumbnail_caption(var_post rt.PhpVal) string {
	mut var_post_thumbnail_id := get_post_thumbnail_id(var_post.dup())
	if !(var_post_thumbnail_id) {
		return ''
	}
	mut var_caption := rt.call_function('wp_get_attachment_caption', [rt.new_bool(var_post_thumbnail_id).dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_caption)))) {
		var_caption = rt.new_string(rt.new_string(''))
	}
	return (var_caption).str()
}

fn the_post_thumbnail_caption(var_post rt.PhpVal) {
	rt.echo_val(rt.call_function('apply_filters', [rt.new_string('the_post_thumbnail_caption'), rt.new_string(get_the_post_thumbnail_caption(var_post.dup()))]))
}



pub fn init_wp_includes_post_thumbnail_template_php() {
}

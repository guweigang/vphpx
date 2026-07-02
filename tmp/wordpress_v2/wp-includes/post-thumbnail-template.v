import rt

fn has_post_thumbnail(var_post rt.PhpVal) bool {
	mut var_thumbnail_id := rt.new_null()
	mut var_has_thumbnail := rt.new_null()
	var_thumbnail_id = get_post_thumbnail_id(var_post.clone())
	var_has_thumbnail = rt.new_bool(var_thumbnail_id.to_bool())
	return (rt.call_function('apply_filters', [rt.new_string('has_post_thumbnail'),
		var_has_thumbnail.clone(), var_post.clone(), var_thumbnail_id.clone()])).to_bool()
}

fn get_post_thumbnail_id(var_post_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_thumbnail_id := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_bool(false)
	}
	var_thumbnail_id = rt.new_int((rt.call_function('get_post_meta', [
		rt.get_property(var_post, 'ID'),
		rt.new_string('_thumbnail_id'),
		rt.new_bool(true),
	])).to_i64())
	return rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('post_thumbnail_id'),
		var_thumbnail_id.clone(),
		var_post.clone(),
	])).to_i64())
}

fn the_post_thumbnail(size string, attr string) {
	mut var_size := size
	mut var_attr := attr
	print(get_the_post_thumbnail(rt.new_null(), size, attr))
}

fn update_post_thumbnail_cache(var_wp_query_arg rt.PhpVal) {
	mut var_wp_query := var_wp_query_arg
	mut var_GLOBALS := rt.new_null()
	mut var_thumb_ids := []rt.PhpVal{}
	mut var_parent_post_ids := []rt.PhpVal{}
	mut var_post := rt.new_null()
	mut var_id := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_wp_query)))) {
		var_wp_query = var_GLOBALS.array_get(rt.new_string('wp_query'))
	}
	if rt.is_true(rt.get_property(var_wp_query, 'thumbnails_cached')) {
		return
	}
	var_thumb_ids = []rt.PhpVal{}
	var_parent_post_ids = []rt.PhpVal{}
	mut iter_1 := rt.get_property(var_wp_query, 'posts').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post_shadow := item_1.val
		if rt.is_true(rt.new_bool(rt.instance_of(var_post_shadow, 'WP_Post'))) {
			var_parent_post_ids << rt.get_property(var_post_shadow, 'ID')
		} else if rt.is_true(rt.new_bool(var_post_shadow.clone().is_long())) {
			var_parent_post_ids << var_post_shadow.clone()
		}
	}
	rt.call_function('_prime_post_caches', [
		rt.create_array_from_list(var_parent_post_ids),
		rt.new_bool(false),
		rt.new_bool(true),
	])
	mut iter_2 := rt.get_property(var_wp_query, 'posts').iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_post_shadow := item_2.val
		var_id = get_post_thumbnail_id(var_post_shadow.clone())
		if rt.is_true(var_id) {
			var_thumb_ids << var_id.clone()
		}
	}
	if !(!rt.is_true(var_thumb_ids)) {
		rt.call_function('_prime_post_caches', [rt.create_array_from_list(var_thumb_ids),
			rt.new_bool(false), rt.new_bool(true)])
	}
	rt.set_property(var_wp_query, 'thumbnails_cached', rt.new_bool(true))
}

fn get_the_post_thumbnail(var_post_arg rt.PhpVal, size string, attr string) string {
	mut var_size := size
	mut var_attr := attr
	mut var_post := var_post_arg
	mut var_post_thumbnail_id := rt.new_null()
	mut var_html := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return ''
	}
	var_post_thumbnail_id = get_post_thumbnail_id(var_post.clone())
	var_size = (rt.call_function('apply_filters', [rt.new_string('post_thumbnail_size'),
		rt.new_string(var_size.str()), rt.get_property(var_post, 'ID')])).str()
	if rt.is_true(var_post_thumbnail_id) {
		rt.call_function('do_action', [rt.new_string('begin_fetch_post_thumbnail_html'),
			rt.get_property(var_post, 'ID'), var_post_thumbnail_id.clone(),
			rt.new_string(var_size.str())])
		if rt.is_true(rt.call_function('in_the_loop', []rt.PhpVal{})) {
			update_post_thumbnail_cache(rt.new_null())
		}
		var_html = rt.call_function('wp_get_attachment_image', [
			var_post_thumbnail_id.clone(), rt.new_string(var_size.str()),
			rt.new_bool(false), rt.new_string(attr)])
		rt.call_function('do_action', [rt.new_string('end_fetch_post_thumbnail_html'),
			rt.get_property(var_post, 'ID'), var_post_thumbnail_id.clone(),
			rt.new_string(var_size.str())])
	} else {
		var_html = rt.new_string('')
	}
	return (rt.call_function('apply_filters', [rt.new_string('post_thumbnail_html'),
		var_html.clone(), rt.get_property(var_post, 'ID'), var_post_thumbnail_id.clone(),
		rt.new_string(var_size.str()), rt.new_string(attr)])).str()
}

fn get_the_post_thumbnail_url(var_post rt.PhpVal, size string) bool {
	mut var_size := size
	mut var_post_thumbnail_id := rt.new_null()
	mut var_thumbnail_url := rt.new_null()
	var_post_thumbnail_id = get_post_thumbnail_id(var_post.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_thumbnail_id)))) {
		return false
	}
	var_thumbnail_url = rt.call_function('wp_get_attachment_image_url', [
		var_post_thumbnail_id.clone(), rt.new_string(var_size.str())])
	return (rt.call_function('apply_filters', [rt.new_string('post_thumbnail_url'),
		var_thumbnail_url.clone(), var_post.clone(), rt.new_string(var_size.str())])).to_bool()
}

fn the_post_thumbnail_url(size string) {
	mut var_size := size
	mut var_url := false
	var_url = get_the_post_thumbnail_url(rt.new_null(), var_size)
	if var_url {
		rt.echo_val(rt.call_function('esc_url', [rt.new_bool(var_url).clone()]))
	}
}

fn get_the_post_thumbnail_caption(var_post rt.PhpVal) string {
	mut var_post_thumbnail_id := rt.new_null()
	mut var_caption := rt.new_null()
	var_post_thumbnail_id = get_post_thumbnail_id(var_post.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post_thumbnail_id)))) {
		return ''
	}
	var_caption = rt.call_function('wp_get_attachment_caption', [
		var_post_thumbnail_id.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_caption)))) {
		var_caption = rt.new_string('')
	}
	return var_caption.str()
}

fn the_post_thumbnail_caption(var_post rt.PhpVal) {
	rt.echo_val(rt.call_function('apply_filters', [
		rt.new_string('the_post_thumbnail_caption'),
		rt.new_string(get_the_post_thumbnail_caption(var_post.clone())),
	]))
}

fn main() {
	defer {
		rt.shutdown()
	}
}

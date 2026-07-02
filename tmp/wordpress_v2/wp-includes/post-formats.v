import rt

fn get_post_format(var_post_arg rt.PhpVal) bool {
	mut var_post := var_post_arg
	mut var__format := rt.new_null()
	mut var_format := rt.new_null()
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('post_type_supports', [
		rt.get_property(var_post, 'post_type'),
		rt.new_string('post-formats'),
	])))))
	{
		return false
	}
	var__format = rt.call_function('get_the_terms', [rt.get_property(var_post, 'ID'),
		rt.new_string('post_format')])
	if !rt.is_true(var__format) {
		return false
	}
	var_format = rt.call_function('reset', [var__format.clone()])
	return (rt.call_function('str_replace', [rt.new_string('post-format-'),
		rt.new_string(''), rt.get_property(var_format, 'slug')])).to_bool()
}

fn has_post_format(var_format rt.PhpVal, var_post rt.PhpVal) rt.PhpVal {
	mut var_prefixed := []rt.PhpVal{}
	mut var_single := rt.new_null()
	var_prefixed = []rt.PhpVal{}
	if rt.is_true(var_format) {
		mut iter_1 := rt.cast_array(var_format).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_single_shadow := item_1.val
			var_prefixed << 'post-format-' +
				(rt.call_function('sanitize_key', [var_single_shadow.clone()])).str()
		}
	}
	return rt.call_function('has_term', [rt.create_array_from_list(var_prefixed),
		rt.new_string('post_format'), var_post.clone()])
}

fn set_post_format(var_post_arg rt.PhpVal, var_format_arg rt.PhpVal) rt.PhpVal {
	mut var_post := var_post_arg
	mut var_format := var_format_arg
	var_post = rt.call_function('get_post', [var_post.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_post)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_post'), rt.call_function('__', [
			rt.new_string('Invalid post.'),
		])))
	}
	if !(!rt.is_true(var_format)) {
		var_format = rt.call_function('sanitize_key', [var_format.clone()])
		if rt.is_true(rt.identical(rt.new_string('standard'), var_format))
			|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_format.clone(), get_post_format_slugs(), rt.new_bool(true)]))))) {
			var_format = rt.new_string('')
		} else {
			var_format = rt.new_string('post-format-' + var_format.str())
		}
	}
	return rt.call_function('wp_set_post_terms', [rt.get_property(var_post, 'ID'),
		var_format.clone(), rt.new_string('post_format')])
}

fn get_post_format_strings() rt.PhpVal {
	mut var_strings := rt.new_null()
	var_strings = rt.create_array([
		rt.ArrayItem{ key: 'standard', val: rt.call_function('_x', [
			rt.new_string('Standard'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'aside', val: rt.call_function('_x', [
			rt.new_string('Aside'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'chat', val: rt.call_function('_x', [
			rt.new_string('Chat'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'gallery', val: rt.call_function('_x', [
			rt.new_string('Gallery'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'link', val: rt.call_function('_x', [
			rt.new_string('Link'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'image', val: rt.call_function('_x', [
			rt.new_string('Image'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'quote', val: rt.call_function('_x', [
			rt.new_string('Quote'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'status', val: rt.call_function('_x', [
			rt.new_string('Status'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'video', val: rt.call_function('_x', [
			rt.new_string('Video'),
			rt.new_string('Post format'),
		]) },
		rt.ArrayItem{ key: 'audio', val: rt.call_function('_x', [
			rt.new_string('Audio'),
			rt.new_string('Post format'),
		]) },
	])
	return var_strings.clone()
}

fn get_post_format_slugs() rt.PhpVal {
	mut var_slugs := rt.new_null()
	var_slugs = rt.func_array_keys(get_post_format_strings())
	return rt.call_function('array_combine', [var_slugs.clone(),
		var_slugs.clone()])
}

fn get_post_format_string(var_slug rt.PhpVal) rt.PhpVal {
	mut var_strings := rt.new_null()
	var_strings = get_post_format_strings()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_slug)))) {
		return var_strings.array_get(rt.new_string('standard'))
	} else {
		return if !(var_strings.array_get(var_slug)).is_null() {
			var_strings.array_get(var_slug)
		} else {
			rt.new_string('')
		}
	}
	return rt.new_null()
}

fn get_post_format_link(var_format rt.PhpVal) bool {
	mut var_term := rt.new_null()
	var_term = rt.call_function('get_term_by', [rt.new_string('slug'),
		rt.new_string('post-format-' + var_format.str()), rt.new_string('post_format')])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_term))))
		|| rt.is_true(rt.call_function('is_wp_error', [var_term.clone()])) {
		return false
	}
	return (rt.call_function('get_term_link', [var_term.clone()])).to_bool()
}

fn _post_format_request(var_qvs rt.PhpVal) rt.PhpVal {
	mut var_slugs := rt.new_null()
	mut var_tax := rt.new_null()
	if !(var_qvs.array_isset(rt.new_string('post_format'))) {
		return var_qvs.clone()
	}
	var_slugs = get_post_format_slugs()
	if var_slugs.array_isset(var_qvs.array_get(rt.new_string('post_format'))) {
		var_qvs['post_format'] = 'post-format-' +
			(var_slugs.array_get(var_qvs.array_get(rt.new_string('post_format')))).str()
	}
	var_tax = rt.call_function('get_taxonomy', [rt.new_string('post_format')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		var_qvs['post_type'] = rt.get_property(var_tax, 'object_type')
	}
	return var_qvs.clone()
}

fn _post_format_link(var_link_arg rt.PhpVal, var_term rt.PhpVal, var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_link := var_link_arg
	mut var_wp_rewrite := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('post_format'), var_taxonomy)))) {
		return var_link.clone()
	}
	if rt.is_true(rt.call_method(var_wp_rewrite, 'get_extra_permastruct', [
		var_taxonomy.clone()]))
	{
		return rt.call_function('str_replace', [
			rt.concat(rt.new_string('/'), rt.get_property(var_term, 'slug')),
			rt.new_string('/' +(rt.call_function('str_replace', [rt.new_string('post-format-'), rt.new_string(''), rt.get_property(var_term, 'slug')])).str()),
			var_link.clone(),
		])
	} else {
		var_link = rt.call_function('remove_query_arg', [rt.new_string('post_format'),
			var_link.clone()])
		return rt.call_function('add_query_arg', [rt.new_string('post_format'),
			rt.call_function('str_replace', [rt.new_string('post-format-'),
				rt.new_string(''), rt.get_property(var_term, 'slug')]),
			var_link.clone()])
	}
	return rt.new_null()
}

fn _post_format_get_term(var_term rt.PhpVal) rt.PhpVal {
	if !(rt.get_property(var_term, 'slug')).is_null() {
		rt.set_property(var_term, 'name', get_post_format_string(rt.call_function('str_replace', [
			rt.new_string('post-format-'),
			rt.new_string(''),
			rt.get_property(var_term, 'slug'),
		])))
	}
	return var_term.clone()
}

fn _post_format_get_terms(var_terms rt.PhpVal, var_taxonomies rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_name := rt.new_null()
	mut var_order := rt.new_null()
	mut var_term := rt.new_null()
	if rt.is_true(rt.call_function('in_array', [rt.new_string('post_format'),
		rt.cast_array(var_taxonomies), rt.new_bool(true)]))
	{
		if var_args.array_isset(rt.new_string('fields'))
			&& rt.is_true(rt.identical(rt.new_string('names'), var_args.array_get(rt.new_string('fields')))) {
			mut iter_2 := var_terms.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var_name_shadow := item_2.val
				mut var_order_shadow := item_2.key
				var_terms.array_set(var_order_shadow, get_post_format_string(rt.call_function('str_replace', [
					rt.new_string('post-format-'),
					rt.new_string(''),
					var_name_shadow.clone(),
				])))
			}
		} else {
			mut iter_3 := rt.cast_array(var_terms).iterator()
			for {
				item_3 := iter_3.next() or { break }
				mut var_term_shadow := item_3.val
				mut var_order_shadow := item_3.key
				if !(rt.get_property(var_term_shadow, 'taxonomy')).is_null()
					&& rt.is_true(rt.identical(rt.new_string('post_format'), rt.get_property(var_term_shadow, 'taxonomy'))) {
					rt.set_property(var_terms.array_get(var_order_shadow), 'name', get_post_format_string(rt.call_function('str_replace', [
						rt.new_string('post-format-'),
						rt.new_string(''),
						rt.get_property(var_term_shadow, 'slug'),
					])))
				}
			}
		}
	}
	return var_terms.clone()
}

fn _post_format_wp_get_object_terms(var_terms rt.PhpVal) rt.PhpVal {
	mut var_term := rt.new_null()
	mut var_order := rt.new_null()
	mut iter_4 := rt.cast_array(var_terms).iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_term_shadow := item_4.val
		mut var_order_shadow := item_4.key
		if !(rt.get_property(var_term_shadow, 'taxonomy')).is_null()
			&& rt.is_true(rt.identical(rt.new_string('post_format'), rt.get_property(var_term_shadow, 'taxonomy'))) {
			rt.set_property(var_terms.array_get(var_order_shadow), 'name', get_post_format_string(rt.call_function('str_replace', [
				rt.new_string('post-format-'),
				rt.new_string(''),
				rt.get_property(var_term_shadow, 'slug'),
			])))
		}
	}
	return var_terms.clone()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
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

fn main() {
	defer {
		rt.shutdown()
	}
}

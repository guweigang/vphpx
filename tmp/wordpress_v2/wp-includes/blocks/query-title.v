import rt

fn render_block_core_query_title(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_type := rt.new_null()
	mut var_is_archive := rt.new_null()
	mut var_is_search := rt.new_null()
	mut var_post_type := rt.new_null()
	mut var_title := rt.new_null()
	mut var_show_prefix := rt.new_null()
	mut var_post_type_object := rt.new_null()
	mut var_post_type_name := rt.new_null()
	mut var_level := rt.new_null()
	mut var_tag_name := rt.new_null()
	mut var_align_class_name := ''
	mut var_wrapper_attributes := rt.new_null()
	var_type = if !(var_attributes.array_get(rt.new_string('type'))).is_null() {
		var_attributes.array_get(rt.new_string('type'))
	} else {
		rt.new_null()
	}
	var_is_archive = rt.call_function('is_archive', []rt.PhpVal{})
	var_is_search = rt.call_function('is_search', []rt.PhpVal{})
	var_post_type = if !(rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('postType'))).is_null() {
		rt.get_property(var_block, 'context').array_get(rt.new_string('query')).array_get(rt.new_string('postType'))
	} else {
		rt.call_function('get_post_type', []rt.PhpVal{})
	}
	if ((rt.is_true(rt.new_bool(!(rt.is_true(var_type))))
		|| (rt.is_true(rt.identical(rt.new_string('archive'), var_type))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_archive))))))
		|| (rt.is_true(rt.identical(rt.new_string('search'), var_type))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_is_search))))))
		|| (rt.is_true(rt.identical(rt.new_string('post-type'), var_type))
		&& rt.is_true(rt.new_bool(!(rt.is_true(var_post_type))))) {
		return ''
	}
	var_title = rt.new_string('')
	if rt.is_true(var_is_archive) {
		var_show_prefix = if !(var_attributes.array_get(rt.new_string('showPrefix'))).is_null() {
			var_attributes.array_get(rt.new_string('showPrefix'))
		} else {
			rt.new_bool(true)
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(var_show_prefix)))) {
			rt.call_function('add_filter', [
				rt.new_string('get_the_archive_title_prefix'),
				rt.new_string('__return_empty_string'),
				rt.new_int(1),
			])
			var_title = rt.call_function('get_the_archive_title', []rt.PhpVal{})
			rt.call_function('remove_filter', [
				rt.new_string('get_the_archive_title_prefix'),
				rt.new_string('__return_empty_string'),
				rt.new_int(1),
			])
		} else {
			var_title = rt.call_function('get_the_archive_title', []rt.PhpVal{})
		}
	}
	if rt.is_true(var_is_search) {
		var_title = rt.call_function('__', [rt.new_string('Search results')])
		if var_attributes.array_isset(rt.new_string('showSearchTerm'))
			&& rt.is_true(var_attributes.array_get(rt.new_string('showSearchTerm'))) {
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Search results for: &#8220;%s&#8221;'),
				]),
				rt.call_function('get_search_query', []rt.PhpVal{}),
			])
		}
	}
	if rt.is_true(rt.identical(rt.new_string('post-type'), var_type)) {
		var_post_type_object = rt.call_function('get_post_type_object', [
			var_post_type.clone()])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_post_type_object)))) {
			return ''
		}
		var_post_type_name = rt.get_property(rt.get_property(var_post_type_object, 'labels'),
			'singular_name')
		var_show_prefix = if !(var_attributes.array_get(rt.new_string('showPrefix'))).is_null() {
			var_attributes.array_get(rt.new_string('showPrefix'))
		} else {
			rt.new_bool(true)
		}
		if rt.is_true(var_show_prefix) {
			var_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Post Type: &#8220;%s&#8221;')]),
				var_post_type_name.clone(),
			])
		} else {
			var_title = var_post_type_name.clone()
		}
	}
	var_level = rt.new_int((if !(var_attributes.array_get(rt.new_string('level'))).is_null() {
		var_attributes.array_get(rt.new_string('level'))
	} else {
		rt.new_int(1)
	}).to_i64())
	var_tag_name = rt.new_string((if rt.is_true(rt.identical(rt.new_int(0), var_level)) {
		'p'
	} else {
		'h' + var_level.str()
	}).str())
	var_align_class_name = if !rt.is_true(var_attributes.array_get(rt.new_string('textAlign'))) {
		''
	} else {
		rt.concat(rt.new_string('has-text-align-'),
			var_attributes.array_get(rt.new_string('textAlign')))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<%1$s %2$s>%3$s</%1$s>'),
		var_tag_name.clone(), var_wrapper_attributes.clone(),
		var_title.clone()])).str()
}

fn register_block_core_query_title() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/query-title'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_query_title' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_query_title')])
}

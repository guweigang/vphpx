import rt

fn render_block_core_comments_title(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_align_class_name := ''
	mut var_show_post_title := false
	mut var_show_comments_count := false
	mut var_wrapper_attributes := rt.new_null()
	mut var_comments_count := rt.new_null()
	mut var_post_title := rt.new_null()
	mut var_tag_name := rt.new_null()
	mut var_comments_title := rt.new_null()
	if rt.is_true(rt.call_function('post_password_required', []rt.PhpVal{})) {
		return rt.new_null()
	}
	var_align_class_name = if !rt.is_true(var_attributes.array_get(rt.new_string('textAlign'))) {
		''
	} else {
		rt.concat(rt.new_string('has-text-align-'),
			var_attributes.array_get(rt.new_string('textAlign')))
	}
	var_show_post_title = !(!rt.is_true(var_attributes.array_get(rt.new_string('showPostTitle'))))
		&& rt.is_true(var_attributes.array_get(rt.new_string('showPostTitle')))
	var_show_comments_count =
		!(!rt.is_true(var_attributes.array_get(rt.new_string('showCommentsCount'))))
		&& rt.is_true(var_attributes.array_get(rt.new_string('showCommentsCount')))
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }]),
	])
	var_comments_count = rt.call_function('get_comments_number', []rt.PhpVal{})
	var_post_title = rt.call_function('get_the_title', []rt.PhpVal{})
	var_tag_name = rt.new_string('h2')
	if var_attributes.array_isset(rt.new_string('level')) {
		var_tag_name = rt.new_string('h' + (var_attributes.array_get(rt.new_string('level'))).str())
	}
	if rt.is_true(rt.identical(rt.new_string('0'), var_comments_count)) {
		return rt.new_null()
	}
	if var_show_comments_count {
		if var_show_post_title {
			if rt.is_true(rt.identical(rt.new_string('1'), var_comments_count)) {
				var_comments_title = rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('One response to &#8220;%s&#8221;'),
					]),
					var_post_title.clone(),
				])
			} else {
				var_comments_title = rt.call_function('sprintf', [
					rt.call_function('_n', [
						rt.new_string('%1$s response to &#8220;%2$s&#8221;'),
						rt.new_string('%1$s responses to &#8220;%2$s&#8221;'),
						var_comments_count.clone(),
					]),
					rt.call_function('number_format_i18n', [
						var_comments_count.clone(),
					]),
					var_post_title.clone(),
				])
			}
		} else if rt.is_true(rt.identical(rt.new_string('1'), var_comments_count)) {
			var_comments_title = rt.call_function('__', [rt.new_string('One response')])
		} else {
			var_comments_title = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s response'),
					rt.new_string('%s responses'), var_comments_count.clone()]),
				rt.call_function('number_format_i18n', [var_comments_count.clone()]),
			])
		}
	} else if var_show_post_title {
		if rt.is_true(rt.identical(rt.new_string('1'), var_comments_count)) {
			var_comments_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Response to &#8220;%s&#8221;')]),
				var_post_title.clone(),
			])
		} else {
			var_comments_title = rt.call_function('sprintf', [
				rt.call_function('__', [rt.new_string('Responses to &#8220;%s&#8221;')]),
				var_post_title.clone(),
			])
		}
	} else if rt.is_true(rt.identical(rt.new_string('1'), var_comments_count)) {
		var_comments_title = rt.call_function('__', [rt.new_string('Response')])
	} else {
		var_comments_title = rt.call_function('__', [rt.new_string('Responses')])
	}
	return rt.call_function('sprintf', [
		rt.new_string('<%1$s id="comments" %2$s>%3$s</%1$s>'),
		var_tag_name.clone(),
		var_wrapper_attributes.clone(),
		var_comments_title.clone(),
	])
}

fn register_block_core_comments_title() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/comments-title'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_comments_title' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_comments_title')])
}

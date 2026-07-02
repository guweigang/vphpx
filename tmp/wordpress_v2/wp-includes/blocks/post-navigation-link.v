import rt

fn render_block_core_post_navigation_link(var_attributes rt.PhpVal, var_content_arg rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_navigation_type := rt.new_null()
	mut var_classes := ''
	mut var_wrapper_attributes := rt.new_null()
	mut var_format := rt.new_null()
	mut var_link := rt.new_null()
	mut var_label := rt.new_null()
	mut var_arrow_map := rt.new_null()
	mut var_arrow := rt.new_null()
	mut var_get_link_function := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		return ''
	}
	var_navigation_type = if !(var_attributes.array_get(rt.new_string('type'))).is_null() {
		var_attributes.array_get(rt.new_string('type'))
	} else {
		rt.new_string('next')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		var_navigation_type.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: 'next' },
			rt.ArrayItem{ key: none, val: 'previous' },
		]),
		rt.new_bool(true)])))))
	{
		return ''
	}
	var_classes = 'post-navigation-link-${var_navigation_type.to_string()}'
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		var_classes = var_classes +
			rt.concat(rt.new_string(' has-text-align-'), var_attributes.array_get(rt.new_string('textAlign')))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }]),
	])
	var_format = rt.new_string('%link')
	var_link = if rt.is_true(rt.identical(rt.new_string('next'), var_navigation_type)) { rt.call_function('_x', [
			rt.new_string('Next'),
			rt.new_string('label for next post link'),
		]) } else { rt.call_function('_x', [rt.new_string('Previous'),
			rt.new_string('label for previous post link')]) }
	var_label = rt.new_string('')
	var_arrow_map = rt.create_array([rt.ArrayItem{ key: 'none', val: '' },
		rt.ArrayItem{ key: 'arrow', val: rt.create_array([
			rt.ArrayItem{ key: 'next', val: '→' },
			rt.ArrayItem{ key: 'previous', val: '←' },
		]) }, rt.ArrayItem{ key: 'chevron', val: rt.create_array([
			rt.ArrayItem{ key: 'next', val: '»' },
			rt.ArrayItem{ key: 'previous', val: '«' },
		]) }])
	if var_attributes.array_isset(rt.new_string('label'))
		&& !(!rt.is_true(var_attributes.array_get(rt.new_string('label')))) {
		var_label = rt.new_string((var_attributes.array_get(rt.new_string('label'))).str())
		var_link = var_label.clone()
	}
	if var_attributes.array_isset(rt.new_string('showTitle'))
		&& rt.is_true(var_attributes.array_get(rt.new_string('showTitle'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get(rt.new_string('linkLabel')))))) {
			if rt.is_true(var_label) {
				var_format = rt.new_string('<span class="post-navigation-link__label">' +
					(rt.call_function('wp_kses_post', [var_label.clone()])).str() + '</span> %link')
			}
			var_link = rt.new_string('%title')
		} else if var_attributes.array_isset(rt.new_string('linkLabel'))
			&& rt.is_true(var_attributes.array_get(rt.new_string('linkLabel'))) {
			if rt.is_true(var_label) {
				var_link = rt.new_string('<span class="post-navigation-link__label">' +
					(rt.call_function('wp_kses_post', [var_label.clone()])).str() +
					'</span> <span class="post-navigation-link__title">%title</span>')
			} else {
				var_label = if rt.is_true(rt.identical(rt.new_string('next'), var_navigation_type)) { rt.call_function('_x', [
						rt.new_string('Next:'),
						rt.new_string('label before the title of the next post'),
					]) } else { rt.call_function('_x', [rt.new_string('Previous:'),
						rt.new_string('label before the title of the previous post')]) }
				var_link = rt.call_function('sprintf', [
					rt.new_string('<span class="post-navigation-link__label">%1$s</span> <span class="post-navigation-link__title">%2$s</span>'),
					rt.call_function('wp_kses_post', [var_label.clone()]),
					rt.new_string('%title'),
				])
			}
		}
	}
	if var_attributes.array_isset(rt.new_string('arrow'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('none'), var_attributes.array_get(rt.new_string('arrow'))))))
		&& var_arrow_map.array_isset(var_attributes.array_get(rt.new_string('arrow'))) {
		var_arrow =
			var_arrow_map.array_get(var_attributes.array_get(rt.new_string('arrow'))).array_get(var_navigation_type)
		if rt.is_true(rt.identical(rt.new_string('next'), var_navigation_type)) {
			var_format = rt.new_string(
				'%link<span class="wp-block-post-navigation-link__arrow-next is-arrow-' +
				(var_attributes.array_get(rt.new_string('arrow'))).str() + '" aria-hidden="true">' + var_arrow.str() +
				'</span>')
		} else {
			var_format = rt.new_string(
				'<span class="wp-block-post-navigation-link__arrow-previous is-arrow-' +
				(var_attributes.array_get(rt.new_string('arrow'))).str() + '" aria-hidden="true">' + var_arrow.str() +
				'</span>%link')
		}
	}
	var_get_link_function = 'get_${var_navigation_type.to_string()}_post_link'
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('taxonomy')))) {
		var_content = rt.call_callable(rt.new_string(var_get_link_function.str()), [
			var_format.clone(),
			var_link.clone(),
			rt.new_bool(true),
			rt.new_string(''),
			var_attributes.array_get(rt.new_string('taxonomy')),
		])
	} else {
		var_content = rt.call_callable(rt.new_string(var_get_link_function.str()), [
			var_format.clone(),
			var_link.clone(),
		])
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_content.clone()])).str()
}

fn register_block_core_post_navigation_link() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-navigation-link'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_navigation_link' },
		]),
	])
}

fn init_registry() {
	rt.register_func('render_block_core_post_navigation_link', fn (args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(render_block_core_post_navigation_link(arg_0, arg_1))
	})
	rt.register_func('register_block_core_post_navigation_link', fn (args []rt.PhpVal) rt.PhpVal {
		return register_block_core_post_navigation_link()
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_navigation_link')])
}

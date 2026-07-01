import rt

fn render_block_core_post_navigation_link(var_attributes rt.PhpVal, var_content rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_singular', []rt.PhpVal{}))))) {
		return ''
	}
	mut var_navigation_type := if !(var_attributes.array_get('type')).is_null() { var_attributes.array_get('type') } else { rt.new_string('next') }
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_navigation_type.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'next' }, rt.ArrayItem{ key: none, val: 'previous' }]), rt.new_bool(true)]))))) {
		return ''
	}
	mut var_classes := "post-navigation-link-${var_navigation_type.to_string()}"
	if var_attributes.array_isset(rt.new_string('textAlign')) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_classes }])])
	mut var_format := rt.new_string(rt.new_string('%link'))
	mut var_link := if rt.is_true(rt.identical(rt.new_string('next'), var_navigation_type)) { rt.call_function('_x', [rt.new_string('Next'), rt.new_string('label for next post link')]) } else { rt.call_function('_x', [rt.new_string('Previous'), rt.new_string('label for previous post link')]) }
	mut var_label := rt.new_string(rt.new_string(''))
	mut var_arrow_map := rt.create_array([rt.ArrayItem{ key: 'none', val: '' }, rt.ArrayItem{ key: 'arrow', val: rt.create_array([rt.ArrayItem{ key: 'next', val: '→' }, rt.ArrayItem{ key: 'previous', val: '←' }]) }, rt.ArrayItem{ key: 'chevron', val: rt.create_array([rt.ArrayItem{ key: 'next', val: '»' }, rt.ArrayItem{ key: 'previous', val: '«' }]) }])
	if var_attributes.array_isset(rt.new_string('label')) && !(!rt.is_true(var_attributes.array_get('label'))) {
		var_label = rt.new_string(var_attributes.array_get('label'))
		var_link = var_label.dup()
	}
	if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('showTitle')) && rt.is_true(var_attributes.array_get('showTitle')))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_attributes.array_get('linkLabel'))))) {
			if rt.is_true(var_label) {
				var_format = rt.new_string('<span class="post-navigation-link__label">' + (rt.call_function('wp_kses_post', [var_label.dup()])).str() + '</span> %link')
			}
			var_link = rt.new_string(rt.new_string('%title'))
		} else if rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('linkLabel')) && rt.is_true(var_attributes.array_get('linkLabel')))) {
			if rt.is_true(var_label) {
				var_link = rt.new_string('<span class="post-navigation-link__label">' + (rt.call_function('wp_kses_post', [var_label.dup()])).str() + '</span> <span class="post-navigation-link__title">%title</span>')
			} else {
				var_label = if rt.is_true(rt.identical(rt.new_string('next'), var_navigation_type)) { rt.call_function('_x', [rt.new_string('Next:'), rt.new_string('label before the title of the next post')]) } else { rt.call_function('_x', [rt.new_string('Previous:'), rt.new_string('label before the title of the previous post')]) }
				var_link = rt.call_function('sprintf', [rt.new_string('<span class="post-navigation-link__label">%1$s</span> <span class="post-navigation-link__title">%2$s</span>'), rt.call_function('wp_kses_post', [var_label.dup()]), rt.new_string('%title')])
			}
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_attributes.array_isset(rt.new_string('arrow')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && var_arrow_map.array_isset(var_attributes.array_get('arrow')))) {
		mut var_arrow := var_arrow_map.array_get(var_attributes.array_get('arrow')).array_get(var_navigation_type)
		if rt.is_true(rt.identical(rt.new_string('next'), var_navigation_type)) {
			var_format = rt.new_string('%link<span class="wp-block-post-navigation-link__arrow-next is-arrow-' + (var_attributes.array_get('arrow')).str() + '" aria-hidden="true">' + (var_arrow).str() + '</span>')
		} else {
			var_format = rt.new_string('<span class="wp-block-post-navigation-link__arrow-previous is-arrow-' + (var_attributes.array_get('arrow')).str() + '" aria-hidden="true">' + (var_arrow).str() + '</span>%link')
		}
	}
	mut var_get_link_function := "get_${var_navigation_type.to_string()}_post_link"
	if !(!rt.is_true(var_attributes.array_get('taxonomy'))) {
		var_content = rt.call_callable(rt.new_string(var_get_link_function), [var_format.dup(), var_link.dup(), rt.new_bool(true), rt.new_string(''), var_attributes.array_get('taxonomy')])
	} else {
		var_content = rt.call_callable(rt.new_string(var_get_link_function), [var_format.dup(), var_link.dup()])
	}
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), var_wrapper_attributes.dup(), var_content.dup()])).str()
}

fn register_block_core_post_navigation_link() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-navigation-link', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_navigation_link' }])])
}

fn init_registry() {
	rt.register_func('render_block_core_post_navigation_link', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_string(render_block_core_post_navigation_link(arg_0, arg_1))
	})
	rt.register_func('register_block_core_post_navigation_link', fn(args []rt.PhpVal) rt.PhpVal {
		return register_block_core_post_navigation_link()
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_blocks_post_navigation_link_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_post_navigation_link')])
}

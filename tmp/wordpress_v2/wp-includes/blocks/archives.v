import rt

fn render_block_core_archives(var_attributes rt.PhpVal) rt.PhpVal {
	mut var_show_post_count := false
	mut var_type := rt.new_null()
	mut var_class := ''
	mut var_dropdown_id := rt.new_null()
	mut var_title := rt.new_null()
	mut var_dropdown_args := rt.new_null()
	mut var_archives := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_label := rt.new_null()
	mut var_show_label := ''
	mut var_block_content := rt.new_null()
	mut var_archives_args := rt.new_null()
	var_show_post_count = !(!rt.is_true(var_attributes.array_get(rt.new_string('showPostCounts'))))
	var_type = if !(var_attributes.array_get(rt.new_string('type'))).is_null() {
		var_attributes.array_get(rt.new_string('type'))
	} else {
		rt.new_string('monthly')
	}
	var_class = 'wp-block-archives-list'
	if !(!rt.is_true(var_attributes.array_get(rt.new_string('displayAsDropdown')))) {
		var_class = 'wp-block-archives-dropdown'
		var_dropdown_id = rt.call_function('wp_unique_id', [
			rt.new_string('wp-block-archives-'),
		])
		var_title = rt.call_function('__', [rt.new_string('Archives')])
		var_dropdown_args = rt.call_function('apply_filters', [
			rt.new_string('widget_archives_dropdown_args'),
			rt.create_array([rt.ArrayItem{ key: 'type', val: var_type },
				rt.ArrayItem{ key: 'format', val: 'option' },
				rt.ArrayItem{ key: 'show_post_count', val: var_show_post_count }]),
		])
		var_dropdown_args.array_set('echo', 0)
		var_archives = rt.call_function('wp_get_archives', [var_dropdown_args.clone()])
		var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
			rt.create_array([rt.ArrayItem{ key: 'class', val: var_class }]),
		])
		mut switch_val_1 := var_dropdown_args.array_get(rt.new_string('type'))
		if rt.is_true(rt.equal(switch_val_1, rt.new_string('yearly'))) {
			var_label = rt.call_function('__', [rt.new_string('Select Year')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('monthly'))) {
			var_label = rt.call_function('__', [rt.new_string('Select Month')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('daily'))) {
			var_label = rt.call_function('__', [rt.new_string('Select Day')])
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('weekly'))) {
			var_label = rt.call_function('__', [rt.new_string('Select Week')])
		} else {
			var_label = rt.call_function('__', [rt.new_string('Select Post')])
		}
		var_show_label = if !rt.is_true(var_attributes.array_get(rt.new_string('showLabel'))) {
			' screen-reader-text'
		} else {
			''
		}
		var_block_content = rt.new_string('<label for="' + var_dropdown_id.str() +
			'" class="wp-block-archives__label' + var_show_label + '">' +
			(rt.call_function('esc_html', [var_title.clone()])).str() +
			'</label>\n\t\t<select id="' +
			(rt.call_function('esc_attr', [var_dropdown_id.clone()])).str() +
			'" name="archive-dropdown">\n\t\t<option value="">' +
			(rt.call_function('esc_html', [var_label.clone()])).str() + '</option>' +
			var_archives.str() + '</select>')
		var_block_content = rt.concat(var_block_content,
			block_core_archives_build_dropdown_script(var_dropdown_id.clone()))
		return rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
			var_wrapper_attributes.clone(), var_block_content.clone()])
	}
	var_archives_args = rt.call_function('apply_filters', [
		rt.new_string('widget_archives_args'),
		rt.create_array([rt.ArrayItem{ key: 'type', val: var_type },
			rt.ArrayItem{ key: 'show_post_count', val: var_show_post_count }]),
	])
	var_archives_args.array_set('echo', 0)
	var_archives = rt.call_function('wp_get_archives', [var_archives_args.clone()])
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_class }]),
	])
	if !rt.is_true(var_archives) {
		return rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
			var_wrapper_attributes.clone(),
			rt.call_function('__', [
				rt.new_string('No archives to show.'),
			])])
	}
	return rt.call_function('sprintf', [rt.new_string('<ul %1$s>%2$s</ul>'),
		var_wrapper_attributes.clone(), var_archives.clone()])
}

fn block_core_archives_build_dropdown_script(var_dropdown_id rt.PhpVal) rt.PhpVal {
	mut var_exports := []rt.PhpVal{}
	rt.call_function('ob_start', []rt.PhpVal{})
	var_exports = [var_dropdown_id, rt.call_function('home_url', []rt.PhpVal{})]
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_json_encode', [
		rt.create_array_from_list(var_exports),
		rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES')),
	]))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('wp_get_inline_script_tag', [
		rt.new_string((
			rt.call_function('str_replace', [rt.create_array([rt.ArrayItem{
			key: none
			val: '<script>'
		}, rt.ArrayItem{ key: none, val: '</script>' }]), rt.new_string(''), rt.call_function('ob_get_clean', []rt.PhpVal{})]).to_string().trim_space() +
			'\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@FN)])).str()).str()),
	])
}

fn register_block_core_archives() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/archives'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_archives' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action',
		[rt.new_string('init'), rt.new_string('register_block_core_archives')])
}

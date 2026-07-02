import rt

fn render_block_core_footnotes(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	mut var_footnotes := rt.new_null()
	mut var_wrapper_attributes := rt.new_null()
	mut var_footnote_index := i64(0)
	mut var_block_content := ''
	mut var_footnote := map[string]rt.PhpVal{}
	mut var_aria_label := rt.new_null()
	if !rt.is_true(rt.get_property(var_block, 'context').array_get(rt.new_string('postId'))) {
		return ''
	}
	if rt.is_true(rt.call_function('post_password_required', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
	]))
	{
		return ''
	}
	var_footnotes = rt.call_function('get_post_meta', [
		rt.get_property(var_block, 'context').array_get(rt.new_string('postId')),
		rt.new_string('footnotes'),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_footnotes)))) {
		return ''
	}
	var_footnotes = rt.call_function('json_decode', [var_footnotes.clone(),
		rt.new_bool(true)])
	if !(var_footnotes.clone().is_array()) || var_footnotes.clone().array_count() == 0 {
		return ''
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', []rt.PhpVal{})
	var_footnote_index = 1
	var_block_content = ''
	mut iter_1 := var_footnotes.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_footnote_shadow := item_1.val
		var_aria_label = rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('Jump to footnote reference %1$d')]),
			rt.new_int(var_footnote_index).clone(),
		])
		var_block_content = var_block_content +(rt.call_function('sprintf', [rt.new_string('<li id="%1$s">%2$s <a href="#%1$s-link" aria-label="%3$s">↩︎</a></li>'), rt.call_function('esc_attr', [var_footnote_shadow['id']]), rt.call_function('wp_kses_post', [var_footnote_shadow['content']]), rt.call_function('esc_attr', [var_aria_label.clone()])])).str()
		var_footnote_index += 1
	}
	return (rt.call_function('sprintf', [rt.new_string('<ol %1$s>%2$s</ol>'),
		var_wrapper_attributes.clone(), rt.new_string(var_block_content.str()).clone()])).str()
}

fn register_block_core_footnotes() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/footnotes'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_footnotes' },
		]),
	])
}

fn register_block_core_footnotes_post_meta() {
	mut var_post_types := rt.new_null()
	mut var_post_type := rt.new_null()
	var_post_types = rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]),
	])
	mut iter_2 := var_post_types.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_post_type_shadow := item_2.val
		if rt.is_true(rt.call_function('post_type_supports', [var_post_type_shadow.clone(), rt.new_string('editor')]))
			&& rt.is_true(rt.call_function('post_type_supports', [var_post_type_shadow.clone(), rt.new_string('custom-fields')]))
			&& rt.is_true(rt.call_function('post_type_supports', [var_post_type_shadow.clone(), rt.new_string('revisions')])) {
			rt.call_function('register_post_meta', [var_post_type_shadow.clone(),
				rt.new_string('footnotes'),
				rt.create_array([
					rt.ArrayItem{ key: 'show_in_rest', val: true },
					rt.ArrayItem{ key: 'single', val: true },
					rt.ArrayItem{ key: 'type', val: 'string' },
					rt.ArrayItem{ key: 'revisions_enabled', val: true },
				])])
		}
	}
}

fn wp_add_footnotes_to_revision(var_fields rt.PhpVal) rt.PhpVal {
	var_fields['footnotes'] = rt.call_function('__', [rt.new_string('Footnotes')])
	return var_fields.clone()
}

fn wp_get_footnotes_from_revision(var_revision_field rt.PhpVal, var_field rt.PhpVal, var_revision rt.PhpVal) rt.PhpVal {
	return rt.call_function('get_metadata', [rt.new_string('post'),
		rt.get_property(var_revision, 'ID'), var_field.clone(),
		rt.new_bool(true)])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_footnotes')])
	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_footnotes_post_meta'),
		rt.new_int(20)])
	rt.call_function('add_filter', [rt.new_string('_wp_post_revision_fields'),
		rt.new_string('wp_add_footnotes_to_revision')])
	rt.call_function('add_filter', [rt.new_string('_wp_post_revision_field_footnotes'),
		rt.new_string('wp_get_footnotes_from_revision'), rt.new_int(10),
		rt.new_int(3)])
}

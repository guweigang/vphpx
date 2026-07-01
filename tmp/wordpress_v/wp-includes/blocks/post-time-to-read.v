import rt

fn block_core_post_time_to_read_word_count(var_text rt.PhpVal, var_type rt.PhpVal) i64 {
	mut var_settings := { 'html_regexp': '/<\\/?[a-z][^>]*?>/i', 'html_comment_regexp': '/<!--[\\s\\S]*?-->/', 'space_regexp': '/&nbsp;|&#160;/i', 'html_entity_regexp': '/&\\S+?;/', 'connector_regexp': '/--|\\x{2014}/u', 'remove_regexp': '/[\\x{0021}-\\x{0040}\\x{005B}-\\x{0060}\\x{007B}-\\x{007E}\\x{0080}-\\x{00BF}\\x{00D7}\\x{00F7}\\x{2000}-\\x{2BFF}\\x{2E00}-\\x{2E7F}]/u', 'astral_regexp': '/[\\x{010000}-\\x{10FFFF}]/u', 'words_regexp': '/\\S\\s+/u', 'characters_excluding_spaces_regexp': '/\\S/u', 'characters_including_spaces_regexp': '/[^\n\r\t\\x{00AD}\\x{2028}\\x{2029}]/u' }
	mut var_count := 0
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_text.dup().to_string().trim_space()))) {
		return var_count
	}
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_type = 'words'
	}
	// unsupported expression: Expr_AssignOp_Concat
	var_text = rt.call_function('preg_replace', [var_settings.array_get('html_regexp'), rt.new_string('\n'), var_text.dup()])
	var_text = rt.call_function('preg_replace', [var_settings.array_get('html_comment_regexp'), rt.new_string(''), var_text.dup()])
	if !(var_settings['shortcodes_regexp'] == '') {
		var_text = rt.call_function('preg_replace', [var_settings.array_get('shortcodes_regexp'), rt.new_string('\n'), var_text.dup()])
	}
	var_text = rt.call_function('preg_replace', [var_settings.array_get('space_regexp'), rt.new_string(' '), var_text.dup()])
	if rt.is_true(rt.identical(rt.new_string('words'), rt.new_string(var_type))) {
		var_text = rt.call_function('preg_replace', [var_settings.array_get('html_entity_regexp'), rt.new_string(''), var_text.dup()])
		var_text = rt.call_function('preg_replace', [var_settings.array_get('connector_regexp'), rt.new_string(' '), var_text.dup()])
		var_text = rt.call_function('preg_replace', [var_settings.array_get('remove_regexp'), rt.new_string(''), var_text.dup()])
	} else {
		var_text = rt.call_function('preg_replace', [var_settings.array_get('html_entity_regexp'), rt.new_string('a'), var_text.dup()])
		var_text = rt.call_function('preg_replace', [var_settings.array_get('astral_regexp'), rt.new_string('a'), var_text.dup()])
	}
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn render_block_core_post_time_to_read(var_attributes rt.PhpVal, var_content rt.PhpVal, var_block rt.PhpVal) string {
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_content = rt.call_function('get_the_content', []rt.PhpVal{})
	mut var_average_reading_rate := if !(var_attributes.array_get('averageReadingSpeed')).is_null() { var_attributes.array_get('averageReadingSpeed') } else { rt.new_int(189) }
	mut var_display_mode := if !(var_attributes.array_get('displayMode')).is_null() { var_attributes.array_get('displayMode') } else { rt.new_string('time') }
	mut var_word_count_type := rt.call_function('wp_get_word_count_type', []rt.PhpVal{})
	mut var_total_words := block_core_post_time_to_read_word_count(var_content.dup(), var_word_count_type.dup())
	mut var_parts := []rt.PhpVal{}
	if rt.is_true(rt.identical(rt.new_string('time'), var_display_mode)) {
		if !(!rt.is_true(var_attributes.array_get('displayAsRange'))) {
			mut var_min_minutes := rt.call_function('max', [rt.new_int(1), // unsupported expression: Expr_Cast_Int])
			mut var_max_minutes := rt.call_function('max', [rt.new_int(1), // unsupported expression: Expr_Cast_Int])
			if rt.is_true(rt.identical(var_min_minutes, var_max_minutes)) {
				var_max_minutes = rt.add(var_min_minutes, rt.new_int(1))
			}
			mut var_time_string := rt.call_function('sprintf', [rt.call_function('_x', [rt.new_string('%1$s–%2$s minutes'), rt.new_string('Range of minutes to read')]), var_min_minutes.dup(), var_max_minutes.dup()])
		} else {
			mut var_minutes_to_read := rt.call_function('max', [rt.new_int(1), // unsupported expression: Expr_Cast_Int])
			var_time_string = rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s minute'), rt.new_string('%s minutes'), var_minutes_to_read.dup()]), var_minutes_to_read.dup()])
		}
		var_parts << var_time_string.dup()
	}
	if rt.is_true(rt.identical(rt.new_string('words'), var_display_mode)) {
		mut var_word_count_string := if rt.is_true(rt.identical(rt.new_string('words'), var_word_count_type)) { rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s word'), rt.new_string('%s words'), rt.new_int(var_total_words).dup()]), rt.call_function('number_format_i18n', [rt.new_int(var_total_words).dup()])]) } else { rt.call_function('sprintf', [rt.call_function('_n', [rt.new_string('%s character'), rt.new_string('%s characters'), rt.new_int(var_total_words).dup()]), rt.call_function('number_format_i18n', [rt.new_int(var_total_words).dup()])]) }
		var_parts << var_word_count_string.dup()
	}
	mut var_display_string := rt.call_function('implode', [rt.new_string('<br>'), var_parts.dup()])
	mut var_align_class_name := if !rt.is_true(var_attributes.array_get('textAlign')) { '' } else { rt.concat(rt.new_string('has-text-align-'), var_attributes.array_get('textAlign')) }
	mut var_wrapper_attributes := rt.call_function('get_block_wrapper_attributes', [rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }])])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'), var_wrapper_attributes.dup(), var_display_string.dup()])).str()
}

fn register_block_core_post_time_to_read() {
	rt.call_function('register_block_type_from_metadata', [@DIR + '/post-time-to-read', rt.create_array([rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_time_to_read' }])])
}



pub fn init_wp_includes_blocks_post_time_to_read_php() {
	rt.call_function('add_action', [rt.new_string('init'), rt.new_string('register_block_core_post_time_to_read')])
}

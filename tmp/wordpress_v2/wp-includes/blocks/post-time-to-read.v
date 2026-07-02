import rt

fn block_core_post_time_to_read_word_count(var_text_arg rt.PhpVal, var_type_arg rt.PhpVal) i64 {
	mut var_text := var_text_arg
	mut var_type := var_type_arg
	mut var_settings := map[string]rt.PhpVal{}
	mut var_count := i64(0)
	var_settings = {
		'html_regexp':                        '/<\\/?[a-z][^>]*?>/i'
		'html_comment_regexp':                '/<!--[\\s\\S]*?-->/'
		'space_regexp':                       '/&nbsp;|&#160;/i'
		'html_entity_regexp':                 '/&\\S+?;/'
		'connector_regexp':                   '/--|\\x{2014}/u'
		'remove_regexp':                      '/[\\x{0021}-\\x{0040}\\x{005B}-\\x{0060}\\x{007B}-\\x{007E}\\x{0080}-\\x{00BF}\\x{00D7}\\x{00F7}\\x{2000}-\\x{2BFF}\\x{2E00}-\\x{2E7F}]/u'
		'astral_regexp':                      '/[\\x{010000}-\\x{10FFFF}]/u'
		'words_regexp':                       '/\\S\\s+/u'
		'characters_excluding_spaces_regexp': '/\\S/u'
		'characters_including_spaces_regexp': '/[^\n\r\t\\x{00AD}\\x{2028}\\x{2029}]/u'
	}
	var_count = 0
	if rt.is_true(rt.identical(rt.new_string(''),
		rt.new_string(var_text.clone().to_string().trim_space())))
	{
		return var_count
	}
	if rt.is_true(rt.new_bool('characters_excluding_spaces' != var_type))
		&& rt.is_true(rt.new_bool('characters_including_spaces' != var_type)) {
		var_type = 'words'
	}
	var_text = rt.concat(var_text, rt.new_string('\n'))
	var_text = rt.call_function('preg_replace', [
		rt.new_string((var_settings['html_regexp']).str()),
		rt.new_string('\n'),
		var_text.clone(),
	])
	var_text = rt.call_function('preg_replace', [
		rt.new_string((var_settings['html_comment_regexp']).str()),
		rt.new_string(''),
		var_text.clone(),
	])
	if !(var_settings['shortcodes_regexp'] == '') {
		var_text = rt.call_function('preg_replace', [
			rt.new_string((var_settings['shortcodes_regexp']).str()),
			rt.new_string('\n'),
			var_text.clone(),
		])
	}
	var_text = rt.call_function('preg_replace', [
		rt.new_string((var_settings['space_regexp']).str()),
		rt.new_string(' '),
		var_text.clone(),
	])
	if rt.is_true(rt.identical(rt.new_string('words'), rt.new_string(var_type.str()))) {
		var_text = rt.call_function('preg_replace', [
			rt.new_string((var_settings['html_entity_regexp']).str()),
			rt.new_string(''),
			var_text.clone(),
		])
		var_text = rt.call_function('preg_replace', [
			rt.new_string((var_settings['connector_regexp']).str()),
			rt.new_string(' '),
			var_text.clone(),
		])
		var_text = rt.call_function('preg_replace', [
			rt.new_string((var_settings['remove_regexp']).str()),
			rt.new_string(''),
			var_text.clone(),
		])
	} else {
		var_text = rt.call_function('preg_replace', [
			rt.new_string((var_settings['html_entity_regexp']).str()),
			rt.new_string('a'),
			var_text.clone(),
		])
		var_text = rt.call_function('preg_replace', [
			rt.new_string((var_settings['astral_regexp']).str()),
			rt.new_string('a'),
			var_text.clone(),
		])
	}
	return rt.new_int((rt.call_function('preg_match_all', [
		rt.new_string((var_settings[var_type + '_regexp']).str()),
		var_text.clone(),
	])).to_i64())
}

fn render_block_core_post_time_to_read(var_attributes rt.PhpVal, var_content_arg rt.PhpVal, var_block rt.PhpVal) string {
	mut var_content := var_content_arg
	mut var_average_reading_rate := rt.new_null()
	mut var_display_mode := rt.new_null()
	mut var_word_count_type := rt.new_null()
	mut var_total_words := i64(0)
	mut var_parts := []rt.PhpVal{}
	mut var_min_minutes := rt.new_null()
	mut var_max_minutes := rt.new_null()
	mut var_time_string := rt.new_null()
	mut var_minutes_to_read := rt.new_null()
	mut var_word_count_string := rt.new_null()
	mut var_display_string := rt.new_null()
	mut var_align_class_name := ''
	mut var_wrapper_attributes := rt.new_null()
	if !(rt.get_property(var_block, 'context').array_isset(rt.new_string('postId'))) {
		return ''
	}
	var_content = rt.call_function('get_the_content', []rt.PhpVal{})
	var_average_reading_rate = if !(var_attributes.array_get(rt.new_string('averageReadingSpeed'))).is_null() {
		var_attributes.array_get(rt.new_string('averageReadingSpeed'))
	} else {
		rt.new_int(189)
	}
	var_display_mode = if !(var_attributes.array_get(rt.new_string('displayMode'))).is_null() {
		var_attributes.array_get(rt.new_string('displayMode'))
	} else {
		rt.new_string('time')
	}
	var_word_count_type = rt.call_function('wp_get_word_count_type', []rt.PhpVal{})
	var_total_words = block_core_post_time_to_read_word_count(var_content.clone(),
		var_word_count_type.clone())
	var_parts = []rt.PhpVal{}
	if rt.is_true(rt.identical(rt.new_string('time'), var_display_mode)) {
		if !(!rt.is_true(var_attributes.array_get(rt.new_string('displayAsRange')))) {
			var_min_minutes = rt.call_function('max', [rt.new_int(1),
				rt.new_int((rt.call_function('round', [
					rt.new_float(var_total_words / var_average_reading_rate * 0.8),
				])).to_i64())])
			var_max_minutes = rt.call_function('max', [rt.new_int(1),
				rt.new_int((rt.call_function('round', [
					rt.new_float(var_total_words / var_average_reading_rate * 1.2),
				])).to_i64())])
			if rt.is_true(rt.identical(var_min_minutes, var_max_minutes)) {
				var_max_minutes = rt.add(var_min_minutes, rt.new_int(1))
			}
			var_time_string = rt.call_function('sprintf', [
				rt.call_function('_x', [rt.new_string('%1$s–%2$s minutes'),
					rt.new_string('Range of minutes to read')]),
				var_min_minutes.clone(),
				var_max_minutes.clone(),
			])
		} else {
			var_minutes_to_read = rt.call_function('max', [rt.new_int(1),
				rt.new_int((rt.call_function('round', [
					rt.div(rt.new_int(var_total_words), var_average_reading_rate),
				])).to_i64())])
			var_time_string = rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s minute'),
					rt.new_string('%s minutes'), var_minutes_to_read.clone()]),
				var_minutes_to_read.clone(),
			])
		}
		var_parts << var_time_string.clone()
	}
	if rt.is_true(rt.identical(rt.new_string('words'), var_display_mode)) {
		var_word_count_string = if rt.is_true(rt.identical(rt.new_string('words'), var_word_count_type)) { rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s word'),
					rt.new_string('%s words'), rt.new_int(var_total_words).clone()]),
				rt.call_function('number_format_i18n', [rt.new_int(var_total_words).clone()]),
			]) } else { rt.call_function('sprintf', [
				rt.call_function('_n', [rt.new_string('%s character'),
					rt.new_string('%s characters'), rt.new_int(var_total_words).clone()]),
				rt.call_function('number_format_i18n', [rt.new_int(var_total_words).clone()]),
			]) }
		var_parts << var_word_count_string.clone()
	}
	var_display_string = rt.call_function('implode', [rt.new_string('<br>'),
		rt.create_array_from_list(var_parts)])
	var_align_class_name = if !rt.is_true(var_attributes.array_get(rt.new_string('textAlign'))) {
		''
	} else {
		rt.concat(rt.new_string('has-text-align-'),
			var_attributes.array_get(rt.new_string('textAlign')))
	}
	var_wrapper_attributes = rt.call_function('get_block_wrapper_attributes', [
		rt.create_array([rt.ArrayItem{ key: 'class', val: var_align_class_name }]),
	])
	return (rt.call_function('sprintf', [rt.new_string('<div %1$s>%2$s</div>'),
		var_wrapper_attributes.clone(), var_display_string.clone()])).str()
}

fn register_block_core_post_time_to_read() {
	rt.call_function('register_block_type_from_metadata', [
		rt.new_string(@DIR + '/post-time-to-read'),
		rt.create_array([
			rt.ArrayItem{ key: 'render_callback', val: 'render_block_core_post_time_to_read' },
		]),
	])
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('add_action', [rt.new_string('init'),
		rt.new_string('register_block_core_post_time_to_read')])
}

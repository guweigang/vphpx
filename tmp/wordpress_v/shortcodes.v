module wp_includes

import rt

fn add_shortcode(var_tag rt.PhpVal, var_callback rt.PhpVal) {
	mut var_shortcode_tags := rt.new_null()
	if rt.is_true(rt.identical(rt.new_string(''),
		rt.new_string(var_tag.clone().to_string().trim_space())))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('__', [
				rt.new_string('Invalid shortcode name: Empty name given.'),
			]),
			rt.new_string('4.4.0')])
		return
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(0), rt.call_function('preg_match', [
		rt.new_string('@[<>&/\\[\\]\\x00-\\x20=]@'),
		var_tag.clone(),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Invalid shortcode name: %1$s. Do not use spaces or reserved characters: %2$s'),
				]),
				var_tag.clone(),
				rt.new_string('& / < > [ ] ='),
			]),
			rt.new_string('4.4.0')])
		return
	}
	var_shortcode_tags.array_set(var_tag, var_callback.clone())
}

fn remove_shortcode(var_tag rt.PhpVal) {
	mut var_shortcode_tags := rt.new_null()
	var_shortcode_tags.array_unset(var_tag)
}

fn remove_all_shortcodes() {
	mut var_shortcode_tags := rt.new_null()
	var_shortcode_tags = rt.new_array()
}

fn shortcode_exists(var_tag rt.PhpVal) bool {
	mut var_shortcode_tags := rt.new_null()
	return var_shortcode_tags.clone().array_isset(var_tag.clone())
}

fn has_shortcode(var_content rt.PhpVal, var_tag rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	mut var_shortcode := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_content.clone(), rt.new_string('[')])))))
	{
		return false
	}
	if rt.is_true(rt.new_bool(shortcode_exists(var_tag.clone()))) {
		rt.call_function('preg_match_all', [
			rt.new_string('/' + get_shortcode_regex() + '/'),
			var_content.clone(),
			rt.create_array_from_list(var_matches),
			rt.get_constant('PREG_SET_ORDER'),
		])
		if !rt.is_true(var_matches) {
			return false
		}
		for var_shortcode_shadow in var_matches {
			if rt.is_true(rt.identical(var_tag, var_shortcode_shadow.array_get(2))) {
				return true
			} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_shortcode_shadow.array_get(5)))
				&& has_shortcode(var_shortcode_shadow.array_get(5), var_tag.clone())))
			{
				return true
			}
		}
	}
	return false
}

fn get_shortcode_tags_in_content(var_content rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	mut var_tags := rt.new_null()
	mut var_shortcode := []rt.PhpVal{}
	mut var_deep_tags := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_content.clone(), rt.new_string('[')])))))
	{
		return rt.new_array()
	}
	rt.call_function('preg_match_all', [rt.new_string('/' + get_shortcode_regex() + '/'),
		var_content.clone(), rt.create_array_from_list(var_matches),
		rt.get_constant('PREG_SET_ORDER')])
	if !rt.is_true(var_matches) {
		return rt.new_array()
	}
	var_tags = rt.new_array()
	for var_shortcode_shadow in var_matches {
		var_tags.array_push(var_shortcode_shadow.array_get(2))
		if !(!rt.is_true(var_shortcode_shadow.array_get(5))) {
			var_deep_tags = get_shortcode_tags_in_content(var_shortcode_shadow.array_get(5))
			if !(!rt.is_true(var_deep_tags)) {
				var_tags = rt.call_function('array_merge', [var_tags.clone(),
					var_deep_tags.clone()])
			}
		}
	}
	return var_tags.clone()
}

fn apply_shortcodes(var_content rt.PhpVal, ignore_html bool) rt.PhpVal {
	mut var_ignore_html := ignore_html
	return do_shortcode(var_content.clone(), ignore_html)
}

fn do_shortcode(var_content_arg rt.PhpVal, ignore_html bool) rt.PhpVal {
	mut var_ignore_html := ignore_html
	mut var_content := var_content_arg
	mut var_shortcode_tags := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_tagnames := rt.new_null()
	mut var_has_filter := rt.new_null()
	mut var_filter_added := rt.new_null()
	mut var_pattern := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_content.clone(), rt.new_string('[')])))))
	{
		return var_content.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_shortcode_tags)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_shortcode_tags.clone().is_array())))))))
	{
		return var_content.clone()
	}
	rt.call_function('preg_match_all', [
		rt.new_string('@\\[([^<>&/\\[\\]\\x00-\\x20=]++)@'),
		var_content.clone(),
		rt.create_array_from_list(var_matches),
	])
	var_tagnames = rt.call_function('array_intersect', [
		rt.func_array_keys(var_shortcode_tags.clone()),
		var_matches.array_get(1),
	])
	if !rt.is_true(var_tagnames) {
		return var_content.clone()
	}
	var_has_filter = rt.call_function('has_filter', [
		rt.new_string('wp_get_attachment_image_context'),
		rt.new_string('_filter_do_shortcode_context'),
	])
	var_filter_added = rt.new_bool(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_filter)))) {
		var_filter_added = rt.call_function('add_filter', [
			rt.new_string('wp_get_attachment_image_context'),
			rt.new_string('_filter_do_shortcode_context'),
		])
	}
	var_content = do_shortcodes_in_html_tags(var_content.clone(), rt.new_bool(ignore_html),
		var_tagnames.clone())
	var_pattern = rt.new_string(get_shortcode_regex(var_tagnames.clone()))
	var_content = rt.call_function('preg_replace_callback', [
		rt.new_string('/${var_pattern.to_string()}/'),
		rt.new_string('do_shortcode_tag'),
		var_content.clone(),
	])
	var_content = unescape_invalid_shortcodes(var_content.clone())
	if rt.is_true(var_filter_added) {
		rt.call_function('remove_filter', [
			rt.new_string('wp_get_attachment_image_context'),
			rt.new_string('_filter_do_shortcode_context'),
		])
	}
	return var_content.clone()
}

fn _filter_do_shortcode_context() string {
	return 'do_shortcode'
}

fn get_shortcode_regex(var_tagnames_arg rt.PhpVal) string {
	mut var_tagnames := var_tagnames_arg
	mut var_shortcode_tags := rt.new_null()
	mut var_tagregexp := rt.new_null()
	if !rt.is_true(var_tagnames) {
		var_tagnames = rt.func_array_keys(var_shortcode_tags.clone())
	}
	var_tagregexp = rt.call_function('implode', [rt.new_string('|'),
		rt.call_function('array_map', [rt.new_string('preg_quote'),
			var_tagnames.clone()])])
	return '\\[' + '(\\[?)' + '(${var_tagregexp.to_string()})' + '(?![\\w-])' + '(' + '[^\\]\\/]*' +
		'(?:' + '\\/(?!\\])' + '[^\\]\\/]*' + ')*?' + ')' + '(?:' + '(\\/)' + '\\]' + '|' + '\\]' +
		'(?:' + '(' + '[^\\[]*+' + '(?:' + '\\[(?!\\/\\2\\])' + '[^\\[]*+' + ')*+' + ')' +
		'\\[\\/\\2\\]' + ')?' + ')' + '(\\]?)'
	return ''
}

fn do_shortcode_tag(var_m rt.PhpVal) rt.PhpVal {
	mut var_shortcode_tags := rt.new_null()
	mut var_tag := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_return := rt.new_null()
	mut var_content := rt.new_null()
	mut var_output := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('['), var_m.array_get(1)))
		&& rt.is_true(rt.identical(rt.new_string(']'), var_m.array_get(6)))))
	{
		return rt.call_function('substr', [var_m.array_get(0),
			rt.new_int(1), -1])
	}
	var_tag = var_m.array_get(2)
	var_attr = shortcode_parse_atts(var_m.array_get(3))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [
		var_shortcode_tags.array_get(var_tag),
	])))))
	{
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Attempting to parse a shortcode without a valid callback: %s'),
				]),
				var_tag.clone(),
			]),
			rt.new_string('4.3.0')])
		return var_m.array_get(0)
	}
	var_return = rt.call_function('apply_filters', [
		rt.new_string('pre_do_shortcode_tag'),
		rt.new_bool(false),
		var_tag.clone(),
		var_attr.clone(),
		rt.create_array_from_list(var_m),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_return)))) {
		return var_return.clone()
	}
	var_content = if !(var_m.array_get(5)).is_null() { var_m.array_get(5) } else { rt.new_null() }
	var_output = rt.new_string(
		(var_m.array_get(1)).str() + (rt.call_function('call_user_func', [var_shortcode_tags.array_get(var_tag), var_attr.clone(), var_content.clone(), var_tag.clone()])).str() +
		(var_m.array_get(6)).str())
	return rt.call_function('apply_filters', [rt.new_string('do_shortcode_tag'),
		var_output.clone(), var_tag.clone(), var_attr.clone(),
		rt.create_array_from_list(var_m)])
}

fn do_shortcodes_in_html_tags(var_content_arg rt.PhpVal, var_ignore_html rt.PhpVal, var_tagnames rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_trans := map[string]rt.PhpVal{}
	mut var_pattern := ''
	mut var_textarr := rt.new_null()
	mut var_element := rt.new_null()
	mut var_noopen := false
	mut var_noclose := false
	mut var_attributes := rt.new_null()
	mut var_front := rt.new_null()
	mut var_back := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_elname := rt.new_null()
	mut var_attr := rt.new_null()
	mut var_open := rt.new_null()
	mut var_close := rt.new_null()
	mut var_double := rt.new_null()
	mut var_single := rt.new_null()
	mut var_count := i64(0)
	mut var_new_attr := rt.new_null()
	var_trans = {
		'&#91;': '&#091;'
		'&#93;': '&#093;'
	}
	var_content = rt.call_function('strtr', [var_content.clone(),
		rt.create_array_from_native_map(var_trans)])
	var_trans = {
		'[': '&#91;'
		']': '&#93;'
	}
	var_pattern = get_shortcode_regex(var_tagnames.clone())
	var_textarr = rt.call_function('wp_html_split', [var_content.clone()])
	{
		mut iter_1 := var_textarr.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element_shadow := item_1.val
			if rt.is_true(rt.new_bool(
				rt.is_true(rt.identical(rt.new_string(''), var_element_shadow))
				|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('<'), var_element_shadow.array_get(0)))))))
			{
				continue
			}
			var_noopen = !(rt.is_true(rt.call_function('str_contains', [
				var_element_shadow.clone(), rt.new_string('[')])))
			var_noclose = !(rt.is_true(rt.call_function('str_contains', [
				var_element_shadow.clone(), rt.new_string(']')])))
			if var_noopen || var_noclose {
				if rt.is_true(rt.is_true(rt.new_bool(var_noopen)) != rt.is_true(rt.new_bool(var_noclose))) {
					var_element_shadow = rt.call_function('strtr', [
						var_element_shadow.clone(), rt.create_array_from_native_map(var_trans)])
				}
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_ignore_html)
				|| rt.is_true(rt.call_function('str_starts_with', [var_element_shadow.clone(), rt.new_string('<!--')]))))
				|| rt.is_true(rt.call_function('str_starts_with', [var_element_shadow.clone(), rt.new_string('<![CDATA[')]))))
			{
				var_element_shadow = rt.call_function('strtr', [
					var_element_shadow.clone(), rt.create_array_from_native_map(var_trans)])
				continue
			}
			var_attributes = rt.call_function('wp_kses_attr_parse', [
				var_element_shadow.clone()])
			if rt.is_true(rt.identical(rt.new_bool(false), var_attributes)) {
				if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
					rt.new_string('%^<\\s*\\[\\[?[^\\[\\]]+\\]%'),
					var_element_shadow.clone(),
				])))
				{
					var_element_shadow = rt.call_function('preg_replace_callback', [
						rt.new_string('/${var_pattern}/'),
						rt.new_string('do_shortcode_tag'),
						var_element_shadow.clone(),
					])
				}
				var_element_shadow = rt.call_function('strtr', [
					var_element_shadow.clone(), rt.create_array_from_native_map(var_trans)])
				continue
			}
			var_front = rt.call_function('array_shift', [var_attributes.clone()])
			var_back = rt.call_function('array_pop', [var_attributes.clone()])
			var_matches = rt.new_array()
			rt.call_function('preg_match', [rt.new_string('%[a-zA-Z0-9]+%'),
				var_front.clone(), rt.create_array_from_list(var_matches)])
			var_elname = var_matches.array_get(0)
			{
				mut iter_2 := var_attributes.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_attr_shadow := item_2.val
					var_open = rt.call_function('strpos', [var_attr_shadow.clone(),
						rt.new_string('[')])
					var_close = rt.call_function('strpos', [var_attr_shadow.clone(),
						rt.new_string(']')])
					if rt.is_true(rt.new_bool(
						rt.is_true(rt.identical(rt.new_bool(false), var_open))
						|| rt.is_true(rt.identical(rt.new_bool(false), var_close))))
					{
						continue
					}
					var_double = rt.call_function('strpos', [
						var_attr_shadow.clone(), rt.new_string('"')])
					var_single = rt.call_function('strpos', [
						var_attr_shadow.clone(), rt.new_string("'")])
					if rt.is_true(rt.new_bool(
						rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_single))
						|| rt.is_true(rt.less(var_open, var_single))))
						&& rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_double))
						|| rt.is_true(rt.less(var_open, var_double))))))
					{
						var_attr_shadow = rt.call_function('preg_replace_callback', [
							rt.new_string('/${var_pattern}/'),
							rt.new_string('do_shortcode_tag'),
							var_attr_shadow.clone(),
						])
					} else {
						var_count = 0
						var_new_attr = rt.call_function('preg_replace_callback', [
							rt.new_string('/${var_pattern}/'),
							rt.new_string('do_shortcode_tag'),
							var_attr_shadow.clone(),
							-1,
							rt.new_int(var_count).clone(),
						])
						if var_count > 0 {
							var_new_attr = rt.call_function('wp_kses_one_attr', [
								var_new_attr.clone(),
								var_elname.clone(),
							])
							if rt.is_true(rt.new_bool('' != var_new_attr.clone().to_string().trim_space())) {
								var_attr_shadow = var_new_attr.clone()
							}
						}
					}
				}
			}
			var_element_shadow = rt.new_string(var_front.str() +
				(rt.call_function('implode', [rt.new_string(''), var_attributes.clone()])).str() +
				var_back.str())
			var_element_shadow = rt.call_function('strtr', [var_element_shadow.clone(),
				rt.create_array_from_native_map(var_trans)])
		}
	}
	var_content = rt.call_function('implode', [rt.new_string(''),
		var_textarr.clone()])
	return var_content.clone()
}

fn unescape_invalid_shortcodes(var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_trans := map[string]rt.PhpVal{}
	var_trans = {
		'&#91;': '['
		'&#93;': ']'
	}
	var_content = rt.call_function('strtr', [var_content.clone(),
		rt.create_array_from_native_map(var_trans)])
	return var_content.clone()
}

fn get_shortcode_atts_regex() string {
	return '/([\\w-]+)\\s*=\\s*"([^"]*)"(?:\\s|$)|([\\w-]+)\\s*=\\s*\'([^\']*)\'(?:\\s|$)|([\\w-]+)\\s*=\\s*([^\\s\'"]+)(?:\\s|$)|"([^"]*)"(?:\\s|$)|\'([^\']*)\'(?:\\s|$)|(\\S+)(?:\\s|$)/'
}

fn shortcode_parse_atts(var_text_arg rt.PhpVal) rt.PhpVal {
	mut var_text := var_text_arg
	mut var_match := rt.new_null()
	mut var_atts := rt.new_null()
	mut var_pattern := ''
	mut var_m := []rt.PhpVal{}
	mut var_value := ''
	var_atts = rt.new_array()
	var_pattern = get_shortcode_atts_regex()
	var_text = rt.call_function('preg_replace', [
		rt.new_string('/[\\x{00a0}\\x{200b}]+/u'),
		rt.new_string(' '),
		var_text.clone(),
	])
	if rt.is_true(rt.call_function('preg_match_all', [rt.new_string(var_pattern.str()).clone(),
		var_text.clone(), var_match.clone(), rt.get_constant('PREG_SET_ORDER')]))
	{
		{
			mut iter_1 := var_match.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_m_shadow := item_1.val
				if !(!rt.is_true(var_m_shadow.array_get(1))) {
					var_atts.array_set(var_m_shadow.array_get(1).to_string().to_lower(), rt.call_function('stripcslashes', [
						var_m_shadow.array_get(2),
					]))
				} else if !(!rt.is_true(var_m_shadow.array_get(3))) {
					var_atts.array_set(var_m_shadow.array_get(3).to_string().to_lower(), rt.call_function('stripcslashes', [
						var_m_shadow.array_get(4),
					]))
				} else if !(!rt.is_true(var_m_shadow.array_get(5))) {
					var_atts.array_set(var_m_shadow.array_get(5).to_string().to_lower(), rt.call_function('stripcslashes', [
						var_m_shadow.array_get(6),
					]))
				} else if rt.is_true(rt.new_bool(var_m_shadow.array_isset(rt.new_int(7))
					&& rt.is_true(rt.new_int(var_m_shadow.array_get(7).to_string().len))))
				{
					var_atts.array_push(rt.call_function('stripcslashes', [
						var_m_shadow.array_get(7),
					]))
				} else if rt.is_true(rt.new_bool(var_m_shadow.array_isset(rt.new_int(8))
					&& rt.is_true(rt.new_int(var_m_shadow.array_get(8).to_string().len))))
				{
					var_atts.array_push(rt.call_function('stripcslashes', [
						var_m_shadow.array_get(8),
					]))
				} else if var_m_shadow.array_isset(rt.new_int(9)) {
					var_atts.array_push(rt.call_function('stripcslashes', [
						var_m_shadow.array_get(9),
					]))
				}
			}
		}
		{
			mut iter_1 := var_atts.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value_shadow := item_1.val
				if rt.is_true(rt.call_function('str_contains', [
					var_value_shadow.clone(), rt.new_string('<')]))
				{
					if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [
						rt.new_string('/^[^<]*+(?:<[^>]*+>[^<]*+)*+$/'),
						var_value_shadow.clone(),
					])))))
					{
						var_value_shadow = rt.new_string('')
					}
				}
			}
		}
	}
	return var_atts.clone()
}

fn shortcode_atts(var_pairs rt.PhpVal, var_atts_arg rt.PhpVal, shortcode string) rt.PhpVal {
	mut var_shortcode := shortcode
	mut var_atts := var_atts_arg
	mut var_out := rt.new_null()
	mut var_default := rt.new_null()
	mut var_name := rt.new_null()
	var_atts = rt.cast_array(var_atts)
	var_out = rt.new_array()
	{
		mut iter_1 := var_pairs.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_default_shadow := item_1.val
			mut var_name_shadow := item_1.key
			if rt.is_true(rt.new_bool(var_atts.clone().array_isset(var_name_shadow.clone()))) {
				var_out.array_set(var_name_shadow, var_atts.array_get(var_name_shadow))
			} else {
				var_out.array_set(var_name_shadow, var_default_shadow.clone())
			}
		}
	}
	if var_shortcode.len > 0 && var_shortcode != '0' {
		var_out = rt.call_function('apply_filters', [
			rt.new_string('shortcode_atts_${var_shortcode}'),
			var_out.clone(),
			var_pairs.clone(),
			var_atts.clone(),
			rt.new_string(shortcode),
		])
	}
	return var_out.clone()
}

fn strip_shortcodes(var_content_arg rt.PhpVal) rt.PhpVal {
	mut var_content := var_content_arg
	mut var_shortcode_tags := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	mut var_tags_to_remove := rt.new_null()
	mut var_tagnames := rt.new_null()
	mut var_pattern := ''
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [
		var_content.clone(), rt.new_string('[')])))))
	{
		return var_content.clone()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_shortcode_tags)
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_shortcode_tags.clone().is_array())))))))
	{
		return var_content.clone()
	}
	rt.call_function('preg_match_all', [
		rt.new_string('@\\[([^<>&/\\[\\]\\x00-\\x20=]++)@'),
		var_content.clone(),
		rt.create_array_from_list(var_matches),
	])
	var_tags_to_remove = rt.func_array_keys(var_shortcode_tags.clone())
	var_tags_to_remove = rt.call_function('apply_filters', [
		rt.new_string('strip_shortcodes_tagnames'),
		var_tags_to_remove.clone(),
		var_content.clone(),
	])
	var_tagnames = rt.call_function('array_intersect', [var_tags_to_remove.clone(),
		var_matches.array_get(1)])
	if !rt.is_true(var_tagnames) {
		return var_content.clone()
	}
	var_content = do_shortcodes_in_html_tags(var_content.clone(), rt.new_bool(true),
		var_tagnames.clone())
	var_pattern = get_shortcode_regex(var_tagnames.clone())
	var_content = rt.call_function('preg_replace_callback', [
		rt.new_string('/${var_pattern}/'),
		rt.new_string('strip_shortcode_tag'),
		var_content.clone(),
	])
	var_content = unescape_invalid_shortcodes(var_content.clone())
	return var_content.clone()
}

fn strip_shortcode_tag(var_m rt.PhpVal) string {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('['), var_m.array_get(1)))
		&& rt.is_true(rt.identical(rt.new_string(']'), var_m.array_get(6)))))
	{
		return (rt.call_function('substr', [var_m.array_get(0),
			rt.new_int(1), -1])).str()
	}
	return (var_m.array_get(1)).str() + (var_m.array_get(6)).str()
}

pub fn init_wp_includes_shortcodes_php() {
	mut var_shortcode_tags := rt.new_array()
}

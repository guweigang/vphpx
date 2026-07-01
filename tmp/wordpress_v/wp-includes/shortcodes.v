import rt

fn add_shortcode(var_tag rt.PhpVal, var_callback rt.PhpVal) {
	mut var_shortcode_tags := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.identical(rt.new_string(''), rt.new_string(var_tag.dup().to_string().trim_space()))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('__', [rt.new_string('Invalid shortcode name: Empty name given.')]), rt.new_string('4.4.0')])
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Invalid shortcode name: %1$s. Do not use spaces or reserved characters: %2$s')]), var_tag.dup(), rt.new_string('& / < > [ ] =')]), rt.new_string('4.4.0')])
		return rt.new_null()
	}
	var_shortcode_tags.array_set(var_tag, var_callback.dup())
}

fn remove_shortcode(var_tag rt.PhpVal) {
	mut var_shortcode_tags := rt.new_null()
	// unsupported statement: Stmt_Global
	var_shortcode_tags.array_unset(var_tag)
}

fn remove_all_shortcodes() {
	// unsupported statement: Stmt_Global
	mut var_shortcode_tags := rt.new_array()
}

fn shortcode_exists(var_tag rt.PhpVal) bool {
	mut var_shortcode_tags := rt.new_null()
	// unsupported statement: Stmt_Global
	return var_shortcode_tags.dup().array_isset(var_tag.dup())
}

fn has_shortcode(var_content rt.PhpVal, var_tag rt.PhpVal) bool {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_content.dup(), rt.new_string('[')]))))) {
		return false
	}
	if rt.is_true(rt.new_bool(shortcode_exists(var_tag.dup()))) {
		rt.call_function('preg_match_all', ['/' + get_shortcode_regex() + '/', var_content.dup(), var_matches.dup(), rt.get_constant('PREG_SET_ORDER')])
		if !rt.is_true(var_matches) {
			return false
		}
		for var_shortcode in var_matches {
			if rt.is_true(rt.identical(var_tag, var_shortcode.array_get(2))) {
				return true
			} else if rt.is_true(rt.new_bool(!(!rt.is_true(var_shortcode.array_get(5))) && has_shortcode(var_shortcode.array_get(5), var_tag.dup()))) {
				return true
			}
		}
	}
	return false
}

fn get_shortcode_tags_in_content(var_content rt.PhpVal) rt.PhpVal {
	mut var_matches := []rt.PhpVal{}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_content.dup(), rt.new_string('[')]))))) {
		return rt.new_array()
	}
	rt.call_function('preg_match_all', ['/' + get_shortcode_regex() + '/', var_content.dup(), var_matches.dup(), rt.get_constant('PREG_SET_ORDER')])
	if !rt.is_true(var_matches) {
		return rt.new_array()
	}
	mut var_tags := rt.new_array()
	for var_shortcode in var_matches {
		var_tags.array_push(var_shortcode.array_get(2))
		if !(!rt.is_true(var_shortcode.array_get(5))) {
			mut var_deep_tags := get_shortcode_tags_in_content(var_shortcode.array_get(5))
			if !(!rt.is_true(var_deep_tags)) {
				var_tags = rt.call_function('array_merge', [var_tags.dup(), var_deep_tags.dup()])
			}
		}
	}
	return var_tags.dup()
}

fn apply_shortcodes(var_content rt.PhpVal, ignore_html bool) rt.PhpVal {
	return do_shortcode(var_content.dup(), ignore_html)
}

fn do_shortcode(var_content rt.PhpVal, ignore_html bool) rt.PhpVal {
	mut var_shortcode_tags := rt.new_null()
	mut var_matches := []rt.PhpVal{}
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('str_contains', [var_content.dup(), rt.new_string('[')]))))) {
		return var_content.dup()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(var_shortcode_tags) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_shortcode_tags.dup().is_array()))))))) {
		return var_content.dup()
	}
	rt.call_function('preg_match_all', [rt.new_string('@\\[([^<>&/\\[\\]\\x00-\\x20=]++)@'), var_content.dup(), var_matches.dup()])
	mut var_tagnames := rt.call_function('array_intersect', [rt.func_array_keys(var_shortcode_tags.dup()), var_matches.array_get(1)])
	if !rt.is_true(var_tagnames) {
		return var_content.dup()
	}
	mut var_has_filter := rt.call_function('has_filter', [rt.new_string('wp_get_attachment_image_context'), rt.new_string('_filter_do_shortcode_context')])
	mut var_filter_added := rt.new_bool(rt.new_bool(false))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_filter)))) {
		var_filter_added = rt.call_function('add_filter', [rt.new_string('wp_get_attachment_image_context'), rt.new_string('_filter_do_shortcode_context')])
	}
	var_content = do_shortcodes_in_html_tags(var_content.dup(), rt.new_bool(ignore_html), var_tagnames.dup())
	mut var_pattern := rt.new_string(rt.new_string(get_shortcode_regex(var_tagnames.dup())))
	var_content = rt.call_function('preg_replace_callback', [rt.new_string("/${var_pattern.to_string()}/"), rt.new_string('do_shortcode_tag'), var_content.dup()])
	var_content = unescape_invalid_shortcodes(var_content.dup())
	if rt.is_true(var_filter_added) {
		rt.call_function('remove_filter', [rt.new_string('wp_get_attachment_image_context'), rt.new_string('_filter_do_shortcode_context')])
	}
	return var_content.dup()
}

fn _filter_do_shortcode_context() string {
	return 'do_shortcode'
}

fn get_shortcode_regex(var_tagnames rt.PhpVal) string {
	mut var_shortcode_tags := rt.new_null()
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_tagnames) {
		var_tagnames = rt.func_array_keys(var_shortcode_tags.dup())
	}
	mut var_tagregexp := rt.call_function('implode', [rt.new_string('|'), rt.call_function('array_map', [rt.new_string('preg_quote'), var_tagnames.dup()])])
	return '\\[' + '(\\[?)' + "(${var_tagregexp.to_string()})" + '(?![\\w-])' + '(' + '[^\\]\\/]*' + '(?:' + '\\/(?!\\])' + '[^\\]\\/]*' + ')*?' + ')' + '(?:' + '(\\/)' + '\\]' + '|' + '\\]' + '(?:' + '(' + '[^\\[]*+' + '(?:' + '\\[(?!\\/\\2\\])' + '[^\\[]*+' + ')*+' + ')' + '\\[\\/\\2\\]' + ')?' + ')' + '(\\]?)'
	// unsupported statement: Stmt_Nop
	return ''
}

fn do_shortcode_tag(var_m rt.PhpVal) rt.PhpVal {
	mut var_shortcode_tags := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('['), var_m.array_get(1))) && rt.is_true(rt.identical(rt.new_string(']'), var_m.array_get(6))))) {
		return rt.call_function('substr', [var_m.array_get(0), rt.new_int(1), // unsupported expression: Expr_UnaryMinus])
	}
	mut var_tag := var_m.array_get(2)
	mut var_attr := shortcode_parse_atts(var_m.array_get(3))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_callable', [var_shortcode_tags.array_get(var_tag)]))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@FN), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Attempting to parse a shortcode without a valid callback: %s')]), var_tag.dup()]), rt.new_string('4.3.0')])
		return var_m.array_get(0)
	}
	mut var_return := rt.call_function('apply_filters', [rt.new_string('pre_do_shortcode_tag'), rt.new_bool(false), var_tag.dup(), var_attr.dup(), var_m.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_return.dup()
	}
	mut var_content := if !(var_m.array_get(5)).is_null() { var_m.array_get(5) } else { rt.new_null() }
	mut var_output := rt.new_string((var_m.array_get(1)).str() + (rt.call_function('call_user_func', [var_shortcode_tags.array_get(var_tag), var_attr.dup(), var_content.dup(), var_tag.dup()])).str() + (var_m.array_get(6)).str())
	return rt.call_function('apply_filters', [rt.new_string('do_shortcode_tag'), var_output.dup(), var_tag.dup(), var_attr.dup(), var_m.dup()])
}

fn do_shortcodes_in_html_tags(var_content rt.PhpVal, var_ignore_html rt.PhpVal, var_tagnames rt.PhpVal) rt.PhpVal {
	mut var_trans := { '&#91;': '&#091;', '&#93;': '&#093;' }
	var_content = rt.call_function('strtr', [var_content.dup(), var_trans.dup()])
	var_trans = { '[': '&#91;', ']': '&#93;' }
	mut var_pattern := get_shortcode_regex(var_tagnames.dup())
	mut var_textarr := rt.call_function('wp_html_split', [var_content.dup()])
	{
		mut iter_1 := var_textarr.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_element := item_1.val
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string(''), var_element)) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				continue
			}
			mut var_noopen := !(rt.is_true(rt.call_function('str_contains', [var_element.dup(), rt.new_string('[')])))
			mut var_noclose := !(rt.is_true(rt.call_function('str_contains', [var_element.dup(), rt.new_string(']')])))
			if var_noopen || var_noclose {
				if rt.is_true(// unsupported expression: Expr_BinaryOp_LogicalXor) {
					var_element = rt.call_function('strtr', [var_element.dup(), var_trans.dup()])
				}
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_ignore_html) || rt.is_true(rt.call_function('str_starts_with', [var_element.dup(), rt.new_string('<!--')])))) || rt.is_true(rt.call_function('str_starts_with', [var_element.dup(), rt.new_string('<![CDATA[')])))) {
				var_element = rt.call_function('strtr', [var_element.dup(), var_trans.dup()])
				continue
			}
			mut var_attributes := rt.call_function('wp_kses_attr_parse', [var_element.dup()])
			if rt.is_true(rt.identical(rt.new_bool(false), var_attributes)) {
				if rt.is_true(rt.identical(rt.new_int(1), rt.call_function('preg_match', [rt.new_string('%^<\\s*\\[\\[?[^\\[\\]]+\\]%'), var_element.dup()]))) {
					var_element = rt.call_function('preg_replace_callback', [rt.new_string("/${var_pattern}/"), rt.new_string('do_shortcode_tag'), var_element.dup()])
				}
				var_element = rt.call_function('strtr', [var_element.dup(), var_trans.dup()])
				continue
			}
			mut var_front := rt.call_function('array_shift', [var_attributes.dup()])
			mut var_back := rt.call_function('array_pop', [var_attributes.dup()])
			mut var_matches := rt.new_array()
			rt.call_function('preg_match', [rt.new_string('%[a-zA-Z0-9]+%'), var_front.dup(), var_matches.dup()])
			mut var_elname := var_matches.array_get(0)
			{
				mut iter_2 := var_attributes.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_attr := item_2.val
					mut var_open := rt.call_function('strpos', [.dup(), ])
					mut var_close := 
					if rt.is_true() {
					}
					
				}
			}
		}
	}
}



pub fn init_wp_includes_shortcodes_php() {
	mut var_shortcode_tags := rt.new_array()
}

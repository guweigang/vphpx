import rt

pub fn Class_WP_Token_Map.storage_version() string {
	return '6.6.0-trunk'
}
pub fn Class_WP_Token_Map.max_length() i64 {
	return 256
}
struct Class_WP_Token_Map {
	rt.PhpObjectBase
pub mut:
		key_length rt.PhpVal = rt.new_int(2)
		large_words rt.PhpVal = rt.new_array()
		groups rt.PhpVal = rt.new_string('')
		small_words rt.PhpVal = rt.new_string('')
		small_mappings rt.PhpVal = rt.new_array()
}

fn Class_WP_Token_Map.from_array(mut var_mappings Class_array, key_length i64) rt.PhpVal {
	mut var_map := create_wp_token_map()
	var_map.key_length = rt.new_int(key_length)
	mut var_groups := rt.new_array()
	mut var_shorts := rt.new_array()
	mut iter_1 := var_mappings.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_mapping := item_1.val
		mut var_word := item_1.key
		if Class_WP_Token_Map.max_length() <= var_word.clone().to_string().len || Class_WP_Token_Map.max_length() <= var_mapping.clone().to_string().len {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Token Map tokens and substitutions must all be shorter than %1$d bytes.')]), rt.new_int(Class_WP_Token_Map.max_length())]), rt.new_string('6.6.0')])
			return rt.new_null()
		}
		mut var_length := rt.new_int(var_word.clone().to_string().len)
		if rt.is_true(rt.greater_equal(rt.new_int(key_length), var_length)) {
			var_shorts << var_word.clone()
		} else {
			mut var_group := rt.call_function('substr', [var_word.clone(), rt.new_int(0), rt.new_int(key_length)])
			if !(var_groups.array_isset(var_group)) {
				var_groups.array_set(var_group, rt.new_array())
			}
			var_groups.array_get_mut(var_group).array_push(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('substr', [var_word.clone(), rt.new_int(key_length)]) }, rt.ArrayItem{ key: none, val: var_mapping }]))
		}
	}
	rt.call_function('usort', [rt.create_array_from_list(var_shorts), rt.new_string('WP_Token_Map::longest_first_then_alphabetical')])
	mut iter_2 := var_groups.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_group := item_2.val
		mut var_group_key := item_2.key
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_a := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			mut var_b := if args.len > 1 { args[1].clone() } else { rt.new_null() }
			return Class_WP_Token_Map.longest_first_then_alphabetical((var_a.array_get(rt.new_int(0))).str(), (var_b.array_get(rt.new_int(0))).str())
			}
		rt.call_function('usort', [var_groups.array_get(var_group_key), rt.new_closure(closure_1_fn)])
	}
	for var_word in var_shorts {
		var_map.small_words = rt.concat(var_map.small_words, rt.call_function('str_pad', [var_word.clone(), rt.new_int(key_length + 1), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')]))
		var_map.small_mappings.array_push(var_mappings.array_get(var_word))
	}
	mut var_group_keys := rt.func_array_keys(var_groups.clone())
	rt.call_function('sort', [var_group_keys.clone()])
	mut iter_3 := var_group_keys.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_group := item_3.val
		var_map.groups = rt.concat(var_map.groups, rt.new_string("${var_group.to_string()}"))
		mut var_group_string := rt.new_string('')
		mut iter_4 := var_groups.array_get(var_group).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_group_word := item_4.val
			mut list_tmp_1 := var_group_word
			mut var_word := (list_tmp_1).array_get(0)
			mut var_mapping := (list_tmp_1).array_get(1)
			mut var_word_length := rt.call_function('pack', [rt.new_string('C'), rt.new_int(var_word.clone().to_string().len)])
			mut var_mapping_length := rt.call_function('pack', [rt.new_string('C'), rt.new_int(var_mapping.clone().to_string().len)])
			var_group_string = rt.concat(var_group_string, rt.new_string("${var_word_length.to_string()}${var_word.to_string()}${var_mapping_length.to_string()}${var_mapping.to_string()}"))
		}
		var_map.large_words.array_push(var_group_string.clone())
	}
	return rt.new_object('WP_Token_Map', []string{}, var_map)
}

fn Class_WP_Token_Map.from_precomputed_table(var_state rt.PhpVal) rt.PhpVal {
	mut var_has_necessary_state := rt.new_bool(var_state.array_isset(rt.new_string('storage_version')) && var_state.array_isset(rt.new_string('key_length')) && var_state.array_isset(rt.new_string('groups')) && var_state.array_isset(rt.new_string('large_words')) && var_state.array_isset(rt.new_string('small_words')) && var_state.array_isset(rt.new_string('small_mappings')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_necessary_state)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Missing required inputs to pre-computed WP_Token_Map.')]), rt.new_string('6.6.0')])
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(Class_WP_Token_Map.storage_version(), var_state.array_get(rt.new_string('storage_version')))))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Loaded version \'%1$s\' incompatible with expected version \'%2$s\'.')]), var_state.array_get(rt.new_string('storage_version')), rt.new_string(Class_WP_Token_Map.storage_version())]), rt.new_string('6.6.0')])
		return rt.new_null()
	}
	mut var_map := create_wp_token_map()
	var_map.key_length = var_state.array_get(rt.new_string('key_length'))
	var_map.groups = var_state.array_get(rt.new_string('groups'))
	var_map.large_words = var_state.array_get(rt.new_string('large_words'))
	var_map.small_words = var_state.array_get(rt.new_string('small_words'))
	var_map.small_mappings = var_state.array_get(rt.new_string('small_mappings'))
	return rt.new_object('WP_Token_Map', []string{}, var_map)
}

fn (mut this Class_WP_Token_Map) contains(word string, case_sensitivity string) bool {
	mut var_ignore_case := rt.identical(rt.new_string('ascii-case-insensitive'), rt.new_string(case_sensitivity))
	if rt.is_true(rt.greater_equal(this.key_length, rt.new_int(word.len))) {
		if 0 == this.small_words.to_string().len {
			return false
		}
		mut var_term := rt.call_function('str_pad', [rt.new_string(word), rt.add(this.key_length, rt.new_int(1)), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
		mut var_word_at := if rt.is_true(var_ignore_case) { rt.call_function('stripos', [this.small_words, var_term.clone()]) } else { rt.call_function('strpos', [this.small_words, var_term.clone()]) }
		if rt.is_true(rt.identical(rt.new_bool(false), var_word_at)) {
			return false
		}
		return true
	}
	mut var_group_key := rt.call_function('substr', [rt.new_string(word), rt.new_int(0), this.key_length])
	mut var_group_at := if rt.is_true(var_ignore_case) { rt.call_function('stripos', [this.groups, var_group_key.clone()]) } else { rt.call_function('strpos', [this.groups, var_group_key.clone()]) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_group_at)) {
		return false
	}
	mut var_group := this.large_words.array_get(rt.div(var_group_at, rt.add(this.key_length, rt.new_int(1))))
	mut var_group_length := rt.new_int(var_group.clone().to_string().len)
	mut var_slug := rt.call_function('substr', [rt.new_string(word), this.key_length])
	mut var_length := rt.new_int(var_slug.clone().to_string().len)
	mut var_at := rt.new_int(0)
	for rt.is_true(rt.less(var_at, var_group_length)) {
		mut var_token_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
		mut var_token_at := var_at.clone()
		var_at = rt.add(var_at, var_token_length)
		mut var_mapping_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
		mut var_mapping_at := var_at.clone()
		if rt.is_true(rt.identical(var_token_length, var_length)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_group.clone(), var_slug.clone(), var_token_at.clone(), var_token_length.clone(), var_ignore_case.clone()]))) {
			return true
		}
	var_at = rt.add(var_mapping_at, var_mapping_length)
	}
	return false
}

fn (mut this Class_WP_Token_Map) read_token(text string, offset i64, var_matched_token_byte_length rt.PhpVal, case_sensitivity string) string {
	mut var_matched_token_byte_length_mutated := var_matched_token_byte_length
	mut var_ignore_case := rt.identical(rt.new_string('ascii-case-insensitive'), rt.new_string(case_sensitivity))
	mut var_text_length := rt.new_int(text.len)
	if rt.is_true(rt.greater(var_text_length, this.key_length)) {
		mut var_group_key := rt.call_function('substr', [rt.new_string(text), rt.new_int(offset), this.key_length])
		mut var_group_at := if rt.is_true(var_ignore_case) { rt.call_function('stripos', [this.groups, var_group_key.clone()]) } else { rt.call_function('strpos', [this.groups, var_group_key.clone()]) }
		if rt.is_true(rt.identical(rt.new_bool(false), var_group_at)) {
			return (if this.small_words.to_string().len > 0 { this.read_small_token(text, offset, var_matched_token_byte_length_mutated.clone(), case_sensitivity) } else { rt.new_null() }).str()
		}
		mut var_group := this.large_words.array_get(rt.div(var_group_at, rt.add(this.key_length, rt.new_int(1))))
		mut var_group_length := rt.new_int(var_group.clone().to_string().len)
		mut var_at := rt.new_int(0)
		for rt.is_true(rt.less(var_at, var_group_length)) {
			mut var_token_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
			mut var_token := rt.call_function('substr', [var_group.clone(), var_at.clone(), var_token_length.clone()])
			var_at = rt.add(var_at, var_token_length)
			mut var_mapping_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
			mut var_mapping_at := var_at.clone()
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(text), var_token.clone(), rt.add(rt.new_int(offset), this.key_length), var_token_length.clone(), var_ignore_case.clone()]))) {
				var_matched_token_byte_length_mutated = rt.add(this.key_length, var_token_length)
				return (rt.call_function('substr', [var_group.clone(), var_mapping_at.clone(), var_mapping_length.clone()])).str()
			}
		var_at = rt.add(var_mapping_at, var_mapping_length)
		}
	}
	return (if this.small_words.to_string().len > 0 { this.read_small_token(text, offset, var_matched_token_byte_length_mutated.clone(), case_sensitivity) } else { rt.new_null() }).str()
}

fn (mut this Class_WP_Token_Map) read_small_token(text string, offset i64, var_matched_token_byte_length rt.PhpVal, case_sensitivity string) string {
	mut var_matched_token_byte_length_mutated := var_matched_token_byte_length
	mut var_ignore_case := rt.identical(rt.new_string('ascii-case-insensitive'), rt.new_string(case_sensitivity))
	mut var_small_length := rt.new_int(this.small_words.to_string().len)
	mut var_search_text := rt.call_function('substr', [rt.new_string(text), rt.new_int(offset), this.key_length])
	if rt.is_true(var_ignore_case) {
	var_search_text = rt.new_string(var_search_text.clone().to_string().to_upper())
	}
	mut var_starting_char := var_search_text.array_get(rt.new_int(0))
	mut var_at := rt.new_int(0)
	for rt.is_true(rt.less(var_at, var_small_length)) {
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_starting_char, this.small_words.array_get(var_at))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_ignore_case)))) || rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(this.small_words.array_get(var_at).to_string().to_upper()), var_starting_char)))) {
			var_at = rt.add(var_at, rt.add(this.key_length, rt.new_int(1)))
			continue
		}
		mut var_adjust := rt.new_int(1)
		for {
			if !(rt.is_true(rt.less(var_adjust, this.key_length))) { break }
			if rt.is_true(rt.identical(rt.new_string(''), this.small_words.array_get(rt.add(var_at, var_adjust)))) {
				var_matched_token_byte_length_mutated = var_adjust.clone()
				return (this.small_mappings.array_get(rt.div(var_at, rt.add(this.key_length, rt.new_int(1))))).str()
			}
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_search_text.array_get(var_adjust), this.small_words.array_get(rt.add(var_at, var_adjust)))))) && rt.is_true(rt.new_bool(!(rt.is_true(var_ignore_case)))) || rt.is_true(rt.new_string(rt.new_bool(!rt.is_true(rt.identical(this.small_words.array_get(rt.add(var_at, var_adjust)), var_search_text.array_get(var_adjust)))).to_string().to_upper())) {
				var_at = rt.add(var_at, rt.add(this.key_length, rt.new_int(1)))
				continue
			}
			rt.post_inc(var_adjust)
		}
		mut var_matched_token_byte_length_mutated := var_adjust.clone()
		return (this.small_mappings.array_get(rt.div(var_at, rt.add(this.key_length, rt.new_int(1))))).str()
	}
	return (rt.new_null()).str()
}

fn (mut this Class_WP_Token_Map) to_array() rt.PhpVal {
	mut var_tokens := rt.new_array()
	mut var_at := rt.new_int(0)
	mut var_small_mapping := rt.new_int(0)
	mut var_small_length := rt.new_int(this.small_words.to_string().len)
	for rt.is_true(rt.less(var_at, var_small_length)) {
		mut var_key := rt.new_string(rt.call_function('substr', [this.small_words, var_at.clone(), rt.add(this.key_length, rt.new_int(1))]).to_string().trim_right(' \t\n\r'))
		mut var_value := this.small_mappings.array_get(rt.post_inc(var_small_mapping))
		var_tokens.array_set(var_key, var_value.clone())
		var_at = rt.add(var_at, rt.add(this.key_length, rt.new_int(1)))
	}
	mut iter_5 := this.large_words.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_group := item_5.val
		mut var_index := item_5.key
		mut var_prefix := rt.call_function('substr', [this.groups, rt.mul(var_index, rt.add(this.key_length, rt.new_int(1))), rt.new_int(2)])
		mut var_group_length := rt.new_int(var_group.clone().to_string().len)
		var_at = rt.new_int(0)
		for rt.is_true(rt.less(var_at, var_group_length)) {
			mut var_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
			var_key = rt.new_string((var_prefix).str() + (rt.call_function('substr', [var_group.clone(), var_at.clone(), var_length.clone()])).str())
			var_at = rt.add(var_at, var_length)
			var_length = rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
			var_value = rt.call_function('substr', [var_group.clone(), var_at.clone(), var_length.clone()])
			var_tokens.array_set(var_key, var_value.clone())
			var_at = rt.add(var_at, var_length)
		}
	}
	return var_tokens.clone()
}

fn (mut this Class_WP_Token_Map) precomputed_php_source_table(indent string) string {
	mut var_i1 := rt.new_string(indent)
	mut var_i2 := rt.new_string((var_i1).str() + indent)
	mut var_i3 := rt.new_string((var_i2).str() + indent)
	mut var_class_version := rt.new_string(Class_WP_Token_Map.storage_version())
	mut var_output := rt.new_string((Class_WP_Token_Map.class()).str() + '::from_precomputed_table(\n')
	var_output = rt.concat(var_output, rt.new_string("${var_i1.to_string()}array(\n"))
	var_output = rt.concat(var_output, rt.new_string("${var_i2.to_string()}\"storage_version\" => \"${var_class_version.to_string()}\",\n"))
	var_output = rt.concat(var_output, rt.concat(rt.concat(rt.concat(var_i2, rt.new_string('"key_length" => ')), this.key_length), rt.new_string(',\n')))
	mut var_group_line := rt.call_function('str_replace', [rt.new_string(''), rt.new_string('\\x00'), this.groups])
	var_output = rt.concat(var_output, rt.new_string("${var_i2.to_string()}\"groups\" => \"${var_group_line.to_string()}\",\n"))
	var_output = rt.concat(var_output, rt.new_string("${var_i2.to_string()}\"large_words\" => array(\n"))
	mut var_prefixes := rt.call_function('explode', [rt.new_string(''), this.groups])
	mut iter_6 := var_prefixes.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_prefix := item_6.val
		mut var_index := item_6.key
		if rt.is_true(rt.identical(rt.new_string(''), var_prefix)) {
			break
		}
		mut var_group := this.large_words.array_get(var_index)
		mut var_group_length := rt.new_int(var_group.clone().to_string().len)
		mut var_comment_line := rt.new_string("${var_i3.to_string()}//")
		mut var_data_line := rt.new_string("${var_i3.to_string()}\"")
		mut var_at := rt.new_int(0)
		for rt.is_true(rt.less(var_at, var_group_length)) {
			mut var_token_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
			mut var_token := rt.call_function('substr', [var_group.clone(), var_at.clone(), var_token_length.clone()])
			var_at = rt.add(var_at, var_token_length)
			mut var_mapping_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(rt.new_int(1))
			mut var_mapping := rt.call_function('substr', [var_group.clone(), var_at.clone(), var_mapping_length.clone()])
			var_at = rt.add(var_at, var_mapping_length)
			mut var_token_digits := rt.call_function('str_pad', [rt.call_function('dechex', [var_token_length.clone()]), rt.new_int(2), rt.new_string('0'), rt.get_constant('STR_PAD_LEFT')])
			mut var_mapping_digits := rt.call_function('str_pad', [rt.call_function('dechex', [var_mapping_length.clone()]), rt.new_int(2), rt.new_string('0'), rt.get_constant('STR_PAD_LEFT')])
			closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
				mut var_match_result := if args.len > 0 { args[0].clone() } else { rt.new_null() }
				mut switch_val_1 := var_match_result.array_get(rt.new_int(0))
				if rt.is_true(rt.equal(switch_val_1, rt.new_string('"'))) {
					return '\\"'
				} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('\\'))) {
					return '\\\\'
				} else {
					mut var_hex := rt.call_function('dechex', [rt.call_function('ord', [var_match_result.array_get(rt.new_int(0))])])
					return "\\x${var_hex.to_string()}"
				}
				return rt.new_null()
				}
			var_mapping = rt.call_function('preg_replace_callback', [rt.new_string('~[\\x00-\\x1f\\x22\\x5c]~'), rt.new_closure(closure_2_fn), var_mapping.clone()])
			var_comment_line = rt.concat(var_comment_line, rt.new_string(" ${var_prefix.to_string()}${var_token.to_string()}[${var_mapping.to_string()}]"))
			var_data_line = rt.concat(var_data_line, rt.new_string("\\x${var_token_digits.to_string()}${var_token.to_string()}\\x${var_mapping_digits.to_string()}${var_mapping.to_string()}"))
		}
		var_comment_line = rt.concat(var_comment_line, rt.new_string('.\n'))
		var_data_line = rt.concat(var_data_line, rt.new_string('",\n'))
		var_output = rt.concat(var_output, var_comment_line)
		var_output = rt.concat(var_output, var_data_line)
	}
	var_output = rt.concat(var_output, rt.new_string("${var_i2.to_string()}),\n"))
	mut var_small_words := rt.new_array()
	mut var_small_length := rt.new_int(this.small_words.to_string().len)
	mut var_at := rt.new_int(0)
	for rt.is_true(rt.less(var_at, var_small_length)) {
		var_small_words << rt.call_function('substr', [this.small_words, var_at.clone(), rt.add(this.key_length, rt.new_int(1))])
		var_at = rt.add(var_at, rt.add(this.key_length, rt.new_int(1)))
	}
	mut var_small_text := rt.call_function('str_replace', [rt.new_string(''), rt.new_string('\\x00'), rt.call_function('implode', [rt.new_string(''), rt.create_array_from_list(var_small_words)])])
	var_output = rt.concat(var_output, rt.new_string("${var_i2.to_string()}\"small_words\" => \"${var_small_text.to_string()}\",\n"))
	var_output = rt.concat(var_output, rt.new_string("${var_i2.to_string()}\"small_mappings\" => array(\n"))
	mut iter_7 := this.small_mappings.iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_mapping := item_7.val
		var_output = rt.concat(var_output, rt.new_string("${var_i3.to_string()}\"${var_mapping.to_string()}\",\n"))
	}
	var_output = rt.concat(var_output, rt.new_string("${var_i2.to_string()})\n"))
	var_output = rt.concat(var_output, rt.new_string("${var_i1.to_string()})\n"))
	var_output = rt.concat(var_output, rt.new_string(')'))
	return (var_output).str()
}

fn Class_WP_Token_Map.longest_first_then_alphabetical(a string, b string) i64 {
	if rt.is_true(rt.identical(rt.new_string(a), rt.new_string(b))) {
		return 0
	}
	mut var_length_a := rt.new_int(a.len)
	mut var_length_b := rt.new_int(b.len)
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_length_a, var_length_b)))) {
		return (rt.sub(var_length_b, var_length_a)).to_i64()
	}
	return (rt.call_function('strcmp', [rt.new_string(a), rt.new_string(b)])).to_i64()
}

fn create_wp_token_map(_args ...rt.PhpVal) &Class_WP_Token_Map {
	mut obj := &Class_WP_Token_Map{
		PhpObjectBase: rt.PhpObjectBase{}
		key_length: rt.new_int(2)
		large_words: rt.new_array()
		groups: rt.new_string('')
		small_words: rt.new_string('')
		small_mappings: rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Token_Map) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'from_array' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			return Class_WP_Token_Map.from_array(mut dispatch_arg_0, dispatch_arg_1)
		}
		'from_precomputed_table' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Token_Map.from_precomputed_table(dispatch_arg_0)
		}
		'contains' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.contains(dispatch_arg_0, dispatch_arg_1))
		}
		'read_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.read_token(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'read_small_token' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			return rt.new_string(this.read_small_token(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'to_array' {
			return this.to_array()
		}
		'precomputed_php_source_table' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.precomputed_php_source_table(dispatch_arg_0))
		}
		'longest_first_then_alphabetical' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_int(Class_WP_Token_Map.longest_first_then_alphabetical(dispatch_arg_0, dispatch_arg_1))
		}
		else { return none }
	}
}

fn (this &Class_WP_Token_Map) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'key_length' { return this.key_length }
		'large_words' { return this.large_words }
		'groups' { return this.groups }
		'small_words' { return this.small_words }
		'small_mappings' { return this.small_mappings }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Token_Map) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'key_length' { this.key_length = val; return true }
		'large_words' { this.large_words = val; return true }
		'groups' { this.groups = val; return true }
		'small_words' { this.small_words = val; return true }
		'small_mappings' { this.small_mappings = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

}

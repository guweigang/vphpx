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
	var_map.key_length = rt.new_int(key_length).dup()
	mut var_groups := rt.new_array()
	mut var_shorts := rt.new_array()
	{
		mut iter_1 := var_mappings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_mapping := item_1.val
			mut var_word := item_1.key
			if Class_WP_Token_Map.max_length() <= var_word.dup().to_string().len || Class_WP_Token_Map.max_length() <= var_mapping.dup().to_string().len {
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Token Map tokens and substitutions must all be shorter than %1$d bytes.')]), Class_WP_Token_Map.max_length()]), rt.new_string('6.6.0')])
				return rt.new_null()
			}
			mut var_length := rt.new_int(rt.new_int(var_word.dup().to_string().len))
			if rt.is_true(rt.greater_equal(rt.new_int(key_length), var_length)) {
				var_shorts << var_word.dup()
			} else {
				mut var_group := rt.call_function('substr', [var_word.dup(), rt.new_int(0), rt.new_int(key_length)])
				if !(var_groups.array_isset(var_group)) {
					var_groups.array_set(var_group, rt.new_array())
				}
				var_groups.array_get_mut(var_group).array_push(rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('substr', [var_word.dup(), rt.new_int(key_length)]) }, rt.ArrayItem{ key: none, val: var_mapping }]))
			}
		}
	}
	rt.call_function('usort', [var_shorts.dup(), rt.new_string('WP_Token_Map::longest_first_then_alphabetical')])
	{
		mut iter_1 := var_groups.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			mut var_group_key := item_1.key
			closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_a := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_b := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	return Class_WP_Token_Map.longest_first_then_alphabetical((var_a.array_get(0)).str(), (var_b.array_get(0)).str())
	}
			rt.call_function('usort', [var_groups.array_get(var_group_key), rt.new_closure(closure_1_fn)])
		}
	}
	for var_word in var_shorts {
		// unsupported expression: Expr_AssignOp_Concat
		var_map.small_mappings.array_push(var_mappings.array_get(var_word))
	}
	mut var_group_keys := rt.func_array_keys(var_groups.dup())
	rt.call_function('sort', [var_group_keys.dup()])
	{
		mut iter_1 := var_group_keys.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_group := item_1.val
			// unsupported expression: Expr_AssignOp_Concat
			mut var_group_string := rt.new_string(rt.new_string(''))
			{
				mut iter_2 := var_groups.array_get(var_group).iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_group_word := item_2.val
					// unsupported assign target: Expr_List
					mut var_word_length := rt.call_function('pack', [rt.new_string('C'), rt.new_int(var_word.dup().to_string().len)])
					mut var_mapping_length := rt.call_function('pack', [rt.new_string('C'), rt.new_int(var_mapping.dup().to_string().len)])
					// unsupported expression: Expr_AssignOp_Concat
				}
			}
			var_map.large_words.array_push(var_group_string.dup())
		}
	}
	return rt.new_object('WP_Token_Map', []string{}, var_map)
}

fn Class_WP_Token_Map.from_precomputed_table(var_state rt.PhpVal) rt.PhpVal {
	mut var_has_necessary_state := rt.new_bool(var_state.array_isset(rt.new_string('storage_version')) && var_state.array_isset(rt.new_string('key_length')) && var_state.array_isset(rt.new_string('groups')) && var_state.array_isset(rt.new_string('large_words')) && var_state.array_isset(rt.new_string('small_words')) && var_state.array_isset(rt.new_string('small_mappings')))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_has_necessary_state)))) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('__', [rt.new_string('Missing required inputs to pre-computed WP_Token_Map.')]), rt.new_string('6.6.0')])
		return rt.new_null()
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Loaded version \'%1$s\' incompatible with expected version \'%2$s\'.')]), var_state.array_get('storage_version'), Class_WP_Token_Map.storage_version()]), rt.new_string('6.6.0')])
		return rt.new_null()
	}
	mut var_map := create_wp_token_map()
	var_map.key_length = var_state.array_get('key_length')
	var_map.groups = var_state.array_get('groups')
	var_map.large_words = var_state.array_get('large_words')
	var_map.small_words = var_state.array_get('small_words')
	var_map.small_mappings = var_state.array_get('small_mappings')
	return rt.new_object('WP_Token_Map', []string{}, var_map)
}

fn (mut this Class_WP_Token_Map) contains(word string, case_sensitivity string) bool {
	mut var_ignore_case := rt.identical(rt.new_string('ascii-case-insensitive'), rt.new_string(case_sensitivity))
	if rt.is_true(rt.greater_equal(this.key_length, rt.new_int(word.len))) {
		if 0 == this.small_words.to_string().len {
			return false
		}
		mut var_term := rt.call_function('str_pad', [rt.new_string(word), rt.add(this.key_length, rt.new_int(1)), rt.new_string(''), rt.get_constant('STR_PAD_RIGHT')])
		mut var_word_at := if rt.is_true(var_ignore_case) { rt.call_function('stripos', [this.small_words, var_term.dup()]) } else { rt.call_function('strpos', [this.small_words, var_term.dup()]) }
		if rt.is_true(rt.identical(rt.new_bool(false), var_word_at)) {
			return false
		}
		return true
	}
	mut var_group_key := rt.call_function('substr', [rt.new_string(word), rt.new_int(0), this.key_length])
	mut var_group_at := if rt.is_true(var_ignore_case) { rt.call_function('stripos', [this.groups, var_group_key.dup()]) } else { rt.call_function('strpos', [this.groups, var_group_key.dup()]) }
	if rt.is_true(rt.identical(rt.new_bool(false), var_group_at)) {
		return false
	}
	mut var_group := this.large_words.array_get(rt.div(var_group_at, rt.add(this.key_length, rt.new_int(1))))
	mut var_group_length := rt.new_int(rt.new_int(var_group.dup().to_string().len))
	mut var_slug := rt.call_function('substr', [rt.new_string(word), this.key_length])
	mut var_length := rt.new_int(rt.new_int(var_slug.dup().to_string().len))
	mut var_at := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.less(var_at, var_group_length)) {
		mut var_token_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(1)
		mut var_token_at := var_at.dup()
		// unsupported expression: Expr_AssignOp_Plus
		mut var_mapping_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(1)
		mut var_mapping_at := var_at.dup()
		if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_token_length, var_length)) && rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [var_group.dup(), var_slug.dup(), var_token_at.dup(), var_token_length.dup(), var_ignore_case.dup()]))))) {
			return true
		}
		var_at = rt.add(var_mapping_at, var_mapping_length)
	}
	return false
}

fn (mut this Class_WP_Token_Map) read_token(text string, offset i64, var_matched_token_byte_length rt.PhpVal, case_sensitivity string) string {
	mut var_matched_token_byte_length_mutated := var_matched_token_byte_length
	mut var_ignore_case := rt.identical(rt.new_string('ascii-case-insensitive'), rt.new_string(case_sensitivity))
	mut var_text_length := rt.new_int(rt.new_int(text.len))
	if rt.is_true(rt.greater(var_text_length, this.key_length)) {
		mut var_group_key := rt.call_function('substr', [rt.new_string(text), rt.new_int(offset), this.key_length])
		mut var_group_at := if rt.is_true(var_ignore_case) { rt.call_function('stripos', [this.groups, var_group_key.dup()]) } else { rt.call_function('strpos', [this.groups, var_group_key.dup()]) }
		if rt.is_true(rt.identical(rt.new_bool(false), var_group_at)) {
			return (if this.small_words.to_string().len > 0 { this.read_small_token(text, offset, var_matched_token_byte_length_mutated.dup(), case_sensitivity) } else { rt.new_null() }).str()
		}
		mut var_group := this.large_words.array_get(rt.div(var_group_at, rt.add(this.key_length, rt.new_int(1))))
		mut var_group_length := rt.new_int(rt.new_int(var_group.dup().to_string().len))
		mut var_at := rt.new_int(rt.new_int(0))
		for rt.is_true(rt.less(var_at, var_group_length)) {
			mut var_token_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(1)
			mut var_token := rt.call_function('substr', [var_group.dup(), var_at.dup(), var_token_length.dup()])
			// unsupported expression: Expr_AssignOp_Plus
			mut var_mapping_length := rt.call_function('unpack', [rt.new_string('C'), var_group.array_get(rt.post_inc(var_at))]).array_get(1)
			mut var_mapping_at := var_at.dup()
			if rt.is_true(rt.identical(rt.new_int(0), rt.call_function('substr_compare', [rt.new_string(text), var_token.dup(), rt.add(rt.new_int(offset), this.key_length), var_token_length.dup(), var_ignore_case.dup()]))) {
				var_matched_token_byte_length_mutated = rt.add(this.key_length, var_token_length)
				return (rt.call_function('substr', [var_group.dup(), var_mapping_at.dup(), var_mapping_length.dup()])).str()
			}
			var_at = rt.add(var_mapping_at, var_mapping_length)
		}
	}
	return (if this.small_words.to_string().len > 0 { this.read_small_token(text, offset, var_matched_token_byte_length_mutated.dup(), case_sensitivity) } else { rt.new_null() }).str()
}

fn (mut this Class_WP_Token_Map) read_small_token(text string, offset i64, var_matched_token_byte_length rt.PhpVal, case_sensitivity string) string {
	mut var_matched_token_byte_length_mutated := var_matched_token_byte_length
	mut var_ignore_case := rt.identical(rt.new_string('ascii-case-insensitive'), rt.new_string(case_sensitivity))
	mut var_small_length := rt.new_int(rt.new_int(this.small_words.to_string().len))
	mut var_search_text := rt.call_function('substr', [rt.new_string(text), rt.new_int(offset), this.key_length])
	if rt.is_true(var_ignore_case) {
		var_search_text = rt.new_string(rt.new_string(var_search_text.dup().to_string().to_upper()))
	}
	mut var_starting_char := var_search_text.array_get(0)
	mut var_at := rt.new_int(rt.new_int(0))
	for rt.is_true(rt.less(var_at, var_small_length)) {
		if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_ignore_case)))) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))))) {
			// unsupported expression: Expr_AssignOp_Plus
			continue
		}
		{
			mut var_adjust := rt.new_int(rt.new_int(1))
			for {
				if !(rt.is_true(rt.less(var_adjust, this.key_length))) { break }
				if rt.is_true(rt.identical(rt.new_string(''), this.small_words.array_get(rt.add(var_at, var_adjust)))) {
					var_matched_token_byte_length_mutated = var_adjust.dup()
					return (this.small_mappings.array_get(rt.div(, ))).str()
				}
				if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.new_bool(rt.is_true() || rt.is_true())))) {
					// unsupported expression: Expr_AssignOp_Plus
					continue
				}
				rt.post_inc()
			}
		}
		
	}
}

fn (mut this Class_WP_Token_Map) to_array() rt.PhpVal {
}

fn (mut this Class_WP_Token_Map) precomputed_php_source_table(indent string) string {
}

fn Class_WP_Token_Map.longest_first_then_alphabetical(a string, b string) i64 {
}

fn create_wp_token_map() &Class_WP_Token_Map {
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




pub fn init_wp_includes_class_wp_token_map_php() {
}

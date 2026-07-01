import rt

fn _(var_message rt.PhpVal) rt.PhpVal {
	return var_message.dup()
}

fn _wp_can_use_pcre_u(var_set rt.PhpVal) bool {
	// unsupported statement: Stmt_Static
	if !(var_set).is_null() {
		rt.call_function('_deprecated_argument', [rt.new_string(@FN), rt.new_string('6.9.0')])
	}
	if !(rt.new_bool(var_utf8_pcre)).is_null() {
		return var_utf8_pcre
	}
	mut var_utf8_pcre := true
	closure_2_fn := fn [mut var_utf8_pcre] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn [mut var_utf8_pcre] (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_errno := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_errstr := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(str_starts_with(var_errstr.dup(), rt.new_string('preg_match():')))) {
		var_utf8_pcre = false
		return true
	}
	return false
	}
	mut var_errno := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	mut var_errstr := if args.len > 1 { args[1].dup() } else { rt.new_null() }
	if rt.is_true(rt.new_bool(str_starts_with(var_errstr.dup(), rt.new_string('preg_match():')))) {
		var_utf8_pcre = false
		return true
	}
	return false
	}
	rt.call_function('set_error_handler', [rt.new_closure(closure_1_fn), rt.get_constant('E_WARNING')])
	rt.call_function('preg_match', [rt.new_string('//u'), rt.new_string('')])
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	return var_utf8_pcre
}

fn _is_utf8_charset(var_charset_slug rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_charset_slug.dup().is_string()))))) {
		return false
	}
	return rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.new_string('UTF-8'), var_charset_slug.dup()]))) || rt.is_true(rt.identical(rt.new_int(0), rt.call_function('strcasecmp', [rt.new_string('UTF8'), var_charset_slug.dup()])))
}

fn mb_substr(var_string rt.PhpVal, var_start rt.PhpVal, var_length rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	return rt.new_string(_mb_substr(var_string.dup(), var_start.dup(), var_length.dup(), var_encoding.dup()))
}

fn _mb_substr(var_str rt.PhpVal, var_start rt.PhpVal, var_length rt.PhpVal, var_encoding rt.PhpVal) string {
	if rt.is_true(rt.identical(rt.new_null(), var_str)) {
		return ''
	}
	if !(_is_utf8_charset(if !(var_encoding).is_null() { var_encoding } else { rt.call_function('get_option', [rt.new_string('blog_charset')]) })) {
		return (if rt.is_true(rt.new_bool(var_length.dup().is_null())) { rt.call_function('substr', [var_str.dup(), var_start.dup()]) } else { rt.call_function('substr', [var_str.dup(), var_start.dup(), var_length.dup()]) }).str()
	}
	mut var_total_length := if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_start, rt.new_int(0))) || rt.is_true(rt.less(var_length, rt.new_int(0))))) { rt.call_function('_wp_utf8_codepoint_count', [var_str.dup()]) } else { rt.new_int(0) }
	mut var_normalized_start := if rt.is_true(rt.less(var_start, rt.new_int(0))) { rt.call_function('max', [rt.new_int(0), rt.add(var_total_length, var_start)]) } else { var_start }
	mut var_starting_byte_offset := rt.call_function('_wp_utf8_codepoint_span', [var_str.dup(), rt.new_int(0), var_normalized_start.dup()])
	mut var_normalized_length := if rt.is_true(rt.less(var_length, rt.new_int(0))) { rt.call_function('max', [rt.new_int(0), rt.add(rt.sub(var_total_length, var_normalized_start), var_length)]) } else { var_length }
	mut var_byte_length := if !(var_normalized_length).is_null() { rt.call_function('_wp_utf8_codepoint_span', [var_str.dup(), var_starting_byte_offset.dup(), var_normalized_length.dup()]) } else { rt.sub(rt.new_int(var_str.dup().to_string().len), var_starting_byte_offset) }
	return (rt.call_function('substr', [var_str.dup(), var_starting_byte_offset.dup(), var_byte_length.dup()])).str()
}

fn mb_strlen(var_string rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	return _mb_strlen(var_string.dup(), var_encoding.dup())
}

fn _mb_strlen(var_str rt.PhpVal, var_encoding rt.PhpVal) rt.PhpVal {
	return if _is_utf8_charset(if !(var_encoding).is_null() { var_encoding } else { rt.call_function('get_option', [rt.new_string('blog_charset')]) }) { rt.call_function('_wp_utf8_codepoint_count', [var_str.dup()]) } else { rt.new_int(var_str.dup().to_string().len) }
}

fn utf8_encode(var_iso_8859_1_text rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.9.0'), rt.new_string('mb_convert_encoding')])
	return (rt.call_function('mb_convert_encoding', [var_iso_8859_1_text.dup(), rt.new_string('UTF-8'), rt.new_string('ISO-8859-1')])).str()
}

fn utf8_encode(var_iso_8859_1_text rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.9.0'), rt.new_string('mb_convert_encoding')])
	return (rt.call_function('_wp_utf8_encode_fallback', [var_iso_8859_1_text.dup()])).str()
}

fn utf8_decode(var_utf8_text rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.9.0'), rt.new_string('mb_convert_encoding')])
	return (rt.call_function('mb_convert_encoding', [var_utf8_text.dup(), rt.new_string('ISO-8859-1'), rt.new_string('UTF-8')])).str()
}

fn utf8_decode(var_utf8_text rt.PhpVal) string {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('6.9.0'), rt.new_string('mb_convert_encoding')])
	return (rt.call_function('_wp_utf8_decode_fallback', [var_utf8_text.dup()])).str()
}

fn array_is_list(var_arr rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_array(), var_arr)) || rt.is_true(rt.identical(rt.call_function('array_values', [var_arr.dup()]), var_arr)))) {
		return true
	}
	mut var_next_key := // unsupported expression: Expr_UnaryMinus
	{
		mut iter_1 := var_arr.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_v := item_1.val
			mut var_k := item_1.key
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return false
			}
		}
	}
	return true
}

fn str_contains(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string(''), var_needle)) {
		return true
	}
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn str_starts_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) bool {
	if rt.is_true(rt.identical(rt.new_string(''), var_needle)) {
		return true
	}
	return (rt.identical(rt.new_int(0), rt.call_function('strpos', [var_haystack.dup(), var_needle.dup()]))).to_bool()
}

fn str_ends_with(var_haystack rt.PhpVal, var_needle rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_string(''), var_haystack)) {
		return rt.identical(rt.new_string(''), var_needle)
	}
	mut var_len := var_needle.dup().to_string().len
	return rt.identical(rt.call_function('substr', [var_haystack.dup(), // unsupported expression: Expr_UnaryMinus, rt.new_int(var_len).dup()]), var_needle)
}

fn array_find(var_array rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := var_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_callable(var_callback, [var_value.dup(), var_key.dup()])) {
				return var_value.dup()
			}
		}
	}
	return rt.new_null()
}

fn array_find_key(var_array rt.PhpVal, var_callback rt.PhpVal) rt.PhpVal {
	{
		mut iter_1 := var_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_callable(var_callback, [var_value.dup(), var_key.dup()])) {
				return var_key.dup()
			}
		}
	}
	return rt.new_null()
}

fn array_any(var_array rt.PhpVal, var_callback rt.PhpVal) bool {
	{
		mut iter_1 := var_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.call_callable(var_callback, [var_value.dup(), var_key.dup()])) {
				return true
			}
		}
	}
	return false
}

fn array_all(var_array rt.PhpVal, var_callback rt.PhpVal) bool {
	{
		mut iter_1 := var_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_callable(var_callback, [var_value.dup(), var_key.dup()]))))) {
				return false
			}
		}
	}
	return true
}

fn array_first(var_array rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_array) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_array.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			return var_value.dup()
		}
	}
	return rt.new_null()
}

fn array_last(var_array rt.PhpVal) rt.PhpVal {
	if !rt.is_true(var_array) {
		return rt.new_null()
	}
	return var_array.array_get(rt.call_function('array_key_last', [var_array.dup()]))
}

fn init_registry() {
	rt.register_func('_', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return _(arg_0)
	})
	rt.register_func('_wp_can_use_pcre_u', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(_wp_can_use_pcre_u(arg_0))
	})
	rt.register_func('_is_utf8_charset', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(_is_utf8_charset(arg_0))
	})
	rt.register_func('mb_substr', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return mb_substr(arg_0, arg_1, arg_2, arg_3)
	})
	rt.register_func('_mb_substr', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
		arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
		return rt.new_string(_mb_substr(arg_0, arg_1, arg_2, arg_3))
	})
	rt.register_func('mb_strlen', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return mb_strlen(arg_0, arg_1)
	})
	rt.register_func('_mb_strlen', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return _mb_strlen(arg_0, arg_1)
	})
	rt.register_func('utf8_encode', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(utf8_encode(arg_0))
	})
	rt.register_func('utf8_decode', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_string(utf8_decode(arg_0))
	})
	rt.register_func('array_is_list', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return rt.new_bool(array_is_list(arg_0))
	})
	rt.register_func('str_contains', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(str_contains(arg_0, arg_1))
	})
	rt.register_func('str_starts_with', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(str_starts_with(arg_0, arg_1))
	})
	rt.register_func('str_ends_with', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return str_ends_with(arg_0, arg_1)
	})
	rt.register_func('array_find', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return array_find(arg_0, arg_1)
	})
	rt.register_func('array_find_key', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return array_find_key(arg_0, arg_1)
	})
	rt.register_func('array_any', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(array_any(arg_0, arg_1))
	})
	rt.register_func('array_all', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
		return rt.new_bool(array_all(arg_0, arg_1))
	})
	rt.register_func('array_first', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return array_first(arg_0)
	})
	rt.register_func('array_last', fn(args []rt.PhpVal) rt.PhpVal {
		arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		return array_last(arg_0)
	})
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_compat_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('_')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_substr')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('mb_strlen')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('utf8_encode')]))))) {
		if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mbstring')])) {
		} else {
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('utf8_decode')]))))) {
		if rt.is_true(rt.call_function('extension_loaded', [rt.new_string('mbstring')])) {
		} else {
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('sodium_crypto_box')]))))) {
		rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/sodium_compat/autoload.php', '3')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('array_is_list')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('str_contains')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('str_starts_with')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('str_ends_with')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('array_find')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('array_find_key')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('array_any')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('array_all')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('array_first')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('array_last')]))))) {
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IMAGETYPE_AVIF')]))))) {
		rt.call_function('define', [rt.new_string('IMAGETYPE_AVIF'), rt.new_int(19)])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IMG_AVIF')]))))) {
		rt.call_function('define', [rt.new_string('IMG_AVIF'), rt.get_constant('IMAGETYPE_AVIF')])
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('IMAGETYPE_HEIF')]))))) {
		rt.call_function('define', [rt.new_string('IMAGETYPE_HEIF'), rt.new_int(20)])
	}
}

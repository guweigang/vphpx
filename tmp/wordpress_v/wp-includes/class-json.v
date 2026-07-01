import rt

struct Class_Services_JSON {
	rt.PhpObjectBase
pub mut:
			use rt.PhpVal = rt.new_null()
			_mb_strlen rt.PhpVal = rt.new_bool(false)
			_mb_substr rt.PhpVal = rt.new_bool(false)
			_mb_convert_encoding rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Services_JSON) construct(use i64)  {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	this.use = rt.new_int(use).dup()
	this._mb_strlen = rt.call_function('function_exists', [rt.new_string('mb_strlen')])
	this._mb_convert_encoding = rt.call_function('function_exists', [rt.new_string('mb_convert_encoding')])
	this._mb_substr = rt.call_function('function_exists', [rt.new_string('mb_substr')])
}

fn (mut this Class_Services_JSON) services_json(use i64)  {
	rt.call_function('_deprecated_constructor', [rt.new_string('Services_JSON'), rt.new_string('5.3.0'), rt.call_function('get_class', [rt.new_object('Services_JSON', []string{}, &this)])])
	fn (arg_0 i64) rt.PhpVal { mut temp := Class_Services_JSON{}; temp.construct(arg_0); return rt.new_null() }(use)
}

fn (mut this Class_Services_JSON) utf162utf8(var_utf16 rt.PhpVal) string {
	mut var_utf16_mutated := var_utf16
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	if rt.is_true(this._mb_convert_encoding) {
		return (rt.call_function('mb_convert_encoding', [var_utf16_mutated.dup(), rt.new_string('UTF-8'), rt.new_string('UTF-16')])).str()
	}
	mut var_bytes := rt.new_int(rt.bitwise_or(rt.shift_left(rt.call_function('ord', [var_utf16_mutated.array_get(0)]), rt.new_int(8)), rt.call_function('ord', [var_utf16_mutated.array_get(1)])))
	mut switch_val_1 := rt.new_bool(true)
	if rt.is_true(rt.equal(switch_val_1, rt.equal(rt.bitwise_and(rt.new_int(127), var_bytes), var_bytes))) {
		return (rt.call_function('chr', [rt.bitwise_and(rt.new_int(127), var_bytes)])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.equal(rt.bitwise_and(rt.new_int(2047), var_bytes), var_bytes))) {
		return (rt.call_function('chr', [192 | rt.shift_right(var_bytes, rt.new_int(6)) & 31])).str() + (rt.call_function('chr', [128 | rt.bitwise_and(var_bytes, rt.new_int(63))])).str()
	} else if rt.is_true(rt.equal(switch_val_1, rt.equal(rt.bitwise_and(rt.new_int(65535), var_bytes), var_bytes))) {
		return (rt.call_function('chr', [224 | rt.shift_right(var_bytes, rt.new_int(12)) & 15])).str() + (rt.call_function('chr', [128 | rt.shift_right(var_bytes, rt.new_int(6)) & 63])).str() + (rt.call_function('chr', [128 | rt.bitwise_and(var_bytes, rt.new_int(63))])).str()
	}
	return ''
}

fn (mut this Class_Services_JSON) utf82utf16(var_utf8 rt.PhpVal) string {
	mut var_utf8_mutated := var_utf8
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	if rt.is_true(this._mb_convert_encoding) {
		return (rt.call_function('mb_convert_encoding', [var_utf8_mutated.dup(), rt.new_string('UTF-16'), rt.new_string('UTF-8')])).str()
	}
	match this.strlen8(var_utf8_mutated.dup()) {
		1 {
			return (var_utf8_mutated).str()
		}
		2 {
			return (rt.call_function('chr', [7 & rt.shift_right(rt.call_function('ord', [var_utf8_mutated.array_get(0)]), rt.new_int(2))])).str() + (rt.call_function('chr', [192 & rt.shift_left(rt.call_function('ord', [var_utf8_mutated.array_get(0)]), rt.new_int(6)) | rt.bitwise_and(rt.new_int(63), rt.call_function('ord', [var_utf8_mutated.array_get(1)]))])).str()
		}
		3 {
			return (rt.call_function('chr', [240 & rt.shift_left(rt.call_function('ord', [var_utf8_mutated.array_get(0)]), rt.new_int(4)) | 15 & rt.shift_right(rt.call_function('ord', [var_utf8_mutated.array_get(1)]), rt.new_int(2))])).str() + (rt.call_function('chr', [192 & rt.shift_left(rt.call_function('ord', [var_utf8_mutated.array_get(1)]), rt.new_int(6)) | rt.bitwise_and(rt.new_int(127), rt.call_function('ord', [var_utf8_mutated.array_get(2)]))])).str()
		}
	}
	return ''
}

fn (mut this Class_Services_JSON) encode(var_var rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	rt.call_function('header', [rt.new_string('Content-Type: application/json')])
	return this.encodeunsafe(var_var.dup())
}

fn (mut this Class_Services_JSON) encodeunsafe(var_var rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	mut var_lc := rt.call_function('setlocale', [rt.get_constant('LC_NUMERIC'), rt.new_int(0)])
	rt.call_function('setlocale', [rt.get_constant('LC_NUMERIC'), rt.new_string('C')])
	mut var_ret := this._encode(var_var.dup())
	rt.call_function('setlocale', [rt.get_constant('LC_NUMERIC'), var_lc.dup()])
	return var_ret.dup()
}

fn (mut this Class_Services_JSON) _encode(var_var rt.PhpVal)  {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('5.3.0'), rt.new_string('The PHP native JSON extension')])
	mut switch_val_3 := rt.call_function('gettype', [var_var.dup()])
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('boolean'))) {
		return rt.new_string(if rt.is_true(var_var) { 'true' } else { 'false' })
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('NULL'))) {
		return rt.new_string('null')
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('integer'))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('double'))) || rt.is_true(rt.equal(switch_val_3, rt.new_string('float'))) {
		return // unsupported expression: Expr_Cast_Double
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('string'))) {
		mut var_ascii := rt.new_string(rt.new_string(''))
		mut var_strlen_var := rt.new_int(this.strlen8(var_var.dup()))
		{
			mut var_c := rt.new_int(rt.new_int(0))
			for {
				if !(rt.is_true(rt.less(var_c, var_strlen_var))) { break }
				mut var_ord_var_c := rt.call_function('ord', [var_var.array_get(var_c)])
				mut switch_val_4 := rt.new_bool(true)
				if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(8)))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(9)))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(10)))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(12)))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(13)))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(34)))) || rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(47)))) || rt.is_true(rt.equal(switch_val_4, rt.equal(var_ord_var_c, rt.new_int(92)))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.is_true(rt.greater_equal(var_ord_var_c, rt.new_int(32))) && rt.is_true(rt.less_equal(var_ord_var_c, rt.new_int(127)))))) {
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(224)) == 192))) {
					if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(1)), var_strlen_var)) {
						// unsupported expression: Expr_AssignOp_Plus
						// unsupported expression: Expr_AssignOp_Concat
						break
					}
					mut var_char := rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.dup(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))])])
					// unsupported expression: Expr_AssignOp_Plus
					mut var_utf16 := this.utf82utf16(var_char.dup())
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(240)) == 224))) {
					if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(2)), var_strlen_var)) {
						// unsupported expression: Expr_AssignOp_Plus
						// unsupported expression: Expr_AssignOp_Concat
						break
					}
					var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.dup(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))])])
					// unsupported expression: Expr_AssignOp_Plus
					var_utf16 = this.utf82utf16(var_char.dup())
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(248)) == 240))) {
					if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(3)), var_strlen_var)) {
						// unsupported expression: Expr_AssignOp_Plus
						// unsupported expression: Expr_AssignOp_Concat
						break
					}
					var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.dup(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(3)))])])
					// unsupported expression: Expr_AssignOp_Plus
					var_utf16 = this.utf82utf16(var_char.dup())
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(252)) == 248))) {
					if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(4)), var_strlen_var)) {
						// unsupported expression: Expr_AssignOp_Plus
						// unsupported expression: Expr_AssignOp_Concat
						break
					}
					var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.dup(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(3)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(4)))])])
					// unsupported expression: Expr_AssignOp_Plus
					var_utf16 = this.utf82utf16(var_char.dup())
					// unsupported expression: Expr_AssignOp_Concat
				} else if rt.is_true(rt.equal(switch_val_4, rt.new_bool(rt.bitwise_and(var_ord_var_c, rt.new_int(254)) == 252))) {
					if rt.is_true(rt.greater_equal(rt.add(var_c, rt.new_int(5)), var_strlen_var)) {
						// unsupported expression: Expr_AssignOp_Plus
						// unsupported expression: Expr_AssignOp_Concat
						break
					}
					var_char = rt.call_function('pack', [rt.new_string('C*'), var_ord_var_c.dup(), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(1)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(2)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(3)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(4)))]), rt.call_function('ord', [var_var.array_get(rt.add(var_c, rt.new_int(5)))])])
					// unsupported expression: Expr_AssignOp_Plus
					var_utf16 = this.utf82utf16(var_char.dup())
					// unsupported expression: Expr_AssignOp_Concat
				}
				rt.pre_inc(var_c)
			}
		}
		return rt.new_string('"' + (var_ascii).str() + '"')
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('array'))) {
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(.dup().is_array())) && rt.is_true(rt.new_int(.dup().array_count())))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			mut var_properties := rt.call_function('array_map', [, , ])
			{
				mut iter_1 := var_properties.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_property := item_1.val
					if rt.is_true() {
					}
				}
			}
			return rt.new_string()
		}
		
	} else if rt.is_true(rt.equal(switch_val_3, )) {
	} else {
	}
}

fn (mut this Class_Services_JSON) name_value(var_name rt.PhpVal, var_value rt.PhpVal) string {
}

fn (mut this Class_Services_JSON) reduce_string(var_str rt.PhpVal) string {
	mut var_str_mutated := var_str
}

fn (mut this Class_Services_JSON) decode(var_str rt.PhpVal)  {
	mut var_str_mutated := var_str
}

fn (mut this Class_Services_JSON) iserror(var_data rt.PhpVal, var_code rt.PhpVal) bool {
}

fn (mut this Class_Services_JSON) strlen8(var_str rt.PhpVal) i64 {
	mut var_str_mutated := var_str
}

fn (mut this Class_Services_JSON) substr8(var_string rt.PhpVal, var_start rt.PhpVal, length bool) rt.PhpVal {
	mut length_mutated := length
}

fn create_services_json(use i64) &Class_Services_JSON {
	mut obj := &Class_Services_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
		use: rt.new_null()
		_mb_strlen: rt.new_bool(false)
		_mb_substr: rt.new_bool(false)
		_mb_convert_encoding: rt.new_bool(false)
	}
	obj.construct(use)
	return obj
}

fn (mut this Class_Services_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'Services_JSON' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.services_json(dispatch_arg_0)
			return rt.new_null()
		}
		'utf162utf8' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.utf162utf8(dispatch_arg_0))
		}
		'utf82utf16' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.utf82utf16(dispatch_arg_0))
		}
		'encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.encode(dispatch_arg_0)
		}
		'encodeUnsafe' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.encodeunsafe(dispatch_arg_0)
		}
		'_encode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._encode(dispatch_arg_0)
			return rt.new_null()
		}
		'name_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.name_value(dispatch_arg_0, dispatch_arg_1))
		}
		'reduce_string' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.reduce_string(dispatch_arg_0))
		}
		'decode' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.decode(dispatch_arg_0)
			return rt.new_null()
		}
		'isError' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.iserror(dispatch_arg_0, dispatch_arg_1))
		}
		'strlen8' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(this.strlen8(dispatch_arg_0))
		}
		'substr8' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.substr8(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_Services_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'use' { return this.use }
		'_mb_strlen' { return this._mb_strlen }
		'_mb_substr' { return this._mb_substr }
		'_mb_convert_encoding' { return this._mb_convert_encoding }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Services_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'use' { this.use = val; return true }
		'_mb_strlen' { this._mb_strlen = val; return true }
		'_mb_substr' { this._mb_substr = val; return true }
		'_mb_convert_encoding' { this._mb_convert_encoding = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}




pub fn init_wp_includes_class_json_php() {
	rt.call_function('_deprecated_file', [rt.call_function('basename', [rt.new_string(@FILE)]), rt.new_string('5.3.0'), rt.new_string(''), rt.new_string('The PHP native JSON extension is now a requirement.')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('class_exists', [rt.new_string('Services_JSON')]))))) {
		rt.call_function('define', [rt.new_string('SERVICES_JSON_SLICE'), rt.new_int(1)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_STR'), rt.new_int(2)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_ARR'), rt.new_int(3)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_OBJ'), rt.new_int(4)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_IN_CMT'), rt.new_int(5)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_LOOSE_TYPE'), rt.new_int(16)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_SUPPRESS_ERRORS'), rt.new_int(32)])
		rt.call_function('define', [rt.new_string('SERVICES_JSON_USE_TO_JSON'), rt.new_int(64)])
	}
}

import rt

struct Class_SimplePie_Decode_HTML_Entities {
	rt.PhpObjectBase
pub mut:
	data     string
	consumed rt.PhpVal = rt.new_string('')
	position rt.PhpVal = rt.new_int(0)
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) construct(data string) {
	mut data_mutated := data
	this.data = (rt.new_string(data_mutated)).str()
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) parse() string {
	mut var_position := rt.call_function('strpos', [rt.new_string(this.data),
		rt.new_string('&'), this.position])
	for rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_position, rt.new_bool(false))))) {
		this.position = var_position.clone()
		this.consume()
		this.entity()
		this.consumed = rt.new_string('')
	}
	return this.data
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) consume() bool {
	if this.data.array_isset(this.position) {
		this.consumed = rt.concat(this.consumed, this.data.array_get(this.position))
		return (this.data.array_get(rt.post_inc(this.position))).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) consume_range(chars string) bool {
	mut var_len := rt.call_function('strspn', [rt.new_string(this.data),
		rt.new_string(chars), this.position])
	if rt.is_true(var_len) {
		mut var_data := rt.call_function('substr', [rt.new_string(this.data), this.position,
			var_len.clone()])
		this.consumed = rt.concat(this.consumed, var_data)
		this.position = rt.add(this.position, var_len)
		return var_data.to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) unconsume() {
	this.consumed = rt.call_function('substr', [this.consumed, rt.new_int(0),
		rt.new_int(-1)])
	rt.post_dec(this.position)
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) entity() {
	mut var_windows_1252_specials := rt.new_null()
	mut var_entities := rt.new_null()
	mut switch_val_1 := this.consume()
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('\t')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('\n')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string(' ')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('<')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_string('&')))
		|| rt.is_true(rt.equal(switch_val_1, rt.new_bool(false))) {
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('#'))) {
		mut switch_val_2 := this.consume()
		if rt.is_true(rt.equal(switch_val_2, rt.new_string('x')))
			|| rt.is_true(rt.equal(switch_val_2, rt.new_string('X'))) {
			mut var_range := rt.new_string('0123456789ABCDEFabcdef')
			mut var_hex := rt.new_bool(true)
		} else {
			var_range = rt.new_string('0123456789')
			var_hex = rt.new_bool(false)
			this.unconsume()
		}
		mut var_codepoint := rt.new_bool(this.consume_range(var_range.str()))
		if rt.is_true(var_codepoint) {
			if rt.is_true(var_hex) {
				var_codepoint = rt.new_int((rt.call_function('min', [
					rt.call_function('hexdec', [var_codepoint.clone()]),
					rt.get_constant('PHP_INT_MAX'),
				])).to_i64())
			} else {
				var_codepoint = rt.new_int(var_codepoint.to_i64())
			}
			if var_windows_1252_specials.array_isset(var_codepoint) {
				mut var_replacement := var_windows_1252_specials.array_get(var_codepoint)
			} else {
				mut iife_temp_0 := Class_SimplePie_Misc{}
				mut iife_result_0 := iife_temp_0.codepoint_to_utf8(var_codepoint.clone())
				var_replacement = iife_result_0
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
				rt.new_bool(this.consume()),
				rt.create_array([rt.ArrayItem{ key: none, val: ';' },
					rt.ArrayItem{ key: none, val: false }]),
				rt.new_bool(true),
			])))))
			{
				this.unconsume()
			}
			mut var_consumed_length := rt.new_int(this.consumed.to_string().len)
			this.data = rt.call_function('substr_replace', [rt.new_string(this.data),
				var_replacement.clone(), rt.sub(this.position, var_consumed_length),
				var_consumed_length.clone()])
			this.position = rt.add(this.position, rt.sub(rt.new_int(var_replacement.clone().to_string().len),
				var_consumed_length))
		}
	} else {
		mut var_i := rt.new_int(0)
		mut var_match := rt.new_null()
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(9))) && rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.consume(), rt.new_bool(false)))))) { break
			 }
			mut var_consumed := rt.new_string((rt.call_function('substr', [this.consumed,
				rt.new_int(1)])).str())
			if var_entities.array_isset(var_consumed) {
				var_match = var_consumed.clone()
			}
			rt.post_inc(var_i)
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_match, rt.new_null())))) {
			this.data = rt.call_function('substr_replace', [rt.new_string(this.data),
				var_entities.array_get(var_match),
				rt.sub(rt.sub(this.position,
					rt.new_int(var_consumed.clone().to_string().len)), rt.new_int(1)),
				rt.new_int(var_match.clone().to_string().len + 1)])
			this.position = rt.add(this.position,
				var_entities.array_get(var_match).to_string().len -
				var_consumed.clone().to_string().len - 1)
		}
	}
}

struct Class_SimplePie_Misc {
	rt.PhpObjectBase
}

fn create_simplepie_decode_html_entities(data string) &Class_SimplePie_Decode_HTML_Entities {
	mut obj := &Class_SimplePie_Decode_HTML_Entities{
		PhpObjectBase: rt.PhpObjectBase{}
		data:          ''
		consumed:      rt.new_string('')
		position:      rt.new_int(0)
	}
	obj.construct(data)
	return obj
}

fn create_simplepie_misc(_args ...rt.PhpVal) &Class_SimplePie_Misc {
	mut obj := &Class_SimplePie_Misc{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'parse' {
			return rt.new_string(this.parse())
		}
		'consume' {
			return rt.new_bool(this.consume())
		}
		'consume_range' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.consume_range(dispatch_arg_0))
		}
		'unconsume' {
			this.unconsume()
			return rt.new_null()
		}
		'entity' {
			this.entity()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Decode_HTML_Entities) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'data' { return rt.new_string(this.data) }
		'consumed' { return this.consumed }
		'position' { return this.position }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Decode_HTML_Entities) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'data' {
			this.data = val.str()
			return true
		}
		'consumed' {
			this.consumed = val
			return true
		}
		'position' {
			this.position = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_SimplePie_Misc) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Misc) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Misc) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

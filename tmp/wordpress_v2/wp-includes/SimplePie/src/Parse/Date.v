import rt

struct Class_SimplePie_Parse_Date {
	rt.PhpObjectBase
pub mut:
	date       rt.PhpVal = rt.new_null()
	day        rt.PhpVal = rt.new_array()
	month      rt.PhpVal = rt.new_array()
	timezone   rt.PhpVal = rt.new_array()
	day_pcre   rt.PhpVal = rt.new_null()
	month_pcre rt.PhpVal = rt.new_null()
	built_in   rt.PhpVal = rt.new_array()
	user       rt.PhpVal = rt.new_array()
}

fn (mut this Class_SimplePie_Parse_Date) construct() {
	mut var_cache := rt.new_null()
	this.day_pcre = '(' +
		(rt.call_function('implode', [rt.new_string('|'), rt.func_array_keys(this.day)])).str() +
		')'
	this.month_pcre = '(' +
		(rt.call_function('implode', [rt.new_string('|'), rt.func_array_keys(this.month)])).str() +
		')'
	if !(var_cache.array_isset(rt.call_function('get_class', [
		rt.new_object('SimplePie_Parse_Date', []string{}, &this),
	]))) {
		mut var_all_methods := rt.call_function('get_class_methods', [
			rt.new_object('SimplePie_Parse_Date', []string{}, &this),
		])
		mut iter_1 := var_all_methods.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_method := item_1.val
			if rt.is_true(rt.identical(rt.new_string(rt.call_function('substr', [
				var_method.clone(),
				rt.new_int(0),
				rt.new_int(5),
			]).to_string().to_lower()), rt.new_string('date_')))
			{
				var_cache.array_get_mut(rt.call_function('get_class', [
					rt.new_object('SimplePie_Parse_Date', []string{}, &this),
				])).array_push(var_method.clone())
			}
		}
	}
	mut iter_2 := var_cache.array_get(rt.call_function('get_class', [
		rt.new_object('SimplePie_Parse_Date', []string{}, &this),
	])).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_method := item_2.val
		this.built_in.array_push(var_method.clone())
	}
}

fn Class_SimplePie_Parse_Date.get() rt.PhpVal {
	mut var_object := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_object)))) {
		var_object = create_simplepie_parse_date()
	}
	return mut var_object
}

fn (mut this Class_SimplePie_Parse_Date) parse(date string) rt.PhpVal {
	mut iter_3 := this.user.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_method := item_3.val
		mut var_returned := rt.call_function('call_user_func', [
			var_method.clone(), rt.new_string(date)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_returned, rt.new_bool(false))))) {
			return rt.new_int(var_returned.to_i64())
		}
	}
	mut iter_4 := this.built_in.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_method := item_4.val
		mut var_callable := rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('SimplePie_Parse_Date', []string{}, &this) },
			rt.ArrayItem{ key: none, val: var_method },
		])
		mut var_returned := rt.call_function('call_user_func', [
			var_callable.clone(), rt.new_string(date)])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_returned, rt.new_bool(false))))) {
			return var_returned.clone()
		}
	}
	return rt.new_bool(false)
}

fn (mut this Class_SimplePie_Parse_Date) add_callback(mut var_callback Class_SimplePie_Parse_callable) {
	this.user.array_push(var_callback)
}

fn (mut this Class_SimplePie_Parse_Date) date_w3cdtf(date string) bool {
	mut var_match := rt.new_null()
	mut var_pcre :=
		rt.new_string('            /\n            ^\n            (?P<year>[0-9]{4})\n            (?:\n                -?\n                (?P<month>[0-9]{2})\n                (?:\n                    -?\n                    (?P<day>[0-9]{2})\n                    (?:\n                        [Tt\\x09\\x20]+\n                        (?P<hour>[0-9]{2})\n                        (?:\n                            :?\n                            (?P<minute>[0-9]{2})\n                            (?:\n                                :?\n                                (?P<second>[0-9]{2})\n                                (?:\n                                    .\n                                    (?P<second_fraction>[0-9]*)\n                                )?\n                            )?\n                        )?\n                        (?:\n                            (?P<zulu>Z)\n                            |   (?P<tz_sign>[+\\-])\n                                (?P<tz_hour>[0-9]{1,2})\n                                :?\n                                (?P<tz_minute>[0-9]{1,2})\n                        )\n                    )?\n                )?\n            )?\n            $\n            /x')
	if rt.is_true(rt.call_function('preg_match', [var_pcre.clone(),
		rt.new_string(date), var_match.clone()]))
	{
		mut var_year := rt.new_int((var_match.array_get(rt.new_string('year'))).to_i64())
		mut var_month := rt.new_int(if var_match.array_isset(rt.new_string('month')) {
			rt.new_int((var_match.array_get(rt.new_string('month'))).to_i64())
		} else {
			1
		})
		mut var_day := rt.new_int(if var_match.array_isset(rt.new_string('day')) {
			rt.new_int((var_match.array_get(rt.new_string('day'))).to_i64())
		} else {
			1
		})
		mut var_hour := rt.new_int(if var_match.array_isset(rt.new_string('hour')) {
			rt.new_int((var_match.array_get(rt.new_string('hour'))).to_i64())
		} else {
			0
		})
		mut var_minute := rt.new_int(if var_match.array_isset(rt.new_string('minute')) {
			rt.new_int((var_match.array_get(rt.new_string('minute'))).to_i64())
		} else {
			0
		})
		mut var_second := rt.new_int(if var_match.array_isset(rt.new_string('second')) {
			rt.new_int((var_match.array_get(rt.new_string('second'))).to_i64())
		} else {
			0
		})
		mut var_second_fraction := if var_match.array_isset(rt.new_string('second_fraction')) {
			rt.div(rt.new_int((var_match.array_get(rt.new_string('second_fraction'))).to_i64()),
				rt.new_null())
		} else {
			rt.new_int(0)
		}
		mut var_tz_sign := rt.new_int(if rt.is_true(rt.identical(if !(var_match.array_get(rt.new_string('tz_sign'))).is_null() {
			var_match.array_get(rt.new_string('tz_sign'))
		} else {
			rt.new_string('')
		}, rt.new_string('-')))
		{ -1
		 } else { 1
		 })
		mut var_tz_hour := rt.new_int(if var_match.array_isset(rt.new_string('tz_hour')) {
			rt.new_int((var_match.array_get(rt.new_string('tz_hour'))).to_i64())
		} else {
			0
		})
		mut var_tz_minute := rt.new_int(if var_match.array_isset(rt.new_string('tz_minute')) {
			rt.new_int((var_match.array_get(rt.new_string('tz_minute'))).to_i64())
		} else {
			0
		})
		mut var_timezone := rt.mul(var_tz_hour, rt.new_int(3600))
		var_timezone = rt.add(var_timezone, rt.mul(var_tz_minute, rt.new_int(60)))
		var_timezone = rt.mul(var_timezone, var_tz_sign)
		var_second = rt.new_int((rt.call_function('round', [
			rt.add(var_second, var_second_fraction),
		])).to_i64())
		return (rt.sub(rt.call_function('gmmktime', [var_hour.clone(),
			var_minute.clone(), var_second.clone(), var_month.clone(),
			var_day.clone(), var_year.clone()]), var_timezone)).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Parse_Date) remove_rfc2822_comments(string string) rt.PhpVal {
	mut var_position := rt.new_int(0)
	mut var_length := rt.new_int(string.len)
	mut var_depth := rt.new_int(0)
	mut var_output := rt.new_string('')
	mut var_pos := rt.call_function('strpos', [rt.new_string(string),
		rt.new_string('('), var_position.clone()])
	for rt.is_true(rt.less(var_position, var_length))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_pos, rt.new_bool(false))))) {
		var_output = rt.concat(var_output, rt.call_function('substr', [
			rt.new_string(string),
			var_position.clone(),
			rt.sub(var_pos, var_position),
		]))
		var_position = rt.add(var_pos, rt.new_int(1))
		if rt.is_true(rt.identical(var_pos, rt.new_int(0)))
			|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(string).array_get(rt.sub(var_pos, rt.new_int(1))), rt.new_string('\\'))))) {
			rt.post_inc(var_depth)
			for rt.is_true(var_depth) && rt.is_true(rt.less(var_position, var_length)) {
				var_position = rt.add(var_position, rt.call_function('strcspn', [
					rt.new_string(string),
					rt.new_string('()'),
					var_position.clone(),
				]))
				if rt.is_true(rt.identical(rt.new_string(string).array_get(rt.sub(var_position,
					rt.new_int(1))), rt.new_string('\\')))
				{
					rt.post_inc(var_position)
					continue
				} else if rt.new_string(string).array_isset(var_position) {
					mut switch_val_1 := rt.new_string(string).array_get(var_position)
					if rt.is_true(rt.equal(switch_val_1, rt.new_string('('))) {
						rt.post_inc(var_depth)
					} else if rt.is_true(rt.equal(switch_val_1, rt.new_string(')'))) {
						rt.post_dec(var_depth)
					}
					rt.post_inc(var_position)
				} else {
					break
				}
			}
		} else {
			var_output = rt.concat(var_output, rt.new_string('('))
		}
	}
	var_output = rt.concat(var_output, rt.call_function('substr', [
		rt.new_string(string), var_position.clone()]))
	return var_output.clone()
}

fn (mut this Class_SimplePie_Parse_Date) date_rfc2822(date string) bool {
	mut var_match := rt.new_null()
	mut var_pcre := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pcre)))) {
		mut var_wsp := rt.new_string('[\\x09\\x20]')
		mut var_fws := rt.new_string('(?:' + var_wsp.str() + '+|' + var_wsp.str() +
			'*(?:\\x0D\\x0A' + var_wsp.str() + '+)+)')
		mut var_optional_fws := rt.new_string(var_fws.str() + '?')
		mut var_day_name := this.day_pcre
		mut var_month := this.month_pcre
		mut var_day := rt.new_string('([0-9]{1,2})')
		mut var_second := rt.new_string('([0-9]{2})')
		mut var_minute := var_second
		mut var_hour := var_minute
		mut var_year := rt.new_string('([0-9]{2,4})')
		mut var_num_zone := rt.new_string('([+\\-])([0-9]{2})([0-9]{2})')
		mut var_character_zone := rt.new_string('([A-Z]{1,5})')
		mut var_zone := rt.new_string('(?:' + var_num_zone.str() + '|' + var_character_zone.str() +
			')')
		var_pcre = rt.new_string('/(?:' + var_optional_fws.str() + var_day_name.str() +
			var_optional_fws.str() + ',)?' + var_optional_fws.str() + var_day.str() +
			var_fws.str() + var_month.str() + var_fws.str() + var_year.str() + var_fws.str() +
			var_hour.str() + var_optional_fws.str() + ':' + var_optional_fws.str() +
			var_minute.str() + '(?:' + var_optional_fws.str() + ':' + var_optional_fws.str() +
			var_second.str() + ')?' + var_fws.str() + var_zone.str() + '/i')
	}
	if rt.is_true(rt.call_function('preg_match', [var_pcre.clone(),
		this.remove_rfc2822_comments(date), var_match.clone()]))
	{
		var_day = rt.new_int((var_match.array_get(rt.new_int(2))).to_i64())
		var_month =
			this.month.array_get(rt.new_string((var_match.array_get(rt.new_int(3)).to_string().to_lower()).str()))
		var_year = rt.new_int((var_match.array_get(rt.new_int(4))).to_i64())
		var_hour = rt.new_int((var_match.array_get(rt.new_int(5))).to_i64())
		var_minute = rt.new_int((var_match.array_get(rt.new_int(6))).to_i64())
		var_second = rt.new_int((var_match.array_get(rt.new_int(7))).to_i64())
		mut var_tz_sign := var_match.array_get(rt.new_int(8))
		mut var_tz_hour := rt.new_int((var_match.array_get(rt.new_int(9))).to_i64())
		mut var_tz_minute := rt.new_int((var_match.array_get(rt.new_int(10))).to_i64())
		mut var_tz_code := rt.new_string((if var_match.array_isset(rt.new_int(11)) {
			var_match.array_get(rt.new_int(11)).to_string().to_upper()
		} else {
			''
		}).str())
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_tz_sign, rt.new_string(''))))) {
			mut var_timezone := rt.mul(var_tz_hour, rt.new_int(3600))
			var_timezone = rt.add(var_timezone, rt.mul(var_tz_minute, rt.new_int(60)))
			if rt.is_true(rt.identical(var_tz_sign, rt.new_string('-'))) {
				var_timezone = rt.sub(rt.new_int(0), var_timezone)
			}
		} else if this.timezone.array_isset(var_tz_code) {
			var_timezone = this.timezone.array_get(var_tz_code)
		} else {
			var_timezone = rt.new_int(0)
		}
		if rt.is_true(rt.less(var_year, rt.new_int(50))) {
			var_year = rt.add(var_year, rt.new_int(2000))
		} else if rt.is_true(rt.less(var_year, rt.new_int(1000))) {
			var_year = rt.add(var_year, rt.new_int(1900))
		}
		return (rt.sub(rt.call_function('gmmktime', [var_hour.clone(),
			var_minute.clone(), var_second.clone(), var_month.clone(),
			var_day.clone(), var_year.clone()]), var_timezone)).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Parse_Date) date_rfc850(date string) bool {
	mut var_match := rt.new_null()
	mut var_pcre := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pcre)))) {
		mut var_space := rt.new_string('[\\x09\\x20]+')
		mut var_day_name := this.day_pcre
		mut var_month := this.month_pcre
		mut var_day := rt.new_string('([0-9]{1,2})')
		mut var_second := rt.new_string('([0-9]{2})')
		mut var_minute := var_second
		mut var_hour := var_minute
		mut var_year := var_hour
		mut var_zone := rt.new_string('([A-Z]{1,5})')
		var_pcre = rt.new_string('/^' + var_day_name.str() + ',' + var_space.str() + var_day.str() +
			'-' + var_month.str() + '-' + var_year.str() + var_space.str() + var_hour.str() + ':' +
			var_minute.str() + ':' + var_second.str() + var_space.str() + var_zone.str() + '$/i')
	}
	if rt.is_true(rt.call_function('preg_match', [var_pcre.clone(),
		rt.new_string(date), var_match.clone()]))
	{
		var_day = rt.new_int((var_match.array_get(rt.new_int(2))).to_i64())
		var_month =
			this.month.array_get(rt.new_string((var_match.array_get(rt.new_int(3)).to_string().to_lower()).str()))
		var_year = rt.new_int((var_match.array_get(rt.new_int(4))).to_i64())
		var_hour = rt.new_int((var_match.array_get(rt.new_int(5))).to_i64())
		var_minute = rt.new_int((var_match.array_get(rt.new_int(6))).to_i64())
		var_second = rt.new_int((var_match.array_get(rt.new_int(7))).to_i64())
		mut var_tz_code := rt.new_string(var_match.array_get(rt.new_int(8)).to_string().to_upper())
		if this.timezone.array_isset(var_tz_code) {
			mut var_timezone := this.timezone.array_get(var_tz_code)
		} else {
			var_timezone = rt.new_int(0)
		}
		if rt.is_true(rt.less(var_year, rt.new_int(50))) {
			var_year = rt.add(var_year, rt.new_int(2000))
		} else {
			var_year = rt.add(var_year, rt.new_int(1900))
		}
		return (rt.sub(rt.call_function('gmmktime', [var_hour.clone(),
			var_minute.clone(), var_second.clone(), var_month.clone(),
			var_day.clone(), var_year.clone()]), var_timezone)).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Parse_Date) date_asctime(date string) bool {
	mut var_match := rt.new_null()
	mut var_pcre := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_pcre)))) {
		mut var_space := rt.new_string('[\\x09\\x20]+')
		mut var_wday_name := this.day_pcre
		mut var_mon_name := this.month_pcre
		mut var_day := rt.new_string('([0-9]{1,2})')
		mut var_min := rt.new_string('([0-9]{2})')
		mut var_sec := var_min
		mut var_hour := var_sec
		mut var_year := rt.new_string('([0-9]{4})')
		mut var_terminator := rt.new_string('\\x0A?\\x00?')
		var_pcre = rt.new_string('/^' + var_wday_name.str() + var_space.str() + var_mon_name.str() +
			var_space.str() + var_day.str() + var_space.str() + var_hour.str() + ':' +
			var_min.str() + ':' + var_sec.str() + var_space.str() + var_year.str() +
			var_terminator.str() + '$/i')
	}
	if rt.is_true(rt.call_function('preg_match', [var_pcre.clone(),
		rt.new_string(date), var_match.clone()]))
	{
		mut var_month :=
			this.month.array_get(rt.new_string((var_match.array_get(rt.new_int(2)).to_string().to_lower()).str()))
		return (rt.call_function('gmmktime', [
			rt.new_int((var_match.array_get(rt.new_int(4))).to_i64()),
			rt.new_int((var_match.array_get(rt.new_int(5))).to_i64()),
			rt.new_int((var_match.array_get(rt.new_int(6))).to_i64()),
			var_month.clone(),
			rt.new_int((var_match.array_get(rt.new_int(3))).to_i64()),
			rt.new_int((var_match.array_get(rt.new_int(7))).to_i64()),
		])).to_bool()
	}
	return false
}

fn (mut this Class_SimplePie_Parse_Date) date_strtotime(date string) bool {
	mut var_strtotime := rt.call_function('strtotime', [rt.new_string(date)])
	if rt.is_true(rt.identical(var_strtotime, -1))
		|| rt.is_true(rt.identical(var_strtotime, rt.new_bool(false))) {
		return false
	}
	return var_strtotime.to_bool()
}

fn create_simplepie_parse_date() &Class_SimplePie_Parse_Date {
	mut obj := &Class_SimplePie_Parse_Date{
		PhpObjectBase: rt.PhpObjectBase{}
		date:          rt.new_null()
		day:           rt.new_array()
		month:         rt.new_array()
		timezone:      rt.new_array()
		day_pcre:      rt.new_null()
		month_pcre:    rt.new_null()
		built_in:      rt.new_array()
		user:          rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_SimplePie_Parse_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get' {
			return Class_SimplePie_Parse_Date.get()
		}
		'parse' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.parse(dispatch_arg_0)
		}
		'add_callback' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Parse_callable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.add_callback(mut dispatch_arg_0)
			return rt.new_null()
		}
		'date_w3cdtf' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.date_w3cdtf(dispatch_arg_0))
		}
		'remove_rfc2822_comments' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.remove_rfc2822_comments(dispatch_arg_0)
		}
		'date_rfc2822' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.date_rfc2822(dispatch_arg_0))
		}
		'date_rfc850' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.date_rfc850(dispatch_arg_0))
		}
		'date_asctime' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.date_asctime(dispatch_arg_0))
		}
		'date_strtotime' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.date_strtotime(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Parse_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'date' { return this.date }
		'day' { return this.day }
		'month' { return this.month }
		'timezone' { return this.timezone }
		'day_pcre' { return this.day_pcre }
		'month_pcre' { return this.month_pcre }
		'built_in' { return this.built_in }
		'user' { return this.user }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Parse_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'date' {
			this.date = val
			return true
		}
		'day' {
			this.day = val
			return true
		}
		'month' {
			this.month = val
			return true
		}
		'timezone' {
			this.timezone = val
			return true
		}
		'day_pcre' {
			this.day_pcre = val
			return true
		}
		'month_pcre' {
			this.month_pcre = val
			return true
		}
		'built_in' {
			this.built_in = val
			return true
		}
		'user' {
			this.user = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Parse\\Date'),
		rt.new_string('SimplePie_Parse_Date')])
}

import rt

struct Class_ActionScheduler_TimezoneHelper {
	rt.PhpObjectBase
pub mut:
		local_timezone rt.PhpVal = rt.new_null()
}

fn Class_ActionScheduler_TimezoneHelper.set_local_timezone(mut var_date Class_DateTime) rt.PhpVal {
	mut var_date_mutated := var_date
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_a', [var_date_mutated.dup(), rt.new_string('ActionScheduler_DateTime')]))))) {
		var_date_mutated = rt.call_function('as_get_datetime_object', [rt.call_method(var_date_mutated, 'format', [rt.new_string('U')])])
	}
	if rt.is_true(rt.call_function('get_option', [rt.new_string('timezone_string')])) {
		rt.call_method(var_date_mutated, 'setTimezone', [create_datetimezone(Class_ActionScheduler_TimezoneHelper.get_local_timezone_string())])
	} else {
		rt.call_method(var_date_mutated, 'setUtcOffset', [Class_ActionScheduler_TimezoneHelper.get_local_timezone_offset()])
	}
	return rt.new_object('DateTime', []string{}, var_date_mutated)
}

fn Class_ActionScheduler_TimezoneHelper.get_local_timezone_string(reset bool) string {
	mut var_timezone := rt.call_function('get_option', [rt.new_string('timezone_string')])
	if rt.is_true(var_timezone) {
		return (var_timezone).str()
	}
	mut var_utc_offset := rt.new_int(rt.new_int(rt.call_function('get_option', [rt.new_string('gmt_offset'), rt.new_int(0)]).to_i64()))
	if rt.is_true(rt.identical(rt.new_int(0), var_utc_offset)) {
		return 'UTC'
	}
	// unsupported expression: Expr_AssignOp_Mul
	var_timezone = rt.call_function('timezone_name_from_abbr', [rt.new_string(''), var_utc_offset.dup()])
	if rt.is_true(var_timezone) {
		return (var_timezone).str()
	}
	{
		mut iter_1 := rt.call_function('timezone_abbreviations_list', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_abbr := item_1.val
			{
				mut iter_2 := var_abbr.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_city := item_2.val
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Bool, // unsupported expression: Expr_Cast_Bool)) && rt.is_true(var_city.array_get('timezone_id')))) && rt.is_true(rt.identical(rt.new_int(var_city.array_get('offset').to_i64()), var_utc_offset)))) {
						return (var_city.array_get('timezone_id')).str()
					}
				}
			}
		}
	}
	return ''
}

fn Class_ActionScheduler_TimezoneHelper.get_local_timezone_offset() f64 {
	mut var_timezone := rt.call_function('get_option', [rt.new_string('timezone_string')])
	if rt.is_true(var_timezone) {
		mut var_timezone_object := create_datetimezone(var_timezone.dup())
		return (var_timezone_object.getoffset(create_datetime(rt.new_string('now')))).to_f64()
	} else {
		return rt.call_function('get_option', [rt.new_string('gmt_offset'), rt.new_int(0)]).to_f64() * rt.get_constant('HOUR_IN_SECONDS')
	}
	return f64(0.0)
}

fn Class_ActionScheduler_TimezoneHelper.get_local_timezone(reset bool) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('2.1.0'), rt.new_string('ActionScheduler_TimezoneHelper::set_local_timezone()')])
	if var_reset {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	if !(!(// unsupported expression: Expr_StaticPropertyFetch).is_null()) {
		mut var_tzstring := rt.call_function('get_option', [rt.new_string('timezone_string')])
		if !rt.is_true(var_tzstring) {
			mut var_gmt_offset := rt.call_function('absint', [rt.call_function('get_option', [rt.new_string('gmt_offset')])])
			if rt.is_true(rt.identical(rt.new_int(0), var_gmt_offset)) {
				var_tzstring = rt.new_string(rt.new_string('UTC'))
			} else {
				// unsupported expression: Expr_AssignOp_Mul
				var_tzstring = rt.call_function('timezone_name_from_abbr', [rt.new_string(''), var_gmt_offset.dup(), rt.new_int(1)])
				if rt.is_true(rt.identical(rt.new_bool(false), var_tzstring)) {
					var_tzstring = rt.call_function('timezone_name_from_abbr', [rt.new_string(''), var_gmt_offset.dup(), rt.new_int(0)])
				}
				if rt.is_true(rt.identical(rt.new_bool(false), var_tzstring)) {
					mut var_is_dst := rt.call_function('date', [rt.new_string('I')])
					{
						mut iter_1 := rt.call_function('timezone_abbreviations_list', []rt.PhpVal{}).iterator()
						for {
							item_1 := iter_1.next() or { break }
							mut var_abbr := item_1.val
							{
								mut iter_2 := var_abbr.iterator()
								for {
									item_2 := iter_2.next() or { break }
									mut var_city := item_2.val
									if rt.is_true(rt.new_bool(rt.is_true(rt.identical(var_city.array_get('dst'), var_is_dst)) && rt.is_true(rt.identical(var_city.array_get('offset'), var_gmt_offset)))) {
										if rt.is_true(rt.new_bool(var_city.array_get('timezone_id').is_null())) {
											continue
										}
										var_tzstring = var_city.array_get('timezone_id')
										break
									}
								}
							}
						}
					}
				}
				if rt.is_true(rt.identical(rt.new_bool(false), var_tzstring)) {
					var_tzstring = rt.new_string(rt.new_string('UTC'))
				}
			}
		}
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_actionscheduler_timezonehelper() &Class_ActionScheduler_TimezoneHelper {
	mut obj := &Class_ActionScheduler_TimezoneHelper{
		PhpObjectBase: rt.PhpObjectBase{}
		local_timezone: rt.new_null()
	}
	return obj
}

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'set_local_timezone' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			return Class_ActionScheduler_TimezoneHelper.set_local_timezone(mut dispatch_arg_0)
		}
		'get_local_timezone_string' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return rt.new_string(Class_ActionScheduler_TimezoneHelper.get_local_timezone_string(dispatch_arg_0))
		}
		'get_local_timezone_offset' {
			return rt.new_float(Class_ActionScheduler_TimezoneHelper.get_local_timezone_offset())
		}
		'get_local_timezone' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_ActionScheduler_TimezoneHelper.get_local_timezone(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ActionScheduler_TimezoneHelper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'local_timezone' { return this.local_timezone }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_TimezoneHelper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'local_timezone' { this.local_timezone = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_abstracts_actionscheduler_timezonehelper_php() {
}

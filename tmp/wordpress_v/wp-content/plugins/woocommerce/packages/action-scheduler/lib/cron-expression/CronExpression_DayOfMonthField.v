import rt

struct Class_CronExpression_DayOfMonthField {
	rt.PhpObjectBase
}

fn Class_CronExpression_DayOfMonthField.getnearestweekday(var_currentYear rt.PhpVal, var_currentMonth rt.PhpVal, var_targetDay rt.PhpVal) rt.PhpVal {
	mut var_targetDay_mutated := var_targetDay
	mut var_tday := rt.call_function('str_pad', [var_targetDay_mutated.dup(), rt.new_int(2), rt.new_string('0'), rt.get_constant('STR_PAD_LEFT')])
	mut var_target := create_datetime(rt.new_string("${var_currentYear.to_string()}-${var_currentMonth.to_string()}-${var_tday.to_string()}"))
	mut var_currentWeekday := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less(var_currentWeekday, rt.new_int(6))) {
		return mut var_target
	}
	mut var_lastDayOfMonth := var_target.format(rt.new_string('t'))
	{
		mut iter_1 := rt.create_array([rt.ArrayItem{ key: none, val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: none, val: 1 }, rt.ArrayItem{ key: none, val: // unsupported expression: Expr_UnaryMinus }, rt.ArrayItem{ key: none, val: 2 }]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_i := item_1.val
			mut var_adjusted := rt.add(var_targetDay_mutated, var_i)
			if rt.is_true(rt.new_bool(rt.is_true(rt.greater(var_adjusted, rt.new_int(0))) && rt.is_true(rt.less_equal(var_adjusted, var_lastDayOfMonth)))) {
				var_target.setdate(var_currentYear.dup(), var_currentMonth.dup(), var_adjusted.dup())
				if rt.is_true(rt.new_bool(rt.is_true(rt.less(var_target.format(rt.new_string('N')), rt.new_int(6))) && rt.is_true(rt.equal(var_target.format(rt.new_string('m')), var_currentMonth)))) {
					return mut var_target
				}
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_CronExpression_DayOfMonthField) issatisfiedby(mut var_date Class_DateTime, var_value rt.PhpVal) bool {
	if rt.is_true(rt.equal(var_value, rt.new_string('?'))) {
		return true
	}
	mut var_fieldValue := var_date.format(rt.new_string('d'))
	if rt.is_true(rt.equal(var_value, rt.new_string('L'))) {
		return (rt.equal(var_fieldValue, var_date.format(rt.new_string('t')))).to_bool()
	}
	if rt.is_true(rt.call_function('strpos', [var_value.dup(), rt.new_string('W')])) {
		mut var_targetDay := rt.call_function('substr', [var_value.dup(), rt.new_int(0), rt.call_function('strpos', [var_value.dup(), rt.new_string('W')])])
		return (rt.equal(var_date.format(rt.new_string('j')), rt.call_method(Class_CronExpression_DayOfMonthField.getnearestweekday(var_date.format(rt.new_string('Y')), var_date.format(rt.new_string('m')), var_targetDay.dup()), 'format', [rt.new_string('j')]))).to_bool()
	}
	return (this.issatisfied(var_date.format(rt.new_string('d')), var_value.dup())).to_bool()
}

fn (mut this Class_CronExpression_DayOfMonthField) increment(mut var_date Class_DateTime, invert bool) rt.PhpVal {
	if var_invert {
		var_date.modify(rt.new_string('previous day'))
		var_date.settime(rt.new_int(23), rt.new_int(59))
	} else {
		var_date.modify(rt.new_string('next day'))
		var_date.settime(rt.new_int(0), rt.new_int(0))
	}
	return rt.new_object('CronExpression_DayOfMonthField', []string{}, this)
}

fn (mut this Class_CronExpression_DayOfMonthField) validate(var_value rt.PhpVal) rt.PhpVal {
	return // unsupported expression: Expr_Cast_Bool
}

struct Class_CronExpression_AbstractField {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_cronexpression_dayofmonthfield() &Class_CronExpression_DayOfMonthField {
	mut obj := &Class_CronExpression_DayOfMonthField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_abstractfield() &Class_CronExpression_AbstractField {
	mut obj := &Class_CronExpression_AbstractField{
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

fn (mut this Class_CronExpression_DayOfMonthField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getNearestWeekday' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_CronExpression_DayOfMonthField.getnearestweekday(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'isSatisfiedBy' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.issatisfiedby(mut dispatch_arg_0, dispatch_arg_1))
		}
		'increment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.increment(mut dispatch_arg_0, dispatch_arg_1)
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_CronExpression_DayOfMonthField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_DayOfMonthField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_CronExpression_AbstractField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_AbstractField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_AbstractField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_lib_cron_expression_cronexpression_dayofmonthfield_php() {
}

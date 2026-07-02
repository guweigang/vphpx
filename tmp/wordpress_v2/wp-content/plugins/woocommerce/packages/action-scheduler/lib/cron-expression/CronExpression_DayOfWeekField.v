import rt

struct Class_CronExpression_DayOfWeekField {
	rt.PhpObjectBase
}

fn (mut this Class_CronExpression_DayOfWeekField) issatisfiedby(mut var_date Class_DateTime, var_value rt.PhpVal) bool {
	mut var_nth := rt.new_null()
	mut var_value_mutated := var_value
	if rt.is_true(rt.equal(var_value_mutated, rt.new_string('?'))) {
		return true
	}
	var_value_mutated = rt.call_function('str_ireplace', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'SUN' },
			rt.ArrayItem{ key: none, val: 'MON' }, rt.ArrayItem{ key: none, val: 'TUE' },
			rt.ArrayItem{ key: none, val: 'WED' }, rt.ArrayItem{ key: none, val: 'THU' },
			rt.ArrayItem{ key: none, val: 'FRI' }, rt.ArrayItem{ key: none, val: 'SAT' }]),
		rt.call_function('range', [rt.new_int(0), rt.new_int(6)]),
		var_value_mutated.clone(),
	])
	mut var_currentYear := var_date.format(rt.new_string('Y'))
	mut var_currentMonth := var_date.format(rt.new_string('m'))
	mut var_lastDayOfMonth := var_date.format(rt.new_string('t'))
	if rt.is_true(rt.call_function('strpos', [var_value_mutated.clone(),
		rt.new_string('L')]))
	{
		mut var_weekday := rt.call_function('str_replace', [rt.new_string('7'),
			rt.new_string('0'),
			rt.call_function('substr', [var_value_mutated.clone(),
				rt.new_int(0),
				rt.call_function('strpos', [var_value_mutated.clone(),
					rt.new_string('L')])])])
		mut var_tdate := var_date.dup()
		rt.call_method(var_tdate, 'setDate', [var_currentYear.clone(),
			var_currentMonth.clone(), var_lastDayOfMonth.clone()])
		for rt.is_true(rt.new_bool(!rt.is_true(rt.equal(rt.call_method(var_tdate, 'format', [
			rt.new_string('w'),
		]), var_weekday)))) {
			rt.call_method(var_tdate, 'setDate', [var_currentYear.clone(),
				var_currentMonth.clone(), rt.pre_dec(var_lastDayOfMonth)])
		}
		return (rt.equal(var_date.format(rt.new_string('j')), var_lastDayOfMonth)).to_bool()
	}
	if rt.is_true(rt.call_function('strpos', [var_value_mutated.clone(),
		rt.new_string('#')]))
	{
		mut list_tmp_1 := rt.call_function('explode', [rt.new_string('#'),
			var_value_mutated.clone()])
		var_weekday = list_tmp_1.array_get(0)
		var_nth = list_tmp_1.array_get(1)
		if rt.is_true(rt.less(var_weekday, rt.new_int(1)))
			|| rt.is_true(rt.greater(var_weekday, rt.new_int(5))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
				create_invalidargumentexception(rt.new_string('Weekday must be a value between 1 and 5. ${var_weekday.to_string()} given'))))
		}
		if rt.is_true(rt.greater(var_nth, rt.new_int(5))) {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{},
				create_invalidargumentexception(rt.new_string('There are never more than 5 of a given weekday in a month'))))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.equal(var_date.format(rt.new_string('N')),
			var_weekday))))
		{
			return false
		}
		var_tdate = var_date.dup()
		rt.call_method(var_tdate, 'setDate', [var_currentYear.clone(),
			var_currentMonth.clone(), rt.new_int(1)])
		mut var_dayCount := rt.new_int(0)
		mut var_currentDay := rt.new_int(1)
		for rt.is_true(rt.less(var_currentDay, rt.add(var_lastDayOfMonth, rt.new_int(1)))) {
			if rt.is_true(rt.equal(rt.call_method(var_tdate, 'format', [
				rt.new_string('N'),
			]), var_weekday))
			{
				if rt.is_true(rt.greater_equal(rt.pre_inc(var_dayCount), var_nth)) {
					break
				}
			}
			rt.call_method(var_tdate, 'setDate', [var_currentYear.clone(),
				var_currentMonth.clone(), rt.pre_inc(var_currentDay)])
		}
		return (rt.equal(var_date.format(rt.new_string('j')), var_currentDay)).to_bool()
	}
	if rt.is_true(rt.call_function('strpos', [var_value_mutated.clone(),
		rt.new_string('-')]))
	{
		mut var_parts := rt.call_function('explode', [rt.new_string('-'),
			var_value_mutated.clone()])
		if rt.is_true(rt.equal(var_parts.array_get(rt.new_int(0)), rt.new_string('7'))) {
			var_parts.array_set(0, '0')
		} else if rt.is_true(rt.equal(var_parts.array_get(rt.new_int(1)), rt.new_string('0'))) {
			var_parts.array_set(1, '7')
		}
		var_value_mutated = rt.call_function('implode', [rt.new_string('-'),
			var_parts.clone()])
	}
	mut var_format := rt.new_string((if rt.is_true(rt.call_function('in_array', [
		rt.new_int(7),
		rt.call_function('str_split', [var_value_mutated.clone()]),
	]))
	{ 'N' } else { 'w' }).str())
	mut var_fieldValue := var_date.format(var_format.clone())
	return (this.issatisfied(var_fieldValue.clone(), var_value_mutated.clone())).to_bool()
}

fn (mut this Class_CronExpression_DayOfWeekField) increment(mut var_date Class_DateTime, invert bool) rt.PhpVal {
	if var_invert {
		var_date.modify(rt.new_string('-1 day'))
		var_date.settime(rt.new_int(23), rt.new_int(59), rt.new_int(0))
	} else {
		var_date.modify(rt.new_string('+1 day'))
		var_date.settime(rt.new_int(0), rt.new_int(0), rt.new_int(0))
	}
	return rt.new_object('CronExpression_DayOfWeekField', []string{}, this)
}

fn (mut this Class_CronExpression_DayOfWeekField) validate(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	return (rt.call_function('preg_match', [rt.new_string('/[\\*,\\/\\-0-9A-Z]+/'),
		var_value_mutated.clone()])).to_bool()
}

struct Class_CronExpression_AbstractField {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_cronexpression_dayofweekfield(_args ...rt.PhpVal) &Class_CronExpression_DayOfWeekField {
	mut obj := &Class_CronExpression_DayOfWeekField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_abstractfield(_args ...rt.PhpVal) &Class_CronExpression_AbstractField {
	mut obj := &Class_CronExpression_AbstractField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception(_args ...rt.PhpVal) &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_CronExpression_DayOfWeekField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isSatisfiedBy' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.issatisfiedby(mut dispatch_arg_0, dispatch_arg_1))
		}
		'increment' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.increment(mut dispatch_arg_0, dispatch_arg_1)
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_CronExpression_DayOfWeekField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_DayOfWeekField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_InvalidArgumentException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_InvalidArgumentException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_InvalidArgumentException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

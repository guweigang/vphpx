import rt

struct Class_CronExpression_MonthField {
	rt.PhpObjectBase
}

fn (mut this Class_CronExpression_MonthField) issatisfiedby(mut var_date Class_DateTime, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = rt.call_function('str_ireplace', [
		rt.create_array([rt.ArrayItem{ key: none, val: 'JAN' },
			rt.ArrayItem{ key: none, val: 'FEB' }, rt.ArrayItem{ key: none, val: 'MAR' },
			rt.ArrayItem{ key: none, val: 'APR' }, rt.ArrayItem{ key: none, val: 'MAY' },
			rt.ArrayItem{ key: none, val: 'JUN' }, rt.ArrayItem{ key: none, val: 'JUL' },
			rt.ArrayItem{ key: none, val: 'AUG' }, rt.ArrayItem{ key: none, val: 'SEP' },
			rt.ArrayItem{ key: none, val: 'OCT' }, rt.ArrayItem{ key: none, val: 'NOV' },
			rt.ArrayItem{ key: none, val: 'DEC' }]),
		rt.call_function('range', [rt.new_int(1), rt.new_int(12)]),
		var_value_mutated.clone(),
	])
	return this.issatisfied(var_date.format(rt.new_string('m')), var_value_mutated.clone())
}

fn (mut this Class_CronExpression_MonthField) increment(mut var_date Class_DateTime, invert bool) rt.PhpVal {
	if var_invert {
		var_date.modify(rt.new_string('previous month'))
		var_date.modify(var_date.format(rt.new_string('Y-m-t')))
		var_date.settime(rt.new_int(23), rt.new_int(59))
	} else {
		var_date.modify(rt.new_string('next month'))
		var_date.modify(var_date.format(rt.new_string('Y-m-01')))
		var_date.settime(rt.new_int(0), rt.new_int(0))
	}
	return rt.new_object('CronExpression_MonthField', []string{}, this)
}

fn (mut this Class_CronExpression_MonthField) validate(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	return (rt.call_function('preg_match', [rt.new_string('/[\\*,\\/\\-0-9A-Z]+/'),
		var_value_mutated.clone()])).to_bool()
}

struct Class_CronExpression_AbstractField {
	rt.PhpObjectBase
}

fn create_cronexpression_monthfield(_args ...rt.PhpVal) &Class_CronExpression_MonthField {
	mut obj := &Class_CronExpression_MonthField{
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

fn (mut this Class_CronExpression_MonthField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'isSatisfiedBy' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_DateTime](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.issatisfiedby(mut dispatch_arg_0, dispatch_arg_1)
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

fn (this &Class_CronExpression_MonthField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_MonthField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

struct Class_CronExpression_MinutesField {
	rt.PhpObjectBase
}

fn (mut this Class_CronExpression_MinutesField) issatisfiedby(mut var_date Class_DateTime, var_value rt.PhpVal) rt.PhpVal {
	return this.issatisfied(var_date.format(rt.new_string('i')), var_value.clone())
}

fn (mut this Class_CronExpression_MinutesField) increment(mut var_date Class_DateTime, invert bool) rt.PhpVal {
	if var_invert {
		var_date.modify(rt.new_string('-1 minute'))
	} else {
		var_date.modify(rt.new_string('+1 minute'))
	}
	return rt.new_object('CronExpression_MinutesField', []string{}, this)
}

fn (mut this Class_CronExpression_MinutesField) validate(var_value rt.PhpVal) bool {
	return (rt.call_function('preg_match', [rt.new_string('/[\\*,\\/\\-0-9]+/'),
		var_value.clone()])).to_bool()
}

struct Class_CronExpression_AbstractField {
	rt.PhpObjectBase
}

fn create_cronexpression_minutesfield(_args ...rt.PhpVal) &Class_CronExpression_MinutesField {
	mut obj := &Class_CronExpression_MinutesField{
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

fn (mut this Class_CronExpression_MinutesField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_CronExpression_MinutesField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_MinutesField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

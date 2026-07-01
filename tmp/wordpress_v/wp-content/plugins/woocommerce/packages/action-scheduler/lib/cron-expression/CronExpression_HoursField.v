import rt

struct Class_CronExpression_HoursField {
	rt.PhpObjectBase
}

fn (mut this Class_CronExpression_HoursField) issatisfiedby(mut var_date Class_DateTime, var_value rt.PhpVal) rt.PhpVal {
	return this.issatisfied(var_date.format(rt.new_string('H')), var_value.dup())
}

fn (mut this Class_CronExpression_HoursField) increment(mut var_date Class_DateTime, invert bool) rt.PhpVal {
	mut var_timezone := var_date.gettimezone()
	var_date.settimezone(create_datetimezone(rt.new_string('UTC')))
	if var_invert {
		var_date.modify(rt.new_string('-1 hour'))
		var_date.settime(var_date.format(rt.new_string('H')), rt.new_int(59))
	} else {
		var_date.modify(rt.new_string('+1 hour'))
		var_date.settime(var_date.format(rt.new_string('H')), rt.new_int(0))
	}
	var_date.settimezone(var_timezone.dup())
	return rt.new_object('CronExpression_HoursField', []string{}, this)
}

fn (mut this Class_CronExpression_HoursField) validate(var_value rt.PhpVal) rt.PhpVal {
	return
}

struct Class_CronExpression_AbstractField {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

fn create_cronexpression_hoursfield() &Class_CronExpression_HoursField {
	mut obj := &Class_CronExpression_HoursField{
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

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_CronExpression_HoursField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
			return this.validate(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_CronExpression_HoursField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_HoursField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_DateTimeZone) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTimeZone) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTimeZone) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_lib_cron_expression_cronexpression_hoursfield_php() {
}

import rt

struct Class_CronExpression_FieldFactory {
	rt.PhpObjectBase
pub mut:
	fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_CronExpression_FieldFactory) getfield(var_position rt.PhpVal) rt.PhpVal {
	if !(this.fields.array_isset(var_position)) {
		mut switch_val_1 := var_position
		if rt.is_true(rt.equal(switch_val_1, rt.new_int(0))) {
			this.fields.array_set(var_position, create_cronexpression_minutesfield())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(1))) {
			this.fields.array_set(var_position, create_cronexpression_hoursfield())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(2))) {
			this.fields.array_set(var_position, create_cronexpression_dayofmonthfield())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(3))) {
			this.fields.array_set(var_position, create_cronexpression_monthfield())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(4))) {
			this.fields.array_set(var_position, create_cronexpression_dayofweekfield())
		} else if rt.is_true(rt.equal(switch_val_1, rt.new_int(5))) {
			this.fields.array_set(var_position, create_cronexpression_yearfield())
		} else {
			rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception(
				var_position.str() + ' is not a valid position')))
		}
	}
	return this.fields.array_get(var_position)
}

struct Class_CronExpression_MinutesField {
	rt.PhpObjectBase
}

struct Class_CronExpression_HoursField {
	rt.PhpObjectBase
}

struct Class_CronExpression_DayOfMonthField {
	rt.PhpObjectBase
}

struct Class_CronExpression_MonthField {
	rt.PhpObjectBase
}

struct Class_CronExpression_DayOfWeekField {
	rt.PhpObjectBase
}

struct Class_CronExpression_YearField {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

fn create_cronexpression_fieldfactory(_args ...rt.PhpVal) &Class_CronExpression_FieldFactory {
	mut obj := &Class_CronExpression_FieldFactory{
		PhpObjectBase: rt.PhpObjectBase{}
		fields:        rt.new_array()
	}
	return obj
}

fn create_cronexpression_minutesfield(_args ...rt.PhpVal) &Class_CronExpression_MinutesField {
	mut obj := &Class_CronExpression_MinutesField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_hoursfield(_args ...rt.PhpVal) &Class_CronExpression_HoursField {
	mut obj := &Class_CronExpression_HoursField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_dayofmonthfield(_args ...rt.PhpVal) &Class_CronExpression_DayOfMonthField {
	mut obj := &Class_CronExpression_DayOfMonthField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_monthfield(_args ...rt.PhpVal) &Class_CronExpression_MonthField {
	mut obj := &Class_CronExpression_MonthField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_dayofweekfield(_args ...rt.PhpVal) &Class_CronExpression_DayOfWeekField {
	mut obj := &Class_CronExpression_DayOfWeekField{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_yearfield(_args ...rt.PhpVal) &Class_CronExpression_YearField {
	mut obj := &Class_CronExpression_YearField{
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

fn (mut this Class_CronExpression_FieldFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getField' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getfield(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_CronExpression_FieldFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'fields' { return this.fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_CronExpression_FieldFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'fields' {
			this.fields = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_CronExpression_MinutesField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_MinutesField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_MinutesField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_CronExpression_HoursField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_HoursField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_HoursField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_CronExpression_DayOfMonthField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_DayOfMonthField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_DayOfMonthField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_CronExpression_MonthField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_MonthField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_MonthField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_CronExpression_DayOfWeekField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_DayOfWeekField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_DayOfWeekField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_CronExpression_YearField) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_YearField) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_YearField) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

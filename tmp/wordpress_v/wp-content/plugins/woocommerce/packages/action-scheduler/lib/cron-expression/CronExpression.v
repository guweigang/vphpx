import rt

pub fn Class_CronExpression.minute() i64 {
	return 0
}
pub fn Class_CronExpression.hour() i64 {
	return 1
}
pub fn Class_CronExpression.day() i64 {
	return 2
}
pub fn Class_CronExpression.month() i64 {
	return 3
}
pub fn Class_CronExpression.weekday() i64 {
	return 4
}
pub fn Class_CronExpression.year() i64 {
	return 5
}
struct Class_CronExpression {
	rt.PhpObjectBase
pub mut:
		cronParts rt.PhpVal = rt.new_null()
		fieldFactory rt.PhpVal = rt.new_null()
		order rt.PhpVal = rt.new_array()
}

fn Class_CronExpression.factory(var_expression rt.PhpVal, mut var_fieldFactory Class_?CronExpression_FieldFactory) rt.PhpVal {
	mut var_expression_mutated := var_expression
	mut var_mappings := rt.create_array([rt.ArrayItem{ key: '@yearly', val: '0 0 1 1 *' }, rt.ArrayItem{ key: '@annually', val: '0 0 1 1 *' }, rt.ArrayItem{ key: '@monthly', val: '0 0 1 * *' }, rt.ArrayItem{ key: '@weekly', val: '0 0 * * 0' }, rt.ArrayItem{ key: '@daily', val: '0 0 * * *' }, rt.ArrayItem{ key: '@hourly', val: '0 * * * *' }])
	if var_mappings.array_isset(var_expression_mutated) {
		var_expression_mutated = var_mappings.array_get(var_expression_mutated)
	}
	return create_self(var_expression_mutated.dup(), if rt.is_true(var_fieldFactory) { var_fieldFactory } else { create_cronexpression_fieldfactory() })
}

fn (mut this Class_CronExpression) construct(var_expression rt.PhpVal, mut var_fieldFactory Class_CronExpression_FieldFactory)  {
	mut var_expression_mutated := var_expression
	this.fieldFactory = var_fieldFactory.dup()
	this.setexpression(var_expression_mutated.dup())
}

fn (mut this Class_CronExpression) setexpression(var_value rt.PhpVal) rt.PhpVal {
	this.cronParts = rt.call_function('preg_split', [rt.new_string('/\\s/'), var_value.dup(), // unsupported expression: Expr_UnaryMinus, rt.get_constant('PREG_SPLIT_NO_EMPTY')])
	if this.cronParts.array_count() < 5 {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception((var_value).str() + ' is not a valid CRON expression')))
	}
	{
		mut iter_1 := this.cronParts.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_part := item_1.val
			mut var_position := item_1.key
			this.setpart(var_position.dup(), var_part.dup())
		}
	}
	return rt.new_object('CronExpression', []string{}, this)
}

fn (mut this Class_CronExpression) setpart(var_position rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(rt.call_method(this.fieldFactory, 'getField', [var_position.dup()]), 'validate', [var_value.dup()]))))) {
		rt.throw_exception(rt.new_object('InvalidArgumentException', []string{}, create_invalidargumentexception('Invalid CRON field value ' + (var_value).str() + ' as position ' + (var_position).str())))
	}
	this.cronParts.array_set(var_position, var_value.dup())
	return rt.new_object('CronExpression', []string{}, this)
}

fn (mut this Class_CronExpression) getnextrundate(currentTime string, nth i64, allowCurrentDate bool) rt.PhpVal {
	mut currentTime_mutated := currentTime
	mut nth_mutated := nth
	return this.getrundate(rt.new_string(currentTime_mutated), nth_mutated, false, allowCurrentDate)
}

fn (mut this Class_CronExpression) getpreviousrundate(currentTime string, nth i64, allowCurrentDate bool) rt.PhpVal {
	mut currentTime_mutated := currentTime
	mut nth_mutated := nth
	return this.getrundate(rt.new_string(currentTime_mutated), nth_mutated, true, allowCurrentDate)
}

fn (mut this Class_CronExpression) getmultiplerundates(var_total rt.PhpVal, currentTime string, invert bool, allowCurrentDate bool) rt.PhpVal {
	mut currentTime_mutated := currentTime
	mut var_matches := []rt.PhpVal{}
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.call_function('max', [rt.new_int(0), var_total.dup()])))) { break }
			var_matches << this.getrundate(rt.new_string(currentTime_mutated), (var_i).to_i64(), invert, allowCurrentDate)
			rt.post_inc(var_i)
		}
	}
	return var_matches.dup()
}

fn (mut this Class_CronExpression) getexpression(var_part rt.PhpVal) rt.PhpVal {
	mut var_part_mutated := var_part
	if rt.is_true(rt.identical(rt.new_null(), var_part_mutated)) {
		return rt.call_function('implode', [rt.new_string(' '), this.cronParts])
	} else if rt.is_true(rt.new_bool(this.cronParts.array_isset(var_part_mutated.dup()))) {
		return this.cronParts.array_get(var_part_mutated)
	}
	return rt.new_null()
}

fn (mut this Class_CronExpression) magic_tostring() rt.PhpVal {
	return this.getexpression(rt.new_null())
}

fn (mut this Class_CronExpression) isdue(currentTime string) rt.PhpVal {
	mut currentTime_mutated := currentTime
	if rt.is_true(rt.identical(rt.new_string('now'), rt.new_string(currentTime_mutated))) {
		mut var_currentDate := rt.call_function('date', [rt.new_string('Y-m-d H:i')])
		currentTime_mutated = (rt.call_function('strtotime', [var_currentDate.dup()])).str()
	} else if rt.is_true(rt.new_bool(rt.instance_of(rt.new_string(currentTime_mutated), 'DateTime'))) {
		var_currentDate = rt.call_method(rt.new_string(currentTime_mutated), 'format', [rt.new_string('Y-m-d H:i')])
		currentTime_mutated = (rt.call_function('strtotime', [var_currentDate.dup()])).str()
	} else {
		currentTime_mutated = (create_datetime(rt.new_string(currentTime_mutated).dup())).str()
		rt.call_method(rt.new_string(currentTime_mutated), 'setTime', [rt.call_method(rt.new_string(currentTime_mutated), 'format', [rt.new_string('H')]), rt.call_method(rt.new_string(currentTime_mutated), 'format', [rt.new_string('i')]), rt.new_int(0)])
		var_currentDate = rt.call_method(rt.new_string(currentTime_mutated), 'format', [rt.new_string('Y-m-d H:i')])
		currentTime_mutated = (// unsupported expression: Expr_Cast_Int).str()
	}
	return rt.equal(rt.call_method(this.getnextrundate((var_currentDate).str(), 0, true), 'getTimestamp', []rt.PhpVal{}), rt.new_string(currentTime_mutated))
}

fn (mut this Class_CronExpression) getrundate(var_currentTime rt.PhpVal, nth i64, invert bool, allowCurrentDate bool) rt.PhpVal {
	mut var_currentTime_mutated := var_currentTime
	mut nth_mutated := nth
	if rt.is_true(rt.new_bool(rt.instance_of(var_currentTime_mutated, 'DateTime'))) {
		mut var_currentDate := var_currentTime_mutated.dup()
	} else {
		var_currentDate = create_datetime(if rt.is_true(var_currentTime_mutated) { var_currentTime_mutated } else { rt.new_string('now') })
		rt.call_method(var_currentDate, 'setTimezone', [create_datetimezone(rt.call_function('date_default_timezone_get', []rt.PhpVal{}))])
	}
	rt.call_method(var_currentDate, 'setTime', [rt.call_method(var_currentDate, 'format', [rt.new_string('H')]), rt.call_method(var_currentDate, 'format', [rt.new_string('i')]), rt.new_int(0)])
	mut var_nextRun := // unsupported expression: Expr_Clone
	nth_mutated = (// unsupported expression: Expr_Cast_Int).to_i64()
	{
		mut var_i := rt.new_int(rt.new_int(0))
		for {
			if !(rt.is_true(rt.less(var_i, rt.new_int(1000)))) { break }
			{
				mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_position := item_1.val
					mut var_part := this.getexpression(var_position.dup())
					if rt.is_true(rt.identical(rt.new_null(), var_part)) {
						continue
					}
					mut var_satisfied := rt.new_bool(rt.new_bool(false))
					mut var_field := rt.call_method(this.fieldFactory, 'getField', [var_position.dup()])
					if rt.is_true(rt.identical(rt.call_function('strpos', [var_part.dup(), rt.new_string(',')]), rt.new_bool(false))) {
						var_satisfied = rt.call_method(var_field, 'isSatisfiedBy', [var_nextRun.dup(), var_part.dup()])
					} else {
						{
							mut iter_2 := rt.call_function('array_map', [rt.new_string('trim'), rt.call_function('explode', [rt.new_string(','), var_part.dup()])]).iterator()
							for {
								item_2 := iter_2.next() or { break }
								mut var_listPart := item_2.val
								if rt.is_true(rt.call_method(var_field, 'isSatisfiedBy', [var_nextRun.dup(), var_listPart.dup()])) {
									var_satisfied = rt.new_bool(rt.new_bool(true))
									break
								}
							}
						}
					}
					if rt.is_true(rt.new_bool(!(rt.is_true(var_satisfied)))) {
						rt.call_method(var_field, 'increment', [var_nextRun.dup(), rt.new_bool(invert)])
						continue
					}
				}
			}
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(var_allowCurrentDate) && rt.is_true(rt.equal(var_nextRun, var_currentDate)))) || rt.is_true(rt.greater(rt.pre_dec(rt.new_int(nth_mutated)), // unsupported expression: Expr_UnaryMinus)))) {
				rt.call_method(rt.call_method(this.fieldFactory, 'getField', [rt.new_int(0)]), 'increment', [var_nextRun.dup(), rt.new_bool(invert)])
				continue
			}
			return var_nextRun.dup()
			rt.post_inc(var_i)
		}
	}
	rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('Impossible CRON expression'))))
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

struct Class_self {
	rt.PhpObjectBase
}

struct Class_CronExpression_FieldFactory {
	rt.PhpObjectBase
}

struct Class_InvalidArgumentException {
	rt.PhpObjectBase
}

struct Class_DateTime {
	rt.PhpObjectBase
}

struct Class_DateTimeZone {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

fn create_cronexpression(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_CronExpression {
	mut obj := &Class_CronExpression{
		PhpObjectBase: rt.PhpObjectBase{}
		cronParts: rt.new_null()
		fieldFactory: rt.new_null()
		order: rt.new_array()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn create_self() &Class_self {
	mut obj := &Class_self{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_cronexpression_fieldfactory() &Class_CronExpression_FieldFactory {
	mut obj := &Class_CronExpression_FieldFactory{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_invalidargumentexception() &Class_InvalidArgumentException {
	mut obj := &Class_InvalidArgumentException{
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

fn create_datetimezone() &Class_DateTimeZone {
	mut obj := &Class_DateTimeZone{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception() &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_CronExpression) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'factory' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?CronExpression_FieldFactory](if args.len > 1 { args[1] } else { rt.new_null() })
			return Class_CronExpression.factory(dispatch_arg_0, mut dispatch_arg_1)
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_CronExpression_FieldFactory](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'setExpression' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.setexpression(dispatch_arg_0)
		}
		'setPart' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.setpart(dispatch_arg_0, dispatch_arg_1)
		}
		'getNextRunDate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.getnextrundate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'getPreviousRunDate' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.getpreviousrundate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'getMultipleRunDates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.getmultiplerundates(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'getExpression' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.getexpression(dispatch_arg_0)
		}
		'__toString' {
			return this.magic_tostring()
		}
		'isDue' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.isdue(dispatch_arg_0)
		}
		'getRunDate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_bool()
			return this.getrundate(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		else { return none }
	}
}

fn (this &Class_CronExpression) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'cronParts' { return this.cronParts }
		'fieldFactory' { return this.fieldFactory }
		'order' { return this.order }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_CronExpression) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'cronParts' { this.cronParts = val; return true }
		'fieldFactory' { this.fieldFactory = val; return true }
		'order' { this.order = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_self) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_self) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_self) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_CronExpression_FieldFactory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_CronExpression_FieldFactory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_CronExpression_FieldFactory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_lib_cron_expression_cronexpression_php() {
}

import rt

struct Class_ActionScheduler_DateTime {
	rt.PhpObjectBase
pub mut:
	utcOffset i64
}

fn (mut this Class_ActionScheduler_DateTime) gettimestamp() rt.PhpVal {
	return if rt.is_true(rt.call_function('method_exists', [rt.new_string('DateTime'),
		rt.new_string('getTimestamp')]))
	{ this.Class_DateTime.gettimestamp() } else { this.format(rt.new_string('U')) }
}

fn (mut this Class_ActionScheduler_DateTime) setutcoffset(var_offset rt.PhpVal) {
	this.utcOffset = var_offset.dup().to_i64()
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_ActionScheduler_DateTime) getoffset() rt.PhpVal {
	return if rt.is_true(this.utcOffset) { this.utcOffset } else { this.Class_DateTime.getoffset() }
	// unsupported statement: Stmt_Nop
	return rt.new_null()
}

fn (mut this Class_ActionScheduler_DateTime) settimezone(var_timezone rt.PhpVal) rt.PhpVal {
	this.utcOffset = 0
	this.Class_DateTime.settimezone(var_timezone.dup())
	return rt.new_object('ActionScheduler_DateTime', []string{}, this)
}

fn (mut this Class_ActionScheduler_DateTime) getoffsettimestamp() rt.PhpVal {
	return rt.add(this.gettimestamp(), this.getoffset())
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_actionscheduler_datetime() &Class_ActionScheduler_DateTime {
	mut obj := &Class_ActionScheduler_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
		utcOffset:     i64(0)
	}
	return obj
}

fn create_datetime() &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ActionScheduler_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'getTimestamp' {
			return this.gettimestamp()
		}
		'setUtcOffset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.setutcoffset(dispatch_arg_0)
			return rt.new_null()
		}
		'getOffset' {
			return this.getoffset()
		}
		'setTimezone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.settimezone(dispatch_arg_0)
		}
		'getOffsetTimestamp' {
			return this.getoffsettimestamp()
		}
		else {
			return none
		}
	}
}

fn (this &Class_ActionScheduler_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'utcOffset' { return rt.new_int(this.utcOffset) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_ActionScheduler_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'utcOffset' {
			this.utcOffset = val.to_i64()
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

pub fn init_wp_content_plugins_woocommerce_packages_action_scheduler_classes_actionscheduler_datetime_php() {
}

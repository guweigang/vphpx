import rt

struct Class_WC_DateTime {
	rt.PhpObjectBase
pub mut:
	utc_offset i64
}

fn (mut this Class_WC_DateTime) magic_tostring() rt.PhpVal {
	return this.format(rt.get_constant('DATE_ATOM'))
}

fn (mut this Class_WC_DateTime) set_utc_offset(var_offset rt.PhpVal) {
	this.utc_offset = var_offset.clone().to_i64()
}

fn (mut this Class_WC_DateTime) getoffset() rt.PhpVal {
	return if rt.is_true(this.utc_offset) {
		this.utc_offset
	} else {
		this.Class_DateTime.getoffset()
	}
}

fn (mut this Class_WC_DateTime) settimezone(var_timezone rt.PhpVal) rt.PhpVal {
	this.utc_offset = 0
	return this.Class_DateTime.settimezone(var_timezone.clone())
}

fn (mut this Class_WC_DateTime) gettimestamp() rt.PhpVal {
	return if rt.is_true(rt.call_function('method_exists', [rt.new_string('DateTime'),
		rt.new_string('getTimestamp')]))
	{ this.Class_DateTime.gettimestamp() } else { this.format(rt.new_string('U')) }
}

fn (mut this Class_WC_DateTime) getoffsettimestamp() rt.PhpVal {
	return rt.add(this.gettimestamp(), this.getoffset())
}

fn (mut this Class_WC_DateTime) date(var_format rt.PhpVal) rt.PhpVal {
	return rt.call_function('gmdate', [var_format.clone(), this.getoffsettimestamp()])
}

fn (mut this Class_WC_DateTime) date_i18n(format string) rt.PhpVal {
	return rt.call_function('date_i18n', [rt.new_string(format),
		this.getoffsettimestamp()])
}

struct Class_DateTime {
	rt.PhpObjectBase
}

fn create_wc_datetime(_args ...rt.PhpVal) &Class_WC_DateTime {
	mut obj := &Class_WC_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
		utc_offset:    i64(0)
	}
	return obj
}

fn create_datetime(_args ...rt.PhpVal) &Class_DateTime {
	mut obj := &Class_DateTime{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_DateTime) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__toString' {
			return this.magic_tostring()
		}
		'set_utc_offset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_utc_offset(dispatch_arg_0)
			return rt.new_null()
		}
		'getOffset' {
			return this.getoffset()
		}
		'setTimezone' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.settimezone(dispatch_arg_0)
		}
		'getTimestamp' {
			return this.gettimestamp()
		}
		'getOffsetTimestamp' {
			return this.getoffsettimestamp()
		}
		'date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.date(dispatch_arg_0)
		}
		'date_i18n' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.date_i18n(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_DateTime) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'utc_offset' { return rt.new_int(this.utc_offset) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_DateTime) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'utc_offset' {
			this.utc_offset = val.to_i64()
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

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

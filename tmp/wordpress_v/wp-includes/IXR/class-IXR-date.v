import rt

struct Class_IXR_Date {
	rt.PhpObjectBase
pub mut:
	year     rt.PhpVal = rt.new_null()
	month    rt.PhpVal = rt.new_null()
	day      rt.PhpVal = rt.new_null()
	hour     rt.PhpVal = rt.new_null()
	minute   rt.PhpVal = rt.new_null()
	second   rt.PhpVal = rt.new_null()
	timezone rt.PhpVal = rt.new_null()
}

fn (mut this Class_IXR_Date) construct(var_time rt.PhpVal) {
	if rt.is_true(rt.new_bool(var_time.dup().is_long() || var_time.dup().is_double())) {
		this.parsetimestamp(var_time.dup())
	} else {
		this.parseiso(var_time.dup())
	}
}

fn (mut this Class_IXR_Date) ixr_date(var_time rt.PhpVal) {
	fn (arg_0 rt.PhpVal) rt.PhpVal {
		mut temp := Class_IXR_Date{}
		temp.construct(arg_0)
		return rt.new_null()
	}(var_time.dup())
}

fn (mut this Class_IXR_Date) parsetimestamp(var_timestamp rt.PhpVal) {
	this.year = rt.call_function('gmdate', [rt.new_string('Y'),
		var_timestamp.dup()])
	this.month = rt.call_function('gmdate', [rt.new_string('m'),
		var_timestamp.dup()])
	this.day = rt.call_function('gmdate', [rt.new_string('d'),
		var_timestamp.dup()])
	this.hour = rt.call_function('gmdate', [rt.new_string('H'),
		var_timestamp.dup()])
	this.minute = rt.call_function('gmdate', [rt.new_string('i'),
		var_timestamp.dup()])
	this.second = rt.call_function('gmdate', [rt.new_string('s'),
		var_timestamp.dup()])
	this.timezone = rt.new_string('')
}

fn (mut this Class_IXR_Date) parseiso(var_iso rt.PhpVal) {
	this.year = rt.call_function('substr', [var_iso.dup(), rt.new_int(0),
		rt.new_int(4)])
	this.month = rt.call_function('substr', [var_iso.dup(), rt.new_int(4),
		rt.new_int(2)])
	this.day = rt.call_function('substr', [var_iso.dup(), rt.new_int(6),
		rt.new_int(2)])
	this.hour = rt.call_function('substr', [var_iso.dup(), rt.new_int(9),
		rt.new_int(2)])
	this.minute = rt.call_function('substr', [var_iso.dup(), rt.new_int(12),
		rt.new_int(2)])
	this.second = rt.call_function('substr', [var_iso.dup(), rt.new_int(15),
		rt.new_int(2)])
	this.timezone = rt.call_function('substr', [var_iso.dup(),
		rt.new_int(17)])
}

fn (mut this Class_IXR_Date) getiso() string {
	return (this.year).str() + (this.month).str() + (this.day).str() + 'T' + (this.hour).str() +
		':' + (this.minute).str() + ':' + (this.second).str() + (this.timezone).str()
}

fn (mut this Class_IXR_Date) getxml() string {
	return '<dateTime.iso8601>' + this.getiso() + '</dateTime.iso8601>'
}

fn (mut this Class_IXR_Date) gettimestamp() rt.PhpVal {
	return rt.call_function('mktime', [this.hour, this.minute, this.second, this.month, this.day,
		this.year])
}

fn create_ixr_date(arg_0 rt.PhpVal) &Class_IXR_Date {
	mut obj := &Class_IXR_Date{
		PhpObjectBase: rt.PhpObjectBase{}
		year:          rt.new_null()
		month:         rt.new_null()
		day:           rt.new_null()
		hour:          rt.new_null()
		minute:        rt.new_null()
		second:        rt.new_null()
		timezone:      rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_IXR_Date) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'IXR_Date' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.ixr_date(dispatch_arg_0)
			return rt.new_null()
		}
		'parseTimestamp' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.parsetimestamp(dispatch_arg_0)
			return rt.new_null()
		}
		'parseIso' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.parseiso(dispatch_arg_0)
			return rt.new_null()
		}
		'getIso' {
			return rt.new_string(this.getiso())
		}
		'getXml' {
			return rt.new_string(this.getxml())
		}
		'getTimestamp' {
			return this.gettimestamp()
		}
		else {
			return none
		}
	}
}

fn (this &Class_IXR_Date) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'year' { return this.year }
		'month' { return this.month }
		'day' { return this.day }
		'hour' { return this.hour }
		'minute' { return this.minute }
		'second' { return this.second }
		'timezone' { return this.timezone }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_IXR_Date) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'year' {
			this.year = val
			return true
		}
		'month' {
			this.month = val
			return true
		}
		'day' {
			this.day = val
			return true
		}
		'hour' {
			this.hour = val
			return true
		}
		'minute' {
			this.minute = val
			return true
		}
		'second' {
			this.second = val
			return true
		}
		'timezone' {
			this.timezone = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_ixr_class_ixr_date_php() {
}

import rt
import crypto.md5

struct Class_SimplePie_Caption {
	rt.PhpObjectBase
pub mut:
		prop_type rt.PhpVal = rt.new_null()
		lang rt.PhpVal = rt.new_null()
		startTime rt.PhpVal = rt.new_null()
		endTime rt.PhpVal = rt.new_null()
		text rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Caption) construct(mut var_type Class_SimplePie_?string, mut var_lang Class_SimplePie_?string, mut var_startTime Class_SimplePie_?string, mut var_endTime Class_SimplePie_?string, mut var_text Class_SimplePie_?string) {
	this.prop_type = var_type
	this.lang = var_lang
	this.startTime = var_startTime
	this.endTime = var_endTime
	this.text = var_text
}

fn (mut this Class_SimplePie_Caption) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Caption', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Caption) get_endtime() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.endTime, rt.new_null())))) {
		return this.endTime
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Caption) get_language() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.lang, rt.new_null())))) {
		return this.lang
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Caption) get_starttime() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.startTime, rt.new_null())))) {
		return this.startTime
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Caption) get_text() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.text, rt.new_null())))) {
		return this.text
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Caption) get_type() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.prop_type, rt.new_null())))) {
		return this.prop_type
	}
	return rt.new_null()
}

fn create_simplepie_caption(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal, arg_4 rt.PhpVal) &Class_SimplePie_Caption {
	mut obj := &Class_SimplePie_Caption{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type: rt.new_null()
		lang: rt.new_null()
		startTime: rt.new_null()
		endTime: rt.new_null()
		text: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3, arg_4)
	return obj
}

fn (mut this Class_SimplePie_Caption) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 3 { args[3] } else { rt.new_null() })
			mut dispatch_arg_4 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 4 { args[4] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2, mut dispatch_arg_3, mut dispatch_arg_4)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_endtime' {
			return this.get_endtime()
		}
		'get_language' {
			return this.get_language()
		}
		'get_starttime' {
			return this.get_starttime()
		}
		'get_text' {
			return this.get_text()
		}
		'get_type' {
			return this.get_type()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Caption) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'lang' { return this.lang }
		'startTime' { return this.startTime }
		'endTime' { return this.endTime }
		'text' { return this.text }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Caption) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' { this.prop_type = val; return true }
		'lang' { this.lang = val; return true }
		'startTime' { this.startTime = val; return true }
		'endTime' { this.endTime = val; return true }
		'text' { this.text = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Caption'), rt.new_string('SimplePie_Caption')])
}

import rt
import crypto.md5

struct Class_SimplePie_Rating {
	rt.PhpObjectBase
pub mut:
		scheme rt.PhpVal = rt.new_null()
		value rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Rating) construct(mut var_scheme Class_SimplePie_?string, mut var_value Class_SimplePie_?string) {
	this.scheme = var_scheme
	this.value = var_value
}

fn (mut this Class_SimplePie_Rating) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Rating', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Rating) get_scheme() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.scheme, rt.new_null())))) {
		return this.scheme
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Rating) get_value() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.value, rt.new_null())))) {
		return this.value
	}
	return rt.new_null()
}

fn create_simplepie_rating(arg_0 rt.PhpVal, arg_1 rt.PhpVal) &Class_SimplePie_Rating {
	mut obj := &Class_SimplePie_Rating{
		PhpObjectBase: rt.PhpObjectBase{}
		scheme: rt.new_null()
		value: rt.new_null()
	}
	obj.construct(arg_0, arg_1)
	return obj
}

fn (mut this Class_SimplePie_Rating) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_scheme' {
			return this.get_scheme()
		}
		'get_value' {
			return this.get_value()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Rating) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'scheme' { return this.scheme }
		'value' { return this.value }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Rating) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'scheme' { this.scheme = val; return true }
		'value' { this.value = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Rating'), rt.new_string('SimplePie_Rating')])
}

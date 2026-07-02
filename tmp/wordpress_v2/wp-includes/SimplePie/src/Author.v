import rt
import crypto.md5

struct Class_SimplePie_Author {
	rt.PhpObjectBase
pub mut:
		name rt.PhpVal = rt.new_null()
		link rt.PhpVal = rt.new_null()
		email rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Author) construct(mut var_name Class_SimplePie_?string, mut var_link Class_SimplePie_?string, mut var_email Class_SimplePie_?string) {
	this.name = var_name
	this.link = var_link
	this.email = var_email
}

fn (mut this Class_SimplePie_Author) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Author', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Author) get_name() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.name, rt.new_null())))) {
		return this.name
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Author) get_link() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.link, rt.new_null())))) {
		return this.link
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Author) get_email() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.email, rt.new_null())))) {
		return this.email
	}
	return rt.new_null()
}

fn create_simplepie_author(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_SimplePie_Author {
	mut obj := &Class_SimplePie_Author{
		PhpObjectBase: rt.PhpObjectBase{}
		name: rt.new_null()
		link: rt.new_null()
		email: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_SimplePie_Author) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 0 { args[0] } else { rt.new_null() })
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_SimplePie_?string](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'__toString' {
			return rt.new_string(this.magic_tostring())
		}
		'get_name' {
			return this.get_name()
		}
		'get_link' {
			return this.get_link()
		}
		'get_email' {
			return this.get_email()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Author) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'link' { return this.link }
		'email' { return this.email }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Author) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' { this.name = val; return true }
		'link' { this.link = val; return true }
		'email' { this.email = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Author'), rt.new_string('SimplePie_Author')])
}

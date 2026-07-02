import rt
import crypto.md5

pub fn Class_SimplePie_Restriction.relationship_allow() string {
	return 'allow'
}
pub fn Class_SimplePie_Restriction.relationship_deny() string {
	return 'deny'
}
struct Class_SimplePie_Restriction {
	rt.PhpObjectBase
pub mut:
		relationship rt.PhpVal = rt.new_null()
		prop_type rt.PhpVal = rt.new_null()
		value rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Restriction) construct(mut var_relationship Class_SimplePie_?string, mut var_type Class_SimplePie_?string, mut var_value Class_SimplePie_?string) {
	this.relationship = var_relationship
	this.prop_type = var_type
	this.value = var_value
}

fn (mut this Class_SimplePie_Restriction) magic_tostring() string {
	return md5.hexhash(rt.call_function('serialize', [rt.new_object('SimplePie_Restriction', []string{}, &this)]).to_string())
}

fn (mut this Class_SimplePie_Restriction) get_relationship() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.relationship, rt.new_null())))) {
		return this.relationship
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Restriction) get_type() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.prop_type, rt.new_null())))) {
		return this.prop_type
	}
	return rt.new_null()
}

fn (mut this Class_SimplePie_Restriction) get_value() rt.PhpVal {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(this.value, rt.new_null())))) {
		return this.value
	}
	return rt.new_null()
}

fn create_simplepie_restriction(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_SimplePie_Restriction {
	mut obj := &Class_SimplePie_Restriction{
		PhpObjectBase: rt.PhpObjectBase{}
		relationship: rt.new_null()
		prop_type: rt.new_null()
		value: rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_SimplePie_Restriction) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_relationship' {
			return this.get_relationship()
		}
		'get_type' {
			return this.get_type()
		}
		'get_value' {
			return this.get_value()
		}
		else { return none }
	}
}

fn (this &Class_SimplePie_Restriction) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'relationship' { return this.relationship }
		'type' { return this.prop_type }
		'value' { return this.value }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Restriction) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'relationship' { this.relationship = val; return true }
		'type' { this.prop_type = val; return true }
		'value' { this.value = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}



fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [rt.new_string('SimplePie\\Restriction'), rt.new_string('SimplePie_Restriction')])
}

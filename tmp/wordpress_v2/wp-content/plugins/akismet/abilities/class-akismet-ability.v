import rt

struct Class_Akismet_Ability {
	rt.PhpObjectBase
}

fn (mut this Class_Akismet_Ability) get_ability_name() string {
	return ''
}

fn (mut this Class_Akismet_Ability) get_config() {
}

fn (mut this Class_Akismet_Ability) construct() {
	rt.call_function('wp_register_ability', [rt.new_string(this.get_ability_name()), this.get_config()])
}

fn (mut this Class_Akismet_Ability) current_user_has_permission(mut var_input Class_?array) bool {
	return (rt.call_function('current_user_can', [rt.new_string('moderate_comments')])).to_bool()
}

fn create_akismet_ability() &Class_Akismet_Ability {
	mut obj := &Class_Akismet_Ability{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_Akismet_Ability) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_ability_name' {
			return rt.new_string(this.get_ability_name())
		}
		'get_config' {
			this.get_config()
			return rt.new_null()
		}
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'current_user_has_permission' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_?array](if args.len > 0 { args[0] } else { rt.new_null() })
			return rt.new_bool(this.current_user_has_permission(mut dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_Akismet_Ability) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Ability) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}



fn main() {
	defer {
		rt.shutdown()
	}

}

import rt

struct Class_WP_Block_Editor_Context {
	rt.PhpObjectBase
pub mut:
	name rt.PhpVal = rt.new_string('core/edit-post')
	post rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Editor_Context) construct(mut var_settings Class_array) {
	if var_settings.array_isset(rt.new_string('name')) {
		this.name = var_settings.array_get(rt.new_string('name'))
	}
	if var_settings.array_isset(rt.new_string('post')) {
		this.post = var_settings.array_get(rt.new_string('post'))
	}
}

fn create_wp_block_editor_context(arg_0 rt.PhpVal) &Class_WP_Block_Editor_Context {
	mut obj := &Class_WP_Block_Editor_Context{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_string('core/edit-post')
		post:          rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Block_Editor_Context) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Block_Editor_Context) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'post' { return this.post }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Editor_Context) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'post' {
			this.post = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

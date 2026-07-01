import rt

struct Class_SimplePie_Cache_CallableNameFilter {
	rt.PhpObjectBase
pub mut:
	callable rt.PhpVal = rt.new_null()
}

fn (mut this Class_SimplePie_Cache_CallableNameFilter) construct(mut var_callable Class_SimplePie_Cache_callable) {
	this.callable = var_callable.dup()
}

fn (mut this Class_SimplePie_Cache_CallableNameFilter) filter(name string) string {
	return (rt.call_function('call_user_func', [this.callable, rt.new_string(name)])).str()
}

fn create_simplepie_cache_callablenamefilter(arg_0 rt.PhpVal) &Class_SimplePie_Cache_CallableNameFilter {
	mut obj := &Class_SimplePie_Cache_CallableNameFilter{
		PhpObjectBase: rt.PhpObjectBase{}
		callable:      rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_SimplePie_Cache_CallableNameFilter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_SimplePie_Cache_callable](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'filter' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(this.filter(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_SimplePie_Cache_CallableNameFilter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'callable' { return this.callable }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_SimplePie_Cache_CallableNameFilter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'callable' {
			this.callable = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_simplepie_src_cache_callablenamefilter_php() {
	// unsupported statement: Stmt_Declare
}

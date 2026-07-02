import rt

struct Class__WP_Dependency {
	rt.PhpObjectBase
pub mut:
	handle            rt.PhpVal = rt.new_null()
	src               rt.PhpVal = rt.new_null()
	deps              rt.PhpVal = rt.new_array()
	ver               rt.PhpVal = rt.new_bool(false)
	args              rt.PhpVal = rt.new_null()
	extra             rt.PhpVal = rt.new_array()
	textdomain        rt.PhpVal = rt.new_null()
	translations_path rt.PhpVal = rt.new_null()
}

fn (mut this Class__WP_Dependency) construct(var_args rt.PhpVal) {
	mut list_tmp_1 := var_args
	if !(this.deps.is_array()) {
		this.deps = rt.new_array()
	}
}

fn (mut this Class__WP_Dependency) add_data(var_name rt.PhpVal, var_data rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [
		var_name.clone()])))))
	{
		return false
	}
	this.extra.array_set(var_name, var_data.clone())
	return true
}

fn (mut this Class__WP_Dependency) set_translations(var_domain rt.PhpVal, path string) bool {
	if !(var_domain.clone().is_string()) {
		return false
	}
	this.textdomain = var_domain.clone()
	this.translations_path = rt.new_string(path)
	return true
}

fn create__wp_dependency(arg_0 rt.PhpVal) &Class__WP_Dependency {
	mut obj := &Class__WP_Dependency{
		PhpObjectBase:     rt.PhpObjectBase{}
		handle:            rt.new_null()
		src:               rt.new_null()
		deps:              rt.new_array()
		ver:               rt.new_bool(false)
		args:              rt.new_null()
		extra:             rt.new_array()
		textdomain:        rt.new_null()
		translations_path: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class__WP_Dependency) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'add_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.add_data(dispatch_arg_0, dispatch_arg_1))
		}
		'set_translations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_translations(dispatch_arg_0, dispatch_arg_1))
		}
		else {
			return none
		}
	}
}

fn (this &Class__WP_Dependency) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'handle' { return this.handle }
		'src' { return this.src }
		'deps' { return this.deps }
		'ver' { return this.ver }
		'args' { return this.args }
		'extra' { return this.extra }
		'textdomain' { return this.textdomain }
		'translations_path' { return this.translations_path }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class__WP_Dependency) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'handle' {
			this.handle = val
			return true
		}
		'src' {
			this.src = val
			return true
		}
		'deps' {
			this.deps = val
			return true
		}
		'ver' {
			this.ver = val
			return true
		}
		'args' {
			this.args = val
			return true
		}
		'extra' {
			this.extra = val
			return true
		}
		'textdomain' {
			this.textdomain = val
			return true
		}
		'translations_path' {
			this.translations_path = val
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

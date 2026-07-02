import rt

struct Class_WP_Sitemaps_Registry {
	rt.PhpObjectBase
pub mut:
	providers rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Sitemaps_Registry) add_provider(var_name rt.PhpVal, mut var_provider Class_WP_Sitemaps_Provider) bool {
	mut var_provider_mutated := var_provider
	if this.providers.array_isset(var_name) {
		return false
	}
	var_provider_mutated = rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_add_provider'),
		var_provider_mutated,
		var_name.clone(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_provider_mutated,
		'WP_Sitemaps_Provider'))))))
	{
		return false
	}
	this.providers.array_set(var_name, var_provider_mutated)
	return true
}

fn (mut this Class_WP_Sitemaps_Registry) get_provider(var_name rt.PhpVal) rt.PhpVal {
	if !(var_name.clone().is_string()) || !(this.providers.array_isset(var_name)) {
		return rt.new_null()
	}
	return this.providers.array_get(var_name)
}

fn (mut this Class_WP_Sitemaps_Registry) get_providers() rt.PhpVal {
	return this.providers
}

fn create_wp_sitemaps_registry(_args ...rt.PhpVal) &Class_WP_Sitemaps_Registry {
	mut obj := &Class_WP_Sitemaps_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		providers:     rt.new_array()
	}
	return obj
}

fn (mut this Class_WP_Sitemaps_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_provider' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_WP_Sitemaps_Provider](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_bool(this.add_provider(dispatch_arg_0, mut dispatch_arg_1))
		}
		'get_provider' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_provider(dispatch_arg_0)
		}
		'get_providers' {
			return this.get_providers()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Sitemaps_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'providers' { return this.providers }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Sitemaps_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'providers' {
			this.providers = val
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

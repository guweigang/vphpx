import rt

struct Class_WP_Feed_Cache_Transient {
	rt.PhpObjectBase
pub mut:
	name     rt.PhpVal = rt.new_null()
	mod_name rt.PhpVal = rt.new_null()
	lifetime rt.PhpVal = rt.new_int(43200)
}

fn (mut this Class_WP_Feed_Cache_Transient) construct(var_location rt.PhpVal, var_name rt.PhpVal, var_type rt.PhpVal) {
	this.name = 'feed_' + var_name.str()
	this.mod_name = 'feed_mod_' + var_name.str()
	mut var_lifetime := this.lifetime
	this.lifetime = rt.call_function('apply_filters', [
		rt.new_string('wp_feed_cache_transient_lifetime'),
		var_lifetime.clone(),
		var_name.clone(),
	])
}

fn (mut this Class_WP_Feed_Cache_Transient) save(var_data rt.PhpVal) bool {
	mut var_data_mutated := var_data
	if rt.is_true(rt.new_bool(rt.instance_of(var_data_mutated, 'SimplePie_SimplePie'))) {
		var_data_mutated = rt.get_property(var_data_mutated, 'data')
	}
	rt.call_function('set_site_transient', [this.name, var_data_mutated.clone(), this.lifetime])
	rt.call_function('set_site_transient', [this.mod_name, rt.call_function('time', []rt.PhpVal{}),
		this.lifetime])
	return true
}

fn (mut this Class_WP_Feed_Cache_Transient) load() rt.PhpVal {
	return rt.call_function('get_site_transient', [this.name])
}

fn (mut this Class_WP_Feed_Cache_Transient) mtime() rt.PhpVal {
	return rt.call_function('get_site_transient', [this.mod_name])
}

fn (mut this Class_WP_Feed_Cache_Transient) touch() rt.PhpVal {
	return rt.call_function('set_site_transient', [this.mod_name,
		rt.call_function('time', []rt.PhpVal{}), this.lifetime])
}

fn (mut this Class_WP_Feed_Cache_Transient) unlink() bool {
	rt.call_function('delete_site_transient', [this.name])
	rt.call_function('delete_site_transient', [this.mod_name])
	return true
}

fn create_wp_feed_cache_transient(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Feed_Cache_Transient {
	mut obj := &Class_WP_Feed_Cache_Transient{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_null()
		mod_name:      rt.new_null()
		lifetime:      rt.new_int(43200)
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn (mut this Class_WP_Feed_Cache_Transient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'save' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.save(dispatch_arg_0))
		}
		'load' {
			return this.load()
		}
		'mtime' {
			return this.mtime()
		}
		'touch' {
			return this.touch()
		}
		'unlink' {
			return rt.new_bool(this.unlink())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Feed_Cache_Transient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'mod_name' { return this.mod_name }
		'lifetime' { return this.lifetime }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Feed_Cache_Transient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'mod_name' {
			this.mod_name = val
			return true
		}
		'lifetime' {
			this.lifetime = val
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

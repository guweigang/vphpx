import rt

struct Class_WP_Feed_Cache {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Feed_Cache) create(var_location rt.PhpVal, var_filename rt.PhpVal, var_extension rt.PhpVal) rt.PhpVal {
	return create_wp_feed_cache_transient(var_location.dup(), var_filename.dup(),
		var_extension.dup())
}

struct Class_SimplePie_Cache {
	rt.PhpObjectBase
}

struct Class_WP_Feed_Cache_Transient {
	rt.PhpObjectBase
}

fn create_wp_feed_cache() &Class_WP_Feed_Cache {
	mut obj := &Class_WP_Feed_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_simplepie_cache() &Class_SimplePie_Cache {
	mut obj := &Class_SimplePie_Cache{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_feed_cache_transient() &Class_WP_Feed_Cache_Transient {
	mut obj := &Class_WP_Feed_Cache_Transient{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Feed_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'create' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.create(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Feed_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Feed_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_SimplePie_Cache) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SimplePie_Cache) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SimplePie_Cache) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Feed_Cache_Transient) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Feed_Cache_Transient) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Feed_Cache_Transient) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_class_wp_feed_cache_php() {
	rt.call_function('_deprecated_file', [
		rt.call_function('basename', [rt.new_string(@FILE)]),
		rt.new_string('5.6.0'),
		rt.new_string(''),
		rt.call_function('__', [
			rt.new_string('This file is only loaded for backward compatibility with SimplePie 1.2.x. Please consider switching to a recent SimplePie version.'),
		]),
	])
}

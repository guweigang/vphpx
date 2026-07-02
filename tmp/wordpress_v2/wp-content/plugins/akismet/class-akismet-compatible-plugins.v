import rt

pub fn Class_Akismet_Compatible_Plugins.compatible_plugin_endpoint() string {
	return 'https://rest.akismet.com/1.2/compatible-plugins'
}

pub fn Class_Akismet_Compatible_Plugins.compatible_plugin_api_error() string {
	return 'akismet_compatible_plugins_api_error'
}

pub fn Class_Akismet_Compatible_Plugins.compatible_plugin_fields() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'slug' },
		rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'logo' },
		rt.ArrayItem{ key: none, val: 'help_url' }, rt.ArrayItem{ key: none, val: 'path' }])
}

pub fn Class_Akismet_Compatible_Plugins.cache_key() string {
	return 'akismet_compatible_plugin_list'
}

pub fn Class_Akismet_Compatible_Plugins.default_visible_plugin_count() i64 {
	return 2
}

struct Class_Akismet_Compatible_Plugins {
	rt.PhpObjectBase
}

fn Class_Akismet_Compatible_Plugins.get_installed_compatible_plugins(bypass_cache bool) rt.PhpVal {
	mut var_compatible_plugins :=
		Class_Akismet_Compatible_Plugins.get_compatible_plugins(bypass_cache)
	if !rt.is_true(var_compatible_plugins) {
		return create_wp_error(Class_Akismet_Compatible_Plugins.compatible_plugin_api_error(), rt.call_function('__', [
			rt.new_string('Error getting compatible plugins.'),
			rt.new_string('akismet'),
		]))
	}
	mut var_all_plugins := rt.call_function('get_plugins', []rt.PhpVal{})
	mut var_active_compatible_plugins := rt.new_array()
	mut iter_1 := var_compatible_plugins.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_data := item_1.val
		mut var_slug := item_1.key
		mut var_path := var_data.array_get(rt.new_string('path'))
		if !(var_all_plugins.array_isset(var_path)) {
			continue
		}
		mut var_site_active := rt.call_function('is_plugin_active', [
			var_path.clone()])
		mut var_network_active := rt.new_bool(
			rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))
			&& rt.is_true(rt.call_function('is_plugin_active_for_network', [var_path.clone()])))
		if rt.is_true(var_site_active) || rt.is_true(var_network_active) {
			var_active_compatible_plugins.array_set(var_slug, var_data.clone())
		}
	}
	return var_active_compatible_plugins.clone()
}

fn Class_Akismet_Compatible_Plugins.init() {
	rt.call_function('add_action', [rt.new_string('activated_plugin'),
		rt.create_array([rt.ArrayItem{ key: none, val: Class_static.class() },
			rt.ArrayItem{ key: none, val: 'handle_plugin_change' }]),
		rt.new_bool(true)])
	rt.call_function('add_action', [rt.new_string('deactivated_plugin'),
		rt.create_array([rt.ArrayItem{ key: none, val: Class_static.class() },
			rt.ArrayItem{ key: none, val: 'handle_plugin_change' }]),
		rt.new_bool(true)])
}

fn Class_Akismet_Compatible_Plugins.handle_plugin_change(plugin string) {
	mut var_cached_plugins := Class_Akismet_Compatible_Plugins.get_cached_plugins()
	if rt.is_true(rt.identical(rt.new_bool(false), var_cached_plugins)) {
		return
	}
	mut var_plugin_change_should_invalidate_cache := rt.call_function('in_array', [
		rt.new_string(plugin),
		rt.call_function('array_column', [var_cached_plugins.clone(),
			rt.new_string('path')]),
	])
	if rt.is_true(var_plugin_change_should_invalidate_cache) {
		Class_Akismet_Compatible_Plugins.purge_cache()
	}
}

fn Class_Akismet_Compatible_Plugins.get_compatible_plugins(bypass_cache bool) rt.PhpVal {
	mut var_cached_plugins := Class_Akismet_Compatible_Plugins.get_cached_plugins()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_cached_plugins))))
		&& !var_bypass_cache {
		return var_cached_plugins.clone()
	}
	mut var_response := rt.call_function('wp_remote_get', [
		rt.new_string(Class_Akismet_Compatible_Plugins.compatible_plugin_endpoint()),
	])
	mut var_sanitized :=
		Class_Akismet_Compatible_Plugins.validate_compatible_plugin_response(var_response.clone())
	if rt.is_true(rt.identical(rt.new_bool(false), var_sanitized)) {
		return rt.new_array()
	}
	mut var_compatible_plugins := rt.new_array()
	mut iter_2 := var_sanitized.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_plugin := item_2.val
		var_compatible_plugins.array_set(var_plugin.array_get(rt.new_string('slug')),
			var_plugin.clone())
	}
	Class_Akismet_Compatible_Plugins.set_cached_plugins(mut rt.cast_object_ptr[Class_array](var_compatible_plugins))
	return var_compatible_plugins.clone()
}

fn Class_Akismet_Compatible_Plugins.validate_compatible_plugin_response(var_response rt.PhpVal) bool {
	mut var_response_mutated := var_response
	if rt.is_true(rt.call_function('is_wp_error', [var_response_mutated.clone()])) {
		return false
	}
	mut var_response_body := rt.call_function('wp_remote_retrieve_body', [
		var_response_mutated.clone()])
	if !rt.is_true(var_response_body) {
		return false
	}
	mut var_plugins := rt.call_function('json_decode', [var_response_body.clone(),
		rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(var_plugins.clone().is_array()))) {
		return false
	}
	mut iter_3 := var_plugins.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_plugin := item_3.val
		if !(var_plugin.clone().is_array()) {
			continue
		}
		mut var_plugin_key_count := rt.new_int(rt.call_function('array_intersect_key', [
			var_plugin.clone(),
			rt.call_function('array_flip', [Class_static.compatible_plugin_fields()]),
		]).array_count())
		mut var_does_not_have_all_required_fields := rt.new_bool(!(rt.is_true(rt.identical(var_plugin_key_count,
			rt.new_int(Class_static.compatible_plugin_fields().array_count())))))
		if rt.is_true(var_does_not_have_all_required_fields) {
			return false
		}
		if rt.is_true(rt.identical(rt.new_bool(false),
			Class_Akismet_Compatible_Plugins.has_valid_plugin_path((var_plugin.array_get(rt.new_string('path'))).str())))
		{
			return false
		}
	}
	return (Class_Akismet_Compatible_Plugins.sanitize_compatible_plugin_response(mut rt.cast_object_ptr[Class_array](var_plugins))).to_bool()
}

fn Class_Akismet_Compatible_Plugins.has_valid_plugin_path(path string) bool {
	mut path_mutated := path
	return (rt.identical(rt.call_function('preg_match', [
		rt.new_string('/^[a-zA-Z0-9._-]+\\/[a-zA-Z0-9_-]+\\.php$/'),
		rt.new_string(path_mutated).clone(),
	]), rt.new_int(1))).to_bool()
}

fn Class_Akismet_Compatible_Plugins.sanitize_compatible_plugin_response(mut var_plugins Class_array) rt.PhpVal {
	mut var_plugins_mutated := var_plugins
	mut iter_4 := var_plugins_mutated.iterator()
	for {
		item_4 := iter_4.next() or { break }
		mut var_plugin := item_4.val
		mut var_key := item_4.key
		var_plugins_mutated.array_set(var_key, rt.call_function('array_map', [
			rt.new_string('sanitize_text_field'),
			var_plugin.clone(),
		]))
		var_plugins_mutated.array_get_mut(var_key).array_set('help_url', rt.call_function('sanitize_url', [
			var_plugins_mutated.array_get(var_key).array_get(rt.new_string('help_url')),
		]))
		var_plugins_mutated.array_get_mut(var_key).array_set('logo', rt.call_function('sanitize_url', [
			var_plugins_mutated.array_get(var_key).array_get(rt.new_string('logo')),
		]))
	}
	return rt.new_object('array', []string{}, var_plugins_mutated)
}

fn Class_Akismet_Compatible_Plugins.set_cached_plugins(mut var_plugins Class_array) bool {
	mut var_plugins_mutated := var_plugins
	mut var__blog_id :=
		rt.new_int((rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64())
	return (rt.call_function('set_transient', [
		rt.new_string((Class_static.cache_key()).str() + '_${var__blog_id.to_string()}'),
		var_plugins_mutated,
		rt.get_constant('DAY_IN_SECONDS'),
	])).to_bool()
}

fn Class_Akismet_Compatible_Plugins.get_cached_plugins() rt.PhpVal {
	mut var__blog_id :=
		rt.new_int((rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64())
	return rt.call_function('get_transient', [
		rt.new_string((Class_static.cache_key()).str() + '_${var__blog_id.to_string()}'),
	])
}

fn Class_Akismet_Compatible_Plugins.purge_cache() bool {
	mut var__blog_id :=
		rt.new_int((rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64())
	return (rt.call_function('delete_transient', [
		rt.new_string((Class_static.cache_key()).str() + '_${var__blog_id.to_string()}'),
	])).to_bool()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_akismet_compatible_plugins(_args ...rt.PhpVal) &Class_Akismet_Compatible_Plugins {
	mut obj := &Class_Akismet_Compatible_Plugins{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Akismet_Compatible_Plugins) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_installed_compatible_plugins' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Akismet_Compatible_Plugins.get_installed_compatible_plugins(dispatch_arg_0)
		}
		'init' {
			Class_Akismet_Compatible_Plugins.init()
			return rt.new_null()
		}
		'handle_plugin_change' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_Akismet_Compatible_Plugins.handle_plugin_change(dispatch_arg_0)
			return rt.new_null()
		}
		'get_compatible_plugins' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_Akismet_Compatible_Plugins.get_compatible_plugins(dispatch_arg_0)
		}
		'validate_compatible_plugin_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_Akismet_Compatible_Plugins.validate_compatible_plugin_response(dispatch_arg_0))
		}
		'has_valid_plugin_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Akismet_Compatible_Plugins.has_valid_plugin_path(dispatch_arg_0))
		}
		'sanitize_compatible_plugin_response' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return Class_Akismet_Compatible_Plugins.sanitize_compatible_plugin_response(mut dispatch_arg_0)
		}
		'set_cached_plugins' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return rt.new_bool(Class_Akismet_Compatible_Plugins.set_cached_plugins(mut dispatch_arg_0))
		}
		'get_cached_plugins' {
			return Class_Akismet_Compatible_Plugins.get_cached_plugins()
		}
		'purge_cache' {
			return rt.new_bool(Class_Akismet_Compatible_Plugins.purge_cache())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Akismet_Compatible_Plugins) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Akismet_Compatible_Plugins) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Error) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Error) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Error) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

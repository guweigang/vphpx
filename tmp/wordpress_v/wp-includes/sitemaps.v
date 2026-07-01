import rt

fn wp_sitemaps_get_server() rt.PhpVal {
	// unsupported statement: Stmt_Global
	if !rt.is_true(var_wp_sitemaps) {
		mut var_wp_sitemaps := create_wp_sitemaps()
		var_wp_sitemaps.init()
		rt.call_function('do_action', [rt.new_string('wp_sitemaps_init'), var_wp_sitemaps])
	}
	return mut var_wp_sitemaps
}

fn wp_get_sitemap_providers() rt.PhpVal {
	mut var_sitemaps := wp_sitemaps_get_server()
	return rt.call_method(rt.get_property(var_sitemaps, 'registry'), 'get_providers', []rt.PhpVal{})
}

fn wp_register_sitemap_provider(var_name rt.PhpVal, var_provider rt.PhpVal) rt.PhpVal {
	mut var_sitemaps := wp_sitemaps_get_server()
	return rt.call_method(rt.get_property(var_sitemaps, 'registry'), 'add_provider', [
		var_name.dup(),
		var_provider.dup(),
	])
}

fn wp_sitemaps_get_max_urls(var_object_type rt.PhpVal) rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('wp_sitemaps_max_urls'),
		rt.new_int(2000), var_object_type.dup()])
}

fn get_sitemap_url(var_name rt.PhpVal, subtype_name string, page i64) bool {
	mut var_sitemaps := wp_sitemaps_get_server()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_sitemaps)))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('index'), var_name)) {
		return (rt.call_method(rt.get_property(var_sitemaps, 'index'), 'get_index_url',
			[]rt.PhpVal{})).to_bool()
	}
	mut var_provider := rt.call_method(rt.get_property(var_sitemaps, 'registry'), 'get_provider', [
		var_name.dup(),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_provider)))) {
		return false
	}
	if rt.is_true(rt.new_bool(var_subtype_name.len > 0 && var_subtype_name != '0'
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string(subtype_name), rt.func_array_keys(rt.call_method(var_provider, 'get_object_subtypes', []rt.PhpVal{})), rt.new_bool(true)])))))))
	{
		return false
	}
	page = (rt.call_function('absint', [rt.new_int(page)])).to_i64()
	if 0 >= page {
		page = 1
	}
	return (rt.call_method(var_provider, 'get_sitemap_url', [
		rt.new_string(subtype_name), rt.new_int(page)])).to_bool()
}

struct Class_WP_Sitemaps {
	rt.PhpObjectBase
}

fn create_wp_sitemaps() &Class_WP_Sitemaps {
	mut obj := &Class_WP_Sitemaps{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Sitemaps) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_includes_sitemaps_php() {
}

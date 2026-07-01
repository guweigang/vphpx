import rt

struct Class_WP_Sitemaps_Index {
	rt.PhpObjectBase
pub mut:
	registry     rt.PhpVal = rt.new_null()
	max_sitemaps rt.PhpVal = rt.new_int(50000)
}

fn (mut this Class_WP_Sitemaps_Index) construct(mut var_registry Class_WP_Sitemaps_Registry) {
	this.registry = var_registry.dup()
}

fn (mut this Class_WP_Sitemaps_Index) get_sitemap_list() rt.PhpVal {
	mut var_sitemaps := rt.new_array()
	mut var_providers := rt.call_method(this.registry, 'get_providers', []rt.PhpVal{})
	{
		mut iter_1 := var_providers.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_provider := item_1.val
			mut var_name := item_1.key
			mut var_sitemap_entries := rt.call_method(var_provider, 'get_sitemap_entries',
				[]rt.PhpVal{})
			if rt.is_true(rt.new_bool(!(rt.is_true(var_sitemap_entries)))) {
				continue
			}
			var_sitemaps.dup().array_push(var_sitemap_entries.dup())
			if rt.is_true(rt.greater_equal(rt.new_int(var_sitemaps.dup().array_count()),
				this.max_sitemaps))
			{
				break
			}
		}
	}
	return rt.call_function('array_slice', [var_sitemaps.dup(),
		rt.new_int(0), this.max_sitemaps, rt.new_bool(true)])
}

fn (mut this Class_WP_Sitemaps_Index) get_index_url() rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks',
		[]rt.PhpVal{})))))
	{
		return rt.call_function('home_url', [rt.new_string('/?sitemap=index')])
	}
	return rt.call_function('home_url', [rt.new_string('/wp-sitemap.xml')])
}

fn create_wp_sitemaps_index(arg_0 rt.PhpVal) &Class_WP_Sitemaps_Index {
	mut obj := &Class_WP_Sitemaps_Index{
		PhpObjectBase: rt.PhpObjectBase{}
		registry:      rt.new_null()
		max_sitemaps:  rt.new_int(50000)
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Sitemaps_Index) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Sitemaps_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_sitemap_list' {
			return this.get_sitemap_list()
		}
		'get_index_url' {
			return this.get_index_url()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Sitemaps_Index) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registry' { return this.registry }
		'max_sitemaps' { return this.max_sitemaps }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Sitemaps_Index) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registry' {
			this.registry = val
			return true
		}
		'max_sitemaps' {
			this.max_sitemaps = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_sitemaps_class_wp_sitemaps_index_php() {
}

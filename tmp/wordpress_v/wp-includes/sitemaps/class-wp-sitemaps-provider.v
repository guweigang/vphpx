import rt

struct Class_WP_Sitemaps_Provider {
	rt.PhpObjectBase
pub mut:
	name        rt.PhpVal = rt.new_string('')
	object_type rt.PhpVal = rt.new_string('')
}

fn (mut this Class_WP_Sitemaps_Provider) get_url_list(var_page_num rt.PhpVal, object_subtype string) {
}

fn (mut this Class_WP_Sitemaps_Provider) get_max_num_pages(object_subtype string) {
}

fn (mut this Class_WP_Sitemaps_Provider) get_sitemap_type_data() rt.PhpVal {
	mut var_sitemap_data := []rt.PhpVal{}
	mut var_object_subtypes := this.get_object_subtypes()
	if !rt.is_true(var_object_subtypes) {
		var_sitemap_data << rt.create_array([rt.ArrayItem{ key: 'name', val: '' },
			rt.ArrayItem{ key: 'pages', val: this.get_max_num_pages('') }])
		return var_sitemap_data.dup()
	}
	{
		mut iter_1 := var_object_subtypes.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_data := item_1.val
			mut var_object_subtype_name := item_1.key
			var_object_subtype_name = var_sitemap_data << rt.create_array([
				rt.ArrayItem{ key: 'name', val: var_object_subtype_name },
				rt.ArrayItem{
					key: 'pages'
					val: this.get_max_num_pages(var_object_subtype_name.str())
				},
			])
		}
	}
	return var_sitemap_data.dup()
}

fn (mut this Class_WP_Sitemaps_Provider) get_sitemap_entries() rt.PhpVal {
	mut var_sitemaps := []rt.PhpVal{}
	mut var_sitemap_types := this.get_sitemap_type_data()
	{
		mut iter_1 := var_sitemap_types.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_type := item_1.val
			{
				mut var_page := rt.new_int(rt.new_int(1))
				for {
					if !(rt.is_true(rt.less_equal(var_page, var_type.array_get('pages')))) { break
					 }
					mut var_sitemap_entry := rt.create_array([
						rt.ArrayItem{ key: 'loc', val: this.get_sitemap_url(var_type.array_get('name'),
							var_page.dup()) },
					])
					var_sitemap_entry = rt.call_function('apply_filters', [
						rt.new_string('wp_sitemaps_index_entry'),
						var_sitemap_entry.dup(),
						this.object_type,
						var_type.array_get('name'),
						var_page.dup(),
					])
					var_sitemaps << var_sitemap_entry.dup()
					rt.post_inc(var_page)
				}
			}
		}
	}
	return var_sitemaps.dup()
}

fn (mut this Class_WP_Sitemaps_Provider) get_sitemap_url(var_name rt.PhpVal, var_page rt.PhpVal) rt.PhpVal {
	mut var_wp_rewrite := rt.new_null()
	mut var_page_mutated := var_page
	// unsupported statement: Stmt_Global
	mut var_params := rt.call_function('array_filter', [
		rt.create_array([rt.ArrayItem{ key: 'sitemap', val: this.name },
			rt.ArrayItem{ key: 'sitemap-subtype', val: var_name },
			rt.ArrayItem{ key: 'paged', val: var_page_mutated }]),
	])
	mut var_basename := rt.call_function('sprintf', [
		rt.new_string('/wp-sitemap-%1$s.xml'),
		rt.call_function('implode', [rt.new_string('-'), var_params.dup()]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_rewrite, 'using_permalinks',
		[]rt.PhpVal{})))))
	{
		var_basename =
			rt.new_string('/?' +(rt.call_function('http_build_query', [var_params.dup(), rt.new_string(''), rt.new_string('&')])).str())
	}
	return rt.call_function('home_url', [var_basename.dup()])
}

fn (mut this Class_WP_Sitemaps_Provider) get_object_subtypes() rt.PhpVal {
	return []rt.PhpVal{}
}

fn create_wp_sitemaps_provider() &Class_WP_Sitemaps_Provider {
	mut obj := &Class_WP_Sitemaps_Provider{
		PhpObjectBase: rt.PhpObjectBase{}
		name:          rt.new_string('')
		object_type:   rt.new_string('')
	}
	return obj
}

fn (mut this Class_WP_Sitemaps_Provider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_url_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			this.get_url_list(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_max_num_pages' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.get_max_num_pages(dispatch_arg_0)
			return rt.new_null()
		}
		'get_sitemap_type_data' {
			return this.get_sitemap_type_data()
		}
		'get_sitemap_entries' {
			return this.get_sitemap_entries()
		}
		'get_sitemap_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_sitemap_url(dispatch_arg_0, dispatch_arg_1)
		}
		'get_object_subtypes' {
			return this.get_object_subtypes()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Sitemaps_Provider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'object_type' { return this.object_type }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Sitemaps_Provider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'object_type' {
			this.object_type = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_sitemaps_class_wp_sitemaps_provider_php() {
}

import rt

struct Class_WP_Sitemaps_Taxonomies {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Sitemaps_Taxonomies) construct() {
	this.dispatch_set_prop('name', rt.new_string('taxonomies'))
	this.dispatch_set_prop('object_type', rt.new_string('term'))
}

fn (mut this Class_WP_Sitemaps_Taxonomies) get_object_subtypes() rt.PhpVal {
	mut var_taxonomies := rt.call_function('get_taxonomies', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
		rt.new_string('objects'),
	])
	var_taxonomies = rt.call_function('array_filter', [var_taxonomies.clone(),
		rt.new_string('is_taxonomy_viewable')])
	return rt.call_function('apply_filters', [rt.new_string('wp_sitemaps_taxonomies'),
		var_taxonomies.clone()])
}

fn (mut this Class_WP_Sitemaps_Taxonomies) get_url_list(var_page_num rt.PhpVal, object_subtype string) rt.PhpVal {
	mut var_taxonomy := rt.new_string(object_subtype)
	mut var_supported_types := this.get_object_subtypes()
	if !(var_supported_types.array_isset(var_taxonomy)) {
		return rt.new_array()
	}
	mut var_url_list := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_taxonomies_pre_url_list'),
		rt.new_null(),
		var_taxonomy.clone(),
		var_page_num.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_url_list)))) {
		return var_url_list.clone()
	}
	var_url_list = rt.new_array()
	mut var_offset := rt.mul(rt.sub(var_page_num, rt.new_int(1)), rt.call_function('wp_sitemaps_get_max_urls', [
		rt.get_property(rt.new_object('WP_Sitemaps_Taxonomies', [
			'WP_Sitemaps_Provider',
		], &this), 'object_type'),
	]))
	mut var_args := this.get_taxonomies_query_args(var_taxonomy.clone())
	var_args.array_set('fields', 'all')
	var_args.array_set('offset', var_offset.clone())
	mut var_taxonomy_terms := create_wp_term_query(var_args.clone())
	if !(!rt.is_true(rt.get_property(var_taxonomy_terms, 'terms'))) {
		mut iter_1 := rt.get_property(var_taxonomy_terms, 'terms').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_term := item_1.val
			mut var_term_link := rt.call_function('get_term_link', [
				var_term.clone(), var_taxonomy.clone()])
			if rt.is_true(rt.call_function('is_wp_error', [var_term_link.clone()])) {
				continue
			}
			mut var_sitemap_entry := rt.create_array([
				rt.ArrayItem{ key: 'loc', val: var_term_link },
			])
			var_sitemap_entry = rt.call_function('apply_filters', [
				rt.new_string('wp_sitemaps_taxonomies_entry'),
				var_sitemap_entry.clone(),
				rt.get_property(var_term, 'term_id'),
				var_taxonomy.clone(),
				var_term.clone(),
			])
			var_url_list.array_push(var_sitemap_entry.clone())
		}
	}
	return var_url_list.clone()
}

fn (mut this Class_WP_Sitemaps_Taxonomies) get_max_num_pages(object_subtype string) i64 {
	if object_subtype == '' {
		return 0
	}
	mut var_taxonomy := rt.new_string(object_subtype)
	mut var_max_num_pages := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_taxonomies_pre_max_num_pages'),
		rt.new_null(),
		var_taxonomy.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_max_num_pages)))) {
		return var_max_num_pages.to_i64()
	}
	mut var_term_count := rt.call_function('wp_count_terms', [
		this.get_taxonomies_query_args(var_taxonomy.clone()),
	])
	return rt.new_int((rt.call_function('ceil', [
		rt.div(rt.new_int(var_term_count.to_i64()), rt.call_function('wp_sitemaps_get_max_urls', [
			rt.get_property(rt.new_object('WP_Sitemaps_Taxonomies', [
				'WP_Sitemaps_Provider',
			], &this), 'object_type'),
		])),
	])).to_i64())
}

fn (mut this Class_WP_Sitemaps_Taxonomies) get_taxonomies_query_args(var_taxonomy rt.PhpVal) rt.PhpVal {
	mut var_taxonomy_mutated := var_taxonomy
	mut var_args := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_taxonomies_query_args'),
		rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_taxonomy_mutated },
			rt.ArrayItem{ key: 'orderby', val: 'term_order' },
			rt.ArrayItem{ key: 'number', val: rt.call_function('wp_sitemaps_get_max_urls', [
				rt.get_property(rt.new_object('WP_Sitemaps_Taxonomies', [
					'WP_Sitemaps_Provider',
				], &this), 'object_type'),
			]) }, rt.ArrayItem{ key: 'hide_empty', val: true },
			rt.ArrayItem{ key: 'hierarchical', val: false }, rt.ArrayItem{
				key: 'update_term_meta_cache'
				val: false
			}]),
		var_taxonomy_mutated.clone(),
	])
	return var_args.clone()
}

struct Class_WP_Sitemaps_Provider {
	rt.PhpObjectBase
}

struct Class_WP_Term_Query {
	rt.PhpObjectBase
}

fn create_wp_sitemaps_taxonomies() &Class_WP_Sitemaps_Taxonomies {
	mut obj := &Class_WP_Sitemaps_Taxonomies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_sitemaps_provider(_args ...rt.PhpVal) &Class_WP_Sitemaps_Provider {
	mut obj := &Class_WP_Sitemaps_Provider{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_term_query(_args ...rt.PhpVal) &Class_WP_Term_Query {
	mut obj := &Class_WP_Term_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Sitemaps_Taxonomies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_object_subtypes' {
			return this.get_object_subtypes()
		}
		'get_url_list' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.get_url_list(dispatch_arg_0, dispatch_arg_1)
		}
		'get_max_num_pages' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_int(this.get_max_num_pages(dispatch_arg_0))
		}
		'get_taxonomies_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_taxonomies_query_args(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Sitemaps_Taxonomies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Taxonomies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Sitemaps_Provider) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Sitemaps_Provider) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Provider) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_Term_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Term_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Term_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

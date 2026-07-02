import rt

struct Class_WP_Sitemaps_Posts {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Sitemaps_Posts) construct() {
	this.dispatch_set_prop('name', rt.new_string('posts'))
	this.dispatch_set_prop('object_type', rt.new_string('post'))
}

fn (mut this Class_WP_Sitemaps_Posts) get_object_subtypes() rt.PhpVal {
	mut var_post_types := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
		rt.new_string('objects'),
	])
	var_post_types.array_unset(rt.new_string('attachment'))
	var_post_types = rt.call_function('array_filter', [var_post_types.clone(),
		rt.new_string('is_post_type_viewable')])
	return rt.call_function('apply_filters', [rt.new_string('wp_sitemaps_post_types'),
		var_post_types.clone()])
}

fn (mut this Class_WP_Sitemaps_Posts) get_url_list(var_page_num rt.PhpVal, object_subtype string) rt.PhpVal {
	mut var_post_type := rt.new_string(object_subtype)
	mut var_supported_types := this.get_object_subtypes()
	if !(var_supported_types.array_isset(var_post_type)) {
		return rt.new_array()
	}
	mut var_url_list := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_posts_pre_url_list'),
		rt.new_null(),
		var_post_type.clone(),
		var_page_num.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_url_list)))) {
		return var_url_list.clone()
	}
	mut var_args := this.get_posts_query_args(var_post_type.clone())
	var_args.array_set('paged', var_page_num.clone())
	mut var_query := create_wp_query(var_args.clone())
	var_url_list = rt.new_array()
	if rt.is_true(rt.identical(rt.new_string('page'), var_post_type))
		&& rt.is_true(rt.identical(rt.new_int(1), var_page_num))
		&& rt.is_true(rt.identical(rt.new_string('posts'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) {
		mut var_sitemap_entry := rt.create_array([
			rt.ArrayItem{ key: 'loc', val: rt.call_function('home_url', [
				rt.new_string('/'),
			]) },
		])
		mut var_latest_posts := create_wp_query(rt.create_array([
			rt.ArrayItem{ key: 'post_type', val: 'post' },
			rt.ArrayItem{ key: 'post_status', val: 'publish' },
			rt.ArrayItem{ key: 'orderby', val: 'date' },
			rt.ArrayItem{ key: 'order', val: 'DESC' },
			rt.ArrayItem{ key: 'no_found_rows', val: true },
			rt.ArrayItem{ key: 'update_post_meta_cache', val: false },
			rt.ArrayItem{ key: 'update_post_term_cache', val: false },
		]))
		if !(!rt.is_true(rt.get_property(var_latest_posts, 'posts'))) {
			mut var_posts := rt.call_function('wp_list_sort', [
				rt.get_property(var_latest_posts, 'posts'),
				rt.new_string('post_modified_gmt'),
				rt.new_string('DESC'),
			])
			var_sitemap_entry.array_set('lastmod', rt.call_function('wp_date', [
				rt.get_constant('DATE_W3C'),
				rt.call_function('strtotime', [
					rt.get_property(var_posts.array_get(rt.new_int(0)), 'post_modified_gmt'),
				]),
			]))
		}
		var_sitemap_entry = rt.call_function('apply_filters', [
			rt.new_string('wp_sitemaps_posts_show_on_front_entry'),
			var_sitemap_entry.clone(),
		])
		var_url_list.array_push(var_sitemap_entry.clone())
	}
	mut iter_1 := rt.get_property(var_query, 'posts').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_post := item_1.val
		var_sitemap_entry = rt.create_array([
			rt.ArrayItem{ key: 'loc', val: rt.call_function('get_permalink', [
				var_post.clone()]) },
			rt.ArrayItem{
				key: 'lastmod'
				val: rt.call_function('wp_date', [rt.get_constant('DATE_W3C'),
					rt.call_function('strtotime', [
						rt.get_property(var_post, 'post_modified_gmt'),
					])])
			},
		])
		var_sitemap_entry = rt.call_function('apply_filters', [
			rt.new_string('wp_sitemaps_posts_entry'),
			var_sitemap_entry.clone(),
			var_post.clone(),
			var_post_type.clone(),
		])
		var_url_list.array_push(var_sitemap_entry.clone())
	}
	return var_url_list.clone()
}

fn (mut this Class_WP_Sitemaps_Posts) get_max_num_pages(object_subtype string) i64 {
	if object_subtype == '' {
		return 0
	}
	mut var_post_type := rt.new_string(object_subtype)
	mut var_max_num_pages := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_posts_pre_max_num_pages'),
		rt.new_null(),
		var_post_type.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_max_num_pages)))) {
		return var_max_num_pages.to_i64()
	}
	mut var_args := this.get_posts_query_args(var_post_type.clone())
	var_args.array_set('fields', 'ids')
	var_args.array_set('no_found_rows', false)
	mut var_query := create_wp_query(var_args.clone())
	mut var_min_num_pages := rt.new_int(if
		rt.is_true(rt.identical(rt.new_string('page'), var_post_type))
		&& rt.is_true(rt.identical(rt.new_string('posts'), rt.call_function('get_option', [rt.new_string('show_on_front')]))) {
		1
	} else {
		0
	})
	return (if !(rt.get_property(var_query, 'max_num_pages')).is_null() {
		rt.call_function('max', [var_min_num_pages.clone(), rt.get_property(var_query,
			'max_num_pages')])
	} else {
		rt.new_int(1)
	}).to_i64()
}

fn (mut this Class_WP_Sitemaps_Posts) get_posts_query_args(var_post_type rt.PhpVal) rt.PhpVal {
	mut var_post_type_mutated := var_post_type
	mut var_args := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_posts_query_args'),
		rt.create_array([rt.ArrayItem{ key: 'orderby', val: 'ID' },
			rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{
				key: 'post_type'
				val: var_post_type_mutated
			}, rt.ArrayItem{ key: 'posts_per_page', val: rt.call_function('wp_sitemaps_get_max_urls', [
				rt.get_property(rt.new_object('WP_Sitemaps_Posts', [
					'WP_Sitemaps_Provider',
				], &this), 'object_type'),
			]) }, rt.ArrayItem{ key: 'post_status', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'publish' },
			]) }, rt.ArrayItem{ key: 'no_found_rows', val: true },
			rt.ArrayItem{ key: 'update_post_term_cache', val: false },
			rt.ArrayItem{ key: 'update_post_meta_cache', val: false },
			rt.ArrayItem{ key: 'ignore_sticky_posts', val: true }]),
		var_post_type_mutated.clone(),
	])
	return var_args.clone()
}

struct Class_WP_Sitemaps_Provider {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

fn create_wp_sitemaps_posts() &Class_WP_Sitemaps_Posts {
	mut obj := &Class_WP_Sitemaps_Posts{
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

fn create_wp_query(_args ...rt.PhpVal) &Class_WP_Query {
	mut obj := &Class_WP_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Sitemaps_Posts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_posts_query_args' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_posts_query_args(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Sitemaps_Posts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Posts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

struct Class_WP_Sitemaps_Users {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Sitemaps_Users) construct() {
	this.dispatch_set_prop('name', rt.new_string('users'))
	this.dispatch_set_prop('object_type', rt.new_string('user'))
}

fn (mut this Class_WP_Sitemaps_Users) get_url_list(var_page_num rt.PhpVal, object_subtype string) rt.PhpVal {
	mut var_url_list := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_users_pre_url_list'),
		rt.new_null(),
		var_page_num.clone(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_url_list)))) {
		return var_url_list.clone()
	}
	mut var_args := this.get_users_query_args()
	var_args.array_set('paged', var_page_num.clone())
	mut var_query := create_wp_user_query(var_args.clone())
	mut var_users := var_query.get_results()
	var_url_list = rt.new_array()
	mut iter_1 := var_users.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_user := item_1.val
		mut var_sitemap_entry := rt.create_array([
			rt.ArrayItem{ key: 'loc', val: rt.call_function('get_author_posts_url', [
				rt.get_property(var_user, 'ID'),
			]) },
		])
		var_sitemap_entry = rt.call_function('apply_filters', [
			rt.new_string('wp_sitemaps_users_entry'),
			var_sitemap_entry.clone(),
			var_user.clone(),
		])
		var_url_list.array_push(var_sitemap_entry.clone())
	}
	return var_url_list.clone()
}

fn (mut this Class_WP_Sitemaps_Users) get_max_num_pages(object_subtype string) i64 {
	mut var_max_num_pages := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_users_pre_max_num_pages'),
		rt.new_null(),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_max_num_pages)))) {
		return var_max_num_pages.to_i64()
	}
	mut var_args := this.get_users_query_args()
	mut var_query := create_wp_user_query(var_args.clone())
	mut var_total_users := var_query.get_total()
	return rt.new_int((rt.call_function('ceil', [
		rt.div(var_total_users, rt.call_function('wp_sitemaps_get_max_urls', [
			rt.get_property(rt.new_object('WP_Sitemaps_Users', [
				'WP_Sitemaps_Provider',
			], &this), 'object_type'),
		])),
	])).to_i64())
}

fn (mut this Class_WP_Sitemaps_Users) get_users_query_args() rt.PhpVal {
	mut var_public_post_types := rt.call_function('get_post_types', [
		rt.create_array([rt.ArrayItem{ key: 'public', val: true }]),
	])
	var_public_post_types.array_unset(rt.new_string('attachment'))
	var_public_post_types.array_unset(rt.new_string('page'))
	mut var_args := rt.call_function('apply_filters', [
		rt.new_string('wp_sitemaps_users_query_args'),
		rt.create_array([
			rt.ArrayItem{
				key: 'has_published_posts'
				val: rt.func_array_keys(var_public_post_types.clone())
			},
			rt.ArrayItem{ key: 'number', val: rt.call_function('wp_sitemaps_get_max_urls', [
				rt.get_property(rt.new_object('WP_Sitemaps_Users', [
					'WP_Sitemaps_Provider',
				], &this), 'object_type'),
			]) },
		]),
	])
	return var_args.clone()
}

struct Class_WP_Sitemaps_Provider {
	rt.PhpObjectBase
}

struct Class_WP_User_Query {
	rt.PhpObjectBase
}

fn create_wp_sitemaps_users() &Class_WP_Sitemaps_Users {
	mut obj := &Class_WP_Sitemaps_Users{
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

fn create_wp_user_query(_args ...rt.PhpVal) &Class_WP_User_Query {
	mut obj := &Class_WP_User_Query{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Sitemaps_Users) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
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
		'get_users_query_args' {
			return this.get_users_query_args()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Sitemaps_Users) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Sitemaps_Users) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_User_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_User_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_User_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

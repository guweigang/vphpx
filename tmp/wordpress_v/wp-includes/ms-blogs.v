import rt
import crypto.md5

fn wpmu_update_blogs_date() {
	mut var_site_id := rt.call_function('get_current_blog_id', []rt.PhpVal{})
	rt.new_bool(update_blog_details(var_site_id.dup(), rt.create_array([rt.ArrayItem{ key: 'last_updated', val: rt.call_function('current_time', [rt.new_string('mysql'), rt.new_bool(true)]) }])))
	rt.call_function('do_action', [rt.new_string('wpmu_blog_updated'), var_site_id.dup()])
}

fn get_blogaddress_by_id(var_blog_id rt.PhpVal) string {
	mut var_bloginfo := rt.call_function('get_site', [// unsupported expression: Expr_Cast_Int])
	if !rt.is_true(var_bloginfo) {
		return ''
	}
	mut var_scheme := rt.call_function('parse_url', [rt.get_property(var_bloginfo, 'home'), rt.get_constant('PHP_URL_SCHEME')])
	var_scheme = if !rt.is_true(var_scheme) { rt.new_string('http') } else { var_scheme }
	return (rt.call_function('esc_url', [(var_scheme).str() + '://' + (rt.get_property(var_bloginfo, 'domain')).str() + (rt.get_property(var_bloginfo, 'path')).str()])).str()
}

fn get_blogaddress_by_name(var_blogname rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		if rt.is_true(rt.identical(rt.new_string('main'), rt.new_string(var_blogname))) {
			var_blogname = 'www'
		}
		mut var_url := rt.new_string(rt.new_string(rt.call_function('network_home_url', []rt.PhpVal{}).to_string().trim_right(' \t\n\r')))
		if !(var_blogname == '') {
			var_url = rt.call_function('preg_replace', [rt.new_string('|^([^\\.]+://)|'), '${1}' + var_blogname + '.', var_url.dup()])
		}
	} else {
		var_url = rt.call_function('network_home_url', [rt.new_string(var_blogname).dup()])
	}
	return rt.call_function('esc_url', [(var_url).str() + '/'])
}

fn get_id_from_blogname(var_slug rt.PhpVal) rt.PhpVal {
	mut var_current_network := rt.call_function('get_network', []rt.PhpVal{})
	var_slug = var_slug.trim_space()
	if rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})) {
		mut var_domain := rt.new_string(var_slug + '.' + (rt.call_function('preg_replace', [rt.new_string('|^www\\.|'), rt.new_string(''), rt.get_property(var_current_network, 'domain')])).str())
		mut var_path := rt.get_property(var_current_network, 'path')
	} else {
		var_domain = rt.get_property(var_current_network, 'domain')
		var_path = rt.new_string((rt.get_property(var_current_network, 'path')).str() + var_slug + '/')
	}
	mut var_site_ids := rt.call_function('get_sites', [rt.create_array([rt.ArrayItem{ key: 'number', val: 1 }, rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'domain', val: var_domain }, rt.ArrayItem{ key: 'path', val: var_path }, rt.ArrayItem{ key: 'update_site_meta_cache', val: false }])])
	if !rt.is_true(var_site_ids) {
		return rt.new_null()
	}
	return rt.call_function('array_shift', [var_site_ids.dup()])
}

fn get_blog_details(var_fields rt.PhpVal, get_all bool) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(var_fields.dup().is_array())) {
		if var_fields.array_isset(rt.new_string('blog_id')) {
			mut var_blog_id := var_fields.array_get('blog_id')
		} else if var_fields.array_isset(rt.new_string('domain')) && var_fields.array_isset(rt.new_string('path')) {
			mut var_key := md5.hexhash((var_fields.array_get('domain')).str() + (var_fields.array_get('path')).str())
			mut var_blog := rt.call_function('wp_cache_get', [rt.new_string(var_key).dup(), rt.new_string('blog-lookup')])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return (var_blog).to_bool()
			}
			if rt.is_true(rt.call_function('str_starts_with', [var_fields.array_get('domain'), rt.new_string('www.')])) {
				mut var_nowww := rt.call_function('substr', [var_fields.array_get('domain'), rt.new_int(4)])
				var_blog = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE domain IN (%s,%s) AND path = %s ORDER BY CHAR_LENGTH(domain) DESC')), var_nowww.dup(), var_fields.array_get('domain'), var_fields.array_get('path')])])
			} else {
				var_blog = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE domain = %s AND path = %s')), var_fields.array_get('domain'), var_fields.array_get('path')])])
			}
			if rt.is_true(var_blog) {
				rt.call_function('wp_cache_set', [(rt.get_property(var_blog, 'blog_id')).str() + 'short', var_blog.dup(), rt.new_string('blog-details')])
				var_blog_id = rt.get_property(var_blog, 'blog_id')
			} else {
				return false
			}
		} else if rt.is_true(rt.new_bool(var_fields.array_isset(rt.new_string('domain')) && rt.is_true(rt.call_function('is_subdomain_install', []rt.PhpVal{})))) {
			var_key = md5.hexhash(var_fields.array_get('domain').to_string())
			var_blog = rt.call_function('wp_cache_get', [rt.new_string(var_key).dup(), rt.new_string('blog-lookup')])
			if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
				return (var_blog).to_bool()
			}
			if rt.is_true(rt.call_function('str_starts_with', [var_fields.array_get('domain'), rt.new_string('www.')])) {
				var_nowww = rt.call_function('substr', [var_fields.array_get('domain'), rt.new_int(4)])
				var_blog = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE domain IN (%s,%s) ORDER BY CHAR_LENGTH(domain) DESC')), var_nowww.dup(), var_fields.array_get('domain')])])
			} else {
				var_blog = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE domain = %s')), var_fields.array_get('domain')])])
			}
			if rt.is_true(var_blog) {
				rt.call_function('wp_cache_set', [(rt.get_property(var_blog, 'blog_id')).str() + 'short', var_blog.dup(), rt.new_string('blog-details')])
				var_blog_id = rt.get_property(var_blog, 'blog_id')
			} else {
				return false
			}
		} else {
			return false
		}
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_fields)))) {
			var_blog_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_fields.dup().is_long() || var_fields.dup().is_double()))))) {
			var_blog_id = get_id_from_blogname(var_fields.dup())
		} else {
			var_blog_id = var_fields
		}
	}
	var_blog_id = // unsupported expression: Expr_Cast_Int
	mut var_all := if var_get_all { '' } else { 'short' }
	mut var_details := rt.call_function('wp_cache_get', [(var_blog_id).str() + var_all, rt.new_string('blog-details')])
	if rt.is_true(var_details) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_details.dup().is_object()))))) {
			if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_details)) {
				return false
			} else {
				rt.call_function('wp_cache_delete', [(var_blog_id).str() + var_all, rt.new_string('blog-details')])
				var_details = rt.new_null()
			}
		} else {
			return (var_details).to_bool()
		}
	}
	if var_get_all {
		var_details = rt.call_function('wp_cache_get', [(var_blog_id).str() + 'short', rt.new_string('blog-details')])
	} else {
		var_details = rt.call_function('wp_cache_get', [var_blog_id.dup(), rt.new_string('blog-details')])
		if rt.is_true(var_details) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_details.dup().is_object()))))) {
				if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_details)) {
					return false
				} else {
					rt.call_function('wp_cache_delete', [var_blog_id.dup(), rt.new_string('blog-details')])
					var_details = rt.new_null()
				}
			} else {
				return (var_details).to_bool()
			}
		}
	}
	if !rt.is_true(var_details) {
		var_details = fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Site{}; return temp.get_instance(arg_0) }(var_blog_id.dup())
		if rt.is_true(rt.new_bool(!(rt.is_true(var_details)))) {
			rt.call_function('wp_cache_set', [var_blog_id.dup(), // unsupported expression: Expr_UnaryMinus, rt.new_string('blog-details')])
			return false
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.instance_of(var_details, 'WP_Site')))))) {
		var_details = create_wp_site(var_details.dup())
	}
	if !(var_get_all) {
		rt.call_function('wp_cache_set', [(var_blog_id).str() + var_all, var_details.dup(), rt.new_string('blog-details')])
		return (var_details).to_bool()
	}
	mut var_switched_blog := false
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.new_bool(switch_to_blog(var_blog_id.dup(), rt.new_null()))
		var_switched_blog = true
	}
	rt.set_property(var_details, 'blogname', rt.call_function('get_option', [rt.new_string('blogname')]))
	rt.set_property(var_details, 'siteurl', rt.call_function('get_option', [rt.new_string('siteurl')]))
	rt.set_property(var_details, 'post_count', rt.call_function('get_option', [rt.new_string('post_count')]))
	rt.set_property(var_details, 'home', rt.call_function('get_option', [rt.new_string('home')]))
	if var_switched_blog {
		rt.new_bool(restore_current_blog())
	}
	var_details = rt.call_function('apply_filters_deprecated', [rt.new_string('blog_details'), rt.create_array([rt.ArrayItem{ key: none, val: var_details }]), rt.new_string('4.7.0'), rt.new_string('site_details')])
	rt.call_function('wp_cache_set', [(var_blog_id).str() + var_all, var_details.dup(), rt.new_string('blog-details')])
	var_key = md5.hexhash((rt.get_property(var_details, 'domain')).str() + (rt.get_property(var_details, 'path')).str())
	rt.call_function('wp_cache_set', [rt.new_string(var_key).dup(), var_details.dup(), rt.new_string('blog-lookup')])
	return (var_details).to_bool()
}

fn refresh_blog_details(blog_id i64) {
	blog_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	if !(var_blog_id != 0) {
		blog_id = (rt.call_function('get_current_blog_id', []rt.PhpVal{})).to_i64()
	}
	rt.call_function('clean_blog_cache', [rt.new_int(blog_id)])
}

fn update_blog_details(var_blog_id rt.PhpVal, var_details rt.PhpVal) bool {
	if !rt.is_true(var_details) {
		return false
	}
	if rt.is_true(rt.new_bool(var_details.dup().is_object())) {
		var_details = rt.call_function('get_object_vars', [var_details.dup()])
	}
	mut var_site := rt.call_function('wp_update_site', [var_blog_id.dup(), var_details.dup()])
	if rt.is_true(rt.call_function('is_wp_error', [var_site.dup()])) {
		return false
	}
	return true
}

fn clean_site_details_cache(site_id i64) {
	site_id = ().to_i64()
	if !(var_site_id != 0) {
		
	}
	
}

struct Class_WP_Site {
	rt.PhpObjectBase
}

fn create_wp_site() &Class_WP_Site {
	mut obj := &Class_WP_Site{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Site) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Site) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_ms_blogs_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))))) {
		// unsupported expression: Expr_Exit
	}
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/ms-site.php', '4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/ms-network.php', '4')
}

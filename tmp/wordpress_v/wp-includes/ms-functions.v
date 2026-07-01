import rt
import crypto.md5

fn get_sitestats() rt.PhpVal {
	mut var_stats := { 'blogs': get_blog_count(rt.new_null()), 'users': rt.call_function('get_user_count', []rt.PhpVal{}) }
	return var_stats.dup()
}

fn get_active_blog_for_user(var_user_id rt.PhpVal) rt.PhpVal {
	mut var_blogs := rt.call_function('get_blogs_of_user', [var_user_id.dup()])
	if !rt.is_true(var_blogs) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_multisite', []rt.PhpVal{}))))) {
		return var_blogs.array_get(rt.call_function('get_current_blog_id', []rt.PhpVal{}))
	}
	mut var_primary_blog := rt.call_function('get_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), rt.new_bool(true)])
	mut var_first_blog := rt.call_function('current', [var_blogs.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		if !(var_blogs.array_isset(var_primary_blog)) {
			rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), rt.get_property(var_first_blog, 'userblog_id')])
			mut var_primary := rt.call_function('get_site', [rt.get_property(var_first_blog, 'userblog_id')])
		} else {
			var_primary = rt.call_function('get_site', [var_primary_blog.dup()])
		}
	} else {
		mut var_result := rt.new_bool(rt.new_bool(add_user_to_blog(rt.get_property(var_first_blog, 'userblog_id'), var_user_id.dup(), rt.new_string('subscriber'))))
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_result.dup()]))))) {
			rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), rt.get_property(var_first_blog, 'userblog_id')])
			var_primary = var_first_blog.dup()
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_primary.dup().is_object()))))) || rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_primary, 'archived'))) || rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_primary, 'spam'))))) || rt.is_true(rt.identical(rt.new_string('1'), rt.get_property(var_primary, 'deleted'))))))) {
		var_blogs = rt.call_function('get_blogs_of_user', [var_user_id.dup(), rt.new_bool(true)])
		mut var_ret := rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_blogs.dup().is_array())) && var_blogs.dup().array_count() > 0)) {
			mut var_current_network_id := rt.call_function('get_current_network_id', []rt.PhpVal{})
			{
				mut iter_1 := rt.cast_array(var_blogs).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_blog := item_1.val
					mut var_blog_id := item_1.key
					if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
						continue
					}
					mut var_details := rt.call_function('get_site', [var_blog_id.dup()])
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_details.dup().is_object())) && rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_details, 'archived'))))) && rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_details, 'spam'))))) && rt.is_true(rt.identical(rt.new_string('0'), rt.get_property(var_details, 'deleted'))))) {
						var_ret = var_details.dup()
						if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
							rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), var_blog_id.dup()])
						}
						if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_meta', [var_user_id.dup(), rt.new_string('source_domain'), rt.new_bool(true)]))))) {
							rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('source_domain'), rt.get_property(var_details, 'domain')])
						}
						break
					}
				}
			}
		} else {
			return rt.new_null()
		}
		return var_ret.dup()
	} else {
		return var_primary.dup()
	}
	return rt.new_null()
}

fn get_blog_count(var_network_id rt.PhpVal) rt.PhpVal {
	return rt.call_function('get_network_option', [var_network_id.dup(), rt.new_string('blog_count')])
}

fn get_blog_post(var_blog_id rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	rt.call_function('switch_to_blog', [var_blog_id.dup()])
	mut var_post := rt.call_function('get_post', [var_post_id.dup()])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return var_post.dup()
}

fn add_user_to_blog(var_blog_id rt.PhpVal, var_user_id rt.PhpVal, var_role rt.PhpVal) bool {
	rt.call_function('switch_to_blog', [var_blog_id.dup()])
	mut var_user := rt.call_function('get_userdata', [var_user_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		return (create_wp_error(rt.new_string('user_does_not_exist'), rt.call_function('__', [rt.new_string('The requested user does not exist.')]))).to_bool()
	}
	mut var_can_add_user := rt.call_function('apply_filters', [rt.new_string('can_add_user_to_blog'), rt.new_bool(true), var_user_id.dup(), var_role.dup(), var_blog_id.dup()])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		if rt.is_true(rt.call_function('is_wp_error', [var_can_add_user.dup()])) {
			return (var_can_add_user).to_bool()
		}
		return (create_wp_error(rt.new_string('user_cannot_be_added'), rt.call_function('__', [rt.new_string('User cannot be added to this site.')]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), rt.new_bool(true)]))))) {
		rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), var_blog_id.dup()])
		mut var_site := rt.call_function('get_site', [var_blog_id.dup()])
		rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('source_domain'), rt.get_property(var_site, 'domain')])
	}
	rt.call_method(var_user, 'set_role', [var_role.dup()])
	rt.call_function('do_action', [rt.new_string('add_user_to_blog'), var_user_id.dup(), var_role.dup(), var_blog_id.dup()])
	rt.call_function('clean_user_cache', [var_user_id.dup()])
	rt.call_function('wp_cache_delete', [(var_blog_id).str() + '_user_count', rt.new_string('blog-details')])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return true
}

fn remove_user_from_blog(var_user_id rt.PhpVal, blog_id i64, reassign i64) bool {
	mut var_wpdb := rt.new_null()
	// unsupported statement: Stmt_Global
	var_user_id = // unsupported expression: Expr_Cast_Int
	blog_id = (// unsupported expression: Expr_Cast_Int).to_i64()
	rt.call_function('switch_to_blog', [rt.new_int(blog_id)])
	rt.call_function('do_action', [rt.new_string('remove_user_from_blog'), var_user_id.dup(), rt.new_int(blog_id), rt.new_int(reassign)])
	mut var_primary_blog := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.identical(var_primary_blog, rt.new_int(blog_id))) {
		mut var_new_id := rt.new_string(rt.new_string(''))
		mut var_new_domain := rt.new_string(rt.new_string(''))
		mut var_blogs := rt.call_function('get_blogs_of_user', [var_user_id.dup()])
		{
			mut iter_1 := rt.cast_array(var_blogs).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_blog := item_1.val
				if rt.is_true(rt.identical(rt.get_property(var_blog, 'userblog_id'), rt.new_int(blog_id))) {
					continue
				}
				var_new_id = rt.get_property(var_blog, 'userblog_id')
				var_new_domain = rt.get_property(var_blog, 'domain')
				break
			}
		}
		rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), var_new_id.dup()])
		rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('source_domain'), var_new_domain.dup()])
	}
	mut var_user := rt.call_function('get_userdata', [var_user_id.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_user)))) {
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		return (create_wp_error(rt.new_string('user_does_not_exist'), rt.call_function('__', [rt.new_string('That user does not exist.')]))).to_bool()
	}
	rt.call_method(var_user, 'remove_all_caps', []rt.PhpVal{})
	var_blogs = rt.call_function('get_blogs_of_user', [var_user_id.dup()])
	if var_blogs.dup().array_count() == 0 {
		rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('primary_blog'), rt.new_string('')])
		rt.call_function('update_user_meta', [var_user_id.dup(), rt.new_string('source_domain'), rt.new_string('')])
	}
	if var_reassign != 0 {
		reassign = (// unsupported expression: Expr_Cast_Int).to_i64()
		mut var_post_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT ID FROM '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' WHERE post_author = %d')), var_user_id.dup()])])
		mut var_link_ids := rt.call_method(var_wpdb, 'get_col', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT link_id FROM '), rt.get_property(var_wpdb, 'links')), rt.new_string(' WHERE link_owner = %d')), var_user_id.dup()])])
		if !(!rt.is_true(var_post_ids)) {
			rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'posts')), rt.new_string(' SET post_author = %d WHERE post_author = %d')), rt.new_int(reassign), var_user_id.dup()])])
			rt.call_function('array_walk', [var_post_ids.dup(), rt.new_string('clean_post_cache')])
		}
		if !(!rt.is_true(var_link_ids)) {
			rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('UPDATE '), rt.get_property(var_wpdb, 'links')), rt.new_string(' SET link_owner = %d WHERE link_owner = %d')), rt.new_int(reassign), var_user_id.dup()])])
			rt.call_function('array_walk', [var_link_ids.dup(), rt.new_string('clean_bookmark_cache')])
		}
	}
	rt.call_function('clean_user_cache', [var_user_id.dup()])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return true
}

fn get_blog_permalink(var_blog_id rt.PhpVal, var_post_id rt.PhpVal) rt.PhpVal {
	rt.call_function('switch_to_blog', [var_blog_id.dup()])
	mut var_link := rt.call_function('get_permalink', [var_post_id.dup()])
	rt.call_function('restore_current_blog', []rt.PhpVal{})
	return var_link.dup()
}

fn get_blog_id_from_url(var_domain rt.PhpVal, path string) i64 {
	var_domain = var_domain.to_lower()
	path = path.to_lower()
	mut var_id := rt.call_function('wp_cache_get', [rt.new_string(md5.hexhash( + )), rt.new_string('blog-id-cache')])
	if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_id)) {
		return 0
	} else if rt.is_true(var_id) {
		return (// unsupported expression: Expr_Cast_Int).to_i64()
	}
	mut var_args := 
	
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
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




pub fn init_wp_includes_ms_functions_php() {
}

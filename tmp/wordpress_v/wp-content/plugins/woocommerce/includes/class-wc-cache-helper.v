import rt
import crypto.md5

struct Class_WC_Cache_Helper {
	rt.PhpObjectBase
pub mut:
		delete_transients rt.PhpVal = rt.new_array()
}

fn Class_WC_Cache_Helper.init()  {
	rt.call_function('add_action', [rt.new_string('wp_headers'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'prevent_caching' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('shutdown'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_transients_on_shutdown' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('template_redirect'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'geolocation_ajax_redirect' }])])
	rt.call_function('add_action', [rt.new_string('wc_ajax_update_order_review'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'update_geolocation_hash' }]), rt.new_int(5)])
	rt.call_function('add_action', [rt.new_string('admin_notices'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'notices' }])])
	rt.call_function('add_action', [rt.new_string('delete_version_transients'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'delete_version_transients' }]), rt.new_int(10)])
	rt.call_function('add_action', [rt.new_string('clean_term_cache'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clean_term_cache' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_action', [rt.new_string('edit_terms'), rt.create_array([rt.ArrayItem{ key: none, val: @STRUCT }, rt.ArrayItem{ key: none, val: 'clean_term_cache' }]), rt.new_int(10), rt.new_int(2)])
}

fn Class_WC_Cache_Helper.prevent_caching(var_headers rt.PhpVal) rt.PhpVal {
	mut var_headers_mutated := var_headers
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_blog_installed', []rt.PhpVal{}))))) {
		return var_headers_mutated.dup()
	}
	mut var_page_ids := rt.call_function('array_filter', [rt.create_array([rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('cart')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('checkout')]) }, rt.ArrayItem{ key: none, val: rt.call_function('wc_get_page_id', [rt.new_string('myaccount')]) }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_page', [var_page_ids.dup()]))))) {
		return var_headers_mutated.dup()
	}
	Class_WC_Cache_Helper.set_nocache_constants()
	if var_headers_mutated.array_isset(rt.new_string('Cache-Control')) {
		mut var_old_directives := rt.call_function('preg_split', [rt.new_string('/\\s*,\\s*/'), rt.new_string(var_headers_mutated.array_get('Cache-Control').to_string().trim_space())])
	} else {
		var_old_directives = rt.new_array()
	}
	mut var_nocache_headers := rt.call_function('wp_get_nocache_headers', []rt.PhpVal{})
	if var_nocache_headers.array_isset(rt.new_string('Cache-Control')) {
		mut var_new_directives := rt.call_function('preg_split', [rt.new_string('/\\s*,\\s*/'), rt.new_string(var_nocache_headers.array_get('Cache-Control').to_string().trim_space())])
	} else {
		var_new_directives = rt.new_array()
	}
	var_headers_mutated = rt.call_function('array_merge', [var_headers_mutated.dup(), var_nocache_headers.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
		var_new_directives = rt.call_function('array_diff', [var_new_directives.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'no-store' }])])
	}
	var_headers_mutated.array_set('Cache-Control', rt.call_function('implode', [rt.new_string(', '), rt.call_function('array_unique', [rt.call_function('array_merge', [var_old_directives.dup(), var_new_directives.dup()])])]))
	return var_headers_mutated.dup()
}

fn Class_WC_Cache_Helper.queue_delete_transient(var_keys rt.PhpVal)  {
	// unsupported assign target: Expr_StaticPropertyFetch
}

fn Class_WC_Cache_Helper.delete_transients_on_shutdown()  {
	if rt.is_true(// unsupported expression: Expr_StaticPropertyFetch) {
		{
			mut iter_1 := // unsupported expression: Expr_StaticPropertyFetch.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_key := item_1.val
				rt.call_function('delete_transient', [var_key.dup()])
			}
		}
		// unsupported assign target: Expr_StaticPropertyFetch
	}
}

fn Class_WC_Cache_Helper.invalidate_attribute_count(var_attribute_keys rt.PhpVal)  {
	if rt.is_true(var_attribute_keys) {
		{
			mut iter_1 := var_attribute_keys.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_attribute_key := item_1.val
				Class_WC_Cache_Helper.queue_delete_transient(rt.new_string('wc_layered_nav_counts_' + (var_attribute_key).str()))
			}
		}
	}
}

fn Class_WC_Cache_Helper.geolocation_ajax_get_location_hash() rt.PhpVal {
	mut var_customer := create_wc_customer(rt.new_int(0), rt.new_bool(true))
	mut var_location := rt.new_array()
	var_location['country'] = var_customer.get_billing_country()
	var_location['state'] = var_customer.get_billing_state()
	var_location['postcode'] = var_customer.get_billing_postcode()
	var_location['city'] = var_customer.get_billing_city()
	mut var_location_hash := rt.call_function('substr', [rt.new_string(md5.hexhash(rt.call_function('implode', [rt.new_string(''), var_location.dup()]).to_string().to_lower())), rt.new_int(0), rt.new_int(12)])
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_geolocation_ajax_get_location_hash'), var_location_hash.dup(), var_location.dup(), var_customer])
}

fn Class_WC_Cache_Helper.geolocation_ajax_redirect()  {
	mut var_wp := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax(), rt.call_function('get_option', [rt.new_string('woocommerce_default_customer_address')]))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_checkout', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_cart', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_account_page', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_robots', []rt.PhpVal{}))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_doing_ajax', []rt.PhpVal{}))))))) && !rt.is_true(rt.get_superglobal('_POST')))) {
		mut var_location_hash := Class_WC_Cache_Helper.geolocation_ajax_get_location_hash()
		mut var_current_hash := if rt.get_superglobal('_GET').array_isset(rt.new_string('v')) { rt.call_function('wc_clean', [rt.call_function('wp_unslash', [rt.get_superglobal('_GET').array_get('v')])]) } else { rt.new_string('') }
		if rt.is_true(rt.new_bool(!rt.is_true(var_current_hash) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			// unsupported statement: Stmt_Global
			mut var_redirect_url := rt.call_function('trailingslashit', [rt.call_function('home_url', [rt.get_property(var_wp, 'request')])])
			if !(!rt.is_true(rt.get_superglobal('_SERVER').array_get('QUERY_STRING'))) {
				var_redirect_url = rt.call_function('add_query_arg', [rt.call_function('wp_unslash', [rt.get_superglobal('_SERVER').array_get('QUERY_STRING')]), rt.new_string(''), var_redirect_url.dup()])
				// unsupported statement: Stmt_Nop
			}
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_option', [rt.new_string('permalink_structure')]))))) {
				var_redirect_url = rt.call_function('add_query_arg', [rt.get_property(var_wp, 'query_string'), rt.new_string(''), var_redirect_url.dup()])
			}
			var_redirect_url = rt.call_function('add_query_arg', [rt.new_string('v'), var_location_hash.dup(), rt.call_function('remove_query_arg', [rt.create_array([rt.ArrayItem{ key: none, val: 'v' }, rt.ArrayItem{ key: none, val: 'add-to-cart' }]), var_redirect_url.dup()])])
			rt.call_function('wp_safe_redirect', [rt.call_function('esc_url_raw', [var_redirect_url.dup()]), rt.new_int(307)])
			// unsupported expression: Expr_Exit
		}
	}
}

fn Class_WC_Cache_Helper.update_geolocation_hash()  {
	if rt.is_true(rt.identical(Class_Automattic_WooCommerce_Enums_DefaultCustomerAddress.geolocation_ajax(), rt.call_function('get_option', [rt.new_string('woocommerce_default_customer_address')]))) {
		rt.call_function('wc_setcookie', [rt.new_string('woocommerce_geo_hash'), Class_WC_Cache_Helper.geolocation_ajax_get_location_hash(), rt.add(rt.call_function('time', []rt.PhpVal{}), rt.get_constant('HOUR_IN_SECONDS'))])
	}
}

fn Class_WC_Cache_Helper.get_transient_version(var_group rt.PhpVal, refresh bool) rt.PhpVal {
	mut var_transient_name := rt.new_string((var_group).str() + '-transient-version')
	mut var_transient_value := rt.call_function('get_transient', [var_transient_name.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), var_transient_value)) || rt.is_true(rt.identical(rt.new_bool(true), rt.new_bool(refresh))))) {
		var_transient_value = // unsupported expression: Expr_Cast_String
		rt.call_function('set_transient', [var_transient_name.dup(), var_transient_value.dup()])
	}
	return var_transient_value.dup()
}

fn Class_WC_Cache_Helper.set_nocache_constants(return bool) rt.PhpVal {
	rt.call_function('wc_maybe_define_constant', [rt.new_string('DONOTCACHEPAGE'), rt.new_bool(true)])
	rt.call_function('wc_maybe_define_constant', [rt.new_string('DONOTCACHEOBJECT'), rt.new_bool(true)])
	rt.call_function('wc_maybe_define_constant', [rt.new_string('DONOTCACHEDB'), rt.new_bool(true)])
	return rt.new_bool(return)
}

fn Class_WC_Cache_Helper.notices()  {
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('w3tc_pgcache_flush')]))))) || rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [rt.new_string('w3_instance')]))))))) {
		return rt.new_null()
	}
	mut var_config := rt.call_function('w3_instance', [rt.new_string('W3_Config')])
	mut var_enabled := rt.call_method(var_config, 'get_integer', [rt.new_string('dbcache.enabled')])
	mut var_settings := rt.call_function('array_map', [rt.new_string('trim'), rt.call_method(var_config, 'get_array', [rt.new_string('dbcache.reject.sql')])])
	if rt.is_true(rt.new_bool(rt.is_true(var_enabled) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.new_string('_wc_session_'), var_settings.dup(), rt.new_bool(true)]))))))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('In order for <strong>database caching</strong> to work with WooCommerce you must add %1$s to the "Ignored Query Strings" option in <a href="%2$s">W3 Total Cache settings</a>.'), rt.new_string('woocommerce')]), rt.new_string('<code>_wc_session_</code>'), rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('admin.php?page=w3tc_dbcache')])])])]))
		// unsupported statement: Stmt_InlineHTML
	}
}

fn Class_WC_Cache_Helper.clean_term_cache(var_ids rt.PhpVal, var_taxonomy rt.PhpVal)  {
	mut var_ids_mutated := var_ids
	if rt.is_true(rt.identical(rt.new_string('product_cat'), var_taxonomy)) {
		var_ids_mutated = if rt.is_true(rt.new_bool(var_ids_mutated.dup().is_array())) { var_ids_mutated } else { rt.create_array([rt.ArrayItem{ key: none, val: var_ids_mutated }]) }
		mut var_clear_ids := rt.create_array([rt.ArrayItem{ key: none, val: 0 }])
		{
			mut iter_1 := var_ids_mutated.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_id := item_1.val
				var_clear_ids.array_push(var_id.dup())
				var_clear_ids = rt.call_function('array_merge', [var_clear_ids.dup(), rt.call_function('get_ancestors', [var_id.dup(), rt.new_string('product_cat'), rt.new_string('taxonomy')])])
			}
		}
		var_clear_ids = rt.call_function('array_unique', [var_clear_ids.dup()])
		{
			mut iter_1 := var_clear_ids.iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_id := item_1.val
				rt.call_function('wp_cache_delete', ['product-category-hierarchy-' + (var_id).str(), rt.new_string('product_cat')])
			}
		}
	}
}

fn Class_WC_Cache_Helper.delete_version_transients(version string)  {
	mut var_wpdb := rt.new_null()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{}))))) && !(version == ''))) {
		// unsupported statement: Stmt_Global
		mut var_limit := rt.call_function('apply_filters', [rt.new_string('woocommerce_delete_version_transients_limit'), rt.new_int(1000)])
		if rt.is_true(rt.new_bool(!(rt.is_true(var_limit)))) {
			return rt.new_null()
		}
		mut var_affected := rt.call_method(var_wpdb, 'query', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('DELETE FROM '), rt.get_property(var_wpdb, 'options')), rt.new_string(' WHERE option_name LIKE %s LIMIT %d;')), '\\_transient\\_%' + version, var_limit.dup()])])
		if rt.is_true(rt.identical(var_affected, var_limit)) {
			rt.call_function('wp_schedule_single_event', [rt.add(rt.call_function('time', []rt.PhpVal{}), rt.new_int(30)), rt.new_string('delete_version_transients'), rt.create_array([rt.ArrayItem{ key: none, val: version }])])
		}
	}
}

struct Class_WC_Customer {
	rt.PhpObjectBase
}

fn create_wc_cache_helper() &Class_WC_Cache_Helper {
	mut obj := &Class_WC_Cache_Helper{
		PhpObjectBase: rt.PhpObjectBase{}
		delete_transients: rt.new_array()
	}
	return obj
}

fn create_wc_customer() &Class_WC_Customer {
	mut obj := &Class_WC_Customer{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Cache_Helper) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			Class_WC_Cache_Helper.init()
			return rt.new_null()
		}
		'prevent_caching' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WC_Cache_Helper.prevent_caching(dispatch_arg_0)
		}
		'queue_delete_transient' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Cache_Helper.queue_delete_transient(dispatch_arg_0)
			return rt.new_null()
		}
		'delete_transients_on_shutdown' {
			Class_WC_Cache_Helper.delete_transients_on_shutdown()
			return rt.new_null()
		}
		'invalidate_attribute_count' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			Class_WC_Cache_Helper.invalidate_attribute_count(dispatch_arg_0)
			return rt.new_null()
		}
		'geolocation_ajax_get_location_hash' {
			return Class_WC_Cache_Helper.geolocation_ajax_get_location_hash()
		}
		'geolocation_ajax_redirect' {
			Class_WC_Cache_Helper.geolocation_ajax_redirect()
			return rt.new_null()
		}
		'update_geolocation_hash' {
			Class_WC_Cache_Helper.update_geolocation_hash()
			return rt.new_null()
		}
		'get_transient_version' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return Class_WC_Cache_Helper.get_transient_version(dispatch_arg_0, dispatch_arg_1)
		}
		'set_nocache_constants' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return Class_WC_Cache_Helper.set_nocache_constants(dispatch_arg_0)
		}
		'notices' {
			Class_WC_Cache_Helper.notices()
			return rt.new_null()
		}
		'clean_term_cache' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			Class_WC_Cache_Helper.clean_term_cache(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'delete_version_transients' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			Class_WC_Cache_Helper.delete_version_transients(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WC_Cache_Helper) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'delete_transients' { return this.delete_transients }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Cache_Helper) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'delete_transients' { this.delete_transients = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WC_Customer) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Customer) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Customer) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_woocommerce_includes_class_wc_cache_helper_php() {
	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(// unsupported expression: Expr_Exit))
	Class_WC_Cache_Helper.init()
}

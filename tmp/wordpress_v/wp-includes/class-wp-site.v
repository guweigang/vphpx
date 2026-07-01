import rt

struct Class_WP_Site {
	rt.PhpObjectBase
pub mut:
		blog_id rt.PhpVal = rt.new_null()
		domain rt.PhpVal = rt.new_string('')
		path rt.PhpVal = rt.new_string('')
		site_id rt.PhpVal = rt.new_string('0')
		registered rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
		last_updated rt.PhpVal = rt.new_string('0000-00-00 00:00:00')
		public rt.PhpVal = rt.new_string('1')
		archived rt.PhpVal = rt.new_string('0')
		mature rt.PhpVal = rt.new_string('0')
		spam rt.PhpVal = rt.new_string('0')
		deleted rt.PhpVal = rt.new_string('0')
		lang_id rt.PhpVal = rt.new_string('0')
}

fn Class_WP_Site.get_instance(var_site_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_site_id_mutated := var_site_id
	// unsupported statement: Stmt_Global
	var_site_id_mutated = // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_site_id_mutated)))) {
		return false
	}
	mut var__site := rt.call_function('wp_cache_get', [var_site_id_mutated.dup(), rt.new_string('sites')])
	if rt.is_true(rt.identical(rt.new_bool(false), var__site)) {
		var__site = rt.call_method(var_wpdb, 'get_row', [rt.call_method(var_wpdb, 'prepare', [rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb, 'blogs')), rt.new_string(' WHERE blog_id = %d LIMIT 1')), var_site_id_mutated.dup()])])
		if rt.is_true(rt.new_bool(!rt.is_true(var__site) || rt.is_true(rt.call_function('is_wp_error', [var__site.dup()])))) {
			var__site = // unsupported expression: Expr_UnaryMinus
		}
		rt.call_function('wp_cache_add', [var_site_id_mutated.dup(), var__site.dup(), rt.new_string('sites')])
	}
	if rt.is_true(rt.new_bool(var__site.dup().is_long() || var__site.dup().is_double())) {
		return false
	}
	return (create_wp_site(var__site.dup())).to_bool()
}

fn (mut this Class_WP_Site) construct(var_site rt.PhpVal)  {
	{
		mut iter_1 := rt.call_function('get_object_vars', [var_site.dup()]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":197,"name":"key"}', var_value.dup())
		}
	}
}

fn (mut this Class_WP_Site) to_array() rt.PhpVal {
	return rt.call_function('get_object_vars', [rt.new_object('WP_Site', []string{}, &this)])
}

fn (mut this Class_WP_Site) magic_get(var_key rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		return // unsupported expression: Expr_Cast_Int
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('network_id'))) {
		return // unsupported expression: Expr_Cast_Int
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('ms_loaded')]))))) {
			return rt.new_null()
		}
		mut var_details := this.get_details()
		if !(rt.get_property(var_details, '{"nodeType":"Expr_Variable","line":239,"name":"key"}')).is_null() {
			return rt.get_property(var_details, '{"nodeType":"Expr_Variable","line":240,"name":"key"}')
		}
	}
	return rt.new_null()
}

fn (mut this Class_WP_Site) magic_isset(var_key rt.PhpVal) bool {
	mut switch_val_2 := var_key
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('id'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('network_id'))) {
		return true
	} else if rt.is_true(rt.equal(switch_val_2, rt.new_string('blogname'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('siteurl'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('post_count'))) || rt.is_true(rt.equal(switch_val_2, rt.new_string('home'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('ms_loaded')]))))) {
			return false
		}
		return true
	} else {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('did_action', [rt.new_string('ms_loaded')]))))) {
			return false
		}
		mut var_details := this.get_details()
		if !(rt.get_property(var_details, '{"nodeType":"Expr_Variable","line":277,"name":"key"}')).is_null() {
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Site) magic_set(var_key rt.PhpVal, var_value rt.PhpVal)  {
	mut switch_val_3 := var_key
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('id'))) {
		this.blog_id = // unsupported expression: Expr_Cast_String
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('network_id'))) {
		this.site_id = // unsupported expression: Expr_Cast_String
	} else {
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":304,"name":"key"}', var_value.dup())
	}
}

fn (mut this Class_WP_Site) get_details() rt.PhpVal {
	mut var_details := rt.call_function('wp_cache_get', [this.blog_id, rt.new_string('site-details')])
	if rt.is_true(rt.identical(rt.new_bool(false), var_details)) {
		rt.call_function('switch_to_blog', [this.blog_id])
		var_details = create_stdclass()
		{
			mut iter_1 := rt.call_function('get_object_vars', [rt.new_object('WP_Site', []string{}, &this)]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_value := item_1.val
				mut var_key := item_1.key
				rt.set_property(var_details, '{"nodeType":"Expr_Variable","line":328,"name":"key"}', var_value.dup())
			}
		}
		rt.set_property(var_details, 'blogname', rt.call_function('get_option', [rt.new_string('blogname')]))
		rt.set_property(var_details, 'siteurl', rt.call_function('get_option', [rt.new_string('siteurl')]))
		rt.set_property(var_details, 'post_count', rt.call_function('get_option', [rt.new_string('post_count')]))
		rt.set_property(var_details, 'home', rt.call_function('get_option', [rt.new_string('home')]))
		rt.call_function('restore_current_blog', []rt.PhpVal{})
		rt.call_function('wp_cache_set', [this.blog_id, var_details.dup(), rt.new_string('site-details')])
	}
	var_details = rt.call_function('apply_filters_deprecated', [rt.new_string('blog_details'), rt.create_array([rt.ArrayItem{ key: none, val: var_details }]), rt.new_string('4.7.0'), rt.new_string('site_details')])
	var_details = rt.call_function('apply_filters', [rt.new_string('site_details'), var_details.dup()])
	return var_details.dup()
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_site(arg_0 rt.PhpVal) &Class_WP_Site {
	mut obj := &Class_WP_Site{
		PhpObjectBase: rt.PhpObjectBase{}
		blog_id: rt.new_null()
		domain: rt.new_string('')
		path: rt.new_string('')
		site_id: rt.new_string('0')
		registered: rt.new_string('0000-00-00 00:00:00')
		last_updated: rt.new_string('0000-00-00 00:00:00')
		public: rt.new_string('1')
		archived: rt.new_string('0')
		mature: rt.new_string('0')
		spam: rt.new_string('0')
		deleted: rt.new_string('0')
		lang_id: rt.new_string('0')
	}
	obj.construct(arg_0)
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Site) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Site.get_instance(dispatch_arg_0))
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'to_array' {
			return this.to_array()
		}
		'__get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.magic_get(dispatch_arg_0)
		}
		'__isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.magic_isset(dispatch_arg_0))
		}
		'__set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.magic_set(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'get_details' {
			return this.get_details()
		}
		else { return none }
	}
}

fn (this &Class_WP_Site) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'blog_id' { return this.blog_id }
		'domain' { return this.domain }
		'path' { return this.path }
		'site_id' { return this.site_id }
		'registered' { return this.registered }
		'last_updated' { return this.last_updated }
		'public' { return this.public }
		'archived' { return this.archived }
		'mature' { return this.mature }
		'spam' { return this.spam }
		'deleted' { return this.deleted }
		'lang_id' { return this.lang_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Site) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'blog_id' { this.blog_id = val; return true }
		'domain' { this.domain = val; return true }
		'path' { this.path = val; return true }
		'site_id' { this.site_id = val; return true }
		'registered' { this.registered = val; return true }
		'last_updated' { this.last_updated = val; return true }
		'public' { this.public = val; return true }
		'archived' { this.archived = val; return true }
		'mature' { this.mature = val; return true }
		'spam' { this.spam = val; return true }
		'deleted' { this.deleted = val; return true }
		'lang_id' { this.lang_id = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_site_php() {
}

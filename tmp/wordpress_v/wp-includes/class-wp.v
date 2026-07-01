import rt

struct Class_WP {
	rt.PhpObjectBase
pub mut:
		public_query_vars rt.PhpVal = rt.new_array()
		private_query_vars rt.PhpVal = rt.new_array()
		extra_query_vars rt.PhpVal = rt.new_array()
		query_vars rt.PhpVal = rt.new_array()
		query_string rt.PhpVal = rt.new_string('')
		request rt.PhpVal = rt.new_string('')
		matched_rule rt.PhpVal = rt.new_string('')
		matched_query rt.PhpVal = rt.new_string('')
		did_permalink bool
}

fn (mut this Class_WP) add_query_var(var_qv rt.PhpVal)  {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_qv.dup(), this.public_query_vars, rt.new_bool(true)]))))) {
		this.public_query_vars.array_push(var_qv.dup())
	}
}

fn (mut this Class_WP) remove_query_var(var_name rt.PhpVal)  {
	this.public_query_vars = rt.call_function('array_diff', [this.public_query_vars, rt.create_array([rt.ArrayItem{ key: none, val: var_name }])])
}

fn (mut this Class_WP) set_query_var(var_key rt.PhpVal, var_value rt.PhpVal)  {
	this.query_vars.array_set(var_key, var_value.dup())
}

fn (mut this Class_WP) parse_request(extra_query_vars string) bool {
	mut var_wp_rewrite := rt.new_null()
	mut var_varmatch := []rt.PhpVal{}
	mut var_perma_query_vars := rt.new_null()
	// unsupported statement: Stmt_Global
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('apply_filters', [rt.new_string('do_parse_request'), rt.new_bool(true), rt.new_object('WP', []string{}, &this), rt.new_string(extra_query_vars)]))))) {
		return false
	}
	this.query_vars = rt.new_array()
	mut var_post_type_query_vars := rt.new_array()
	if rt.is_true(rt.new_bool(rt.new_string(extra_query_vars).is_array())) {
		// unsupported expression: Expr_AssignRef
	} else if !(extra_query_vars == '') {
		rt.call_function('parse_str', [rt.new_string(extra_query_vars), this.extra_query_vars])
	}
	mut var_rewrite := rt.call_method(var_wp_rewrite, 'wp_rewrite_rules', []rt.PhpVal{})
	if !(!rt.is_true(var_rewrite)) {
		mut var_error := rt.new_string(rt.new_string('404'))
		this.did_permalink = true
		mut var_pathinfo := if !(rt.get_superglobal('_SERVER').array_get('PATH_INFO')).is_null() { rt.get_superglobal('_SERVER').array_get('PATH_INFO') } else { rt.new_string('') }
		// unsupported assign target: Expr_List
		var_pathinfo = rt.call_function('str_replace', [rt.new_string('%'), rt.new_string('%25'), var_pathinfo.dup()])
		// unsupported assign target: Expr_List
		mut var_self := rt.get_superglobal('_SERVER').array_get('PHP_SELF')
		mut var_home_path := rt.call_function('parse_url', [rt.call_function('home_url', []rt.PhpVal{}), rt.get_constant('PHP_URL_PATH')])
		mut var_home_path_regex := rt.new_string(rt.new_string(''))
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_home_path.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			var_home_path = rt.new_string(rt.new_string(var_home_path.dup().to_string().trim_space()))
			var_home_path_regex = rt.call_function('sprintf', [rt.new_string('|^%s|i'), rt.call_function('preg_quote', [var_home_path.dup(), rt.new_string('|')])])
		}
		mut var_req_uri := rt.call_function('str_replace', [var_pathinfo.dup(), rt.new_string(''), var_req_uri.dup()])
		var_req_uri = rt.new_string(rt.new_string(var_req_uri.dup().to_string().trim_space()))
		var_pathinfo = rt.new_string(rt.new_string(var_pathinfo.dup().to_string().trim_space()))
		var_self = rt.new_string(rt.new_string(var_self.dup().to_string().trim_space()))
		if !(!rt.is_true(var_home_path_regex)) {
			var_req_uri = rt.call_function('preg_replace', [var_home_path_regex.dup(), rt.new_string(''), var_req_uri.dup()])
			var_req_uri = rt.new_string(rt.new_string(var_req_uri.dup().to_string().trim_space()))
			var_pathinfo = rt.call_function('preg_replace', [var_home_path_regex.dup(), rt.new_string(''), var_pathinfo.dup()])
			var_pathinfo = rt.new_string(rt.new_string(var_pathinfo.dup().to_string().trim_space()))
			var_self = rt.call_function('preg_replace', [var_home_path_regex.dup(), rt.new_string(''), var_self.dup()])
			var_self = rt.new_string(rt.new_string(var_self.dup().to_string().trim_space()))
		}
		if rt.is_true(rt.new_bool(!(!rt.is_true(var_pathinfo)) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', ['|^.*' + (rt.get_property(var_wp_rewrite, 'index')).str() + '$|', var_pathinfo.dup()]))))))) {
			mut var_requested_path := var_pathinfo.dup()
		} else {
			if rt.is_true(rt.identical(var_req_uri, rt.get_property(var_wp_rewrite, 'index'))) {
				var_req_uri = rt.new_string(rt.new_string(''))
			}
			var_requested_path = var_req_uri.dup()
		}
		mut var_requested_file := var_req_uri.dup()
		this.request = var_requested_path.dup()
		mut var_request_match := var_requested_path.dup()
		if !rt.is_true(var_request_match) {
			if var_rewrite.array_isset(rt.new_string('$')) {
				this.matched_rule = rt.new_string('$')
				mut var_query := var_rewrite.array_get('$')
				mut var_matches := rt.create_array([rt.ArrayItem{ key: none, val: '' }])
			}
		} else {
			{
				mut iter_1 := rt.cast_array(var_rewrite).iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_query_shadow := item_1.val
					mut var_match := item_1.key
					if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(!rt.is_true(var_requested_file)) && rt.is_true(rt.call_function('str_starts_with', [var_match.dup(), var_requested_file.dup()])))) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
						var_request_match = rt.new_string((var_requested_file).str() + '/' + (var_requested_path).str())
					}
					if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('preg_match', [rt.new_string("#^${var_match.to_string()}#"), var_request_match.dup(), var_matches.dup()])) || rt.is_true(rt.call_function('preg_match', [rt.new_string("#^${var_match.to_string()}#"), rt.call_function('urldecode', [var_request_match.dup()]), var_matches.dup()])))) {
						if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_wp_rewrite, 'use_verbose_page_rules')) && rt.is_true(rt.call_function('preg_match', [rt.new_string('/pagename=\\$matches\\[([0-9]+)\\]/'), var_query_shadow.dup(), var_varmatch.dup()])))) {
							mut var_page := rt.call_function('get_page_by_path', [var_matches.array_get(var_varmatch.array_get(1))])
							if rt.is_true(rt.new_bool(!(rt.is_true(var_page)))) {
								continue
							}
							mut var_post_status_obj := rt.call_function('get_post_status_object', [rt.get_property(var_page, 'post_status')])
							if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'public'))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'protected'))))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(var_post_status_obj, 'private'))))))) && rt.is_true(rt.get_property(var_post_status_obj, 'exclude_from_search')))) {
								continue
							}
						}
						this.matched_rule = var_match.dup()
						break
					}
				}
			}
		}
		if !(!rt.is_true(this.matched_rule)) {
			var_query = rt.call_function('preg_replace', [rt.new_string('!^.+\\?!'), rt.new_string(''), var_query.dup()])
			var_query = rt.call_function('addslashes', [fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_MatchesMapRegex{}; return temp.apply(arg_0, arg_1) }(var_query.dup(), var_matches.dup())])
			this.matched_query = var_query.dup()
			rt.call_function('parse_str', [var_query.dup(), var_perma_query_vars.dup()])
			if rt.is_true(rt.identical(rt.new_string('404'), var_error)) {
				var_error = rt.new_null()
				rt.get_superglobal('_GET').array_unset(rt.new_string('error'))
			}
		}
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(var_requested_path) || rt.is_true(rt.identical(var_requested_file, var_self)))) || rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('PHP_SELF'), rt.new_string('wp-admin/')])))) {
			var_error = rt.new_null()
			rt.get_superglobal('_GET').array_unset(rt.new_string('error'))
			if rt.is_true(rt.new_bool(!(var_perma_query_vars).is_null() && rt.is_true(rt.call_function('str_contains', [rt.get_superglobal('_SERVER').array_get('PHP_SELF'), rt.new_string('wp-admin/')])))) {
				var_perma_query_vars = rt.new_null()
			}
			this.did_permalink = false
		}
	}
	this.public_query_vars = rt.call_function('apply_filters', [rt.new_string('query_vars'), this.public_query_vars])
	{
		mut iter_1 := rt.call_function('get_post_types', [rt.new_array(), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_t := item_1.val
			mut var_post_type := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_post_type_viewable', [var_t.dup()])) && rt.is_true(rt.get_property(var_t, 'query_var')))) {
				var_post_type_query_vars.array_set(rt.get_property(var_t, 'query_var'), var_post_type.dup())
			}
		}
	}
	{
		mut iter_1 := this.public_query_vars.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_wpvar := item_1.val
			if this.extra_query_vars.array_isset(var_wpvar) {
				this.query_vars.array_set(var_wpvar, this.extra_query_vars.array_get(var_wpvar))
			} else if rt.is_true(rt.new_bool(rt.get_superglobal('_GET').array_isset(var_wpvar) && rt.get_superglobal('_POST').array_isset(var_wpvar) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
				rt.call_function('wp_die', [rt.call_function('__', [rt.new_string('A variable mismatch has been detected.')]), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view this item.')]), rt.new_int(400)])
			} else if rt.get_superglobal('_POST').array_isset(var_wpvar) {
				this.query_vars.array_set(var_wpvar, rt.get_superglobal('_POST').array_get(var_wpvar))
			} else if rt.get_superglobal('_GET').array_isset(var_wpvar) {
				this.query_vars.array_set(var_wpvar, rt.get_superglobal('_GET').array_get(var_wpvar))
			} else if var_perma_query_vars.array_isset(var_wpvar) {
				this.query_vars.array_set(var_wpvar, var_perma_query_vars.array_get(var_wpvar))
			}
			if !(!rt.is_true(this.query_vars.array_get(var_wpvar))) {
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.query_vars.array_get(var_wpvar).is_array()))))) {
					this.query_vars.array_set(var_wpvar, // unsupported expression: Expr_Cast_String)
				} else {
					{
						mut iter_2 := this.query_vars.array_get(var_wpvar).iterator()
						for {
							item_2 := iter_2.next() or { break }
							mut var_v := item_2.val
							mut var_vkey := item_2.key
							if rt.is_true(rt.call_function('is_scalar', [var_v.dup()])) {
								this.query_vars.array_get_mut(var_wpvar).array_set(var_vkey, // unsupported expression: Expr_Cast_String)
							}
						}
					}
				}
				if var_post_type_query_vars.array_isset(var_wpvar) {
					this.query_vars.array_set('post_type', var_post_type_query_vars.array_get(var_wpvar))
					this.query_vars.array_set('name', this.query_vars.array_get(var_wpvar))
				}
			}
		}
	}
	{
		mut iter_1 := rt.call_function('get_taxonomies', [rt.new_array(), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_t := item_1.val
			mut var_taxonomy := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(var_t, 'query_var')) && this.query_vars.array_isset(rt.get_property(var_t, 'query_var')))) {
				this.query_vars.array_set(rt.get_property(var_t, 'query_var'), rt.call_function('str_replace', [rt.new_string(' '), rt.new_string('+'), this.query_vars.array_get(rt.get_property(var_t, 'query_var'))]))
			}
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_admin', []rt.PhpVal{}))))) {
		{
			mut iter_1 := rt.call_function('get_taxonomies', [rt.create_array([rt.ArrayItem{ key: 'publicly_queryable', val: false }]), rt.new_string('objects')]).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_t := item_1.val
				mut var_taxonomy := item_1.key
				if rt.is_true(rt.new_bool(this.query_vars.array_isset(rt.new_string('taxonomy')) && rt.is_true(rt.identical(var_taxonomy, this.query_vars.array_get('taxonomy'))))) {
					this.query_vars.array_unset(rt.new_string('taxonomy'))
					this.query_vars.array_unset(rt.new_string('term'))
				}
			}
		}
	}
	if this.query_vars.array_isset(rt.new_string('post_type')) {
		mut var_queryable_post_types := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'publicly_queryable', val: true }])])
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(this.query_vars.array_get('post_type').is_array()))))) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [this.query_vars.array_get('post_type'), var_queryable_post_types.dup(), rt.new_bool(true)]))))) {
				this.query_vars.array_unset(rt.new_string('post_type'))
			}
		} else {
			this.query_vars.array_set('post_type', rt.call_function('array_intersect', [this.query_vars.array_get('post_type'), var_queryable_post_types.dup()]))
		}
	}
	this.query_vars = rt.call_function('wp_resolve_numeric_slug_conflicts', [this.query_vars])
	{
		mut iter_1 := rt.cast_array(this.private_query_vars).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_var := item_1.val
			if this.extra_query_vars.array_isset(var_var) {
				this.query_vars.array_set(var_var, this.extra_query_vars.array_get(var_var))
			}
		}
	}
	if !(var_error).is_null() {
		this.query_vars.array_set('error', var_error.dup())
	}
	this.query_vars = rt.call_function('apply_filters', [rt.new_string('request'), this.query_vars])
	rt.call_function('do_action_ref_array', [rt.new_string('parse_request'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP', []string{}, &this) }])])
	return true
}

fn (mut this Class_WP) send_headers()  {
	mut var_wp_query := rt.new_null()
	// unsupported statement: Stmt_Global
	mut var_headers := rt.new_array()
	mut var_status := rt.new_null()
	mut var_exit_required := rt.new_bool(rt.new_bool(false))
	mut var_date_format := rt.new_string(rt.new_string('D, d M Y H:i:s'))
	if rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{})) {
		var_headers = rt.call_function('array_merge', [var_headers.dup(), rt.call_function('wp_get_nocache_headers', []rt.PhpVal{})])
	} else if !(!rt.is_true(rt.get_superglobal('_GET').array_get('unapproved'))) && !(!rt.is_true(rt.get_superglobal('_GET').array_get('moderation-hash'))) {
		mut var_expires := rt.mul(rt.new_int(10), rt.get_constant('MINUTE_IN_SECONDS'))
		var_headers.array_set('Expires', rt.call_function('gmdate', [var_date_format.dup(), rt.add(rt.call_function('time', []rt.PhpVal{}), var_expires)]))
		var_headers.array_set('Cache-Control', rt.call_function('sprintf', [rt.new_string('max-age=%d, must-revalidate'), var_expires.dup()]))
	}
	if !(!rt.is_true(this.query_vars.array_get('error'))) {
		var_status = // unsupported expression: Expr_Cast_Int
		if rt.is_true(rt.identical(rt.new_int(404), var_status)) {
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_user_logged_in', []rt.PhpVal{}))))) {
				var_headers = 
			}
			.array_set(, )
		} else if rt.is_true(rt.call_function('in_array', [.dup(), , ])) {
			
		}
	} else if !rt.is_true(.array_get()) {
		
	} else {
	}
	if rt.is_true() {
	}
	
}

fn (mut this Class_WP) build_query_string()  {
}

fn (mut this Class_WP) register_globals()  {
	mut var_wp_query := rt.new_null()
	mut var_GLOBALS := rt.new_null()
}

fn (mut this Class_WP) init()  {
}

fn (mut this Class_WP) query_posts()  {
	mut var_wp_the_query := rt.new_null()
}

fn (mut this Class_WP) handle_404()  {
	mut var_wp_query := rt.new_null()
}

fn (mut this Class_WP) main(query_args string)  {
}

struct Class_WP_MatchesMapRegex {
	rt.PhpObjectBase
}

fn create_wp() &Class_WP {
	mut obj := &Class_WP{
		PhpObjectBase: rt.PhpObjectBase{}
		public_query_vars: rt.new_array()
		private_query_vars: rt.new_array()
		extra_query_vars: rt.new_array()
		query_vars: rt.new_array()
		query_string: rt.new_string('')
		request: rt.new_string('')
		matched_rule: rt.new_string('')
		matched_query: rt.new_string('')
		did_permalink: false
	}
	return obj
}

fn create_wp_matchesmapregex() &Class_WP_MatchesMapRegex {
	mut obj := &Class_WP_MatchesMapRegex{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_query_var(dispatch_arg_0)
			return rt.new_null()
		}
		'remove_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_query_var(dispatch_arg_0)
			return rt.new_null()
		}
		'set_query_var' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.set_query_var(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'parse_request' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.parse_request(dispatch_arg_0))
		}
		'send_headers' {
			this.send_headers()
			return rt.new_null()
		}
		'build_query_string' {
			this.build_query_string()
			return rt.new_null()
		}
		'register_globals' {
			this.register_globals()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'query_posts' {
			this.query_posts()
			return rt.new_null()
		}
		'handle_404' {
			this.handle_404()
			return rt.new_null()
		}
		'main' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.main(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'public_query_vars' { return this.public_query_vars }
		'private_query_vars' { return this.private_query_vars }
		'extra_query_vars' { return this.extra_query_vars }
		'query_vars' { return this.query_vars }
		'query_string' { return this.query_string }
		'request' { return this.request }
		'matched_rule' { return this.matched_rule }
		'matched_query' { return this.matched_query }
		'did_permalink' { return rt.new_bool(this.did_permalink) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'public_query_vars' { this.public_query_vars = val; return true }
		'private_query_vars' { this.private_query_vars = val; return true }
		'extra_query_vars' { this.extra_query_vars = val; return true }
		'query_vars' { this.query_vars = val; return true }
		'query_string' { this.query_string = val; return true }
		'request' { this.request = val; return true }
		'matched_rule' { this.matched_rule = val; return true }
		'matched_query' { this.matched_query = val; return true }
		'did_permalink' { this.did_permalink = (val).to_bool(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_MatchesMapRegex) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_MatchesMapRegex) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_MatchesMapRegex) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_php() {
}

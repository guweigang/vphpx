import rt

struct Class_WP_Network {
	rt.PhpObjectBase
pub mut:
	id            rt.PhpVal = rt.new_null()
	domain        rt.PhpVal = rt.new_string('')
	path          rt.PhpVal = rt.new_string('')
	blog_id       rt.PhpVal = rt.new_string('0')
	cookie_domain rt.PhpVal = rt.new_string('')
	site_name     rt.PhpVal = rt.new_string('')
}

fn Class_WP_Network.get_instance(var_network_id rt.PhpVal) bool {
	mut var_wpdb := rt.new_null()
	mut var_network_id_mutated := var_network_id
	var_network_id_mutated = rt.new_int(var_network_id_mutated.to_i64())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_network_id_mutated)))) {
		return false
	}
	mut var__network := rt.call_function('wp_cache_get', [var_network_id_mutated.clone(),
		rt.new_string('networks')])
	if rt.is_true(rt.identical(rt.new_bool(false), var__network)) {
		var__network = rt.call_method(var_wpdb, 'get_row', [
			rt.call_method(var_wpdb, 'prepare', [
				rt.concat(rt.concat(rt.new_string('SELECT * FROM '), rt.get_property(var_wpdb,
					'site')), rt.new_string(' WHERE id = %d LIMIT 1')),
				var_network_id_mutated.clone(),
			]),
		])
		if !rt.is_true(var__network)
			|| rt.is_true(rt.call_function('is_wp_error', [var__network.clone()])) {
			var__network = rt.new_int(-1)
		}
		rt.call_function('wp_cache_add', [var_network_id_mutated.clone(),
			var__network.clone(), rt.new_string('networks')])
	}
	if rt.is_true(rt.new_bool(var__network.clone().is_long() || var__network.clone().is_double())) {
		return false
	}
	return (create_wp_network(var__network.clone())).to_bool()
}

fn (mut this Class_WP_Network) construct(var_network rt.PhpVal) {
	mut iter_1 := rt.call_function('get_object_vars', [var_network.clone()]).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_key := item_1.key
		this.magic_set(var_key.clone(), var_value.clone())
	}
	this._set_site_name()
	this._set_cookie_domain()
}

fn (mut this Class_WP_Network) magic_get(var_key rt.PhpVal) rt.PhpVal {
	mut switch_val_1 := var_key
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('id'))) {
		return rt.new_int((this.id).to_i64())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('blog_id'))) {
		return rt.new_string(this.get_main_site_id().str())
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('site_id'))) {
		return rt.new_int(this.get_main_site_id())
	}
	return rt.new_null()
}

fn (mut this Class_WP_Network) magic_isset(var_key rt.PhpVal) bool {
	mut switch_val_2 := var_key
	if rt.is_true(rt.equal(switch_val_2, rt.new_string('id')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('blog_id')))
		|| rt.is_true(rt.equal(switch_val_2, rt.new_string('site_id'))) {
		return true
	}
	return false
}

fn (mut this Class_WP_Network) magic_set(var_key rt.PhpVal, var_value rt.PhpVal) {
	mut switch_val_3 := var_key
	if rt.is_true(rt.equal(switch_val_3, rt.new_string('id'))) {
		this.id = rt.new_int(var_value.to_i64())
	} else if rt.is_true(rt.equal(switch_val_3, rt.new_string('blog_id')))
		|| rt.is_true(rt.equal(switch_val_3, rt.new_string('site_id'))) {
		this.blog_id = var_value.str()
	} else {
		this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":205,"name":"key"}',
			var_value.clone())
	}
}

fn (mut this Class_WP_Network) get_main_site_id() i64 {
	mut var_main_site_id := rt.new_int((rt.call_function('apply_filters', [
		rt.new_string('pre_get_main_site_id'),
		rt.new_null(),
		rt.new_object('WP_Network', []string{}, &this),
	])).to_i64())
	if rt.is_true(rt.less(rt.new_int(0), var_main_site_id)) {
		return var_main_site_id.to_i64()
	}
	if 0 < rt.new_int((this.blog_id).to_i64()) {
		return rt.new_int((this.blog_id).to_i64())
	}
	if (rt.is_true(rt.call_function('defined', [rt.new_string('DOMAIN_CURRENT_SITE')]))
		&& rt.is_true(rt.call_function('defined', [rt.new_string('PATH_CURRENT_SITE')]))
		&& rt.is_true(rt.identical(rt.get_constant('DOMAIN_CURRENT_SITE'), this.domain))
		&& rt.is_true(rt.identical(rt.get_constant('PATH_CURRENT_SITE'), this.path)))
		|| (rt.is_true(rt.call_function('defined', [rt.new_string('SITE_ID_CURRENT_SITE')]))
		&& rt.is_true(rt.identical(rt.new_int((rt.get_constant('SITE_ID_CURRENT_SITE')).to_i64()), this.id))) {
		if rt.is_true(rt.call_function('defined', [rt.new_string('BLOG_ID_CURRENT_SITE')])) {
			this.blog_id = (rt.get_constant('BLOG_ID_CURRENT_SITE')).str()
			return rt.new_int((this.blog_id).to_i64())
		}
		if rt.is_true(rt.call_function('defined', [rt.new_string('BLOGID_CURRENT_SITE')])) {
			this.blog_id = (rt.get_constant('BLOGID_CURRENT_SITE')).str()
			return rt.new_int((this.blog_id).to_i64())
		}
	}
	mut var_site := rt.call_function('get_site', []rt.PhpVal{})
	if rt.is_true(rt.identical(rt.get_property(var_site, 'domain'), this.domain))
		&& rt.is_true(rt.identical(rt.get_property(var_site, 'path'), this.path)) {
		var_main_site_id = rt.new_int((rt.get_property(var_site, 'id')).to_i64())
	} else {
		var_main_site_id = rt.call_function('get_network_option',
			[this.id, rt.new_string('main_site')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_main_site_id)) {
			mut var__sites := rt.call_function('get_sites', [
				rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' },
					rt.ArrayItem{ key: 'number', val: 1 }, rt.ArrayItem{
						key: 'domain'
						val: this.domain
					}, rt.ArrayItem{ key: 'path', val: this.path },
					rt.ArrayItem{ key: 'network_id', val: this.id }]),
			])
			var_main_site_id = if !(!rt.is_true(var__sites)) { rt.call_function('array_shift', [
					var__sites.clone(),
				]) } else { rt.new_int(0) }
			rt.call_function('update_network_option', [this.id, rt.new_string('main_site'),
				var_main_site_id.clone()])
		}
	}
	this.blog_id = var_main_site_id.str()
	return rt.new_int((this.blog_id).to_i64())
}

fn (mut this Class_WP_Network) _set_site_name() {
	if !(!rt.is_true(this.site_name)) {
		return
	}
	mut var_default := rt.call_function('ucfirst', [this.domain])
	this.site_name = rt.call_function('get_network_option', [this.id, rt.new_string('site_name'),
		var_default.clone()])
}

fn (mut this Class_WP_Network) _set_cookie_domain() {
	if !(!rt.is_true(this.cookie_domain)) {
		return
	}
	mut var_domain := rt.call_function('parse_url', [this.domain, rt.get_constant('PHP_URL_HOST')])
	this.cookie_domain = if var_domain.clone().is_string() { var_domain } else { this.domain }
	if rt.is_true(rt.call_function('str_starts_with', [this.cookie_domain, rt.new_string('www.')])) {
		this.cookie_domain = rt.call_function('substr', [this.cookie_domain, rt.new_int(4)])
	}
}

fn Class_WP_Network.get_by_path(domain string, path string, var_segments rt.PhpVal) bool {
	mut domain_mutated := domain
	mut var_segments_mutated := var_segments
	mut var_domains := [rt.new_string(domain_mutated)]
	mut var_pieces := rt.call_function('explode', [rt.new_string('.'),
		rt.new_string(domain_mutated).clone()])
	for rt.is_true(rt.call_function('array_shift', [var_pieces.clone()])) {
		if !(!rt.is_true(var_pieces)) {
			var_domains << rt.call_function('implode', [rt.new_string('.'),
				var_pieces.clone()])
		}
	}
	mut var_using_paths := rt.new_bool(true)
	if rt.is_true(rt.call_function('wp_using_ext_object_cache', []rt.PhpVal{})) {
		var_using_paths = rt.call_function('get_networks', [
			rt.create_array([rt.ArrayItem{ key: 'number', val: 1 },
				rt.ArrayItem{ key: 'count', val: true }, rt.ArrayItem{ key: 'path__not_in', val: '/' }]),
		])
	}
	mut var_paths := []rt.PhpVal{}
	if rt.is_true(var_using_paths) {
		mut var_path_segments := rt.call_function('array_filter', [
			rt.call_function('explode', [rt.new_string('/'), rt.new_string(path.trim_space())]),
		])
		var_segments_mutated = rt.call_function('apply_filters', [
			rt.new_string('network_by_path_segments_count'),
			var_segments_mutated.clone(),
			rt.new_string(domain_mutated).clone(),
			rt.new_string(path),
		])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_segments_mutated))))
			&& rt.is_true(rt.greater(rt.new_int(var_path_segments.clone().array_count()), var_segments_mutated)) {
			var_path_segments = rt.call_function('array_slice', [
				var_path_segments.clone(), rt.new_int(0), var_segments_mutated.clone()])
		}
		for rt.is_true(rt.new_int(var_path_segments.clone().array_count())) {
			var_paths << '/' +
				(rt.call_function('implode', [rt.new_string('/'), var_path_segments.clone()])).str() +
				'/'
			rt.call_function('array_pop', [var_path_segments.clone()])
		}
		var_paths << '/'
	}
	mut var_pre := rt.call_function('apply_filters', [
		rt.new_string('pre_get_network_by_path'),
		rt.new_null(),
		rt.new_string(domain_mutated).clone(),
		rt.new_string(path),
		var_segments_mutated.clone(),
		rt.create_array_from_list(var_paths),
	])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_pre)))) {
		return var_pre.to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_using_paths)))) {
		mut var_networks := rt.call_function('get_networks', [
			rt.create_array([rt.ArrayItem{ key: 'number', val: 1 },
				rt.ArrayItem{ key: 'orderby', val: rt.create_array([
					rt.ArrayItem{ key: 'domain_length', val: 'DESC' },
				]) }, rt.ArrayItem{ key: 'domain__in', val: var_domains }]),
		])
		if !(!rt.is_true(var_networks)) {
			return (rt.call_function('array_shift', [var_networks.clone()])).to_bool()
		}
		return false
	}
	var_networks = rt.call_function('get_networks', [
		rt.create_array([
			rt.ArrayItem{ key: 'orderby', val: rt.create_array([
				rt.ArrayItem{ key: 'domain_length', val: 'DESC' },
				rt.ArrayItem{ key: 'path_length', val: 'DESC' },
			]) },
			rt.ArrayItem{ key: 'domain__in', val: var_domains },
			rt.ArrayItem{ key: 'path__in', val: var_paths },
		]),
	])
	mut var_found := rt.new_bool(false)
	mut iter_2 := var_networks.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_network := item_2.val
		if rt.is_true(rt.identical(rt.get_property(var_network, 'domain'), rt.new_string(domain_mutated)))
			|| rt.is_true(rt.identical(rt.concat(rt.new_string('www.'), rt.get_property(var_network, 'domain')), rt.new_string(domain_mutated))) {
			if rt.is_true(rt.call_function('in_array', [
				rt.get_property(var_network, 'path'),
				rt.create_array_from_list(var_paths),
				rt.new_bool(true),
			]))
			{
				var_found = rt.new_bool(true)
				break
			}
		}
		if rt.is_true(rt.identical(rt.new_string('/'), rt.get_property(var_network, 'path'))) {
			var_found = rt.new_bool(true)
			break
		}
	}
	if rt.is_true(rt.identical(rt.new_bool(true), var_found)) {
		return var_network.to_bool()
	}
	return false
}

fn create_wp_network(arg_0 rt.PhpVal) &Class_WP_Network {
	mut obj := &Class_WP_Network{
		PhpObjectBase: rt.PhpObjectBase{}
		id:            rt.new_null()
		domain:        rt.new_string('')
		path:          rt.new_string('')
		blog_id:       rt.new_string('0')
		cookie_domain: rt.new_string('')
		site_name:     rt.new_string('')
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Network) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_instance' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Network.get_instance(dispatch_arg_0))
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
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
		'get_main_site_id' {
			return rt.new_int(this.get_main_site_id())
		}
		'_set_site_name' {
			this._set_site_name()
			return rt.new_null()
		}
		'_set_cookie_domain' {
			this._set_cookie_domain()
			return rt.new_null()
		}
		'get_by_path' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(Class_WP_Network.get_by_path(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Network) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id' { return this.id }
		'domain' { return this.domain }
		'path' { return this.path }
		'blog_id' { return this.blog_id }
		'cookie_domain' { return this.cookie_domain }
		'site_name' { return this.site_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Network) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id' {
			this.id = val
			return true
		}
		'domain' {
			this.domain = val
			return true
		}
		'path' {
			this.path = val
			return true
		}
		'blog_id' {
			this.blog_id = val
			return true
		}
		'cookie_domain' {
			this.cookie_domain = val
			return true
		}
		'site_name' {
			this.site_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

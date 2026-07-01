import rt

struct Class_WP_REST_Response {
	rt.PhpObjectBase
pub mut:
	links           rt.PhpVal = rt.new_array()
	matched_route   rt.PhpVal = rt.new_string('')
	matched_handler rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_REST_Response) add_link(var_rel rt.PhpVal, var_href rt.PhpVal, var_attributes rt.PhpVal) {
	if !rt.is_true(this.links.array_get(var_rel)) {
		this.links.array_set(var_rel, rt.new_array())
	}
	if var_attributes.array_isset(rt.new_string('href')) {
		var_attributes.array_unset(rt.new_string('href'))
	}
	this.links.array_get_mut(var_rel).array_push(rt.create_array([
		rt.ArrayItem{ key: 'href', val: var_href },
		rt.ArrayItem{ key: 'attributes', val: var_attributes },
	]))
}

fn (mut this Class_WP_REST_Response) remove_link(var_rel rt.PhpVal, var_href rt.PhpVal) {
	if !(this.links.array_isset(var_rel)) {
		return rt.new_null()
	}
	if rt.is_true(var_href) {
		this.links.array_set(var_rel, rt.call_function('wp_list_filter', [
			this.links.array_get(var_rel),
			rt.create_array([rt.ArrayItem{ key: 'href', val: var_href }]),
			rt.new_string('NOT'),
		]))
	} else {
		this.links.array_set(var_rel, rt.new_array())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.links.array_get(var_rel))))) {
		this.links.array_unset(var_rel)
	}
}

fn (mut this Class_WP_REST_Response) add_links(var_links rt.PhpVal) {
	{
		mut iter_1 := var_links.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_set := item_1.val
			mut var_rel := item_1.key
			if var_set.array_isset(rt.new_string('href')) {
				var_set = rt.create_array([rt.ArrayItem{ key: none, val: var_set }])
			}
			{
				mut iter_2 := var_set.iterator()
				for {
					item_2 := iter_2.next() or { break }
					mut var_attributes := item_2.val
					this.add_link(var_rel.dup(), var_attributes.array_get('href'),
						var_attributes.dup())
				}
			}
		}
	}
}

fn (mut this Class_WP_REST_Response) get_links() rt.PhpVal {
	return this.links
}

fn (mut this Class_WP_REST_Response) link_header(var_rel rt.PhpVal, var_link rt.PhpVal, var_other rt.PhpVal) {
	mut var_header := rt.new_string('<' + var_link.str() + '>; rel="' + var_rel.str() + '"')
	{
		mut iter_1 := var_other.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value := item_1.val
			mut var_key := item_1.key
			if rt.is_true(rt.identical(rt.new_string('title'), var_key)) {
				var_value = rt.new_string('"' + var_value.str() + '"')
			}
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	this.header(rt.new_string('Link'), var_header.dup(), rt.new_bool(false))
}

fn (mut this Class_WP_REST_Response) get_matched_route() rt.PhpVal {
	return this.matched_route
}

fn (mut this Class_WP_REST_Response) set_matched_route(var_route rt.PhpVal) {
	this.matched_route = var_route.dup()
}

fn (mut this Class_WP_REST_Response) get_matched_handler() rt.PhpVal {
	return this.matched_handler
}

fn (mut this Class_WP_REST_Response) set_matched_handler(var_handler rt.PhpVal) {
	this.matched_handler = var_handler.dup()
}

fn (mut this Class_WP_REST_Response) is_error() rt.PhpVal {
	return rt.greater_equal(this.get_status(), rt.new_int(400))
}

fn (mut this Class_WP_REST_Response) as_error() rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_error())))) {
		return rt.new_null()
	}
	mut var_error := create_wp_error()
	if rt.is_true(rt.new_bool(this.get_data().is_array())) {
		mut var_data := this.get_data()
		var_error.add(var_data.array_get('code'), var_data.array_get('message'),
			var_data.array_get('data'))
		if !(!rt.is_true(var_data.array_get('additional_errors'))) {
			{
				mut iter_1 := var_data.array_get('additional_errors').iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_err := item_1.val
					var_error.add(var_err.array_get('code'), var_err.array_get('message'),
						var_err.array_get('data'))
				}
			}
		}
	} else {
		var_error.add(this.get_status(), rt.new_string(''), rt.create_array([
			rt.ArrayItem{ key: 'status', val: this.get_status() },
		]))
	}
	return rt.new_object('WP_Error', []string{}, var_error)
}

fn (mut this Class_WP_REST_Response) get_curies() rt.PhpVal {
	mut var_curies := [
		[rt.new_string('wp'), rt.new_string('https://api.w.org/{rel}'),
			rt.new_bool(true)],
	]
	mut var_additional := rt.call_function('apply_filters', [
		rt.new_string('rest_response_link_curies'),
		rt.new_array(),
	])
	return rt.call_function('array_merge', [var_curies.dup(),
		var_additional.dup()])
}

struct Class_WP_HTTP_Response {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_rest_response() &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase:   rt.PhpObjectBase{}
		links:           rt.new_array()
		matched_route:   rt.new_string('')
		matched_handler: rt.new_null()
	}
	return obj
}

fn create_wp_http_response() &Class_WP_HTTP_Response {
	mut obj := &Class_WP_HTTP_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'add_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.add_link(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'remove_link' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.remove_link(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'add_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_links(dispatch_arg_0)
			return rt.new_null()
		}
		'get_links' {
			return this.get_links()
		}
		'link_header' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.link_header(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'get_matched_route' {
			return this.get_matched_route()
		}
		'set_matched_route' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_matched_route(dispatch_arg_0)
			return rt.new_null()
		}
		'get_matched_handler' {
			return this.get_matched_handler()
		}
		'set_matched_handler' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_matched_handler(dispatch_arg_0)
			return rt.new_null()
		}
		'is_error' {
			return this.is_error()
		}
		'as_error' {
			return this.as_error()
		}
		'get_curies' {
			return this.get_curies()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'links' { return this.links }
		'matched_route' { return this.matched_route }
		'matched_handler' { return this.matched_handler }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'links' {
			this.links = val
			return true
		}
		'matched_route' {
			this.matched_route = val
			return true
		}
		'matched_handler' {
			this.matched_handler = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WP_HTTP_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTTP_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTTP_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
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

pub fn init_wp_includes_rest_api_class_wp_rest_response_php() {
}

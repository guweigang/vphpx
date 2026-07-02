import rt
import crypto.md5

struct Class_WP_oEmbed_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_oEmbed_Controller) register_routes() {
	mut var_maxwidth := rt.call_function('apply_filters', [
		rt.new_string('oembed_default_width'),
		rt.new_int(600),
	])
	rt.call_function('register_rest_route', [rt.new_string('oembed/1.0'),
		rt.new_string('/embed'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_oEmbed_Controller', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'get_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: '__return_true' },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'url', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The URL of the resource for which to fetch oEmbed data.'),
						]) },
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'format', val: 'uri' },
					]) },
					rt.ArrayItem{ key: 'format', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: 'json' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'wp_oembed_ensure_format' },
					]) },
					rt.ArrayItem{ key: 'maxwidth', val: rt.create_array([
						rt.ArrayItem{ key: 'default', val: var_maxwidth },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
					]) },
				]) },
			]) },
		])])
	rt.call_function('register_rest_route', [rt.new_string('oembed/1.0'),
		rt.new_string('/proxy'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_oEmbed_Controller', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'get_proxy_item' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_oEmbed_Controller', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'get_proxy_item_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: rt.create_array([
					rt.ArrayItem{ key: 'url', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The URL of the resource for which to fetch oEmbed data.'),
						]) },
						rt.ArrayItem{ key: 'required', val: true },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'format', val: 'uri' },
					]) },
					rt.ArrayItem{ key: 'format', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The oEmbed format to use.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'string' },
						rt.ArrayItem{ key: 'default', val: 'json' },
						rt.ArrayItem{ key: 'enum', val: rt.create_array([
							rt.ArrayItem{ key: none, val: 'json' },
							rt.ArrayItem{ key: none, val: 'xml' },
						]) },
					]) },
					rt.ArrayItem{ key: 'maxwidth', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The maximum width of the embed frame in pixels.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'default', val: var_maxwidth },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
					]) },
					rt.ArrayItem{ key: 'maxheight', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('The maximum height of the embed frame in pixels.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'integer' },
						rt.ArrayItem{ key: 'sanitize_callback', val: 'absint' },
					]) },
					rt.ArrayItem{ key: 'discover', val: rt.create_array([
						rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
							rt.new_string('Whether to perform an oEmbed discovery request for unsanctioned providers.'),
						]) },
						rt.ArrayItem{ key: 'type', val: 'boolean' },
						rt.ArrayItem{ key: 'default', val: true },
					]) },
				]) },
			]) },
		])])
}

fn (mut this Class_WP_oEmbed_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_post_id := rt.call_function('url_to_postid', [
		var_request.array_get(rt.new_string('url')),
	])
	var_post_id = rt.call_function('apply_filters', [
		rt.new_string('oembed_request_post_id'),
		var_post_id.clone(),
		var_request.array_get(rt.new_string('url')),
	])
	mut var_data := rt.call_function('get_oembed_response_data', [
		var_post_id.clone(), var_request.array_get(rt.new_string('maxwidth'))])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data)))) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('oembed_invalid_url'), rt.call_function('get_status_header_desc', [
			rt.new_int(404),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	return var_data.clone()
}

fn (mut this Class_WP_oEmbed_Controller) get_proxy_item_permissions_check() bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('edit_posts'),
	])))))
	{
		return (create_wp_error(rt.new_string('rest_forbidden'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to make proxied oEmbed requests.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_oEmbed_Controller) get_proxy_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_embed := rt.new_null()
	mut var_wp_scripts := rt.new_null()
	mut var_args := rt.call_method(var_request, 'get_params', []rt.PhpVal{})
	var_args.array_unset(rt.new_string('_wpnonce'))
	mut var_cache_key := rt.new_string('oembed_' +
		md5.hexhash(rt.call_function('serialize', [var_args.clone()]).to_string()))
	mut var_data := rt.call_function('get_transient', [var_cache_key.clone()])
	if !(!rt.is_true(var_data)) {
		return mut rt.cast_object_ptr[Class_stdClass](var_data)
	}
	mut var_url := var_request.array_get(rt.new_string('url'))
	var_args.array_unset(rt.new_string('url'))
	if var_args.array_isset(rt.new_string('maxwidth')) {
		var_args.array_set('width', var_args.array_get(rt.new_string('maxwidth')))
	}
	if var_args.array_isset(rt.new_string('maxheight')) {
		var_args.array_set('height', var_args.array_get(rt.new_string('maxheight')))
	}
	var_data = rt.call_function('get_oembed_response_data_for_url', [
		var_url.clone(), var_args.clone()])
	if rt.is_true(var_data) {
		return mut rt.cast_object_ptr[Class_stdClass](var_data)
	}
	var_data = rt.call_method(rt.call_function('_wp_oembed_get_object', []rt.PhpVal{}), 'get_data', [
		var_url.clone(),
		var_args.clone(),
	])
	if rt.is_true(rt.identical(rt.new_bool(false), var_data)) {
		mut var_html := rt.call_method(var_wp_embed, 'get_embed_handler_html', [
			var_args.clone(),
			var_url.clone(),
		])
		if rt.is_true(var_html) {
			mut var_enqueued_scripts := []rt.PhpVal{}
			mut iter_1 := rt.get_property(var_wp_scripts, 'queue').iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_script := item_1.val
				var_enqueued_scripts << rt.get_property(rt.get_property(var_wp_scripts,
					'registered').array_get(var_script), 'src')
			}
			return mut rt.array_to_object(rt.create_array([
				rt.ArrayItem{ key: 'provider_name', val: rt.call_function('__', [
					rt.new_string('Embed Handler'),
				]) },
				rt.ArrayItem{ key: 'html', val: var_html },
				rt.ArrayItem{ key: 'scripts', val: var_enqueued_scripts },
			]))
		}
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('oembed_invalid_url'), rt.call_function('get_status_header_desc', [
			rt.new_int(404),
		]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }])))
	}
	rt.set_property(var_data, 'html', rt.call_function('apply_filters', [
		rt.new_string('oembed_result'),
		rt.call_method(rt.call_function('_wp_oembed_get_object', []rt.PhpVal{}), 'data2html', [
			rt.array_to_object(var_data),
			var_url.clone(),
		]),
		var_url.clone(),
		var_args.clone(),
	]))
	mut var_ttl := rt.call_function('apply_filters', [rt.new_string('rest_oembed_ttl'),
		rt.get_constant('DAY_IN_SECONDS'), var_url.clone(), var_args.clone()])
	rt.call_function('set_transient', [var_cache_key.clone(),
		var_data.clone(), var_ttl.clone()])
	return mut rt.cast_object_ptr[Class_stdClass](var_data)
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_oembed_controller(_args ...rt.PhpVal) &Class_WP_oEmbed_Controller {
	mut obj := &Class_WP_oEmbed_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error(_args ...rt.PhpVal) &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_oEmbed_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
		}
		'get_proxy_item_permissions_check' {
			return rt.new_bool(this.get_proxy_item_permissions_check())
		}
		'get_proxy_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_proxy_item(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_oEmbed_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_oEmbed_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn main() {
	defer {
		rt.shutdown()
	}
}

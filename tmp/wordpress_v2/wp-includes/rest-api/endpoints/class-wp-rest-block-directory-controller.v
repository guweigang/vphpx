import rt

struct Class_WP_REST_Block_Directory_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Block_Directory_Controller) construct() {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('block-directory'))
}

fn (mut this Class_WP_REST_Block_Directory_Controller) register_routes() {
	rt.call_function('register_rest_route', [
		rt.get_property(rt.new_object('WP_REST_Block_Directory_Controller', [
			'WP_REST_Controller',
		], &this), 'namespace'),
		rt.new_string('/' +
			rt.get_property(rt.new_object('WP_REST_Block_Directory_Controller', ['WP_REST_Controller'], &this), 'rest_base') +
			'/search'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.create_array([
				rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() },
				rt.ArrayItem{ key: 'callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Directory_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items' },
				]) },
				rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Directory_Controller', [
						'WP_REST_Controller',
					], &this) },
					rt.ArrayItem{ key: none, val: 'get_items_permissions_check' },
				]) },
				rt.ArrayItem{ key: 'args', val: this.get_collection_params() },
			]) },
			rt.ArrayItem{ key: 'schema', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Block_Directory_Controller', [
					'WP_REST_Controller',
				], &this) },
				rt.ArrayItem{ key: none, val: 'get_public_item_schema' },
			]) },
		]),
	])
}

fn (mut this Class_WP_REST_Block_Directory_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('install_plugins')])))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('activate_plugins')]))))) {
		return (create_wp_error(rt.new_string('rest_block_directory_cannot_view'), rt.call_function('__', [
			rt.new_string('Sorry, you are not allowed to browse the block directory.'),
		]), rt.create_array([
			rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code',
				[]rt.PhpVal{}) },
		]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Block_Directory_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin-install.php',
		'4')
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_response := rt.call_function('plugins_api', [rt.new_string('query_plugins'),
		rt.create_array([
			rt.ArrayItem{ key: 'block', val: var_request.array_get(rt.new_string('term')) },
			rt.ArrayItem{ key: 'per_page', val: var_request.array_get(rt.new_string('per_page')) },
			rt.ArrayItem{ key: 'page', val: var_request.array_get(rt.new_string('page')) },
		])])
	if rt.is_true(rt.call_function('is_wp_error', [var_response.clone()])) {
		rt.call_method(var_response, 'add_data', [
			rt.create_array([rt.ArrayItem{ key: 'status', val: 500 }]),
		])
		return var_response.clone()
	}
	mut var_result := []rt.PhpVal{}
	mut iter_1 := rt.get_property(var_response, 'plugins').iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_plugin := item_1.val
		if !rt.is_true(var_plugin.array_get(rt.new_string('blocks'))) {
			continue
		}
		mut var_data := this.prepare_item_for_response(var_plugin.clone(), var_request.clone())
		var_result << this.prepare_response_for_collection(var_data.clone())
	}
	return rt.call_function('rest_ensure_response', [
		rt.create_array_from_list(var_result),
	])
}

fn (mut this Class_WP_REST_Block_Directory_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_plugin := var_item
	mut var_fields := this.get_fields_for_response(var_request.clone())
	mut var_block_data := rt.call_function('reset', [
		var_plugin.array_get(rt.new_string('blocks')),
	])
	mut var_block := {
		'name':                var_block_data.array_get(rt.new_string('name'))
		'title':               if rt.is_true(var_block_data.array_get(rt.new_string('title'))) {
			var_block_data.array_get(rt.new_string('title'))
		} else {
			var_plugin.array_get(rt.new_string('name'))
		}
		'description':         rt.call_function('wp_trim_words', [
			var_plugin.array_get(rt.new_string('short_description')),
			rt.new_int(30),
			rt.new_string('...'),
		])
		'id':                  var_plugin.array_get(rt.new_string('slug'))
		'rating':              var_plugin.array_get(rt.new_string('rating')) / 20
		'rating_count':        rt.new_int((var_plugin.array_get(rt.new_string('num_ratings'))).to_i64())
		'active_installs':     rt.new_int((var_plugin.array_get(rt.new_string('active_installs'))).to_i64())
		'author_block_rating': var_plugin.array_get(rt.new_string('author_block_rating')) / 20
		'author_block_count':  rt.new_int((var_plugin.array_get(rt.new_string('author_block_count'))).to_i64())
		'author':              rt.call_function('wp_strip_all_tags', [
			var_plugin.array_get(rt.new_string('author')),
		])
		'icon':                if !(var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('1x'))).is_null() {
			var_plugin.array_get(rt.new_string('icons')).array_get(rt.new_string('1x'))
		} else {
			rt.new_string('block-default')
		}
		'last_updated':        rt.call_function('gmdate', [
			rt.new_string('Y-m-d\\TH:i:s'),
			rt.call_function('strtotime', [var_plugin.array_get(rt.new_string('last_updated'))]),
		])
		'humanized_updated':   rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s ago')]),
			rt.call_function('human_time_diff', [
				rt.call_function('strtotime', [
					var_plugin.array_get(rt.new_string('last_updated')),
				]),
			]),
		])
	}
	this.add_additional_fields_to_object(var_block.clone(), var_request.clone())
	mut var_response := create_wp_rest_response(var_block.clone())
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.clone()]))
		|| rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.clone()])) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_plugin.clone())])
	}
	return var_response.clone()
}

fn (mut this Class_WP_REST_Block_Directory_Controller) prepare_links(var_plugin rt.PhpVal) rt.PhpVal {
	mut var_plugin_mutated := var_plugin
	mut var_links := {
		'https://api.w.org/install-plugin': {
			'href': rt.call_function('add_query_arg', [rt.new_string('slug'),
				rt.call_function('urlencode', [var_plugin_mutated.array_get(rt.new_string('slug'))]),
				rt.call_function('rest_url', [rt.new_string('wp/v2/plugins')])])
		}
	}
	mut var_plugin_file :=
		rt.new_string(this.find_plugin_for_slug(var_plugin_mutated.array_get(rt.new_string('slug'))))
	if rt.is_true(var_plugin_file) {
		var_links['https://api.w.org/plugin'] = rt.create_array([
			rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [
				rt.new_string('wp/v2/plugins/' +(rt.call_function('substr', [var_plugin_file.clone(), rt.new_int(0), rt.new_int(-4)])).str()),
			]) },
			rt.ArrayItem{ key: 'embeddable', val: true },
		])
	}
	return var_links.clone()
}

fn (mut this Class_WP_REST_Block_Directory_Controller) find_plugin_for_slug(var_slug rt.PhpVal) string {
	rt.include_file((rt.get_constant('ABSPATH')).str() + 'wp-admin/includes/plugin.php', '4')
	mut var_plugin_files := rt.call_function('get_plugins', [
		rt.new_string('/' + var_slug.str()),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_plugin_files)))) {
		return ''
	}
	var_plugin_files = rt.func_array_keys(var_plugin_files.clone())
	return var_slug.str() + '/' + (rt.call_function('reset', [var_plugin_files.clone()])).str()
}

fn (mut this Class_WP_REST_Block_Directory_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Block_Directory_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
	{
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Directory_Controller', [
			'WP_REST_Controller',
		], &this), 'schema'))
	}
	this.dispatch_set_prop('schema', rt.create_array([
		rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' },
		rt.ArrayItem{ key: 'title', val: 'block-directory-item' },
		rt.ArrayItem{ key: 'type', val: 'object' },
		rt.ArrayItem{ key: 'properties', val: rt.create_array([
			rt.ArrayItem{ key: 'name', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The block name, in namespace/block-name format.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'title', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The block title, in human readable format.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'description', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('A short description of the block, in human readable format.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'id', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The block slug.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'rating', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The star rating of the block.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'rating_count', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The number of ratings.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'active_installs', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The number sites that have activated this block.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'author_block_rating', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The average rating of blocks published by the same author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'number' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'author_block_count', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The number of blocks published by the same author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'integer' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'author', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The WordPress.org username of the block author.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'icon', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The block icon.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'uri' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'last_updated', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The date when the block was last updated.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'format', val: 'date-time' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
			rt.ArrayItem{ key: 'humanized_updated', val: rt.create_array([
				rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
					rt.new_string('The date when the block was last updated, in human readable format.'),
				]) },
				rt.ArrayItem{ key: 'type', val: 'string' },
				rt.ArrayItem{ key: 'context', val: rt.create_array([
					rt.ArrayItem{ key: none, val: 'view' },
				]) },
			]) },
		]) },
	]))
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Block_Directory_Controller', [
		'WP_REST_Controller',
	], &this), 'schema'))
}

fn (mut this Class_WP_REST_Block_Directory_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Controller.get_collection_params()
	var_query_params.array_get_mut('context').array_set('default', 'view')
	var_query_params.array_set('term', rt.create_array([
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('Limit result set to blocks matching the search term.'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'string' },
		rt.ArrayItem{ key: 'required', val: true },
		rt.ArrayItem{ key: 'minLength', val: 1 },
	]))
	var_query_params.array_unset(rt.new_string('search'))
	return rt.call_function('apply_filters', [
		rt.new_string('rest_block_directory_collection_params'),
		var_query_params.clone(),
	])
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_REST_Response {
	rt.PhpObjectBase
}

fn create_wp_rest_block_directory_controller() &Class_WP_REST_Block_Directory_Controller {
	mut obj := &Class_WP_REST_Block_Directory_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller(_args ...rt.PhpVal) &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_wp_rest_response(_args ...rt.PhpVal) &Class_WP_REST_Response {
	mut obj := &Class_WP_REST_Response{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Block_Directory_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_items(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'find_plugin_for_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.find_plugin_for_slug(dispatch_arg_0))
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_REST_Block_Directory_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Block_Directory_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_REST_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_REST_Response) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Response) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Response) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

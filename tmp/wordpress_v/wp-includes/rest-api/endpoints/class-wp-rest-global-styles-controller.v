import rt

struct Class_WP_REST_Global_Styles_Controller {
	rt.PhpObjectBase
pub mut:
		allow_batch rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_REST_Global_Styles_Controller) construct(post_type string)  {
	mut post_type_mutated := post_type
	this.Class_WP_REST_Posts_Controller.construct(rt.new_string(post_type_mutated))
}

fn (mut this Class_WP_REST_Global_Styles_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() + '/themes/(?P<stylesheet>[\\/\\s%\\w\\.\\(\\)\\[\\]\\@_\\-]+)/variations', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_theme_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_theme_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'stylesheet', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme identifier')]) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), rt.call_function('sprintf', [rt.new_string('/%s/themes/(?P<stylesheet>%s)'), rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base'), rt.new_string('[^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?')]), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_theme_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_theme_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'stylesheet', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme identifier')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: '_sanitize_global_styles_callback' }]) }]) }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), '/' + (rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')).str() + '/(?P<id>[\\/\\d+]+)', rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('ID of global styles config.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.editable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'update_item_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_endpoint_args_for_item_schema(Class_WP_REST_Server.editable()) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }, rt.ArrayItem{ key: 'allow_batch', val: this.allow_batch }])])
}

fn (mut this Class_WP_REST_Global_Styles_Controller) _sanitize_global_styles_callback(var_stylesheet rt.PhpVal) rt.PhpVal {
	return rt.call_function('urldecode', [var_stylesheet.dup()])
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_post(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_error := create_wp_error(rt.new_string('rest_global_styles_not_found'), rt.call_function('__', [rt.new_string('No global styles config exists with that ID.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	var_id_mutated = // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.less_equal(var_id_mutated, rt.new_int(0))) {
		return mut var_error
	}
	mut var_post := rt.call_function('get_post', [var_id_mutated.dup()])
	if rt.is_true(rt.new_bool(!rt.is_true(var_post) || !rt.is_true(rt.get_property(var_post, 'ID')) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		return mut var_error
	}
	return mut rt.cast_object_ptr[Class_WP_Error](var_post)
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return (var_post).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_string('edit'), var_request.array_get('context'))) && rt.is_true(var_post))) && rt.is_true(rt.new_bool(!(rt.is_true(this.check_update_permission(var_post.dup()))))))) {
		return (create_wp_error(rt.new_string('rest_forbidden_context'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this global style.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.check_read_permission(var_post.dup()))))) {
		return (create_wp_error(rt.new_string('rest_cannot_view'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view this global style.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Global_Styles_Controller) check_read_permission(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	return rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post_mutated, 'ID')])
}

fn (mut this Class_WP_REST_Global_Styles_Controller) update_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return (var_post).to_bool()
	}
	if rt.is_true(rt.new_bool(rt.is_true(var_post) && rt.is_true(rt.new_bool(!(rt.is_true(this.check_update_permission(var_post.dup()))))))) {
		return (create_wp_error(rt.new_string('rest_cannot_edit'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to edit this global style.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Global_Styles_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_changes := create_stdclass()
	rt.set_property(var_changes, 'ID', var_request.array_get('id'))
	mut var_post := rt.call_function('get_post', [var_request.array_get('id')])
	mut var_existing_config := rt.new_array()
	if rt.is_true(var_post) {
		var_existing_config = rt.call_function('json_decode', [rt.get_property(var_post, 'post_content'), rt.new_bool(true)])
		mut var_json_decoding_error := rt.call_function('json_last_error', []rt.PhpVal{})
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || !(var_existing_config.array_isset(rt.new_string('isGlobalStylesUserThemeJSON'))))) || rt.is_true(rt.new_bool(!(rt.is_true(var_existing_config.array_get('isGlobalStylesUserThemeJSON'))))))) {
			var_existing_config = rt.new_array()
		}
	}
	if var_request.array_isset(rt.new_string('styles')) || var_request.array_isset(rt.new_string('settings')) {
		mut var_config := rt.new_array()
		if var_request.array_isset(rt.new_string('styles')) {
			if var_request.array_get('styles').array_isset(rt.new_string('css')) {
				mut var_css_validation_result := rt.new_bool(this.validate_custom_css(var_request.array_get('styles').array_get('css')))
				if rt.is_true(rt.call_function('is_wp_error', [var_css_validation_result.dup()])) {
					return mut rt.cast_object_ptr[Class_stdClass](var_css_validation_result)
				}
			}
			var_config.array_set('styles', var_request.array_get('styles'))
		} else if var_existing_config.array_isset(rt.new_string('styles')) {
			var_config.array_set('styles', var_existing_config.array_get('styles'))
		}
		mut var_variations := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_style_variations(arg_0) }(rt.new_string('block'))
		rt.call_function('wp_register_block_style_variations_from_theme_json_partials', [var_variations.dup()])
		if var_request.array_isset(rt.new_string('settings')) {
			var_config.array_set('settings', var_request.array_get('settings'))
		} else if var_existing_config.array_isset(rt.new_string('settings')) {
			var_config.array_set('settings', var_existing_config.array_get('settings'))
		}
		var_config.array_set('isGlobalStylesUserThemeJSON', true)
		var_config.array_set('version', Class_WP_Theme_JSON.latest_schema())
		rt.set_property(var_changes, 'post_content', rt.call_function('wp_json_encode', [var_config.dup(), rt.bitwise_or(rt.bitwise_or(rt.get_constant('JSON_UNESCAPED_SLASHES'), rt.get_constant('JSON_HEX_TAG')), rt.get_constant('JSON_HEX_AMP'))]))
	}
	if var_request.array_isset(rt.new_string('title')) {
		if rt.is_true(rt.new_bool(var_request.array_get('title').is_string())) {
			rt.set_property(var_changes, 'post_title', var_request.array_get('title'))
		} else if !(!rt.is_true(var_request.array_get('title').array_get('raw'))) {
			rt.set_property(var_changes, 'post_title', var_request.array_get('title').array_get('raw'))
		}
	}
	return mut var_changes
}

fn (mut this Class_WP_REST_Global_Styles_Controller) prepare_item_for_response(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_raw_config := rt.call_function('json_decode', [rt.get_property(var_post_mutated, 'post_content'), rt.new_bool(true)])
	mut var_is_global_styles_user_theme_json := rt.new_bool(rt.new_bool(var_raw_config.array_isset(rt.new_string('isGlobalStylesUserThemeJSON')) && rt.is_true(rt.identical(rt.new_bool(true), var_raw_config.array_get('isGlobalStylesUserThemeJSON')))))
	mut var_config := rt.new_array()
	mut var_theme_json := rt.new_null()
	if rt.is_true(var_is_global_styles_user_theme_json) {
		var_theme_json = create_wp_theme_json(var_raw_config.dup(), rt.new_string('custom'))
		var_config = rt.call_method(var_theme_json, 'get_raw_data', []rt.PhpVal{})
	}
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('id'), var_fields.dup()])) {
		var_data.array_set('id', rt.get_property(var_post_mutated, 'ID'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('title'), var_fields.dup()])) {
		var_data.array_set('title', rt.new_array())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('title.raw'), var_fields.dup()])) {
		var_data.array_get_mut('title').array_set('raw', rt.get_property(var_post_mutated, 'post_title'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('title.rendered'), var_fields.dup()])) {
		rt.call_function('add_filter', [rt.new_string('protected_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
		rt.call_function('add_filter', [rt.new_string('private_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
		var_data.array_get_mut('title').array_set('rendered', rt.call_function('get_the_title', [rt.get_property(var_post_mutated, 'ID')]))
		rt.call_function('remove_filter', [rt.new_string('protected_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
		rt.call_function('remove_filter', [rt.new_string('private_title_format'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'protected_title_format' }])])
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('settings'), var_fields.dup()])) {
		var_data.array_set('settings', if rt.is_true(rt.new_bool(!(!rt.is_true(var_config.array_get('settings'))) && rt.is_true(var_is_global_styles_user_theme_json))) { var_config.array_get('settings') } else { create_stdclass() })
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('styles'), var_fields.dup()])) {
		var_data.array_set('styles', if rt.is_true(rt.new_bool(!(!rt.is_true(var_config.array_get('styles'))) && rt.is_true(var_is_global_styles_user_theme_json))) { var_config.array_get('styles') } else { create_stdclass() })
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		mut var_links := this.prepare_links(rt.get_property(var_post_mutated, 'ID'))
		if rt.is_true(var_theme_json) {
			mut var_resolved_theme_uris := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_resolved_theme_uris(arg_0) }(var_theme_json.dup())
			if !(!rt.is_true(var_resolved_theme_uris)) {
				var_links.array_set('https://api.w.org/theme-file', var_resolved_theme_uris.dup())
			}
		}
		rt.call_method(var_response, 'add_links', [var_links.dup()])
		if !(!rt.is_true(var_links.array_get('self').array_get('href'))) {
			mut var_actions := this.get_available_actions(var_post_mutated.dup(), var_request.dup())
			mut var_self := var_links.array_get('self').array_get('href')
			{
				mut iter_1 := var_actions.iterator()
				for {
					item_1 := iter_1.next() or { break }
					mut var_rel := item_1.val
					rt.call_method(var_response, 'add_link', [var_rel.dup(), var_self.dup()])
				}
			}
		}
	}
	return var_response.dup()
}

fn (mut this Class_WP_REST_Global_Styles_Controller) prepare_links(var_id rt.PhpVal) rt.PhpVal {
	mut var_id_mutated := var_id
	mut var_base := rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base')])
	mut var_links := rt.create_array([rt.ArrayItem{ key: 'self', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.concat(rt.call_function('trailingslashit', [var_base.dup()]), var_id_mutated)]) }]) }, rt.ArrayItem{ key: 'about', val: rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', ['wp/v2/types/' + (rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type')).str()]) }]) }])
	if rt.is_true(rt.call_function('post_type_supports', [rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type'), rt.new_string('revisions')])) {
		mut var_revisions := rt.call_function('wp_get_latest_revision_id_and_total_count', [var_id_mutated.dup()])
		mut var_revisions_count := if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_wp_error', [var_revisions.dup()]))))) { var_revisions.array_get('count') } else { rt.new_int(0) }
		mut var_revisions_base := rt.call_function('sprintf', [rt.new_string('/%s/%d/revisions'), var_base.dup(), var_id_mutated.dup()])
		var_links.array_set('version-history', rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [var_revisions_base.dup()]) }, rt.ArrayItem{ key: 'count', val: var_revisions_count }]))
	}
	return var_links.dup()
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_available_actions(var_post rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_rels := rt.new_array()
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(var_post_mutated, 'post_type')])
	if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'publish_posts')])) {
		var_rels << 'https://api.w.org/action-publish'
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_css')])) {
		var_rels << 'https://api.w.org/action-edit-css'
	}
	return var_rels.dup()
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_collection_params() rt.PhpVal {
	return rt.new_array()
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'schema'))
	}
	mut var_schema := { '$schema': rt.new_string('http://json-schema.org/draft-04/schema#'), 'title': rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type'), 'type': rt.new_string('object'), 'properties': { 'id': { 'description': rt.call_function('__', [rt.new_string('ID of global styles config.')]), 'type': rt.new_string('integer'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) }, 'styles': { 'description': rt.call_function('__', [rt.new_string('Global styles.')]), 'type': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'settings': { 'description': rt.call_function('__', [rt.new_string('Global settings.')]), 'type': map[string]rt.PhpVal{}, 'context': map[string]rt.PhpVal{} }, 'title': { 'description': rt.call_function('__', [rt.new_string('Title of the global styles variation.')]), 'type': map[string]rt.PhpVal{}, 'default': rt.new_string(''), 'context': map[string]rt.PhpVal{}, 'properties': { 'raw': { 'description': rt.call_function('__', [rt.new_string('Title for the global styles variation, as it exists in the database.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{} }, 'rendered': { 'description': rt.call_function('__', [rt.new_string('HTML title for the post, transformed for display.')]), 'type': rt.new_string('string'), 'context': map[string]rt.PhpVal{}, 'readonly': rt.new_bool(true) } } } } }
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Global_Styles_Controller', ['WP_REST_Posts_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_theme_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_posts')])) {
		return true
	}
	{
		mut iter_1 := rt.call_function('get_post_types', [rt.create_array([rt.ArrayItem{ key: 'show_in_rest', val: true }]), rt.new_string('objects')]).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_post_type := item_1.val
			if rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'edit_posts')])) {
				return true
			}
		}
	}
	if rt.is_true(rt.call_function('current_user_can', [rt.new_string('edit_theme_options')])) {
		return true
	}
	return (create_wp_error(rt.new_string('rest_cannot_read_global_styles'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access the global styles on this site.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_theme_item(var_request rt.PhpVal) rt.PhpVal {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return create_wp_error(, , )
	}
	mut var_theme := 
	
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_theme_items_permissions_check(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Global_Styles_Controller) get_theme_items(var_request rt.PhpVal) rt.PhpVal {
}

fn (mut this Class_WP_REST_Global_Styles_Controller) validate_custom_css(var_css rt.PhpVal) bool {
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON {
	rt.PhpObjectBase
}

fn create_wp_rest_global_styles_controller(post_type string) &Class_WP_REST_Global_Styles_Controller {
	mut obj := &Class_WP_REST_Global_Styles_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		allow_batch: rt.new_array()
	}
	obj.construct(post_type)
	return obj
}

fn create_wp_rest_posts_controller() &Class_WP_REST_Posts_Controller {
	mut obj := &Class_WP_REST_Posts_Controller{
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

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_theme_json() &Class_WP_Theme_JSON {
	mut obj := &Class_WP_Theme_JSON{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Global_Styles_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'_sanitize_global_styles_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._sanitize_global_styles_callback(dispatch_arg_0)
		}
		'get_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post(dispatch_arg_0)
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'check_read_permission' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.check_read_permission(dispatch_arg_0)
		}
		'update_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update_item_permissions_check(dispatch_arg_0))
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
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
		'get_available_actions' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_available_actions(dispatch_arg_0, dispatch_arg_1)
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_theme_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_theme_item_permissions_check(dispatch_arg_0))
		}
		'get_theme_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_theme_item(dispatch_arg_0)
		}
		'get_theme_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_theme_items_permissions_check(dispatch_arg_0)
		}
		'get_theme_items' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_theme_items(dispatch_arg_0)
		}
		'validate_custom_css' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.validate_custom_css(dispatch_arg_0))
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Global_Styles_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Global_Styles_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'allow_batch' { this.allow_batch = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_REST_Posts_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_REST_Posts_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Posts_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_stdClass) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_stdClass) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_stdClass) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Theme_JSON) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_global_styles_controller_php() {
}

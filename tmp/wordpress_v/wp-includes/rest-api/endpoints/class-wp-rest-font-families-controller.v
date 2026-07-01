import rt

pub fn Class_WP_REST_Font_Families_Controller.latest_theme_json_version_supported() i64 {
	return 3
}
struct Class_WP_REST_Font_Families_Controller {
	rt.PhpObjectBase
pub mut:
		allow_batch rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	mut var_post_type := rt.call_function('get_post_type_object', [rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.get_property(rt.get_property(var_post_type, 'cap'), 'read')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access font families.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	mut var_post := this.get_post(var_request.array_get('id'))
	if rt.is_true(rt.call_function('is_wp_error', [var_post.dup()])) {
		return (var_post).to_bool()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [rt.new_string('read_post'), rt.get_property(var_post, 'ID')]))))) {
		return (create_wp_error(rt.new_string('rest_cannot_read'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to access this font family.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
	}
	return true
}

fn (mut this Class_WP_REST_Font_Families_Controller) validate_font_family_settings(var_value rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_args := this.get_endpoint_args_for_item_schema(rt.call_method(var_request, 'get_method', []rt.PhpVal{}))
	mut var_validity := rt.call_function('rest_validate_value_from_schema', [var_value.dup(), var_args.array_get('font_family_settings'), rt.new_string('font_family_settings')])
	if rt.is_true(rt.call_function('is_wp_error', [var_validity.dup()])) {
		return (var_validity).to_bool()
	}
	mut var_settings := rt.call_function('json_decode', [var_value.dup(), rt.new_bool(true)])
	if rt.is_true(rt.identical(rt.new_null(), var_settings)) {
		return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s parameter must be a valid JSON string.')]), rt.new_string('font_family_settings')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
	}
	mut var_schema := this.get_item_schema().array_get('properties').array_get('font_family_settings')
	mut var_required := var_schema.array_get('required')
	if var_request.array_isset(rt.new_string('id')) {
		var_schema.array_unset(rt.new_string('required'))
		if var_settings.array_isset(rt.new_string('slug')) {
			return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s cannot be updated.')]), rt.new_string('font_family_settings[slug]')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
		}
	}
	mut var_has_valid_settings := rt.call_function('rest_validate_value_from_schema', [var_settings.dup(), var_schema.dup(), rt.new_string('font_family_settings')])
	if rt.is_true(rt.call_function('is_wp_error', [var_has_valid_settings.dup()])) {
		rt.call_method(var_has_valid_settings, 'add_data', [rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }])])
		return (var_has_valid_settings).to_bool()
	}
	{
		mut iter_1 := var_required.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_key := item_1.val
			if rt.is_true(rt.new_bool(var_settings.array_isset(var_key) && rt.is_true(rt.new_bool(!(rt.is_true(var_settings.array_get(var_key))))))) {
				return (create_wp_error(rt.new_string('rest_invalid_param'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%s cannot be empty.')]), rt.new_string("font_family_settings[ ${var_key.to_string()} ]")]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))).to_bool()
			}
		}
	}
	return true
}

fn (mut this Class_WP_REST_Font_Families_Controller) sanitize_font_family_settings(var_value rt.PhpVal) rt.PhpVal {
	mut var_settings := rt.call_function('json_decode', [var_value.dup(), rt.new_bool(true)])
	mut var_schema := this.get_item_schema().array_get('properties').array_get('font_family_settings').array_get('properties')
	{
		mut iter_1 := var_settings.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_value_shadow := item_1.val
			mut var_key := item_1.key
			mut var_sanitize_callback := var_schema.array_get(var_key).array_get('arg_options').array_get('sanitize_callback')
			var_settings.array_set(var_key, rt.call_function('call_user_func', [var_sanitize_callback.dup(), var_value_shadow.dup()]))
		}
	}
	return var_settings.dup()
}

fn (mut this Class_WP_REST_Font_Families_Controller) create_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_settings := rt.call_method(var_request, 'get_param', [rt.new_string('font_family_settings')])
	mut var_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'post_type', val: rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type') }, rt.ArrayItem{ key: 'posts_per_page', val: 1 }, rt.ArrayItem{ key: 'name', val: var_settings.array_get('slug') }, rt.ArrayItem{ key: 'update_post_meta_cache', val: false }, rt.ArrayItem{ key: 'update_post_term_cache', val: false }]))
	if !(!rt.is_true(rt.get_property(var_query, 'posts'))) {
		return create_wp_error(rt.new_string('rest_duplicate_font_family'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('A font family with slug "%s" already exists.')]), var_settings.array_get('slug')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 400 }]))
	}
	return this.Class_WP_REST_Posts_Controller.create_item(var_request.dup())
}

fn (mut this Class_WP_REST_Font_Families_Controller) delete_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_force := if var_request.array_isset(rt.new_string('force')) { // unsupported expression: Expr_Cast_Bool } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(!(rt.is_true(var_force)))) {
		return create_wp_error(rt.new_string('rest_trash_not_supported'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Font faces do not support trashing. Set "%s" to delete.')]), rt.new_string('force=true')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 501 }]))
	}
	return this.Class_WP_REST_Posts_Controller.delete_item(var_request.dup())
}

fn (mut this Class_WP_REST_Font_Families_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := rt.new_array()
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('id'), var_fields.dup()])) {
		var_data.array_set('id', rt.get_property(var_item, 'ID'))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('theme_json_version'), var_fields.dup()])) {
		var_data.array_set('theme_json_version', Class_static.latest_theme_json_version_supported())
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('font_faces'), var_fields.dup()])) {
		var_data.array_set('font_faces', this.get_font_face_ids(rt.get_property(var_item, 'ID')))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('font_family_settings'), var_fields.dup()])) {
		var_data.array_set('font_family_settings', this.get_settings_from_post(var_item.dup()))
	}
	mut var_context := if !(!rt.is_true(var_request.array_get('context'))) { var_request.array_get('context') } else { rt.new_string('view') }
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	var_data = this.filter_response_by_context(var_data.dup(), var_context.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) {
		mut var_links := this.prepare_links(var_item.dup())
		rt.call_method(var_response, 'add_links', [var_links.dup()])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_wp_font_family'), var_response.dup(), var_item.dup(), var_request.dup()])
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'schema'))
	}
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type') }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'id', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Unique identifier for the post.'), rt.new_string('default')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'theme_json_version', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Version of the theme.json schema used for the typography settings.')]) }, rt.ArrayItem{ key: 'type', val: 'integer' }, rt.ArrayItem{ key: 'default', val: Class_static.latest_theme_json_version_supported() }, rt.ArrayItem{ key: 'minimum', val: 2 }, rt.ArrayItem{ key: 'maximum', val: Class_static.latest_theme_json_version_supported() }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }]) }, rt.ArrayItem{ key: 'font_faces', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The IDs of the child font faces in the font family.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'integer' }]) }]) }, rt.ArrayItem{ key: 'font_family_settings', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('font-face definition in theme.json format.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'context', val: rt.create_array([rt.ArrayItem{ key: none, val: 'view' }, rt.ArrayItem{ key: none, val: 'edit' }, rt.ArrayItem{ key: none, val: 'embed' }]) }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Name of the font family preset, translatable.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_text_field' }]) }]) }, rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Kebab-case unique identifier for the font family preset.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_title' }]) }]) }, rt.ArrayItem{ key: 'fontFamily', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('CSS font-family value.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: 'WP_Font_Utils' }, rt.ArrayItem{ key: none, val: 'sanitize_font_family' }]) }]) }]) }, rt.ArrayItem{ key: 'preview', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('URL to a preview image of the font family.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'default', val: '' }, rt.ArrayItem{ key: 'arg_options', val: rt.create_array([rt.ArrayItem{ key: 'sanitize_callback', val: 'sanitize_url' }]) }]) }]) }, rt.ArrayItem{ key: 'required', val: rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'slug' }, rt.ArrayItem{ key: none, val: 'fontFamily' }]) }, rt.ArrayItem{ key: 'additionalProperties', val: false }]) }]) }])
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'schema'))
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_public_item_schema() rt.PhpVal {
	mut var_schema := this.Class_WP_REST_Posts_Controller.get_public_item_schema()
	{
		mut iter_1 := var_schema.array_get('properties').array_get('font_family_settings').array_get('properties').iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			var_property.array_unset(rt.new_string('arg_options'))
		}
	}
	return var_schema.dup()
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_collection_params() rt.PhpVal {
	mut var_query_params := this.Class_WP_REST_Posts_Controller.get_collection_params()
	var_query_params.array_unset(rt.new_string('after'))
	var_query_params.array_unset(rt.new_string('modified_after'))
	var_query_params.array_unset(rt.new_string('before'))
	var_query_params.array_unset(rt.new_string('modified_before'))
	var_query_params.array_unset(rt.new_string('search'))
	var_query_params.array_unset(rt.new_string('search_columns'))
	var_query_params.array_unset(rt.new_string('status'))
	var_query_params.array_get_mut('orderby').array_set('default', 'id')
	var_query_params.array_get_mut('orderby').array_set('enum', rt.create_array([rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'include' }]))
	return rt.call_function('apply_filters', [rt.new_string('rest_wp_font_family_collection_params'), var_query_params.dup()])
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_endpoint_args_for_item_schema(var_method rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(Class_WP_REST_Server.creatable(), var_method)) || rt.is_true(rt.identical(Class_WP_REST_Server.editable(), var_method)))) {
		mut var_properties := this.get_item_schema().array_get('properties')
		return rt.create_array([rt.ArrayItem{ key: 'theme_json_version', val: var_properties.array_get('theme_json_version') }, rt.ArrayItem{ key: 'font_family_settings', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('font-family declaration in theme.json format, encoded as a string.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'required', val: true }, rt.ArrayItem{ key: 'validate_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'validate_font_family_settings' }]) }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'sanitize_font_family_settings' }]) }]) }])
	}
	return this.Class_WP_REST_Posts_Controller.get_endpoint_args_for_item_schema(var_method.dup())
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_font_face_ids(var_font_family_id rt.PhpVal) rt.PhpVal {
	mut var_query := create_wp_query(rt.create_array([rt.ArrayItem{ key: 'fields', val: 'ids' }, rt.ArrayItem{ key: 'post_parent', val: var_font_family_id }, rt.ArrayItem{ key: 'post_type', val: 'wp_font_face' }, rt.ArrayItem{ key: 'posts_per_page', val: 99 }, rt.ArrayItem{ key: 'order', val: 'ASC' }, rt.ArrayItem{ key: 'orderby', val: 'id' }, rt.ArrayItem{ key: 'update_post_meta_cache', val: false }, rt.ArrayItem{ key: 'update_post_term_cache', val: false }]))
	return rt.get_property(var_query, 'posts')
}

fn (mut this Class_WP_REST_Font_Families_Controller) prepare_links(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_links := this.Class_WP_REST_Posts_Controller.prepare_links(var_post_mutated.dup())
	return rt.create_array([rt.ArrayItem{ key: 'self', val: var_links.array_get('self') }, rt.ArrayItem{ key: 'collection', val: var_links.array_get('collection') }, rt.ArrayItem{ key: 'font_faces', val: this.prepare_font_face_links(rt.get_property(var_post_mutated, 'ID')) }])
}

fn (mut this Class_WP_REST_Font_Families_Controller) prepare_font_face_links(var_font_family_id rt.PhpVal) rt.PhpVal {
	mut var_font_face_ids := this.get_font_face_ids(var_font_family_id.dup())
	mut var_links := rt.new_array()
	{
		mut iter_1 := var_font_face_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_font_face_id := item_1.val
			var_links.array_push(rt.create_array([rt.ArrayItem{ key: 'embeddable', val: true }, rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%s/font-faces/%s'), rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'rest_base'), var_font_family_id.dup(), var_font_face_id.dup()])]) }]))
		}
	}
	return var_links.dup()
}

fn (mut this Class_WP_REST_Font_Families_Controller) prepare_item_for_database(var_request rt.PhpVal) rt.PhpVal {
	mut var_prepared_post := create_stdclass()
	mut var_settings := rt.call_method(var_request, 'get_param', [rt.new_string('font_family_settings')])
	if var_request.array_isset(rt.new_string('id')) {
		mut var_existing_post := this.get_post(var_request.array_get('id'))
		if rt.is_true(rt.call_function('is_wp_error', [var_existing_post.dup()])) {
			return mut rt.cast_object_ptr[Class_stdClass](var_existing_post)
		}
		rt.set_property(var_prepared_post, 'ID', rt.get_property(var_existing_post, 'ID'))
		mut var_existing_settings := this.get_settings_from_post(var_existing_post.dup())
		var_settings = rt.call_function('array_merge', [var_existing_settings.dup(), var_settings.dup()])
	}
	rt.set_property(var_prepared_post, 'post_type', rt.get_property(rt.new_object('WP_REST_Font_Families_Controller', ['WP_REST_Posts_Controller'], &this), 'post_type'))
	rt.set_property(var_prepared_post, 'post_status', rt.new_string('publish'))
	rt.set_property(var_prepared_post, 'post_title', var_settings.array_get('name'))
	rt.set_property(var_prepared_post, 'post_name', rt.call_function('sanitize_title', [var_settings.array_get('slug')]))
	var_settings.array_unset(rt.new_string('name'))
	var_settings.array_unset(rt.new_string('slug'))
	rt.set_property(var_prepared_post, 'post_content', rt.call_function('wp_json_encode', [var_settings.dup()]))
	return mut var_prepared_post
}

fn (mut this Class_WP_REST_Font_Families_Controller) get_settings_from_post(var_post rt.PhpVal) rt.PhpVal {
	mut var_post_mutated := var_post
	mut var_settings_json := rt.call_function('json_decode', [rt.get_property(var_post_mutated, 'post_content'), rt.new_bool(true)])
	return rt.create_array([rt.ArrayItem{ key: 'name', val: if rt.is_true(rt.new_bool(!(rt.get_property(var_post_mutated, 'post_title')).is_null() && rt.is_true(rt.get_property(var_post_mutated, 'post_title')))) { rt.get_property(var_post_mutated, 'post_title') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'slug', val: if rt.is_true(rt.new_bool(!(rt.get_property(var_post_mutated, 'post_name')).is_null() && rt.is_true(rt.get_property(var_post_mutated, 'post_name')))) { rt.get_property(var_post_mutated, 'post_name') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'fontFamily', val: if rt.is_true(rt.new_bool(var_settings_json.array_isset(rt.new_string('fontFamily')) && rt.is_true(var_settings_json.array_get('fontFamily')))) { var_settings_json.array_get('fontFamily') } else { rt.new_string('') } }, rt.ArrayItem{ key: 'preview', val: if rt.is_true(rt.new_bool(var_settings_json.array_isset(rt.new_string('preview')) && rt.is_true(var_settings_json.array_get('preview')))) { var_settings_json.array_get('preview') } else { rt.new_string('') } }])
}

struct Class_WP_REST_Posts_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Query {
	rt.PhpObjectBase
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_rest_font_families_controller() &Class_WP_REST_Font_Families_Controller {
	mut obj := &Class_WP_REST_Font_Families_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
		allow_batch: rt.new_bool(false)
	}
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

fn create_wp_query() &Class_WP_Query {
	mut obj := &Class_WP_Query{
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

fn (mut this Class_WP_REST_Font_Families_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'validate_font_family_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.validate_font_family_settings(dispatch_arg_0, dispatch_arg_1))
		}
		'sanitize_font_family_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize_font_family_settings(dispatch_arg_0)
		}
		'create_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.create_item(dispatch_arg_0)
		}
		'delete_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.delete_item(dispatch_arg_0)
		}
		'prepare_item_for_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.prepare_item_for_response(dispatch_arg_0, dispatch_arg_1)
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_public_item_schema' {
			return this.get_public_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'get_endpoint_args_for_item_schema' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_endpoint_args_for_item_schema(dispatch_arg_0)
		}
		'get_font_face_ids' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_font_face_ids(dispatch_arg_0)
		}
		'prepare_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_links(dispatch_arg_0)
		}
		'prepare_font_face_links' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_font_face_links(dispatch_arg_0)
		}
		'prepare_item_for_database' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.prepare_item_for_database(dispatch_arg_0)
		}
		'get_settings_from_post' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_settings_from_post(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Font_Families_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'allow_batch' { return this.allow_batch }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_REST_Font_Families_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Query) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Query) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Query) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_font_families_controller_php() {
}

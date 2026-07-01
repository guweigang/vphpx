import rt

pub fn Class_WP_REST_Themes_Controller.pattern() string {
	return '[^\\/:<>\\*\\?"\\|]+(?:\\/[^\\/:<>\\*\\?"\\|]+)?'
}
struct Class_WP_REST_Themes_Controller {
	rt.PhpObjectBase
}

fn (mut this Class_WP_REST_Themes_Controller) construct()  {
	this.dispatch_set_prop('namespace', rt.new_string('wp/v2'))
	this.dispatch_set_prop('rest_base', rt.new_string('themes'))
}

fn (mut this Class_WP_REST_Themes_Controller) register_routes()  {
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'namespace'), '/' + rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_items_permissions_check' }]) }, rt.ArrayItem{ key: 'args', val: this.get_collection_params() }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_schema' }]) }])])
	rt.call_function('register_rest_route', [rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.call_function('sprintf', [rt.new_string('/%s/(?P<stylesheet>%s)'), rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'rest_base'), Class_WP_REST_Themes_Controller.pattern()]), rt.create_array([rt.ArrayItem{ key: 'args', val: rt.create_array([rt.ArrayItem{ key: 'stylesheet', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme\'s stylesheet. This uniquely identifies the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'sanitize_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: '_sanitize_stylesheet_callback' }]) }]) }]) }, rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'methods', val: Class_WP_REST_Server.readable() }, rt.ArrayItem{ key: 'callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item' }]) }, rt.ArrayItem{ key: 'permission_callback', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_item_permissions_check' }]) }]) }, rt.ArrayItem{ key: 'schema', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'get_public_item_schema' }]) }])])
}

fn (mut this Class_WP_REST_Themes_Controller) _sanitize_stylesheet_callback(var_stylesheet rt.PhpVal) rt.PhpVal {
	return rt.call_function('urldecode', [var_stylesheet.dup()])
}

fn (mut this Class_WP_REST_Themes_Controller) get_items_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])))) {
		return true
	}
	mut var_registered := this.get_collection_params()
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_registered.array_isset(rt.new_string('status')) && var_request.array_isset(rt.new_string('status')) && rt.is_true(rt.new_bool(var_request.array_get('status').is_array())))) && rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'active' }]), var_request.array_get('status'))))) {
		return this.check_read_active_theme_permission()
	}
	return (create_wp_error(rt.new_string('rest_cannot_view_themes'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view themes.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Themes_Controller) get_item_permissions_check(var_request rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('current_user_can', [rt.new_string('switch_themes')])) || rt.is_true(rt.call_function('current_user_can', [rt.new_string('manage_network_themes')])))) {
		return true
	}
	mut var_wp_theme := rt.call_function('wp_get_theme', [var_request.array_get('stylesheet')])
	mut var_current_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	if rt.is_true(this.is_same_theme(var_wp_theme.dup(), var_current_theme.dup())) {
		return this.check_read_active_theme_permission()
	}
	return (create_wp_error(rt.new_string('rest_cannot_view_themes'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view themes.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Themes_Controller) check_read_active_theme_permission() bool {
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
	return (create_wp_error(rt.new_string('rest_cannot_view_active_theme'), rt.call_function('__', [rt.new_string('Sorry, you are not allowed to view the active theme.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: rt.call_function('rest_authorization_required_code', []rt.PhpVal{}) }]))).to_bool()
}

fn (mut this Class_WP_REST_Themes_Controller) get_item(var_request rt.PhpVal) rt.PhpVal {
	mut var_wp_theme := rt.call_function('wp_get_theme', [var_request.array_get('stylesheet')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_wp_theme, 'exists', []rt.PhpVal{}))))) {
		return create_wp_error(rt.new_string('rest_theme_not_found'), rt.call_function('__', [rt.new_string('Theme not found.')]), rt.create_array([rt.ArrayItem{ key: 'status', val: 404 }]))
	}
	mut var_data := this.prepare_item_for_response(var_wp_theme.dup(), var_request.dup())
	return rt.call_function('rest_ensure_response', [var_data.dup()])
}

fn (mut this Class_WP_REST_Themes_Controller) get_items(var_request rt.PhpVal) rt.PhpVal {
	mut var_themes := []rt.PhpVal{}
	mut var_current_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	mut var_status := var_request.array_get('status')
	if rt.is_true(rt.identical(rt.create_array([rt.ArrayItem{ key: none, val: 'active' }]), var_status)) {
		mut var_prepared := this.prepare_item_for_response(var_current_theme.dup(), var_request.dup())
		var_themes << this.prepare_response_for_collection(var_prepared.dup())
	} else {
		{
			mut iter_1 := rt.call_function('wp_get_themes', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_theme := item_1.val
				mut var_theme_status := rt.new_string(if rt.is_true(this.is_same_theme(var_theme.dup(), var_current_theme.dup())) { rt.new_string('active') } else { rt.new_string('inactive') })
				if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_status.dup().is_array())) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_theme_status.dup(), var_status.dup(), rt.new_bool(true)]))))))) {
					continue
				}
				var_prepared = this.prepare_item_for_response(var_theme.dup(), var_request.dup())
				var_themes << this.prepare_response_for_collection(var_prepared.dup())
			}
		}
	}
	mut var_response := rt.call_function('rest_ensure_response', [var_themes.dup()])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-Total'), rt.new_int(var_themes.len)])
	rt.call_method(var_response, 'header', [rt.new_string('X-WP-TotalPages'), rt.new_int(1)])
	return var_response.dup()
}

fn (mut this Class_WP_REST_Themes_Controller) prepare_item_for_response(var_item rt.PhpVal, var_request rt.PhpVal) rt.PhpVal {
	mut var_theme := var_item
	mut var_fields := this.get_fields_for_response(var_request.dup())
	mut var_data := []rt.PhpVal{}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('stylesheet'), var_fields.dup()])) {
		var_data.array_set('stylesheet', rt.call_method(var_theme, 'get_stylesheet', []rt.PhpVal{}))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('template'), var_fields.dup()])) {
		var_data.array_set('template', rt.call_method(var_theme, 'get_template', []rt.PhpVal{}))
	}
	mut var_plain_field_mappings := { 'requires_php': 'RequiresPHP', 'requires_wp': 'RequiresWP', 'textdomain': 'TextDomain', 'version': 'Version' }
	for var_field, var_header in var_plain_field_mappings {
		if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string(field), var_fields.dup()])) {
			var_data.array_set(field, rt.call_method(var_theme, 'get', [rt.new_string(header)]))
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('screenshot'), var_fields.dup()])) {
		var_data.array_set('screenshot', if rt.is_true(rt.call_method(var_theme, 'get_screenshot', []rt.PhpVal{})) { rt.call_method(var_theme, 'get_screenshot', []rt.PhpVal{}) } else { rt.new_string('') })
	}
	mut var_rich_field_mappings := { 'author': 'Author', 'author_uri': 'AuthorURI', 'description': 'Description', 'name': 'Name', 'tags': 'Tags', 'theme_uri': 'ThemeURI' }
	for var_field, var_header in var_rich_field_mappings {
		if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string("${var_field}.raw"), var_fields.dup()])) {
			var_data.array_get_mut(field).array_set('raw', rt.call_method(var_theme, 'display', [rt.new_string(header), rt.new_bool(false), rt.new_bool(true)]))
		}
		if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string("${var_field}.rendered"), var_fields.dup()])) {
			var_data.array_get_mut(field).array_set('rendered', rt.call_method(var_theme, 'display', [rt.new_string(header)]))
		}
	}
	mut var_current_theme := rt.call_function('wp_get_theme', []rt.PhpVal{})
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('status'), var_fields.dup()])) {
		var_data.array_set('status', if rt.is_true(this.is_same_theme(var_theme.dup(), var_current_theme.dup())) { 'active' } else { 'inactive' })
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('theme_supports'), var_fields.dup()])) && rt.is_true(this.is_same_theme(var_theme.dup(), var_current_theme.dup())))) {
		{
			mut iter_1 := rt.call_function('get_registered_theme_features', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_config := item_1.val
				mut var_feature := item_1.key
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_config.array_get('show_in_rest').is_array()))))) {
					continue
				}
				mut var_name := var_config.array_get('show_in_rest').array_get('name')
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string("theme_supports.${var_name.to_string()}"), var_fields.dup()]))))) {
					continue
				}
				if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [var_feature.dup()]))))) {
					var_data.array_get_mut('theme_supports').array_set(var_name, var_config.array_get('show_in_rest').array_get('schema').array_get('default'))
					continue
				}
				mut var_support := rt.call_function('get_theme_support', [var_feature.dup()])
				if var_config.array_get('show_in_rest').array_isset(rt.new_string('prepare_callback')) {
					mut var_prepare := var_config.array_get('show_in_rest').array_get('prepare_callback')
				} else {
					var_prepare = rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this) }, rt.ArrayItem{ key: none, val: 'prepare_theme_support' }])
				}
				mut var_prepared := rt.call_callable(var_prepare, [var_support.dup(), var_config.dup(), var_feature.dup(), var_request.dup()])
				if rt.is_true(rt.call_function('is_wp_error', [var_prepared.dup()])) {
					continue
				}
				var_data.array_get_mut('theme_supports').array_set(var_name, var_prepared.dup())
			}
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('is_block_theme'), var_fields.dup()])) {
		var_data.array_set('is_block_theme', rt.call_method(var_theme, 'is_block_theme', []rt.PhpVal{}))
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('stylesheet_uri'), var_fields.dup()])) {
		if rt.is_true(this.is_same_theme(var_theme.dup(), var_current_theme.dup())) {
			var_data.array_set('stylesheet_uri', rt.call_function('get_stylesheet_directory_uri', []rt.PhpVal{}))
		} else {
			var_data.array_set('stylesheet_uri', rt.call_method(var_theme, 'get_stylesheet_directory_uri', []rt.PhpVal{}))
		}
	}
	if rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('template_uri'), var_fields.dup()])) {
		if rt.is_true(this.is_same_theme(var_theme.dup(), var_current_theme.dup())) {
			var_data.array_set('template_uri', rt.call_function('get_template_directory_uri', []rt.PhpVal{}))
		} else {
			var_data.array_set('template_uri', rt.call_method(var_theme, 'get_template_directory_uri', []rt.PhpVal{}))
		}
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('default_template_types'), var_fields.dup()])) && rt.is_true(this.is_same_theme(var_theme.dup(), var_current_theme.dup())))) {
		mut var_default_template_types := []rt.PhpVal{}
		{
			mut iter_1 := rt.call_function('get_default_block_template_types', []rt.PhpVal{}).iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_template_type := item_1.val
				mut var_slug := item_1.key
				var_template_type.array_set('slug', // unsupported expression: Expr_Cast_String)
				var_default_template_types << var_template_type.dup()
			}
		}
		var_data.array_set('default_template_types', var_default_template_types.dup())
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('default_template_part_areas'), var_fields.dup()])) && rt.is_true(this.is_same_theme(var_theme.dup(), var_current_theme.dup())))) {
		var_data.array_set('default_template_part_areas', rt.call_function('get_allowed_block_template_part_areas', []rt.PhpVal{}))
	}
	var_data = this.add_additional_fields_to_object(var_data.dup(), var_request.dup())
	mut var_response := rt.call_function('rest_ensure_response', [var_data.dup()])
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_links'), var_fields.dup()])) || rt.is_true(rt.call_function('rest_is_field_included', [rt.new_string('_embedded'), var_fields.dup()])))) {
		rt.call_method(var_response, 'add_links', [this.prepare_links(var_theme.dup())])
	}
	return rt.call_function('apply_filters', [rt.new_string('rest_prepare_theme'), var_response.dup(), var_theme.dup(), var_request.dup()])
}

fn (mut this Class_WP_REST_Themes_Controller) prepare_links(var_theme rt.PhpVal) rt.PhpVal {
	mut var_theme_mutated := var_theme
	mut var_links := { 'self': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s/%s'), rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'rest_base'), rt.call_method(var_theme_mutated, 'get_stylesheet', []rt.PhpVal{})])]) }, 'collection': { 'href': rt.call_function('rest_url', [rt.call_function('sprintf', [rt.new_string('%s/%s'), rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'namespace'), rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'rest_base')])]) } }
	if rt.is_true(this.is_same_theme(var_theme_mutated.dup(), rt.call_function('wp_get_theme', []rt.PhpVal{}))) {
		mut var_id := fn () rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_user_global_styles_post_id() }()
	} else {
		mut var_user_cpt := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Theme_JSON_Resolver{}; return temp.get_user_data_from_wp_global_styles(arg_0) }(var_theme_mutated.dup())
		var_id = if !(var_user_cpt.array_get('ID')).is_null() { var_user_cpt.array_get('ID') } else { rt.new_null() }
	}
	if rt.is_true(var_id) {
		var_links['https://api.w.org/user-global-styles'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', ['wp/v2/global-styles/' + (var_id).str()]) }])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.call_method(var_theme_mutated, 'is_block_theme', []rt.PhpVal{})) && rt.is_true(this.is_same_theme(var_theme_mutated.dup(), rt.call_function('wp_get_theme', []rt.PhpVal{}))))) {
		var_links['https://api.w.org/export-theme'] = rt.create_array([rt.ArrayItem{ key: 'href', val: rt.call_function('rest_url', [rt.new_string('wp-block-editor/v1/export')]) }, rt.ArrayItem{ key: 'targetHints', val: rt.create_array([rt.ArrayItem{ key: 'allow', val: if rt.is_true(rt.call_function('current_user_can', [rt.new_string('export')])) { rt.create_array([rt.ArrayItem{ key: none, val: 'GET' }]) } else { []rt.PhpVal{} } }]) }])
	}
	return var_links.dup()
}

fn (mut this Class_WP_REST_Themes_Controller) is_same_theme(var_theme_a rt.PhpVal, var_theme_b rt.PhpVal) rt.PhpVal {
	return rt.identical(rt.call_method(var_theme_a, 'get_stylesheet', []rt.PhpVal{}), rt.call_method(var_theme_b, 'get_stylesheet', []rt.PhpVal{}))
}

fn (mut this Class_WP_REST_Themes_Controller) prepare_theme_support(var_support rt.PhpVal, var_args rt.PhpVal, var_feature rt.PhpVal, var_request rt.PhpVal) bool {
	mut var_support_mutated := var_support
	mut var_schema := var_args.array_get('show_in_rest').array_get('schema')
	if rt.is_true(rt.identical(rt.new_string('boolean'), var_schema.array_get('type'))) {
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_support_mutated.dup().is_array())) && rt.is_true(rt.new_bool(!(rt.is_true(var_args.array_get('variadic'))))))) {
		var_support_mutated = var_support_mutated.array_get(0)
	}
	return (rt.call_function('rest_sanitize_value_from_schema', [var_support_mutated.dup(), var_schema.dup()])).to_bool()
}

fn (mut this Class_WP_REST_Themes_Controller) get_item_schema() rt.PhpVal {
	if rt.is_true(rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'schema')) {
		return this.add_additional_fields_schema(rt.get_property(rt.new_object('WP_REST_Themes_Controller', ['WP_REST_Controller'], &this), 'schema'))
	}
	mut var_schema := rt.create_array([rt.ArrayItem{ key: '$schema', val: 'http://json-schema.org/draft-04/schema#' }, rt.ArrayItem{ key: 'title', val: 'theme' }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'stylesheet', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme\'s stylesheet. This uniquely identifies the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'stylesheet_uri', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The uri for the theme\'s stylesheet directory.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'template', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme\'s template. If this is a child theme, this refers to the parent theme, otherwise this is the same as the theme\'s stylesheet.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'template_uri', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The uri for the theme\'s template directory. If this is a child theme, this refers to the parent theme, otherwise this is the same as the theme\'s stylesheet directory.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'author', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme author.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'author_uri', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The website of the theme author.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }]) }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A description of the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'is_block_theme', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Whether the theme is a block-based theme.')]) }, rt.ArrayItem{ key: 'type', val: 'boolean' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'name', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The name of the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'requires_php', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The minimum PHP version required for the theme to work.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'requires_wp', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The minimum WordPress version required for the theme to work.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'screenshot', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme\'s screenshot URL.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'tags', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Tags indicating styles and features of the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }]) }]) }]) }, rt.ArrayItem{ key: 'textdomain', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme\'s text domain.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'theme_supports', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('Features supported by this theme.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: []rt.PhpVal{} }]) }, rt.ArrayItem{ key: 'theme_uri', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The URI of the theme\'s webpage.')]) }, rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'raw', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }, rt.ArrayItem{ key: 'rendered', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', []) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'format', val: 'uri' }]) }]) }]) }, rt.ArrayItem{ key: 'version', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('The theme\'s current version.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'readonly', val: true }]) }, rt.ArrayItem{ key: 'status', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A named status for the theme.')]) }, rt.ArrayItem{ key: 'type', val: 'string' }, rt.ArrayItem{ key: 'enum', val: rt.create_array([rt.ArrayItem{ key: none, val: 'inactive' }, rt.ArrayItem{ key: none, val: 'active' }]) }]) }, rt.ArrayItem{ key: 'default_template_types', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A list of default template types.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'slug', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'title', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }]) }]) }, rt.ArrayItem{ key: 'default_template_part_areas', val: rt.create_array([rt.ArrayItem{ key: 'description', val: rt.call_function('__', [rt.new_string('A list of allowed area values for template parts.')]) }, rt.ArrayItem{ key: 'type', val: 'array' }, rt.ArrayItem{ key: 'readonly', val: true }, rt.ArrayItem{ key: 'items', val: rt.create_array([rt.ArrayItem{ key: 'type', val: 'object' }, rt.ArrayItem{ key: 'properties', val: rt.create_array([rt.ArrayItem{ key: 'area', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'label', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'description', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'icon', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }, rt.ArrayItem{ key: 'area_tag', val: rt.create_array([rt.ArrayItem{ key: , val:  }]) }]) }]) }]) }]) }])
	{
		mut iter_1 := rt.call_function('get_registered_theme_features', []rt.PhpVal{}).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_config := item_1.val
			mut var_feature := item_1.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_config.array_get('show_in_rest').is_array()))))) {
				continue
			}
			mut var_name := var_config.array_get('show_in_rest').array_get('name')
			var_schema.array_get_mut('properties').array_get_mut('theme_supports').array_get_mut('properties').array_set(var_name, .array_get().array_get('schema'))
		}
	}
	this.dispatch_set_prop('schema', var_schema.dup())
	return this.add_additional_fields_schema()
}

fn (mut this Class_WP_REST_Themes_Controller) get_collection_params() rt.PhpVal {
	
}

fn (mut this Class_WP_REST_Themes_Controller) sanitize_theme_status(var_statuses rt.PhpVal, var_request rt.PhpVal, var_parameter rt.PhpVal) rt.PhpVal {
	mut var_statuses_mutated := var_statuses
}

struct Class_WP_REST_Controller {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Theme_JSON_Resolver {
	rt.PhpObjectBase
}

fn create_wp_rest_themes_controller() &Class_WP_REST_Themes_Controller {
	mut obj := &Class_WP_REST_Themes_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_rest_controller() &Class_WP_REST_Controller {
	mut obj := &Class_WP_REST_Controller{
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

fn create_wp_theme_json_resolver() &Class_WP_Theme_JSON_Resolver {
	mut obj := &Class_WP_Theme_JSON_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_REST_Themes_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'register_routes' {
			this.register_routes()
			return rt.new_null()
		}
		'_sanitize_stylesheet_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._sanitize_stylesheet_callback(dispatch_arg_0)
		}
		'get_items_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_items_permissions_check(dispatch_arg_0))
		}
		'get_item_permissions_check' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.get_item_permissions_check(dispatch_arg_0))
		}
		'check_read_active_theme_permission' {
			return rt.new_bool(this.check_read_active_theme_permission())
		}
		'get_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_item(dispatch_arg_0)
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
		'is_same_theme' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.is_same_theme(dispatch_arg_0, dispatch_arg_1)
		}
		'prepare_theme_support' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.prepare_theme_support(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3))
		}
		'get_item_schema' {
			return this.get_item_schema()
		}
		'get_collection_params' {
			return this.get_collection_params()
		}
		'sanitize_theme_status' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.sanitize_theme_status(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		else { return none }
	}
}

fn (this &Class_WP_REST_Themes_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_REST_Themes_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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


fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Theme_JSON_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Theme_JSON_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn init_registry() {
}

fn init() {
	init_registry()
}



pub fn init_wp_includes_rest_api_endpoints_class_wp_rest_themes_controller_php() {
}

import rt

struct Class_WP_Font_Collection {
	rt.PhpObjectBase
pub mut:
		slug rt.PhpVal = rt.new_null()
		data rt.PhpVal = rt.new_null()
		src rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Font_Collection) construct(slug string, mut var_args Class_array)  {
	this.slug = rt.call_function('sanitize_title', [rt.new_string(slug)])
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Font collection slug "%s" is not valid. Slugs must use only alphanumeric characters, dashes, and underscores.')]), rt.new_string(slug)]), rt.new_string('6.5.0')])
	}
	mut var_required_properties := ['name', 'font_families']
	if rt.is_true(rt.new_bool(var_args.array_isset(rt.new_string('font_families')) && rt.is_true(rt.new_bool(var_args.array_get('font_families').is_string())))) {
		this.src = var_args.array_get('font_families')
		var_args.array_unset(rt.new_string('font_families'))
		var_required_properties = ['name']
	}
	this.data = this.sanitize_and_validate_data(rt.new_object('array', []string{}, var_args), var_required_properties.dup())
}

fn (mut this Class_WP_Font_Collection) get_data() rt.PhpVal {
	if rt.is_true(rt.call_function('is_wp_error', [this.data])) {
		return this.data
	}
	if !(this.src).is_null() {
		this.data = this.load_from_json(this.src)
	}
	if rt.is_true(rt.call_function('is_wp_error', [this.data])) {
		return this.data
	}
	mut var_defaults := { 'description': rt.new_string(''), 'categories': map[string]rt.PhpVal{} }
	return rt.call_function('wp_parse_args', [this.data, var_defaults.dup()])
}

fn (mut this Class_WP_Font_Collection) load_from_json(var_file_or_url rt.PhpVal) rt.PhpVal {
	mut var_url := rt.call_function('wp_http_validate_url', [var_file_or_url.dup()])
	mut var_file := if rt.is_true(rt.call_function('file_exists', [var_file_or_url.dup()])) { rt.call_function('wp_normalize_path', [rt.call_function('realpath', [var_file_or_url.dup()])]) } else { rt.new_bool(false) }
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_url)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_file)))))) {
		mut var_message := rt.call_function('__', [rt.new_string('Font collection JSON file is invalid or does not exist.')])
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_message.dup(), rt.new_string('6.5.0')])
		return create_wp_error(rt.new_string('font_collection_json_missing'), var_message.dup())
	}
	mut var_data := if rt.is_true(var_url) { this.load_from_url(var_url.dup()) } else { this.load_from_file(var_file.dup()) }
	if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
		return var_data.dup()
	}
	var_data = rt.create_array([rt.ArrayItem{ key: 'name', val: this.data.array_get('name') }, rt.ArrayItem{ key: 'font_families', val: var_data.array_get('font_families') }])
	if this.data.array_isset(rt.new_string('description')) {
		var_data.array_set('description', this.data.array_get('description'))
	}
	if this.data.array_isset(rt.new_string('categories')) {
		var_data.array_set('categories', this.data.array_get('categories'))
	}
	return var_data.dup()
}

fn (mut this Class_WP_Font_Collection) load_from_file(var_file rt.PhpVal) rt.PhpVal {
	mut var_file_mutated := var_file
	mut var_data := rt.call_function('wp_json_file_decode', [var_file_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'associative', val: true }])])
	if !rt.is_true(var_data) {
		return create_wp_error(rt.new_string('font_collection_decode_error'), rt.call_function('__', [rt.new_string('Error decoding the font collection JSON file contents.')]))
	}
	return this.sanitize_and_validate_data(var_data.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'font_families' }]))
}

fn (mut this Class_WP_Font_Collection) load_from_url(var_url rt.PhpVal) rt.PhpVal {
	mut var_url_mutated := var_url
	mut var_transient_key := rt.call_function('substr', ['wp_font_collection_url_' + (var_url_mutated).str(), rt.new_int(0), rt.new_int(167)])
	mut var_data := rt.call_function('get_site_transient', [var_transient_key.dup()])
	if rt.is_true(rt.identical(rt.new_bool(false), var_data)) {
		mut var_response := rt.call_function('wp_safe_remote_get', [var_url_mutated.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_response.dup()])) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
			return create_wp_error(rt.new_string('font_collection_request_error'), rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Error fetching the font collection data from "%s".')]), var_url_mutated.dup()]))
		}
		var_data = rt.call_function('json_decode', [rt.call_function('wp_remote_retrieve_body', [var_response.dup()]), rt.new_bool(true)])
		if !rt.is_true(var_data) {
			return create_wp_error(rt.new_string('font_collection_decode_error'), rt.call_function('__', [rt.new_string('Error decoding the font collection data from the HTTP response JSON.')]))
		}
		var_data = this.sanitize_and_validate_data(var_data.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'font_families' }]))
		if rt.is_true(rt.call_function('is_wp_error', [var_data.dup()])) {
			return var_data.dup()
		}
		rt.call_function('set_site_transient', [var_transient_key.dup(), var_data.dup(), rt.get_constant('DAY_IN_SECONDS')])
	}
	return var_data.dup()
}

fn (mut this Class_WP_Font_Collection) sanitize_and_validate_data(var_data rt.PhpVal, var_required_properties rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_required_properties_mutated := var_required_properties
	mut var_schema := Class_WP_Font_Collection.get_sanitization_schema()
	var_data_mutated = fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_WP_Font_Utils{}; return temp.sanitize_from_schema(arg_0, arg_1) }(var_data_mutated.dup(), var_schema.dup())
	{
		mut iter_1 := var_required_properties_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_property := item_1.val
			if !rt.is_true(var_data_mutated.array_get(var_property)) {
				mut var_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Font collection "%1$s" has missing or empty property: "%2$s".')]), this.slug, var_property.dup()])
				rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_message.dup(), rt.new_string('6.5.0')])
				return create_wp_error(rt.new_string('font_collection_missing_property'), var_message.dup())
			}
		}
	}
	return var_data_mutated.dup()
}

fn Class_WP_Font_Collection.get_sanitization_schema() rt.PhpVal {
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return rt.call_function('_wp_to_kebab_case', [rt.call_function('sanitize_title', [var_value.dup()])])
	}
	mut var_value := if args.len > 0 { args[0].dup() } else { rt.new_null() }
	return if rt.is_true(rt.new_bool(var_value.dup().is_array())) { rt.call_function('array_map', [rt.new_string('sanitize_text_field'), var_value.dup()]) } else { rt.call_function('sanitize_text_field', [var_value.dup()]) }
	}
	return rt.create_array([rt.ArrayItem{ key: 'name', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'description', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'font_families', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'font_family_settings', val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'slug', val: rt.new_closure(closure_1_fn) }, rt.ArrayItem{ key: 'fontFamily', val: 'WP_Font_Utils::sanitize_font_family' }, rt.ArrayItem{ key: 'preview', val: 'sanitize_url' }, rt.ArrayItem{ key: 'fontFace', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'fontFamily', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'fontStyle', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'fontWeight', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'src', val: rt.new_closure(closure_2_fn) }, rt.ArrayItem{ key: 'preview', val: 'sanitize_url' }, rt.ArrayItem{ key: 'fontDisplay', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'fontStretch', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'ascentOverride', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'descentOverride', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'fontVariant', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'fontFeatureSettings', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'fontVariationSettings', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'lineGapOverride', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'sizeAdjust', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'unicodeRange', val: 'sanitize_text_field' }]) }]) }]) }, rt.ArrayItem{ key: 'categories', val: rt.create_array([rt.ArrayItem{ key: none, val: 'sanitize_title' }]) }]) }]) }, rt.ArrayItem{ key: 'categories', val: rt.create_array([rt.ArrayItem{ key: none, val: rt.create_array([rt.ArrayItem{ key: 'name', val: 'sanitize_text_field' }, rt.ArrayItem{ key: 'slug', val: 'sanitize_title' }]) }]) }])
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Font_Utils {
	rt.PhpObjectBase
}

fn create_wp_font_collection(slug string, arg_1 rt.PhpVal) &Class_WP_Font_Collection {
	mut obj := &Class_WP_Font_Collection{
		PhpObjectBase: rt.PhpObjectBase{}
		slug: rt.new_null()
		data: rt.new_null()
		src: rt.new_null()
	}
	obj.construct(slug, arg_1)
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_font_utils() &Class_WP_Font_Utils {
	mut obj := &Class_WP_Font_Utils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Font_Collection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			this.construct(dispatch_arg_0, mut dispatch_arg_1)
			return rt.new_null()
		}
		'get_data' {
			return this.get_data()
		}
		'load_from_json' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.load_from_json(dispatch_arg_0)
		}
		'load_from_file' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.load_from_file(dispatch_arg_0)
		}
		'load_from_url' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.load_from_url(dispatch_arg_0)
		}
		'sanitize_and_validate_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.sanitize_and_validate_data(dispatch_arg_0, dispatch_arg_1)
		}
		'get_sanitization_schema' {
			return Class_WP_Font_Collection.get_sanitization_schema()
		}
		else { return none }
	}
}

fn (this &Class_WP_Font_Collection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'slug' { return this.slug }
		'data' { return this.data }
		'src' { return this.src }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Font_Collection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'slug' { this.slug = val; return true }
		'data' { this.data = val; return true }
		'src' { this.src = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Font_Utils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Font_Utils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Font_Utils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_fonts_class_wp_font_collection_php() {
}

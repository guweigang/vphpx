import rt

struct Class_WC_Settings_API {
	rt.PhpObjectBase
pub mut:
		plugin_id rt.PhpVal = rt.new_string('woocommerce_')
		id rt.PhpVal = rt.new_string('')
		errors rt.PhpVal = rt.new_array()
		settings rt.PhpVal = rt.new_array()
		form_fields rt.PhpVal = rt.new_array()
		data rt.PhpVal = rt.new_array()
}

fn (mut this Class_WC_Settings_API) get_form_fields() rt.PhpVal {
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_api_form_fields_' + (this.id).str()), rt.call_function('array_map', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'set_defaults' }]), this.form_fields])])
}

fn (mut this Class_WC_Settings_API) set_defaults(var_field rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	if !(var_field_mutated.array_isset(rt.new_string('default'))) {
		var_field_mutated.array_set('default', '')
	}
	return var_field_mutated.clone()
}

fn (mut this Class_WC_Settings_API) admin_options() {
	print('<table class="form-table">' + (this.generate_settings_html(this.get_form_fields(), false)).str() + '</table>')
}

fn (mut this Class_WC_Settings_API) init_form_fields() {
}

fn (mut this Class_WC_Settings_API) get_option_key() string {
	return (this.plugin_id).str() + (this.id).str() + '_settings'
}

fn (mut this Class_WC_Settings_API) get_field_type(var_field rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	return if !rt.is_true(var_field_mutated.array_get(rt.new_string('type'))) { rt.new_string('text') } else { var_field_mutated.array_get(rt.new_string('type')) }
}

fn (mut this Class_WC_Settings_API) get_field_default(var_field rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	return if !rt.is_true(var_field_mutated.array_get(rt.new_string('default'))) { rt.new_string('') } else { var_field_mutated.array_get(rt.new_string('default')) }
}

fn (mut this Class_WC_Settings_API) get_field_value(var_key rt.PhpVal, var_field rt.PhpVal, var_post_data rt.PhpVal) rt.PhpVal {
	mut var_field_mutated := var_field
	mut var_post_data_mutated := var_post_data
	mut var_type := this.get_field_type(var_field_mutated.clone())
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	var_post_data_mutated = if !rt.is_true(var_post_data_mutated) { rt.get_superglobal('_POST') } else { var_post_data_mutated }
	mut var_value := if var_post_data_mutated.array_isset(var_field_key) { var_post_data_mutated.array_get(var_field_key) } else { rt.new_null() }
	if var_field_mutated.array_isset(rt.new_string('sanitize_callback')) && rt.call_function('is_callable', [var_field_mutated.array_get(rt.new_string('sanitize_callback'))]) {
		return rt.call_function('call_user_func', [var_field_mutated.array_get(rt.new_string('sanitize_callback')), var_value.clone()])
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'validate_' + (var_key).str() + '_field' }])])) {
		return rt.call_method(rt.new_object('WC_Settings_API', []string{}, &this), 'validate_' + (var_key).str() + '_field', [var_key.clone(), var_value.clone()])
	}
	if rt.is_true(rt.call_function('is_callable', [rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WC_Settings_API', []string{}, &this) }, rt.ArrayItem{ key: none, val: 'validate_' + (var_type).str() + '_field' }])])) {
		return rt.call_method(rt.new_object('WC_Settings_API', []string{}, &this), 'validate_' + (var_type).str() + '_field', [var_key.clone(), var_value.clone()])
	}
	return this.validate_text_field(var_key.clone(), var_value.clone())
}

fn (mut this Class_WC_Settings_API) set_post_data(var_data rt.PhpVal) {
	mut var_data_mutated := var_data
	this.data = var_data_mutated.clone()
}

fn (mut this Class_WC_Settings_API) get_post_data() rt.PhpVal {
	if !(!rt.is_true(this.data)) && this.data.is_array() {
		return this.data
	}
	return rt.get_superglobal('_POST').clone()
	return rt.new_null()
}

fn (mut this Class_WC_Settings_API) update_option(var_key rt.PhpVal, value string) rt.PhpVal {
	mut value_mutated := value
	if !rt.is_true(this.settings) {
		this.init_settings()
	}
	this.settings.array_set(var_key, value_mutated)
	return rt.call_function('update_option', [rt.new_string(this.get_option_key()), rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_api_sanitized_fields_' + (this.id).str()), this.settings]), rt.new_string('yes')])
}

fn (mut this Class_WC_Settings_API) process_admin_options() rt.PhpVal {
	this.init_settings()
	mut var_post_data := this.get_post_data()
	mut iter_1 := this.get_form_fields().iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_field := item_1.val
		mut var_key := item_1.key
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('title'), this.get_field_type(var_field.clone()))))) {
			this.settings.array_set(var_key, this.get_field_value(var_key.clone(), var_field.clone(), var_post_data.clone()))
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			if rt.is_true(rt.identical(rt.new_string('select'), var_field.array_get(rt.new_string('type')))) || rt.is_true(rt.identical(rt.new_string('checkbox'), var_field.array_get(rt.new_string('type')))) {
				rt.call_function('do_action', [rt.new_string('woocommerce_update_non_option_setting'), rt.create_array([rt.ArrayItem{ key: 'id', val: var_key }, rt.ArrayItem{ key: 'type', val: var_field.array_get(rt.new_string('type')) }, rt.ArrayItem{ key: 'value', val: this.settings.array_get(var_key) }])])
				if rt.has_exception() { unsafe { goto catch_label_1 } }
			}
			if rt.has_exception() { unsafe { goto catch_label_1 } }
			unsafe { goto end_label_1 }

catch_label_1:
			mut var_e_1 := rt.get_and_clear_exception()
			if rt.instance_of(var_e_1, 'Exception') {
				mut var_e := var_e_1.clone()
				this.add_error(rt.call_method(var_e, 'getMessage', []rt.PhpVal{}))
				unsafe { goto end_label_1 }
			}
			else {
				rt.throw_exception(var_e_1)
				unsafe { goto end_label_1 }
			}

end_label_1:
		}
	}
	mut var_option_key := rt.new_string(this.get_option_key())
	rt.call_function('do_action', [rt.new_string('woocommerce_update_option'), rt.create_array([rt.ArrayItem{ key: 'id', val: var_option_key }])])
	return rt.call_function('update_option', [var_option_key.clone(), rt.call_function('apply_filters', [rt.new_string('woocommerce_settings_api_sanitized_fields_' + (this.id).str()), this.settings]), rt.new_string('yes')])
	return rt.new_null()
}

fn (mut this Class_WC_Settings_API) add_error(var_error rt.PhpVal) {
	this.errors.array_push(var_error.clone())
}

fn (mut this Class_WC_Settings_API) get_errors() rt.PhpVal {
	return this.errors
}

fn (mut this Class_WC_Settings_API) display_errors() {
	if rt.is_true(this.get_errors()) {
		print('<div id="woocommerce_errors" class="error notice is-dismissible">')
		mut iter_2 := this.get_errors().iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_error := item_2.val
			print('<p>' + (rt.call_function('wp_kses_post', [var_error.clone()])).str() + '</p>')
		}
		print('</div>')
	}
}

fn (mut this Class_WC_Settings_API) init_settings() {
	this.settings = rt.call_function('get_option', [rt.new_string(this.get_option_key()), rt.new_null()])
	if !(this.settings.is_array()) {
		mut var_form_fields := this.get_form_fields()
		this.settings = rt.call_function('array_merge', [rt.call_function('array_fill_keys', [rt.func_array_keys(var_form_fields.clone()), rt.new_string('')]), rt.call_function('wp_list_pluck', [var_form_fields.clone(), rt.new_string('default')])])
	}
}

fn (mut this Class_WC_Settings_API) get_option(var_key rt.PhpVal, var_empty_value rt.PhpVal) rt.PhpVal {
	if !rt.is_true(this.settings) {
		this.init_settings()
	}
	if !(this.settings.array_isset(var_key)) {
		mut var_form_fields := this.get_form_fields()
		this.settings.array_set(var_key, if var_form_fields.array_isset(var_key) { this.get_field_default(var_form_fields.array_get(var_key)) } else { rt.new_string('') })
	}
	if !(var_empty_value.clone().is_null()) && rt.is_true(rt.identical(rt.new_string(''), this.settings.array_get(var_key))) {
		this.settings.array_set(var_key, var_empty_value.clone())
	}
	return this.settings.array_get(var_key)
}

fn (mut this Class_WC_Settings_API) get_field_key(var_key rt.PhpVal) string {
	return (this.plugin_id).str() + (this.id).str() + '_' + (var_key).str()
}

fn (mut this Class_WC_Settings_API) generate_settings_html(var_form_fields rt.PhpVal, echo bool) rt.PhpVal {
	mut var_form_fields_mutated := var_form_fields
	if !rt.is_true(var_form_fields_mutated) {
	var_form_fields_mutated = this.get_form_fields()
	}
	mut var_html := rt.new_string('')
	mut iter_3 := var_form_fields_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_v := item_3.val
		mut var_k := item_3.key
		mut var_type := this.get_field_type(var_v.clone())
		if rt.is_true(rt.call_function('method_exists', [rt.new_object('WC_Settings_API', []string{}, &this), rt.new_string('generate_' + (var_type).str() + '_html')])) {
			var_html = rt.concat(var_html, rt.call_method(rt.new_object('WC_Settings_API', []string{}, &this), 'generate_' + (var_type).str() + '_html', [var_k.clone(), var_v.clone()]))
		} else if rt.is_true(rt.call_function('has_filter', [rt.new_string('woocommerce_generate_' + (var_type).str() + '_html')])) {
			var_html = rt.concat(var_html, rt.call_function('apply_filters', [rt.new_string('woocommerce_generate_' + (var_type).str() + '_html'), rt.new_string(''), var_k.clone(), var_v.clone(), rt.new_object('WC_Settings_API', []string{}, &this)]))
		} else {
			var_html = rt.concat(var_html, this.generate_text_html(var_k.clone(), var_v.clone()))
		}
	}
	if var_echo {
		rt.echo_val(var_html)
	} else {
		return var_html.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WC_Settings_API) get_tooltip_html(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.new_bool(true), var_data_mutated.array_get(rt.new_string('desc_tip')))) {
	mut var_tip := var_data_mutated.array_get(rt.new_string('description'))
	} else if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('desc_tip')))) {
	var_tip = var_data_mutated.array_get(rt.new_string('desc_tip'))
	} else {
	var_tip = rt.new_string('')
	}
	return if rt.is_true(var_tip) { rt.call_function('wc_help_tip', [var_tip.clone(), rt.new_bool(true)]) } else { rt.new_string('') }
}

fn (mut this Class_WC_Settings_API) get_description_html(var_data rt.PhpVal) string {
	mut var_data_mutated := var_data
	if rt.is_true(rt.identical(rt.new_bool(true), var_data_mutated.array_get(rt.new_string('desc_tip')))) {
	mut var_description := rt.new_string('')
	} else if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('desc_tip')))) {
	var_description = var_data_mutated.array_get(rt.new_string('description'))
	} else if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('description')))) {
	var_description = var_data_mutated.array_get(rt.new_string('description'))
	} else {
	var_description = rt.new_string('')
	}
	return if rt.is_true(var_description) { '<p class="description">' + (rt.call_function('wp_kses_post', [var_description.clone()])).str() + '</p>' + '\n' } else { '' }
}

fn (mut this Class_WC_Settings_API) get_custom_attribute_html(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_custom_attributes := []rt.PhpVal{}
	if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('custom_attributes')))) && var_data_mutated.array_get(rt.new_string('custom_attributes')).is_array() {
		mut iter_4 := var_data_mutated.array_get(rt.new_string('custom_attributes')).iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_attribute_value := item_4.val
			mut var_attribute := item_4.key
			var_custom_attributes << (rt.call_function('esc_attr', [var_attribute.clone()])).str() + '="' + (rt.call_function('esc_attr', [var_attribute_value.clone()])).str() + '"'
		}
	}
	return rt.call_function('implode', [rt.new_string(' '), rt.create_array_from_list(var_custom_attributes)])
}

fn (mut this Class_WC_Settings_API) generate_text_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'placeholder': rt.new_string(''), 'type': rt.new_string('text'), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('type'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_option(var_key.clone(), rt.new_null())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('placeholder'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_safe_text_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	var_data_mutated.array_set('type', 'text')
	return this.generate_text_html(var_key.clone(), var_data_mutated.clone())
}

fn (mut this Class_WC_Settings_API) generate_price_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'placeholder': rt.new_string(''), 'type': rt.new_string('text'), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_price', [this.get_option(var_key.clone(), rt.new_null())])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('placeholder'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_decimal_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'placeholder': rt.new_string(''), 'type': rt.new_string('text'), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [rt.call_function('wc_format_localized_decimal', [this.get_option(var_key.clone(), rt.new_null())])]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('placeholder'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_password_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	var_data_mutated.array_set('type', 'password')
	return this.generate_text_html(var_key.clone(), var_data_mutated.clone())
}

fn (mut this Class_WC_Settings_API) generate_color_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'placeholder': rt.new_string(''), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_option(var_key.clone(), rt.new_null())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_option(var_key.clone(), rt.new_null())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('placeholder'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_textarea_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'placeholder': rt.new_string(''), 'type': rt.new_string('text'), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('type'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('placeholder'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_textarea', [this.get_option(var_key.clone(), rt.new_null())]))
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_checkbox_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'label': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'type': rt.new_string('text'), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data_mutated.array_get(rt.new_string('label')))))) {
		var_data_mutated.array_set('label', var_data_mutated.array_get(rt.new_string('title')))
	}
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [this.get_option(var_key.clone(), rt.new_null()), rt.new_string('yes')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('label'))]))
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_select_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'placeholder': rt.new_string(''), 'type': rt.new_string('text'), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{}, 'options': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	mut var_value := this.get_option(var_key.clone(), rt.new_null())
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	mut iter_5 := rt.cast_array(var_data_mutated.array_get(rt.new_string('options'))).iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_option_value := item_5.val
		mut var_option_key := item_5.key
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(var_option_value.clone().is_array())) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			mut iter_6 := var_option_value.iterator()
			for {
				item_6 := iter_6.next() or { break }
				mut var_option_value_inner := item_6.val
				mut var_option_key_inner := item_6.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_option_key_inner.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [rt.new_string((var_option_key_inner).str()), rt.call_function('esc_attr', [var_value.clone()])])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_option_value_inner.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.new_string((var_option_key).str()), rt.call_function('esc_attr', [var_value.clone()])])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_option_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_multiselect_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'disabled': rt.new_bool(false), 'class': rt.new_string(''), 'css': rt.new_string(''), 'placeholder': rt.new_string(''), 'type': rt.new_string('text'), 'desc_tip': rt.new_bool(false), 'description': rt.new_string(''), 'custom_attributes': []rt.PhpVal{}, 'select_buttons': rt.new_bool(false), 'options': []rt.PhpVal{} }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	mut var_value := rt.cast_array(this.get_option(var_key.clone(), []rt.PhpVal{}))
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_tooltip_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('css'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('disabled', [var_data_mutated.array_get(rt.new_string('disabled')), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_custom_attribute_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	mut iter_7 := rt.cast_array(var_data_mutated.array_get(rt.new_string('options'))).iterator()
	for {
		item_7 := iter_7.next() or { break }
		mut var_option_value := item_7.val
		mut var_option_key := item_7.key
		// unsupported statement: Stmt_InlineHTML
		if rt.is_true(rt.new_bool(var_option_value.clone().is_array())) {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			mut iter_8 := var_option_value.iterator()
			for {
				item_8 := iter_8.next() or { break }
				mut var_option_value_inner := item_8.val
				mut var_option_key_inner := item_8.key
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_attr', [var_option_key_inner.clone()]))
				// unsupported statement: Stmt_InlineHTML
				rt.call_function('selected', [rt.call_function('in_array', [rt.new_string((var_option_key_inner).str()), var_value.clone(), rt.new_bool(true)]), rt.new_bool(true)])
				// unsupported statement: Stmt_InlineHTML
				rt.echo_val(rt.call_function('esc_html', [var_option_value_inner.clone()]))
				// unsupported statement: Stmt_InlineHTML
			}
			// unsupported statement: Stmt_InlineHTML
		} else {
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_attr', [var_option_key.clone()]))
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [rt.call_function('in_array', [rt.new_string((var_option_key).str()), var_value.clone(), rt.new_bool(true)]), rt.new_bool(true)])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [var_option_value.clone()]))
			// unsupported statement: Stmt_InlineHTML
		}
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	print(this.get_description_html(var_data_mutated.clone()))
	// unsupported statement: Stmt_InlineHTML
	if rt.is_true(var_data_mutated.array_get(rt.new_string('select_buttons'))) {
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Select all'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
		rt.call_function('esc_html_e', [rt.new_string('Select none'), rt.new_string('woocommerce')])
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) generate_title_html(var_key rt.PhpVal, var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
	mut var_field_key := rt.new_string(this.get_field_key(var_key.clone()))
	mut var_defaults := { 'title': rt.new_string(''), 'class': rt.new_string('') }
	var_data_mutated = rt.call_function('wp_parse_args', [var_data_mutated.clone(), rt.create_array_from_native_map(var_defaults)])
	rt.call_function('ob_start', []rt.PhpVal{})
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_data_mutated.array_get(rt.new_string('class'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [var_field_key.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	if !(!rt.is_true(var_data_mutated.array_get(rt.new_string('description')))) {
		// unsupported statement: Stmt_InlineHTML
		rt.echo_val(rt.call_function('wp_kses_post', [var_data_mutated.array_get(rt.new_string('description'))]))
		// unsupported statement: Stmt_InlineHTML
	}
	// unsupported statement: Stmt_InlineHTML
	return rt.call_function('ob_get_clean', []rt.PhpVal{})
}

fn (mut this Class_WC_Settings_API) validate_text_field(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() { rt.new_string('') } else { var_value_mutated }
	return rt.call_function('wp_kses_post', [rt.new_string(rt.call_function('stripslashes', [var_value_mutated.clone()]).to_string().trim_space())])
}

fn (mut this Class_WC_Settings_API) validate_safe_text_field(key string, mut var_value Class_?string) string {
	mut var_value_mutated := var_value
	return (rt.call_method(rt.call_method(rt.call_function('wc_get_container', []rt.PhpVal{}), 'get', [Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer.class()]), 'sanitize', [rt.new_string((var_value_mutated).str()), Class_Automattic_WooCommerce_Internal_Utilities_HtmlSanitizer.low_html_balanced_tags_no_links()])).str()
}

fn (mut this Class_WC_Settings_API) validate_price_field(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() { rt.new_string('') } else { var_value_mutated }
	return if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [rt.new_string(rt.call_function('stripslashes', [var_value_mutated.clone()]).to_string().trim_space())]) }
}

fn (mut this Class_WC_Settings_API) validate_decimal_field(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() { rt.new_string('') } else { var_value_mutated }
	return if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated)) { rt.new_string('') } else { rt.call_function('wc_format_decimal', [rt.new_string(rt.call_function('stripslashes', [var_value_mutated.clone()]).to_string().trim_space())]) }
}

fn (mut this Class_WC_Settings_API) validate_password_field(var_key rt.PhpVal, var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() { rt.new_string('') } else { var_value_mutated }
	return rt.call_function('stripslashes', [var_value_mutated.clone()]).to_string().trim_space()
}

fn (mut this Class_WC_Settings_API) validate_textarea_field(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() { rt.new_string('') } else { var_value_mutated }
	return rt.call_function('wp_kses_post', [rt.new_string(rt.call_function('stripslashes', [var_value_mutated.clone()]).to_string().trim_space())])
}

fn (mut this Class_WC_Settings_API) validate_checkbox_field(var_key rt.PhpVal, var_value rt.PhpVal) string {
	mut var_value_mutated := var_value
	return if !(var_value_mutated.clone().is_null()) { 'yes' } else { 'no' }
}

fn (mut this Class_WC_Settings_API) validate_select_field(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	var_value_mutated = if var_value_mutated.clone().is_null() { rt.new_string('') } else { var_value_mutated }
	return rt.call_function('wc_clean', [rt.call_function('stripslashes', [var_value_mutated.clone()])])
}

fn (mut this Class_WC_Settings_API) validate_multiselect_field(var_key rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return if var_value_mutated.clone().is_array() { rt.call_function('array_map', [rt.new_string('wc_clean'), rt.call_function('array_map', [rt.new_string('stripslashes'), var_value_mutated.clone()])]) } else { rt.new_string('') }
}

fn (mut this Class_WC_Settings_API) validate_settings_fields(var_form_fields rt.PhpVal) {
	mut var_form_fields_mutated := var_form_fields
	rt.call_function('wc_deprecated_function', [rt.new_string('validate_settings_fields'), rt.new_string('2.6')])
}

fn (mut this Class_WC_Settings_API) format_settings(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	rt.call_function('wc_deprecated_function', [rt.new_string('format_settings'), rt.new_string('2.6')])
	return var_value_mutated.clone()
}

fn create_wc_settings_api(_args ...rt.PhpVal) &Class_WC_Settings_API {
	mut obj := &Class_WC_Settings_API{
		PhpObjectBase: rt.PhpObjectBase{}
		plugin_id: rt.new_string('woocommerce_')
		id: rt.new_string('')
		errors: rt.new_array()
		settings: rt.new_array()
		form_fields: rt.new_array()
		data: rt.new_array()
	}
	return obj
}

fn (mut this Class_WC_Settings_API) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_form_fields' {
			return this.get_form_fields()
		}
		'set_defaults' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.set_defaults(dispatch_arg_0)
		}
		'admin_options' {
			this.admin_options()
			return rt.new_null()
		}
		'init_form_fields' {
			this.init_form_fields()
			return rt.new_null()
		}
		'get_option_key' {
			return rt.new_string(this.get_option_key())
		}
		'get_field_type' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_field_type(dispatch_arg_0)
		}
		'get_field_default' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_field_default(dispatch_arg_0)
		}
		'get_field_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.get_field_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_post_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.set_post_data(dispatch_arg_0)
			return rt.new_null()
		}
		'get_post_data' {
			return this.get_post_data()
		}
		'update_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.update_option(dispatch_arg_0, dispatch_arg_1)
		}
		'process_admin_options' {
			return this.process_admin_options()
		}
		'add_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.add_error(dispatch_arg_0)
			return rt.new_null()
		}
		'get_errors' {
			return this.get_errors()
		}
		'display_errors' {
			this.display_errors()
			return rt.new_null()
		}
		'init_settings' {
			this.init_settings()
			return rt.new_null()
		}
		'get_option' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_option(dispatch_arg_0, dispatch_arg_1)
		}
		'get_field_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_field_key(dispatch_arg_0))
		}
		'generate_settings_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.generate_settings_html(dispatch_arg_0, dispatch_arg_1)
		}
		'get_tooltip_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_tooltip_html(dispatch_arg_0)
		}
		'get_description_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_description_html(dispatch_arg_0))
		}
		'get_custom_attribute_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_custom_attribute_html(dispatch_arg_0)
		}
		'generate_text_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_text_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_safe_text_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_safe_text_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_price_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_price_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_decimal_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_decimal_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_password_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_password_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_color_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_color_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_textarea_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_textarea_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_checkbox_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_checkbox_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_select_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_select_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_multiselect_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_multiselect_html(dispatch_arg_0, dispatch_arg_1)
		}
		'generate_title_html' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.generate_title_html(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_text_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_text_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_safe_text_field' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_?string](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_string(this.validate_safe_text_field(dispatch_arg_0, mut dispatch_arg_1))
		}
		'validate_price_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_price_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_decimal_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_decimal_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_password_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.validate_password_field(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_textarea_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_textarea_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_checkbox_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_string(this.validate_checkbox_field(dispatch_arg_0, dispatch_arg_1))
		}
		'validate_select_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_select_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_multiselect_field' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.validate_multiselect_field(dispatch_arg_0, dispatch_arg_1)
		}
		'validate_settings_fields' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.validate_settings_fields(dispatch_arg_0)
			return rt.new_null()
		}
		'format_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.format_settings(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WC_Settings_API) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugin_id' { return this.plugin_id }
		'id' { return this.id }
		'errors' { return this.errors }
		'settings' { return this.settings }
		'form_fields' { return this.form_fields }
		'data' { return this.data }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_API) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugin_id' { this.plugin_id = val; return true }
		'id' { this.id = val; return true }
		'errors' { this.errors = val; return true }
		'settings' { this.settings = val; return true }
		'form_fields' { this.form_fields = val; return true }
		'data' { this.data = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn init_registry() {
}

fn init() {
	init_registry()
}


fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')])) || rt.is_true(exit(0)))
}

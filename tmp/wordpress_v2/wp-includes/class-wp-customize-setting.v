import rt

struct Class_WP_Customize_Setting {
	rt.PhpObjectBase
pub mut:
	manager                        rt.PhpVal = rt.new_null()
	id                             rt.PhpVal = rt.new_null()
	prop_type                      rt.PhpVal = rt.new_string('theme_mod')
	capability                     rt.PhpVal = rt.new_string('edit_theme_options')
	theme_supports                 rt.PhpVal = rt.new_string('')
	default                        rt.PhpVal = rt.new_string('')
	transport                      rt.PhpVal = rt.new_string('refresh')
	validate_callback              rt.PhpVal = rt.new_string('')
	sanitize_callback              rt.PhpVal = rt.new_string('')
	sanitize_js_callback           rt.PhpVal = rt.new_string('')
	dirty                          rt.PhpVal = rt.new_bool(false)
	id_data                        rt.PhpVal = rt.new_array()
	is_previewed                   bool
	is_multidimensional_aggregated bool
	_previewed_blog_id             rt.PhpVal = rt.new_null()
	_original_value                rt.PhpVal = rt.new_null()
}

fn init_static_wp_customize_setting() {
	rt.init_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals', rt.new_array())
}

fn (mut this Class_WP_Customize_Setting) construct(var_manager rt.PhpVal, var_id rt.PhpVal, var_args rt.PhpVal) {
	mut var_keys := rt.func_array_keys(rt.call_function('get_object_vars', [
		rt.new_object('WP_Customize_Setting', []string{}, &this),
	]))
	mut iter_1 := var_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if var_args.array_isset(var_key) {
			this.dispatch_set_prop('{"nodeType":"Expr_Variable","line":187,"name":"key"}',
				var_args.array_get(var_key))
		}
	}
	this.manager = var_manager.clone()
	this.id = var_id.clone()
	this.id_data.array_set('keys', rt.call_function('preg_split', [
		rt.new_string('/\\[/'),
		rt.call_function('str_replace', [rt.new_string(']'), rt.new_string(''), this.id]),
	]))
	this.id_data.array_set('base', rt.call_function('array_shift', [
		this.id_data.array_get(rt.new_string('keys')),
	]))
	this.id = this.id_data.array_get(rt.new_string('base'))
	if !(!rt.is_true(this.id_data.array_get(rt.new_string('keys')))) {
		this.id = rt.concat(this.id, rt.new_string('[' +
			(rt.call_function('implode', [rt.new_string(']['), this.id_data.array_get(rt.new_string('keys'))])).str() +
			']'))
	}
	if rt.is_true(this.validate_callback) {
		rt.call_function('add_filter', [
			rt.concat(rt.new_string('customize_validate_'), this.id),
			this.validate_callback,
			rt.new_int(10),
			rt.new_int(3),
		])
	}
	if rt.is_true(this.sanitize_callback) {
		rt.call_function('add_filter', [
			rt.concat(rt.new_string('customize_sanitize_'), this.id),
			this.sanitize_callback,
			rt.new_int(10),
			rt.new_int(2),
		])
	}
	if rt.is_true(this.sanitize_js_callback) {
		rt.call_function('add_filter', [
			rt.concat(rt.new_string('customize_sanitize_js_'), this.id),
			this.sanitize_js_callback,
			rt.new_int(10),
			rt.new_int(2),
		])
	}
	if rt.is_true(rt.identical(rt.new_string('option'), this.prop_type))
		|| rt.is_true(rt.identical(rt.new_string('theme_mod'), this.prop_type)) {
		this.aggregate_multidimensional()
		if rt.is_true(rt.identical(rt.new_string('option'), this.prop_type))
			&& var_args.array_isset(rt.new_string('autoload')) {
			rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get_mut(this.prop_type).array_get_mut(this.id_data.array_get(rt.new_string('base'))).array_set('autoload',
				var_args.array_get(rt.new_string('autoload')))
		}
	}
}

fn (mut this Class_WP_Customize_Setting) id_data() rt.PhpVal {
	return this.id_data
}

fn (mut this Class_WP_Customize_Setting) aggregate_multidimensional() {
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	if !(rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_isset(this.prop_type)) {
		rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_set(this.prop_type,
			rt.new_array())
	}
	if !(rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(this.prop_type).array_isset(var_id_base)) {
		rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get_mut(this.prop_type).array_set(var_id_base, rt.create_array([
			rt.ArrayItem{ key: 'previewed_instances', val: rt.new_array() },
			rt.ArrayItem{ key: 'preview_applied_instances', val: rt.new_array() },
			rt.ArrayItem{ key: 'root_value', val: this.get_root_value(rt.new_array()) },
		]))
	}
	if !(!rt.is_true(this.id_data.array_get(rt.new_string('keys')))) {
		rt.call_function('add_action', [
			rt.concat(rt.new_string('customize_post_value_set_'), this.id),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Setting', []string{},
					&this) },
				rt.ArrayItem{
					key: none
					val: '_clear_aggregated_multidimensional_preview_applied_flag'
				},
			]),
			rt.new_int(9),
		])
		this.is_multidimensional_aggregated = true
	}
}

fn Class_WP_Customize_Setting.reset_aggregated_multidimensionals() {
	rt.set_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals', rt.new_array())
}

fn (mut this Class_WP_Customize_Setting) is_current_blog_previewed() bool {
	if !(!(this._previewed_blog_id).is_null()) {
		return false
	}
	return (rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}),
		this._previewed_blog_id)).to_bool()
}

fn (mut this Class_WP_Customize_Setting) preview() bool {
	if !(!(this._previewed_blog_id).is_null()) {
		this._previewed_blog_id = rt.call_function('get_current_blog_id', []rt.PhpVal{})
	}
	if this.is_previewed {
		return true
	}
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	mut var_is_multidimensional :=
		rt.new_bool(!(!rt.is_true(this.id_data.array_get(rt.new_string('keys')))))
	mut var_multidimensional_filter := [
		rt.new_object('WP_Customize_Setting', []string{}, &this),
		rt.new_string('_multidimensional_preview_filter'),
	]
	mut var_undefined := create_stdclass()
	mut var_needs_preview := rt.new_bool(!rt.is_true(rt.identical(var_undefined, this.post_value(rt.new_object('stdClass',
		[]string{}, var_undefined)))))
	mut var_value := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_needs_preview)))) {
		if this.is_multidimensional_aggregated {
			mut var_root := rt.get_static_prop('WP_Customize_Setting',
				'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('root_value'))
			var_value = this.multidimensional_get(var_root.clone(),
				this.id_data.array_get(rt.new_string('keys')), rt.new_object('stdClass',
				[]string{}, var_undefined))
		} else {
			mut var_default := this.default
			this.default = var_undefined
			var_value = this.value()
			this.default = var_default.clone()
		}
		var_needs_preview = rt.identical(var_undefined, var_value)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_needs_preview)))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('has_action', [
			rt.concat(rt.new_string('customize_post_value_set_'), this.id),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Setting', []string{},
					&this) },
				rt.ArrayItem{ key: none, val: 'preview' },
			]),
		])))))
		{
			rt.call_function('add_action', [
				rt.concat(rt.new_string('customize_post_value_set_'), this.id),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Setting', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: 'preview' },
				]),
			])
		}
		return false
	}
	mut switch_val_1 := this.prop_type
	if rt.is_true(rt.equal(switch_val_1, rt.new_string('theme_mod'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_multidimensional)))) {
			rt.call_function('add_filter', [
				rt.new_string('theme_mod_${var_id_base.to_string()}'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Setting', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: '_preview_filter' },
				]),
			])
		} else {
			if !rt.is_true(rt.get_static_prop('WP_Customize_Setting',
				'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('previewed_instances'))) {
				rt.call_function('add_filter', [
					rt.new_string('theme_mod_${var_id_base.to_string()}'),
					rt.create_array_from_list(var_multidimensional_filter),
				])
			}
			rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get_mut(this.prop_type).array_get_mut(var_id_base).array_get_mut('previewed_instances').array_set(this.id, rt.new_object('WP_Customize_Setting',
				[]string{}, &this))
		}
	} else if rt.is_true(rt.equal(switch_val_1, rt.new_string('option'))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(var_is_multidimensional)))) {
			rt.call_function('add_filter', [
				rt.new_string('pre_option_${var_id_base.to_string()}'),
				rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Setting', []string{},
						&this) },
					rt.ArrayItem{ key: none, val: '_preview_filter' },
				]),
			])
		} else {
			if !rt.is_true(rt.get_static_prop('WP_Customize_Setting',
				'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('previewed_instances'))) {
				rt.call_function('add_filter', [
					rt.new_string('option_${var_id_base.to_string()}'),
					rt.create_array_from_list(var_multidimensional_filter),
				])
				rt.call_function('add_filter', [
					rt.new_string('default_option_${var_id_base.to_string()}'),
					rt.create_array_from_list(var_multidimensional_filter),
				])
			}
			rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get_mut(this.prop_type).array_get_mut(var_id_base).array_get_mut('previewed_instances').array_set(this.id, rt.new_object('WP_Customize_Setting',
				[]string{}, &this))
		}
	} else {
		rt.call_function('do_action', [
			rt.concat(rt.new_string('customize_preview_'), this.id),
			rt.new_object('WP_Customize_Setting', []string{}, &this),
		])
		rt.call_function('do_action', [
			rt.concat(rt.new_string('customize_preview_'), this.prop_type),
			rt.new_object('WP_Customize_Setting', []string{}, &this),
		])
	}
	this.is_previewed = true
	return true
}

fn (mut this Class_WP_Customize_Setting) _clear_aggregated_multidimensional_preview_applied_flag() {
	rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(this.prop_type).array_get(this.id_data.array_get(rt.new_string('base'))).array_get(rt.new_string('preview_applied_instances')).array_unset(this.id)
}

fn (mut this Class_WP_Customize_Setting) _preview_filter(var_original rt.PhpVal) rt.PhpVal {
	if !(this.is_current_blog_previewed()) {
		return var_original.clone()
	}
	mut var_undefined := create_stdclass()
	mut var_post_value := this.post_value(rt.new_object('stdClass', []string{}, var_undefined))
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_undefined, var_post_value)))) {
		mut var_value := var_post_value.clone()
	} else {
		var_value = this.default
	}
	return var_value.clone()
}

fn (mut this Class_WP_Customize_Setting) _multidimensional_preview_filter(var_original rt.PhpVal) rt.PhpVal {
	if !(this.is_current_blog_previewed()) {
		return var_original.clone()
	}
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	if !rt.is_true(rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('previewed_instances'))) {
		return var_original.clone()
	}
	mut iter_2 :=
		rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('previewed_instances')).iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_previewed_setting := item_2.val
		if !(!rt.is_true(rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('preview_applied_instances')).array_get(rt.get_property(var_previewed_setting,
			'id')))) {
			continue
		}
		mut var_value := rt.call_method(var_previewed_setting, 'post_value', [
			rt.get_property(var_previewed_setting, 'default'),
		])
		mut var_root := rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(rt.get_property(var_previewed_setting,
			'type')).array_get(var_id_base).array_get(rt.new_string('root_value'))
		var_root = rt.call_method(var_previewed_setting, 'multidimensional_replace', [
			var_root.clone(),
			rt.get_property(var_previewed_setting, 'id_data').array_get(rt.new_string('keys')),
			var_value.clone(),
		])
		rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get_mut(rt.get_property(var_previewed_setting,
			'type')).array_get_mut(var_id_base).array_set('root_value', var_root.clone())
		rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get_mut(rt.get_property(var_previewed_setting,
			'type')).array_get_mut(var_id_base).array_get_mut('preview_applied_instances').array_set(rt.get_property(var_previewed_setting,
			'id'), true)
	}
	return rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('root_value'))
}

fn (mut this Class_WP_Customize_Setting) save() bool {
	mut var_value := this.post_value(rt.new_null())
	if !(this.check_capabilities()) || !(!var_value.is_null()) {
		return false
	}
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	rt.call_function('do_action', [
		rt.new_string('customize_save_${var_id_base.to_string()}'),
		rt.new_object('WP_Customize_Setting', []string{}, &this),
	])
	this.update(var_value.clone())
	return false
}

fn (mut this Class_WP_Customize_Setting) post_value(var_default_value rt.PhpVal) rt.PhpVal {
	return rt.call_method(this.manager, 'post_value', [
		rt.new_object('WP_Customize_Setting', []string{}, &this),
		var_default_value.clone(),
	])
}

fn (mut this Class_WP_Customize_Setting) sanitize(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	return rt.call_function('apply_filters', [
		rt.concat(rt.new_string('customize_sanitize_'), this.id),
		var_value_mutated.clone(),
		rt.new_object('WP_Customize_Setting', []string{}, &this),
	])
}

fn (mut this Class_WP_Customize_Setting) validate(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.call_function('is_wp_error', [var_value_mutated.clone()])) {
		return var_value_mutated.clone()
	}
	if rt.is_true(rt.new_bool(var_value_mutated.clone().is_null())) {
		return rt.new_object('WP_Error', []string{}, create_wp_error(rt.new_string('invalid_value'), rt.call_function('__', [
			rt.new_string('Invalid value.'),
		])))
	}
	mut var_validity := create_wp_error()
	var_validity = rt.call_function('apply_filters', [
		rt.concat(rt.new_string('customize_validate_'), this.id),
		var_validity.clone(),
		var_value_mutated.clone(),
		rt.new_object('WP_Customize_Setting', []string{}, &this),
	])
	if rt.is_true(rt.call_function('is_wp_error', [var_validity.clone()]))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_validity, 'has_errors', []rt.PhpVal{}))))) {
		var_validity = rt.new_bool(true)
	}
	return var_validity.clone()
}

fn (mut this Class_WP_Customize_Setting) get_root_value(var_default_value rt.PhpVal) rt.PhpVal {
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	if rt.is_true(rt.identical(rt.new_string('option'), this.prop_type)) {
		return rt.call_function('get_option', [var_id_base.clone(),
			var_default_value.clone()])
	} else if rt.is_true(rt.identical(rt.new_string('theme_mod'), this.prop_type)) {
		return rt.call_function('get_theme_mod', [var_id_base.clone(),
			var_default_value.clone()])
	} else {
		return var_default_value.clone()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Setting) set_root_value(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	if rt.is_true(rt.identical(rt.new_string('option'), this.prop_type)) {
		mut var_autoload := rt.new_bool(true)
		if rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get(this.prop_type).array_get(this.id_data.array_get(rt.new_string('base'))).array_isset(rt.new_string('autoload')) {
			var_autoload = rt.get_static_prop('WP_Customize_Setting',
				'aggregated_multidimensionals').array_get(this.prop_type).array_get(this.id_data.array_get(rt.new_string('base'))).array_get(rt.new_string('autoload'))
		}
		return (rt.call_function('update_option', [var_id_base.clone(),
			var_value_mutated.clone(), var_autoload.clone()])).to_bool()
	} else if rt.is_true(rt.identical(rt.new_string('theme_mod'), this.prop_type)) {
		rt.call_function('set_theme_mod', [var_id_base.clone(),
			var_value_mutated.clone()])
		return true
	} else {
		return false
	}
	return false
}

fn (mut this Class_WP_Customize_Setting) update(var_value rt.PhpVal) bool {
	mut var_value_mutated := var_value
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	if rt.is_true(rt.identical(rt.new_string('option'), this.prop_type))
		|| rt.is_true(rt.identical(rt.new_string('theme_mod'), this.prop_type)) {
		if !(this.is_multidimensional_aggregated) {
			return this.set_root_value(var_value_mutated.clone())
		} else {
			mut var_root := rt.get_static_prop('WP_Customize_Setting',
				'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('root_value'))
			var_root = this.multidimensional_replace(var_root.clone(),
				this.id_data.array_get(rt.new_string('keys')), var_value_mutated.clone())
			rt.get_static_prop('WP_Customize_Setting', 'aggregated_multidimensionals').array_get_mut(this.prop_type).array_get_mut(var_id_base).array_set('root_value',
				var_root.clone())
			return this.set_root_value(var_root.clone())
		}
	} else {
		rt.call_function('do_action', [
			rt.concat(rt.new_string('customize_update_'), this.prop_type),
			var_value_mutated.clone(),
			rt.new_object('WP_Customize_Setting', []string{}, &this),
		])
		return (rt.call_function('has_action', [
			rt.concat(rt.new_string('customize_update_'), this.prop_type),
		])).to_bool()
	}
	return false
}

fn (mut this Class_WP_Customize_Setting) _update_theme_mod() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.4.0'), rt.new_string(@STRUCT + '::update()')])
}

fn (mut this Class_WP_Customize_Setting) _update_option() {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('4.4.0'), rt.new_string(@STRUCT + '::update()')])
}

fn (mut this Class_WP_Customize_Setting) value() rt.PhpVal {
	mut var_id_base := this.id_data.array_get(rt.new_string('base'))
	mut var_is_core_type := rt.new_bool(
		rt.is_true(rt.identical(rt.new_string('option'), this.prop_type))
		|| rt.is_true(rt.identical(rt.new_string('theme_mod'), this.prop_type)))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_core_type))))
		&& !(this.is_multidimensional_aggregated) {
		if this.is_previewed {
			mut var_value := this.post_value(rt.new_null())
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_value)))) {
				return var_value.clone()
			}
		}
		var_value = this.get_root_value(this.default)
		var_value = rt.call_function('apply_filters', [
			rt.new_string('customize_value_${var_id_base.to_string()}'),
			var_value.clone(),
			rt.new_object('WP_Customize_Setting', []string{}, &this),
		])
	} else if this.is_multidimensional_aggregated {
		mut var_root_value := rt.get_static_prop('WP_Customize_Setting',
			'aggregated_multidimensionals').array_get(this.prop_type).array_get(var_id_base).array_get(rt.new_string('root_value'))
		var_value = this.multidimensional_get(var_root_value.clone(),
			this.id_data.array_get(rt.new_string('keys')), this.default)
		if this.is_previewed {
			var_value = this.post_value(var_value.clone())
		}
	} else {
		var_value = this.get_root_value(this.default)
	}
	return var_value.clone()
}

fn (mut this Class_WP_Customize_Setting) js_value() rt.PhpVal {
	mut var_value := rt.call_function('apply_filters', [
		rt.concat(rt.new_string('customize_sanitize_js_'), this.id),
		this.value(),
		rt.new_object('WP_Customize_Setting', []string{}, &this),
	])
	if rt.is_true(rt.new_bool(var_value.clone().is_string())) {
		return rt.call_function('html_entity_decode', [var_value.clone(),
			rt.get_constant('ENT_QUOTES'), rt.new_string('UTF-8')])
	}
	return var_value.clone()
}

fn (mut this Class_WP_Customize_Setting) json() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'value', val: this.js_value() },
		rt.ArrayItem{ key: 'transport', val: this.transport },
		rt.ArrayItem{ key: 'dirty', val: this.dirty }, rt.ArrayItem{
			key: 'type'
			val: this.prop_type
		}])
}

fn (mut this Class_WP_Customize_Setting) check_capabilities() bool {
	if rt.is_true(this.capability)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_user_can', [this.capability]))))) {
		return false
	}
	if rt.is_true(this.theme_supports)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('current_theme_supports', [rt.cast_array(this.theme_supports)]))))) {
		return false
	}
	return true
}

fn (mut this Class_WP_Customize_Setting) multidimensional(var_root rt.PhpVal, var_keys rt.PhpVal, create bool) rt.PhpVal {
	mut var_root_mutated := var_root
	mut var_keys_mutated := var_keys
	if var_create && !rt.is_true(var_root_mutated) {
		var_root_mutated = rt.new_array()
	}
	if !(!var_root_mutated.is_null()) || !rt.is_true(var_keys_mutated) {
		return rt.new_null()
	}
	mut var_last := rt.call_function('array_pop', [var_keys_mutated.clone()])
	mut var_node := var_root_mutated
	mut iter_3 := var_keys_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_key := item_3.val
		if var_create && !(var_node.array_isset(var_key)) {
			var_node.array_set(var_key, rt.new_array())
		}
		if !(var_node.clone().is_array()) || !(var_node.array_isset(var_key)) {
			return rt.new_null()
		}
		var_node = var_node.array_get(var_key)
	}
	if var_create {
		if !(var_node.clone().is_array()) {
			var_node = rt.new_array()
		}
		if !(var_node.array_isset(var_last)) {
			var_node.array_set(var_last, rt.new_array())
		}
	}
	if !(var_node.array_isset(var_last)) {
		return rt.new_null()
	}
	return rt.create_array([rt.ArrayItem{ key: 'root', val: var_root_mutated },
		rt.ArrayItem{ key: 'node', val: var_node }, rt.ArrayItem{ key: 'key', val: var_last }])
}

fn (mut this Class_WP_Customize_Setting) multidimensional_replace(var_root rt.PhpVal, var_keys rt.PhpVal, var_value rt.PhpVal) rt.PhpVal {
	mut var_root_mutated := var_root
	mut var_keys_mutated := var_keys
	mut var_value_mutated := var_value
	if !(!var_value_mutated.is_null()) {
		return var_root_mutated.clone()
	} else if !rt.is_true(var_keys_mutated) {
		return var_value_mutated.clone()
	}
	mut var_result :=
		this.multidimensional(var_root_mutated.clone(), var_keys_mutated.clone(), true)
	if !var_result.is_null() {
		var_result.array_get_mut('node').array_set(var_result.array_get(rt.new_string('key')),
			var_value_mutated.clone())
	}
	return var_root_mutated.clone()
}

fn (mut this Class_WP_Customize_Setting) multidimensional_get(var_root rt.PhpVal, var_keys rt.PhpVal, var_default_value rt.PhpVal) rt.PhpVal {
	mut var_root_mutated := var_root
	mut var_keys_mutated := var_keys
	if !rt.is_true(var_keys_mutated) {
		return if !var_root_mutated.is_null() { var_root_mutated } else { var_default_value }
	}
	mut var_result := this.multidimensional(var_root_mutated.clone(), var_keys_mutated.clone(),
		false)
	return if !var_result.is_null() {
		var_result.array_get(rt.new_string('node')).array_get(var_result.array_get(rt.new_string('key')))
	} else {
		var_default_value
	}
}

fn (mut this Class_WP_Customize_Setting) multidimensional_isset(var_root rt.PhpVal, var_keys rt.PhpVal) rt.PhpVal {
	mut var_root_mutated := var_root
	mut var_keys_mutated := var_keys
	mut var_result := this.multidimensional_get(var_root_mutated.clone(), var_keys_mutated.clone(),
		rt.new_null())
	return rt.new_bool(!var_result.is_null())
}

struct Class_stdClass {
	rt.PhpObjectBase
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_customize_setting(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Setting {
	mut obj := &Class_WP_Customize_Setting{
		PhpObjectBase:                  rt.PhpObjectBase{}
		manager:                        rt.new_null()
		id:                             rt.new_null()
		prop_type:                      rt.new_string('theme_mod')
		capability:                     rt.new_string('edit_theme_options')
		theme_supports:                 rt.new_string('')
		default:                        rt.new_string('')
		transport:                      rt.new_string('refresh')
		validate_callback:              rt.new_string('')
		sanitize_callback:              rt.new_string('')
		sanitize_js_callback:           rt.new_string('')
		dirty:                          rt.new_bool(false)
		id_data:                        rt.new_array()
		is_previewed:                   false
		is_multidimensional_aggregated: false
		_previewed_blog_id:             rt.new_null()
		_original_value:                rt.new_null()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_stdclass(_args ...rt.PhpVal) &Class_stdClass {
	mut obj := &Class_stdClass{
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

fn (mut this Class_WP_Customize_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'id_data' {
			return this.id_data()
		}
		'aggregate_multidimensional' {
			this.aggregate_multidimensional()
			return rt.new_null()
		}
		'reset_aggregated_multidimensionals' {
			Class_WP_Customize_Setting.reset_aggregated_multidimensionals()
			return rt.new_null()
		}
		'is_current_blog_previewed' {
			return rt.new_bool(this.is_current_blog_previewed())
		}
		'preview' {
			return rt.new_bool(this.preview())
		}
		'_clear_aggregated_multidimensional_preview_applied_flag' {
			this._clear_aggregated_multidimensional_preview_applied_flag()
			return rt.new_null()
		}
		'_preview_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._preview_filter(dispatch_arg_0)
		}
		'_multidimensional_preview_filter' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._multidimensional_preview_filter(dispatch_arg_0)
		}
		'save' {
			return rt.new_bool(this.save())
		}
		'post_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.post_value(dispatch_arg_0)
		}
		'sanitize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize(dispatch_arg_0)
		}
		'validate' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.validate(dispatch_arg_0)
		}
		'get_root_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_root_value(dispatch_arg_0)
		}
		'set_root_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.set_root_value(dispatch_arg_0))
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.update(dispatch_arg_0))
		}
		'_update_theme_mod' {
			this._update_theme_mod()
			return rt.new_null()
		}
		'_update_option' {
			this._update_option()
			return rt.new_null()
		}
		'value' {
			return this.value()
		}
		'js_value' {
			return this.js_value()
		}
		'json' {
			return this.json()
		}
		'check_capabilities' {
			return rt.new_bool(this.check_capabilities())
		}
		'multidimensional' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.multidimensional(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'multidimensional_replace' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.multidimensional_replace(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'multidimensional_get' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.multidimensional_get(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'multidimensional_isset' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.multidimensional_isset(dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'manager' { return this.manager }
		'id' { return this.id }
		'type' { return this.prop_type }
		'capability' { return this.capability }
		'theme_supports' { return this.theme_supports }
		'default' { return this.default }
		'transport' { return this.transport }
		'validate_callback' { return this.validate_callback }
		'sanitize_callback' { return this.sanitize_callback }
		'sanitize_js_callback' { return this.sanitize_js_callback }
		'dirty' { return this.dirty }
		'id_data' { return this.id_data }
		'is_previewed' { return rt.new_bool(this.is_previewed) }
		'is_multidimensional_aggregated' { return rt.new_bool(this.is_multidimensional_aggregated) }
		'_previewed_blog_id' { return this._previewed_blog_id }
		'_original_value' { return this._original_value }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'manager' {
			this.manager = val
			return true
		}
		'id' {
			this.id = val
			return true
		}
		'type' {
			this.prop_type = val
			return true
		}
		'capability' {
			this.capability = val
			return true
		}
		'theme_supports' {
			this.theme_supports = val
			return true
		}
		'default' {
			this.default = val
			return true
		}
		'transport' {
			this.transport = val
			return true
		}
		'validate_callback' {
			this.validate_callback = val
			return true
		}
		'sanitize_callback' {
			this.sanitize_callback = val
			return true
		}
		'sanitize_js_callback' {
			this.sanitize_js_callback = val
			return true
		}
		'dirty' {
			this.dirty = val
			return true
		}
		'id_data' {
			this.id_data = val
			return true
		}
		'is_previewed' {
			this.is_previewed = val.to_bool()
			return true
		}
		'is_multidimensional_aggregated' {
			this.is_multidimensional_aggregated = val.to_bool()
			return true
		}
		'_previewed_blog_id' {
			this._previewed_blog_id = val
			return true
		}
		'_original_value' {
			this._original_value = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
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

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		fn () {
			print((rt.new_string('-1')).str())
			exit(0)
		}()
	}
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-filter-setting.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-header-image-setting.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-background-image-setting.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-item-setting.php',
		'4')
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-nav-menu-setting.php',
		'4')
}

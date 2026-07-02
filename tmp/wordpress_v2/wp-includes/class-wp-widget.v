import rt

struct Class_WP_Widget {
	rt.PhpObjectBase
pub mut:
	id_base         rt.PhpVal = rt.new_null()
	name            rt.PhpVal = rt.new_null()
	option_name     rt.PhpVal = rt.new_null()
	alt_option_name rt.PhpVal = rt.new_null()
	widget_options  rt.PhpVal = rt.new_null()
	control_options rt.PhpVal = rt.new_null()
	number          rt.PhpVal = rt.new_bool(false)
	id              rt.PhpVal = rt.new_bool(false)
	updated         bool
}

fn (mut this Class_WP_Widget) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	fn () {
		print((rt.new_string('function WP_Widget::widget() must be overridden in a subclass.')).str())
		exit(0)
	}()
}

fn (mut this Class_WP_Widget) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_new_instance_mutated := var_new_instance
	mut var_old_instance_mutated := var_old_instance
	return var_new_instance_mutated.clone()
}

fn (mut this Class_WP_Widget) form(var_instance rt.PhpVal) string {
	mut var_instance_mutated := var_instance
	print('<p class="no-options-widget">' +
		(rt.call_function('__', [rt.new_string('There are no options for this widget.')])).str() +
		'</p>')
	return 'noform'
}

fn (mut this Class_WP_Widget) construct(var_id_base rt.PhpVal, var_name rt.PhpVal, var_widget_options rt.PhpVal, var_control_options rt.PhpVal) {
	mut var_id_base_mutated := var_id_base
	if !(!rt.is_true(var_id_base_mutated)) {
		var_id_base_mutated = rt.new_string(var_id_base_mutated.clone().to_string().to_lower())
	} else {
		var_id_base_mutated = rt.call_function('preg_replace', [
			rt.new_string('/(wp_)?widget_/'),
			rt.new_string(''),
			rt.new_string(rt.call_function('get_class', [
				rt.new_object('WP_Widget', []string{}, &this),
			]).to_string().to_lower()),
		])
	}
	this.id_base = var_id_base_mutated.clone()
	this.name = var_name.clone()
	this.option_name = 'widget_' + (this.id_base).str()
	this.widget_options = rt.call_function('wp_parse_args', [
		var_widget_options.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'classname', val: rt.call_function('str_replace', [
				rt.new_string('\\'),
				rt.new_string('_'),
				this.option_name,
			]) },
			rt.ArrayItem{ key: 'customize_selective_refresh', val: false },
		])])
	this.control_options = rt.call_function('wp_parse_args', [
		var_control_options.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'id_base', val: this.id_base },
		])])
}

fn (mut this Class_WP_Widget) wp_widget(var_id_base rt.PhpVal, var_name rt.PhpVal, var_widget_options rt.PhpVal, var_control_options rt.PhpVal) {
	mut var_id_base_mutated := var_id_base
	rt.call_function('_deprecated_constructor', [rt.new_string('WP_Widget'),
		rt.new_string('4.3.0'),
		rt.call_function('get_class', [
			rt.new_object('WP_Widget', []string{}, &this),
		])])
	mut iife_temp_0 := Class_WP_Widget{}
	iife_temp_0.construct(var_id_base_mutated.clone(), var_name.clone(),
		var_widget_options.clone(), var_control_options.clone())
	rt.new_null()
}

fn (mut this Class_WP_Widget) get_field_name(var_field_name rt.PhpVal) string {
	mut var_field_name_mutated := var_field_name
	mut var_pos := rt.call_function('strpos', [var_field_name_mutated.clone(),
		rt.new_string('[')])
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_pos)))) {
		var_field_name_mutated =
			rt.new_string('[' +(rt.call_function('substr_replace', [var_field_name_mutated.clone(), rt.new_string(']['), var_pos.clone(), rt.new_int('['.len)])).str())
	} else {
		var_field_name_mutated = rt.new_string('[' + var_field_name_mutated.str() + ']')
	}
	return 'widget-' +
		(this.id_base).str() + '[' + (this.number).str() + ']' + var_field_name_mutated.str()
}

fn (mut this Class_WP_Widget) get_field_id(var_field_name rt.PhpVal) string {
	mut var_field_name_mutated := var_field_name
	var_field_name_mutated = rt.call_function('str_replace', [
		rt.create_array([rt.ArrayItem{ key: none, val: '[]' },
			rt.ArrayItem{ key: none, val: '[' }, rt.ArrayItem{ key: none, val: ']' }]),
		rt.create_array([rt.ArrayItem{ key: none, val: '' }, rt.ArrayItem{ key: none, val: '-' },
			rt.ArrayItem{ key: none, val: '' }]),
		var_field_name_mutated.clone(),
	])
	var_field_name_mutated = rt.new_string(var_field_name_mutated.clone().to_string().trim_space())
	return 'widget-' +
		(this.id_base).str() + '-' + (this.number).str() + '-' + var_field_name_mutated.str()
}

fn (mut this Class_WP_Widget) _register() {
	mut var_settings := this.get_settings()
	mut var_empty := rt.new_bool(true)
	if rt.is_true(rt.new_bool(rt.instance_of(var_settings, 'ArrayObject')))
		|| rt.is_true(rt.new_bool(rt.instance_of(var_settings, 'ArrayIterator'))) {
		var_settings = rt.call_method(var_settings, 'getArrayCopy', []rt.PhpVal{})
	}
	if rt.is_true(rt.new_bool(var_settings.clone().is_array())) {
		mut iter_1 := rt.func_array_keys(var_settings.clone()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_number := item_1.val
			if rt.is_true(rt.new_bool(var_number.clone().is_long() || var_number.clone().is_double())) {
				this._set(var_number.clone())
				this._register_one(var_number.clone())
				var_empty = rt.new_bool(false)
			}
		}
	}
	if rt.is_true(var_empty) {
		this._set(rt.new_int(1))
		this._register_one(rt.new_null())
	}
}

fn (mut this Class_WP_Widget) _set(var_number rt.PhpVal) {
	mut var_number_mutated := var_number
	this.number = var_number_mutated.clone()
	this.id = (this.id_base).str() + '-' + var_number_mutated.str()
}

fn (mut this Class_WP_Widget) _get_display_callback() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget', []string{}, &this) },
		rt.ArrayItem{ key: none, val: 'display_callback' },
	])
}

fn (mut this Class_WP_Widget) _get_update_callback() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget', []string{}, &this) },
		rt.ArrayItem{ key: none, val: 'update_callback' },
	])
}

fn (mut this Class_WP_Widget) _get_form_callback() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget', []string{}, &this) },
		rt.ArrayItem{ key: none, val: 'form_callback' },
	])
}

fn (mut this Class_WP_Widget) is_preview() bool {
	mut var_wp_customize := rt.new_null()
	return !var_wp_customize.is_null()
		&& rt.is_true(rt.call_method(var_wp_customize, 'is_preview', []rt.PhpVal{}))
}

fn (mut this Class_WP_Widget) display_callback(var_args rt.PhpVal, widget_args i64) {
	mut widget_args_mutated := widget_args
	if rt.is_true(rt.new_bool(rt.new_int(widget_args_mutated).clone().is_long()
		|| rt.new_int(widget_args_mutated).clone().is_double()))
	{
		widget_args_mutated = (rt.create_array([
			rt.ArrayItem{ key: 'number', val: widget_args_mutated },
		])).to_i64()
	}
	widget_args_mutated = (rt.call_function('wp_parse_args', [
		rt.new_int(widget_args_mutated).clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'number', val: -1 },
		])])).to_i64()
	this._set(rt.new_int(widget_args_mutated).array_get(rt.new_string('number')))
	mut var_instances := this.get_settings()
	if var_instances.array_isset(this.number) {
		mut var_instance := var_instances.array_get(this.number)
		var_instance = rt.call_function('apply_filters', [
			rt.new_string('widget_display_callback'),
			var_instance.clone(),
			rt.new_object('WP_Widget', []string{}, &this),
			var_args.clone(),
		])
		if rt.is_true(rt.identical(rt.new_bool(false), var_instance)) {
			return
		}
		mut var_was_cache_addition_suspended := rt.call_function('wp_suspend_cache_addition',
			[]rt.PhpVal{})
		if this.is_preview()
			&& rt.is_true(rt.new_bool(!(rt.is_true(var_was_cache_addition_suspended)))) {
			rt.call_function('wp_suspend_cache_addition', [rt.new_bool(true)])
		}
		this.widget(var_args.clone(), var_instance.clone())
		if this.is_preview() {
			rt.call_function('wp_suspend_cache_addition',
				[var_was_cache_addition_suspended.clone()])
		}
	}
}

fn (mut this Class_WP_Widget) update_callback(deprecated i64) {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_all_instances := this.get_settings()
	if this.updated {
		return
	}
	if rt.get_superglobal('_POST').array_isset(rt.new_string('delete_widget'))
		&& rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('delete_widget'))) {
		if rt.get_superglobal('_POST').array_isset(rt.new_string('the-widget-id')) {
			mut var_del_id := rt.get_superglobal('_POST').array_get(rt.new_string('the-widget-id'))
		} else {
			return
		}
		if var_wp_registered_widgets.array_get(var_del_id).array_get(rt.new_string('params')).array_get(rt.new_int(0)).array_isset(rt.new_string('number')) {
			mut var_number :=
				var_wp_registered_widgets.array_get(var_del_id).array_get(rt.new_string('params')).array_get(rt.new_int(0)).array_get(rt.new_string('number'))
			if rt.is_true(rt.identical((this.id_base).str() + '-' + var_number.str(), var_del_id)) {
				var_all_instances.array_unset(var_number)
			}
		}
	} else {
		if rt.get_superglobal('_POST').array_isset('widget-' + (this.id_base).str()) && rt.get_superglobal('_POST').array_get(rt.new_string('widget-' + (this.id_base).str())).is_array() {
			mut var_settings := rt.get_superglobal('_POST').array_get(rt.new_string('widget-' +
				(this.id_base).str()))
		} else if rt.get_superglobal('_POST').array_isset(rt.new_string('id_base'))
			&& rt.is_true(rt.identical(rt.get_superglobal('_POST').array_get(rt.new_string('id_base')), this.id_base)) {
			mut var_num := rt.new_int(if rt.is_true(rt.get_superglobal('_POST').array_get(rt.new_string('multi_number'))) {
				rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('multi_number'))).to_i64())
			} else {
				rt.new_int((rt.get_superglobal('_POST').array_get(rt.new_string('widget_number'))).to_i64())
			})
			var_settings = rt.create_array([
				rt.ArrayItem{ key: var_num, val: rt.new_array() },
			])
		} else {
			return
		}
		mut iter_2 := var_settings.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_new_instance := item_2.val
			mut var_number_shadow := item_2.key
			var_new_instance = rt.call_function('stripslashes_deep', [
				var_new_instance.clone()])
			this._set(var_number_shadow.clone())
			mut var_old_instance := if !(var_all_instances.array_get(var_number_shadow)).is_null() {
				var_all_instances.array_get(var_number_shadow)
			} else {
				rt.new_array()
			}
			mut var_was_cache_addition_suspended := rt.call_function('wp_suspend_cache_addition',
				[]rt.PhpVal{})
			if this.is_preview()
				&& rt.is_true(rt.new_bool(!(rt.is_true(var_was_cache_addition_suspended)))) {
				rt.call_function('wp_suspend_cache_addition', [
					rt.new_bool(true)])
			}
			mut var_instance := this.update(var_new_instance.clone(), var_old_instance.clone())
			if this.is_preview() {
				rt.call_function('wp_suspend_cache_addition', [
					var_was_cache_addition_suspended.clone()])
			}
			var_instance = rt.call_function('apply_filters', [
				rt.new_string('widget_update_callback'),
				var_instance.clone(),
				var_new_instance.clone(),
				var_old_instance.clone(),
				rt.new_object('WP_Widget', []string{}, &this),
			])
			if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_instance)))) {
				var_all_instances.array_set(var_number_shadow, var_instance.clone())
			}
			break
		}
	}
	this.save_settings(var_all_instances.clone())
	this.updated = true
}

fn (mut this Class_WP_Widget) form_callback(widget_args i64) rt.PhpVal {
	mut widget_args_mutated := widget_args
	if rt.is_true(rt.new_bool(rt.new_int(widget_args_mutated).clone().is_long()
		|| rt.new_int(widget_args_mutated).clone().is_double()))
	{
		widget_args_mutated = (rt.create_array([
			rt.ArrayItem{ key: 'number', val: widget_args_mutated },
		])).to_i64()
	}
	widget_args_mutated = (rt.call_function('wp_parse_args', [
		rt.new_int(widget_args_mutated).clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'number', val: -1 },
		])])).to_i64()
	mut var_all_instances := this.get_settings()
	if rt.is_true(rt.identical(-1,
		rt.new_int(widget_args_mutated).array_get(rt.new_string('number'))))
	{
		this._set(rt.new_string('__i__'))
		mut var_instance := rt.new_array()
	} else {
		this._set(rt.new_int(widget_args_mutated).array_get(rt.new_string('number')))
		var_instance =
			var_all_instances.array_get(rt.new_int(widget_args_mutated).array_get(rt.new_string('number')))
	}
	var_instance = rt.call_function('apply_filters', [
		rt.new_string('widget_form_callback'),
		var_instance.clone(),
		rt.new_object('WP_Widget', []string{}, &this),
	])
	mut var_return := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_instance)))) {
		var_return = rt.new_string(this.form(var_instance.clone()))
		rt.call_function('do_action_ref_array', [rt.new_string('in_widget_form'),
			rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget', []string{}, &this) },
				rt.ArrayItem{ key: none, val: var_return },
				rt.ArrayItem{ key: none, val: var_instance },
			])])
	}
	return var_return.clone()
}

fn (mut this Class_WP_Widget) _register_one(var_number rt.PhpVal) {
	mut var_number_mutated := var_number
	rt.call_function('wp_register_sidebar_widget', [this.id, this.name, this._get_display_callback(),
		this.widget_options, rt.create_array([
			rt.ArrayItem{ key: 'number', val: var_number_mutated },
		])])
	rt.call_function('_register_widget_update_callback', [this.id_base, this._get_update_callback(),
		this.control_options, rt.create_array([rt.ArrayItem{ key: 'number', val: -1 }])])
	rt.call_function('_register_widget_form_callback', [this.id, this.name, this._get_form_callback(),
		this.control_options, rt.create_array([
			rt.ArrayItem{ key: 'number', val: var_number_mutated },
		])])
}

fn (mut this Class_WP_Widget) save_settings(var_settings rt.PhpVal) {
	mut var_settings_mutated := var_settings
	var_settings_mutated.array_set('_multiwidget', 1)
	rt.call_function('update_option', [this.option_name, var_settings_mutated.clone()])
}

fn (mut this Class_WP_Widget) get_settings() rt.PhpVal {
	mut var_settings := rt.call_function('get_option', [this.option_name])
	if rt.is_true(rt.identical(rt.new_bool(false), var_settings)) {
		var_settings = rt.new_array()
		if !(this.alt_option_name).is_null() {
			var_settings = rt.call_function('get_option', [this.alt_option_name, rt.new_array()])
			rt.call_function('delete_option', [this.alt_option_name])
		}
		this.save_settings(var_settings.clone())
	}
	if !(var_settings.clone().is_array())
		&& !(rt.is_true(rt.new_bool(rt.instance_of(var_settings, 'ArrayObject')))
		|| rt.is_true(rt.new_bool(rt.instance_of(var_settings, 'ArrayIterator')))) {
		var_settings = rt.new_array()
	}
	if !(!rt.is_true(var_settings)) && !(var_settings.array_isset(rt.new_string('_multiwidget'))) {
		var_settings = rt.call_function('wp_convert_widget_settings', [this.id_base, this.option_name,
			var_settings.clone()])
	}
	var_settings.array_unset(rt.new_string('_multiwidget'))
	var_settings.array_unset(rt.new_string('__i__'))
	return var_settings.clone()
}

fn create_wp_widget(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal, arg_3 rt.PhpVal) &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase:   rt.PhpObjectBase{}
		id_base:         rt.new_null()
		name:            rt.new_null()
		option_name:     rt.new_null()
		alt_option_name: rt.new_null()
		widget_options:  rt.new_null()
		control_options: rt.new_null()
		number:          rt.new_bool(false)
		id:              rt.new_bool(false)
		updated:         false
	}
	obj.construct(arg_0, arg_1, arg_2, arg_3)
	return obj
}

fn (mut this Class_WP_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.widget(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.update(dispatch_arg_0, dispatch_arg_1)
		}
		'form' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.form(dispatch_arg_0))
		}
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'WP_Widget' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.wp_widget(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'get_field_name' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_field_name(dispatch_arg_0))
		}
		'get_field_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_field_id(dispatch_arg_0))
		}
		'_register' {
			this._register()
			return rt.new_null()
		}
		'_set' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._set(dispatch_arg_0)
			return rt.new_null()
		}
		'_get_display_callback' {
			return this._get_display_callback()
		}
		'_get_update_callback' {
			return this._get_update_callback()
		}
		'_get_form_callback' {
			return this._get_form_callback()
		}
		'is_preview' {
			return rt.new_bool(this.is_preview())
		}
		'display_callback' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			this.display_callback(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		'update_callback' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			this.update_callback(dispatch_arg_0)
			return rt.new_null()
		}
		'form_callback' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_i64()
			return this.form_callback(dispatch_arg_0)
		}
		'_register_one' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this._register_one(dispatch_arg_0)
			return rt.new_null()
		}
		'save_settings' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.save_settings(dispatch_arg_0)
			return rt.new_null()
		}
		'get_settings' {
			return this.get_settings()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'id_base' { return this.id_base }
		'name' { return this.name }
		'option_name' { return this.option_name }
		'alt_option_name' { return this.alt_option_name }
		'widget_options' { return this.widget_options }
		'control_options' { return this.control_options }
		'number' { return this.number }
		'id' { return this.id }
		'updated' { return rt.new_bool(this.updated) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'id_base' {
			this.id_base = val
			return true
		}
		'name' {
			this.name = val
			return true
		}
		'option_name' {
			this.option_name = val
			return true
		}
		'alt_option_name' {
			this.alt_option_name = val
			return true
		}
		'widget_options' {
			this.widget_options = val
			return true
		}
		'control_options' {
			this.control_options = val
			return true
		}
		'number' {
			this.number = val
			return true
		}
		'id' {
			this.id = val
			return true
		}
		'updated' {
			this.updated = val.to_bool()
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

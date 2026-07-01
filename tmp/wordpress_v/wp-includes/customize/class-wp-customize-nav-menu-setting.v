import rt

pub fn Class_WP_Customize_Nav_Menu_Setting.id_pattern() string {
	return '/^nav_menu\\[(?P<id>-?\\d+)\\]$/'
}
pub fn Class_WP_Customize_Nav_Menu_Setting.taxonomy() string {
	return 'nav_menu'
}
pub fn Class_WP_Customize_Nav_Menu_Setting.type() string {
	return 'nav_menu'
}
struct Class_WP_Customize_Nav_Menu_Setting {
	rt.PhpObjectBase
pub mut:
		prop_type rt.PhpVal = rt.new_null()
		default rt.PhpVal = rt.new_array()
		transport rt.PhpVal = rt.new_string('postMessage')
		term_id rt.PhpVal = rt.new_null()
		previous_term_id rt.PhpVal = rt.new_null()
		is_updated bool
		update_status string
		update_error rt.PhpVal = rt.new_null()
		_current_menus_sort_orderby rt.PhpVal = rt.new_null()
		_widget_nav_menu_updates rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) construct(mut var_manager Class_WP_Customize_Manager, var_id rt.PhpVal, mut var_args Class_array)  {
	mut var_matches := map[string]rt.PhpVal{}
	if !rt.is_true(rt.get_property(var_manager, 'nav_menus')) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string('Expected WP_Customize_Manager::$nav_menus to be set.'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [Class_WP_Customize_Nav_Menu_Setting.id_pattern(), var_id.dup(), var_matches.dup()]))))) {
		rt.throw_exception(rt.new_object('Exception', []string{}, create_exception(rt.new_string("Illegal widget setting ID: ${var_id.to_string()}"))))
	}
	this.term_id = // unsupported expression: Expr_Cast_Int
	this.Class_WP_Customize_Setting.construct(rt.new_object('WP_Customize_Manager', []string{}, var_manager), var_id.dup(), rt.new_object('array', []string{}, var_args))
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) value() rt.PhpVal {
	if rt.is_true(rt.new_bool(rt.is_true(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this), 'is_previewed')) && rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this), '_previewed_blog_id'))))) {
		mut var_undefined := create_stdclass()
		mut var_post_value := this.post_value(rt.new_object('stdClass', []string{}, var_undefined))
		if rt.is_true(rt.identical(var_undefined, var_post_value)) {
			mut var_value := rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this), '_original_value')
		} else {
			var_value = var_post_value.dup()
		}
	} else {
		var_value = rt.new_bool(rt.new_bool(false))
		if rt.is_true(rt.greater(this.term_id, rt.new_int(0))) {
			mut var_term := rt.call_function('wp_get_nav_menu_object', [this.term_id])
			if rt.is_true(var_term) {
				var_value = rt.call_function('wp_array_slice_assoc', [rt.cast_array(var_term), rt.func_array_keys(this.default)])
				mut var_nav_menu_options := rt.cast_array(rt.call_function('get_option', [rt.new_string('nav_menu_options'), rt.new_array()]))
				var_value.array_set('auto_add', false)
				if rt.is_true(rt.new_bool(var_nav_menu_options.array_isset(rt.new_string('auto_add')) && rt.is_true(rt.new_bool(var_nav_menu_options.array_get('auto_add').is_array())))) {
					var_value.array_set('auto_add', rt.call_function('in_array', [rt.get_property(var_term, 'term_id'), var_nav_menu_options.array_get('auto_add'), rt.new_bool(true)]))
				}
			}
		}
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value.dup().is_array()))))) {
			var_value = this.default
		}
	}
	return var_value.dup()
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) preview() bool {
	if rt.is_true(rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this), 'is_previewed')) {
		return false
	}
	mut var_undefined := create_stdclass()
	mut var_is_placeholder := rt.less(this.term_id, rt.new_int(0))
	mut var_is_dirty := // unsupported expression: Expr_BinaryOp_NotIdentical
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_placeholder)))) && rt.is_true(rt.new_bool(!(rt.is_true(var_is_dirty)))))) {
		return false
	}
	this.dispatch_set_prop('is_previewed', rt.new_bool(true))
	this.dispatch_set_prop('_original_value', this.value())
	this.dispatch_set_prop('_previewed_blog_id', rt.call_function('get_current_blog_id', []rt.PhpVal{}))
	rt.call_function('add_filter', [rt.new_string('wp_get_nav_menus'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this) }, rt.ArrayItem{ key: none, val: 'filter_wp_get_nav_menus' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('wp_get_nav_menu_object'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this) }, rt.ArrayItem{ key: none, val: 'filter_wp_get_nav_menu_object' }]), rt.new_int(10), rt.new_int(2)])
	rt.call_function('add_filter', [rt.new_string('default_option_nav_menu_options'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this) }, rt.ArrayItem{ key: none, val: 'filter_nav_menu_options' }])])
	rt.call_function('add_filter', [rt.new_string('option_nav_menu_options'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this) }, rt.ArrayItem{ key: none, val: 'filter_nav_menu_options' }])])
	return true
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) filter_wp_get_nav_menus(var_menus rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_menus_mutated := var_menus
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_menus_mutated.dup()
	}
	mut var_setting_value := this.value()
	mut var_is_delete := rt.identical(rt.new_bool(false), var_setting_value)
	mut var_index := // unsupported expression: Expr_UnaryMinus
	{
		mut iter_1 := var_menus_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_menu := item_1.val
			mut var_i := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int)) || rt.is_true(rt.identical(// unsupported expression: Expr_Cast_Int, // unsupported expression: Expr_Cast_Int)))) {
				var_index = var_i.dup()
				break
			}
		}
	}
	if rt.is_true(var_is_delete) {
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			rt.call_function('array_splice', [var_menus_mutated.dup(), var_index.dup(), rt.new_int(1)])
		}
	} else {
		mut var_menu_obj := // unsupported expression: Expr_Cast_Object
		rt.call_function('array_splice', [var_menus_mutated.dup(), var_index.dup(), if rt.is_true(rt.identical(// unsupported expression: Expr_UnaryMinus, var_index)) { rt.new_int(0) } else { rt.new_int(1) }, rt.create_array([rt.ArrayItem{ key: none, val: var_menu_obj }])])
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_is_delete)))) && !(!rt.is_true(var_args.array_get('orderby'))))) {
		var_menus_mutated = rt.call_function('wp_list_sort', [var_menus_mutated.dup(), rt.create_array([rt.ArrayItem{ key: var_args.array_get('orderby'), val: 'ASC' }])])
	}
	return var_menus_mutated.dup()
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) _sort_menus_by_orderby(var_menu1 rt.PhpVal, var_menu2 rt.PhpVal) rt.PhpVal {
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('4.7.0'), rt.new_string('wp_list_sort')])
	mut var_key := this._current_menus_sort_orderby
	return rt.call_function('strcmp', [rt.get_property(var_menu1, '{"nodeType":"Expr_Variable","line":323,"name":"key"}'), rt.get_property(var_menu2, '{"nodeType":"Expr_Variable","line":323,"name":"key"}')])
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) filter_wp_get_nav_menu_object(var_menu_obj rt.PhpVal, var_menu_id rt.PhpVal) bool {
	mut var_menu_obj_mutated := var_menu_obj
	mut var_menu_id_mutated := var_menu_id
	mut var_ok := rt.new_bool(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.call_function('get_current_blog_id', []rt.PhpVal{}), rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this), '_previewed_blog_id'))) && rt.is_true(rt.new_bool(var_menu_id_mutated.dup().is_long())))) && rt.is_true(rt.identical(var_menu_id_mutated, this.term_id))))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_ok)))) {
		return (var_menu_obj_mutated).to_bool()
	}
	mut var_setting_value := this.value()
	if rt.is_true(rt.identical(rt.new_bool(false), var_setting_value)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), var_setting_value)) {
		return (var_menu_obj_mutated).to_bool()
	}
	var_menu_obj_mutated = // unsupported expression: Expr_Cast_Object
	return (var_menu_obj_mutated).to_bool()
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) filter_nav_menu_options(var_nav_menu_options rt.PhpVal) rt.PhpVal {
	mut var_nav_menu_options_mutated := var_nav_menu_options
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		return var_nav_menu_options_mutated.dup()
	}
	mut var_menu := this.value()
	var_nav_menu_options_mutated = this.filter_nav_menu_options_value(var_nav_menu_options_mutated.dup(), this.term_id, if rt.is_true(rt.identical(rt.new_bool(false), var_menu)) { rt.new_bool(false) } else { var_menu.array_get('auto_add') })
	return var_nav_menu_options_mutated.dup()
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) sanitize(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(rt.identical(rt.new_bool(false), var_value_mutated)) {
		return var_value_mutated.dup()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_value_mutated.dup().is_array()))))) {
		return rt.new_null()
	}
	mut var_default := { 'name': rt.new_string(''), 'description': rt.new_string(''), 'parent': rt.new_int(0), 'auto_add': rt.new_bool(false) }
	var_value_mutated = rt.call_function('array_merge', [var_default.dup(), var_value_mutated.dup()])
	var_value_mutated = rt.call_function('wp_array_slice_assoc', [var_value_mutated.dup(), rt.func_array_keys(var_default.dup())])
	var_value_mutated.array_set('name', rt.call_function('esc_html', [var_value_mutated.array_get('name')]).to_string().trim_space())
	var_value_mutated.array_set('description', rt.call_function('sanitize_text_field', [var_value_mutated.array_get('description')]))
	var_value_mutated.array_set('parent', rt.call_function('max', [rt.new_int(0), // unsupported expression: Expr_Cast_Int]))
	var_value_mutated.array_set('auto_add', !(!rt.is_true(var_value_mutated.array_get('auto_add'))))
	if rt.is_true(rt.identical(rt.new_string(''), var_value_mutated.array_get('name'))) {
		var_value_mutated.array_set('name', rt.call_function('_x', [rt.new_string('(unnamed)'), rt.new_string('Missing menu name.')]))
	}
	return rt.call_function('apply_filters', [rt.concat(rt.new_string('customize_sanitize_'), rt.get_property(rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this), 'id')), var_value_mutated.dup(), rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this)])
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) update(var_value rt.PhpVal) rt.PhpVal {
	mut var_value_mutated := var_value
	if rt.is_true(this.is_updated) {
		return // unsupported expression: Expr_BinaryOp_NotIdentical
	}
	this.is_updated = true
	mut var_is_placeholder := rt.less(this.term_id, rt.new_int(0))
	mut var_is_delete := rt.identical(rt.new_bool(false), var_value_mutated)
	rt.call_function('add_filter', [rt.new_string('customize_save_response'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Nav_Menu_Setting', ['WP_Customize_Setting'], &this) }, rt.ArrayItem{ key: none, val: 'amend_customize_save_response' }])])
	mut var_auto_add := rt.new_null()
	if rt.is_true(var_is_delete) {
		if rt.is_true(var_is_placeholder) {
			this.update_status = 'deleted'
		} else {
			mut var_r := rt.call_function('wp_delete_nav_menu', [this.term_id])
			if rt.is_true(rt.call_function('is_wp_error', [var_r.dup()])) {
				this.update_status = 'error'
				this.update_error = var_r.dup()
			} else {
				this.update_status = 'deleted'
				var_auto_add = rt.new_bool(rt.new_bool(false))
			}
		}
	} else {
		mut var_menu_data := rt.call_function('wp_array_slice_assoc', [var_value_mutated.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'description' }, rt.ArrayItem{ key: none, val: 'parent' }])])
		var_menu_data.array_set('menu-name', var_value_mutated.array_get('name'))
		mut var_menu_id := if rt.is_true(var_is_placeholder) { rt.new_int(0) } else { this.term_id }
		var_r = rt.call_function('wp_update_nav_menu_object', [var_menu_id.dup(), rt.call_function('wp_slash', [var_menu_data.dup()])])
		mut var_original_name := var_menu_data.array_get('menu-name')
		mut var_name_conflict_suffix := rt.new_int(rt.new_int(1))
		for rt.is_true(rt.new_bool(rt.is_true(rt.call_function('is_wp_error', [var_r.dup()])) && rt.is_true(rt.identical(rt.new_string('menu_exists'), rt.call_method(var_r, 'get_error_code', []rt.PhpVal{}))))) {
			// unsupported expression: Expr_AssignOp_Plus
			var_menu_data.array_set('menu-name', rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('%1$s (%2$d)')]), var_original_name.dup(), var_name_conflict_suffix.dup()]))
			var_r = rt.call_function('wp_update_nav_menu_object', [var_menu_id.dup(), rt.call_function('wp_slash', [var_menu_data.dup()])])
		}
		if rt.is_true(rt.call_function('is_wp_error', [var_r.dup()])) {
			this.update_status = 'error'
			this.update_error = var_r.dup()
		} else {
			if rt.is_true(var_is_placeholder) {
				this.previous_term_id = this.term_id
				this.term_id = var_r.dup()
				this.update_status = 'inserted'
			} else {
				this.update_status = 'updated'
			}
			var_auto_add = .array_get()
		}
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		mut var_nav_menu_options := this.filter_nav_menu_options_value(, , .dup())
		rt.call_function('update_option', [, .dup()])
	}
	if rt.is_true(rt.identical(, )) {
		{
			mut iter_1 := .iterator()
			for {
				item_1 := iter_1.next() or { break }
				mut var_setting := item_1.val
			}
		}
	}
	return 
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) filter_nav_menu_options_value(var_nav_menu_options rt.PhpVal, var_menu_id rt.PhpVal, var_auto_add rt.PhpVal) rt.PhpVal {
	mut var_nav_menu_options_mutated := var_nav_menu_options
	mut var_menu_id_mutated := var_menu_id
	mut var_auto_add_mutated := var_auto_add
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) amend_customize_save_response(var_data rt.PhpVal) rt.PhpVal {
	mut var_data_mutated := var_data
}

struct Class_WP_Customize_Setting {
	rt.PhpObjectBase
}

struct Class_Exception {
	rt.PhpObjectBase
pub mut:
		message string
		code i64
		file string
		line i64
}

fn (mut this Class_Exception) construct(var_message rt.PhpVal) {
	this.message = var_message.to_string()
}

fn (mut this Class_Exception) getmessage() string {
	return this.message
}

struct Class_stdClass {
	rt.PhpObjectBase
}

fn create_wp_customize_nav_menu_setting(arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) &Class_WP_Customize_Nav_Menu_Setting {
	mut obj := &Class_WP_Customize_Nav_Menu_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
		prop_type: rt.new_null()
		default: rt.new_array()
		transport: rt.new_string('postMessage')
		term_id: rt.new_null()
		previous_term_id: rt.new_null()
		is_updated: false
		update_status: ''
		update_error: rt.new_null()
		_current_menus_sort_orderby: rt.new_null()
		_widget_nav_menu_updates: rt.new_array()
	}
	obj.construct(arg_0, arg_1, arg_2)
	return obj
}

fn create_wp_customize_setting() &Class_WP_Customize_Setting {
	mut obj := &Class_WP_Customize_Setting{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_exception(arg_0 rt.PhpVal) &Class_Exception {
	mut obj := &Class_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
		message: ''
		code: i64(0)
		file: ''
		line: i64(0)
	}
	obj.construct(arg_0)
	return obj
}

fn create_stdclass() &Class_stdClass {
	mut obj := &Class_stdClass{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Customize_Manager](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			this.construct(mut dispatch_arg_0, dispatch_arg_1, mut dispatch_arg_2)
			return rt.new_null()
		}
		'value' {
			return this.value()
		}
		'preview' {
			return rt.new_bool(this.preview())
		}
		'filter_wp_get_nav_menus' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.filter_wp_get_nav_menus(dispatch_arg_0, dispatch_arg_1)
		}
		'_sort_menus_by_orderby' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this._sort_menus_by_orderby(dispatch_arg_0, dispatch_arg_1)
		}
		'filter_wp_get_nav_menu_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.filter_wp_get_nav_menu_object(dispatch_arg_0, dispatch_arg_1))
		}
		'filter_nav_menu_options' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.filter_nav_menu_options(dispatch_arg_0)
		}
		'sanitize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.sanitize(dispatch_arg_0)
		}
		'update' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.update(dispatch_arg_0)
		}
		'filter_nav_menu_options_value' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.filter_nav_menu_options_value(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'amend_customize_save_response' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.amend_customize_save_response(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_WP_Customize_Nav_Menu_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'default' { return this.default }
		'transport' { return this.transport }
		'term_id' { return this.term_id }
		'previous_term_id' { return this.previous_term_id }
		'is_updated' { return rt.new_bool(this.is_updated) }
		'update_status' { return rt.new_string(this.update_status) }
		'update_error' { return this.update_error }
		'_current_menus_sort_orderby' { return this._current_menus_sort_orderby }
		'_widget_nav_menu_updates' { return this._widget_nav_menu_updates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Nav_Menu_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' { this.prop_type = val; return true }
		'default' { this.default = val; return true }
		'transport' { this.transport = val; return true }
		'term_id' { this.term_id = val; return true }
		'previous_term_id' { this.previous_term_id = val; return true }
		'is_updated' { this.is_updated = (val).to_bool(); return true }
		'update_status' { this.update_status = (val).str(); return true }
		'update_error' { this.update_error = val; return true }
		'_current_menus_sort_orderby' { this._current_menus_sort_orderby = val; return true }
		'_widget_nav_menu_updates' { this._widget_nav_menu_updates = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Customize_Setting) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Customize_Setting) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Customize_Setting) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getMessage' {
			return rt.new_string(this.getmessage())
		}
		else { return none }
	}
}

fn (this &Class_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'message' { return rt.new_string(this.message) }
		'code' { return rt.new_int(this.code) }
		'file' { return rt.new_string(this.file) }
		'line' { return rt.new_int(this.line) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'message' { this.message = (val).str(); return true }
		'code' { this.code = (val).to_i64(); return true }
		'file' { this.file = (val).str(); return true }
		'line' { this.line = (val).to_i64(); return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
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




pub fn init_wp_includes_customize_class_wp_customize_nav_menu_setting_php() {
}

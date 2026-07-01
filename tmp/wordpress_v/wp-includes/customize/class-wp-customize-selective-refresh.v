import rt

pub fn Class_WP_Customize_Selective_Refresh.render_query_var() string {
	return 'wp_customize_render_partials'
}

struct Class_WP_Customize_Selective_Refresh {
	rt.PhpObjectBase
pub mut:
	manager            rt.PhpVal = rt.new_null()
	partials           rt.PhpVal = rt.new_array()
	triggered_errors   rt.PhpVal = rt.new_array()
	current_partial_id rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Customize_Selective_Refresh) construct(mut var_manager Class_WP_Customize_Manager) {
	this.manager = var_manager.dup()
	rt.include_file(
		(rt.get_constant('ABSPATH')).str() + (rt.get_constant('WPINC')).str() + '/customize/class-wp-customize-partial.php',
		'4')
	rt.call_function('add_action', [rt.new_string('customize_preview_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Selective_Refresh',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'init_preview' },
		])])
}

fn (mut this Class_WP_Customize_Selective_Refresh) partials() rt.PhpVal {
	return this.partials
}

fn (mut this Class_WP_Customize_Selective_Refresh) add_partial(var_id rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_args_mutated := var_args
	if rt.is_true(rt.new_bool(rt.instance_of(var_id, 'WP_Customize_Partial'))) {
		mut var_partial := var_id
	} else {
		mut var_class := rt.new_string(rt.new_string('WP_Customize_Partial'))
		var_args_mutated = rt.call_function('apply_filters', [
			rt.new_string('customize_dynamic_partial_args'),
			var_args_mutated.dup(),
			var_id.dup(),
		])
		var_class = rt.call_function('apply_filters', [
			rt.new_string('customize_dynamic_partial_class'),
			var_class.dup(),
			var_id.dup(),
			var_args_mutated.dup(),
		])
		var_partial = rt.create_object_dynamically(var_class, [
			rt.new_object('WP_Customize_Selective_Refresh', []string{}, &this),
			var_id.dup(),
			var_args_mutated.dup(),
		])
	}
	this.partials.array_set(rt.get_property(var_partial, 'id'), var_partial.dup())
	return var_partial.dup()
}

fn (mut this Class_WP_Customize_Selective_Refresh) get_partial(var_id rt.PhpVal) rt.PhpVal {
	if this.partials.array_isset(var_id) {
		return this.partials.array_get(var_id)
	} else {
		return rt.new_null()
	}
	return rt.new_null()
}

fn (mut this Class_WP_Customize_Selective_Refresh) remove_partial(var_id rt.PhpVal) {
	this.partials.array_unset(var_id)
}

fn (mut this Class_WP_Customize_Selective_Refresh) init_preview() {
	rt.call_function('add_action', [rt.new_string('template_redirect'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Selective_Refresh',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_render_partials_request' },
		])])
	rt.call_function('add_action', [rt.new_string('wp_enqueue_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Selective_Refresh',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'enqueue_preview_scripts' },
		])])
}

fn (mut this Class_WP_Customize_Selective_Refresh) enqueue_preview_scripts() {
	rt.call_function('wp_enqueue_script', [rt.new_string('customize-selective-refresh')])
	rt.call_function('add_action', [rt.new_string('wp_footer'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Selective_Refresh',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'export_preview_data' },
		]),
		rt.new_int(1000)])
}

fn (mut this Class_WP_Customize_Selective_Refresh) export_preview_data() {
	mut var_partials := rt.new_array()
	{
		mut iter_1 := this.partials().iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_partial := item_1.val
			if rt.is_true(rt.call_method(var_partial, 'check_capabilities', []rt.PhpVal{})) {
				var_partials.array_set(rt.get_property(var_partial, 'id'), rt.call_method(var_partial,
					'json', []rt.PhpVal{}))
			}
		}
	}
	mut var_switched_locale := rt.call_function('switch_to_user_locale', [
		rt.call_function('get_current_user_id', []rt.PhpVal{}),
	])
	mut var_l10n := {
		'shiftClickToEdit': rt.call_function('__', [
			rt.new_string('Shift-click to edit this element.'),
		])
		'clickEditMenu':    rt.call_function('__', [
			rt.new_string('Click to edit this menu.'),
		])
		'clickEditWidget':  rt.call_function('__', [
			rt.new_string('Click to edit this widget.'),
		])
		'clickEditTitle':   rt.call_function('__', [
			rt.new_string('Click to edit the site title.'),
		])
		'clickEditMisc':    rt.call_function('__', [
			rt.new_string('Click to edit this element.'),
		])
		'badDocumentWrite': rt.call_function('sprintf', [
			rt.call_function('__', [rt.new_string('%s is forbidden')]),
			rt.new_string('document.write()'),
		])
	}
	if rt.is_true(var_switched_locale) {
		rt.call_function('restore_previous_locale', []rt.PhpVal{})
	}
	mut var_exports := {
		'partials':       var_partials
		'renderQueryVar': Class_WP_Customize_Selective_Refresh.render_query_var()
		'l10n':           var_l10n
	}
	rt.call_function('wp_print_inline_script_tag', [
			(rt.call_function('sprintf', [rt.new_string('var _customizePartialRefreshExports = %s;'), rt.call_function('wp_json_encode', [var_exports.dup(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])])).str() +
			'\n//# sourceURL=' + (rt.call_function('rawurlencode', [rt.new_string(@METHOD)])).str(),
	])
}

fn (mut this Class_WP_Customize_Selective_Refresh) add_dynamic_partials(var_partial_ids rt.PhpVal) rt.PhpVal {
	mut var_new_partials := rt.new_array()
	{
		mut iter_1 := var_partial_ids.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_partial_id := item_1.val
			mut var_partial := this.get_partial(var_partial_id.dup())
			if rt.is_true(var_partial) {
				continue
			}
			mut var_partial_args := rt.new_bool(rt.new_bool(false))
			mut var_partial_class := rt.new_string(rt.new_string('WP_Customize_Partial'))
			var_partial_args = rt.call_function('apply_filters', [
				rt.new_string('customize_dynamic_partial_args'),
				var_partial_args.dup(),
				var_partial_id.dup(),
			])
			if rt.is_true(rt.identical(rt.new_bool(false), var_partial_args)) {
				continue
			}
			var_partial_class = rt.call_function('apply_filters', [
				rt.new_string('customize_dynamic_partial_class'),
				var_partial_class.dup(),
				var_partial_id.dup(),
				var_partial_args.dup(),
			])
			var_partial = rt.create_object_dynamically(var_partial_class, [
				rt.new_object('WP_Customize_Selective_Refresh', []string{}, &this),
				var_partial_id.dup(),
				var_partial_args.dup(),
			])
			this.add_partial(var_partial.dup(), rt.new_null())
			var_new_partials << var_partial.dup()
		}
	}
	return var_new_partials.dup()
}

fn (mut this Class_WP_Customize_Selective_Refresh) is_render_partials_request() bool {
	return !(!rt.is_true(rt.get_superglobal('_POST').array_get(Class_WP_Customize_Selective_Refresh.render_query_var())))
}

fn (mut this Class_WP_Customize_Selective_Refresh) handle_error(var_errno rt.PhpVal, var_errstr rt.PhpVal, var_errfile rt.PhpVal, var_errline rt.PhpVal) bool {
	this.triggered_errors.array_push(rt.create_array([
		rt.ArrayItem{ key: 'partial', val: this.current_partial_id },
		rt.ArrayItem{ key: 'error_number', val: var_errno },
		rt.ArrayItem{ key: 'error_string', val: var_errstr },
		rt.ArrayItem{ key: 'error_file', val: var_errfile },
		rt.ArrayItem{ key: 'error_line', val: var_errline },
	]))
	return true
}

fn (mut this Class_WP_Customize_Selective_Refresh) handle_render_partials_request() {
	if !(this.is_render_partials_request()) {
		return rt.new_null()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_customize_preview', []rt.PhpVal{}))))) {
		rt.call_function('wp_send_json_error', [
			rt.new_string('expected_customize_preview'),
			rt.new_int(403),
		])
	} else if !(rt.get_superglobal('_POST').array_isset(rt.new_string('partials'))) {
		rt.call_function('wp_send_json_error', [rt.new_string('missing_partials'),
			rt.new_int(400)])
	}
	rt.call_function('status_header', [rt.new_int(200)])
	mut var_partials := rt.call_function('json_decode', [
		rt.call_function('wp_unslash', [rt.get_superglobal('_POST').array_get('partials')]),
		rt.new_bool(true),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_partials.dup().is_array()))))) {
		rt.call_function('wp_send_json_error', [rt.new_string('malformed_partials')])
	}
	this.add_dynamic_partials(rt.func_array_keys(var_partials.dup()))
	rt.call_function('do_action', [rt.new_string('customize_render_partials_before'),
		rt.new_object('WP_Customize_Selective_Refresh', []string{}, &this),
		var_partials.dup()])
	rt.call_function('set_error_handler', [
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Customize_Selective_Refresh',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'handle_error' },
		]),
		rt.call_function('error_reporting', []rt.PhpVal{}),
	])
	mut var_contents := rt.new_array()
	{
		mut iter_1 := var_partials.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_container_contexts := item_1.val
			mut var_partial_id := item_1.key
			this.current_partial_id = var_partial_id.dup()
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_container_contexts.dup().is_array()))))) {
				rt.call_function('wp_send_json_error', [
					rt.new_string('malformed_container_contexts'),
				])
			}
			mut var_partial := this.get_partial(var_partial_id.dup())
			if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(var_partial))))
				|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(var_partial, 'check_capabilities', []rt.PhpVal{})))))))
			{
				var_contents.array_set(var_partial_id, rt.new_null())
				continue
			}
			var_contents.array_set(var_partial_id, rt.new_array())
			if !rt.is_true(var_container_contexts) {
				var_contents.array_get_mut(var_partial_id).array_push(rt.call_method(var_partial,
					'render', [rt.new_null()]))
			} else {
				{
					mut iter_2 := var_container_contexts.iterator()
					for {
						item_2 := iter_2.next() or { break }
						mut var_container_context := item_2.val
						var_contents.array_get_mut(var_partial_id).array_push(rt.call_method(var_partial,
							'render', [var_container_context.dup()]))
					}
				}
			}
		}
	}
	this.current_partial_id = rt.new_null()
	rt.call_function('restore_error_handler', []rt.PhpVal{})
	rt.call_function('do_action', [rt.new_string('customize_render_partials_after'),
		rt.new_object('WP_Customize_Selective_Refresh', []string{}, &this),
		var_partials.dup()])
	mut var_response := rt.create_array([
		rt.ArrayItem{ key: 'contents', val: var_contents },
	])
	if rt.is_true(rt.new_bool(
		rt.is_true(rt.call_function('defined', [rt.new_string('WP_DEBUG_DISPLAY')]))
		&& rt.is_true(rt.get_constant('WP_DEBUG_DISPLAY'))))
	{
		var_response.array_set('errors', this.triggered_errors)
	}
	mut var_setting_validities := rt.call_method(this.manager, 'validate_setting_values', [
		rt.call_method(this.manager, 'unsanitized_post_values', []rt.PhpVal{}),
	])
	mut var_exported_setting_validities := rt.call_function('array_map', [
		rt.create_array([rt.ArrayItem{ key: none, val: this.manager },
			rt.ArrayItem{ key: none, val: 'prepare_setting_validity_for_js' }]),
		var_setting_validities.dup(),
	])
	var_response.array_set('setting_validities', var_exported_setting_validities.dup())
	var_response = rt.call_function('apply_filters', [
		rt.new_string('customize_render_partials_response'),
		var_response.dup(),
		rt.new_object('WP_Customize_Selective_Refresh', []string{}, &this),
		var_partials.dup(),
	])
	rt.call_function('wp_send_json_success', [var_response.dup()])
}

fn create_wp_customize_selective_refresh(arg_0 rt.PhpVal) &Class_WP_Customize_Selective_Refresh {
	mut obj := &Class_WP_Customize_Selective_Refresh{
		PhpObjectBase:      rt.PhpObjectBase{}
		manager:            rt.new_null()
		partials:           rt.new_array()
		triggered_errors:   rt.new_array()
		current_partial_id: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn (mut this Class_WP_Customize_Selective_Refresh) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_WP_Customize_Manager](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'partials' {
			return this.partials()
		}
		'add_partial' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.add_partial(dispatch_arg_0, dispatch_arg_1)
		}
		'get_partial' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_partial(dispatch_arg_0)
		}
		'remove_partial' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.remove_partial(dispatch_arg_0)
			return rt.new_null()
		}
		'init_preview' {
			this.init_preview()
			return rt.new_null()
		}
		'enqueue_preview_scripts' {
			this.enqueue_preview_scripts()
			return rt.new_null()
		}
		'export_preview_data' {
			this.export_preview_data()
			return rt.new_null()
		}
		'add_dynamic_partials' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.add_dynamic_partials(dispatch_arg_0)
		}
		'is_render_partials_request' {
			return rt.new_bool(this.is_render_partials_request())
		}
		'handle_error' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return rt.new_bool(this.handle_error(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3))
		}
		'handle_render_partials_request' {
			this.handle_render_partials_request()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Customize_Selective_Refresh) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'manager' { return this.manager }
		'partials' { return this.partials }
		'triggered_errors' { return this.triggered_errors }
		'current_partial_id' { return this.current_partial_id }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Customize_Selective_Refresh) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'manager' {
			this.manager = val
			return true
		}
		'partials' {
			this.partials = val
			return true
		}
		'triggered_errors' {
			this.triggered_errors = val
			return true
		}
		'current_partial_id' {
			this.current_partial_id = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
	rt.register_class_factory('WP_Customize_Selective_Refresh', fn (args []rt.PhpVal) rt.PhpVal {
		c_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
		obj := create_wp_customize_selective_refresh(c_arg_0)
		return rt.new_object('WP_Customize_Selective_Refresh', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

pub fn init_wp_includes_customize_class_wp_customize_selective_refresh_php() {
}

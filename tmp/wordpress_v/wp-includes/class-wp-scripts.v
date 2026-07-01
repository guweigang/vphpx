import rt

struct Class_WP_Scripts {
	rt.PhpObjectBase
pub mut:
		base_url rt.PhpVal = rt.new_null()
		content_url rt.PhpVal = rt.new_null()
		default_version rt.PhpVal = rt.new_null()
		in_footer rt.PhpVal = rt.new_array()
		concat string
		concat_version string
		do_concat bool
		print_html string
		print_code string
		ext_handles string
		ext_version string
		default_dirs rt.PhpVal = rt.new_null()
		dependents_map rt.PhpVal = rt.new_array()
		delayed_strategies rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Scripts) construct()  {
	this.init()
	rt.call_function('add_action', [rt.new_string('init'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Scripts', ['WP_Dependencies'], &this) }, rt.ArrayItem{ key: none, val: 'init' }]), rt.new_int(0)])
}

fn (mut this Class_WP_Scripts) init()  {
	rt.call_function('do_action_ref_array', [rt.new_string('wp_default_scripts'), rt.create_array([rt.ArrayItem{ key: none, val: rt.new_object('WP_Scripts', ['WP_Dependencies'], &this) }])])
}

fn (mut this Class_WP_Scripts) print_scripts(handles bool, group bool) rt.PhpVal {
	return this.do_items(rt.new_bool(handles), rt.new_bool(group))
}

fn (mut this Class_WP_Scripts) print_scripts_l10n(var_handle rt.PhpVal, display bool) rt.PhpVal {
	mut var_handle_mutated := var_handle
	rt.call_function('_deprecated_function', [rt.new_string(@FN), rt.new_string('3.3.0'), rt.new_string('WP_Scripts::print_extra_script()')])
	return rt.new_bool(this.print_extra_script(var_handle_mutated.dup(), display))
}

fn (mut this Class_WP_Scripts) print_extra_script(var_handle rt.PhpVal, display bool) bool {
	mut var_handle_mutated := var_handle
	mut var_output := this.get_data(var_handle_mutated.dup(), rt.new_string('data'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_output)))) {
		return false
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.do_concat)))) {
		// unsupported expression: Expr_AssignOp_Concat
	}
	if !(var_display) {
		return (var_output).to_bool()
	}
	rt.call_function('wp_print_inline_script_tag', [var_output.dup(), rt.create_array([rt.ArrayItem{ key: 'id', val: "${var_handle.to_string()}-js-extra" }])])
	return true
}

fn (mut this Class_WP_Scripts) are_all_dependents_in_footer(var_handle rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	{
		mut iter_1 := this.get_dependents(var_handle_mutated.dup()).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_dep := item_1.val
			if rt.is_true(rt.new_bool(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_isset(var_dep) && rt.is_true(rt.identical(rt.new_int(0), rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_get(var_dep))))) {
				return false
			}
		}
	}
	return true
}

fn (mut this Class_WP_Scripts) do_item(var_handle rt.PhpVal, group bool) bool {
	mut var_handle_mutated := var_handle
	if rt.is_true(rt.new_bool(!(rt.is_true(this.Class_WP_Dependencies.do_item(var_handle_mutated.dup()))))) {
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), rt.new_bool(group))) && rt.is_true(rt.greater(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_get(var_handle_mutated), rt.new_int(0))))) {
		this.in_footer.array_push(var_handle_mutated.dup())
		return false
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(group))) && rt.is_true(rt.call_function('in_array', [var_handle_mutated.dup(), this.in_footer, rt.new_bool(true)])))) {
		this.in_footer = rt.call_function('array_diff', [this.in_footer, rt.cast_array(var_handle_mutated)])
	}
	mut var_obj := rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_get(var_handle_mutated)
	if rt.is_true(if !(rt.get_property(var_obj, 'extra').array_get('conditional')).is_null() { rt.get_property(var_obj, 'extra').array_get('conditional') } else { rt.new_bool(false) }) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_obj, 'ver'))) {
		mut var_ver := rt.new_string(rt.new_string(''))
	} else {
		var_ver = if rt.is_true(rt.get_property(var_obj, 'ver')) { rt.get_property(var_obj, 'ver') } else { this.default_version }
	}
	if rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'args').array_isset(var_handle_mutated) {
		var_ver = if rt.is_true(var_ver) { (var_ver).str() + '&amp;' + (rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'args').array_get(var_handle_mutated)).str() } else { rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'args').array_get(var_handle_mutated) }
	}
	mut var_src := rt.get_property(var_obj, 'src')
	mut var_strategy := rt.new_string(this.get_eligible_loading_strategy(var_handle_mutated.dup()))
	mut var_intended_strategy := // unsupported expression: Expr_Cast_String
	if !(this.is_delayed_strategy(var_intended_strategy.dup())) {
		var_intended_strategy = rt.new_string(rt.new_string(''))
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_int(0), rt.new_bool(group))) && rt.is_true(rt.identical(rt.new_int(0), rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_get(var_handle_mutated))))) && rt.is_true(var_intended_strategy))) && !(this.is_delayed_strategy(var_strategy.dup())))) && this.are_all_dependents_in_footer(var_handle_mutated.dup()))) {
		this.in_footer.array_push(var_handle_mutated.dup())
		return false
	}
	mut var_before_script := rt.new_string(this.get_inline_script_tag(var_handle_mutated.dup(), 'before'))
	mut var_after_script := rt.new_string(this.get_inline_script_tag(var_handle_mutated.dup(), 'after'))
	if rt.is_true(rt.new_bool(rt.is_true(var_before_script) || rt.is_true(var_after_script))) {
		mut var_inline_script_tag := rt.new_string(rt.concat(var_before_script, var_after_script))
	} else {
		var_inline_script_tag = rt.new_string(rt.new_string(''))
	}
	mut var_translations_stop_concat := rt.new_bool(rt.new_bool(!(!rt.is_true(rt.get_property(var_obj, 'textdomain')))))
	mut var_translations := rt.new_bool(this.print_translations(var_handle_mutated.dup(), false))
	if rt.is_true(var_translations) {
		mut var_source_url := rt.call_function('rawurlencode', [rt.new_string("${var_handle.to_string()}-js-translations")])
		// unsupported expression: Expr_AssignOp_Concat
		var_translations = rt.call_function('wp_get_inline_script_tag', [var_translations.dup(), rt.create_array([rt.ArrayItem{ key: 'id', val: "${var_handle.to_string()}-js-translations" }])])
	}
	if rt.is_true(this.do_concat) {
		mut var_filtered_src := rt.call_function('apply_filters', [rt.new_string('script_loader_src'), var_src.dup(), var_handle_mutated.dup()])
		if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_filtered_src.dup().is_string())) && this.in_default_dir(var_filtered_src.dup()))) && rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(rt.is_true(var_before_script) || rt.is_true(var_after_script))) || rt.is_true(var_translations_stop_concat))) || this.is_delayed_strategy(var_strategy.dup()))))) {
			this.do_concat = false
			rt.call_function('_print_scripts', []rt.PhpVal{})
			this.reset()
		} else if this.in_default_dir(var_filtered_src.dup()) {
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
			return true
		} else {
			// unsupported expression: Expr_AssignOp_Concat
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	this.print_extra_script(var_handle_mutated.dup(), false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		if rt.is_true(var_inline_script_tag) {
			if rt.is_true(this.do_concat) {
				// unsupported expression: Expr_AssignOp_Concat
			} else {
				rt.echo_val(var_inline_script_tag)
			}
		}
		return true
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), var_src.dup()]))))) && rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(rt.is_true(this.content_url) && rt.is_true(rt.call_function('str_starts_with', [var_src.dup(), this.content_url]))))))))) {
		var_src = rt.new_string(rt.concat(this.base_url, var_src))
	}
	mut var_ver_to_add := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(!rt.is_true(rt.get_property(var_obj, 'ver')) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) && rt.is_true(rt.new_bool(this.default_version.is_string())))) {
		var_ver_to_add = this.default_version
	} else if rt.is_true(rt.call_function('is_scalar', [rt.get_property(var_obj, 'ver')])) {
		var_ver_to_add = // unsupported expression: Expr_Cast_String
	}
	mut var_added_args := // unsupported expression: Expr_Cast_String
	if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) || rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		mut var_fragment := rt.call_function('strstr', [var_src.dup(), rt.new_string('#')])
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			var_src = rt.call_function('substr', [var_src.dup(), rt.new_int(0), // unsupported expression: Expr_UnaryMinus])
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported expression: Expr_AssignOp_Concat
		}
		if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
			// unsupported expression: Expr_AssignOp_Concat
		}
	}
	var_src = rt.call_function('esc_url_raw', [rt.call_function('apply_filters', [rt.new_string('script_loader_src'), var_src.dup(), var_handle_mutated.dup()])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		return true
	}
	mut var_attr := rt.create_array([rt.ArrayItem{ key: 'src', val: var_src }, rt.ArrayItem{ key: 'id', val: "${var_handle.to_string()}-js" }])
	if rt.is_true(var_strategy) {
		var_attr.array_set(var_strategy, true)
	}
	if rt.is_true(var_intended_strategy) {
		var_attr.array_set('data-wp-strategy', var_intended_strategy.dup())
	}
	mut var_original_fetchpriority := if !(rt.get_property(var_obj, 'extra').array_get('fetchpriority')).is_null() { rt.get_property(var_obj, 'extra').array_get('fetchpriority') } else { rt.new_null() }
	if rt.is_true(rt.new_bool(rt.is_true(rt.identical(rt.new_null(), var_original_fetchpriority)) || !(this.is_valid_fetchpriority(var_original_fetchpriority.dup())))) {
		var_original_fetchpriority = rt.new_string(rt.new_string('auto'))
	}
	mut var_actual_fetchpriority := rt.new_string(this.get_highest_fetchpriority_with_dependents((var_handle_mutated).str(), rt.new_null(), rt.new_null()))
	if rt.is_true(rt.identical(rt.new_null(), var_actual_fetchpriority)) {
		var_actual_fetchpriority = var_original_fetchpriority.dup()
	}
	if rt.is_true(rt.new_bool(rt.is_true(rt.new_bool(var_actual_fetchpriority.dup().is_string())) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) {
		var_attr.array_set('fetchpriority', var_actual_fetchpriority.dup())
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		var_attr.array_set('data-wp-fetchpriority', var_original_fetchpriority.dup())
	}
	mut var_tag := rt.new_string(rt.concat(var_translations, var_before_script))
	// unsupported expression: Expr_AssignOp_Concat
	// unsupported expression: Expr_AssignOp_Concat
	var_tag = rt.call_function('apply_filters', [rt.new_string('script_loader_tag'), var_tag.dup(), var_handle_mutated.dup(), var_src.dup()])
	if rt.is_true(this.do_concat) {
		// unsupported expression: Expr_AssignOp_Concat
	} else {
		rt.echo_val(var_tag)
	}
	return true
}

fn (mut this Class_WP_Scripts) add_inline_script(var_handle rt.PhpVal, var_data rt.PhpVal, position string) bool {
	mut var_handle_mutated := var_handle
	mut var_data_mutated := var_data
	mut position_mutated := position
	if rt.is_true(rt.new_bool(!(rt.is_true(var_data_mutated)))) {
		return false
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		position_mutated = 'before'
	}
	mut var_script := rt.cast_array(this.get_data(var_handle_mutated.dup(), rt.new_string(position_mutated)))
	var_script.array_push(var_data_mutated.dup())
	return this.add_data(var_handle_mutated.dup(), rt.new_string(position_mutated), var_script.dup())
}

fn (mut this Class_WP_Scripts) print_inline_script(var_handle rt.PhpVal, position string, display bool) bool {
	mut var_handle_mutated := var_handle
	mut position_mutated := position
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD), rt.new_string('6.3.0'), rt.new_string('WP_Scripts::get_inline_script_data() or WP_Scripts::get_inline_script_tag()')])
	mut var_output := rt.new_string(this.get_inline_script_data(var_handle_mutated.dup(), position_mutated))
	if !rt.is_true(var_output) {
		return false
	}
	if var_display {
		print(this.get_inline_script_tag(var_handle_mutated.dup(), position_mutated))
	}
	return (var_output).to_bool()
}

fn (mut this Class_WP_Scripts) get_inline_script_data(var_handle rt.PhpVal, position string) string {
	mut var_handle_mutated := var_handle
	mut position_mutated := position
	mut var_data := this.get_data(var_handle_mutated.dup(), rt.new_string(position_mutated))
	if rt.is_true(rt.new_bool(!rt.is_true(var_data) || rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_data.dup().is_array()))))))) {
		return ''
	}
	var_data.array_push(rt.call_function('sprintf', [rt.new_string('//# sourceURL=%s'), rt.call_function('rawurlencode', [rt.new_string("${var_handle.to_string()}-js-${var_position.to_string()}")])]))
	return rt.call_function('implode', [rt.new_string('\n'), var_data.dup()]).to_string().trim_space()
}

fn (mut this Class_WP_Scripts) get_inline_script_tag(var_handle rt.PhpVal, position string) string {
	mut var_handle_mutated := var_handle
	mut position_mutated := position
	mut var_js := rt.new_string(this.get_inline_script_data(var_handle_mutated.dup(), position_mutated))
	if !rt.is_true(var_js) {
		return ''
	}
	mut var_id := rt.new_string()
	return ().str()
}

fn (mut this Class_WP_Scripts) localize(var_handle rt.PhpVal, var_object_name rt.PhpVal, var_l10n rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_l10n_mutated := var_l10n
}

fn (mut this Class_WP_Scripts) set_group(var_handle rt.PhpVal, var_recursion rt.PhpVal, group bool) rt.PhpVal {
	mut var_handle_mutated := var_handle
}

fn (mut this Class_WP_Scripts) set_translations(var_handle rt.PhpVal, domain string, path string) bool {
	mut var_handle_mutated := var_handle
	mut domain_mutated := domain
	mut path_mutated := path
}

fn (mut this Class_WP_Scripts) print_translations(var_handle rt.PhpVal, display bool) bool {
	mut var_handle_mutated := var_handle
}

fn (mut this Class_WP_Scripts) all_deps(var_handles rt.PhpVal, recursion bool, group bool) rt.PhpVal {
}

fn (mut this Class_WP_Scripts) do_head_items() rt.PhpVal {
}

fn (mut this Class_WP_Scripts) do_footer_items() rt.PhpVal {
}

fn (mut this Class_WP_Scripts) in_default_dir(var_src rt.PhpVal) bool {
	mut var_src_mutated := var_src
}

fn (mut this Class_WP_Scripts) add_data(var_handle rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_value_mutated := var_value
}

fn (mut this Class_WP_Scripts) get_dependents(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
}

fn (mut this Class_WP_Scripts) is_delayed_strategy(var_strategy rt.PhpVal) bool {
	mut var_strategy_mutated := var_strategy
}

fn (mut this Class_WP_Scripts) is_valid_fetchpriority(var_priority rt.PhpVal) bool {
}

fn (mut this Class_WP_Scripts) get_eligible_loading_strategy(var_handle rt.PhpVal) string {
	mut var_handle_mutated := var_handle
}

fn (mut this Class_WP_Scripts) filter_eligible_strategies(var_handle rt.PhpVal, var_eligible_strategies rt.PhpVal, var_checked rt.PhpVal, mut var_stored_results Class_array) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_eligible_strategies_mutated := var_eligible_strategies
	mut var_checked_mutated := var_checked
	mut var_stored_results_mutated := var_stored_results
}

fn (mut this Class_WP_Scripts) get_highest_fetchpriority_with_dependents(handle string, mut var_checked Class_array, mut var_stored_results Class_array) string {
	mut var_priorities := rt.new_null()
	mut handle_mutated := handle
	mut var_checked_mutated := var_checked
	mut var_stored_results_mutated := var_stored_results
}

fn (mut this Class_WP_Scripts) has_inline_script(var_handle rt.PhpVal, var_position rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_position_mutated := var_position
}

fn (mut this Class_WP_Scripts) reset()  {
}

fn (mut this Class_WP_Scripts) get_dependency_warning_message(var_handle rt.PhpVal, var_missing_dependency_handles rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
}

struct Class_WP_Dependencies {
	rt.PhpObjectBase
}

fn create_wp_scripts() &Class_WP_Scripts {
	mut obj := &Class_WP_Scripts{
		PhpObjectBase: rt.PhpObjectBase{}
		base_url: rt.new_null()
		content_url: rt.new_null()
		default_version: rt.new_null()
		in_footer: rt.new_array()
		concat: ''
		concat_version: ''
		do_concat: false
		print_html: ''
		print_code: ''
		ext_handles: ''
		ext_version: ''
		default_dirs: rt.new_null()
		dependents_map: rt.new_array()
		delayed_strategies: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_dependencies() &Class_WP_Dependencies {
	mut obj := &Class_WP_Dependencies{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Scripts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init' {
			this.init()
			return rt.new_null()
		}
		'print_scripts' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.print_scripts(dispatch_arg_0, dispatch_arg_1)
		}
		'print_scripts_l10n' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.print_scripts_l10n(dispatch_arg_0, dispatch_arg_1)
		}
		'print_extra_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.print_extra_script(dispatch_arg_0, dispatch_arg_1))
		}
		'are_all_dependents_in_footer' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.are_all_dependents_in_footer(dispatch_arg_0))
		}
		'do_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.do_item(dispatch_arg_0, dispatch_arg_1))
		}
		'add_inline_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.add_inline_script(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'print_inline_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.print_inline_script(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_inline_script_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_inline_script_data(dispatch_arg_0, dispatch_arg_1))
		}
		'get_inline_script_tag' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return rt.new_string(this.get_inline_script_tag(dispatch_arg_0, dispatch_arg_1))
		}
		'localize' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.localize(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_group' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.set_group(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'set_translations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_translations(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'print_translations' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.print_translations(dispatch_arg_0, dispatch_arg_1))
		}
		'all_deps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.all_deps(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'do_head_items' {
			return this.do_head_items()
		}
		'do_footer_items' {
			return this.do_footer_items()
		}
		'in_default_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.in_default_dir(dispatch_arg_0))
		}
		'add_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.add_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'get_dependents' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_dependents(dispatch_arg_0)
		}
		'is_delayed_strategy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_delayed_strategy(dispatch_arg_0))
		}
		'is_valid_fetchpriority' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.is_valid_fetchpriority(dispatch_arg_0))
		}
		'get_eligible_loading_strategy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_eligible_loading_strategy(dispatch_arg_0))
		}
		'filter_eligible_strategies' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_array](if args.len > 3 { args[3] } else { rt.new_null() })
			return this.filter_eligible_strategies(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut dispatch_arg_3)
		}
		'get_highest_fetchpriority_with_dependents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 { args[1] } else { rt.new_null() })
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 { args[2] } else { rt.new_null() })
			return rt.new_string(this.get_highest_fetchpriority_with_dependents(dispatch_arg_0, mut dispatch_arg_1, mut dispatch_arg_2))
		}
		'has_inline_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.has_inline_script(dispatch_arg_0, dispatch_arg_1)
		}
		'reset' {
			this.reset()
			return rt.new_null()
		}
		'get_dependency_warning_message' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.get_dependency_warning_message(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Scripts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'base_url' { return this.base_url }
		'content_url' { return this.content_url }
		'default_version' { return this.default_version }
		'in_footer' { return this.in_footer }
		'concat' { return rt.new_string(this.concat) }
		'concat_version' { return rt.new_string(this.concat_version) }
		'do_concat' { return rt.new_bool(this.do_concat) }
		'print_html' { return rt.new_string(this.print_html) }
		'print_code' { return rt.new_string(this.print_code) }
		'ext_handles' { return rt.new_string(this.ext_handles) }
		'ext_version' { return rt.new_string(this.ext_version) }
		'default_dirs' { return this.default_dirs }
		'dependents_map' { return this.dependents_map }
		'delayed_strategies' { return this.delayed_strategies }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Scripts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'base_url' { this.base_url = val; return true }
		'content_url' { this.content_url = val; return true }
		'default_version' { this.default_version = val; return true }
		'in_footer' { this.in_footer = val; return true }
		'concat' { this.concat = (val).str(); return true }
		'concat_version' { this.concat_version = (val).str(); return true }
		'do_concat' { this.do_concat = (val).to_bool(); return true }
		'print_html' { this.print_html = (val).str(); return true }
		'print_code' { this.print_code = (val).str(); return true }
		'ext_handles' { this.ext_handles = (val).str(); return true }
		'ext_version' { this.ext_version = (val).str(); return true }
		'default_dirs' { this.default_dirs = val; return true }
		'dependents_map' { this.dependents_map = val; return true }
		'delayed_strategies' { this.delayed_strategies = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_WP_Dependencies) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Dependencies) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Dependencies) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_scripts_php() {
}

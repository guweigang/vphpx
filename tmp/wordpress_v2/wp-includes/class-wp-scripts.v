import rt

struct Class_WP_Scripts {
	rt.PhpObjectBase
pub mut:
	base_url           rt.PhpVal = rt.new_null()
	content_url        rt.PhpVal = rt.new_null()
	default_version    rt.PhpVal = rt.new_null()
	in_footer          rt.PhpVal = rt.new_array()
	concat             string
	concat_version     string
	do_concat          bool
	print_html         string
	print_code         string
	ext_handles        string
	ext_version        string
	default_dirs       rt.PhpVal = rt.new_null()
	dependents_map     rt.PhpVal = rt.new_array()
	delayed_strategies rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Scripts) construct() {
	this.init()
	rt.call_function('add_action', [rt.new_string('init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Scripts', [
				'WP_Dependencies',
			], &this) },
			rt.ArrayItem{ key: none, val: 'init' },
		]),
		rt.new_int(0)])
}

fn (mut this Class_WP_Scripts) init() {
	rt.call_function('do_action_ref_array', [rt.new_string('wp_default_scripts'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Scripts', [
				'WP_Dependencies',
			], &this) },
		])])
}

fn (mut this Class_WP_Scripts) print_scripts(handles bool, group bool) rt.PhpVal {
	return this.do_items(rt.new_bool(handles), rt.new_bool(group))
}

fn (mut this Class_WP_Scripts) print_scripts_l10n(var_handle rt.PhpVal, display bool) rt.PhpVal {
	mut var_handle_mutated := var_handle
	rt.call_function('_deprecated_function', [rt.new_string(@FN),
		rt.new_string('3.3.0'), rt.new_string('WP_Scripts::print_extra_script()')])
	return rt.new_bool(this.print_extra_script(var_handle_mutated.clone(), display))
}

fn (mut this Class_WP_Scripts) print_extra_script(var_handle rt.PhpVal, display bool) bool {
	mut var_handle_mutated := var_handle
	mut var_output := this.get_data(var_handle_mutated.clone(), rt.new_string('data'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_output)))) {
		return false
	}
	if !(this.do_concat) {
		var_output = rt.concat(var_output, rt.call_function('sprintf', [
			rt.new_string('\n//# sourceURL=%s'),
			rt.call_function('rawurlencode', [
				rt.new_string('${var_handle.to_string()}-js-extra'),
			]),
		]))
	}
	if !var_display {
		return var_output.to_bool()
	}
	rt.call_function('wp_print_inline_script_tag', [var_output.clone(),
		rt.create_array([
			rt.ArrayItem{ key: 'id', val: '${var_handle.to_string()}-js-extra' },
		])])
	return true
}

fn (mut this Class_WP_Scripts) are_all_dependents_in_footer(var_handle rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut iter_1 := this.get_dependents(var_handle_mutated.clone()).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_dep := item_1.val
		if rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_isset(var_dep)
			&& rt.is_true(rt.identical(rt.new_int(0), rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_get(var_dep))) {
			return false
		}
	}
	return true
}

fn (mut this Class_WP_Scripts) do_item(var_handle rt.PhpVal, group bool) bool {
	mut var_handle_mutated := var_handle
	if rt.is_true(rt.new_bool(!(rt.is_true(this.Class_WP_Dependencies.do_item(var_handle_mutated.clone()))))) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.new_bool(group)))
		&& rt.is_true(rt.greater(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_get(var_handle_mutated), rt.new_int(0))) {
		this.in_footer.array_push(var_handle_mutated.clone())
		return false
	}
	if rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(group)))
		&& rt.is_true(rt.call_function('in_array', [var_handle_mutated.clone(), this.in_footer, rt.new_bool(true)])) {
		this.in_footer = rt.call_function('array_diff', [this.in_footer,
			rt.cast_array(var_handle_mutated)])
	}
	mut var_obj := rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this),
		'registered').array_get(var_handle_mutated)
	if rt.is_true(if !(rt.get_property(var_obj, 'extra').array_get(rt.new_string('conditional'))).is_null() {
		rt.get_property(var_obj, 'extra').array_get(rt.new_string('conditional'))
	} else {
		rt.new_bool(false)
	})
	{
		return false
	}
	if rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_obj, 'ver'))) {
		mut var_ver := rt.new_string('')
	} else {
		var_ver = if rt.is_true(rt.get_property(var_obj, 'ver')) {
			rt.get_property(var_obj, 'ver')
		} else {
			this.default_version
		}
	}
	if rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'args').array_isset(var_handle_mutated) {
		var_ver = if rt.is_true(var_ver) { var_ver.str() + '&amp;' + (rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'args').array_get(var_handle_mutated)).str() } else { rt.get_property(rt.new_object('WP_Scripts', [
				'WP_Dependencies',
			], &this), 'args').array_get(var_handle_mutated) }
	}
	mut var_src := rt.get_property(var_obj, 'src')
	mut var_strategy :=
		rt.new_string(this.get_eligible_loading_strategy(var_handle_mutated.clone()))
	mut var_intended_strategy := rt.new_string((this.get_data(var_handle_mutated.clone(),
		rt.new_string('strategy'))).str())
	if !(this.is_delayed_strategy(var_intended_strategy.clone())) {
		var_intended_strategy = rt.new_string('')
	}
	if rt.is_true(rt.identical(rt.new_int(0), rt.new_bool(group)))
		&& rt.is_true(rt.identical(rt.new_int(0), rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'groups').array_get(var_handle_mutated)))
		&& rt.is_true(var_intended_strategy) && !(this.is_delayed_strategy(var_strategy.clone()))
		&& this.are_all_dependents_in_footer(var_handle_mutated.clone()) {
		this.in_footer.array_push(var_handle_mutated.clone())
		return false
	}
	mut var_before_script := rt.new_string(this.get_inline_script_tag(var_handle_mutated.clone(),
		'before'))
	mut var_after_script := rt.new_string(this.get_inline_script_tag(var_handle_mutated.clone(),
		'after'))
	if rt.is_true(var_before_script) || rt.is_true(var_after_script) {
		mut var_inline_script_tag := rt.new_string(var_before_script.str() + var_after_script.str())
	} else {
		var_inline_script_tag = rt.new_string('')
	}
	mut var_translations_stop_concat := rt.new_bool(!(!rt.is_true(rt.get_property(var_obj,
		'textdomain'))))
	mut var_translations := rt.new_bool(this.print_translations(var_handle_mutated.clone(), false))
	if rt.is_true(var_translations) {
		mut var_source_url := rt.call_function('rawurlencode', [
			rt.new_string('${var_handle.to_string()}-js-translations'),
		])
		var_translations = rt.concat(var_translations,
			rt.new_string('\n//# sourceURL=${var_source_url.to_string()}'))
		var_translations = rt.call_function('wp_get_inline_script_tag', [
			var_translations.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: '${var_handle.to_string()}-js-translations' },
			])])
	}
	if this.do_concat {
		mut var_filtered_src := rt.call_function('apply_filters', [
			rt.new_string('script_loader_src'),
			var_src.clone(),
			var_handle_mutated.clone(),
		])
		if var_filtered_src.clone().is_string() && this.in_default_dir(var_filtered_src.clone())
			&& rt.is_true(var_before_script) || rt.is_true(var_after_script)
			|| rt.is_true(var_translations_stop_concat)
			|| this.is_delayed_strategy(var_strategy.clone()) {
			this.do_concat = false
			rt.call_function('_print_scripts', []rt.PhpVal{})
			this.reset()
		} else if this.in_default_dir(var_filtered_src.clone()) {
			this.print_code = rt.concat(this.print_code, this.print_extra_script(var_handle_mutated.clone(),
				false))
			this.concat = rt.concat(this.concat, rt.new_string('${var_handle.to_string()},'))
			this.concat_version = rt.concat(this.concat_version,
				rt.new_string('${var_handle.to_string()}${var_ver.to_string()}'))
			return true
		} else {
			this.ext_handles = rt.concat(this.ext_handles,
				rt.new_string('${var_handle.to_string()},'))
			this.ext_version = rt.concat(this.ext_version,
				rt.new_string('${var_handle.to_string()}${var_ver.to_string()}'))
		}
	}
	this.print_extra_script(var_handle_mutated.clone(), false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		if rt.is_true(var_inline_script_tag) {
			if this.do_concat {
				this.print_html = rt.concat(this.print_html, var_inline_script_tag)
			} else {
				rt.echo_val(var_inline_script_tag)
			}
		}
		return true
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), var_src.clone()])))))
		&& !(rt.is_true(this.content_url)
		&& rt.is_true(rt.call_function('str_starts_with', [var_src.clone(), this.content_url]))) {
		var_src = rt.new_string((this.base_url).str() + var_src.str())
	}
	mut var_ver_to_add := rt.new_string('')
	if !rt.is_true(rt.get_property(var_obj, 'ver'))
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), rt.get_property(var_obj, 'ver')))))
		&& this.default_version.is_string() {
		var_ver_to_add = this.default_version
	} else if rt.is_true(rt.call_function('is_scalar', [rt.get_property(var_obj, 'ver')])) {
		var_ver_to_add = rt.new_string((rt.get_property(var_obj, 'ver')).str())
	}
	mut var_added_args := rt.new_string((if !(rt.get_property(rt.new_object('WP_Scripts', [
		'WP_Dependencies',
	], &this), 'args').array_get(var_handle_mutated)).is_null() { rt.get_property(rt.new_object('WP_Scripts', [
			'WP_Dependencies',
		], &this), 'args').array_get(var_handle_mutated) } else { rt.new_string('') }).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_ver_to_add))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_added_args)))) {
		mut var_fragment := rt.call_function('strstr', [var_src.clone(),
			rt.new_string('#')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_fragment)))) {
			var_src = rt.call_function('substr', [var_src.clone(),
				rt.new_int(0), rt.new_int(-var_fragment.clone().to_string().len)])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_ver_to_add)))) {
			var_src = rt.concat(var_src, rt.new_string(
				if rt.is_true(rt.call_function('str_contains', [var_src.clone(), rt.new_string('?')])) { '&' } else { '?' } +
				'ver=' + (rt.call_function('rawurlencode', [var_ver_to_add.clone()])).str()))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_added_args)))) {
			var_src = rt.concat(var_src, rt.new_string(
				if rt.is_true(rt.call_function('str_contains', [var_src.clone(), rt.new_string('?')])) { '&' } else { '?' } +
				var_added_args.str()))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_fragment)))) {
			var_src = rt.concat(var_src, var_fragment)
		}
	}
	var_src = rt.call_function('esc_url_raw', [
		rt.call_function('apply_filters', [rt.new_string('script_loader_src'),
			var_src.clone(), var_handle_mutated.clone()]),
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		return true
	}
	mut var_attr := rt.create_array([rt.ArrayItem{ key: 'src', val: var_src },
		rt.ArrayItem{ key: 'id', val: '${var_handle.to_string()}-js' }])
	if rt.is_true(var_strategy) {
		var_attr.array_set(var_strategy, true)
	}
	if rt.is_true(var_intended_strategy) {
		var_attr.array_set('data-wp-strategy', var_intended_strategy.clone())
	}
	mut var_original_fetchpriority := if !(rt.get_property(var_obj, 'extra').array_get(rt.new_string('fetchpriority'))).is_null() {
		rt.get_property(var_obj, 'extra').array_get(rt.new_string('fetchpriority'))
	} else {
		rt.new_null()
	}
	if rt.is_true(rt.identical(rt.new_null(), var_original_fetchpriority))
		|| !(this.is_valid_fetchpriority(var_original_fetchpriority.clone())) {
		var_original_fetchpriority = rt.new_string('auto')
	}
	mut var_actual_fetchpriority := rt.new_string(this.get_highest_fetchpriority_with_dependents(var_handle_mutated.str(),
		rt.new_null(), rt.new_null()))
	if rt.is_true(rt.identical(rt.new_null(), var_actual_fetchpriority)) {
		var_actual_fetchpriority = var_original_fetchpriority.clone()
	}
	if var_actual_fetchpriority.clone().is_string()
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('auto'), var_actual_fetchpriority)))) {
		var_attr.array_set('fetchpriority', var_actual_fetchpriority.clone())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_original_fetchpriority,
		var_actual_fetchpriority))))
	{
		var_attr.array_set('data-wp-fetchpriority', var_original_fetchpriority.clone())
	}
	mut var_tag := rt.new_string(var_translations.str() + var_before_script.str())
	var_tag = rt.concat(var_tag, rt.call_function('wp_get_script_tag', [
		var_attr.clone()]))
	var_tag = rt.concat(var_tag, var_after_script)
	var_tag = rt.call_function('apply_filters', [rt.new_string('script_loader_tag'),
		var_tag.clone(), var_handle_mutated.clone(), var_src.clone()])
	if this.do_concat {
		this.print_html = rt.concat(this.print_html, var_tag)
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
	if rt.is_true(rt.new_bool('after' != position_mutated)) {
		position_mutated = 'before'
	}
	mut var_script := rt.cast_array(this.get_data(var_handle_mutated.clone(),
		rt.new_string(position_mutated)))
	var_script.array_push(var_data_mutated.clone())
	return this.add_data(var_handle_mutated.clone(), rt.new_string(position_mutated),
		var_script.clone())
}

fn (mut this Class_WP_Scripts) print_inline_script(var_handle rt.PhpVal, position string, display bool) bool {
	mut var_handle_mutated := var_handle
	mut position_mutated := position
	rt.call_function('_deprecated_function', [rt.new_string(@METHOD),
		rt.new_string('6.3.0'),
		rt.new_string('WP_Scripts::get_inline_script_data() or WP_Scripts::get_inline_script_tag()')])
	mut var_output := rt.new_string(this.get_inline_script_data(var_handle_mutated.clone(),
		position_mutated))
	if !rt.is_true(var_output) {
		return false
	}
	if var_display {
		print(this.get_inline_script_tag(var_handle_mutated.clone(), position_mutated))
	}
	return var_output.to_bool()
}

fn (mut this Class_WP_Scripts) get_inline_script_data(var_handle rt.PhpVal, position string) string {
	mut var_handle_mutated := var_handle
	mut position_mutated := position
	mut var_data := this.get_data(var_handle_mutated.clone(), rt.new_string(position_mutated))
	if !rt.is_true(var_data) || !(var_data.clone().is_array()) {
		return ''
	}
	var_data.array_push(rt.call_function('sprintf', [rt.new_string('//# sourceURL=%s'),
		rt.call_function('rawurlencode', [
			rt.new_string('${var_handle.to_string()}-js-${var_position.to_string()}'),
		])]))
	return rt.call_function('implode', [rt.new_string('\n'), var_data.clone()]).to_string().trim_space()
}

fn (mut this Class_WP_Scripts) get_inline_script_tag(var_handle rt.PhpVal, position string) string {
	mut var_handle_mutated := var_handle
	mut position_mutated := position
	mut var_js := rt.new_string(this.get_inline_script_data(var_handle_mutated.clone(),
		position_mutated))
	if !rt.is_true(var_js) {
		return ''
	}
	mut var_id := rt.new_string('${var_handle.to_string()}-js-${var_position.to_string()}')
	return (rt.call_function('wp_get_inline_script_tag', [var_js.clone(),
		rt.call_function('compact', [rt.new_string('id')])])).str()
}

fn (mut this Class_WP_Scripts) localize(var_handle rt.PhpVal, var_object_name rt.PhpVal, var_l10n rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_l10n_mutated := var_l10n
	if rt.is_true(rt.identical(rt.new_string('jquery'), var_handle_mutated)) {
		var_handle_mutated = rt.new_string('jquery-core')
	}
	if var_l10n_mutated.clone().is_array()
		&& var_l10n_mutated.array_isset(rt.new_string('l10n_print_after')) {
		mut var_after := var_l10n_mutated.array_get(rt.new_string('l10n_print_after'))
		var_l10n_mutated.array_unset(rt.new_string('l10n_print_after'))
	}
	if !(var_l10n_mutated.clone().is_array()) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
			rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('The %1$s parameter must be an array. To pass arbitrary data to scripts, use the %2$s function instead.'),
				]),
				rt.new_string('<code>$l10n</code>'),
				rt.new_string('<code>wp_add_inline_script()</code>'),
			]),
			rt.new_string('5.7.0')])
		if rt.is_true(rt.identical(rt.new_bool(false), var_l10n_mutated)) {
			var_l10n_mutated = rt.create_array([
				rt.ArrayItem{ key: none, val: var_l10n_mutated },
			])
		}
	}
	if rt.is_true(rt.new_bool(var_l10n_mutated.clone().is_string())) {
		var_l10n_mutated = rt.call_function('html_entity_decode', [
			var_l10n_mutated.clone(), rt.get_constant('ENT_QUOTES'),
			rt.new_string('UTF-8')])
	} else if rt.is_true(rt.new_bool(var_l10n_mutated.clone().is_array())) {
		mut iter_2 := var_l10n_mutated.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_value := item_2.val
			mut var_key := item_2.key
			if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_scalar', [
				var_value.clone(),
			])))))
			{
				continue
			}
			var_l10n_mutated.array_set(var_key, rt.call_function('html_entity_decode', [
				rt.new_string(var_value.str()),
				rt.get_constant('ENT_QUOTES'),
				rt.new_string('UTF-8'),
			]))
		}
	}
	mut var_script := rt.new_string('var ${var_object_name.to_string()} = ' +
		(rt.call_function('wp_json_encode', [var_l10n_mutated.clone(), rt.bitwise_or(rt.get_constant('JSON_HEX_TAG'), rt.get_constant('JSON_UNESCAPED_SLASHES'))])).str() +
		';')
	if !(!rt.is_true(var_after)) {
		var_script = rt.concat(var_script, rt.new_string('\n${var_after.to_string()};'))
	}
	mut var_data := this.get_data(var_handle_mutated.clone(), rt.new_string('data'))
	if !(!rt.is_true(var_data)) {
		var_script = rt.new_string('${var_data.to_string()}\n${var_script.to_string()}')
	}
	return rt.new_bool(this.add_data(var_handle_mutated.clone(), rt.new_string('data'),
		var_script.clone()))
}

fn (mut this Class_WP_Scripts) set_group(var_handle rt.PhpVal, var_recursion rt.PhpVal, group bool) rt.PhpVal {
	mut var_handle_mutated := var_handle
	if !(rt.get_property(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_get(var_handle_mutated), 'args')).is_null()
		&& rt.is_true(rt.identical(rt.new_int(1), rt.get_property(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_get(var_handle_mutated), 'args'))) {
		mut var_calculated_group := rt.new_int(1)
	} else {
		var_calculated_group = rt.new_int((this.get_data(var_handle_mutated.clone(),
			rt.new_string('group'))).to_i64())
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), rt.new_bool(group)))))
		&& rt.is_true(rt.greater(var_calculated_group, rt.new_bool(group))) {
		var_calculated_group = rt.new_bool(group)
	}
	return this.Class_WP_Dependencies.set_group(var_handle_mutated.clone(), var_recursion.clone(),
		var_calculated_group.clone())
}

fn (mut this Class_WP_Scripts) set_translations(var_handle rt.PhpVal, domain string, path string) bool {
	mut var_handle_mutated := var_handle
	mut domain_mutated := domain
	mut path_mutated := path
	if !(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_isset(var_handle_mutated)) {
		return false
	}
	mut var_obj := rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this),
		'registered').array_get(var_handle_mutated)
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
		rt.new_string('wp-i18n'),
		rt.get_property(var_obj, 'deps'),
		rt.new_bool(true),
	])))))
	{
		rt.get_property(var_obj, 'deps').array_push('wp-i18n')
	}
	return (rt.call_method(var_obj, 'set_translations', [rt.new_string(domain_mutated).clone(),
		rt.new_string(path_mutated).clone()])).to_bool()
}

fn (mut this Class_WP_Scripts) print_translations(var_handle rt.PhpVal, display bool) bool {
	mut var_handle_mutated := var_handle
	if !(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_isset(var_handle_mutated))
		|| !rt.is_true(rt.get_property(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_get(var_handle_mutated), 'textdomain')) {
		return false
	}
	mut var_domain := rt.get_property(rt.get_property(rt.new_object('WP_Scripts', [
		'WP_Dependencies',
	], &this), 'registered').array_get(var_handle_mutated), 'textdomain')
	mut var_path := rt.new_string('')
	if !(rt.get_property(rt.get_property(rt.new_object('WP_Scripts', [
		'WP_Dependencies',
	], &this), 'registered').array_get(var_handle_mutated), 'translations_path')).is_null() {
		var_path = rt.get_property(rt.get_property(rt.new_object('WP_Scripts', [
			'WP_Dependencies',
		], &this), 'registered').array_get(var_handle_mutated), 'translations_path')
	}
	mut var_json_translations := rt.call_function('load_script_textdomain', [
		var_handle_mutated.clone(), var_domain.clone(), var_path.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_json_translations)))) {
		return false
	}
	mut var_output :=
		rt.new_string("( function( domain, translations ) {\n\tvar localeData = translations.locale_data[ domain ] || translations.locale_data.messages;\n\tlocaleData[\"\"].domain = domain;\n\twp.i18n.setLocaleData( localeData, domain );\n} )( \"${var_domain.to_string()}\", ${var_json_translations.to_string()} );")
	if var_display {
		mut var_source_url := rt.call_function('rawurlencode', [
			rt.new_string('${var_handle.to_string()}-js-translations'),
		])
		var_output = rt.concat(var_output,
			rt.new_string('\n//# sourceURL=${var_source_url.to_string()}'))
		rt.call_function('wp_print_inline_script_tag', [var_output.clone(),
			rt.create_array([
				rt.ArrayItem{ key: 'id', val: '${var_handle.to_string()}-js-translations' },
			])])
	}
	return var_output.to_bool()
}

fn (mut this Class_WP_Scripts) all_deps(var_handles rt.PhpVal, recursion bool, group bool) rt.PhpVal {
	mut var_result := this.Class_WP_Dependencies.all_deps(var_handles.clone(),
		rt.new_bool(recursion), rt.new_bool(group))
	if !var_recursion {
		this.dispatch_set_prop('to_do', rt.call_function('apply_filters', [
			rt.new_string('print_scripts_array'),
			rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'to_do'),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Scripts) do_head_items() rt.PhpVal {
	this.do_items(rt.new_bool(false), rt.new_int(0))
	return rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'done')
}

fn (mut this Class_WP_Scripts) do_footer_items() rt.PhpVal {
	this.do_items(rt.new_bool(false), rt.new_int(1))
	return rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'done')
}

fn (mut this Class_WP_Scripts) in_default_dir(var_src rt.PhpVal) bool {
	mut var_src_mutated := var_src
	if rt.is_true(rt.new_bool(!(rt.is_true(this.default_dirs)))) {
		return true
	}
	if rt.is_true(rt.call_function('str_starts_with', [var_src_mutated.clone(),
		rt.new_string('/' + (rt.get_constant('WPINC')).str() + '/js/l10n')]))
	{
		return false
	}
	mut iter_3 := rt.cast_array(this.default_dirs).iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_test := item_3.val
		if rt.is_true(rt.call_function('str_starts_with', [var_src_mutated.clone(),
			var_test.clone()]))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Scripts) add_data(var_handle rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_value_mutated := var_value
	if !(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_isset(var_handle_mutated)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('conditional'), var_key)) {
		rt.set_property(rt.get_property(rt.new_object('WP_Scripts', [
			'WP_Dependencies',
		], &this), 'registered').array_get(var_handle_mutated), 'deps', rt.new_array())
	}
	if rt.is_true(rt.identical(rt.new_string('strategy'), var_key)) {
		if !(!rt.is_true(var_value_mutated))
			&& !(this.is_delayed_strategy(var_value_mutated.clone())) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Invalid strategy `%1$s` defined for `%2$s` during script registration.'),
					]),
					if var_value_mutated.clone().is_string() { var_value_mutated } else { rt.call_function('gettype', [
							var_value_mutated.clone(),
						]) },
					var_handle_mutated.clone(),
				]),
				rt.new_string('6.3.0')])
			return false
		} else if
			rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_get(var_handle_mutated), 'src')))))
			&& this.is_delayed_strategy(var_value_mutated.clone()) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Cannot supply a strategy `%1$s` for script `%2$s` because it is an alias (it lacks a `src` value).'),
					]),
					if var_value_mutated.clone().is_string() { var_value_mutated } else { rt.call_function('gettype', [
							var_value_mutated.clone(),
						]) },
					var_handle_mutated.clone(),
				]),
				rt.new_string('6.3.0')])
			return false
		}
	} else if rt.is_true(rt.identical(rt.new_string('fetchpriority'), var_key)) {
		if !rt.is_true(var_value_mutated) {
			var_value_mutated = rt.new_string('auto')
		}
		if !(this.is_valid_fetchpriority(var_value_mutated.clone())) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Invalid fetchpriority `%1$s` defined for `%2$s` during script registration.'),
					]),
					if var_value_mutated.clone().is_string() { var_value_mutated } else { rt.call_function('gettype', [
							var_value_mutated.clone(),
						]) },
					var_handle_mutated.clone(),
				]),
				rt.new_string('6.9.0')])
			return false
		} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.get_property(rt.get_property(rt.new_object('WP_Scripts', [
			'WP_Dependencies',
		], &this), 'registered').array_get(var_handle_mutated), 'src')))))
		{
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('Cannot supply a fetchpriority `%1$s` for script `%2$s` because it is an alias (it lacks a `src` value).'),
					]),
					if var_value_mutated.clone().is_string() { var_value_mutated } else { rt.call_function('gettype', [
							var_value_mutated.clone(),
						]) },
					var_handle_mutated.clone(),
				]),
				rt.new_string('6.9.0')])
			return false
		}
	} else if rt.is_true(rt.identical(rt.new_string('module_dependencies'), var_key)) {
		if !(var_value_mutated.clone().is_array()) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The value for "%1$s" must be an array for the "%2$s" script.'),
					]),
					rt.new_string('module_dependencies'),
					var_handle_mutated.clone(),
				]),
				rt.new_string('7.0.0')])
			return false
		}
		mut var_sanitized_value := rt.new_array()
		mut var_has_invalid_ids := rt.new_bool(false)
		mut iter_4 := var_value_mutated.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_module := item_4.val
			if var_module.clone().is_string()
				|| (var_module.clone().is_array() && var_module.array_isset(rt.new_string('id'))
				&& var_module.array_get(rt.new_string('id')).is_string()) {
				var_sanitized_value << var_module.clone()
			} else {
				var_has_invalid_ids = rt.new_bool(true)
			}
		}
		if rt.is_true(var_has_invalid_ids) {
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('The script handle "%1$s" has one or more of its script module dependencies ("%2$s") which are invalid.'),
					]),
					var_handle_mutated.clone(),
					rt.new_string('module_dependencies'),
				]),
				rt.new_string('7.0.0')])
		}
		var_value_mutated = var_sanitized_value.clone()
	}
	return (this.Class_WP_Dependencies.add_data(var_handle_mutated.clone(), var_key.clone(),
		var_value_mutated.clone())).to_bool()
}

fn (mut this Class_WP_Scripts) get_dependents(var_handle rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	if this.dependents_map.array_isset(var_handle_mutated) {
		return this.dependents_map.array_get(var_handle_mutated)
	}
	mut var_dependents := rt.new_array()
	mut iter_5 := rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this),
		'registered').iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_args := item_5.val
		mut var_registered_handle := item_5.key
		if rt.is_true(rt.call_function('in_array', [var_handle_mutated.clone(),
			rt.get_property(var_args, 'deps'), rt.new_bool(true)]))
		{
			var_dependents.array_push(var_registered_handle.clone())
		}
	}
	this.dependents_map.array_set(var_handle_mutated, var_dependents.clone())
	return var_dependents.clone()
}

fn (mut this Class_WP_Scripts) is_delayed_strategy(var_strategy rt.PhpVal) bool {
	mut var_strategy_mutated := var_strategy
	return (rt.call_function('in_array', [var_strategy_mutated.clone(), this.delayed_strategies,
		rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WP_Scripts) is_valid_fetchpriority(var_priority rt.PhpVal) bool {
	return (rt.call_function('in_array', [var_priority.clone(),
		rt.create_array([rt.ArrayItem{ key: none, val: 'auto' },
			rt.ArrayItem{ key: none, val: 'low' }, rt.ArrayItem{ key: none, val: 'high' }]),
		rt.new_bool(true)])).to_bool()
}

fn (mut this Class_WP_Scripts) get_eligible_loading_strategy(var_handle rt.PhpVal) string {
	mut var_handle_mutated := var_handle
	mut var_intended_strategy := rt.new_string((this.get_data(var_handle_mutated.clone(),
		rt.new_string('strategy'))).str())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_intended_strategy)))) {
		return ''
	}
	mut var_initial_strategy := if rt.is_true(rt.identical(rt.new_string('defer'), var_intended_strategy)) { rt.create_array([
			rt.ArrayItem{ key: none, val: 'defer' },
		]) } else { rt.new_null() }
	mut var_eligible_strategies := this.filter_eligible_strategies(var_handle_mutated.clone(),
		var_initial_strategy.clone(), rt.new_null(), rt.new_null())
	if !rt.is_true(var_eligible_strategies) {
		return ''
	}
	return if rt.is_true(rt.call_function('in_array', [rt.new_string('async'),
		var_eligible_strategies.clone(), rt.new_bool(true)]))
	{ 'async' } else { 'defer' }
}

fn (mut this Class_WP_Scripts) filter_eligible_strategies(var_handle rt.PhpVal, var_eligible_strategies rt.PhpVal, var_checked rt.PhpVal, mut var_stored_results Class_array) rt.PhpVal {
	mut var_handle_mutated := var_handle
	mut var_eligible_strategies_mutated := var_eligible_strategies
	mut var_checked_mutated := var_checked
	mut var_stored_results_mutated := var_stored_results
	if var_stored_results_mutated.array_isset(var_handle_mutated) {
		return var_stored_results_mutated.array_get(var_handle_mutated)
	}
	if rt.is_true(rt.identical(rt.new_null(), var_eligible_strategies_mutated)) {
		var_eligible_strategies_mutated = this.delayed_strategies
	}
	if var_checked_mutated.array_isset(var_handle_mutated) {
		return var_eligible_strategies_mutated.clone()
	}
	var_checked_mutated.array_set(var_handle_mutated, true)
	if !(rt.get_property(rt.new_object('WP_Scripts', ['WP_Dependencies'], &this), 'registered').array_isset(var_handle_mutated)) {
		return var_eligible_strategies_mutated.clone()
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(this.query(var_handle_mutated.clone(),
		rt.new_string('enqueued'))))))
	{
		return var_eligible_strategies_mutated.clone()
	}
	mut var_is_alias := rt.new_bool(!(rt.is_true(rt.get_property(rt.get_property(rt.new_object('WP_Scripts', [
		'WP_Dependencies',
	], &this), 'registered').array_get(var_handle_mutated), 'src'))))
	mut var_intended_strategy := this.get_data(var_handle_mutated.clone(),
		rt.new_string('strategy'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_is_alias)))) && !rt.is_true(var_intended_strategy) {
		return rt.new_array()
	}
	if this.has_inline_script(var_handle_mutated.clone(), rt.new_string('after')) {
		return rt.new_array()
	}
	if rt.is_true(rt.identical(rt.new_string('defer'), var_intended_strategy)) {
		var_eligible_strategies_mutated = rt.create_array([
			rt.ArrayItem{ key: none, val: 'defer' },
		])
	}
	mut var_dependents := this.get_dependents(var_handle_mutated.clone())
	mut iter_6 := var_dependents.iterator()
	for {
		item_6 := iter_6.next() or { break }
		mut var_dependent := item_6.val
		if !rt.is_true(var_eligible_strategies_mutated) {
			return rt.new_array()
		}
		var_eligible_strategies_mutated = this.filter_eligible_strategies(var_dependent.clone(),
			var_eligible_strategies_mutated.clone(), var_checked_mutated.clone(), mut
			var_stored_results_mutated)
	}
	var_stored_results_mutated.array_set(var_handle_mutated,
		var_eligible_strategies_mutated.clone())
	return var_eligible_strategies_mutated.clone()
}

fn (mut this Class_WP_Scripts) get_highest_fetchpriority_with_dependents(handle string, mut var_checked Class_array, mut var_stored_results Class_array) string {
	mut var_priorities := rt.new_null()
	mut handle_mutated := handle
	mut var_checked_mutated := var_checked
	mut var_stored_results_mutated := var_stored_results
	if var_stored_results_mutated.array_isset(rt.new_string(handle_mutated)) {
		return (var_stored_results_mutated.array_get(rt.new_string(handle_mutated))).str()
	}
	if var_checked_mutated.array_isset(rt.new_string(handle_mutated)) {
		return (rt.new_null()).str()
	}
	var_checked_mutated.array_set(handle_mutated, true)
	if rt.is_true(rt.new_bool(!(rt.is_true(this.query(rt.new_string(handle_mutated),
		rt.new_string('enqueued'))))))
	{
		return (rt.new_null()).str()
	}
	mut var_fetchpriority := this.get_data(rt.new_string(handle_mutated),
		rt.new_string('fetchpriority'))
	if !(this.is_valid_fetchpriority(var_fetchpriority.clone())) {
		var_fetchpriority = rt.new_string('auto')
	}
	mut var_high_priority_index := rt.new_int(var_priorities.clone().array_count() - 1)
	mut var_highest_priority_index := rt.new_int((rt.call_function('array_search', [
		var_fetchpriority.clone(),
		var_priorities.clone(),
		rt.new_bool(true),
	])).to_i64())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_highest_priority_index,
		var_high_priority_index))))
	{
		mut iter_7 := this.get_dependents(rt.new_string(handle_mutated)).iterator()
		for {
			item_7 := iter_7.next() or { break }
			mut var_dependent_handle := item_7.val
			mut var_dependent_priority := rt.new_string(this.get_highest_fetchpriority_with_dependents(var_dependent_handle.str(), mut
				var_checked_mutated, mut var_stored_results_mutated))
			if rt.is_true(rt.new_bool(var_dependent_priority.clone().is_string())) {
				var_highest_priority_index = rt.call_function('max', [
					var_highest_priority_index.clone(),
					rt.new_int((rt.call_function('array_search', [
						var_dependent_priority.clone(),
						var_priorities.clone(),
						rt.new_bool(true),
					])).to_i64())])
				if rt.is_true(rt.identical(var_highest_priority_index, var_high_priority_index)) {
					break
				}
			}
		}
	}
	var_stored_results_mutated.array_set(handle_mutated,
		var_priorities.array_get(var_highest_priority_index))
	return (var_priorities.array_get(var_highest_priority_index)).str()
}

fn (mut this Class_WP_Scripts) has_inline_script(var_handle rt.PhpVal, var_position rt.PhpVal) bool {
	mut var_handle_mutated := var_handle
	mut var_position_mutated := var_position
	if rt.is_true(var_position_mutated)
		&& rt.is_true(rt.call_function('in_array', [var_position_mutated.clone(), rt.create_array([rt.ArrayItem{
		key: none
		val: 'before'
	}, rt.ArrayItem{ key: none, val: 'after' }]), rt.new_bool(true)])) {
		return (this.get_data(var_handle_mutated.clone(), var_position_mutated.clone())).to_bool()
	}
	return rt.is_true(this.get_data(var_handle_mutated.clone(), rt.new_string('before')))
		|| rt.is_true(this.get_data(var_handle_mutated.clone(), rt.new_string('after')))
}

fn (mut this Class_WP_Scripts) reset() {
	this.do_concat = false
	this.print_code = ''
	this.concat = ''
	this.concat_version = ''
	this.print_html = ''
	this.ext_version = ''
	this.ext_handles = ''
}

fn (mut this Class_WP_Scripts) get_dependency_warning_message(var_handle rt.PhpVal, var_missing_dependency_handles rt.PhpVal) rt.PhpVal {
	mut var_handle_mutated := var_handle
	return rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('The script with the handle "%1$s" was enqueued with dependencies that are not registered: %2$s.'),
		]),
		var_handle_mutated.clone(),
		rt.call_function('implode', [
			rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}),
			var_missing_dependency_handles.clone(),
		]),
	])
}

struct Class_WP_Dependencies {
	rt.PhpObjectBase
}

fn create_wp_scripts() &Class_WP_Scripts {
	mut obj := &Class_WP_Scripts{
		PhpObjectBase:      rt.PhpObjectBase{}
		base_url:           rt.new_null()
		content_url:        rt.new_null()
		default_version:    rt.new_null()
		in_footer:          rt.new_array()
		concat:             ''
		concat_version:     ''
		do_concat:          false
		print_html:         ''
		print_code:         ''
		ext_handles:        ''
		ext_version:        ''
		default_dirs:       rt.new_null()
		dependents_map:     rt.new_array()
		delayed_strategies: rt.new_array()
	}
	obj.construct()
	return obj
}

fn create_wp_dependencies(_args ...rt.PhpVal) &Class_WP_Dependencies {
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
			return rt.new_bool(this.add_inline_script(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
		}
		'print_inline_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.print_inline_script(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2))
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
			mut dispatch_arg_3 := rt.cast_object_ptr[Class_array](if args.len > 3 {
				args[3]
			} else {
				rt.new_null()
			})
			return this.filter_eligible_strategies(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, mut
				dispatch_arg_3)
		}
		'get_highest_fetchpriority_with_dependents' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			mut dispatch_arg_2 := rt.cast_object_ptr[Class_array](if args.len > 2 {
				args[2]
			} else {
				rt.new_null()
			})
			return rt.new_string(this.get_highest_fetchpriority_with_dependents(dispatch_arg_0, mut
				dispatch_arg_1, mut dispatch_arg_2))
		}
		'has_inline_script' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.has_inline_script(dispatch_arg_0, dispatch_arg_1))
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
		else {
			return none
		}
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
		'base_url' {
			this.base_url = val
			return true
		}
		'content_url' {
			this.content_url = val
			return true
		}
		'default_version' {
			this.default_version = val
			return true
		}
		'in_footer' {
			this.in_footer = val
			return true
		}
		'concat' {
			this.concat = val.str()
			return true
		}
		'concat_version' {
			this.concat_version = val.str()
			return true
		}
		'do_concat' {
			this.do_concat = val.to_bool()
			return true
		}
		'print_html' {
			this.print_html = val.str()
			return true
		}
		'print_code' {
			this.print_code = val.str()
			return true
		}
		'ext_handles' {
			this.ext_handles = val.str()
			return true
		}
		'ext_version' {
			this.ext_version = val.str()
			return true
		}
		'default_dirs' {
			this.default_dirs = val
			return true
		}
		'dependents_map' {
			this.dependents_map = val
			return true
		}
		'delayed_strategies' {
			this.delayed_strategies = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

struct Class_WP_Styles {
	rt.PhpObjectBase
pub mut:
	base_url        rt.PhpVal = rt.new_null()
	content_url     rt.PhpVal = rt.new_null()
	default_version rt.PhpVal = rt.new_null()
	text_direction  rt.PhpVal = rt.new_string('ltr')
	concat          string
	concat_version  string
	do_concat       bool
	print_html      string
	print_code      rt.PhpVal = rt.new_string('')
	default_dirs    rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Styles) construct() {
	rt.call_function('do_action_ref_array', [rt.new_string('wp_default_styles'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Styles', [
				'WP_Dependencies',
			], &this) },
		])])
}

fn (mut this Class_WP_Styles) do_item(var_handle rt.PhpVal, group bool) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.Class_WP_Dependencies.do_item(var_handle.clone()))))) {
		return false
	}
	mut var_obj := rt.get_property(rt.new_object('WP_Styles', ['WP_Dependencies'], &this),
		'registered').array_get(var_handle)
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
	if rt.get_property(rt.new_object('WP_Styles', ['WP_Dependencies'], &this), 'args').array_isset(var_handle) {
		var_ver = if rt.is_true(var_ver) { var_ver.str() + '&amp;' + (rt.get_property(rt.new_object('WP_Styles', ['WP_Dependencies'], &this), 'args').array_get(var_handle)).str() } else { rt.get_property(rt.new_object('WP_Styles', [
				'WP_Dependencies',
			], &this), 'args').array_get(var_handle) }
	}
	mut var_src := rt.get_property(var_obj, 'src')
	mut var_inline_style := this.print_inline_style(var_handle.clone(), false)
	if rt.is_true(var_inline_style) {
		mut var_processor := create_wp_html_tag_processor(rt.new_string('<style></style>'))
		var_processor.next_tag()
		var_processor.set_attribute(rt.new_string('id'),
			rt.new_string('${var_handle.to_string()}-inline-css'))
		var_processor.set_modifiable_text(rt.new_string('\n${var_inline_style.to_string()}\n'))
		mut var_inline_style_tag := rt.new_string((rt.concat(var_processor.get_updated_html(),
			rt.new_string('\n'))).str())
	} else {
		var_inline_style_tag = rt.new_string('')
	}
	if this.do_concat {
		if var_src.clone().is_string() && this.in_default_dir(var_src.clone())
			&& !(rt.get_property(var_obj, 'extra').array_isset(rt.new_string('alt'))) {
			this.concat = rt.concat(this.concat, rt.new_string('${var_handle.to_string()},'))
			this.concat_version = rt.concat(this.concat_version,
				rt.new_string('${var_handle.to_string()}${var_ver.to_string()}'))
			this.print_code = rt.concat(this.print_code, var_inline_style)
			return true
		}
	}
	mut var_media := if !(rt.get_property(var_obj, 'args')).is_null() {
		rt.get_property(var_obj, 'args')
	} else {
		rt.new_string('all')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_src)))) {
		if rt.is_true(var_inline_style_tag) {
			if this.do_concat {
				this.print_html = rt.concat(this.print_html, var_inline_style_tag)
			} else {
				rt.echo_val(var_inline_style_tag)
			}
		}
		return true
	}
	mut var_href := this._css_href(var_src.clone(), rt.get_property(var_obj, 'ver'),
		var_handle.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(var_href)))) {
		return true
	}
	mut var_rel := rt.new_string((if
		rt.get_property(var_obj, 'extra').array_isset(rt.new_string('alt'))
		&& rt.is_true(rt.get_property(var_obj, 'extra').array_get(rt.new_string('alt'))) {
		'alternate stylesheet'
	} else {
		'stylesheet'
	}).str())
	mut var_title := if !(rt.get_property(var_obj, 'extra').array_get(rt.new_string('title'))).is_null() {
		rt.get_property(var_obj, 'extra').array_get(rt.new_string('title'))
	} else {
		rt.new_string('')
	}
	mut var_tag := rt.call_function('sprintf', [
		rt.new_string("<link rel='%s' id='%s-css'%s href='%s' media='%s' />\n"),
		var_rel.clone(),
		rt.call_function('esc_attr', [var_handle.clone()]),
		if rt.is_true(var_title) {
			rt.call_function('sprintf', [rt.new_string(" title='%s'"),
				rt.call_function('esc_attr', [var_title.clone()])])
		} else {
			rt.new_string('')
		},
		var_href.clone(),
		rt.call_function('esc_attr', [var_media.clone()]),
	])
	var_tag = rt.call_function('apply_filters', [rt.new_string('style_loader_tag'),
		var_tag.clone(), var_handle.clone(), var_href.clone(),
		var_media.clone()])
	if rt.is_true(rt.identical(rt.new_string('rtl'), this.text_direction))
		&& rt.get_property(var_obj, 'extra').array_isset(rt.new_string('rtl'))
		&& rt.is_true(rt.get_property(var_obj, 'extra').array_get(rt.new_string('rtl'))) {
		if rt.get_property(var_obj, 'extra').array_get(rt.new_string('rtl')).is_bool()
			|| rt.is_true(rt.identical(rt.new_string('replace'), rt.get_property(var_obj, 'extra').array_get(rt.new_string('rtl')))) {
			mut var_suffix := if !(rt.get_property(var_obj, 'extra').array_get(rt.new_string('suffix'))).is_null() {
				rt.get_property(var_obj, 'extra').array_get(rt.new_string('suffix'))
			} else {
				rt.new_string('')
			}
			mut var_rtl_href := rt.call_function('str_replace', [
				rt.new_string('${var_suffix.to_string()}.css'),
				rt.new_string('-rtl${var_suffix.to_string()}.css'),
				this._css_href(var_src.clone(), var_ver.clone(),
					rt.new_string('${var_handle.to_string()}-rtl')),
			])
		} else {
			var_rtl_href = this._css_href(rt.get_property(var_obj, 'extra').array_get(rt.new_string('rtl')),
				var_ver.clone(), rt.new_string('${var_handle.to_string()}-rtl'))
		}
		mut var_rtl_tag := rt.call_function('sprintf', [
			rt.new_string("<link rel='%s' id='%s-rtl-css'%s href='%s' media='%s' />\n"),
			var_rel.clone(),
			rt.call_function('esc_attr', [var_handle.clone()]),
			if rt.is_true(var_title) {
				rt.call_function('sprintf', [rt.new_string(" title='%s'"),
					rt.call_function('esc_attr', [
						var_title.clone(),
					])])
			} else {
				rt.new_string('')
			},
			var_rtl_href.clone(),
			rt.call_function('esc_attr', [var_media.clone()]),
		])
		var_rtl_tag = rt.call_function('apply_filters', [
			rt.new_string('style_loader_tag'),
			var_rtl_tag.clone(),
			var_handle.clone(),
			var_rtl_href.clone(),
			var_media.clone(),
		])
		if rt.is_true(rt.identical(rt.new_string('replace'),
			rt.get_property(var_obj, 'extra').array_get(rt.new_string('rtl'))))
		{
			var_tag = var_rtl_tag.clone()
		} else {
			var_tag = rt.concat(var_tag, var_rtl_tag)
		}
	}
	if this.do_concat {
		this.print_html = rt.concat(this.print_html, var_tag)
		if rt.is_true(var_inline_style_tag) {
			this.print_html = rt.concat(this.print_html, var_inline_style_tag)
		}
	} else {
		rt.echo_val(var_tag)
		this.print_inline_style(var_handle.clone(), false)
	}
	return true
}

fn (mut this Class_WP_Styles) add_inline_style(var_handle rt.PhpVal, var_code rt.PhpVal) bool {
	if rt.is_true(rt.new_bool(!(rt.is_true(var_code)))) {
		return false
	}
	mut var_after := this.get_data(var_handle.clone(), rt.new_string('after'))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_after)))) {
		var_after = rt.new_array()
	}
	var_after.array_push(var_code.clone())
	return this.add_data(var_handle.clone(), rt.new_string('after'), var_after.clone())
}

fn (mut this Class_WP_Styles) print_inline_style(var_handle rt.PhpVal, display bool) rt.PhpVal {
	mut var_output := this.get_data(var_handle.clone(), rt.new_string('after'))
	if !rt.is_true(var_output) || !(var_output.clone().is_array()) {
		return rt.new_bool(false)
	}
	if !(this.do_concat) {
		mut var_inlined_src := this.get_data(var_handle.clone(), rt.new_string('inlined_src'))
		if var_output.clone().array_count() == 1 && var_inlined_src.clone().is_string()
			&& var_inlined_src.clone().to_string().len > 0 {
			mut var_source_url := rt.call_function('esc_url_raw', [
				var_inlined_src.clone()])
		} else {
			var_source_url = rt.call_function('rawurlencode', [
				rt.new_string('${var_handle.to_string()}-inline-css'),
			])
		}
		var_output.array_push(rt.call_function('sprintf', [
			rt.new_string('/*# sourceURL=%s */'),
			var_source_url.clone(),
		]))
	}
	var_output = rt.call_function('implode', [rt.new_string('\n'),
		var_output.clone()])
	if !var_display {
		return var_output.clone()
	}
	mut var_processor := create_wp_html_tag_processor(rt.new_string('<style></style>'))
	var_processor.next_tag()
	var_processor.set_attribute(rt.new_string('id'),
		rt.new_string('${var_handle.to_string()}-inline-css'))
	var_processor.set_modifiable_text(rt.new_string('\n${var_output.to_string()}\n'))
	print(rt.concat(var_processor.get_updated_html(), rt.new_string('\n')))
	return rt.new_bool(true)
}

fn (mut this Class_WP_Styles) add_data(var_handle rt.PhpVal, var_key rt.PhpVal, var_value rt.PhpVal) bool {
	if !(rt.get_property(rt.new_object('WP_Styles', ['WP_Dependencies'], &this), 'registered').array_isset(var_handle)) {
		return false
	}
	if rt.is_true(rt.identical(rt.new_string('conditional'), var_key)) {
		rt.set_property(rt.get_property(rt.new_object('WP_Styles', ['WP_Dependencies'], &this),
			'registered').array_get(var_handle), 'deps', rt.new_array())
	}
	return (this.Class_WP_Dependencies.add_data(var_handle.clone(), var_key.clone(),
		var_value.clone())).to_bool()
}

fn (mut this Class_WP_Styles) all_deps(var_handles rt.PhpVal, recursion bool, group bool) rt.PhpVal {
	mut var_result := this.Class_WP_Dependencies.all_deps(var_handles.clone(),
		rt.new_bool(recursion), rt.new_bool(group))
	if !var_recursion {
		this.dispatch_set_prop('to_do', rt.call_function('apply_filters', [
			rt.new_string('print_styles_array'),
			rt.get_property(rt.new_object('WP_Styles', ['WP_Dependencies'], &this), 'to_do'),
		]))
	}
	return var_result.clone()
}

fn (mut this Class_WP_Styles) _css_href(var_src rt.PhpVal, var_ver rt.PhpVal, var_handle rt.PhpVal) rt.PhpVal {
	mut var_src_mutated := var_src
	mut var_ver_mutated := var_ver
	if !(var_src_mutated.clone().is_bool())
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('|^(https?:)?//|'), var_src_mutated.clone()])))))
		&& !(rt.is_true(this.content_url)
		&& rt.is_true(rt.call_function('str_starts_with', [var_src_mutated.clone(), this.content_url]))) {
		var_src_mutated = rt.new_string((this.base_url).str() + var_src_mutated.str())
	}
	mut var_ver_to_add := rt.new_string('')
	if !rt.is_true(var_ver_mutated)
		&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_ver_mutated))))
		&& this.default_version.is_string() {
		var_ver_to_add = this.default_version
	} else if rt.is_true(rt.call_function('is_scalar', [var_ver_mutated.clone()])) {
		var_ver_to_add = rt.new_string(var_ver_mutated.str())
	}
	mut var_added_args := rt.new_string((if !(rt.get_property(rt.new_object('WP_Styles', [
		'WP_Dependencies',
	], &this), 'args').array_get(var_handle)).is_null() { rt.get_property(rt.new_object('WP_Styles', [
			'WP_Dependencies',
		], &this), 'args').array_get(var_handle) } else { rt.new_string('') }).str())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_ver_to_add))))
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_added_args)))) {
		mut var_fragment := rt.call_function('strstr', [var_src_mutated.clone(),
			rt.new_string('#')])
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_fragment)))) {
			var_src_mutated = rt.call_function('substr', [var_src_mutated.clone(),
				rt.new_int(0), rt.new_int(-var_fragment.clone().to_string().len)])
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_ver_to_add)))) {
			var_src_mutated = rt.concat(var_src_mutated, rt.new_string(
				if rt.is_true(rt.call_function('str_contains', [var_src_mutated.clone(), rt.new_string('?')])) { '&' } else { '?' } +
				'ver=' + (rt.call_function('rawurlencode', [var_ver_to_add.clone()])).str()))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_added_args)))) {
			var_src_mutated = rt.concat(var_src_mutated, rt.new_string(
				if rt.is_true(rt.call_function('str_contains', [var_src_mutated.clone(), rt.new_string('?')])) { '&' } else { '?' } +
				var_added_args.str()))
		}
		if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_fragment)))) {
			var_src_mutated = rt.concat(var_src_mutated, var_fragment)
		}
	}
	var_src_mutated = rt.call_function('apply_filters', [
		rt.new_string('style_loader_src'),
		var_src_mutated.clone(),
		var_handle.clone(),
	])
	return rt.call_function('esc_url', [var_src_mutated.clone()])
}

fn (mut this Class_WP_Styles) in_default_dir(var_src rt.PhpVal) bool {
	mut var_src_mutated := var_src
	if rt.is_true(rt.new_bool(!(rt.is_true(this.default_dirs)))) {
		return true
	}
	mut iter_1 := rt.cast_array(this.default_dirs).iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_test := item_1.val
		if rt.is_true(rt.call_function('str_starts_with', [var_src_mutated.clone(),
			var_test.clone()]))
		{
			return true
		}
	}
	return false
}

fn (mut this Class_WP_Styles) do_footer_items() rt.PhpVal {
	this.do_items(rt.new_bool(false), rt.new_int(1))
	return rt.get_property(rt.new_object('WP_Styles', ['WP_Dependencies'], &this), 'done')
}

fn (mut this Class_WP_Styles) reset() {
	this.do_concat = false
	this.concat = ''
	this.concat_version = ''
	this.print_html = ''
}

fn (mut this Class_WP_Styles) get_dependency_warning_message(var_handle rt.PhpVal, var_missing_dependency_handles rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.call_function('__', [
			rt.new_string('The style with the handle "%1$s" was enqueued with dependencies that are not registered: %2$s.'),
		]),
		var_handle.clone(),
		rt.call_function('implode', [
			rt.call_function('wp_get_list_item_separator', []rt.PhpVal{}),
			var_missing_dependency_handles.clone(),
		]),
	])
}

struct Class_WP_Dependencies {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

fn create_wp_styles() &Class_WP_Styles {
	mut obj := &Class_WP_Styles{
		PhpObjectBase:   rt.PhpObjectBase{}
		base_url:        rt.new_null()
		content_url:     rt.new_null()
		default_version: rt.new_null()
		text_direction:  rt.new_string('ltr')
		concat:          ''
		concat_version:  ''
		do_concat:       false
		print_html:      ''
		print_code:      rt.new_string('')
		default_dirs:    rt.new_null()
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

fn create_wp_html_tag_processor(_args ...rt.PhpVal) &Class_WP_HTML_Tag_Processor {
	mut obj := &Class_WP_HTML_Tag_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Styles) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'do_item' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return rt.new_bool(this.do_item(dispatch_arg_0, dispatch_arg_1))
		}
		'add_inline_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return rt.new_bool(this.add_inline_style(dispatch_arg_0, dispatch_arg_1))
		}
		'print_inline_style' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			return this.print_inline_style(dispatch_arg_0, dispatch_arg_1)
		}
		'add_data' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return rt.new_bool(this.add_data(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2))
		}
		'all_deps' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_bool()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_bool()
			return this.all_deps(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'_css_href' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this._css_href(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'in_default_dir' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_bool(this.in_default_dir(dispatch_arg_0))
		}
		'do_footer_items' {
			return this.do_footer_items()
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

fn (this &Class_WP_Styles) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'base_url' { return this.base_url }
		'content_url' { return this.content_url }
		'default_version' { return this.default_version }
		'text_direction' { return this.text_direction }
		'concat' { return rt.new_string(this.concat) }
		'concat_version' { return rt.new_string(this.concat_version) }
		'do_concat' { return rt.new_bool(this.do_concat) }
		'print_html' { return rt.new_string(this.print_html) }
		'print_code' { return this.print_code }
		'default_dirs' { return this.default_dirs }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Styles) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
		'text_direction' {
			this.text_direction = val
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
			this.print_code = val
			return true
		}
		'default_dirs' {
			this.default_dirs = val
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

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Tag_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Tag_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

pub fn Class_WP_Interactivity_API_Directives_Processor.tags_that_dont_visit_closer_tag() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: none, val: 'SCRIPT' },
		rt.ArrayItem{ key: none, val: 'IFRAME' }, rt.ArrayItem{ key: none, val: 'NOEMBED' },
		rt.ArrayItem{ key: none, val: 'NOFRAMES' }, rt.ArrayItem{ key: none, val: 'STYLE' },
		rt.ArrayItem{ key: none, val: 'TEXTAREA' }, rt.ArrayItem{ key: none, val: 'TITLE' },
		rt.ArrayItem{ key: none, val: 'XMP' }])
}

struct Class_WP_Interactivity_API_Directives_Processor {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) get_content_between_balanced_template_tags() rt.PhpVal {
	mut var_after_opener_tag := rt.new_null()
	mut var_before_closer_tag := rt.new_null()
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('TEMPLATE'), this.get_tag())))) {
		return rt.new_null()
	}
	mut var_positions := this.get_after_opener_tag_and_before_closer_tag_positions(false)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_positions)))) {
		return rt.new_null()
	}
	mut list_tmp_1 := var_positions
	var_after_opener_tag = list_tmp_1.array_get(0)
	var_before_closer_tag = list_tmp_1.array_get(1)
	return rt.call_function('substr', [
		rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
			'WP_HTML_Tag_Processor',
		], &this), 'html'),
		var_after_opener_tag.clone(),
		rt.sub(var_before_closer_tag, var_after_opener_tag),
	])
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) set_content_between_balanced_tags(new_content string) bool {
	mut var_after_opener_tag := rt.new_null()
	mut var_before_closer_tag := rt.new_null()
	mut var_positions := this.get_after_opener_tag_and_before_closer_tag_positions(true)
	if rt.is_true(rt.new_bool(!(rt.is_true(var_positions)))) {
		return false
	}
	mut list_tmp_2 := var_positions
	var_after_opener_tag = list_tmp_2.array_get(0)
	var_before_closer_tag = list_tmp_2.array_get(1)
	rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'lexical_updates').array_push(create_wp_html_text_replacement(var_after_opener_tag.clone(), rt.sub(var_before_closer_tag,
		var_after_opener_tag), rt.call_function('esc_html', [
		rt.new_string(new_content)])))
	return true
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) append_content_after_template_tag_closer(new_content string) bool {
	if new_content == ''
		|| rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('TEMPLATE'), this.get_tag()))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(this.is_tag_closer())))) {
		return false
	}
	this.get_updated_html()
	mut var_bookmark := rt.new_string('append_content_after_template_tag_closer')
	this.set_bookmark(var_bookmark.clone())
	mut var_after_closing_tag := rt.add(rt.get_property(rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'bookmarks').array_get(var_bookmark), 'start'), rt.get_property(rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'bookmarks').array_get(var_bookmark), 'length'))
	this.release_bookmark(var_bookmark.clone())
	rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'lexical_updates').array_push(create_wp_html_text_replacement(var_after_closing_tag.clone(),
		rt.new_int(0), rt.new_string(new_content)))
	return true
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) get_after_opener_tag_and_before_closer_tag_positions(rewind bool) rt.PhpVal {
	mut var_opener_tag := rt.new_null()
	mut var_closer_tag := rt.new_null()
	this.get_updated_html()
	mut var_bookmarks := this.get_balanced_tag_bookmarks()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_bookmarks)))) {
		return rt.new_null()
	}
	mut list_tmp_3 := var_bookmarks
	var_opener_tag = list_tmp_3.array_get(0)
	var_closer_tag = list_tmp_3.array_get(1)
	mut var_after_opener_tag := rt.add(rt.get_property(rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'bookmarks').array_get(var_opener_tag), 'start'), rt.get_property(rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'bookmarks').array_get(var_opener_tag), 'length'))
	mut var_before_closer_tag := rt.get_property(rt.get_property(rt.new_object('WP_Interactivity_API_Directives_Processor', [
		'WP_HTML_Tag_Processor',
	], &this), 'bookmarks').array_get(var_closer_tag), 'start')
	if var_rewind {
		this.seek(var_opener_tag.clone())
	}
	this.release_bookmark(var_opener_tag.clone())
	this.release_bookmark(var_closer_tag.clone())
	return rt.create_array([rt.ArrayItem{ key: none, val: var_after_opener_tag },
		rt.ArrayItem{ key: none, val: var_before_closer_tag }])
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) get_balanced_tag_bookmarks() rt.PhpVal {
	mut var_i := rt.new_null()
	mut var_opener_tag := rt.new_string('opener_tag_of_balanced_tag_' + (rt.pre_inc(var_i)).str())
	this.set_bookmark(var_opener_tag.clone())
	if !(this.next_balanced_tag_closer_tag()) {
		this.release_bookmark(var_opener_tag.clone())
		return rt.new_null()
	}
	mut var_closer_tag := rt.new_string('closer_tag_of_balanced_tag_' + (rt.pre_inc(var_i)).str())
	this.set_bookmark(var_closer_tag.clone())
	return rt.create_array([rt.ArrayItem{ key: none, val: var_opener_tag },
		rt.ArrayItem{ key: none, val: var_closer_tag }])
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) skip_to_tag_closer() bool {
	mut var_depth := rt.new_int(1)
	mut var_tag_name := this.get_tag()
	for rt.is_true(rt.greater(var_depth, rt.new_int(0))) && rt.is_true(this.next_tag(rt.create_array([rt.ArrayItem, {
		key: 'tag_closers'
		val: 'visit'
	}]))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.is_tag_closer()))))
			&& rt.is_true(this.get_attribute_names_with_prefix(rt.new_string('data-wp-'))) {
			mut var_message := rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Interactivity directives were detected inside an incompatible %1$s tag. These directives will be ignored in the server side render.'),
				]),
				var_tag_name.clone(),
			])
			rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD),
				var_message.clone(), rt.new_string('6.6.0')])
		}
		if rt.is_true(rt.identical(this.get_tag(), var_tag_name)) {
			if rt.is_true(this.has_self_closing_flag()) {
				continue
			}
			var_depth = rt.add(var_depth, if rt.is_true(this.is_tag_closer()) { -1 } else { 1 })
		}
	}
	return (rt.identical(rt.new_int(0), var_depth)).to_bool()
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) next_balanced_tag_closer_tag() bool {
	mut var_depth := rt.new_int(0)
	mut var_tag_name := this.get_tag()
	if !(this.has_and_visits_its_closer_tag()) {
		return false
	}
	for rt.is_true(this.next_tag(rt.create_array([rt.ArrayItem, {
		key: 'tag_name'
		val: var_tag_name
	}, rt.ArrayItem, {
		key: 'tag_closers'
		val: 'visit'
	}]))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(this.is_tag_closer())))) {
			rt.pre_inc(var_depth)
			continue
		}
		if rt.is_true(rt.identical(rt.new_int(0), var_depth)) {
			return true
		}
		rt.pre_dec(var_depth)
	}
	return false
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) has_and_visits_its_closer_tag() bool {
	mut var_tag_name := this.get_tag()
	mut iife_temp_0 := Class_WP_HTML_Processor{}
	mut iife_result_0 := iife_temp_0.is_void(var_tag_name.clone())
	return rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_null(), var_tag_name))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(iife_result_0))))
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_tag_name.clone(), Class_WP_Interactivity_API_Directives_Processor.tags_that_dont_visit_closer_tag(), rt.new_bool(true)])))))
}

struct Class_WP_HTML_Tag_Processor {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Text_Replacement {
	rt.PhpObjectBase
}

struct Class_WP_HTML_Processor {
	rt.PhpObjectBase
}

fn create_wp_interactivity_api_directives_processor(_args ...rt.PhpVal) &Class_WP_Interactivity_API_Directives_Processor {
	mut obj := &Class_WP_Interactivity_API_Directives_Processor{
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

fn create_wp_html_text_replacement(_args ...rt.PhpVal) &Class_WP_HTML_Text_Replacement {
	mut obj := &Class_WP_HTML_Text_Replacement{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_html_processor(_args ...rt.PhpVal) &Class_WP_HTML_Processor {
	mut obj := &Class_WP_HTML_Processor{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_content_between_balanced_template_tags' {
			return this.get_content_between_balanced_template_tags()
		}
		'set_content_between_balanced_tags' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.set_content_between_balanced_tags(dispatch_arg_0))
		}
		'append_content_after_template_tag_closer' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.append_content_after_template_tag_closer(dispatch_arg_0))
		}
		'get_after_opener_tag_and_before_closer_tag_positions' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).to_bool()
			return this.get_after_opener_tag_and_before_closer_tag_positions(dispatch_arg_0)
		}
		'get_balanced_tag_bookmarks' {
			return this.get_balanced_tag_bookmarks()
		}
		'skip_to_tag_closer' {
			return rt.new_bool(this.skip_to_tag_closer())
		}
		'next_balanced_tag_closer_tag' {
			return rt.new_bool(this.next_balanced_tag_closer_tag())
		}
		'has_and_visits_its_closer_tag' {
			return rt.new_bool(this.has_and_visits_its_closer_tag())
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Interactivity_API_Directives_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Interactivity_API_Directives_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_WP_HTML_Text_Replacement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Text_Replacement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Text_Replacement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WP_HTML_Processor) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_HTML_Processor) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_HTML_Processor) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

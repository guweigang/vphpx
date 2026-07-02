import rt

struct Class_Walker_Category {
	rt.PhpObjectBase
pub mut:
	tree_type rt.PhpVal = rt.new_string('category')
	db_fields rt.PhpVal = rt.new_array()
}

fn (mut this Class_Walker_Category) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('list'),
		var_args.array_get(rt.new_string('style'))))))
	{
		return
	}
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'),
		rt.new_int(depth)])
	var_output = rt.concat(var_output,
		rt.new_string("${var_indent.to_string()}<ul class='children'>\n"))
}

fn (mut this Class_Walker_Category) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('list'),
		var_args.array_get(rt.new_string('style'))))))
	{
		return
	}
	mut var_indent := rt.call_function('str_repeat', [rt.new_string('\t'),
		rt.new_int(depth)])
	var_output = rt.concat(var_output, rt.new_string('${var_indent.to_string()}</ul>\n'))
}

fn (mut this Class_Walker_Category) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64) {
	mut var_category := var_data_object
	mut var_cat_name := rt.call_function('apply_filters', [rt.new_string('list_cats'),
		rt.call_function('esc_attr', [rt.get_property(var_category, 'name')]),
		var_category.clone()])
	if rt.is_true(rt.identical(rt.new_string(''), var_cat_name)) {
		return
	}
	mut var_atts := rt.new_array()
	var_atts.array_set('href', rt.call_function('get_term_link', [
		var_category.clone()]))
	if rt.is_true(var_args.array_get(rt.new_string('use_desc_for_title')))
		&& !(!rt.is_true(rt.get_property(var_category, 'description'))) {
		var_atts.array_set('title', rt.call_function('strip_tags', [
			rt.call_function('apply_filters', [rt.new_string('category_description'),
				rt.get_property(var_category, 'description'),
				var_category.clone()]),
		]))
	}
	var_atts = rt.call_function('apply_filters', [
		rt.new_string('category_list_link_attributes'),
		var_atts.clone(),
		var_category.clone(),
		rt.new_int(depth),
		var_args.clone(),
		rt.new_int(current_object_id),
	])
	mut var_attributes := rt.new_string('')
	mut iter_1 := var_atts.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_value := item_1.val
		mut var_attr := item_1.key
		if rt.is_true(rt.call_function('is_scalar', [var_value.clone()]))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string(''), var_value))))
			&& rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_bool(false), var_value)))) {
			var_value = if rt.is_true(rt.identical(rt.new_string('href'), var_attr)) { rt.call_function('esc_url', [
					var_value.clone(),
				]) } else { rt.call_function('esc_attr', [var_value.clone()]) }
			var_attributes = rt.concat(var_attributes, rt.new_string(' ' + var_attr.str() + '="' +
				var_value.str() + '"'))
		}
	}
	mut var_link := rt.call_function('sprintf', [rt.new_string('<a%s>%s</a>'),
		var_attributes.clone(), var_cat_name.clone()])
	if !(!rt.is_true(var_args.array_get(rt.new_string('feed_image'))))
		|| !(!rt.is_true(var_args.array_get(rt.new_string('feed')))) {
		var_link = rt.concat(var_link, rt.new_string(' '))
		if !rt.is_true(var_args.array_get(rt.new_string('feed_image'))) {
			var_link = rt.concat(var_link, rt.new_string('('))
		}
		var_link = rt.concat(var_link, rt.new_string('<a href="' +
			(rt.call_function('esc_url', [rt.call_function('get_term_feed_link', [var_category.clone(), rt.get_property(var_category, 'taxonomy'), var_args.array_get(rt.new_string('feed_type'))])])).str() +
			'"'))
		if !rt.is_true(var_args.array_get(rt.new_string('feed'))) {
			mut var_alt := rt.new_string(' alt="' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Feed for all posts filed under %s')]), var_cat_name.clone()])).str() +
				'"')
		} else {
			var_alt = rt.new_string(' alt="' +
				(var_args.array_get(rt.new_string('feed'))).str() + '"')
			mut var_name := var_args.array_get(rt.new_string('feed'))
			var_link = rt.concat(var_link, if !rt.is_true(var_args.array_get(rt.new_string('title'))) {
				rt.new_string('')
			} else {
				var_args.array_get(rt.new_string('title'))
			})
		}
		var_link = rt.concat(var_link, rt.new_string('>'))
		if !rt.is_true(var_args.array_get(rt.new_string('feed_image'))) {
			var_link = rt.concat(var_link, var_name)
		} else {
			var_link = rt.concat(var_link, rt.new_string("<img src='" +
				(rt.call_function('esc_url', [var_args.array_get(rt.new_string('feed_image'))])).str() +
				"'${var_alt.to_string()}" + ' />'))
		}
		var_link = rt.concat(var_link, rt.new_string('</a>'))
		if !rt.is_true(var_args.array_get(rt.new_string('feed_image'))) {
			var_link = rt.concat(var_link, rt.new_string(')'))
		}
	}
	if !(!rt.is_true(var_args.array_get(rt.new_string('show_count')))) {
		var_link = rt.concat(var_link, rt.new_string(
			' (' + (rt.call_function('number_format_i18n', [rt.get_property(var_category, 'count')])).str() +
			')'))
	}
	if rt.is_true(rt.identical(rt.new_string('list'), var_args.array_get(rt.new_string('style')))) {
		var_output = rt.concat(var_output, rt.new_string('\t<li'))
		mut var_css_classes := rt.create_array([
			rt.ArrayItem{ key: none, val: 'cat-item' },
			rt.ArrayItem{ key: none, val: 'cat-item-' +
				(rt.get_property(var_category, 'term_id')).str() },
		])
		if !(!rt.is_true(var_args.array_get(rt.new_string('current_category')))) {
			mut var__current_terms := rt.call_function('get_terms', [
				rt.create_array([
					rt.ArrayItem{ key: 'taxonomy', val: rt.get_property(var_category, 'taxonomy') },
					rt.ArrayItem{
						key: 'include'
						val: var_args.array_get(rt.new_string('current_category'))
					},
					rt.ArrayItem{ key: 'hide_empty', val: false },
				]),
			])
			mut iter_2 := var__current_terms.iterator()
			for {
				item_2 := iter_2.next() or { break }
				mut var__current_term := item_2.val
				if rt.is_true(rt.identical(rt.get_property(var_category, 'term_id'), rt.get_property(var__current_term,
					'term_id')))
				{
					var_css_classes.array_push('current-cat')
					var_link = rt.call_function('str_replace', [
						rt.new_string('<a'), rt.new_string('<a aria-current="page"'),
						var_link.clone()])
				} else if rt.is_true(rt.identical(rt.get_property(var_category, 'term_id'), rt.get_property(var__current_term,
					'parent')))
				{
					var_css_classes.array_push('current-cat-parent')
				}
				for rt.is_true(rt.get_property(var__current_term, 'parent')) {
					if rt.is_true(rt.identical(rt.get_property(var_category, 'term_id'), rt.get_property(var__current_term,
						'parent')))
					{
						var_css_classes.array_push('current-cat-ancestor')
						break
					}
					var__current_term = rt.call_function('get_term', [
						rt.get_property(var__current_term, 'parent'),
						rt.get_property(var_category, 'taxonomy'),
					])
				}
			}
		}
		var_css_classes = rt.call_function('implode', [rt.new_string(' '),
			rt.call_function('apply_filters', [rt.new_string('category_css_class'),
				var_css_classes.clone(), var_category.clone(),
				rt.new_int(depth), var_args.clone()])])
		var_css_classes = rt.new_string((if rt.is_true(var_css_classes) {
			' class="' + (rt.call_function('esc_attr', [var_css_classes.clone()])).str() + '"'
		} else {
			''
		}).str())
		var_output = rt.concat(var_output, var_css_classes)
		var_output = rt.concat(var_output, rt.new_string('>${var_link.to_string()}\n'))
	} else if var_args.array_isset(rt.new_string('separator')) {
		var_output = rt.concat(var_output, rt.new_string('\t${var_link.to_string()}' +
			(var_args.array_get(rt.new_string('separator'))).str() + '\n'))
	} else {
		var_output = rt.concat(var_output, rt.new_string('\t${var_link.to_string()}<br />\n'))
	}
}

fn (mut this Class_Walker_Category) end_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal) {
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(rt.new_string('list'),
		var_args.array_get(rt.new_string('style'))))))
	{
		return
	}
	var_output = rt.concat(var_output, rt.new_string('</li>\n'))
}

struct Class_Walker {
	rt.PhpObjectBase
}

fn create_walker_category(_args ...rt.PhpVal) &Class_Walker_Category {
	mut obj := &Class_Walker_Category{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type:     rt.new_string('category')
		db_fields:     rt.new_array()
	}
	return obj
}

fn create_walker(_args ...rt.PhpVal) &Class_Walker {
	mut obj := &Class_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Walker_Category) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'start_lvl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.start_lvl(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'end_lvl' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).to_i64()
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			this.end_lvl(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
			return rt.new_null()
		}
		'start_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).to_i64()
			this.start_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
			return rt.new_null()
		}
		'end_el' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			this.end_el(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Walker_Category) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Walker_Category) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree_type' {
			this.tree_type = val
			return true
		}
		'db_fields' {
			this.db_fields = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

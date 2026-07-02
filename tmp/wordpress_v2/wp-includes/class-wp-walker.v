import rt

struct Class_Walker {
	rt.PhpObjectBase
pub mut:
	tree_type    rt.PhpVal = rt.new_null()
	db_fields    rt.PhpVal = rt.new_null()
	max_pages    rt.PhpVal = rt.new_int(1)
	has_children bool
}

fn (mut this Class_Walker) start_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_output_mutated := var_output
	mut depth_mutated := depth
}

fn (mut this Class_Walker) end_lvl(var_output rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_output_mutated := var_output
	mut depth_mutated := depth
}

fn (mut this Class_Walker) start_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal, current_object_id i64) {
	mut var_output_mutated := var_output
	mut depth_mutated := depth
}

fn (mut this Class_Walker) end_el(var_output rt.PhpVal, var_data_object rt.PhpVal, depth i64, var_args rt.PhpVal) {
	mut var_output_mutated := var_output
	mut depth_mutated := depth
}

fn (mut this Class_Walker) display_element(var_element rt.PhpVal, var_children_elements rt.PhpVal, var_max_depth rt.PhpVal, var_depth rt.PhpVal, var_args rt.PhpVal, var_output rt.PhpVal) {
	mut var_children_elements_mutated := var_children_elements
	mut var_max_depth_mutated := var_max_depth
	mut var_depth_mutated := var_depth
	mut var_output_mutated := var_output
	if rt.is_true(rt.new_bool(!(rt.is_true(var_element)))) {
		return
	}
	var_max_depth_mutated = rt.new_int(var_max_depth_mutated.to_i64())
	var_depth_mutated = rt.new_int(var_depth_mutated.to_i64())
	mut var_id_field := this.db_fields.array_get(rt.new_string('id'))
	mut var_id := rt.get_property(var_element,
		'{"nodeType":"Expr_Variable","line":142,"name":"id_field"}')
	this.has_children = !(!rt.is_true(var_children_elements_mutated.array_get(var_id)))
	if var_args.array_isset(rt.new_int(0)) && var_args.array_get(rt.new_int(0)).is_array() {
		var_args.array_get_mut(0).array_set('has_children', this.has_children)
	}
	this.start_el(var_output_mutated.clone(), var_element.clone(), var_depth_mutated.to_i64(), rt.call_function('array_values', [
		var_args.clone(),
	]), 0)
	if rt.is_true(rt.identical(rt.new_int(0), var_max_depth_mutated))
		|| rt.is_true(rt.greater(var_max_depth_mutated, rt.add(var_depth_mutated, rt.new_int(1))))
		&& var_children_elements_mutated.array_isset(var_id) {
		mut iter_1 := var_children_elements_mutated.array_get(var_id).iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_child := item_1.val
			if !(!var_newlevel.is_null()) {
				mut var_newlevel := rt.new_bool(true)
				this.start_lvl(var_output_mutated.clone(), var_depth_mutated.to_i64(), rt.call_function('array_values', [
					var_args.clone(),
				]))
			}
			this.display_element(var_child.clone(), var_children_elements_mutated.clone(),
				var_max_depth_mutated.clone(), rt.add(var_depth_mutated, rt.new_int(1)),
				var_args.clone(), var_output_mutated.clone())
		}
		var_children_elements_mutated.array_unset(var_id)
	}
	if !var_newlevel.is_null() && rt.is_true(var_newlevel) {
		this.end_lvl(var_output_mutated.clone(), var_depth_mutated.to_i64(), rt.call_function('array_values', [
			var_args.clone(),
		]))
	}
	this.end_el(var_output_mutated.clone(), var_element.clone(), var_depth_mutated.to_i64(), rt.call_function('array_values', [
		var_args.clone(),
	]))
}

fn (mut this Class_Walker) walk(var_elements rt.PhpVal, var_max_depth rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_elements_mutated := var_elements
	mut var_max_depth_mutated := var_max_depth
	mut var_output := rt.new_string('')
	var_max_depth_mutated = rt.new_int(var_max_depth_mutated.to_i64())
	if rt.is_true(rt.less(var_max_depth_mutated, -1)) || !rt.is_true(var_elements_mutated) {
		return var_output.clone()
	}
	mut var_parent_field := this.db_fields.array_get(rt.new_string('parent'))
	if rt.is_true(rt.identical(-1, var_max_depth_mutated)) {
		mut var_empty_array := rt.new_array()
		mut iter_2 := var_elements_mutated.iterator()
		for {
			item_2 := iter_2.next() or { break }
			mut var_e := item_2.val
			this.display_element(var_e.clone(), var_empty_array.clone(), rt.new_int(1),
				rt.new_int(0), var_args.clone(), var_output.clone())
		}
		return var_output.clone()
	}
	mut var_top_level_elements := rt.new_array()
	mut var_children_elements := rt.new_array()
	mut iter_3 := var_elements_mutated.iterator()
	for {
		item_3 := iter_3.next() or { break }
		mut var_e := item_3.val
		if !rt.is_true(rt.get_property(var_e,
			'{"nodeType":"Expr_Variable","line":224,"name":"parent_field"}')) {
			var_top_level_elements.array_push(var_e.clone())
		} else {
			var_children_elements.array_get_mut(rt.get_property(var_e,
				'{"nodeType":"Expr_Variable","line":227,"name":"parent_field"}')).array_push(var_e.clone())
		}
	}
	if !rt.is_true(var_top_level_elements) {
		mut var_first := rt.call_function('array_slice', [var_elements_mutated.clone(),
			rt.new_int(0), rt.new_int(1)])
		mut var_root := var_first.array_get(rt.new_int(0))
		var_top_level_elements = rt.new_array()
		var_children_elements = rt.new_array()
		mut iter_4 := var_elements_mutated.iterator()
		for {
			item_4 := iter_4.next() or { break }
			mut var_e := item_4.val
			if rt.is_true(rt.identical(rt.get_property(var_root,
				'{"nodeType":"Expr_Variable","line":243,"name":"parent_field"}'), rt.get_property(var_e,
				'{"nodeType":"Expr_Variable","line":243,"name":"parent_field"}')))
			{
				var_top_level_elements.array_push(var_e.clone())
			} else {
				var_children_elements.array_get_mut(rt.get_property(var_e,
					'{"nodeType":"Expr_Variable","line":246,"name":"parent_field"}')).array_push(var_e.clone())
			}
		}
	}
	mut iter_5 := var_top_level_elements.iterator()
	for {
		item_5 := iter_5.next() or { break }
		mut var_e := item_5.val
		this.display_element(var_e.clone(), var_children_elements.clone(),
			var_max_depth_mutated.clone(), rt.new_int(0), var_args.clone(), var_output.clone())
	}
	if rt.is_true(rt.identical(rt.new_int(0), var_max_depth_mutated))
		&& var_children_elements.clone().array_count() > 0 {
		var_empty_array = rt.new_array()
		mut iter_6 := var_children_elements.iterator()
		for {
			item_6 := iter_6.next() or { break }
			mut var_orphans := item_6.val
			mut iter_7 := var_orphans.iterator()
			for {
				item_7 := iter_7.next() or { break }
				mut var_op := item_7.val
				this.display_element(var_op.clone(), var_empty_array.clone(), rt.new_int(1),
					rt.new_int(0), var_args.clone(), var_output.clone())
			}
		}
	}
	return var_output.clone()
}

fn (mut this Class_Walker) paged_walk(var_elements rt.PhpVal, var_max_depth rt.PhpVal, var_page_num rt.PhpVal, var_per_page rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_elements_mutated := var_elements
	mut var_max_depth_mutated := var_max_depth
	mut var_output := rt.new_string('')
	var_max_depth_mutated = rt.new_int(var_max_depth_mutated.to_i64())
	if !rt.is_true(var_elements_mutated) || rt.is_true(rt.less(var_max_depth_mutated, -1)) {
		return var_output.clone()
	}
	mut var_parent_field := this.db_fields.array_get(rt.new_string('parent'))
	mut var_count := rt.new_int(-1)
	if rt.is_true(rt.identical(-1, var_max_depth_mutated)) {
		mut var_total_top := rt.new_int(var_elements_mutated.clone().array_count())
	}
	if rt.is_true(rt.less(var_page_num, rt.new_int(1)))
		|| rt.is_true(rt.less(var_per_page, rt.new_int(0))) {
		mut var_paging := rt.new_bool(false)
		mut var_start := rt.new_int(0)
		if rt.is_true(rt.identical(-1, var_max_depth_mutated)) {
			mut var_end := var_total_top.clone()
		}
		this.max_pages = rt.new_int(1)
	} else {
		var_paging = rt.new_bool(true)
		var_start = rt.new_int(var_page_num.to_i64()) - 1 * rt.new_int(var_per_page.to_i64())
		var_end = rt.add(var_start, var_per_page)
		if rt.is_true(rt.identical(-1, var_max_depth_mutated)) {
			this.max_pages = rt.new_int((rt.call_function('ceil', [
				rt.div(var_total_top, var_per_page),
			])).to_i64())
		}
	}
	if rt.is_true(rt.identical(-1, var_max_depth_mutated)) {
		if !(!rt.is_true(var_args.array_get(rt.new_int(0)).array_get(rt.new_string('reverse_top_level')))) {
			var_elements_mutated = rt.call_function('array_reverse', [
				var_elements_mutated.clone()])
			mut var_oldstart := var_start.clone()
			var_start = rt.sub(var_total_top, var_end)
			var_end = rt.sub(var_total_top, var_oldstart)
		}
		mut var_empty_array := rt.new_array()
		mut iter_8 := var_elements_mutated.iterator()
		for {
			item_8 := iter_8.next() or { break }
			mut var_e := item_8.val
			rt.pre_inc(var_count)
			if rt.is_true(rt.less(var_count, var_start)) {
				continue
			}
			if rt.is_true(rt.greater_equal(var_count, var_end)) {
				break
			}
			this.display_element(var_e.clone(), var_empty_array.clone(), rt.new_int(1),
				rt.new_int(0), var_args.clone(), var_output.clone())
		}
		return var_output.clone()
	}
	mut var_top_level_elements := rt.new_array()
	mut var_children_elements := rt.new_array()
	mut iter_9 := var_elements_mutated.iterator()
	for {
		item_9 := iter_9.next() or { break }
		mut var_e := item_9.val
		if !rt.is_true(rt.get_property(var_e,
			'{"nodeType":"Expr_Variable","line":355,"name":"parent_field"}')) {
			var_top_level_elements.array_push(var_e.clone())
		} else {
			var_children_elements.array_get_mut(rt.get_property(var_e,
				'{"nodeType":"Expr_Variable","line":358,"name":"parent_field"}')).array_push(var_e.clone())
		}
	}
	var_total_top = rt.new_int(var_top_level_elements.clone().array_count())
	if rt.is_true(var_paging) {
		this.max_pages = rt.new_int((rt.call_function('ceil', [
			rt.div(var_total_top, var_per_page),
		])).to_i64())
	} else {
		var_end = var_total_top.clone()
	}
	if !(!rt.is_true(var_args.array_get(rt.new_int(0)).array_get(rt.new_string('reverse_top_level')))) {
		var_top_level_elements = rt.call_function('array_reverse', [
			var_top_level_elements.clone()])
		var_oldstart = var_start.clone()
		var_start = rt.sub(var_total_top, var_end)
		var_end = rt.sub(var_total_top, var_oldstart)
	}
	if !(!rt.is_true(var_args.array_get(rt.new_int(0)).array_get(rt.new_string('reverse_children')))) {
		mut iter_10 := var_children_elements.iterator()
		for {
			item_10 := iter_10.next() or { break }
			mut var_children := item_10.val
			mut var_parent := item_10.key
			var_children_elements.array_set(var_parent, rt.call_function('array_reverse', [
				var_children.clone(),
			]))
		}
	}
	mut iter_11 := var_top_level_elements.iterator()
	for {
		item_11 := iter_11.next() or { break }
		mut var_e := item_11.val
		rt.pre_inc(var_count)
		if rt.is_true(rt.greater_equal(var_end, var_total_top))
			&& rt.is_true(rt.less(var_count, var_start)) {
			this.unset_children(var_e.clone(), var_children_elements.clone())
		}
		if rt.is_true(rt.less(var_count, var_start)) {
			continue
		}
		if rt.is_true(rt.greater_equal(var_count, var_end)) {
			break
		}
		this.display_element(var_e.clone(), var_children_elements.clone(),
			var_max_depth_mutated.clone(), rt.new_int(0), var_args.clone(), var_output.clone())
	}
	if rt.is_true(rt.greater_equal(var_end, var_total_top))
		&& var_children_elements.clone().array_count() > 0 {
		var_empty_array = rt.new_array()
		mut iter_12 := var_children_elements.iterator()
		for {
			item_12 := iter_12.next() or { break }
			mut var_orphans := item_12.val
			mut iter_13 := var_orphans.iterator()
			for {
				item_13 := iter_13.next() or { break }
				mut var_op := item_13.val
				this.display_element(var_op.clone(), var_empty_array.clone(), rt.new_int(1),
					rt.new_int(0), var_args.clone(), var_output.clone())
			}
		}
	}
	return var_output.clone()
}

fn (mut this Class_Walker) get_number_of_root_elements(var_elements rt.PhpVal) rt.PhpVal {
	mut var_elements_mutated := var_elements
	mut var_num := rt.new_int(0)
	mut var_parent_field := this.db_fields.array_get(rt.new_string('parent'))
	mut iter_14 := var_elements_mutated.iterator()
	for {
		item_14 := iter_14.next() or { break }
		mut var_e := item_14.val
		if !rt.is_true(rt.get_property(var_e,
			'{"nodeType":"Expr_Variable","line":425,"name":"parent_field"}')) {
			rt.pre_inc(var_num)
		}
	}
	return var_num.clone()
}

fn (mut this Class_Walker) unset_children(var_element rt.PhpVal, var_children_elements rt.PhpVal) {
	mut var_children_elements_mutated := var_children_elements
	if rt.is_true(rt.new_bool(!(rt.is_true(var_element))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(var_children_elements_mutated)))) {
		return
	}
	mut var_id_field := this.db_fields.array_get(rt.new_string('id'))
	mut var_id := rt.get_property(var_element,
		'{"nodeType":"Expr_Variable","line":446,"name":"id_field"}')
	if !(!rt.is_true(var_children_elements_mutated.array_get(var_id)))
		&& var_children_elements_mutated.array_get(var_id).is_array() {
		mut iter_15 := rt.cast_array(var_children_elements_mutated.array_get(var_id)).iterator()
		for {
			item_15 := iter_15.next() or { break }
			mut var_child := item_15.val
			this.unset_children(var_child.clone(), var_children_elements_mutated.clone())
		}
	}
	var_children_elements_mutated.array_unset(var_id)
}

fn create_walker(_args ...rt.PhpVal) &Class_Walker {
	mut obj := &Class_Walker{
		PhpObjectBase: rt.PhpObjectBase{}
		tree_type:     rt.new_null()
		db_fields:     rt.new_null()
		max_pages:     rt.new_int(1)
		has_children:  false
	}
	return obj
}

fn (mut this Class_Walker) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'display_element' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			dispatch_arg_5 := if args.len > 5 { args[5] } else { rt.new_null() }
			this.display_element(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, dispatch_arg_5)
			return rt.new_null()
		}
		'walk' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return this.walk(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'paged_walk' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return this.paged_walk(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4)
		}
		'get_number_of_root_elements' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_number_of_root_elements(dispatch_arg_0)
		}
		'unset_children' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			this.unset_children(dispatch_arg_0, dispatch_arg_1)
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Walker) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'tree_type' { return this.tree_type }
		'db_fields' { return this.db_fields }
		'max_pages' { return this.max_pages }
		'has_children' { return rt.new_bool(this.has_children) }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Walker) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'tree_type' {
			this.tree_type = val
			return true
		}
		'db_fields' {
			this.db_fields = val
			return true
		}
		'max_pages' {
			this.max_pages = val
			return true
		}
		'has_children' {
			this.has_children = val.to_bool()
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

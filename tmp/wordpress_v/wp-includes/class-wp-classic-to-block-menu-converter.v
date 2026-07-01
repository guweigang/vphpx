import rt

struct Class_WP_Classic_To_Block_Menu_Converter {
	rt.PhpObjectBase
}

fn Class_WP_Classic_To_Block_Menu_Converter.convert(var_menu rt.PhpVal) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_nav_menu', [var_menu.dup()]))))) {
		return (create_wp_error(rt.new_string('invalid_menu'), rt.call_function('__', [rt.new_string('The menu provided is not a valid menu.')]))).str()
	}
	mut var_menu_items := rt.call_function('wp_get_nav_menu_items', [rt.get_property(var_menu, 'term_id'), rt.create_array([rt.ArrayItem{ key: 'update_post_term_cache', val: false }])])
	if !rt.is_true(var_menu_items) {
		return ''
	}
	rt.call_function('_wp_menu_item_classes_by_context', [var_menu_items.dup()])
	mut var_menu_items_by_parent_id := Class_WP_Classic_To_Block_Menu_Converter.group_by_parent_id(var_menu_items.dup())
	mut var_first_menu_item := if !(var_menu_items_by_parent_id.array_get(0)).is_null() { var_menu_items_by_parent_id.array_get(0) } else { rt.new_array() }
	mut var_inner_blocks := Class_WP_Classic_To_Block_Menu_Converter.to_blocks(var_first_menu_item.dup(), var_menu_items_by_parent_id.dup())
	return (rt.call_function('serialize_blocks', [var_inner_blocks.dup()])).str()
}

fn Class_WP_Classic_To_Block_Menu_Converter.group_by_parent_id(var_menu_items rt.PhpVal) rt.PhpVal {
	mut var_menu_items_mutated := var_menu_items
	mut var_menu_items_by_parent_id := rt.new_array()
	{
		mut iter_1 := var_menu_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_menu_item := item_1.val
			var_menu_items_by_parent_id.array_get_mut(rt.get_property(var_menu_item, 'menu_item_parent')).array_push(var_menu_item.dup())
		}
	}
	return var_menu_items_by_parent_id.dup()
}

fn Class_WP_Classic_To_Block_Menu_Converter.to_blocks(var_menu_items rt.PhpVal, var_menu_items_by_parent_id rt.PhpVal) rt.PhpVal {
	mut var_menu_items_mutated := var_menu_items
	mut var_menu_items_by_parent_id_mutated := var_menu_items_by_parent_id
	if !rt.is_true(var_menu_items_mutated) {
		return rt.new_array()
	}
	mut var_blocks := rt.new_array()
	{
		mut iter_1 := var_menu_items_mutated.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_menu_item := item_1.val
			mut var_class_name := if !(!rt.is_true(rt.get_property(var_menu_item, 'classes'))) { rt.call_function('implode', [rt.new_string(' '), rt.cast_array(rt.get_property(var_menu_item, 'classes'))]) } else { rt.new_null() }
			mut var_id := if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { rt.get_property(var_menu_item, 'object_id') } else { rt.new_null() }
			mut var_opens_in_new_tab := rt.new_bool(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(rt.identical(rt.new_string('_blank'), rt.get_property(var_menu_item, 'target')))))
			mut var_rel := if rt.is_true(rt.new_bool(rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) && rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical))) { rt.get_property(var_menu_item, 'xfn') } else { rt.new_null() }
			mut var_kind := if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) { rt.call_function('str_replace', [rt.new_string('_'), rt.new_string('-'), rt.get_property(var_menu_item, 'type')]) } else { rt.new_string('custom') }
			mut var_block := { 'blockName': if var_menu_items_by_parent_id_mutated.array_isset(rt.get_property(var_menu_item, 'ID')) { rt.new_string('core/navigation-submenu') } else { rt.new_string('core/navigation-link') }, 'attrs': { 'className': var_class_name, 'description': rt.get_property(var_menu_item, 'description'), 'id': var_id, 'kind': var_kind, 'label': rt.get_property(var_menu_item, 'title'), 'opensInNewTab': var_opens_in_new_tab, 'rel': var_rel, 'title': rt.get_property(var_menu_item, 'attr_title'), 'type': rt.get_property(var_menu_item, 'object'), 'url': rt.get_property(var_menu_item, 'url') } }
			var_block['innerBlocks'] = if var_menu_items_by_parent_id_mutated.array_isset(rt.get_property(var_menu_item, 'ID')) { Class_WP_Classic_To_Block_Menu_Converter.to_blocks(var_menu_items_by_parent_id_mutated.array_get(rt.get_property(var_menu_item, 'ID')), var_menu_items_by_parent_id_mutated.dup()) } else { rt.new_array() }
			var_block['innerContent'] = rt.call_function('array_map', [rt.new_string('serialize_block'), var_block.array_get('innerBlocks')])
			var_blocks << var_block.dup()
		}
	}
	return var_blocks.dup()
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

fn create_wp_classic_to_block_menu_converter() &Class_WP_Classic_To_Block_Menu_Converter {
	mut obj := &Class_WP_Classic_To_Block_Menu_Converter{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Classic_To_Block_Menu_Converter) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'convert' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(Class_WP_Classic_To_Block_Menu_Converter.convert(dispatch_arg_0))
		}
		'group_by_parent_id' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_WP_Classic_To_Block_Menu_Converter.group_by_parent_id(dispatch_arg_0)
		}
		'to_blocks' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_WP_Classic_To_Block_Menu_Converter.to_blocks(dispatch_arg_0, dispatch_arg_1)
		}
		else { return none }
	}
}

fn (this &Class_WP_Classic_To_Block_Menu_Converter) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Classic_To_Block_Menu_Converter) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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




pub fn init_wp_includes_class_wp_classic_to_block_menu_converter_php() {
}

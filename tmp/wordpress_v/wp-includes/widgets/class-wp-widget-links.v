import rt

struct Class_WP_Widget_Links {
	rt.PhpObjectBase
}

fn (mut this Class_WP_Widget_Links) construct()  {
	mut var_widget_ops := { 'description': rt.call_function('__', [rt.new_string('Your blogroll')]), 'customize_selective_refresh': rt.new_bool(true) }
	this.Class_WP_Widget.construct(rt.new_string('links'), rt.call_function('__', [rt.new_string('Links')]), var_widget_ops.dup())
}

fn (mut this Class_WP_Widget_Links) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	mut var_show_description := if !(var_instance_mutated.array_get('description')).is_null() { var_instance_mutated.array_get('description') } else { rt.new_bool(false) }
	mut var_show_name := if !(var_instance_mutated.array_get('name')).is_null() { var_instance_mutated.array_get('name') } else { rt.new_bool(false) }
	mut var_show_rating := if !(var_instance_mutated.array_get('rating')).is_null() { var_instance_mutated.array_get('rating') } else { rt.new_bool(false) }
	mut var_show_images := if !(var_instance_mutated.array_get('images')).is_null() { var_instance_mutated.array_get('images') } else { rt.new_bool(true) }
	mut var_category := if !(var_instance_mutated.array_get('category')).is_null() { var_instance_mutated.array_get('category') } else { rt.new_bool(false) }
	mut var_orderby := if !(var_instance_mutated.array_get('orderby')).is_null() { var_instance_mutated.array_get('orderby') } else { rt.new_string('name') }
	mut var_order := rt.new_string(if rt.is_true(rt.identical(rt.new_string('rating'), var_orderby)) { rt.new_string('DESC') } else { rt.new_string('ASC') })
	mut var_limit := if !(var_instance_mutated.array_get('limit')).is_null() { var_instance_mutated.array_get('limit') } else { // unsupported expression: Expr_UnaryMinus }
	mut var_before_widget := rt.call_function('preg_replace', [rt.new_string('/ id="[^"]*"/'), rt.new_string(' id="%id"'), var_args.array_get('before_widget')])
	mut var_widget_links_args := { 'title_before': var_args.array_get('before_title'), 'title_after': var_args.array_get('after_title'), 'category_before': var_before_widget, 'category_after': var_args.array_get('after_widget'), 'show_images': var_show_images, 'show_description': var_show_description, 'show_name': var_show_name, 'show_rating': var_show_rating, 'category': var_category, 'class': rt.new_string('linkcat widget'), 'orderby': var_orderby, 'order': var_order, 'limit': var_limit }
	rt.call_function('wp_list_bookmarks', [rt.call_function('apply_filters', [rt.new_string('widget_links_args'), var_widget_links_args.dup(), var_instance_mutated.dup()])])
}

fn (mut this Class_WP_Widget_Links) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_new_instance_mutated := var_new_instance
	var_new_instance_mutated = rt.cast_array(var_new_instance_mutated)
	mut var_instance := rt.create_array([rt.ArrayItem{ key: 'images', val: 0 }, rt.ArrayItem{ key: 'name', val: 0 }, rt.ArrayItem{ key: 'description', val: 0 }, rt.ArrayItem{ key: 'rating', val: 0 }])
	{
		mut iter_1 := var_instance.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_val := item_1.val
			mut var_field := item_1.key
			if var_new_instance_mutated.array_isset(var_field) {
				var_instance.array_set(var_field, 1)
			}
		}
	}
	var_instance.array_set('orderby', 'name')
	if rt.is_true(rt.call_function('in_array', [var_new_instance_mutated.array_get('orderby'), rt.create_array([rt.ArrayItem{ key: none, val: 'name' }, rt.ArrayItem{ key: none, val: 'rating' }, rt.ArrayItem{ key: none, val: 'id' }, rt.ArrayItem{ key: none, val: 'rand' }]), rt.new_bool(true)])) {
		var_instance.array_set('orderby', var_new_instance_mutated.array_get('orderby'))
	}
	var_instance.array_set('category', // unsupported expression: Expr_Cast_Int)
	var_instance.array_set('limit', if !(!rt.is_true(var_new_instance_mutated.array_get('limit'))) { // unsupported expression: Expr_Cast_Int } else { // unsupported expression: Expr_UnaryMinus })
	return var_instance.dup()
}

fn (mut this Class_WP_Widget_Links) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [rt.cast_array(var_instance_mutated), rt.create_array([rt.ArrayItem{ key: 'images', val: true }, rt.ArrayItem{ key: 'name', val: true }, rt.ArrayItem{ key: 'description', val: false }, rt.ArrayItem{ key: 'rating', val: false }, rt.ArrayItem{ key: 'category', val: false }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'limit', val: // unsupported expression: Expr_UnaryMinus }])])
	mut var_link_cats := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'link_category' }])])
	mut var_limit := // unsupported expression: Expr_Cast_Int
	if rt.is_true(rt.new_bool(!(rt.is_true(var_limit)))) {
		var_limit = // unsupported expression: Expr_UnaryMinus
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('category')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Select Link Category:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('category')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('category')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('All Links'), rt.new_string('links widget')])
	// unsupported statement: Stmt_InlineHTML
	{
		mut iter_1 := var_link_cats.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_link_cat := item_1.val
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(// unsupported expression: Expr_Cast_Int)
			// unsupported statement: Stmt_InlineHTML
			rt.call_function('selected', [var_instance_mutated.array_get('category'), rt.get_property(var_link_cat, 'term_id')])
			// unsupported statement: Stmt_InlineHTML
			rt.echo_val(rt.call_function('esc_html', [rt.get_property(var_link_cat, 'name')]))
			// unsupported statement: Stmt_InlineHTML
		}
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('orderby')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Sort by:')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('orderby')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('orderby')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('orderby'), rt.new_string('name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link title')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('orderby'), rt.new_string('rating')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link rating')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('orderby'), rt.new_string('id')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Link ID')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('selected', [var_instance_mutated.array_get('orderby'), rt.new_string('rand')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_ex', [rt.new_string('Random'), rt.new_string('Links widget')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_instance_mutated.array_get('images'), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('images')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('images')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('images')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show Link Image')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_instance_mutated.array_get('name'), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('name')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('name')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('name')))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('_e', [rt.new_string('Show Link Name')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_instance_mutated.array_get('description'), rt.new_bool(true)])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('description')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_name(rt.new_string('description')))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(this.get_field_id(rt.new_string('description')))
	// unsupported statement: Stmt_InlineHTML
	
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wp_widget_links() &Class_WP_Widget_Links {
	mut obj := &Class_WP_Widget_Links{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wp_widget() &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Widget_Links) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
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
			this.form(dispatch_arg_0)
			return rt.new_null()
		}
		else { return none }
	}
}

fn (this &Class_WP_Widget_Links) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget_Links) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_WP_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_widgets_class_wp_widget_links_php() {
}

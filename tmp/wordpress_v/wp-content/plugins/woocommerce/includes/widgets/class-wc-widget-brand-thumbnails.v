import rt

struct Class_WC_Widget_Brand_Thumbnails {
	rt.PhpObjectBase
pub mut:
		woo_widget_cssclass string
		woo_widget_description rt.PhpVal = rt.new_null()
		woo_widget_idbase string
		woo_widget_name rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Widget_Brand_Thumbnails) construct()  {
	this.woo_widget_name = rt.call_function('__', [rt.new_string('WooCommerce Brand Thumbnails'), rt.new_string('woocommerce')])
	this.woo_widget_description = rt.call_function('__', [rt.new_string('Show a grid of brand thumbnails.'), rt.new_string('woocommerce')])
	this.woo_widget_idbase = 'wc_brands_brand_thumbnails'
	this.woo_widget_cssclass = 'widget_brand_thumbnails'
	mut var_widget_ops := { 'classname': this.woo_widget_cssclass, 'description': this.woo_widget_description }
	this.Class_WP_Widget.construct(rt.new_string(this.woo_widget_idbase), this.woo_widget_name, var_widget_ops.dup())
}

fn (mut this Class_WC_Widget_Brand_Thumbnails) widget(var_args rt.PhpVal, var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	var_instance_mutated = rt.call_function('wp_parse_args', [var_instance_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'title', val: '' }, rt.ArrayItem{ key: 'columns', val: 1 }, rt.ArrayItem{ key: 'exclude', val: '' }, rt.ArrayItem{ key: 'orderby', val: 'name' }, rt.ArrayItem{ key: 'hide_empty', val: 0 }, rt.ArrayItem{ key: 'number', val: '' }])])
	mut var_exclude := rt.call_function('array_map', [rt.new_string('intval'), rt.call_function('explode', [rt.new_string(','), var_instance_mutated.array_get('exclude')])])
	mut var_order := rt.new_string(if rt.is_true(rt.identical(rt.new_string('name'), var_instance_mutated.array_get('orderby'))) { rt.new_string('asc') } else { rt.new_string('desc') })
	mut var_brands := rt.call_function('get_terms', [rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: 'product_brand' }, rt.ArrayItem{ key: 'hide_empty', val: var_instance_mutated.array_get('hide_empty') }, rt.ArrayItem{ key: 'orderby', val: var_instance_mutated.array_get('orderby') }, rt.ArrayItem{ key: 'exclude', val: var_exclude }, rt.ArrayItem{ key: 'number', val: var_instance_mutated.array_get('number') }, rt.ArrayItem{ key: 'order', val: var_order }])])
	if rt.is_true(rt.new_bool(!(rt.is_true(var_brands)))) {
		return rt.new_null()
	}
	mut var_title := rt.call_function('apply_filters', [rt.new_string('widget_title'), var_instance_mutated.array_get('title'), var_instance_mutated.dup(), this.woo_widget_idbase])
	rt.echo_val(var_args.array_get('before_widget'))
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		print((var_args.array_get('before_title')).str() + (var_title).str() + (var_args.array_get('after_title')).str())
		// unsupported statement: Stmt_Nop
	}
	rt.call_function('wc_get_template', [rt.new_string('widgets/brand-thumbnails.php'), rt.create_array([rt.ArrayItem{ key: 'brands', val: var_brands }, rt.ArrayItem{ key: 'columns', val: // unsupported expression: Expr_Cast_Int }, rt.ArrayItem{ key: 'fluid_columns', val: if !(!rt.is_true(var_instance_mutated.array_get('fluid_columns'))) { true } else { false } }]), rt.new_string('woocommerce'), (rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() + '/templates/brands/'])
	rt.echo_val(var_args.array_get('after_widget'))
	// unsupported statement: Stmt_Nop
}

fn (mut this Class_WC_Widget_Brand_Thumbnails) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := rt.new_null()
	var_instance.array_set('title', rt.call_function('wp_strip_all_tags', [rt.call_function('stripslashes', [var_new_instance.array_get('title')])]))
	var_instance.array_set('columns', rt.call_function('wp_strip_all_tags', [rt.call_function('stripslashes', [var_new_instance.array_get('columns')])]))
	var_instance.array_set('fluid_columns', if !(!rt.is_true(var_new_instance.array_get('fluid_columns'))) { true } else { false })
	var_instance.array_set('orderby', rt.call_function('wp_strip_all_tags', [rt.call_function('stripslashes', [var_new_instance.array_get('orderby')])]))
	var_instance.array_set('exclude', rt.call_function('wp_strip_all_tags', [rt.call_function('stripslashes', [var_new_instance.array_get('exclude')])]))
	var_instance.array_set('hide_empty', rt.call_function('wp_strip_all_tags', [rt.call_function('stripslashes', [// unsupported expression: Expr_Cast_String])]))
	var_instance.array_set('number', rt.call_function('wp_strip_all_tags', [rt.call_function('stripslashes', [var_new_instance.array_get('number')])]))
	if rt.is_true(rt.new_bool(!(rt.is_true(var_instance.array_get('columns'))))) {
		var_instance.array_set('columns', 1)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_instance.array_get('orderby'))))) {
		var_instance.array_set('orderby', 'name')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_instance.array_get('exclude'))))) {
		var_instance.array_set('exclude', '')
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_instance.array_get('hide_empty'))))) {
		var_instance.array_set('hide_empty', 0)
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_instance.array_get('number'))))) {
		var_instance.array_set('number', '')
	}
	return var_instance.dup()
}

fn (mut this Class_WC_Widget_Brand_Thumbnails) form(var_instance rt.PhpVal)  {
	mut var_instance_mutated := var_instance
	if !(var_instance_mutated.array_isset(rt.new_string('hide_empty'))) {
		var_instance_mutated.array_set('hide_empty', 0)
	}
	if !(var_instance_mutated.array_isset(rt.new_string('orderby'))) {
		var_instance_mutated.array_set('orderby', 'name')
	}
	if !rt.is_true(var_instance_mutated.array_get('fluid_columns')) {
		var_instance_mutated.array_set('fluid_columns', false)
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if var_instance_mutated.array_isset(rt.new_string('title')) { rt.call_function('esc_attr', [var_instance_mutated.array_get('title')]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('columns'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Columns:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('columns'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('columns'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if var_instance_mutated.array_isset(rt.new_string('columns')) { rt.call_function('esc_attr', [var_instance_mutated.array_get('columns')]) } else { rt.new_string('1') })
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('fluid_columns'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Fluid columns:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('checked', [var_instance_mutated.array_get('fluid_columns')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('fluid_columns'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('fluid_columns'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('number'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Number:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('number'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('number'))]))
	// unsupported statement: Stmt_InlineHTML
	if var_instance_mutated.array_isset(rt.new_string('number')) {
		rt.echo_val(rt.call_function('esc_attr', [var_instance_mutated.array_get('number')]))
	}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('All'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('exclude'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Exclude:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('exclude'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('exclude'))]))
	// unsupported statement: Stmt_InlineHTML
	if var_instance_mutated.array_isset(rt.new_string('exclude')) {
		rt.echo_val(rt.call_function('esc_attr', [var_instance_mutated.array_get('exclude')]))
	}
	// unsupported statement: Stmt_Nop
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_attr_e', [rt.new_string('None'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('hide_empty'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Hide empty brands:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string())]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val()
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wc_widget_brand_thumbnails() &Class_WC_Widget_Brand_Thumbnails {
	mut obj := &Class_WC_Widget_Brand_Thumbnails{
		PhpObjectBase: rt.PhpObjectBase{}
		woo_widget_cssclass: ''
		woo_widget_description: rt.new_null()
		woo_widget_idbase: ''
		woo_widget_name: rt.new_null()
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

fn (mut this Class_WC_Widget_Brand_Thumbnails) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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

fn (this &Class_WC_Widget_Brand_Thumbnails) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'woo_widget_cssclass' { return rt.new_string(this.woo_widget_cssclass) }
		'woo_widget_description' { return this.woo_widget_description }
		'woo_widget_idbase' { return rt.new_string(this.woo_widget_idbase) }
		'woo_widget_name' { return this.woo_widget_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Widget_Brand_Thumbnails) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'woo_widget_cssclass' { this.woo_widget_cssclass = (val).str(); return true }
		'woo_widget_description' { this.woo_widget_description = val; return true }
		'woo_widget_idbase' { this.woo_widget_idbase = (val).str(); return true }
		'woo_widget_name' { this.woo_widget_name = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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




pub fn init_wp_content_plugins_woocommerce_includes_widgets_class_wc_widget_brand_thumbnails_php() {
	// unsupported statement: Stmt_Declare
}

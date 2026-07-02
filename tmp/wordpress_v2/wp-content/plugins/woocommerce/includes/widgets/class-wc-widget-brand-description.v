import rt

struct Class_WC_Widget_Brand_Description {
	rt.PhpObjectBase
pub mut:
	woo_widget_cssclass    string
	woo_widget_description rt.PhpVal = rt.new_null()
	woo_widget_idbase      string
	woo_widget_name        rt.PhpVal = rt.new_null()
}

fn (mut this Class_WC_Widget_Brand_Description) construct() {
	this.woo_widget_name = rt.call_function('__', [
		rt.new_string('WooCommerce Brand Description'),
		rt.new_string('woocommerce'),
	])
	this.woo_widget_description = rt.call_function('__', [
		rt.new_string('When viewing a brand archive, show the current brands description.'),
		rt.new_string('woocommerce'),
	])
	this.woo_widget_idbase = 'wc_brands_brand_description'
	this.woo_widget_cssclass = 'widget_brand_description'
	mut var_widget_ops := {
		'classname':   this.woo_widget_cssclass
		'description': this.woo_widget_description
	}
	this.Class_WP_Widget.construct(rt.new_string(this.woo_widget_idbase), this.woo_widget_name,
		var_widget_ops.clone())
}

fn (mut this Class_WC_Widget_Brand_Description) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_before_widget := rt.new_null()
	mut var_before_title := rt.new_null()
	mut var_after_title := rt.new_null()
	mut var_after_widget := rt.new_null()
	mut var_instance_mutated := var_instance
	rt.call_function('extract', [var_args.clone()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_tax', [
		rt.new_string('product_brand'),
	])))))
	{
		return
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('get_query_var', [
		rt.new_string('term'),
	])))))
	{
		return
	}
	mut var_thumbnail := rt.new_string('')
	mut var_term := rt.call_function('get_term_by', [rt.new_string('slug'),
		rt.call_function('get_query_var', [rt.new_string('term')]),
		rt.new_string('product_brand')])
	var_thumbnail = rt.call_function('wc_get_brand_thumbnail_url', [
		rt.get_property(var_term, 'term_id'),
		rt.new_string('large'),
	])
	print(var_before_widget.str() + var_before_title.str() +
		(rt.get_property(var_term, 'name')).str() + var_after_title.str())
	rt.call_function('wc_get_template', [rt.new_string('widgets/brand-description.php'),
		rt.create_array([rt.ArrayItem{ key: 'thumbnail', val: var_thumbnail },
			rt.ArrayItem{ key: 'brand', val: var_term }]),
		rt.new_string('woocommerce'),
		rt.new_string(
			(rt.call_method(rt.call_function('WC', []rt.PhpVal{}), 'plugin_path', []rt.PhpVal{})).str() +
			'/templates/brands/')])
	rt.echo_val(var_after_widget)
}

fn (mut this Class_WC_Widget_Brand_Description) update(var_new_instance rt.PhpVal, var_old_instance rt.PhpVal) rt.PhpVal {
	mut var_instance := map[string]rt.PhpVal{}
	var_instance['title'] = rt.call_function('wp_strip_all_tags', [
		rt.call_function('stripslashes', [var_new_instance.array_get(rt.new_string('title'))]),
	])
	return var_instance.clone()
}

fn (mut this Class_WC_Widget_Brand_Description) form(var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Title:'), rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_id(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_attr', [this.get_field_name(rt.new_string('title'))]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(if var_instance_mutated.array_isset(rt.new_string('title')) { rt.call_function('esc_attr', [
			var_instance_mutated.array_get(rt.new_string('title')),
		]) } else { rt.new_string('') })
	// unsupported statement: Stmt_InlineHTML
}

struct Class_WP_Widget {
	rt.PhpObjectBase
}

fn create_wc_widget_brand_description() &Class_WC_Widget_Brand_Description {
	mut obj := &Class_WC_Widget_Brand_Description{
		PhpObjectBase:          rt.PhpObjectBase{}
		woo_widget_cssclass:    ''
		woo_widget_description: rt.new_null()
		woo_widget_idbase:      ''
		woo_widget_name:        rt.new_null()
	}
	obj.construct()
	return obj
}

fn create_wp_widget(_args ...rt.PhpVal) &Class_WP_Widget {
	mut obj := &Class_WP_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget_Brand_Description) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_WC_Widget_Brand_Description) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'woo_widget_cssclass' { return rt.new_string(this.woo_widget_cssclass) }
		'woo_widget_description' { return this.woo_widget_description }
		'woo_widget_idbase' { return rt.new_string(this.woo_widget_idbase) }
		'woo_widget_name' { return this.woo_widget_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Widget_Brand_Description) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'woo_widget_cssclass' {
			this.woo_widget_cssclass = val.str()
			return true
		}
		'woo_widget_description' {
			this.woo_widget_description = val
			return true
		}
		'woo_widget_idbase' {
			this.woo_widget_idbase = val.str()
			return true
		}
		'woo_widget_name' {
			this.woo_widget_name = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
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

fn main() {
	defer {
		rt.shutdown()
	}
}

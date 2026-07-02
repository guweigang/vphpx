import rt

struct Class_WC_Widget_Product_Tag_Cloud {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) construct() {
	this.dispatch_set_prop('widget_cssclass', rt.new_string('woocommerce widget_product_tag_cloud'))
	this.dispatch_set_prop('widget_description', rt.call_function('__', [
		rt.new_string('A cloud of your most used product tags.'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('widget_id', rt.new_string('woocommerce_product_tag_cloud'))
	this.dispatch_set_prop('widget_name', rt.call_function('__', [
		rt.new_string('Product Tag Cloud'),
		rt.new_string('woocommerce'),
	]))
	this.dispatch_set_prop('settings', rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'std', val: rt.call_function('__', [
				rt.new_string('Product tags'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
				rt.new_string('Title'),
				rt.new_string('woocommerce'),
			]) },
		]) },
	]))
	this.Class_WC_Widget.construct()
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) widget(var_args rt.PhpVal, var_instance rt.PhpVal) {
	mut var_instance_mutated := var_instance
	mut var_current_taxonomy :=
		rt.new_string(this.get_current_taxonomy(var_instance_mutated.clone()))
	if !rt.is_true(var_instance_mutated.array_get(rt.new_string('title'))) {
		mut var_taxonomy := rt.call_function('get_taxonomy', [
			var_current_taxonomy.clone()])
		var_instance_mutated.array_set('title', rt.get_property(rt.get_property(var_taxonomy,
			'labels'), 'name'))
	}
	this.widget_start(var_args.clone(), var_instance_mutated.clone())
	print('<div class="tagcloud">')
	rt.call_function('wp_tag_cloud', [
		rt.call_function('apply_filters', [
			rt.new_string('woocommerce_product_tag_cloud_widget_args'),
			rt.create_array([rt.ArrayItem{ key: 'taxonomy', val: var_current_taxonomy },
				rt.ArrayItem{ key: 'topic_count_text_callback', val: rt.create_array([
					rt.ArrayItem{ key: none, val: rt.new_object('WC_Widget_Product_Tag_Cloud', [
						'WC_Widget',
					], &this) },
					rt.ArrayItem{ key: none, val: 'topic_count_text' },
				]) }]),
		]),
	])
	print('</div>')
	this.widget_end(var_args.clone())
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) get_current_taxonomy(var_instance rt.PhpVal) string {
	mut var_instance_mutated := var_instance
	return 'product_tag'
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) topic_count_text(var_count rt.PhpVal) rt.PhpVal {
	return rt.call_function('sprintf', [
		rt.call_function('_n', [rt.new_string('%s product'), rt.new_string('%s products'),
			var_count.clone(), rt.new_string('woocommerce')]),
		rt.call_function('number_format_i18n', [var_count.clone()]),
	])
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) _get_current_taxonomy(var_instance rt.PhpVal) rt.PhpVal {
	mut var_instance_mutated := var_instance
	rt.call_function('wc_deprecated_function', [rt.new_string('_get_current_taxonomy'),
		rt.new_string('3.4.0'), rt.new_string('WC_Widget_Product_Tag_Cloud->get_current_taxonomy')])
	return rt.new_string(this.get_current_taxonomy(var_instance_mutated.clone()))
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) _topic_count_text(var_count rt.PhpVal) rt.PhpVal {
	rt.call_function('wc_deprecated_function', [rt.new_string('_topic_count_text'),
		rt.new_string('3.4.0'), rt.new_string('WC_Widget_Product_Tag_Cloud->topic_count_text')])
	return this.topic_count_text(var_count.clone())
}

struct Class_WC_Widget {
	rt.PhpObjectBase
}

fn create_wc_widget_product_tag_cloud() &Class_WC_Widget_Product_Tag_Cloud {
	mut obj := &Class_WC_Widget_Product_Tag_Cloud{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn create_wc_widget(_args ...rt.PhpVal) &Class_WC_Widget {
	mut obj := &Class_WC_Widget{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'get_current_taxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_current_taxonomy(dispatch_arg_0))
		}
		'topic_count_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.topic_count_text(dispatch_arg_0)
		}
		'_get_current_taxonomy' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._get_current_taxonomy(dispatch_arg_0)
		}
		'_topic_count_text' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this._topic_count_text(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Widget_Product_Tag_Cloud) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget_Product_Tag_Cloud) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_WC_Widget) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Widget) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Widget) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
}

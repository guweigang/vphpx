import rt

struct Class_WP_Widget_Factory {
	rt.PhpObjectBase
pub mut:
	widgets rt.PhpVal = rt.new_array()
}

fn (mut this Class_WP_Widget_Factory) construct() {
	rt.call_function('add_action', [rt.new_string('widgets_init'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WP_Widget_Factory', []string{}, &this) },
			rt.ArrayItem{ key: none, val: '_register_widgets' },
		]),
		rt.new_int(100)])
}

fn (mut this Class_WP_Widget_Factory) wp_widget_factory() {
	rt.call_function('_deprecated_constructor', [rt.new_string('WP_Widget_Factory'),
		rt.new_string('4.3.0')])
	mut iife_temp_0 := Class_WP_Widget_Factory{}
	iife_temp_0.construct()
	rt.new_null()
}

fn (mut this Class_WP_Widget_Factory) register(var_widget rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_widget, 'WP_Widget'))) {
		this.widgets.array_set(rt.call_function('spl_object_hash', [
			var_widget.clone()]), var_widget.clone())
	} else {
		this.widgets.array_set(var_widget, rt.create_object_dynamically(var_widget, []rt.PhpVal{}))
	}
}

fn (mut this Class_WP_Widget_Factory) unregister(var_widget rt.PhpVal) {
	if rt.is_true(rt.new_bool(rt.instance_of(var_widget, 'WP_Widget'))) {
		this.widgets.array_unset(rt.call_function('spl_object_hash', [
			var_widget.clone()]))
	} else {
		this.widgets.array_unset(var_widget)
	}
}

fn (mut this Class_WP_Widget_Factory) _register_widgets() {
	mut var_wp_registered_widgets := rt.new_null()
	mut var_keys := rt.func_array_keys(this.widgets)
	mut var_registered := rt.func_array_keys(var_wp_registered_widgets.clone())
	var_registered = rt.call_function('array_map', [rt.new_string('_get_widget_id_base'),
		var_registered.clone()])
	mut iter_1 := var_keys.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_key := item_1.val
		if rt.is_true(rt.call_function('in_array', [
			rt.get_property(this.widgets.array_get(var_key), 'id_base'),
			var_registered.clone(),
			rt.new_bool(true),
		]))
		{
			this.widgets.array_unset(var_key)
			continue
		}
		rt.call_method(this.widgets.array_get(var_key), '_register', []rt.PhpVal{})
	}
}

fn (mut this Class_WP_Widget_Factory) get_widget_object(var_id_base rt.PhpVal) rt.PhpVal {
	mut var_key := rt.new_string(this.get_widget_key(var_id_base.clone()))
	if rt.is_true(rt.identical(rt.new_string(''), var_key)) {
		return rt.new_null()
	}
	return this.widgets.array_get(var_key)
}

fn (mut this Class_WP_Widget_Factory) get_widget_key(var_id_base rt.PhpVal) string {
	mut iter_2 := this.widgets.iterator()
	for {
		item_2 := iter_2.next() or { break }
		mut var_widget_object := item_2.val
		mut var_key := item_2.key
		if rt.is_true(rt.identical(rt.get_property(var_widget_object, 'id_base'), var_id_base)) {
			return var_key.str()
		}
	}
	return ''
}

fn create_wp_widget_factory() &Class_WP_Widget_Factory {
	mut obj := &Class_WP_Widget_Factory{
		PhpObjectBase: rt.PhpObjectBase{}
		widgets:       rt.new_array()
	}
	obj.construct()
	return obj
}

fn (mut this Class_WP_Widget_Factory) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'WP_Widget_Factory' {
			this.wp_widget_factory()
			return rt.new_null()
		}
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.register(dispatch_arg_0)
			return rt.new_null()
		}
		'unregister' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.unregister(dispatch_arg_0)
			return rt.new_null()
		}
		'_register_widgets' {
			this._register_widgets()
			return rt.new_null()
		}
		'get_widget_object' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_widget_object(dispatch_arg_0)
		}
		'get_widget_key' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_string(this.get_widget_key(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_WP_Widget_Factory) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'widgets' { return this.widgets }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Widget_Factory) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'widgets' {
			this.widgets = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn init_registry() {
	rt.register_class_factory('WP_Widget_Factory', fn (args []rt.PhpVal) rt.PhpVal {
		obj := create_wp_widget_factory()
		return rt.new_object('WP_Widget_Factory', []string{}, obj)
	})
}

fn init() {
	init_registry()
}

fn main() {
	defer {
		rt.shutdown()
	}
}

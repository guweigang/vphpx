import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates {
	rt.PhpObjectBase
pub mut:
	template_prefix    rt.PhpVal = rt.new_string('woocommerce')
	post_types         rt.PhpVal = rt.new_array()
	template_directory rt.PhpVal = rt.new_null()
	templates_registry rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) construct(mut var_templates_registry Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) {
	this.templates_registry = var_templates_registry
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) initialize(mut var_post_types Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_array) {
	this.post_types = var_post_types
	rt.call_function('add_filter', [rt.new_string('theme_templates'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_theme_templates' },
		]),
		rt.new_int(10), rt.new_int(4)])
	rt.call_function('add_filter', [
		rt.new_string('woocommerce_email_editor_register_templates'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'register_templates' },
		]),
	])
	rt.call_method(this.templates_registry, 'initialize', []rt.PhpVal{})
	this.register_post_types_to_api()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) get_block_template(var_template_slug rt.PhpVal) rt.PhpVal {
	mut var_template_id := rt.new_string(
		(rt.call_function('get_stylesheet', []rt.PhpVal{})).str() + '//' + var_template_slug.str())
	return rt.call_function('get_block_template', [var_template_id.clone()])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) register_templates(mut var_templates_registry Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) rt.PhpVal {
	mut var_general_email_slug := rt.new_string('email-general')
	mut var_template_filename := rt.new_string(var_general_email_slug.str() + '.html')
	mut var_general_email := create_automattic_woocommerce_emaileditor_engine_templates_template(this.template_prefix,
		var_general_email_slug.clone(), rt.call_function('__', [
		rt.new_string('General Email'),
		rt.new_string('woocommerce'),
	]), rt.call_function('__', [rt.new_string('A general template for emails.'),
		rt.new_string('woocommerce')]), (rt.call_function('file_get_contents', [
		rt.new_string((this.template_directory).str() + var_template_filename.str()),
	])).str(), this.post_types)
	var_templates_registry.register(rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Template',
		[]string{}, var_general_email))
	return rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry',
		[]string{}, var_templates_registry)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) register_post_types_to_api() {
	mut var_controller :=
		create_automattic_woocommerce_emaileditor_engine_templates_wp_rest_templates_controller(rt.new_string('wp_template'))
	mut var_schema := var_controller.get_item_schema()
	mut var_post_types_context := if !(var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('post_types')).array_get(rt.new_string('context'))).is_null() {
		var_schema.array_get(rt.new_string('properties')).array_get(rt.new_string('post_types')).array_get(rt.new_string('context'))
	} else {
		rt.new_array()
	}
	if rt.is_true(rt.call_function('in_array', [rt.new_string('view'),
		var_post_types_context.clone(), rt.new_bool(true)]))
	{
		return
	}
	mut iife_temp_0 := Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{}
	mut iife_result_0 := iife_temp_0.string()
	rt.call_function('register_rest_field', [rt.new_string('wp_template'),
		rt.new_string('post_types'),
		rt.create_array([
			rt.ArrayItem{ key: 'get_callback', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates',
					[]string{}, &this) },
				rt.ArrayItem{ key: none, val: 'get_post_types' },
			]) },
			rt.ArrayItem{ key: 'update_callback', val: rt.new_null() },
			rt.ArrayItem{ key: 'schema', val: rt.call_method(iife_result_0, 'to_array',
				[]rt.PhpVal{}) },
		])])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) get_post_types(var_response_object rt.PhpVal) rt.PhpVal {
	mut var_template := rt.call_method(this.templates_registry, 'get_by_slug', [if !(var_response_object.array_get(rt.new_string('slug'))).is_null() {
		var_response_object.array_get(rt.new_string('slug'))
	} else {
		rt.new_string('')
	}])
	if rt.is_true(var_template) {
		return rt.call_method(var_template, 'get_post_types', []rt.PhpVal{})
	}
	return if !(var_response_object.array_get(rt.new_string('post_types'))).is_null() {
		var_response_object.array_get(rt.new_string('post_types'))
	} else {
		rt.new_array()
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) add_theme_templates(var_templates rt.PhpVal, var_theme rt.PhpVal, var_post rt.PhpVal, var_post_type rt.PhpVal) rt.PhpVal {
	mut var_templates_mutated := var_templates
	if rt.is_true(var_post_type)
		&& rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.clone(), this.post_types, rt.new_bool(true)]))))) {
		return var_templates_mutated.clone()
	}
	mut var_block_templates := rt.call_function('get_block_templates', []rt.PhpVal{})
	closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_template, 'get_slug', []rt.PhpVal{})
	}
	closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
		mut var_template := if args.len > 0 { args[0].clone() } else { rt.new_null() }
		return rt.call_method(var_template, 'get_slug', []rt.PhpVal{})
	}
	mut var_email_templates_slugs := rt.call_function('array_map', [
		rt.new_closure(closure_2_fn),
		rt.call_method(this.templates_registry, 'get_all', []rt.PhpVal{}),
	])
	mut iter_1 := var_block_templates.iterator()
	for {
		item_1 := iter_1.next() or { break }
		mut var_block_template := item_1.val
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [
			rt.get_property(var_block_template, 'slug'),
			var_email_templates_slugs.clone(),
			rt.new_bool(true),
		])))))
		{
			continue
		}
		if var_templates_mutated.array_isset(rt.get_property(var_block_template, 'slug')) {
			continue
		}
		var_templates_mutated.array_set(rt.get_property(var_block_template, 'slug'), rt.get_property(var_block_template,
			'title'))
	}
	return var_templates_mutated.clone()
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_REST_Templates_Controller {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_templates_templates(arg_0 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates{
		PhpObjectBase:      rt.PhpObjectBase{}
		template_prefix:    rt.new_string('woocommerce')
		post_types:         rt.new_array()
		template_directory: rt.new_null()
		templates_registry: rt.new_null()
	}
	obj.construct(arg_0)
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_templates_template(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_templates_wp_rest_templates_controller(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_REST_Templates_Controller {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_REST_Templates_Controller{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_validator_builder(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.construct(mut dispatch_arg_0)
			return rt.new_null()
		}
		'initialize' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.initialize(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_block_template' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_block_template(dispatch_arg_0)
		}
		'register_templates' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			return this.register_templates(mut dispatch_arg_0)
		}
		'register_post_types_to_api' {
			this.register_post_types_to_api()
			return rt.new_null()
		}
		'get_post_types' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_post_types(dispatch_arg_0)
		}
		'add_theme_templates' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return this.add_theme_templates(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_prefix' { return this.template_prefix }
		'post_types' { return this.post_types }
		'template_directory' { return this.template_directory }
		'templates_registry' { return this.templates_registry }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'template_prefix' {
			this.template_prefix = val
			return true
		}
		'post_types' {
			this.post_types = val
			return true
		}
		'template_directory' {
			this.template_directory = val
			return true
		}
		'templates_registry' {
			this.templates_registry = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_REST_Templates_Controller) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_REST_Templates_Controller) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_REST_Templates_Controller) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Validator_Builder) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

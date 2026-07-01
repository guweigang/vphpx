import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry {
	rt.PhpObjectBase
pub mut:
	templates rt.PhpVal = rt.new_array()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) initialize() {
	rt.call_function('apply_filters', [
		rt.new_string('woocommerce_email_editor_register_templates'),
		rt.new_object('Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry',
			[]string{}, &this),
	])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) register(mut var_template Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_method(fn () rt.PhpVal {
		mut temp :=
			Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_Block_Templates_Registry{}
		return temp.get_instance()
	}(), 'is_registered', [var_template.get_name()])))))
	{
		mut var_result := rt.call_function('register_block_template', [
			var_template.get_name(),
			rt.create_array([
				rt.ArrayItem{ key: 'title', val: var_template.get_title() },
				rt.ArrayItem{ key: 'description', val: var_template.get_description() },
				rt.ArrayItem{ key: 'content', val: var_template.get_content() },
				rt.ArrayItem{ key: 'post_types', val: var_template.get_post_types() },
			])])
		this.templates.array_set(var_template.get_name(), var_template.dup())
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) get_by_name(name string) rt.PhpVal {
	return if !(this.templates.array_get(name)).is_null() {
		this.templates.array_get(name)
	} else {
		rt.new_null()
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) get_by_slug(slug string) rt.PhpVal {
	{
		mut iter_1 := this.templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			if rt.is_true(rt.identical(rt.call_method(var_template, 'get_slug', []rt.PhpVal{}),
				rt.new_string(slug)))
			{
				return var_template.dup()
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) get_all() rt.PhpVal {
	return this.templates
}

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_Block_Templates_Registry {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_emaileditor_engine_templates_templates_registry() &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		templates:     rt.new_array()
	}
	return obj
}

fn create_automattic_woocommerce_emaileditor_engine_templates_wp_block_templates_registry() &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_Block_Templates_Registry {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_Block_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'initialize' {
			this.initialize()
			return rt.new_null()
		}
		'register' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			this.register(mut dispatch_arg_0)
			return rt.new_null()
		}
		'get_by_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_by_name(dispatch_arg_0)
		}
		'get_by_slug' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.get_by_slug(dispatch_arg_0)
		}
		'get_all' {
			return this.get_all()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'templates' { return this.templates }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Templates_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'templates' {
			this.templates = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_Block_Templates_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_Block_Templates_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_WP_Block_Templates_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_templates_class_templates_registry_php() {
	// unsupported statement: Stmt_Declare
}

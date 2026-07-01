import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.to_css_variable_name(value string) string {
	return '--wp--' +(rt.call_function('str_replace', [rt.new_string('|'), rt.new_string('--'), rt.call_function('str_replace', [rt.new_string('var:'), rt.new_string(''), rt.new_string(value)])])).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.is_preset_reference(value string) bool {
	return (rt.identical(rt.call_function('strpos', [rt.new_string(value),
		rt.new_string('var:preset|')]), rt.new_int(0))).to_bool()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.resolve(value string, mut var_variables_map Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array) string {
	if rt.is_true(rt.new_bool(!rt.is_true(var_variables_map)
		|| rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.is_preset_reference(value)))))))
	{
		return value
	}
	mut var_css_var_name :=
		Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.to_css_variable_name(value)
	return (if !(var_variables_map.array_get(var_css_var_name)).is_null() {
		var_variables_map.array_get(var_css_var_name)
	} else {
		rt.new_string(value)
	}).str()
}

fn Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.to_css_var(value string) string {
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.is_preset_reference(value))))) {
		return value
	}
	return 'var(' +
		(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.to_css_variable_name(value)).str() + ')'
}

fn create_automattic_woocommerce_emaileditor_engine_renderer_contentrenderer_preset_variable_resolver() &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'to_css_variable_name' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.to_css_variable_name(dispatch_arg_0))
		}
		'is_preset_reference' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.is_preset_reference(dispatch_arg_0))
		}
		'resolve' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_array](if args.len > 1 {
				args[1]
			} else {
				rt.new_null()
			})
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.resolve(dispatch_arg_0, mut
				dispatch_arg_1))
		}
		'to_css_var' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_string(Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver.to_css_var(dispatch_arg_0))
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Renderer_ContentRenderer_Preset_Variable_Resolver) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_renderer_contentrenderer_class_preset_variable_resolver_php() {
	// unsupported statement: Stmt_Declare
}

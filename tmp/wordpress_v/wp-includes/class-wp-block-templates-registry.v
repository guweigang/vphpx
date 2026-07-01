import rt

struct Class_WP_Block_Templates_Registry {
	rt.PhpObjectBase
pub mut:
		registered_templates rt.PhpVal = rt.new_array()
		instance rt.PhpVal = rt.new_null()
}

fn (mut this Class_WP_Block_Templates_Registry) register(var_template_name rt.PhpVal, var_args rt.PhpVal) rt.PhpVal {
	mut var_plugin := rt.new_null()
	mut var_slug := rt.new_null()
	mut var_template := rt.new_null()
	mut var_error_message := rt.new_string(rt.new_string(''))
	mut var_error_code := rt.new_string(rt.new_string(''))
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_template_name.dup().is_string()))))) {
		var_error_message = rt.call_function('__', [rt.new_string('Template names must be strings.')])
		var_error_code = rt.new_string(rt.new_string('template_name_no_string'))
	} else if rt.is_true(rt.call_function('preg_match', [rt.new_string('/[A-Z]+/'), var_template_name.dup()])) {
		var_error_message = rt.call_function('__', [rt.new_string('Template names must not contain uppercase characters.')])
		var_error_code = rt.new_string(rt.new_string('template_name_no_uppercase'))
	} else if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('preg_match', [rt.new_string('/^[a-z0-9_\\-]+\\/\\/[a-z0-9_\\-]+$/'), var_template_name.dup()]))))) {
		var_error_message = rt.call_function('__', [rt.new_string('Template names must contain a namespace prefix. Example: my-plugin//my-custom-template')])
		var_error_code = rt.new_string(rt.new_string('template_no_prefix'))
	} else if rt.is_true(this.is_registered(var_template_name.dup())) {
		var_error_message = rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Template "%s" is already registered.')]), var_template_name.dup()])
		var_error_code = rt.new_string(rt.new_string('template_already_registered'))
	}
	if rt.is_true(var_error_message) {
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_error_message.dup(), rt.new_string('6.7.0')])
		return create_wp_error(var_error_code.dup(), var_error_message.dup())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(var_template)))) {
		mut var_theme_name := rt.call_function('get_stylesheet', []rt.PhpVal{})
		// unsupported assign target: Expr_List
		mut var_default_template_types := rt.call_function('get_default_block_template_types', []rt.PhpVal{})
		var_template = create_wp_block_template()
		rt.set_property(var_template, 'id', (var_theme_name).str() + '//' + (var_slug).str())
		rt.set_property(var_template, 'theme', var_theme_name.dup())
		rt.set_property(var_template, 'plugin', var_plugin.dup())
		rt.set_property(var_template, 'author', rt.new_null())
		rt.set_property(var_template, 'content', if !(var_args.array_get('content')).is_null() { var_args.array_get('content') } else { rt.new_string('') })
		rt.set_property(var_template, 'source', rt.new_string('plugin'))
		rt.set_property(var_template, 'slug', var_slug.dup())
		rt.set_property(var_template, 'type', rt.new_string('wp_template'))
		rt.set_property(var_template, 'title', if !(var_args.array_get('title')).is_null() { var_args.array_get('title') } else { var_template_name })
		rt.set_property(var_template, 'description', if !(var_args.array_get('description')).is_null() { var_args.array_get('description') } else { rt.new_string('') })
		rt.set_property(var_template, 'status', rt.new_string('publish'))
		rt.set_property(var_template, 'origin', rt.new_string('plugin'))
		rt.set_property(var_template, 'is_custom', rt.new_bool(!(var_default_template_types.array_isset(var_template_name))))
		rt.set_property(var_template, 'post_types', if !(var_args.array_get('post_types')).is_null() { var_args.array_get('post_types') } else { rt.new_array() })
	}
	this.registered_templates.array_set(var_template_name, var_template.dup())
	return var_template.dup()
}

fn (mut this Class_WP_Block_Templates_Registry) get_all_registered() rt.PhpVal {
	return this.registered_templates
}

fn (mut this Class_WP_Block_Templates_Registry) get_registered(var_template_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_template_name.dup()))))) {
		return rt.new_null()
	}
	return this.registered_templates.array_get(var_template_name)
}

fn (mut this Class_WP_Block_Templates_Registry) get_by_slug(var_template_slug rt.PhpVal) rt.PhpVal {
	mut var_all_templates := this.get_all_registered()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_all_templates)))) {
		return rt.new_null()
	}
	{
		mut iter_1 := var_all_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			if rt.is_true(rt.identical(rt.get_property(var_template, 'slug'), var_template_slug)) {
				return var_template.dup()
			}
		}
	}
	return rt.new_null()
}

fn (mut this Class_WP_Block_Templates_Registry) get_by_query(var_query rt.PhpVal) rt.PhpVal {
	mut var_query_mutated := var_query
	mut var_all_templates := this.get_all_registered()
	if rt.is_true(rt.new_bool(!(rt.is_true(var_all_templates)))) {
		return rt.new_array()
	}
	var_query_mutated = rt.call_function('wp_parse_args', [var_query_mutated.dup(), rt.create_array([rt.ArrayItem{ key: 'slug__in', val: rt.new_array() }, rt.ArrayItem{ key: 'slug__not_in', val: rt.new_array() }, rt.ArrayItem{ key: 'post_type', val: '' }])])
	mut var_slugs_to_include := var_query_mutated.array_get('slug__in')
	mut var_slugs_to_skip := var_query_mutated.array_get('slug__not_in')
	mut var_post_type := var_query_mutated.array_get('post_type')
	mut var_matching_templates := rt.new_array()
	{
		mut iter_1 := var_all_templates.iterator()
		for {
			item_1 := iter_1.next() or { break }
			mut var_template := item_1.val
			mut var_template_name := item_1.key
			if rt.is_true(rt.new_bool(rt.is_true(var_slugs_to_include) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_template, 'slug'), var_slugs_to_include.dup(), rt.new_bool(true)]))))))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_slugs_to_skip) && rt.is_true(rt.call_function('in_array', [rt.get_property(var_template, 'slug'), var_slugs_to_skip.dup(), rt.new_bool(true)])))) {
				continue
			}
			if rt.is_true(rt.new_bool(rt.is_true(var_post_type) && rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [var_post_type.dup(), rt.get_property(var_template, 'post_types'), rt.new_bool(true)]))))))) {
				continue
			}
			var_matching_templates.array_set(var_template_name, var_template.dup())
		}
	}
	return var_matching_templates.dup()
}

fn (mut this Class_WP_Block_Templates_Registry) is_registered(var_template_name rt.PhpVal) rt.PhpVal {
	return rt.new_bool(!(var_template_name).is_null() && this.registered_templates.array_isset(var_template_name))
}

fn (mut this Class_WP_Block_Templates_Registry) unregister(var_template_name rt.PhpVal) rt.PhpVal {
	if rt.is_true(rt.new_bool(!(rt.is_true(this.is_registered(var_template_name.dup()))))) {
		mut var_error_message := rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Template "%s" is not registered.')]), var_template_name.dup()])
		rt.call_function('_doing_it_wrong', [rt.new_string(@METHOD), var_error_message.dup(), rt.new_string('6.7.0')])
		return create_wp_error(rt.new_string('template_not_registered'), var_error_message.dup())
	}
	mut var_unregistered_template := this.registered_templates.array_get(var_template_name)
	this.registered_templates.array_unset(var_template_name)
	return var_unregistered_template.dup()
}

fn Class_WP_Block_Templates_Registry.get_instance() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), // unsupported expression: Expr_StaticPropertyFetch)) {
		// unsupported assign target: Expr_StaticPropertyFetch
	}
	return // unsupported expression: Expr_StaticPropertyFetch
}

struct Class_WP_Error {
	rt.PhpObjectBase
}

struct Class_WP_Block_Template {
	rt.PhpObjectBase
}

fn create_wp_block_templates_registry() &Class_WP_Block_Templates_Registry {
	mut obj := &Class_WP_Block_Templates_Registry{
		PhpObjectBase: rt.PhpObjectBase{}
		registered_templates: rt.new_array()
		instance: rt.new_null()
	}
	return obj
}

fn create_wp_error() &Class_WP_Error {
	mut obj := &Class_WP_Error{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_wp_block_template() &Class_WP_Block_Template {
	mut obj := &Class_WP_Block_Template{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WP_Block_Templates_Registry) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'register' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return this.register(dispatch_arg_0, dispatch_arg_1)
		}
		'get_all_registered' {
			return this.get_all_registered()
		}
		'get_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_registered(dispatch_arg_0)
		}
		'get_by_slug' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_by_slug(dispatch_arg_0)
		}
		'get_by_query' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.get_by_query(dispatch_arg_0)
		}
		'is_registered' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.is_registered(dispatch_arg_0)
		}
		'unregister' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.unregister(dispatch_arg_0)
		}
		'get_instance' {
			return Class_WP_Block_Templates_Registry.get_instance()
		}
		else { return none }
	}
}

fn (this &Class_WP_Block_Templates_Registry) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'registered_templates' { return this.registered_templates }
		'instance' { return this.instance }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Templates_Registry) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'registered_templates' { this.registered_templates = val; return true }
		'instance' { this.instance = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
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


fn (mut this Class_WP_Block_Template) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Template) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WP_Block_Template) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_class_wp_block_templates_registry_php() {
}

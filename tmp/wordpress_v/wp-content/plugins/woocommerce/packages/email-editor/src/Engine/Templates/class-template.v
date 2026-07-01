import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template {
	rt.PhpObjectBase
pub mut:
	plugin_uri  string
	slug        string
	name        string
	title       string
	description string
	content     string
	post_types  rt.PhpVal = rt.new_null()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) construct(plugin_uri string, slug string, title string, description string, content string, mut var_post_types Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_array) {
	this.plugin_uri = plugin_uri
	this.slug = slug
	this.name = '${var_plugin_uri}//${var_slug}'
	this.title = title
	this.description = description
	this.content = content
	this.post_types = var_post_types.dup()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) get_pluginuri() string {
	return this.plugin_uri
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) get_slug() string {
	return this.slug
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) get_name() string {
	return this.name
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) get_title() string {
	return this.title
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) get_description() string {
	return this.description
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) get_content() string {
	return this.content
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) get_post_types() rt.PhpVal {
	return this.post_types
}

fn create_automattic_woocommerce_emaileditor_engine_templates_template(plugin_uri string, slug string, title string, description string, content string, arg_5 rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template{
		PhpObjectBase: rt.PhpObjectBase{}
		plugin_uri:    ''
		slug:          ''
		name:          ''
		title:         ''
		description:   ''
		content:       ''
		post_types:    rt.new_null()
	}
	obj.construct(plugin_uri, slug, title, description, content, arg_5)
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).str()
			dispatch_arg_4 := (if args.len > 4 { args[4] } else { rt.new_null() }).str()
			mut dispatch_arg_5 := rt.cast_object_ptr[Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_array](if args.len > 5 {
				args[5]
			} else {
				rt.new_null()
			})
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3,
				dispatch_arg_4, mut dispatch_arg_5)
			return rt.new_null()
		}
		'get_pluginuri' {
			return rt.new_string(this.get_pluginuri())
		}
		'get_slug' {
			return rt.new_string(this.get_slug())
		}
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'get_post_types' {
			return this.get_post_types()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'plugin_uri' { return rt.new_string(this.plugin_uri) }
		'slug' { return rt.new_string(this.slug) }
		'name' { return rt.new_string(this.name) }
		'title' { return rt.new_string(this.title) }
		'description' { return rt.new_string(this.description) }
		'content' { return rt.new_string(this.content) }
		'post_types' { return this.post_types }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Templates_Template) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'plugin_uri' {
			this.plugin_uri = val.str()
			return true
		}
		'slug' {
			this.slug = val.str()
			return true
		}
		'name' {
			this.name = val.str()
			return true
		}
		'title' {
			this.title = val.str()
			return true
		}
		'description' {
			this.description = val.str()
			return true
		}
		'content' {
			this.content = val.str()
			return true
		}
		'post_types' {
			this.post_types = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_content_plugins_woocommerce_packages_email_editor_src_engine_templates_class_template_php() {
	// unsupported statement: Stmt_Declare
}

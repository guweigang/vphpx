import rt

struct Class_WP_Block_Template {
	rt.PhpObjectBase
pub mut:
	prop_type      rt.PhpVal = rt.new_null()
	theme          rt.PhpVal = rt.new_null()
	slug           rt.PhpVal = rt.new_null()
	id             rt.PhpVal = rt.new_null()
	title          rt.PhpVal = rt.new_string('')
	content        rt.PhpVal = rt.new_string('')
	description    rt.PhpVal = rt.new_string('')
	source         rt.PhpVal = rt.new_string('theme')
	origin         rt.PhpVal = rt.new_null()
	wp_id          rt.PhpVal = rt.new_null()
	status         rt.PhpVal = rt.new_null()
	has_theme_file rt.PhpVal = rt.new_null()
	is_custom      rt.PhpVal = rt.new_bool(true)
	author         rt.PhpVal = rt.new_null()
	plugin         rt.PhpVal = rt.new_null()
	post_types     rt.PhpVal = rt.new_null()
	area           rt.PhpVal = rt.new_null()
	modified       rt.PhpVal = rt.new_null()
}

fn create_wp_block_template() &Class_WP_Block_Template {
	mut obj := &Class_WP_Block_Template{
		PhpObjectBase:  rt.PhpObjectBase{}
		prop_type:      rt.new_null()
		theme:          rt.new_null()
		slug:           rt.new_null()
		id:             rt.new_null()
		title:          rt.new_string('')
		content:        rt.new_string('')
		description:    rt.new_string('')
		source:         rt.new_string('theme')
		origin:         rt.new_null()
		wp_id:          rt.new_null()
		status:         rt.new_null()
		has_theme_file: rt.new_null()
		is_custom:      rt.new_bool(true)
		author:         rt.new_null()
		plugin:         rt.new_null()
		post_types:     rt.new_null()
		area:           rt.new_null()
		modified:       rt.new_null()
	}
	return obj
}

fn (mut this Class_WP_Block_Template) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WP_Block_Template) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'type' { return this.prop_type }
		'theme' { return this.theme }
		'slug' { return this.slug }
		'id' { return this.id }
		'title' { return this.title }
		'content' { return this.content }
		'description' { return this.description }
		'source' { return this.source }
		'origin' { return this.origin }
		'wp_id' { return this.wp_id }
		'status' { return this.status }
		'has_theme_file' { return this.has_theme_file }
		'is_custom' { return this.is_custom }
		'author' { return this.author }
		'plugin' { return this.plugin }
		'post_types' { return this.post_types }
		'area' { return this.area }
		'modified' { return this.modified }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WP_Block_Template) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'type' {
			this.prop_type = val
			return true
		}
		'theme' {
			this.theme = val
			return true
		}
		'slug' {
			this.slug = val
			return true
		}
		'id' {
			this.id = val
			return true
		}
		'title' {
			this.title = val
			return true
		}
		'content' {
			this.content = val
			return true
		}
		'description' {
			this.description = val
			return true
		}
		'source' {
			this.source = val
			return true
		}
		'origin' {
			this.origin = val
			return true
		}
		'wp_id' {
			this.wp_id = val
			return true
		}
		'status' {
			this.status = val
			return true
		}
		'has_theme_file' {
			this.has_theme_file = val
			return true
		}
		'is_custom' {
			this.is_custom = val
			return true
		}
		'author' {
			this.author = val
			return true
		}
		'plugin' {
			this.plugin = val
			return true
		}
		'post_types' {
			this.post_types = val
			return true
		}
		'area' {
			this.area = val
			return true
		}
		'modified' {
			this.modified = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

pub fn init_wp_includes_class_wp_block_template_php() {
}

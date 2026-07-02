import rt

struct Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern {
	rt.PhpObjectBase
pub mut:
	name           rt.PhpVal = rt.new_string('')
	namespace      rt.PhpVal = rt.new_string('')
	block_types    rt.PhpVal = rt.new_array()
	template_types rt.PhpVal = rt.new_array()
	post_types     rt.PhpVal = rt.new_array()
	inserter       rt.PhpVal = rt.new_bool(true)
	source         rt.PhpVal = rt.new_string('plugin')
	categories     rt.PhpVal = rt.new_array()
	viewport_width rt.PhpVal = rt.new_int(620)
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) get_name() string {
	return (this.name).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) get_namespace() string {
	return (this.namespace).str()
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) get_properties() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'title', val: this.get_title() },
		rt.ArrayItem{ key: 'content', val: this.get_content() },
		rt.ArrayItem{ key: 'description', val: this.get_description() },
		rt.ArrayItem{ key: 'categories', val: this.categories },
		rt.ArrayItem{ key: 'inserter', val: this.inserter }, rt.ArrayItem{
			key: 'blockTypes'
			val: this.block_types
		}, rt.ArrayItem{ key: 'templateTypes', val: this.template_types },
		rt.ArrayItem{ key: 'postTypes', val: this.post_types },
		rt.ArrayItem{ key: 'source', val: this.source }, rt.ArrayItem{
			key: 'viewportWidth'
			val: this.viewport_width
		}])
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) get_content() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) get_title() string {
	return ''
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) get_description() string {
	return ''
}

fn create_automattic_woocommerce_emaileditor_engine_patterns_abstract_pattern(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern {
	mut obj := &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern{
		PhpObjectBase:  rt.PhpObjectBase{}
		name:           rt.new_string('')
		namespace:      rt.new_string('')
		block_types:    rt.new_array()
		template_types: rt.new_array()
		post_types:     rt.new_array()
		inserter:       rt.new_bool(true)
		source:         rt.new_string('plugin')
		categories:     rt.new_array()
		viewport_width: rt.new_int(620)
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'get_name' {
			return rt.new_string(this.get_name())
		}
		'get_namespace' {
			return rt.new_string(this.get_namespace())
		}
		'get_properties' {
			return this.get_properties()
		}
		'get_content' {
			return rt.new_string(this.get_content())
		}
		'get_title' {
			return rt.new_string(this.get_title())
		}
		'get_description' {
			return rt.new_string(this.get_description())
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'name' { return this.name }
		'namespace' { return this.namespace }
		'block_types' { return this.block_types }
		'template_types' { return this.template_types }
		'post_types' { return this.post_types }
		'inserter' { return this.inserter }
		'source' { return this.source }
		'categories' { return this.categories }
		'viewport_width' { return this.viewport_width }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_EmailEditor_Engine_Patterns_Abstract_Pattern) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'name' {
			this.name = val
			return true
		}
		'namespace' {
			this.namespace = val
			return true
		}
		'block_types' {
			this.block_types = val
			return true
		}
		'template_types' {
			this.template_types = val
			return true
		}
		'post_types' {
			this.post_types = val
			return true
		}
		'inserter' {
			this.inserter = val
			return true
		}
		'source' {
			this.source = val
			return true
		}
		'categories' {
			this.categories = val
			return true
		}
		'viewport_width' {
			this.viewport_width = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate.slug() string {
	return ''
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	rt.PhpObjectBase
pub mut:
	is_taxonomy_template rt.PhpVal = rt.new_bool(false)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) init() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) get_template_title() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) get_template_description() {
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate{
		PhpObjectBase:        rt.PhpObjectBase{}
		is_taxonomy_template: rt.new_bool(false)
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_template_title' {
			this.get_template_title()
			return rt.new_null()
		}
		'get_template_description' {
			this.get_template_description()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'is_taxonomy_template' { return this.is_taxonomy_template }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'is_taxonomy_template' {
			this.is_taxonomy_template = val
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

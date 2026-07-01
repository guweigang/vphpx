import rt

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	rt.PhpObjectBase
pub mut:
	template_area rt.PhpVal = rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatepart() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart{
		PhpObjectBase: rt.PhpObjectBase{}
		template_area: rt.new_null()
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplate() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_area' { return this.template_area }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'template_area' {
			this.template_area = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_abstracttemplatepart_php() {
}

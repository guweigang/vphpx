import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate.slug() string {
	return 'coming-soon-social-links'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate {
	rt.PhpObjectBase
pub mut:
	template_area rt.PhpVal = rt.new_string('uncategorized')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate) init() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Coming soon social links'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Reusable template part for displaying social links on the coming soon page.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate) get_placeholder_page() rt.PhpVal {
	return rt.new_null()
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_comingsoonsociallinkstemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
		template_area: rt.new_string('uncategorized')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatepart(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'init' {
			this.init()
			return rt.new_null()
		}
		'get_template_title' {
			return this.get_template_title()
		}
		'get_template_description' {
			return this.get_template_description()
		}
		'get_placeholder_page' {
			return this.get_placeholder_page()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_area' { return this.template_area }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_ComingSoonSocialLinksTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate.slug() string {
	return 'grouped-product-add-to-cart-with-options'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate {
	rt.PhpObjectBase
pub mut:
	template_area rt.PhpVal = rt.new_string('add-to-cart-with-options')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) init() {
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [
		rt.new_string('Grouped Product Add to Cart + Options'),
		rt.new_string('Template name'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Template used to display the Add to Cart + Options form for Grouped Products.'),
		rt.new_string('woocommerce'),
	])
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_groupedproductaddtocartwithoptionstemplate() &Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
		template_area: rt.new_string('add-to-cart-with-options')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatepart() &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_area' { return this.template_area }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_GroupedProductAddToCartWithOptionsTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

pub fn init_wp_content_plugins_woocommerce_src_blocks_templates_groupedproductaddtocartwithoptionstemplate_php() {
	// unsupported statement: Stmt_Declare
}

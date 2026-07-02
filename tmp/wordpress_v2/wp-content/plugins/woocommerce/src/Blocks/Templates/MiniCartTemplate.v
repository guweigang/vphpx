import rt

pub fn Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate.slug() string {
	return 'mini-cart'
}

struct Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate {
	rt.PhpObjectBase
pub mut:
	template_area rt.PhpVal = rt.new_string('mini-cart')
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) init() {
	rt.call_function('add_filter', [rt.new_string('default_wp_template_part_areas'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate', [
				'Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart',
			], &this) },
			rt.ArrayItem{ key: none, val: 'register_mini_cart_template_part_area' },
		]),
		rt.new_int(10), rt.new_int(1)])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) get_template_title() rt.PhpVal {
	return rt.call_function('_x', [rt.new_string('Mini-Cart'),
		rt.new_string('Template name'), rt.new_string('woocommerce')])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) get_template_description() rt.PhpVal {
	return rt.call_function('__', [
		rt.new_string('Template used to display the Mini-Cart drawer.'),
		rt.new_string('woocommerce'),
	])
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) register_mini_cart_template_part_area(var_default_area_definitions rt.PhpVal) rt.PhpVal {
	mut var_mini_cart_template_part_area := rt.create_array([
		rt.ArrayItem{ key: 'area', val: 'mini-cart' },
		rt.ArrayItem{ key: 'label', val: rt.call_function('__', [
			rt.new_string('Mini-Cart'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'description', val: rt.call_function('__', [
			rt.new_string('The Mini-Cart template allows shoppers to see their cart items and provides access to the Cart and Checkout pages.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'icon', val: 'mini-cart' },
		rt.ArrayItem{ key: 'area_tag', val: 'mini-cart' },
	])
	return rt.call_function('array_merge', [var_default_area_definitions.clone(),
		rt.create_array([
			rt.ArrayItem{ key: none, val: var_mini_cart_template_part_area },
		])])
}

struct Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_templates_minicarttemplate(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate{
		PhpObjectBase: rt.PhpObjectBase{}
		template_area: rt.new_string('mini-cart')
	}
	return obj
}

fn create_automattic_woocommerce_blocks_templates_abstracttemplatepart(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Templates_AbstractTemplatePart{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
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
		'register_mini_cart_template_part_area' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return this.register_mini_cart_template_part_area(dispatch_arg_0)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'template_area' { return this.template_area }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Templates_MiniCartTemplate) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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

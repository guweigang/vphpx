import rt

struct Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU {
	rt.PhpObjectBase
pub mut:
	setting_name rt.PhpVal = rt.new_string('woocommerce_product_match_featured_image_by_sku')
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU) construct() {
	this.init_hooks()
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU) init_hooks() {
	rt.call_function('add_filter', [rt.new_string('woocommerce_get_settings_products'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU',
				[]string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_product_image_sku_setting' },
		]),
		rt.new_int(110), rt.new_int(2)])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU) is_enabled() rt.PhpVal {
	return rt.call_function('wc_string_to_bool', [
		rt.call_function('get_option', [this.setting_name]),
	])
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU) add_product_image_sku_setting(mut var_settings Class_Automattic_WooCommerce_Internal_ProductImage_array, section_id string) rt.PhpVal {
	mut var_settings_mutated := var_settings
	if rt.is_true(rt.new_bool('advanced' != section_id)) {
		return rt.new_object('Automattic_WooCommerce_Internal_ProductImage_array', []string{},
			var_settings_mutated)
	}
	var_settings_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Product image matching by SKU'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'type', val: 'title' },
	]))
	var_settings_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
			rt.new_string('Match images'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
			rt.new_string('Set product featured image when uploaded image file name matches product SKU.'),
			rt.new_string('woocommerce'),
		]) },
		rt.ArrayItem{ key: 'id', val: this.setting_name },
		rt.ArrayItem{ key: 'default', val: 'no' },
		rt.ArrayItem{ key: 'type', val: 'checkbox' },
		rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
	]))
	var_settings_mutated.array_push(rt.create_array([
		rt.ArrayItem{ key: 'type', val: 'sectionend' },
	]))
	return rt.new_object('Automattic_WooCommerce_Internal_ProductImage_array', []string{},
		var_settings_mutated)
}

fn create_automattic_woocommerce_internal_productimage_matchimagebysku() &Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU {
	mut obj := &Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU{
		PhpObjectBase: rt.PhpObjectBase{}
		setting_name:  rt.new_string('woocommerce_product_match_featured_image_by_sku')
	}
	obj.construct()
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'init_hooks' {
			this.init_hooks()
			return rt.new_null()
		}
		'is_enabled' {
			return this.is_enabled()
		}
		'add_product_image_sku_setting' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_Automattic_WooCommerce_Internal_ProductImage_array](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			return this.add_product_image_sku_setting(mut dispatch_arg_0, dispatch_arg_1)
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'setting_name' { return this.setting_name }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_Automattic_WooCommerce_Internal_ProductImage_MatchImageBySKU) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'setting_name' {
			this.setting_name = val
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

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

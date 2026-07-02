import rt

struct Class_WC_Tax {
	rt.PhpObjectBase
}

fn create_wc_tax(_args ...rt.PhpVal) &Class_WC_Tax {
	mut obj := &Class_WC_Tax{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Tax) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Tax) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Tax) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut iife_temp_0 := Class_WC_Tax{}
	mut iife_result_0 := iife_temp_0.get_tax_classes()
	mut var_settings := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Tax options'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'desc', val: '' },
			rt.ArrayItem{ key: 'id', val: 'tax_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Prices entered with tax'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_prices_include_tax' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'radio' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('This option is important as it will affect how you input prices. If you select "Yes", enter prices including your base location\'s tax rate, the baseline for tax calculations. Changing this option will not update existing products.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'yes', val: rt.call_function('__', [
					rt.new_string('Yes, I will enter prices inclusive of tax'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'no', val: rt.call_function('__', [
					rt.new_string('No, I will enter prices exclusive of tax'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Calculate tax based on'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_tax_based_on' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('This option determines which address is used to calculate tax.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{
				key: 'default'
				val: Class_Automattic_WooCommerce_Enums_TaxBasedOn.shipping()
			},
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_TaxBasedOn.shipping(), val: rt.call_function('__', [
					rt.new_string('Customer shipping address'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_TaxBasedOn.billing(), val: rt.call_function('__', [
					rt.new_string('Customer billing address'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: Class_Automattic_WooCommerce_Enums_TaxBasedOn.base(), val: rt.call_function('__', [
					rt.new_string('Shop base address'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: 'shipping-tax-class', val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Shipping tax class'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Optionally control which tax class shipping gets, or leave it so shipping tax is based on the cart items themselves.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_shipping_tax_class' },
			rt.ArrayItem{ key: 'css', val: 'min-width:150px;' },
			rt.ArrayItem{ key: 'default', val: 'inherit' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.add(rt.create_array([
				rt.ArrayItem{ key: 'inherit', val: rt.call_function('__', [
					rt.new_string('Shipping tax class based on cart items'),
					rt.new_string('woocommerce'),
				]) },
			]), rt.call_function('wc_get_product_tax_class_options', []rt.PhpVal{})) },
			rt.ArrayItem{ key: 'desc_tip', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Rounding'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Round tax at subtotal level, instead of rounding per line'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_tax_round_at_subtotal' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Additional tax classes'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('List additional tax classes you need below (1 per line, e.g. Reduced Rates). These are in addition to "Standard rate" which exists by default.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_tax_classes' },
			rt.ArrayItem{ key: 'css', val: 'height: 65px;' },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'is_option', val: false },
			rt.ArrayItem{ key: 'value', val: rt.call_function('implode', [
				rt.new_string('\n'),
				iife_result_0,
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Display prices in the shop'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_tax_display_shop' },
			rt.ArrayItem{ key: 'default', val: 'excl' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'incl', val: rt.call_function('__', [
					rt.new_string('Including tax'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'excl', val: rt.call_function('__', [
					rt.new_string('Excluding tax'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Display prices during cart and checkout'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_tax_display_cart' },
			rt.ArrayItem{ key: 'default', val: 'excl' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'incl', val: rt.call_function('__', [
					rt.new_string('Including tax'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'excl', val: rt.call_function('__', [
					rt.new_string('Excluding tax'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'conflict_error' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'add_settings_slot' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Price display suffix'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_price_display_suffix' },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'text' },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Define text to show after your product prices. This could be, for example, "inc. Vat" to explain your pricing. You can also have prices substituted here using one of the following: {price_including_tax}, {price_excluding_tax}.'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Display tax totals'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_tax_total_display' },
			rt.ArrayItem{ key: 'default', val: 'itemized' },
			rt.ArrayItem{ key: 'type', val: 'select' },
			rt.ArrayItem{ key: 'class', val: 'wc-enhanced-select' },
			rt.ArrayItem{ key: 'options', val: rt.create_array([
				rt.ArrayItem{ key: 'single', val: rt.call_function('__', [
					rt.new_string('As a single total'),
					rt.new_string('woocommerce'),
				]) },
				rt.ArrayItem{ key: 'itemized', val: rt.call_function('__', [
					rt.new_string('Itemized'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'tax_options' },
		]) },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wc_shipping_enabled', []rt.PhpVal{}))))) {
		var_settings.array_unset(rt.new_string('shipping-tax-class'))
	}
	return rt.call_function('apply_filters', [rt.new_string('woocommerce_tax_settings'),
		var_settings.clone()])
}

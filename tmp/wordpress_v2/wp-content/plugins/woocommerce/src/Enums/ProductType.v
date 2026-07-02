import rt

pub fn Class_Automattic_WooCommerce_Enums_ProductType.simple() string {
	return 'simple'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductType.variable() string {
	return 'variable'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductType.grouped() string {
	return 'grouped'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductType.external() string {
	return 'external'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductType.variation() string {
	return 'variation'
}

struct Class_Automattic_WooCommerce_Enums_ProductType {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_producttype(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_ProductType {
	mut obj := &Class_Automattic_WooCommerce_Enums_ProductType{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductType) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_ProductType) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductType) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

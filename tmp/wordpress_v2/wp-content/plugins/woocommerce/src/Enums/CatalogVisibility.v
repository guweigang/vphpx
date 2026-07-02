import rt

pub fn Class_Automattic_WooCommerce_Enums_CatalogVisibility.visible() string {
	return 'visible'
}

pub fn Class_Automattic_WooCommerce_Enums_CatalogVisibility.catalog() string {
	return 'catalog'
}

pub fn Class_Automattic_WooCommerce_Enums_CatalogVisibility.search() string {
	return 'search'
}

pub fn Class_Automattic_WooCommerce_Enums_CatalogVisibility.hidden() string {
	return 'hidden'
}

struct Class_Automattic_WooCommerce_Enums_CatalogVisibility {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_catalogvisibility(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Enums_CatalogVisibility {
	mut obj := &Class_Automattic_WooCommerce_Enums_CatalogVisibility{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_CatalogVisibility) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_CatalogVisibility) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_CatalogVisibility) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

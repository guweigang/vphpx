import rt

pub fn Class_Automattic_WooCommerce_Enums_ProductStatus.auto_draft() string {
	return 'auto-draft'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStatus.draft() string {
	return 'draft'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStatus.pending() string {
	return 'pending'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStatus.private() string {
	return 'private'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStatus.publish() string {
	return 'publish'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStatus.trash() string {
	return 'trash'
}

pub fn Class_Automattic_WooCommerce_Enums_ProductStatus.future() string {
	return 'future'
}

struct Class_Automattic_WooCommerce_Enums_ProductStatus {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_enums_productstatus() &Class_Automattic_WooCommerce_Enums_ProductStatus {
	mut obj := &Class_Automattic_WooCommerce_Enums_ProductStatus{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductStatus) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Enums_ProductStatus) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Enums_ProductStatus) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

pub fn init_wp_content_plugins_woocommerce_src_enums_productstatus_php() {
	// unsupported statement: Stmt_Declare
}

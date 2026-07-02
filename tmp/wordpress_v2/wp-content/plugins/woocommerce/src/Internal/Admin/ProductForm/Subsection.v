import rt

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Subsection {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_internal_admin_productform_subsection(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Subsection {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Subsection{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_internal_admin_productform_component(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component {
	mut obj := &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Subsection) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Subsection) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Subsection) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Internal_Admin_ProductForm_Component) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

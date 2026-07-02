import rt

struct Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Exception {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_admin_notes_notesunavailableexception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_wc_data_exception(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Exception {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Exception{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_NotesUnavailableException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Exception) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Exception) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_WC_Data_Exception) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

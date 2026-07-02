import rt

pub fn Class_Automattic_WooCommerce_Blocks_InboxNotifications.surface_cart_checkout_note_name() string {
	return 'surface_cart_checkout'
}

struct Class_Automattic_WooCommerce_Blocks_InboxNotifications {
	rt.PhpObjectBase
}

fn Class_Automattic_WooCommerce_Blocks_InboxNotifications.delete_surface_cart_checkout_blocks_notification() {
	mut iife_temp_0 := Class_Automattic_WooCommerce_Admin_Notes_Notes{}
	mut iife_result_0 :=
		iife_temp_0.delete_notes_with_name(Class_Automattic_WooCommerce_Blocks_Automattic_WooCommerce_Blocks_InboxNotifications.surface_cart_checkout_note_name())
}

struct Class_Automattic_WooCommerce_Admin_Notes_Notes {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_blocks_inboxnotifications(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_InboxNotifications {
	mut obj := &Class_Automattic_WooCommerce_Blocks_InboxNotifications{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_admin_notes_notes(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Admin_Notes_Notes {
	mut obj := &Class_Automattic_WooCommerce_Admin_Notes_Notes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Blocks_InboxNotifications) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'delete_surface_cart_checkout_blocks_notification' {
			Class_Automattic_WooCommerce_Blocks_InboxNotifications.delete_surface_cart_checkout_blocks_notification()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_Automattic_WooCommerce_Blocks_InboxNotifications) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_InboxNotifications) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Admin_Notes_Notes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

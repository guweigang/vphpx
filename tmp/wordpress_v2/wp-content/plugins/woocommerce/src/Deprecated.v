import rt

fn main() {
	defer {
		rt.shutdown()
	}

	rt.call_function('class_alias', [
		Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.class(),
		Class_Automattic_WooCommerce_Admin_Features_Navigation_Screen.class(),
	])
	rt.call_function('class_alias', [
		Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.class(),
		Class_Automattic_WooCommerce_Admin_Features_Navigation_Menu.class(),
	])
	rt.call_function('class_alias', [
		Class_Automattic_WooCommerce_Admin_Features_Navigation_RemovedDeprecated.class(),
		Class_Automattic_WooCommerce_Admin_Features_Navigation_CoreMenu.class(),
	])
}

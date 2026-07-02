import rt

struct Class_Automattic_Jetpack_Constants {
	rt.PhpObjectBase
}

fn create_automattic_jetpack_constants(_args ...rt.PhpVal) &Class_Automattic_Jetpack_Constants {
	mut obj := &Class_Automattic_Jetpack_Constants{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_Jetpack_Constants) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_Jetpack_Constants) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut var_pending_actions_url := rt.call_function('admin_url', [
		rt.new_string('admin.php?page=wc-status&tab=action-scheduler&s=wc_update_product_lookup_tables&status=pending'),
	])
	mut iife_temp_0 := Class_Automattic_Jetpack_Constants{}
	mut iife_result_0 := iife_temp_0.is_true(rt.new_string('DISABLE_WP_CRON'))
	mut var_cron_disabled := iife_result_0
	mut var_cron_cta := if rt.is_true(var_cron_disabled) { rt.call_function('__', [
			rt.new_string('You can manually run queued updates here.'),
			rt.new_string('woocommerce'),
		]) } else { rt.call_function('__', [rt.new_string('View progress &rarr;'),
			rt.new_string('woocommerce')]) }
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('WooCommerce is updating product data in the background'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Product display, sorting, and reports may not be accurate until this finishes. It will take a few minutes and this notice will disappear when complete.'),
		rt.new_string('woocommerce'),
	])
	if rt.is_true(var_cron_disabled) {
		print('<br>' +(rt.call_function('esc_html__', [rt.new_string('Note: WP CRON has been disabled on your install which may prevent this update from completing.'), rt.new_string('woocommerce')])).str())
	}
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [var_pending_actions_url.clone()]))
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_html', [var_cron_cta.clone()]))
	// unsupported statement: Stmt_InlineHTML
}

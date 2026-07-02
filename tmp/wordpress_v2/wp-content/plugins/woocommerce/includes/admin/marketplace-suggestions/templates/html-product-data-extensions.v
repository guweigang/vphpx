import rt

struct Class_WC_Marketplace_Suggestions {
	rt.PhpObjectBase
}

fn create_wc_marketplace_suggestions(_args ...rt.PhpVal) &Class_WC_Marketplace_Suggestions {
	mut obj := &Class_WC_Marketplace_Suggestions{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Marketplace_Suggestions) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Marketplace_Suggestions) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('defined', [
		rt.new_string('ABSPATH'),
	])))))
	{
		exit(0)
	}
	// unsupported statement: Stmt_InlineHTML
	mut iife_temp_0 := Class_WC_Marketplace_Suggestions{}
	mut iife_result_0 :=
		iife_temp_0.render_suggestions_container(rt.new_string('product-edit-meta-tab-header'))
	mut iife_temp_1 := Class_WC_Marketplace_Suggestions{}
	mut iife_result_1 :=
		iife_temp_1.render_suggestions_container(rt.new_string('product-edit-meta-tab-body'))
	mut iife_temp_2 := Class_WC_Marketplace_Suggestions{}
	mut iife_result_2 :=
		iife_temp_2.render_suggestions_container(rt.new_string('product-edit-meta-tab-footer'))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Enhance your products'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [
		rt.new_string('Extensions can add new functionality to your product pages that make your store stand out'),
		rt.new_string('woocommerce'),
	])
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Browse the Marketplace'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
	rt.echo_val(rt.call_function('esc_url', [
		rt.call_function('admin_url', [
			rt.new_string('admin.php?page=wc-settings&tab=advanced&section=woocommerce_com'),
		]),
	]))
	// unsupported statement: Stmt_InlineHTML
	rt.call_function('esc_html_e', [rt.new_string('Manage suggestions'),
		rt.new_string('woocommerce')])
	// unsupported statement: Stmt_InlineHTML
}

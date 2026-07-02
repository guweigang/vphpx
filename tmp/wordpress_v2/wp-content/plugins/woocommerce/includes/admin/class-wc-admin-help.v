import rt

struct Class_WC_Admin_Help {
	rt.PhpObjectBase
}

fn (mut this Class_WC_Admin_Help) construct() {
	rt.call_function('add_action', [rt.new_string('current_screen'),
		rt.create_array([
			rt.ArrayItem{ key: none, val: rt.new_object('WC_Admin_Help', []string{}, &this) },
			rt.ArrayItem{ key: none, val: 'add_tabs' },
		]),
		rt.new_int(50)])
}

fn (mut this Class_WC_Admin_Help) add_tabs() {
	mut var_screen := rt.call_function('get_current_screen', []rt.PhpVal{})
	if rt.is_true(rt.new_bool(!(rt.is_true(var_screen))))
		|| rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('in_array', [rt.get_property(var_screen, 'id'), rt.call_function('wc_get_screen_ids', []rt.PhpVal{})]))))) {
		return
	}
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce_support_tab' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Help &amp; Support'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'content', val: '<h2>' +
				(rt.call_function('__', [rt.new_string('Help &amp; Support'), rt.new_string('woocommerce')])).str() +
				'</h2>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('Should you need help understanding, using, or extending WooCommerce, <a href="%s">please read our documentation</a>. You will find all kinds of resources including snippets, tutorials and much more.'), rt.new_string('woocommerce')]), rt.new_string('https://woocommerce.com/documentation/plugins/woocommerce/?utm_source=helptab&utm_medium=product&utm_content=docs&utm_campaign=woocommerceplugin')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('For further assistance with WooCommerce core, use the <a href="%1$s">community forum</a>. For help with premium extensions sold on WooCommerce.com, <a href="%2$s">open a support request at WooCommerce.com</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://wordpress.org/support/plugin/woocommerce'), rt.new_string('https://woocommerce.com/my-account/create-a-ticket/?utm_source=helptab&utm_medium=product&utm_content=tickets&utm_campaign=woocommerceplugin')])).str() +
				'</p>' + '<p>' +
				(rt.call_function('__', [rt.new_string('Before asking for help, we recommend checking the system status page to identify any problems with your configuration.'), rt.new_string('woocommerce')])).str() +
				'</p>' + '<p><a href="' +
				(rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-status')])).str() +
				'" class="button button-primary">' +
				(rt.call_function('__', [rt.new_string('System status'), rt.new_string('woocommerce')])).str() +
				'</a> <a href="https://wordpress.org/support/plugin/woocommerce" class="button">' +
				(rt.call_function('__', [rt.new_string('Community forum'), rt.new_string('woocommerce')])).str() +
				'</a> <a href="https://woocommerce.com/my-account/create-a-ticket/?utm_source=helptab&utm_medium=product&utm_content=tickets&utm_campaign=woocommerceplugin" class="button">' +
				(rt.call_function('__', [rt.new_string('WooCommerce.com support'), rt.new_string('woocommerce')])).str() +
				'</a></p>' }]),
	])
	rt.call_method(var_screen, 'add_help_tab', [
		rt.create_array([rt.ArrayItem{ key: 'id', val: 'woocommerce_bugs_tab' },
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Found a bug?'),
				rt.new_string('woocommerce'),
			]) }, rt.ArrayItem{ key: 'content', val: '<h2>' +
				(rt.call_function('__', [rt.new_string('Found a bug?'), rt.new_string('woocommerce')])).str() +
				'</h2>' + '<p>' +
				(rt.call_function('sprintf', [rt.call_function('__', [rt.new_string('If you find a bug within WooCommerce core you can create a ticket via <a href="%1$s">GitHub issues</a>. Ensure you read the <a href="%2$s">contribution guide</a> prior to submitting your report. To help us solve your issue, please be as descriptive as possible and include your <a href="%3$s">system status report</a>.'), rt.new_string('woocommerce')]), rt.new_string('https://github.com/woocommerce/woocommerce/issues?state=open'), rt.new_string('https://github.com/woocommerce/woocommerce/blob/trunk/.github/CONTRIBUTING.md'), rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-status')])])).str() +
				'</p>' +
				'<p><a href="https://github.com/woocommerce/woocommerce/issues/new?assignees=&labels=&template=1-bug-report.yml" class="button button-primary">' +
				(rt.call_function('__', [rt.new_string('Report a bug'), rt.new_string('woocommerce')])).str() +
				'</a> <a href="' +
				(rt.call_function('admin_url', [rt.new_string('admin.php?page=wc-status')])).str() +
				'" class="button">' +
				(rt.call_function('__', [rt.new_string('System status'), rt.new_string('woocommerce')])).str() +
				'</a></p>' }]),
	])
	rt.call_method(var_screen, 'set_help_sidebar', [
		rt.new_string('<p><strong>' +
			(rt.call_function('__', [rt.new_string('For more information:'), rt.new_string('woocommerce')])).str() +
			'</strong></p>' +
			'<p><a href="https://woocommerce.com/?utm_source=helptab&utm_medium=product&utm_content=about&utm_campaign=woocommerceplugin" target="_blank">' +
			(rt.call_function('__', [rt.new_string('About WooCommerce'), rt.new_string('woocommerce')])).str() +
			'</a></p>' +
			'<p><a href="https://wordpress.org/plugins/woocommerce/" target="_blank">' +
			(rt.call_function('__', [rt.new_string('WordPress.org project'), rt.new_string('woocommerce')])).str() +
			'</a></p>' +
			'<p><a href="https://github.com/woocommerce/woocommerce/" target="_blank">' +
			(rt.call_function('__', [rt.new_string('GitHub project'), rt.new_string('woocommerce')])).str() +
			'</a></p>' +
			'<p><a href="https://woocommerce.com/product-category/themes/?utm_source=helptab&utm_medium=product&utm_content=wcthemes&utm_campaign=woocommerceplugin" target="_blank">' +
			(rt.call_function('__', [rt.new_string('Official themes'), rt.new_string('woocommerce')])).str() +
			'</a></p>' +
			'<p><a href="https://woocommerce.com/product-category/woocommerce-extensions/?utm_source=helptab&utm_medium=product&utm_content=wcextensions&utm_campaign=woocommerceplugin" target="_blank">' +
			(rt.call_function('__', [rt.new_string('Official extensions'), rt.new_string('woocommerce')])).str() +
			'</a></p>'),
	])
}

fn create_wc_admin_help() &Class_WC_Admin_Help {
	mut obj := &Class_WC_Admin_Help{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	obj.construct()
	return obj
}

fn (mut this Class_WC_Admin_Help) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'add_tabs' {
			this.add_tabs()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Admin_Help) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Admin_Help) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
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
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('WC_Admin_Help'),
		rt.new_bool(false)]))
	{
		return rt.new_object('WC_Admin_Help', []string{}, create_wc_admin_help())
	}
	return rt.new_object('WC_Admin_Help', []string{}, create_wc_admin_help())
}

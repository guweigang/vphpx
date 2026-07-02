import rt

struct Class_WC_Settings_Accounts {
	rt.PhpObjectBase
pub mut:
	icon rt.PhpVal = rt.new_string('people')
}

fn (mut this Class_WC_Settings_Accounts) construct() {
	this.dispatch_set_prop('id', rt.new_string('account'))
	this.dispatch_set_prop('label', rt.call_function('__', [
		rt.new_string('Accounts &amp; Privacy'),
		rt.new_string('woocommerce'),
	]))
	this.Class_WC_Settings_Page.construct()
}

fn (mut this Class_WC_Settings_Accounts) get_settings_for_default_section() rt.PhpVal {
	mut var_erasure_text := rt.call_function('esc_html__', [
		rt.new_string('account erasure request'),
		rt.new_string('woocommerce'),
	])
	mut var_privacy_text := rt.call_function('esc_html__', [
		rt.new_string('privacy page'),
		rt.new_string('woocommerce'),
	])
	if rt.is_true(rt.call_function('current_user_can', [
		rt.new_string('manage_privacy_options'),
	]))
	{
		if rt.is_true(rt.call_function('version_compare', [
			rt.call_function('get_bloginfo', [rt.new_string('version')]),
			rt.new_string('5.3'),
			rt.new_string('<'),
		]))
		{
			var_erasure_text = rt.call_function('sprintf', [
				rt.new_string('<a href="%s">%s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [
						rt.new_string('tools.php?page=remove_personal_data'),
					]),
				]),
				var_erasure_text.clone(),
			])
		} else {
			var_erasure_text = rt.call_function('sprintf', [
				rt.new_string('<a href="%s">%s</a>'),
				rt.call_function('esc_url', [
					rt.call_function('admin_url', [
						rt.new_string('erase-personal-data.php'),
					]),
				]),
				var_erasure_text.clone(),
			])
		}
		var_privacy_text = rt.call_function('sprintf', [
			rt.new_string('<a href="%s">%s</a>'),
			rt.call_function('esc_url', [
				rt.call_function('admin_url', [rt.new_string('options-privacy.php')]),
			]),
			var_privacy_text.clone(),
		])
	}
	mut var_account_settings := rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: '' },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'id', val: 'account_registration_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Checkout'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable guest checkout (recommended)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Allows customers to checkout without an account.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_guest_checkout' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Login'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Enable log-in during checkout'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_checkout_login_reminder' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Account creation'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('After checkout (recommended)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Customers can create an account after their order is placed. Customize messaging %1$shere%2$s.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string(
					'<a target="_blank" class="delayed-account-creation-customize-link" href="' +
					(rt.call_function('esc_url', [rt.call_function('admin_url', [rt.new_string('site-editor.php?postId=woocommerce%2Fwoocommerce%2F%2Forder-confirmation&postType=wp_template&canvas=edit')])])).str() +
					'">'),
				rt.new_string('</a>'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_delayed_account_creation' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'disabled-tooltip', val: rt.call_function('__', [
					rt.new_string('Enable guest checkout to use this feature.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
			rt.ArrayItem{ key: 'legend', val: rt.call_function('__', [
				rt.new_string('Allow customers to create an account'),
				rt.new_string('woocommerce'),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Account creation'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('During checkout'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Customers can create an account before placing their order.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_signup_and_login_from_checkout' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: '' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Account creation'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('On "My account" page'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_enable_myaccount_registration' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Account creation options'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Send password setup link (recommended)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('New users receive an email to set up their password.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_registration_generate_password' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'disabled-tooltip', val: rt.call_function('__', [
					rt.new_string('Enable an account creation method to use this feature.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Account creation options'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Generate account login (recommended)'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Generate a login for the account using first and/or last name. If neither is usable (e.g. invalid or missing) the email address will be used. If this option is unchecked, customers will need to set a username during account creation'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_registration_generate_username' },
			rt.ArrayItem{ key: 'default', val: 'yes' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'autoload', val: false },
			rt.ArrayItem{ key: 'custom_attributes', val: rt.create_array([
				rt.ArrayItem{ key: 'disabled-tooltip', val: rt.call_function('__', [
					rt.new_string('Enable an account creation method to use this feature.'),
					rt.new_string('woocommerce'),
				]) },
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Account erasure requests'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Remove personal data from orders on request'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('When handling an %s, should personal data within orders be retained or removed?'),
					rt.new_string('woocommerce'),
				]),
				var_erasure_text.clone(),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_erasure_request_removes_order_data' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'start' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Remove access to downloads on request'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('When handling an %s, should access to downloadable files be revoked and download logs cleared?'),
					rt.new_string('woocommerce'),
				]),
				var_erasure_text.clone(),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_erasure_request_removes_download_data' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'checkboxgroup', val: '' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Personal data removal'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string('Allow personal data to be removed in bulk from orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Adds an option to the orders screen for removing personal data in bulk. Note that removing personal data cannot be undone.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_allow_bulk_remove_personal_data' },
			rt.ArrayItem{ key: 'type', val: 'checkbox' },
			rt.ArrayItem{ key: 'checkboxgroup', val: 'end' },
			rt.ArrayItem{ key: 'default', val: 'no' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'account_registration_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Privacy policy'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'id', val: 'privacy_policy_options' },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('sprintf', [
				rt.call_function('esc_html__', [
					rt.new_string('This section controls the display of your website privacy policy. The privacy notices below will not show up unless a %s is set.'),
					rt.new_string('woocommerce'),
				]),
				var_privacy_text.clone(),
			]) },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Registration privacy policy'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Optionally add some text about your store privacy policy to show on account registration forms.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_registration_privacy_policy_text' },
			rt.ArrayItem{ key: 'default', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your personal data will be used to support your experience throughout this website, to manage access to your account, and for other purposes described in our %s.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('[privacy_policy]'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'css', val: 'min-width: 50%; height: 75px;' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Checkout privacy policy'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Optionally add some text about your store privacy policy to show during checkout.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_checkout_privacy_policy_text' },
			rt.ArrayItem{ key: 'default', val: rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our %s.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('[privacy_policy]'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'textarea' },
			rt.ArrayItem{ key: 'css', val: 'min-width: 50%; height: 75px;' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'privacy_policy_options' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Personal data retention'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc', val: rt.call_function('__', [
				rt.new_string("Choose how long to retain personal data when it's no longer needed for processing. Leave the following options blank to retain this data indefinitely."),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'type', val: 'title' },
			rt.ArrayItem{ key: 'id', val: 'personal_data_retention' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Retain inactive accounts '),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Inactive accounts are those which have not logged in, or placed an order, for the specified duration. They will be deleted. Any orders will be converted into guest orders.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_delete_inactive_accounts' },
			rt.ArrayItem{ key: 'type', val: 'relative_date_selector' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.create_array([
				rt.ArrayItem{ key: 'number', val: '' },
				rt.ArrayItem{ key: 'unit', val: 'months' },
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Retain pending orders '),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Pending orders are unpaid and may have been abandoned by the customer. They will be trashed after the specified duration.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_trash_pending_orders' },
			rt.ArrayItem{ key: 'type', val: 'relative_date_selector' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Retain failed orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Failed orders are unpaid and may have been abandoned by the customer. They will be trashed after the specified duration.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_trash_failed_orders' },
			rt.ArrayItem{ key: 'type', val: 'relative_date_selector' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Retain cancelled orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Cancelled orders are unpaid and may have been cancelled by the store owner or customer. They will be trashed after the specified duration.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_trash_cancelled_orders' },
			rt.ArrayItem{ key: 'type', val: 'relative_date_selector' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: '' },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Retain refunded orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Retain refunded orders for a specified duration before anonymizing the personal data within them.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_anonymize_refunded_orders' },
			rt.ArrayItem{ key: 'type', val: 'relative_date_selector' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.create_array([
				rt.ArrayItem{ key: 'number', val: '' },
				rt.ArrayItem{ key: 'unit', val: 'months' },
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'title', val: rt.call_function('__', [
				rt.new_string('Retain completed orders'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'desc_tip', val: rt.call_function('__', [
				rt.new_string('Retain completed orders for a specified duration before anonymizing the personal data within them.'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'id', val: 'woocommerce_anonymize_completed_orders' },
			rt.ArrayItem{ key: 'type', val: 'relative_date_selector' },
			rt.ArrayItem{ key: 'placeholder', val: rt.call_function('__', [
				rt.new_string('N/A'),
				rt.new_string('woocommerce'),
			]) },
			rt.ArrayItem{ key: 'default', val: rt.create_array([
				rt.ArrayItem{ key: 'number', val: '' },
				rt.ArrayItem{ key: 'unit', val: 'months' },
			]) },
			rt.ArrayItem{ key: 'autoload', val: false },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'type', val: 'sectionend' },
			rt.ArrayItem{ key: 'id', val: 'personal_data_retention' },
		]) },
	])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('wp_is_block_theme', []rt.PhpVal{}))))) {
		closure_1_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.new_string('woocommerce_enable_signup_and_login_from_checkout'),
				var_setting.array_get(rt.new_string('id'))))
			{
				var_setting.array_set('checkboxgroup', 'start')
				var_setting.array_set('legend', rt.call_function('__', [
					rt.new_string('Allow customers to create an account'),
					rt.new_string('woocommerce'),
				]))
			}
			return var_setting.clone()
		}
		closure_2_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.new_string('woocommerce_enable_signup_and_login_from_checkout'),
				var_setting.array_get(rt.new_string('id'))))
			{
				var_setting.array_set('checkboxgroup', 'start')
				var_setting.array_set('legend', rt.call_function('__', [
					rt.new_string('Allow customers to create an account'),
					rt.new_string('woocommerce'),
				]))
			}
			return var_setting.clone()
		}
		var_account_settings = rt.call_function('array_map', [
			rt.new_closure(closure_1_fn),
			var_account_settings.clone(),
		])
		closure_3_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_enable_delayed_account_creation'),
				var_setting.array_get(rt.new_string('id')))))
		}
		var_account_settings = rt.call_function('array_filter', [
			var_account_settings.clone(), rt.new_closure(closure_3_fn)])
	}
	mut iife_temp_3 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_3 := iife_temp_3.is_checkout_block_default()
	if rt.is_true(iife_result_3) {
		closure_5_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			return rt.new_bool(!rt.is_true(rt.identical(rt.new_string('woocommerce_registration_generate_username'),
				var_setting.array_get(rt.new_string('id')))))
		}
		var_account_settings = rt.call_function('array_filter', [
			var_account_settings.clone(), rt.new_closure(closure_5_fn)])
		closure_6_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.new_string('woocommerce_registration_generate_password'),
				var_setting.array_get(rt.new_string('id'))))
			{
				var_setting.array_unset(rt.new_string('checkboxgroup'))
			}
			return var_setting.clone()
		}
		closure_7_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.new_string('woocommerce_registration_generate_password'),
				var_setting.array_get(rt.new_string('id'))))
			{
				var_setting.array_unset(rt.new_string('checkboxgroup'))
			}
			return var_setting.clone()
		}
		var_account_settings = rt.call_function('array_map', [
			rt.new_closure(closure_6_fn),
			var_account_settings.clone(),
		])
	} else {
		closure_8_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.new_string('woocommerce_enable_delayed_account_creation'),
				var_setting.array_get(rt.new_string('id'))))
			{
				var_setting.array_set('desc_tip', rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('This feature is only available with the Cart & Checkout blocks. %1$sLearn more%2$s.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<a href="https://woocommerce.com/document/woocommerce-store-editing/customizing-cart-and-checkout">'),
					rt.new_string('</a>'),
				]))
				var_setting.array_set('disabled', true)
				var_setting.array_set('value', 0)
				var_setting.array_get_mut('custom_attributes').array_set('disabled-tooltip', rt.call_function('__', [
					rt.new_string('Your store is using shortcode checkout. Use the Checkout blocks to activate this option.'),
					rt.new_string('woocommerce'),
				]))
			}
			return var_setting.clone()
		}
		closure_9_fn := fn (this_ptr rt.PhpVal, args []rt.PhpVal) rt.PhpVal {
			mut var_setting := if args.len > 0 { args[0].clone() } else { rt.new_null() }
			if rt.is_true(rt.identical(rt.new_string('woocommerce_enable_delayed_account_creation'),
				var_setting.array_get(rt.new_string('id'))))
			{
				var_setting.array_set('desc_tip', rt.call_function('sprintf', [
					rt.call_function('__', [
						rt.new_string('This feature is only available with the Cart & Checkout blocks. %1$sLearn more%2$s.'),
						rt.new_string('woocommerce'),
					]),
					rt.new_string('<a href="https://woocommerce.com/document/woocommerce-store-editing/customizing-cart-and-checkout">'),
					rt.new_string('</a>'),
				]))
				var_setting.array_set('disabled', true)
				var_setting.array_set('value', 0)
				var_setting.array_get_mut('custom_attributes').array_set('disabled-tooltip', rt.call_function('__', [
					rt.new_string('Your store is using shortcode checkout. Use the Checkout blocks to activate this option.'),
					rt.new_string('woocommerce'),
				]))
			}
			return var_setting.clone()
		}
		var_account_settings = rt.call_function('array_map', [
			rt.new_closure(closure_8_fn),
			var_account_settings.clone(),
		])
	}
	return rt.call_function('apply_filters', [
		rt.new_string('woocommerce_' +
			rt.get_property(rt.new_object('WC_Settings_Accounts', ['WC_Settings_Page'], &this), 'id') +
			'_settings'),
		var_account_settings.clone(),
	])
}

fn (mut this Class_WC_Settings_Accounts) output() {
	this.Class_WC_Settings_Page.output()
	mut var_script :=
		rt.new_string('\n\t\t\t// Move tooltips to label element. This is not possible through the settings field API so this is a workaround\n\t\t\t// until said API is refactored.\n\t\t\tdocument.querySelectorAll("input[disabled-tooltip]").forEach(function(element) {\n\t\t\t\tconst label = element.closest("label");\n\t\t\t\tlabel.setAttribute("disabled-tooltip", element.getAttribute("disabled-tooltip"));\n\t\t\t});\n\n\t\t\t// This handles settings that are enabled/disabled based on other settings.\n\t\t\tconst checkboxes = [\n\t\t\t\tdocument.getElementById("woocommerce_enable_signup_and_login_from_checkout"),\n\t\t\t\tdocument.getElementById("woocommerce_enable_myaccount_registration"),\n\t\t\t\tdocument.getElementById("woocommerce_enable_delayed_account_creation"),\n\t\t\t\tdocument.getElementById("woocommerce_enable_signup_from_checkout_for_subscriptions")\n\t\t\t];\n\t\t\tconst inputs = [\n\t\t\t\tdocument.getElementById("woocommerce_registration_generate_username"),\n\t\t\t\tdocument.getElementById("woocommerce_registration_generate_password")\n\t\t\t];\n\t\t\tcheckboxes.forEach(cb => cb && cb.addEventListener("change", function() {\n\t\t\t\tconst isChecked = checkboxes.some(cb => cb && cb.checked);\n\t\t\t\tinputs.forEach(input => {\n\t\t\t\t\tif ( ! input ) {\n\t\t\t\t\t\treturn;\n\t\t\t\t\t}\n\t\t\t\t\tinput.disabled = !isChecked;\n\t\t\t\t});\n\t\t\t}));\n\t\t\tcheckboxes[0].dispatchEvent(new Event("change")); // Initial state\n\n\t\t\t// Tracks for customize link.\n\t\t\tif ( typeof window?.wcTracks?.recordEvent === "function" ) {\n\t\t\t\tconst customizeLink = document.querySelector("a.delayed-account-creation-customize-link");\n\t\t\t\tif ( customizeLink ) {\n\t\t\t\t\tcustomizeLink.addEventListener("click", function() {\n\t\t\t\t\t\twindow.wcTracks.recordEvent("delayed_account_creation_customize_link_clicked");\n\t\t\t\t\t});\n\t\t\t\t}\n\t\t\t}\n\t\t')
	mut iife_temp_9 := Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{}
	mut iife_result_9 := iife_temp_9.is_checkout_block_default()
	if rt.is_true(iife_result_9) {
		var_script = rt.concat(var_script,
			rt.new_string('\n\t\t\t\t// Guest checkout should toggle off some options.\n\t\t\t\tconst guestCheckout = document.getElementById("woocommerce_enable_guest_checkout");\n\n\t\t\t\tif ( guestCheckout ) {\n\t\t\t\t\tguestCheckout.addEventListener("change", function() {\n\t\t\t\t\t\tconst isChecked = this.checked;\n\t\t\t\t\t\tconst input = document.getElementById("woocommerce_enable_delayed_account_creation");\n\t\t\t\t\t\tif ( ! input ) {\n\t\t\t\t\t\t\treturn;\n\t\t\t\t\t\t}\n\t\t\t\t\t\tinput.disabled = !isChecked;\n\t\t\t\t\t});\n\t\t\t\t\tguestCheckout.dispatchEvent(new Event("change")); // Initial state\n\t\t\t\t}\n\t\t\t'))
	}
	mut var_handle := rt.new_string('wc-admin-settings-accounts')
	rt.call_function('wp_register_script', [var_handle.clone(),
		rt.new_string(''), rt.new_array(), rt.get_constant('WC_VERSION'),
		rt.create_array([rt.ArrayItem{ key: 'in_footer', val: true }])])
	rt.call_function('wp_enqueue_script', [var_handle.clone()])
	rt.call_function('wp_add_inline_script', [var_handle.clone(),
		var_script.clone()])
}

struct Class_WC_Settings_Page {
	rt.PhpObjectBase
}

struct Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	rt.PhpObjectBase
}

fn create_wc_settings_accounts() &Class_WC_Settings_Accounts {
	mut obj := &Class_WC_Settings_Accounts{
		PhpObjectBase: rt.PhpObjectBase{}
		icon:          rt.new_string('people')
	}
	obj.construct()
	return obj
}

fn create_wc_settings_page(_args ...rt.PhpVal) &Class_WC_Settings_Page {
	mut obj := &Class_WC_Settings_Page{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_automattic_woocommerce_blocks_utils_cartcheckoututils(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils {
	mut obj := &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_Settings_Accounts) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			this.construct()
			return rt.new_null()
		}
		'get_settings_for_default_section' {
			return this.get_settings_for_default_section()
		}
		'output' {
			this.output()
			return rt.new_null()
		}
		else {
			return none
		}
	}
}

fn (this &Class_WC_Settings_Accounts) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'icon' { return this.icon }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_WC_Settings_Accounts) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'icon' {
			this.icon = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_WC_Settings_Page) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_Settings_Page) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_Settings_Page) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Blocks_Utils_CartCheckoutUtils) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('WC_Settings_Accounts'),
		rt.new_bool(false),
	]))
	{
		return rt.new_object('WC_Settings_Accounts', ['WC_Settings_Page'],
			create_wc_settings_accounts())
	}
	return rt.new_object('WC_Settings_Accounts', ['WC_Settings_Page'],
		create_wc_settings_accounts())
}

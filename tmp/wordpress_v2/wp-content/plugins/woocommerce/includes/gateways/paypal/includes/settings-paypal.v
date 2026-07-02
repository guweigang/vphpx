import rt

struct Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	rt.PhpObjectBase
}

fn create_automattic_woocommerce_utilities_loggingutil(_args ...rt.PhpVal) &Class_Automattic_WooCommerce_Utilities_LoggingUtil {
	mut obj := &Class_Automattic_WooCommerce_Utilities_LoggingUtil{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_Automattic_WooCommerce_Utilities_LoggingUtil) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
	mut iife_temp_0 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_0 := iife_temp_0.get_logs_tab_url()
	mut iife_temp_1 := Class_Automattic_WooCommerce_Utilities_LoggingUtil{}
	mut iife_result_1 := iife_temp_1.get_logs_tab_url()
	mut var_settings := {
		'enabled':          {
			'title':   rt.call_function('__', [rt.new_string('Enable/Disable'),
				rt.new_string('woocommerce')])
			'type':    rt.new_string('checkbox')
			'label':   rt.call_function('__', [rt.new_string('Enable PayPal Standard'),
				rt.new_string('woocommerce')])
			'default': rt.new_string('no')
		}
		'title':            {
			'title':       rt.call_function('__', [rt.new_string('Title'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('safe_text')
			'description': rt.call_function('__', [
				rt.new_string('This controls the title which the user sees during checkout.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.call_function('__', [rt.new_string('PayPal'),
				rt.new_string('woocommerce')])
			'desc_tip':    rt.new_bool(true)
		}
		'description':      {
			'title':       rt.call_function('__', [rt.new_string('Description'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('text')
			'desc_tip':    rt.new_bool(true)
			'description': rt.call_function('__', [
				rt.new_string('This controls the description which the user sees during checkout.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.call_function('__', [
				rt.new_string("Pay via PayPal; you can pay with your credit card if you don't have a PayPal account."),
				rt.new_string('woocommerce'),
			])
		}
		'email':            {
			'title':       rt.call_function('__', [rt.new_string('PayPal email'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('email')
			'description': rt.call_function('__', [
				rt.new_string('Please enter your PayPal email address; this is needed in order to take payment.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.call_function('get_option', [rt.new_string('admin_email')])
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.new_string('you@youremail.com')
		}
		'advanced':         {
			'title':       rt.call_function('__', [rt.new_string('Advanced options'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('title')
			'description': rt.new_string('')
		}
		'testmode':         {
			'title':       rt.call_function('__', [rt.new_string('PayPal sandbox'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('checkbox')
			'label':       rt.call_function('__', [
				rt.new_string('Enable PayPal sandbox'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('no')
			'description': rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('PayPal sandbox can be used to test payments. Sign up for a <a href="%s">developer account</a>.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('https://developer.paypal.com/'),
			])
		}
		'paymentaction':    {
			'title':       rt.call_function('__', [rt.new_string('Payment action'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('select')
			'class':       rt.new_string('wc-enhanced-select')
			'description': rt.call_function('__', [
				rt.new_string('Choose whether you wish to capture funds immediately or authorize payment only.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('sale')
			'desc_tip':    rt.new_bool(true)
			'options':     {
				'sale':          rt.call_function('__', [rt.new_string('Capture'),
					rt.new_string('woocommerce')])
				'authorization': rt.call_function('__', [rt.new_string('Authorize'),
					rt.new_string('woocommerce')])
			}
		}
		'paypal_buttons':   {
			'title':       rt.call_function('__', [rt.new_string('PayPal Buttons'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('checkbox')
			'label':       rt.call_function('__', [
				rt.new_string('Enable PayPal Buttons'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('yes')
			'description': rt.call_function('__', [
				rt.new_string('Enable PayPal buttons to offer PayPal, Venmo and Pay Later as express checkout options on product, cart, and checkout pages.'),
				rt.new_string('woocommerce'),
			])
		}
		'invoice_prefix':   {
			'title':       rt.call_function('__', [rt.new_string('Invoice prefix'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('text')
			'description': rt.call_function('__', [
				rt.new_string('Please enter a prefix for your invoice numbers. If you use your PayPal account for multiple stores ensure this prefix is unique as PayPal will not allow orders with the same invoice number.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('WC-')
			'desc_tip':    rt.new_bool(true)
		}
		'send_shipping':    {
			'title':       rt.call_function('__', [rt.new_string('Shipping details'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('checkbox')
			'label':       rt.call_function('__', [
				rt.new_string('Send shipping details to PayPal instead of billing.'),
				rt.new_string('woocommerce'),
			])
			'description': rt.call_function('__', [
				rt.new_string('PayPal allows us to send one address. If you are using PayPal for shipping labels you may prefer to send the shipping address rather than billing. Turning this option off may prevent PayPal Seller protection from applying.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('yes')
		}
		'address_override': {
			'title':       rt.call_function('__', [rt.new_string('Address override'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('checkbox')
			'label':       rt.call_function('__', [
				rt.new_string('Prevent buyers from changing the shipping address.'),
				rt.new_string('woocommerce'),
			])
			'description': rt.call_function('__', [
				rt.new_string('When enabled, PayPal will use the address provided by the checkout form, and prevent the buyer from changing it inside the PayPal payment page. Disable this to let buyers choose a shipping address from their PayPal account. PayPal verifies addresses therefore this setting can cause errors (we recommend keeping it disabled).'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('no')
		}
		'debug':            {
			'title':       rt.call_function('__', [rt.new_string('Debug log'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('checkbox')
			'label':       rt.call_function('__', [rt.new_string('Enable logging'),
				rt.new_string('woocommerce')])
			'default':     rt.new_string('no')
			'description': rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Log PayPal events such as IPN requests and review them on the <a href="%s">Logs screen</a>. Note: this may log personal information. We recommend using this for debugging purposes only and deleting the logs when finished.'),
					rt.new_string('woocommerce'),
				]),
				rt.call_function('esc_url', [
					iife_result_0,
				]),
			])
		}
	}
	mut var_legacy_settings := {
		'image_url':             {
			'title':       rt.call_function('__', [rt.new_string('Image url'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('text')
			'description': rt.call_function('__', [
				rt.new_string('Optionally enter the URL to a 150x50px image displayed as your logo in the upper left corner of the PayPal checkout pages.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.call_function('__', [rt.new_string('Optional'),
				rt.new_string('woocommerce')])
			'is_legacy':   rt.new_bool(true)
		}
		'ipn_notification':      {
			'title':       rt.call_function('__', [
				rt.new_string('IPN email notifications'),
				rt.new_string('woocommerce'),
			])
			'type':        rt.new_string('checkbox')
			'label':       rt.call_function('__', [
				rt.new_string('Enable IPN email notifications'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('yes')
			'description': rt.call_function('__', [
				rt.new_string('Send notifications when an IPN is received from PayPal indicating refunds, chargebacks and cancellations.'),
				rt.new_string('woocommerce'),
			])
			'is_legacy':   rt.new_bool(true)
		}
		'receiver_email':        {
			'title':       rt.call_function('__', [rt.new_string('Receiver email'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('email')
			'description': rt.call_function('__', [
				rt.new_string('If your main PayPal email differs from the PayPal email entered above, input your main receiver email for your PayPal account here. This is used to validate IPN requests.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.new_string('you@youremail.com')
			'is_legacy':   rt.new_bool(true)
		}
		'identity_token':        {
			'title':       rt.call_function('__', [
				rt.new_string('PayPal identity token'),
				rt.new_string('woocommerce'),
			])
			'type':        rt.new_string('text')
			'description': rt.call_function('__', [
				rt.new_string('Optionally enable "Payment Data Transfer" (Profile > Profile and Settings > My Selling Tools > Website Preferences) and then copy your identity token here. This will allow payments to be verified without the need for PayPal IPN.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.new_string('')
			'is_legacy':   rt.new_bool(true)
		}
		'api_details':           {
			'title':       rt.call_function('__', [rt.new_string('API credentials'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('title')
			'description': rt.call_function('sprintf', [
				rt.call_function('__', [
					rt.new_string('Enter your PayPal API credentials to process refunds via PayPal. Learn how to access your <a href="%s">PayPal API Credentials</a>.'),
					rt.new_string('woocommerce'),
				]),
				rt.new_string('https://developer.paypal.com/webapps/developer/docs/classic/api/apiCredentials/#create-an-api-signature'),
			])
			'is_legacy':   rt.new_bool(true)
		}
		'api_username':          {
			'title':       rt.call_function('__', [rt.new_string('Live API username'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('text')
			'description': rt.call_function('__', [
				rt.new_string('Get your API credentials from PayPal.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.call_function('__', [rt.new_string('Optional'),
				rt.new_string('woocommerce')])
			'is_legacy':   rt.new_bool(true)
		}
		'api_password':          {
			'title':       rt.call_function('__', [rt.new_string('Live API password'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('password')
			'description': rt.call_function('__', [
				rt.new_string('Get your API credentials from PayPal.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.call_function('__', [rt.new_string('Optional'),
				rt.new_string('woocommerce')])
			'is_legacy':   rt.new_bool(true)
		}
		'api_signature':         {
			'title':       rt.call_function('__', [rt.new_string('Live API signature'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('password')
			'description': rt.call_function('__', [
				rt.new_string('Get your API credentials from PayPal.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.call_function('__', [rt.new_string('Optional'),
				rt.new_string('woocommerce')])
			'is_legacy':   rt.new_bool(true)
		}
		'sandbox_api_username':  {
			'title':       rt.call_function('__', [rt.new_string('Sandbox API username'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('text')
			'description': rt.call_function('__', [
				rt.new_string('Get your API credentials from PayPal.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.call_function('__', [rt.new_string('Optional'),
				rt.new_string('woocommerce')])
			'is_legacy':   rt.new_bool(true)
		}
		'sandbox_api_password':  {
			'title':       rt.call_function('__', [rt.new_string('Sandbox API password'),
				rt.new_string('woocommerce')])
			'type':        rt.new_string('password')
			'description': rt.call_function('__', [
				rt.new_string('Get your API credentials from PayPal.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.call_function('__', [rt.new_string('Optional'),
				rt.new_string('woocommerce')])
			'is_legacy':   rt.new_bool(true)
		}
		'sandbox_api_signature': {
			'title':       rt.call_function('__', [
				rt.new_string('Sandbox API signature'),
				rt.new_string('woocommerce'),
			])
			'type':        rt.new_string('password')
			'description': rt.call_function('__', [
				rt.new_string('Get your API credentials from PayPal.'),
				rt.new_string('woocommerce'),
			])
			'default':     rt.new_string('')
			'desc_tip':    rt.new_bool(true)
			'placeholder': rt.call_function('__', [rt.new_string('Optional'),
				rt.new_string('woocommerce')])
			'is_legacy':   rt.new_bool(true)
		}
	}
	return rt.call_function('array_merge', [
		rt.create_array_from_native_map(var_settings),
		rt.create_array_from_native_map(var_legacy_settings),
	])
}

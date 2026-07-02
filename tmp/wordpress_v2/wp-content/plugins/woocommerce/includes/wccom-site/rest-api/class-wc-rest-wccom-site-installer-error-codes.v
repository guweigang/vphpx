import rt

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.not_authenticated() string {
	return 'not_authenticated'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_access_token() string {
	return 'no_access_token'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_signature() string {
	return 'no_signature'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.site_not_connected() string {
	return 'site_not_connnected'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.invalid_token() string {
	return 'invalid_token'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.request_verification_failed() string {
	return 'request_verification_failed'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.user_not_found() string {
	return 'user_not_found'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_permission() string {
	return 'forbidden'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.idempotency_key_mismatch() string {
	return 'idempotency_key_mismatch'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_initiated_installation_found() string {
	return 'no_initiated_installation_found'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.all_installation_steps_run() string {
	return 'all_installation_steps_run'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.requested_step_already_run() string {
	return 'requested_step_already_run'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.plugin_already_installed() string {
	return 'plugin_already_installed'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.installation_already_running() string {
	return 'installation_already_running'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.installation_failed() string {
	return 'installation_failed'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.filesystem_requirements_not_met() string {
	return 'filesystem_requirements_not_met'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.failed_getting_product_info() string {
	return 'product_info_failed'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.invalid_product_info_response() string {
	return 'invalid_product_info_response'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wccom_product_missing_subscription() string {
	return 'wccom_product_missing_subscription'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wccom_product_missing_package() string {
	return 'wccom_product_missing_package'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wporg_product_missing_download_link() string {
	return 'wporg_product_missing_download_link'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.missing_download_path() string {
	return 'missing_download_path'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.missing_unpacked_path() string {
	return 'missing_unpacked_path'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unknown_filename() string {
	return 'unknown_filename'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.plugin_activation_error() string {
	return 'plugin_activation_error'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unexpected_error() string {
	return 'unexpected_error'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.failed_to_reset_installation_state() string {
	return 'failed_to_reset_installation_state'
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.error_messages() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.not_authenticated()
			val: 'Authentication required'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_access_token()
			val: 'No access token provided'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_signature()
			val: 'No signature provided'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.site_not_connected()
			val: 'Site not connected to WooCommerce.com'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.invalid_token()
			val: 'Invalid access token provided'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.request_verification_failed()
			val: 'Request verification by signature failed'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.user_not_found()
			val: 'Token owning user not found'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_permission()
			val: 'You do not have permission to install plugin or theme'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.idempotency_key_mismatch()
			val: 'Idempotency key mismatch'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_initiated_installation_found()
			val: 'No initiated installation for the product found'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.all_installation_steps_run()
			val: 'All installation steps have been run'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.requested_step_already_run()
			val: 'Requested step has already been run'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.plugin_already_installed()
			val: 'The plugin has already been installed'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.installation_already_running()
			val: 'The installation of the plugin is already running'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.installation_failed()
			val: 'The installation of the plugin failed'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.filesystem_requirements_not_met()
			val: 'The filesystem requirements are not met'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.failed_getting_product_info()
			val: 'Failed to retrieve product info from WooCommerce.com'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.invalid_product_info_response()
			val: 'Invalid product info response from WooCommerce.com'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wccom_product_missing_subscription()
			val: 'Product subscription is missing'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.wccom_product_missing_package()
			val: 'Could not find product package'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.missing_download_path()
			val: 'Download path is missing'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.missing_unpacked_path()
			val: 'Unpacked path is missing'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unknown_filename()
			val: 'Unknown product filename'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.plugin_activation_error()
			val: 'Plugin activation error'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unexpected_error()
			val: 'Unexpected error'
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.failed_to_reset_installation_state()
			val: 'Failed to reset installation state'
		},
	])
}

pub fn Class_WC_REST_WCCOM_Site_Installer_Error_Codes.http_codes() rt.PhpVal {
	return rt.create_array([
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.not_authenticated()
			val: 401
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_access_token()
			val: 400
		},
		rt.ArrayItem{ key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_signature(), val: 400 },
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.site_not_connected()
			val: 401
		},
		rt.ArrayItem{ key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.invalid_token(), val: 401 },
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.request_verification_failed()
			val: 400
		},
		rt.ArrayItem{ key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.user_not_found(), val: 401 },
		rt.ArrayItem{ key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_permission(), val: 403 },
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.idempotency_key_mismatch()
			val: 400
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.no_initiated_installation_found()
			val: 400
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.all_installation_steps_run()
			val: 400
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.requested_step_already_run()
			val: 400
		},
		rt.ArrayItem{
			key: Class_WC_REST_WCCOM_Site_Installer_Error_Codes.unexpected_error()
			val: 500
		},
	])
}

struct Class_WC_REST_WCCOM_Site_Installer_Error_Codes {
	rt.PhpObjectBase
}

fn create_wc_rest_wccom_site_installer_error_codes(_args ...rt.PhpVal) &Class_WC_REST_WCCOM_Site_Installer_Error_Codes {
	mut obj := &Class_WC_REST_WCCOM_Site_Installer_Error_Codes{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error_Codes) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_WC_REST_WCCOM_Site_Installer_Error_Codes) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_WC_REST_WCCOM_Site_Installer_Error_Codes) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	rt.new_bool(rt.is_true(rt.call_function('defined', [rt.new_string('ABSPATH')]))
		|| rt.is_true(exit(0)))
}

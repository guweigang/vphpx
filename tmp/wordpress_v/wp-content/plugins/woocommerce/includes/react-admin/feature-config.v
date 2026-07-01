import rt

fn wc_admin_get_feature_config() rt.PhpVal {
	return rt.create_array([rt.ArrayItem{ key: 'activity-panels', val: true },
		rt.ArrayItem{ key: 'analytics', val: true }, rt.ArrayItem{
			key: 'analytics-scheduled-import'
			val: true
		}, rt.ArrayItem{ key: 'product-block-editor', val: true },
		rt.ArrayItem{ key: 'product-data-views', val: false },
		rt.ArrayItem{ key: 'experimental-blocks', val: false },
		rt.ArrayItem{ key: 'experimental-iapi-mini-cart', val: true },
		rt.ArrayItem{ key: 'experimental-iapi-runtime', val: false },
		rt.ArrayItem{ key: 'coming-soon-newsletter-template', val: false },
		rt.ArrayItem{ key: 'coupons', val: true }, rt.ArrayItem{ key: 'core-profiler', val: true },
		rt.ArrayItem{ key: 'customize-store', val: true }, rt.ArrayItem{
			key: 'customer-effort-score-tracks'
			val: true
		}, rt.ArrayItem{ key: 'import-products-task', val: true },
		rt.ArrayItem{ key: 'experimental-fashion-sample-products', val: true },
		rt.ArrayItem{ key: 'shipping-smart-defaults', val: true },
		rt.ArrayItem{ key: 'shipping-setting-tour', val: true },
		rt.ArrayItem{ key: 'homescreen', val: true }, rt.ArrayItem{ key: 'marketing', val: true },
		rt.ArrayItem{ key: 'minified-js', val: false }, rt.ArrayItem{
			key: 'mobile-app-banner'
			val: true
		}, rt.ArrayItem{ key: 'onboarding', val: true }, rt.ArrayItem{
			key: 'onboarding-tasks'
			val: true
		}, rt.ArrayItem{ key: 'pattern-toolkit-full-composability', val: true },
		rt.ArrayItem{ key: 'product-pre-publish-modal', val: false },
		rt.ArrayItem{ key: 'product-custom-fields', val: true },
		rt.ArrayItem{ key: 'products-catalog-api', val: false },
		rt.ArrayItem{ key: 'remote-inbox-notifications', val: true },
		rt.ArrayItem{ key: 'remote-free-extensions', val: true },
		rt.ArrayItem{ key: 'payment-gateway-suggestions', val: true },
		rt.ArrayItem{ key: 'printful', val: true }, rt.ArrayItem{ key: 'settings', val: false },
		rt.ArrayItem{ key: 'shipping-label-banner', val: true },
		rt.ArrayItem{ key: 'subscriptions', val: true }, rt.ArrayItem{
			key: 'store-alerts'
			val: true
		}, rt.ArrayItem{ key: 'transient-notices', val: true },
		rt.ArrayItem{ key: 'woo-mobile-welcome', val: true },
		rt.ArrayItem{ key: 'wc-pay-promotion', val: true }, rt.ArrayItem{
			key: 'wc-pay-welcome-page'
			val: true
		}, rt.ArrayItem{ key: 'async-product-editor-category-field', val: false },
		rt.ArrayItem{ key: 'launch-your-store', val: true }, rt.ArrayItem{
			key: 'product-editor-template-system'
			val: false
		}, rt.ArrayItem{ key: 'use-wp-horizon', val: false },
		rt.ArrayItem{ key: 'rest-api-v4', val: false }])
}

pub fn init_wp_content_plugins_woocommerce_includes_react_admin_feature_config_php() {
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('function_exists', [
		rt.new_string('wc_admin_get_feature_config'),
	])))))
	{
	}
}

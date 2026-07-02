import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-cart-checkout-base' },
			rt.ArrayItem{ key: none, val: 'wc-cart-checkout-vendors' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-data-store' },
			rt.ArrayItem{ key: none, val: 'wc-price-format' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
		]) },
		rt.ArrayItem{ key: 'version', val: '73f6a6859a12793fa23a' },
	])
}

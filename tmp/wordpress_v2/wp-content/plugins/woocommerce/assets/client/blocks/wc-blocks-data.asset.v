import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'wc-blocks-checkout-events' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-registry' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-data-controls' },
			rt.ArrayItem{ key: none, val: 'wp-deprecated' },
			rt.ArrayItem{ key: none, val: 'wp-dom' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-is-shallow-equal' },
			rt.ArrayItem{ key: none, val: 'wp-notices' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'b3c5c63391af29efa131' },
	])
}

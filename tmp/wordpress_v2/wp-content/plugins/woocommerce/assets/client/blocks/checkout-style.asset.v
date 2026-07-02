import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-checkout' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-checkout-events' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-components' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-data-store' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-registry' },
			rt.ArrayItem{ key: none, val: 'wc-blocks-shared-hocs' },
			rt.ArrayItem{ key: none, val: 'wc-price-format' },
			rt.ArrayItem{ key: none, val: 'wc-sanitize' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wc-types' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-autop' },
			rt.ArrayItem{ key: none, val: 'wp-block-editor' },
			rt.ArrayItem{ key: none, val: 'wp-blocks' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-compose' },
			rt.ArrayItem{ key: none, val: 'wp-core-data' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-deprecated' },
			rt.ArrayItem{ key: none, val: 'wp-dom' },
			rt.ArrayItem{ key: none, val: 'wp-dom-ready' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-is-shallow-equal' },
			rt.ArrayItem{ key: none, val: 'wp-keycodes' },
			rt.ArrayItem{ key: none, val: 'wp-notices' },
			rt.ArrayItem{ key: none, val: 'wp-plugins' },
			rt.ArrayItem{ key: none, val: 'wp-polyfill' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
			rt.ArrayItem{ key: none, val: 'wp-wordcount' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'eedf547edcced1c51bbe' },
	])
}

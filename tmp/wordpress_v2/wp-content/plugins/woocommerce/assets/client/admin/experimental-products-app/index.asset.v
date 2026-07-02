import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'react-dom' },
			rt.ArrayItem{ key: none, val: 'wc-settings' },
			rt.ArrayItem{ key: none, val: 'wp-a11y' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-compose' },
			rt.ArrayItem{ key: none, val: 'wp-core-data' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-date' },
			rt.ArrayItem{ key: none, val: 'wp-editor' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-keycodes' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
			rt.ArrayItem{ key: none, val: 'wp-private-apis' },
			rt.ArrayItem{ key: none, val: 'wp-router' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
			rt.ArrayItem{ key: none, val: 'wp-warning' },
		]) },
		rt.ArrayItem{ key: 'version', val: '0760a711a738a4cb605f' },
	])
}

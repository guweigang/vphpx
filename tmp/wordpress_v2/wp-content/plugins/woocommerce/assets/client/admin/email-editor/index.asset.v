import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
			rt.ArrayItem{ key: none, val: 'lodash' },
			rt.ArrayItem{ key: none, val: 'react' },
			rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
			rt.ArrayItem{ key: none, val: 'wp-block-editor' },
			rt.ArrayItem{ key: none, val: 'wp-block-library' },
			rt.ArrayItem{ key: none, val: 'wp-blocks' },
			rt.ArrayItem{ key: none, val: 'wp-commands' },
			rt.ArrayItem{ key: none, val: 'wp-components' },
			rt.ArrayItem{ key: none, val: 'wp-compose' },
			rt.ArrayItem{ key: none, val: 'wp-core-data' },
			rt.ArrayItem{ key: none, val: 'wp-data' },
			rt.ArrayItem{ key: none, val: 'wp-data-controls' },
			rt.ArrayItem{ key: none, val: 'wp-dom-ready' },
			rt.ArrayItem{ key: none, val: 'wp-editor' },
			rt.ArrayItem{ key: none, val: 'wp-element' },
			rt.ArrayItem{ key: none, val: 'wp-format-library' },
			rt.ArrayItem{ key: none, val: 'wp-hooks' },
			rt.ArrayItem{ key: none, val: 'wp-html-entities' },
			rt.ArrayItem{ key: none, val: 'wp-i18n' },
			rt.ArrayItem{ key: none, val: 'wp-is-shallow-equal' },
			rt.ArrayItem{ key: none, val: 'wp-keycodes' },
			rt.ArrayItem{ key: none, val: 'wp-notices' },
			rt.ArrayItem{ key: none, val: 'wp-plugins' },
			rt.ArrayItem{ key: none, val: 'wp-preferences' },
			rt.ArrayItem{ key: none, val: 'wp-primitives' },
			rt.ArrayItem{ key: none, val: 'wp-priority-queue' },
			rt.ArrayItem{ key: none, val: 'wp-private-apis' },
			rt.ArrayItem{ key: none, val: 'wp-rich-text' },
			rt.ArrayItem{ key: none, val: 'wp-style-engine' },
			rt.ArrayItem{ key: none, val: 'wp-url' },
		]) },
		rt.ArrayItem{ key: 'version', val: 'fd9fc151357d9bd2b21c' },
	])
}

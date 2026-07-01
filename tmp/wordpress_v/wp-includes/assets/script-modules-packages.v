import rt

pub fn init_wp_includes_assets_script_modules_packages_php() {
	return rt.create_array([
		rt.ArrayItem{ key: 'a11y/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '1c371cb517a97cdbcb9f' },
		]) },
		rt.ArrayItem{ key: 'abilities/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-data' },
				rt.ArrayItem{ key: none, val: 'wp-i18n' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'f3475bc77a30dcc5b38d' },
		]) },
		rt.ArrayItem{ key: 'block-editor/utils/fit-text-frontend.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '383c7a8bd24a1f2fd9b9' },
		]) },
		rt.ArrayItem{ key: 'block-library/accordion/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '2af01b43d30739c3fb8d' },
		]) },
		rt.ArrayItem{ key: 'block-library/file/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '7d4d261d10dca47ebecb' },
		]) },
		rt.ArrayItem{ key: 'block-library/form/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: '5542f8ad251fe43ef09e' },
		]) },
		rt.ArrayItem{ key: 'block-library/image/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '25ee935fd6c67371d0f3' },
		]) },
		rt.ArrayItem{ key: 'block-library/navigation/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '96a846e1d7b789c39ab9' },
		]) },
		rt.ArrayItem{ key: 'block-library/playlist/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '99f747d731f80246db11' },
		]) },
		rt.ArrayItem{ key: 'block-library/query/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '7a4ec5bfb61a7137cf4b' },
		]) },
		rt.ArrayItem{ key: 'block-library/search/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '38bd0e230eaffa354d2a' },
		]) },
		rt.ArrayItem{ key: 'block-library/tabs/view.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '1f60dd5e3fa56c6b2e2e' },
		]) },
		rt.ArrayItem{ key: 'boot/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'react' },
				rt.ArrayItem{ key: none, val: 'react-dom' },
				rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
				rt.ArrayItem{ key: none, val: 'wp-commands' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-compose' },
				rt.ArrayItem{ key: none, val: 'wp-core-data' },
				rt.ArrayItem{ key: none, val: 'wp-data' },
				rt.ArrayItem{ key: none, val: 'wp-editor' },
				rt.ArrayItem{ key: none, val: 'wp-element' },
				rt.ArrayItem{ key: none, val: 'wp-html-entities' },
				rt.ArrayItem{ key: none, val: 'wp-i18n' },
				rt.ArrayItem{ key: none, val: 'wp-keyboard-shortcuts' },
				rt.ArrayItem{ key: none, val: 'wp-keycodes' },
				rt.ArrayItem{ key: none, val: 'wp-notices' },
				rt.ArrayItem{ key: none, val: 'wp-primitives' },
				rt.ArrayItem{ key: none, val: 'wp-private-apis' },
				rt.ArrayItem{ key: none, val: 'wp-theme' },
				rt.ArrayItem{ key: none, val: 'wp-url' },
			]) },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/a11y' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/lazy-editor' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/route' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '54bb5a420026a61c7e4f' },
		]) },
		rt.ArrayItem{ key: 'connectors/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-data' },
				rt.ArrayItem{ key: none, val: 'wp-element' },
				rt.ArrayItem{ key: none, val: 'wp-i18n' },
				rt.ArrayItem{ key: none, val: 'wp-private-apis' },
			]) },
			rt.ArrayItem{ key: 'version', val: '274797868955a828dfdc' },
		]) },
		rt.ArrayItem{ key: 'core-abilities/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'wp-api-fetch' },
				rt.ArrayItem{ key: none, val: 'wp-url' },
			]) },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/abilities' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '012760fd849397dd0031' },
		]) },
		rt.ArrayItem{ key: 'edit-site-init/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
				rt.ArrayItem{ key: none, val: 'wp-data' },
				rt.ArrayItem{ key: none, val: 'wp-element' },
				rt.ArrayItem{ key: none, val: 'wp-primitives' },
			]) },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/boot' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: 'e57f44d1a9f69e75d2d9' },
		]) },
		rt.ArrayItem{ key: 'interactivity/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'efaa5193bbad9c60ffd1' },
		]) },
		rt.ArrayItem{ key: 'interactivity-router/full-page.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '5c07cd7a12ae073c5241' },
		]) },
		rt.ArrayItem{ key: 'interactivity-router/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/a11y' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '71aa17bac91628a0f874' },
		]) },
		rt.ArrayItem{ key: 'latex-to-mathml/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'version', val: 'e5fd3ae6d2c3b6e669da' },
		]) },
		rt.ArrayItem{ key: 'latex-to-mathml/loader.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.new_array() },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/latex-to-mathml' },
					rt.ArrayItem{ key: 'import', val: 'dynamic' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '4f37456af539bd3d2351' },
		]) },
		rt.ArrayItem{ key: 'lazy-editor/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
				rt.ArrayItem{ key: none, val: 'wp-block-editor' },
				rt.ArrayItem{ key: none, val: 'wp-blocks' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-core-data' },
				rt.ArrayItem{ key: none, val: 'wp-data' },
				rt.ArrayItem{ key: none, val: 'wp-editor' },
				rt.ArrayItem{ key: none, val: 'wp-element' },
				rt.ArrayItem{ key: none, val: 'wp-i18n' },
				rt.ArrayItem{ key: none, val: 'wp-private-apis' },
				rt.ArrayItem{ key: none, val: 'wp-style-engine' },
			]) },
			rt.ArrayItem{ key: 'version', val: '30ab62f45bfe9f971ea0' },
		]) },
		rt.ArrayItem{ key: 'route/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'react' },
				rt.ArrayItem{ key: none, val: 'react-dom' },
				rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
				rt.ArrayItem{ key: none, val: 'wp-private-apis' },
			]) },
			rt.ArrayItem{ key: 'version', val: 'c5843b6c5e84b352f43b' },
		]) },
		rt.ArrayItem{ key: 'workflow/index.js', val: rt.create_array([
			rt.ArrayItem{ key: 'dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: 'react' },
				rt.ArrayItem{ key: none, val: 'react-dom' },
				rt.ArrayItem{ key: none, val: 'react-jsx-runtime' },
				rt.ArrayItem{ key: none, val: 'wp-components' },
				rt.ArrayItem{ key: none, val: 'wp-data' },
				rt.ArrayItem{ key: none, val: 'wp-element' },
				rt.ArrayItem{ key: none, val: 'wp-i18n' },
				rt.ArrayItem{ key: none, val: 'wp-keyboard-shortcuts' },
				rt.ArrayItem{ key: none, val: 'wp-primitives' },
				rt.ArrayItem{ key: none, val: 'wp-private-apis' },
			]) },
			rt.ArrayItem{ key: 'module_dependencies', val: rt.create_array([
				rt.ArrayItem{ key: none, val: rt.create_array([
					rt.ArrayItem{ key: 'id', val: '@wordpress/abilities' },
					rt.ArrayItem{ key: 'import', val: 'static' },
				]) },
			]) },
			rt.ArrayItem{ key: 'version', val: '13556bc597bbf2a8d620' },
		]) },
	])
}

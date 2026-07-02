import rt

fn main() {
	defer {
		rt.shutdown()
	}

	return rt.create_array([
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/a11y' },
			rt.ArrayItem{ key: 'path', val: 'a11y/index' },
			rt.ArrayItem{ key: 'asset', val: 'a11y/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/abilities' },
			rt.ArrayItem{ key: 'path', val: 'abilities/index' },
			rt.ArrayItem{ key: 'asset', val: 'abilities/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-editor/utils/fit-text-frontend' },
			rt.ArrayItem{ key: 'path', val: 'block-editor/utils/fit-text-frontend' },
			rt.ArrayItem{ key: 'asset', val: 'block-editor/utils/fit-text-frontend.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/accordion/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/accordion/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/accordion/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/file/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/file/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/file/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/form/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/form/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/form/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/image/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/image/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/image/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/navigation/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/navigation/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/navigation/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/playlist/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/playlist/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/playlist/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/query/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/query/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/query/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/search/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/search/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/search/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/block-library/tabs/view' },
			rt.ArrayItem{ key: 'path', val: 'block-library/tabs/view' },
			rt.ArrayItem{ key: 'asset', val: 'block-library/tabs/view.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/boot' },
			rt.ArrayItem{ key: 'path', val: 'boot/index' },
			rt.ArrayItem{ key: 'asset', val: 'boot/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/boot' },
			rt.ArrayItem{ key: 'path', val: 'boot/index' },
			rt.ArrayItem{ key: 'asset', val: 'boot/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/connectors' },
			rt.ArrayItem{ key: 'path', val: 'connectors/index' },
			rt.ArrayItem{ key: 'asset', val: 'connectors/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/core-abilities' },
			rt.ArrayItem{ key: 'path', val: 'core-abilities/index' },
			rt.ArrayItem{ key: 'asset', val: 'core-abilities/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/edit-site-init' },
			rt.ArrayItem{ key: 'path', val: 'edit-site-init/index' },
			rt.ArrayItem{ key: 'asset', val: 'edit-site-init/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity' },
			rt.ArrayItem{ key: 'path', val: 'interactivity/index' },
			rt.ArrayItem{ key: 'asset', val: 'interactivity/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router' },
			rt.ArrayItem{ key: 'path', val: 'interactivity-router/index' },
			rt.ArrayItem{ key: 'asset', val: 'interactivity-router/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/interactivity-router/full-page' },
			rt.ArrayItem{ key: 'path', val: 'interactivity-router/full-page' },
			rt.ArrayItem{ key: 'asset', val: 'interactivity-router/full-page.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/latex-to-mathml' },
			rt.ArrayItem{ key: 'path', val: 'latex-to-mathml/index' },
			rt.ArrayItem{ key: 'asset', val: 'latex-to-mathml/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/latex-to-mathml/loader' },
			rt.ArrayItem{ key: 'path', val: 'latex-to-mathml/loader' },
			rt.ArrayItem{ key: 'asset', val: 'latex-to-mathml/loader.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/lazy-editor' },
			rt.ArrayItem{ key: 'path', val: 'lazy-editor/index' },
			rt.ArrayItem{ key: 'asset', val: 'lazy-editor/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/route' },
			rt.ArrayItem{ key: 'path', val: 'route/index' },
			rt.ArrayItem{ key: 'asset', val: 'route/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/route' },
			rt.ArrayItem{ key: 'path', val: 'route/index' },
			rt.ArrayItem{ key: 'asset', val: 'route/index.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/vips/loader' },
			rt.ArrayItem{ key: 'path', val: 'vips/loader' },
			rt.ArrayItem{ key: 'asset', val: 'vips/loader.min.asset.php' },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/vips/worker' },
			rt.ArrayItem{ key: 'path', val: 'vips/worker' },
			rt.ArrayItem{ key: 'asset', val: 'vips/worker.min.asset.php' },
			rt.ArrayItem{ key: 'min_only', val: true },
		]) },
		rt.ArrayItem{ key: none, val: rt.create_array([
			rt.ArrayItem{ key: 'id', val: '@wordpress/workflow' },
			rt.ArrayItem{ key: 'path', val: 'workflow/index' },
			rt.ArrayItem{ key: 'asset', val: 'workflow/index.min.asset.php' },
		]) },
	])
}

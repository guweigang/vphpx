module appx

import httpx
import viewx
import vphp

@[php_arg_name: 'base_path=basePath']
@[php_method: 'setViewBasePath']
pub fn (mut app VSlimApp) set_view_base_path(base_path string) &VSlimApp {
	app.view_base_path = base_path.trim_space()
	return app
}

@[php_method: 'viewBasePath']
pub fn (app &VSlimApp) view_base_path() string {
	return app.view_base_path
}

@[php_method: 'setAssetsPrefix']
pub fn (mut app VSlimApp) set_assets_prefix(prefix string) &VSlimApp {
	app.assets_prefix = viewx.normalize_assets_prefix(prefix)
	return app
}

@[php_method: 'assetsPrefix']
pub fn (app &VSlimApp) assets_prefix() string {
	if app.assets_prefix == '' {
		return '/assets'
	}
	return app.assets_prefix
}

@[php_method: 'setViewCache']
pub fn (mut app VSlimApp) set_view_cache(enabled bool) &VSlimApp {
	app.view_cache_enabled = enabled
	app.view_cache_configured = true
	return app
}

@[php_method: 'viewCacheEnabled']
pub fn (app &VSlimApp) view_cache_enabled() bool {
	if app.view_cache_configured {
		return app.view_cache_enabled
	}
	if app.config_ref != unsafe { nil } && app.config_ref.has('view.cache') {
		return app.config_ref.get_bool('view.cache', viewx.default_view_cache_enabled())
	}
	return viewx.default_view_cache_enabled()
}

@[php_method: 'clearViewCache']
pub fn (mut app VSlimApp) clear_view_cache() &VSlimApp {
	viewx.clear_template_source_cache()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) helper(name string, handler vphp.PhpCallable) &VSlimApp {
	key := name.trim_space()
	if key == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'view helper must be callable', 0)
		return &app
	}
	viewx.register_view_helper(mut app.view_helpers, key, handler)
	return &app
}

@[php_method: 'makeView']
pub fn (app &VSlimApp) make_view() &viewx.VSlimView {
	return viewx.VSlimView.from_settings(viewx.ViewSettings{
		base_path:     app.view_base_path.clone()
		assets_prefix: app.assets_prefix().clone()
		cache_enabled: app.view_cache_enabled()
		helpers:       app.view_helpers
	})
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (app &VSlimApp) view(template string, data vphp.PhpValue) &httpx.VSlimPsr7Response {
	mut view := app.make_view()
	return view.render_response(template, data)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'viewWithLayout']
pub fn (app &VSlimApp) view_with_layout(template string, layout string, data vphp.PhpValue) &httpx.VSlimPsr7Response {
	mut view := app.make_view()
	return view.render_response_with_layout(template, layout, data)
}

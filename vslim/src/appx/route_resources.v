module appx

import routex
import vphp

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method]
pub fn (mut app VSlimApp) resource(resource_path string, controller string) &VSlimApp {
	app.register_resource_routes(resource_path, controller, true)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiResource']
pub fn (mut app VSlimApp) api_resource(resource_path string, controller string) &VSlimApp {
	app.register_resource_routes(resource_path, controller, false)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method]
pub fn (mut app VSlimApp) singleton(resource_path string, controller string) &VSlimApp {
	app.register_singleton_routes(resource_path, controller, true)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiSingleton']
pub fn (mut app VSlimApp) api_singleton(resource_path string, controller string) &VSlimApp {
	app.register_singleton_routes(resource_path, controller, false)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'resourceOpts']
pub fn (mut app VSlimApp) resource_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_resource_routes_with_options(resource_path, controller, true, opts)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiResourceOpts']
pub fn (mut app VSlimApp) api_resource_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_resource_routes_with_options(resource_path, controller, false, opts)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'singletonOpts']
pub fn (mut app VSlimApp) singleton_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_singleton_routes_with_options(resource_path, controller, true, opts)
	return app
}

@[php_arg_name(resource_path: 'resourcePath')]
@[php_method: 'apiSingletonOpts']
pub fn (mut app VSlimApp) api_singleton_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_singleton_routes_with_options(resource_path, controller, false, opts)
	return app
}

module appx

import routex
import vphp

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) resource(resource_path string, controller string) &VSlimApp {
	app.register_resource_routes(resource_path, controller, true)
	return app
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiResource')]
pub fn (mut app VSlimApp) api_resource(resource_path string, controller string) &VSlimApp {
	app.register_resource_routes(resource_path, controller, false)
	return app
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: '')]
pub fn (mut app VSlimApp) singleton(resource_path string, controller string) &VSlimApp {
	app.register_singleton_routes(resource_path, controller, true)
	return app
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiSingleton')]
pub fn (mut app VSlimApp) api_singleton(resource_path string, controller string) &VSlimApp {
	app.register_singleton_routes(resource_path, controller, false)
	return app
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'resourceOpts')]
pub fn (mut app VSlimApp) resource_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_resource_routes_with_options(resource_path, controller, true, opts)
	return app
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiResourceOpts')]
pub fn (mut app VSlimApp) api_resource_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_resource_routes_with_options(resource_path, controller, false, opts)
	return app
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'singletonOpts')]
pub fn (mut app VSlimApp) singleton_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_singleton_routes_with_options(resource_path, controller, true, opts)
	return app
}

@[vphp.PhpArgName(v_name: 'resource_path', php_name: 'resourcePath')]
@[vphp.PhpExportMethod(name: 'apiSingletonOpts')]
pub fn (mut app VSlimApp) api_singleton_opts(resource_path string, controller string, options vphp.PhpArray) &VSlimApp {
	opts := routex.ResourceRouteOptions.from_options(options)
	app.register_singleton_routes_with_options(resource_path, controller, false, opts)
	return app
}

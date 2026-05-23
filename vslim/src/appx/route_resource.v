module appx

import routex

fn (mut app VSlimApp) register_resource_routes(raw_resource_path string, controller string, include_page_routes bool) {
	app.register_resource_routes_with_options(raw_resource_path, controller, include_page_routes,
		routex.ResourceRouteOptions.default())
}

fn (mut app VSlimApp) register_singleton_routes(raw_resource_path string, controller string, include_page_routes bool) {
	app.register_singleton_routes_with_options(raw_resource_path, controller, include_page_routes,
		routex.ResourceRouteOptions.default())
}

fn (mut app VSlimApp) register_resource_routes_with_options(raw_resource_path string, controller string, include_page_routes bool, options routex.ResourceRouteOptions) {
	for item in routex.resource_route_plan(raw_resource_path, controller, include_page_routes,
		options) {
		app.add_route_with_resource_meta(item.method, item.name, item.pattern, item.handler,
			item.action, item.missing_handler)
	}
}

fn (mut app VSlimApp) register_singleton_routes_with_options(raw_resource_path string, controller string, include_page_routes bool, options routex.ResourceRouteOptions) {
	for item in routex.singleton_route_plan(raw_resource_path, controller, include_page_routes,
		options) {
		app.add_route_with_resource_meta(item.method, item.name, item.pattern, item.handler,
			item.action, item.missing_handler)
	}
}

module appx

import httpx
import vphp

@[vphp.PhpExportMethod(name: 'urlFor')]
pub fn (app &VSlimApp) url_for(name string, params vphp.PhpValue) string {
	return app.url_for_query_value(name, params, vphp.PhpValue.null())
}

@[vphp.PhpExportMethod(name: 'urlForQuery')]
pub fn (app &VSlimApp) url_for_query(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	return app.url_for_query_value(name, params, query)
}

fn (app &VSlimApp) url_for_query_value(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	params_map := params.to_string_map()
	query_map := query.to_string_map()
	position := app.route_index.index_for_name(name) or { return '' }
	return app.routes[position].url(app.base_path, &params_map, &query_map)
}

@[vphp.PhpExportMethod(name: 'urlForAbs')]
pub fn (app &VSlimApp) url_for_abs(name string, params vphp.PhpValue, scheme string, host string) string {
	return app.url_for_query_abs_value(name, params, vphp.PhpValue.null(), scheme, host)
}

@[vphp.PhpExportMethod(name: 'urlForQueryAbs')]
pub fn (app &VSlimApp) url_for_query_abs(name string, params vphp.PhpValue, query vphp.PhpValue, scheme string, host string) string {
	return app.url_for_query_abs_value(name, params, query, scheme, host)
}

fn (app &VSlimApp) url_for_query_abs_value(name string, params vphp.PhpValue, query vphp.PhpValue, scheme string, host string) string {
	params_map := params.to_string_map()
	query_map := query.to_string_map()
	position := app.route_index.index_for_name(name) or { return '' }
	return app.routes[position].url_abs(app.base_path, &params_map, &query_map, scheme, host)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'redirectTo')]
pub fn (app &VSlimApp) redirect_to(name string, params vphp.PhpValue) &httpx.VSlimPsr7Response {
	return app.redirect_to_query_value(name, params, vphp.PhpValue.null())
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'redirectToQuery')]
pub fn (app &VSlimApp) redirect_to_query(name string, params vphp.PhpValue, query vphp.PhpValue) &httpx.VSlimPsr7Response {
	return app.redirect_to_query_value(name, params, query)
}

fn (app &VSlimApp) redirect_to_query_value(name string, params vphp.PhpValue, query vphp.PhpValue) &httpx.VSlimPsr7Response {
	location := app.url_for_query_value(name, params, query)
	res := httpx.VSlimResponse.redirect_to(location)
	return res.to_psr7_response()
}

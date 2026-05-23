module appx

import httpx
import routex
import vphp

@[php_method: 'urlFor']
pub fn (app &VSlimApp) url_for(name string, params vphp.PhpValue) string {
	return app.url_for_query_value(name, params, vphp.PhpValue.null())
}

@[php_method: 'urlForQuery']
pub fn (app &VSlimApp) url_for_query(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	return app.url_for_query_value(name, params, query)
}

fn (app &VSlimApp) url_for_query_value(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	params_map := params.to_string_map()
	query_map := query.to_string_map()
	return routex.url_for(app.routes, app.base_path, name, params_map, query_map)
}

@[php_method: 'urlForAbs']
pub fn (app &VSlimApp) url_for_abs(name string, params vphp.PhpValue, scheme string, host string) string {
	return app.url_for_query_abs_value(name, params, vphp.PhpValue.null(), scheme, host)
}

@[php_method: 'urlForQueryAbs']
pub fn (app &VSlimApp) url_for_query_abs(name string, params vphp.PhpValue, query vphp.PhpValue, scheme string, host string) string {
	return app.url_for_query_abs_value(name, params, query, scheme, host)
}

fn (app &VSlimApp) url_for_query_abs_value(name string, params vphp.PhpValue, query vphp.PhpValue, scheme string, host string) string {
	params_map := params.to_string_map()
	query_map := query.to_string_map()
	return routex.url_for_abs(app.routes, app.base_path, name, params_map, query_map, scheme, host)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'redirectTo']
pub fn (app &VSlimApp) redirect_to(name string, params vphp.PhpValue) &httpx.VSlimPsr7Response {
	return app.redirect_to_query_value(name, params, vphp.PhpValue.null())
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'redirectToQuery']
pub fn (app &VSlimApp) redirect_to_query(name string, params vphp.PhpValue, query vphp.PhpValue) &httpx.VSlimPsr7Response {
	return app.redirect_to_query_value(name, params, query)
}

fn (app &VSlimApp) redirect_to_query_value(name string, params vphp.PhpValue, query vphp.PhpValue) &httpx.VSlimPsr7Response {
	location := app.url_for_query_value(name, params, query)
	res := httpx.VSlimResponse.redirect_to(location)
	return res.to_psr7_response()
}

module main

import vphp

fn (c &VSlimController) effective_app() &VSlimApp {
	runtime := current_runtime_dispatch_app()
	if runtime != unsafe { nil } {
		return runtime
	}
	return c.app_ref
}

@[php_method]
@[php_borrowed_return]
pub fn (mut c VSlimController) construct(app &VSlimApp) &VSlimController {
	c.app_ref = app
	return &c
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut c VSlimController) set_app(app &VSlimApp) &VSlimController {
	c.app_ref = app
	return &c
}

@[php_method: 'setView']
@[php_borrowed_return]
pub fn (mut c VSlimController) set_view(view &VSlimView) &VSlimController {
	c.view_ref = view
	return &c
}

@[php_method]
@[php_borrowed_return]
pub fn (c &VSlimController) app() &VSlimApp {
	app := c.effective_app()
	if app == unsafe { nil } {
		vphp.PhpException.raise_class('RuntimeException', 'controller is not bound to an app', 0)
		return unsafe { nil }
	}
	return app
}

@[php_method]
pub fn (mut c VSlimController) view() &VSlimView {
	if c.view_ref != unsafe { nil } {
		return c.view_ref
	}
	app := c.effective_app()
	if app != unsafe { nil } {
		c.view_ref = app.make_view()
		return c.view_ref
	}
	c.view_ref = &VSlimView{
		base_path: ''
		assets_prefix: '/assets'
		cache_enabled: default_view_cache_enabled()
		helpers: map[string]vphp.PhpCallable{}
	}
	return c.view_ref
}

@[php_method]
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
pub fn (mut c VSlimController) render(template string, data vphp.PhpValue) &VSlimPsr7Response {
	mut view := c.view()
	body := view.render(template, data)
	mut res := VSlimResponse{}
	res.construct(200, body, 'text/html; charset=utf-8')
	return res.to_psr7_response()
}

@[php_method: 'renderWithLayout']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
pub fn (mut c VSlimController) render_with_layout(template string, layout string, data vphp.PhpValue) &VSlimPsr7Response {
	mut view := c.view()
	body := view.render_with_layout(template, layout, data)
	mut res := VSlimResponse{}
	res.construct(200, body, 'text/html; charset=utf-8')
	return res.to_psr7_response()
}

@[php_method: 'urlFor']
pub fn (c &VSlimController) url_for(name string, params vphp.PhpValue) string {
	app := c.effective_app()
	if app == unsafe { nil } {
		return ''
	}
	return app.url_for(name, params)
}

@[php_method: 'urlForQuery']
pub fn (c &VSlimController) url_for_query(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	app := c.effective_app()
	if app == unsafe { nil } {
		return ''
	}
	return app.url_for_query(name, params, query)
}

@[php_method]
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
pub fn (c &VSlimController) text(body string, status int) &VSlimPsr7Response {
	mut res := VSlimResponse{}
	res.construct(status, body, 'text/plain; charset=utf-8')
	return res.to_psr7_response()
}

@[php_method]
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
pub fn (c &VSlimController) json(body string, status int) &VSlimPsr7Response {
	mut res := VSlimResponse{}
	res.construct(status, body, 'application/json; charset=utf-8')
	return res.to_psr7_response()
}

@[php_method]
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
pub fn (c &VSlimController) redirect(location string, status int) &VSlimPsr7Response {
	mut res := VSlimResponse{
		status:       if status == 0 { 302 } else { status }
		body:         ''
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type': 'text/plain; charset=utf-8'
		}
	}
	res.set_header('location', location)
	return res.to_psr7_response()
}

@[php_method: 'redirectTo']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
pub fn (c &VSlimController) redirect_to(name string, params vphp.PhpValue, status int) &VSlimPsr7Response {
	location := c.url_for(name, params)
	if location == '' {
		return c.text('route not found', 404)
	}
	return c.redirect(location, status)
}

@[php_method: 'redirectToQuery']
@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
pub fn (c &VSlimController) redirect_to_query(name string, params vphp.PhpValue, query vphp.PhpValue, status int) &VSlimPsr7Response {
	location := c.url_for_query(name, params, query)
	if location == '' {
		return c.text('route not found', 404)
	}
	return c.redirect(location, status)
}

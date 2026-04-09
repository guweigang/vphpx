module main

import vphp

@[php_method]
pub fn (mut c VSlimController) construct(app &VSlimApp) &VSlimController {
	c.app_ref = app
	return &c
}

@[php_method]
pub fn (mut c VSlimController) set_app(app &VSlimApp) &VSlimController {
	c.app_ref = app
	return &c
}

@[php_method]
pub fn (mut c VSlimController) set_view(view &VSlimView) &VSlimController {
	c.view_ref = view
	return &c
}

@[php_method]
@[php_borrowed_return]
pub fn (c &VSlimController) app() &VSlimApp {
	if c.app_ref == unsafe { nil } {
		vphp.throw_exception_class('RuntimeException', 'controller is not bound to an app', 0)
		return unsafe { nil }
	}
	return c.app_ref
}

@[php_method]
pub fn (mut c VSlimController) view() &VSlimView {
	if c.view_ref != unsafe { nil } {
		return c.view_ref
	}
	if c.app_ref != unsafe { nil } {
		c.view_ref = c.app_ref.make_view()
		return c.view_ref
	}
	c.view_ref = &VSlimView{
		base_path: ''
		assets_prefix: '/assets'
		cache_enabled: default_view_cache_enabled()
		helpers: map[string]vphp.PersistentOwnedZBox{}
	}
	return c.view_ref
}

@[php_method]
pub fn (mut c VSlimController) render(template string, data vphp.RequestBorrowedZBox) &VSlimResponse {
	mut view := c.view()
	body := view.render(template, data)
	return &VSlimResponse{
		status:       200
		body:         body.clone()
		content_type: 'text/html; charset=utf-8'
		headers:      map[string]string{}
	}
}

@[php_method]
pub fn (mut c VSlimController) render_with_layout(template string, layout string, data vphp.RequestBorrowedZBox) &VSlimResponse {
	mut view := c.view()
	body := view.render_with_layout(template, layout, data)
	return &VSlimResponse{
		status:       200
		body:         body.clone()
		content_type: 'text/html; charset=utf-8'
		headers:      map[string]string{}
	}
}

@[php_method]
pub fn (c &VSlimController) url_for(name string, params vphp.RequestBorrowedZBox) string {
	if c.app_ref == unsafe { nil } {
		return ''
	}
	return c.app_ref.url_for(name, params)
}

@[php_method]
pub fn (c &VSlimController) url_for_query(name string, params vphp.RequestBorrowedZBox, query vphp.RequestBorrowedZBox) string {
	if c.app_ref == unsafe { nil } {
		return ''
	}
	return c.app_ref.url_for_query(name, params, query)
}

@[php_method]
pub fn (c &VSlimController) text(body string, status int) &VSlimResponse {
	return &VSlimResponse{
		status:       status
		body:         body.clone()
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type': 'text/plain; charset=utf-8'
		}
	}
}

@[php_method]
pub fn (c &VSlimController) json(body string, status int) &VSlimResponse {
	return &VSlimResponse{
		status:       status
		body:         body.clone()
		content_type: 'application/json; charset=utf-8'
		headers:      {
			'content-type': 'application/json; charset=utf-8'
		}
	}
}

@[php_method]
pub fn (c &VSlimController) redirect(location string, status int) &VSlimResponse {
	mut res := VSlimResponse{
		status:       if status == 0 { 302 } else { status }
		body:         ''
		content_type: 'text/plain; charset=utf-8'
		headers:      {
			'content-type': 'text/plain; charset=utf-8'
		}
	}
	res.set_header('location', location)
	return to_vslim_response(res)
}

@[php_method]
pub fn (c &VSlimController) redirect_to(name string, params vphp.RequestBorrowedZBox, status int) &VSlimResponse {
	location := c.url_for(name, params)
	if location == '' {
		return c.text('route not found', 404)
	}
	return c.redirect(location, status)
}

@[php_method]
pub fn (c &VSlimController) redirect_to_query(name string, params vphp.RequestBorrowedZBox, query vphp.RequestBorrowedZBox, status int) &VSlimResponse {
	location := c.url_for_query(name, params, query)
	if location == '' {
		return c.text('route not found', 404)
	}
	return c.redirect(location, status)
}

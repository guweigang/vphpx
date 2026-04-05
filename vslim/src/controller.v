module main

import vphp

@[php_method]
pub fn (mut c VSlimController) construct(app &VSlimApp) &VSlimController {
	c.host.set_app_ref(app)
	return &c
}

@[php_method]
pub fn (mut c VSlimController) set_app(app &VSlimApp) &VSlimController {
	c.host.set_app_ref(app)
	return &c
}

@[php_method]
pub fn (mut c VSlimController) set_view(view &VSlimView) &VSlimController {
	c.host.set_view_ref(view)
	return &c
}

@[php_method]
pub fn (mut c VSlimController) view() &VSlimView {
	return c.host.view()
}

@[php_method]
pub fn (mut c VSlimController) render(template string, data vphp.RequestBorrowedZBox) &VSlimResponse {
	body := c.host.render_template_data(template, data)
	return &VSlimResponse{
		status:       200
		body:         body
		content_type: 'text/html; charset=utf-8'
		headers:      map[string]string{}
	}
}

@[php_method]
pub fn (mut c VSlimController) render_with_layout(template string, layout string, data vphp.RequestBorrowedZBox) &VSlimResponse {
	body := c.host.render_template_with_layout_data(template, layout, data)
	return &VSlimResponse{
		status:       200
		body:         body
		content_type: 'text/html; charset=utf-8'
		headers:      map[string]string{}
	}
}

@[php_method]
pub fn (c &VSlimController) url_for(name string, params vphp.RequestBorrowedZBox) string {
	mut host := c.host
	if host.app() == unsafe { nil } {
		return ''
	}
	return host.app().url_for(name, params)
}

@[php_method]
pub fn (c &VSlimController) url_for_query(name string, params vphp.RequestBorrowedZBox, query vphp.RequestBorrowedZBox) string {
	mut host := c.host
	if host.app() == unsafe { nil } {
		return ''
	}
	return host.app().url_for_query(name, params, query)
}

@[php_method]
pub fn (c &VSlimController) text(body string, status int) &VSlimResponse {
	return &VSlimResponse{
		status:       status
		body:         body
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
		body:         body
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

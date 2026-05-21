module controllerx

import containerx
import httpx
import supportx
import viewx
import vphp

fn (c &VSlimController) app_object() ?vphp.PhpObject {
	if c.app_ref.is_valid() {
		return c.app_ref.retain()
	}
	if c.container_ref == unsafe { nil } {
		return none
	}
	unsafe {
		mut container := c.container_ref
		mut value := container.get_value(service_app) or { return none }
		defer {
			value.release()
		}
		object := value.as_object() or { return none }
		return object.retain()
	}
}

fn (mut c VSlimController) bind_app_object(app vphp.PhpObject) {
	if !app.is_valid() {
		return
	}
	mut old := c.app_ref
	old.release()
	c.app_ref = app.retain()
	if app.method_exists('container') {
		mut container_value := app.call_method('container')
		defer {
			container_value.release()
		}
		if container_object := container_value.as_object() {
			if container := container_object.to_v_object[containerx.VSlimContainer]() {
				c.container_ref = container
			}
		}
	}
	if c.container_ref != unsafe { nil } {
		mut value := app.retain().to_value()
		mut container := c.container_ref
		container.set(service_app, value)
		value.release()
	}
}

pub fn register_convention_controller(mut container containerx.VSlimContainer, class_name string, app_value vphp.PhpValue) !bool {
	if container.has(class_name) {
		return false
	}
	if !vphp.PhpClass.named(class_name).is_subclass_of('VSlim\\Controller') {
		return false
	}
	if supportx.bootstrap_controller_declares_own_constructor(class_name) {
		return false
	}
	controller_obj := vphp.PhpClass.named(class_name).construct(app_value) or {
		return error('controller class "${class_name}" could not be instantiated')
	}
	container.set_object(class_name, controller_obj)
	return true
}

@[php_borrowed_return; php_method]
pub fn (mut c VSlimController) construct(app vphp.PhpObject) &VSlimController {
	c.bind_app_object(app)
	return &c
}

@[php_method: 'setApp']
@[php_borrowed_return]
pub fn (mut c VSlimController) set_app(app vphp.PhpObject) &VSlimController {
	c.bind_app_object(app)
	return &c
}

@[php_method: 'setView']
@[php_borrowed_return]
pub fn (mut c VSlimController) set_view(view &viewx.VSlimView) &VSlimController {
	c.view_ref = view
	return &c
}

@[php_method]
pub fn (c &VSlimController) app() vphp.PhpObject {
	app := c.app_object() or {
		vphp.PhpException.raise_class('RuntimeException', 'controller is not bound to an app', 0)
		return vphp.PhpObject.invalid()
	}
	return app
}

@[php_method]
pub fn (mut c VSlimController) view() &viewx.VSlimView {
	if c.view_ref != unsafe { nil } {
		return c.view_ref
	}
	if c.container_ref != unsafe { nil } {
		unsafe {
			mut container := c.container_ref
			mut value := container.get_value(viewx.service_view) or { vphp.PhpValue.invalid() }
			defer {
				value.release()
			}
			if object := value.as_object() {
				if view := object.to_v_object[viewx.VSlimView]() {
					c.view_ref = view
					return c.view_ref
				}
			}
		}
	}
	c.view_ref = &viewx.VSlimView{
		base_path:     ''
		assets_prefix: '/assets'
		cache_enabled: viewx.default_view_cache_enabled()
		helpers:       map[string]vphp.PhpCallable{}
	}
	return c.view_ref
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (mut c VSlimController) render(template string, data vphp.PhpValue) &httpx.VSlimPsr7Response {
	mut view := c.view()
	body := view.render(template, data)
	res := httpx.VSlimResponse.html(200, body)
	return res.to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'renderWithLayout']
pub fn (mut c VSlimController) render_with_layout(template string, layout string, data vphp.PhpValue) &httpx.VSlimPsr7Response {
	mut view := c.view()
	body := view.render_with_layout(template, layout, data)
	res := httpx.VSlimResponse.html(200, body)
	return res.to_psr7_response()
}

@[php_method: 'urlFor']
pub fn (c &VSlimController) url_for(name string, params vphp.PhpValue) string {
	app := c.app_object() or { return '' }
	defer {
		app.release()
	}
	mut name_arg := vphp.PhpString.of(name)
	defer {
		name_arg.release()
	}
	return app.with_method_result[vphp.PhpString, string]('urlFor', fn (z vphp.PhpString) string {
		return z.value()
	}, name_arg, params) or { '' }
}

@[php_method: 'urlForQuery']
pub fn (c &VSlimController) url_for_query(name string, params vphp.PhpValue, query vphp.PhpValue) string {
	app := c.app_object() or { return '' }
	defer {
		app.release()
	}
	mut name_arg := vphp.PhpString.of(name)
	defer {
		name_arg.release()
	}
	return app.with_method_result[vphp.PhpString, string]('urlForQuery', fn (z vphp.PhpString) string {
		return z.value()
	}, name_arg, params, query) or { '' }
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (c &VSlimController) text(body string, status int) &httpx.VSlimPsr7Response {
	res := httpx.VSlimResponse.text(status, body)
	return res.to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (c &VSlimController) json(body string, status int) &httpx.VSlimPsr7Response {
	res := httpx.VSlimResponse.json(status, body)
	return res.to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method]
pub fn (c &VSlimController) redirect(location string, status int) &httpx.VSlimPsr7Response {
	res := httpx.VSlimResponse.redirect_to_status(location, status)
	return res.to_psr7_response()
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'redirectTo']
pub fn (c &VSlimController) redirect_to(name string, params vphp.PhpValue, status int) &httpx.VSlimPsr7Response {
	location := c.url_for(name, params)
	if location == '' {
		return c.text('route not found', 404)
	}
	return c.redirect(location, status)
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'redirectToQuery']
pub fn (c &VSlimController) redirect_to_query(name string, params vphp.PhpValue, query vphp.PhpValue, status int) &httpx.VSlimPsr7Response {
	location := c.url_for_query(name, params, query)
	if location == '' {
		return c.text('route not found', 404)
	}
	return c.redirect(location, status)
}

module main

import vphp

@[php_method]
pub fn (mut app VSlimApp) set_view_base_path(base_path string) &VSlimApp {
	app.view_base_path = base_path.trim_space()
	return app
}

@[php_method]
pub fn (app &VSlimApp) view_base_path() string {
	return app.view_base_path
}

@[php_method]
pub fn (mut app VSlimApp) set_assets_prefix(prefix string) &VSlimApp {
	app.assets_prefix = normalize_assets_prefix(prefix)
	return app
}

@[php_method]
pub fn (app &VSlimApp) assets_prefix() string {
	if app.assets_prefix == '' {
		return '/assets'
	}
	return app.assets_prefix
}

@[php_method]
pub fn (mut app VSlimApp) set_view_cache(enabled bool) &VSlimApp {
	app.view_cache_enabled = enabled
	app.view_cache_configured = true
	return app
}

@[php_method]
pub fn (app &VSlimApp) view_cache_enabled() bool {
	if app.view_cache_configured {
		return app.view_cache_enabled
	}
	return default_view_cache_enabled()
}

@[php_method]
pub fn (mut app VSlimApp) clear_view_cache() &VSlimApp {
	clear_template_source_cache()
	return app
}

@[php_method]
pub fn (mut app VSlimApp) helper(name string, handler vphp.BorrowedValue) &VSlimApp {
	key := name.trim_space()
	if key == '' || !handler.is_valid() || !handler.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'view helper must be callable', 0)
		return &app
	}
	ensure_view_helper_map(mut app.view_helpers)
	if key in app.view_helpers {
		mut existing := app.view_helpers[key] or { vphp.PersistentOwnedZVal.new_null() }
		release_view_helper(mut existing)
	}
	app.view_helpers[key] = vphp.PersistentOwnedZVal.from_zval(handler.to_zval())
	return &app
}

@[php_method]
pub fn (app &VSlimApp) make_view() &VSlimView {
	return &VSlimView{
		base_path: app.view_base_path
		assets_prefix: app.assets_prefix()
		cache_enabled: app.view_cache_enabled()
		helpers: clone_view_helper_map(app.view_helpers)
	}
}

// VSlimViewHost centralizes view wiring only: app/view references, template/layout,
// and render helpers. It intentionally does not own HTTP response helpers, routing,
// LiveView protocol state, or DOM patch semantics.
fn (mut host VSlimViewHost) set_app_ref(app &VSlimApp) {
	host.app_ref = app
}

fn (mut host VSlimViewHost) app() &VSlimApp {
	return host.app_ref
}

fn (mut host VSlimViewHost) set_view_ref(view &VSlimView) {
	host.view_ref = view
}

fn (mut host VSlimViewHost) view() &VSlimView {
	if host.view_ref != unsafe { nil } {
		return host.view_ref
	}
	if host.app_ref != unsafe { nil } {
		host.view_ref = host.app_ref.make_view()
		return host.view_ref
	}
	host.view_ref = &VSlimView{
		base_path: ''
		assets_prefix: '/assets'
		cache_enabled: default_view_cache_enabled()
		helpers: map[string]vphp.PersistentOwnedZVal{}
	}
	return host.view_ref
}

fn (mut host VSlimViewHost) set_template_name(template string) {
	host.template = template.trim_space()
}

fn (host &VSlimViewHost) template_name() string {
	return host.template
}

fn (mut host VSlimViewHost) set_layout_name(layout string) {
	host.layout = layout.trim_space()
}

fn (host &VSlimViewHost) layout_name() string {
	return host.layout
}

fn (mut host VSlimViewHost) render_template_data(template string, data vphp.BorrowedValue) string {
	mut view := host.view()
	return view.render(template, data)
}

fn (mut host VSlimViewHost) render_template_with_layout_data(template string, layout string, data vphp.BorrowedValue) string {
	mut view := host.view()
	return view.render_with_layout(template, layout, data)
}

fn (mut host VSlimViewHost) render_map_template(template string, data map[string]string) string {
	mut view := host.view()
	return view.render_map(template, data)
}

fn (mut host VSlimViewHost) render_map_template_with_layout(template string, layout string, data map[string]string) string {
	mut view := host.view()
	return view.render_maps_with_layout(template, layout, data, map[string][]string{}, map[string]vphp.RequestOwnedZVal{})
}

fn (mut host VSlimViewHost) html_map(data map[string]string) string {
	if host.template == '' {
		return ''
	}
	if host.layout != '' {
		return host.render_map_template_with_layout(host.template, host.layout, data)
	}
	return host.render_map_template(host.template, data)
}

@[php_method]
pub fn (app &VSlimApp) view(template string, data vphp.BorrowedValue) &VSlimResponse {
	mut view := app.make_view()
	return view.render_response(template, data)
}

@[php_method]
pub fn (app &VSlimApp) view_with_layout(template string, layout string, data vphp.BorrowedValue) &VSlimResponse {
	mut view := app.make_view()
	return view.render_response_with_layout(template, layout, data)
}

@[php_method]
pub fn (mut view VSlimView) construct(base_path string, assets_prefix string) &VSlimView {
	view.base_path = base_path.trim_space()
	view.assets_prefix = normalize_assets_prefix(assets_prefix)
	view.cache_enabled = default_view_cache_enabled()
	view.helpers = map[string]vphp.PersistentOwnedZVal{}
	return &view
}

@[php_method]
pub fn (mut view VSlimView) set_base_path(base_path string) &VSlimView {
	view.base_path = base_path.trim_space()
	return &view
}

@[php_method]
pub fn (view &VSlimView) base_path() string {
	return view.base_path
}

@[php_method]
pub fn (mut view VSlimView) set_assets_prefix(prefix string) &VSlimView {
	view.assets_prefix = normalize_assets_prefix(prefix)
	return &view
}

@[php_method]
pub fn (view &VSlimView) assets_prefix() string {
	if view.assets_prefix == '' {
		return '/assets'
	}
	return view.assets_prefix
}

@[php_method]
pub fn (mut view VSlimView) set_cache_enabled(enabled bool) &VSlimView {
	view.cache_enabled = enabled
	return &view
}

@[php_method]
pub fn (view &VSlimView) cache_enabled() bool {
	return view.cache_enabled
}

@[php_method]
pub fn (mut view VSlimView) clear_cache() &VSlimView {
	clear_template_source_cache()
	return &view
}

@[php_method]
pub fn (mut view VSlimView) helper(name string, handler vphp.BorrowedValue) &VSlimView {
	key := name.trim_space()
	if key == '' || !handler.is_valid() || !handler.is_callable() {
		vphp.throw_exception_class('InvalidArgumentException', 'view helper must be callable', 0)
		return &view
	}
	ensure_view_helper_map(mut view.helpers)
	if key in view.helpers {
		mut existing := view.helpers[key] or { vphp.PersistentOwnedZVal.new_null() }
		release_view_helper(mut existing)
	}
	view.helpers[key] = vphp.PersistentOwnedZVal.from_zval(handler.to_zval())
	return &view
}

@[php_method]
pub fn (view &VSlimView) asset(path string) string {
	clean := path.trim_space().trim_left('/')
	if clean == '' {
		return view.assets_prefix()
	}
	return '${view.assets_prefix()}/${clean}'
}

@[php_method]
pub fn (view &VSlimView) render(template string, data vphp.BorrowedValue) string {
	scalars, lists, objects := extract_template_data(data.to_zval())
	return view.render_maps(template, scalars, lists, objects)
}

pub fn (view &VSlimView) render_map(template string, data map[string]string) string {
	return view.render_maps(template, data, map[string][]string{}, map[string]vphp.RequestOwnedZVal{})
}

fn (view &VSlimView) render_maps(template string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZVal) string {
	return view.render_map_with_depth(template, scalars, lists, objects, 0)
}

fn (view &VSlimView) render_map_with_depth(template string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZVal, depth int) string {
	if depth > 8 {
		return ''
	}
	path := view.resolve_template_path(template)
	return view.render_template_path_with_slots(path, scalars, lists, objects, depth, map[string]string{}) or {
		return debug_template_error('template.missing', path, template, 0, 0)
	}
}

@[php_method]
pub fn (view &VSlimView) render_with_layout(template string, layout string, data vphp.BorrowedValue) string {
	scalars, lists, objects := extract_template_data(data.to_zval())
	return view.render_maps_with_layout(template, layout, scalars, lists, objects)
}

pub fn (view &VSlimView) render_map_with_layout(template string, layout string, data map[string]string) string {
	return view.render_maps_with_layout(template, layout, data, map[string][]string{}, map[string]vphp.RequestOwnedZVal{})
}

pub fn (view &VSlimView) render_maps_with_layout(template string, layout string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.RequestOwnedZVal) string {
	template_path := view.resolve_template_path(template)
	program := view.read_template_program(template_path) or {
		return debug_template_error('template.missing', template_path, template, 0, 0)
	}
	content, mut slots := view.render_template_content_and_slots(program.nodes, scalars, lists, objects, 0, template_path)
	if content == '' {
		return ''
	}
	layout_path := view.resolve_template_path(layout)
	slots['content'] = content
	layout_rendered := view.render_template_path_with_slots(layout_path, scalars, lists, objects, 0, slots) or {
		return debug_template_error('layout.missing', layout_path, layout, 0, 0)
	}
	return layout_rendered
}

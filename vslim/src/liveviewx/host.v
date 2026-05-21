module liveviewx

import containerx
import viewx
import vphp

struct VSlimViewHost {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil }
	view_ref      &viewx.VSlimView           = unsafe { nil }
	template      string
	layout        string
}

fn (mut host VSlimViewHost) set_container_ref(container &containerx.VSlimContainer) {
	host.container_ref = container
}

fn (mut host VSlimViewHost) set_view_ref(view &viewx.VSlimView) {
	host.view_ref = view
}

fn (mut host VSlimViewHost) view() &viewx.VSlimView {
	if host.view_ref != unsafe { nil } {
		return host.view_ref
	}
	if host.container_ref != unsafe { nil } {
		unsafe {
			mut container := &containerx.VSlimContainer(host.container_ref)
			mut value := container.get_value(viewx.service_view) or { vphp.PhpValue.invalid() }
			if value.is_valid() && value.is_object() {
				if view_obj := value.as_object() {
					if resolved := view_obj.to_v_object[viewx.VSlimView]() {
						host.view_ref = resolved
						value.release()
						return host.view_ref
					}
				}
			}
			value.release()
		}
	}
	host.view_ref = &viewx.VSlimView{
		base_path:     ''
		assets_prefix: '/assets'
		cache_enabled: viewx.default_view_cache_enabled()
		helpers:       map[string]vphp.PhpCallable{}
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

fn (mut host VSlimViewHost) render_template_data(template string, data vphp.PhpValue) string {
	mut view := host.view()
	return view.render(template, data)
}

fn (mut host VSlimViewHost) render_template_with_layout_data(template string, layout string, data vphp.PhpValue) string {
	mut view := host.view()
	return view.render_with_layout(template, layout, data)
}

fn (mut host VSlimViewHost) render_map_template(template string, data map[string]string) string {
	mut view := host.view()
	return view.render_map(template, data)
}

fn (mut host VSlimViewHost) render_map_template_with_layout(template string, layout string, data map[string]string) string {
	mut view := host.view()
	return view.render_maps_with_layout(template, layout, data, map[string][]string{},
		map[string]vphp.PhpValue{})
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

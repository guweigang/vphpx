module viewx

import vphp

@[php_class: 'VSlim\\View']
@[heap]
pub struct VSlimView {
pub mut:
	base_path     string                      @[php_prop: basePath]
	assets_prefix string                      @[php_prop: assetsPrefix]
	cache_enabled bool                        @[php_prop: cacheEnabled]
	helpers       map[string]vphp.PhpCallable @[php_ignore]
}

pub struct ViewSettings {
pub:
	base_path     string
	assets_prefix string
	cache_enabled bool
	helpers       map[string]vphp.PhpCallable
}

pub fn VSlimView.from_settings(settings ViewSettings) &VSlimView {
	return &VSlimView{
		base_path:     settings.base_path.clone()
		assets_prefix: normalize_assets_prefix(settings.assets_prefix)
		cache_enabled: settings.cache_enabled
		helpers:       clone_view_helper_map(settings.helpers)
	}
}

@[php_arg_name: 'base_path=basePath,assets_prefix=assetsPrefix']
@[php_method]
pub fn (mut view VSlimView) construct(base_path string, assets_prefix string) &VSlimView {
	view.base_path = base_path.trim_space()
	view.assets_prefix = normalize_assets_prefix(assets_prefix)
	view.cache_enabled = default_view_cache_enabled()
	view.helpers = map[string]vphp.PhpCallable{}
	return &view
}

@[php_arg_name: 'base_path=basePath']
@[php_method: 'setBasePath']
pub fn (mut view VSlimView) set_base_path(base_path string) &VSlimView {
	view.base_path = base_path.trim_space()
	return &view
}

@[php_method: 'basePath']
pub fn (view &VSlimView) base_path() string {
	return view.base_path
}

@[php_method: 'setAssetsPrefix']
pub fn (mut view VSlimView) set_assets_prefix(prefix string) &VSlimView {
	view.assets_prefix = normalize_assets_prefix(prefix)
	return &view
}

@[php_method: 'assetsPrefix']
pub fn (view &VSlimView) assets_prefix() string {
	if view.assets_prefix == '' {
		return '/assets'
	}
	return view.assets_prefix
}

@[php_method: 'setCacheEnabled']
pub fn (mut view VSlimView) set_cache_enabled(enabled bool) &VSlimView {
	view.cache_enabled = enabled
	return &view
}

@[php_method: 'cacheEnabled']
pub fn (view &VSlimView) cache_enabled() bool {
	return view.cache_enabled
}

@[php_method: 'clearCache']
pub fn (mut view VSlimView) clear_cache() &VSlimView {
	clear_template_source_cache()
	return &view
}

@[php_method]
pub fn (mut view VSlimView) helper(name string, handler vphp.PhpCallable) &VSlimView {
	key := name.trim_space()
	if key == '' {
		vphp.PhpException.raise_class('InvalidArgumentException', 'view helper must be callable', 0)
		return &view
	}
	register_view_helper(mut view.helpers, key, handler)
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
pub fn (view &VSlimView) render(template string, data vphp.PhpValue) string {
	scalars, lists, objects := value_subject(data).template_data()
	return view.render_maps(template, scalars, lists, objects)
}

pub fn (view &VSlimView) render_map(template string, data map[string]string) string {
	return view.render_maps(template, data, map[string][]string{}, map[string]vphp.PhpValue{})
}

fn (view &VSlimView) render_maps(template string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.PhpValue) string {
	return view.render_map_with_depth(template, scalars, lists, objects, 0)
}

fn (view &VSlimView) render_map_with_depth(template string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.PhpValue, depth int) string {
	if depth > 8 {
		return ''
	}
	path := view.resolve_template_path(template)
	return view.render_template_path_with_slots(path, scalars, lists, objects, depth,
		map[string]string{}) or {
		return debug_template_error('template.missing', path, template, 0, 0)
	}
}

@[php_method: 'renderWithLayout']
pub fn (view &VSlimView) render_with_layout(template string, layout string, data vphp.PhpValue) string {
	scalars, lists, objects := value_subject(data).template_data()
	return view.render_maps_with_layout(template, layout, scalars, lists, objects)
}

pub fn (view &VSlimView) render_map_with_layout(template string, layout string, data map[string]string) string {
	return view.render_maps_with_layout(template, layout, data, map[string][]string{},
		map[string]vphp.PhpValue{})
}

pub fn (view &VSlimView) render_maps_with_layout(template string, layout string, scalars map[string]string, lists map[string][]string, objects map[string]vphp.PhpValue) string {
	template_path := view.resolve_template_path(template)
	program := view.read_template_program(template_path) or {
		return debug_template_error('template.missing', template_path, template, 0, 0)
	}
	content, mut slots := view.render_template_content_and_slots(program.nodes, scalars, lists,
		objects, 0, template_path)
	if content == '' {
		return ''
	}
	layout_path := view.resolve_template_path(layout)
	slots['content'] = content
	layout_rendered := view.render_template_path_with_slots(layout_path, scalars, lists, objects,
		0, slots) or { return debug_template_error('layout.missing', layout_path, layout, 0, 0) }
	return layout_rendered
}

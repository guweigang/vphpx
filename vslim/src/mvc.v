module main

import vphp

@[php_class: 'VSlim\\View']
@[heap]
struct VSlimView {
mut:
	base_path     string @[php_prop: basePath]
	assets_prefix string @[php_prop: assetsPrefix]
	cache_enabled bool   @[php_prop: cacheEnabled]
	helpers       map[string]vphp.PersistentOwnedZBox @[php_ignore]
}

struct VSlimViewHost {
mut:
	app_ref  &VSlimApp  = unsafe { nil }
	view_ref &VSlimView = unsafe { nil }
	template string
	layout   string
}

@[php_class: 'VSlim\\Controller']
@[heap]
struct VSlimController {
mut:
	app_ref  &VSlimApp  = unsafe { nil } @[php_ignore]
	view_ref &VSlimView = unsafe { nil } @[php_ignore]
}

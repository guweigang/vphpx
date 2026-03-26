module main

import vphp

@[php_class: 'VSlim\\View']
@[heap]
struct VSlimView {
mut:
	base_path     string
	assets_prefix string
	cache_enabled bool
	helpers       map[string]vphp.PersistentOwnedZVal
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
	host VSlimViewHost
}

module appx

import vphp

pub fn VSlimApp.new_core() &VSlimApp {
	return &VSlimApp{
		not_found_handler: vphp.PhpCallable.invalid()
		error_handler:     vphp.PhpCallable.invalid()
		clock_ref:         vphp.PhpObject.invalid()
		view_helpers:      map[string]vphp.PhpCallable{}
		providers:         []vphp.PhpObject{}
		provider_classes:  map[string]bool{}
		modules:           []vphp.PhpObject{}
		module_classes:    map[string]bool{}
		live_ws_sockets:   map[string]vphp.PhpObject{}
	}
}

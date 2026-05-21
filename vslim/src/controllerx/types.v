module controllerx

import containerx
import viewx
import vphp

@[php_class: 'VSlim\\Controller']
@[heap]
pub struct VSlimController {
mut:
	app_ref       vphp.PhpObject             = vphp.PhpObject.invalid()             @[php_ignore]
	container_ref &containerx.VSlimContainer = unsafe { nil } @[php_ignore]
	view_ref      &viewx.VSlimView           = unsafe { nil }           @[php_ignore]
}

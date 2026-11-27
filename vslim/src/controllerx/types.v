module controllerx

import containerx
import viewx
import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Controller')]
@[heap]
pub struct VSlimController {
mut:
	app_ref       vphp.PhpObject             = vphp.PhpObject.invalid() @[vphp.PhpIgnoreField]
	container_ref &containerx.VSlimContainer = unsafe { nil }           @[vphp.PhpIgnoreField]
	view_ref      &viewx.VSlimView           = unsafe { nil }           @[vphp.PhpIgnoreField]
}

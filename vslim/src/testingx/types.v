module testingx

import containerx
import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Testing\\Harness')]
@[heap]
pub struct VSlimTestingHarness {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[vphp.PhpIgnoreField]
	cookies       map[string]string
}

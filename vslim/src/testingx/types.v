module testingx

import containerx

@[php_class: 'VSlim\\Testing\\Harness']
@[heap]
pub struct VSlimTestingHarness {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[php_ignore]
	cookies       map[string]string
}

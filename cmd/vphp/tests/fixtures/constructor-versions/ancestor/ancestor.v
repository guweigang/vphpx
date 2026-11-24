module ancestor

import vphp

@[vphp.PhpExportClass(name: 'VphpNativeAncestor')]
@[vphp.PhpExtends(name: 'Exception')]
pub struct NativeAncestor {
pub mut:
	count int           = 29
	value vphp.PhpValue = vphp.PhpValue.string('ancestor')
}

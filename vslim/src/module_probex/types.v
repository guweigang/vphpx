module module_probex

import eventx
import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Dev\\PhpSignatureProbe')]
@[heap]
pub struct VSlimPhpSignatureProbe {
mut:
	provider_ref &eventx.VSlimPsr14ListenerProvider = unsafe { nil } @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportClass(name: 'VSlim\\Debug\\ObjectProbe')]
@[heap]
pub struct VSlimDebugObjectProbe {}

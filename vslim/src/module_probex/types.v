module module_probex

import eventx

@[php_class: 'VSlim\\Dev\\PhpSignatureProbe']
@[heap]
pub struct VSlimPhpSignatureProbe {
mut:
	provider_ref &eventx.VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
}

@[php_class: 'VSlim\\Debug\\ObjectProbe']
@[heap]
pub struct VSlimDebugObjectProbe {}

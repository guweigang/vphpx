module eventx

import vphp

@[vphp.PhpImplements(names: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr14\\ListenerProvider')]
@[heap]
pub struct VSlimPsr14ListenerProvider {
mut:
	listeners map[string][]vphp.PhpCallable
}

@[vphp.PhpImplements(names: 'Psr\\EventDispatcher\\EventDispatcherInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr14\\EventDispatcher')]
@[heap]
pub struct VSlimPsr14EventDispatcher {
mut:
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil } @[vphp.PhpIgnoreField]
}

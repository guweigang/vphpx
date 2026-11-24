module eventx

import vphp

@[vphp.PhpExternalInterface(name: 'Psr\\EventDispatcher\\ListenerProviderInterface')]
pub interface PsrListenerProviderContract {}

pub type PsrListenerProvider = vphp.PhpInterface[PsrListenerProviderContract]

type ListenerRegistration = vphp.PhpCallable | vphp.PhpWeakReference

@[vphp.PhpImplements(names: 'Psr\\EventDispatcher\\ListenerProviderInterface, Countable')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr14\\ListenerProvider')]
@[heap]
pub struct VSlimPsr14ListenerProvider {
mut:
	listeners map[string][]ListenerRegistration
}

@[vphp.PhpImplements(names: 'Psr\\EventDispatcher\\EventDispatcherInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr14\\EventDispatcher')]
@[heap]
pub struct VSlimPsr14EventDispatcher {
mut:
	provider_ref        &VSlimPsr14ListenerProvider = unsafe { nil } @[vphp.PhpIgnoreField]
	provider_object_ref vphp.PhpObject @[vphp.PhpIgnoreField]
}

module eventx

import vphp

@[php_implements: 'Psr\\EventDispatcher\\ListenerProviderInterface']
@[php_class: 'VSlim\\Psr14\\ListenerProvider']
@[heap]
pub struct VSlimPsr14ListenerProvider {
mut:
	listeners map[string][]vphp.PhpCallable
}

@[php_implements: 'Psr\\EventDispatcher\\EventDispatcherInterface']
@[php_class: 'VSlim\\Psr14\\EventDispatcher']
@[heap]
pub struct VSlimPsr14EventDispatcher {
mut:
	provider_ref &VSlimPsr14ListenerProvider = unsafe { nil } @[php_ignore]
}

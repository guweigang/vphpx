module sessionx

import containerx
import vphp

@[vphp.PhpImplements(names: 'Psr\\Http\\Server\\MiddlewareInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Session\\StartMiddleware')]
@[heap]
pub struct VSlimSessionStartMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[vphp.PhpIgnoreField]
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Server\\MiddlewareInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Auth\\RequireAuthMiddleware')]
@[heap]
pub struct VSlimAuthRequireMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[vphp.PhpIgnoreField]
	redirect_path string @[vphp.PhpProperty; vphp.PhpProperty_name: 'redirectPath']
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Server\\MiddlewareInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Auth\\GuestMiddleware')]
@[heap]
pub struct VSlimAuthGuestMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[vphp.PhpIgnoreField]
	redirect_path string @[vphp.PhpProperty; vphp.PhpProperty_name: 'redirectPath']
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Server\\MiddlewareInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Auth\\RequireAbilityMiddleware')]
@[heap]
pub struct VSlimAuthRequireAbilityMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[vphp.PhpIgnoreField]
	ability       string
	status        int = 403
	message       string
}

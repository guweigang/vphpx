module sessionx

import containerx

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Session\\StartMiddleware']
@[heap]
pub struct VSlimSessionStartMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\RequireAuthMiddleware']
@[heap]
pub struct VSlimAuthRequireMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[php_ignore]
	redirect_path string                     @[php_prop: redirectPath]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\GuestMiddleware']
@[heap]
pub struct VSlimAuthGuestMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[php_ignore]
	redirect_path string                     @[php_prop: redirectPath]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\RequireAbilityMiddleware']
@[heap]
pub struct VSlimAuthRequireAbilityMiddleware {
mut:
	container_ref &containerx.VSlimContainer = unsafe { nil } @[php_ignore]
	ability       string
	status        int = 403
	message       string
}

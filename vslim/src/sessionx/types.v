module sessionx

import vphp

@[vphp.PhpExportClass(name: 'VSlim\\Session\\Store')]
@[heap]
pub struct VSlimSessionStore {
mut:
	cookie_name string = 'vslim_session' @[vphp.PhpProperty(name: 'cookieName')]
	secret      string
	ttl_seconds int    = 7200 @[vphp.PhpProperty(name: 'ttlSeconds')]
	path        string = '/'
	domain      string
	secure      bool
	http_only   bool   = true     @[vphp.PhpProperty(name: 'httpOnly')]
	same_site   string = 'lax'    @[vphp.PhpProperty(name: 'sameSite')]
	values      map[string]string @[vphp.PhpIgnoreField]
	loaded      bool
	dirty       bool @[vphp.PhpIgnoreField]
	destroyed   bool @[vphp.PhpIgnoreField]
}

@[vphp.PhpExportClass(name: 'VSlim\\Auth\\SessionGuard')]
@[heap]
pub struct VSlimAuthSessionGuard {
mut:
	store_ref &VSlimSessionStore = unsafe { nil } @[vphp.PhpIgnoreField]
	user_key  string             = 'auth.user_id' @[vphp.PhpProperty(name: 'userKey')]
}

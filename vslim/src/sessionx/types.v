module sessionx

@[php_class: 'VSlim\\Session\\Store']
@[heap]
pub struct VSlimSessionStore {
mut:
	cookie_name string = 'vslim_session' @[php_prop: cookieName]
	secret      string
	ttl_seconds int    = 7200 @[php_prop: ttlSeconds]
	path        string = '/'
	domain      string
	secure      bool
	http_only   bool   = true              @[php_prop: httpOnly]
	same_site   string = 'lax'            @[php_prop: sameSite]
	values      map[string]string @[php_ignore]
	loaded      bool
	dirty       bool @[php_ignore]
	destroyed   bool @[php_ignore]
}

@[php_class: 'VSlim\\Auth\\SessionGuard']
@[heap]
pub struct VSlimAuthSessionGuard {
mut:
	store_ref &VSlimSessionStore = unsafe { nil } @[php_ignore]
	user_key  string             = 'auth.user_id'             @[php_prop: userKey]
}

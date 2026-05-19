module main

@[php_class: 'VSlim\\VHttpd\\Request']
@[heap]
struct VSlimRequest {
pub mut:
	method           string
	raw_path         string @[php_prop: rawPath]
	body             string
	scheme           string
	host             string
	port             string
	protocol_version string @[php_prop: protocolVersion]
	remote_addr      string @[php_prop: remoteAddr]
mut:
	path           string @[php_ignore]
	query_string   string @[php_ignore]
	query          map[string]string
	headers        map[string]string
	cookies        map[string]string
	attributes     map[string]string
	server         map[string]string
	uploaded_files []string @[php_prop: uploadedFiles]
	params         map[string]string
}

@[php_class: 'VSlim\\VHttpd\\Client']
@[heap]
struct VSlimVhttpdClient {
mut:
	socket_path             string @[php_prop: socketPath]
	connect_timeout_seconds f64 = 2.0    @[php_prop: connectTimeoutSeconds]
}

@[php_class: 'VSlim\\Session\\Store']
@[heap]
struct VSlimSessionStore {
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
struct VSlimAuthSessionGuard {
mut:
	store_ref &VSlimSessionStore = unsafe { nil } @[php_ignore]
	user_key  string             = 'auth.user_id'             @[php_prop: userKey]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Session\\StartMiddleware']
@[heap]
struct VSlimSessionStartMiddleware {
mut:
	app_ref &VSlimApp = unsafe { nil } @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\RequireAuthMiddleware']
@[heap]
struct VSlimAuthRequireMiddleware {
mut:
	app_ref       &VSlimApp = unsafe { nil } @[php_ignore]
	redirect_path string    @[php_prop: redirectPath]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\GuestMiddleware']
@[heap]
struct VSlimAuthGuestMiddleware {
mut:
	app_ref       &VSlimApp = unsafe { nil } @[php_ignore]
	redirect_path string    @[php_prop: redirectPath]
}

@[php_implements: 'Psr\\Http\\Server\\MiddlewareInterface']
@[php_class: 'VSlim\\Auth\\RequireAbilityMiddleware']
@[heap]
struct VSlimAuthRequireAbilityMiddleware {
mut:
	app_ref &VSlimApp = unsafe { nil } @[php_ignore]
	ability string
	status  int = 403
	message string
}

@[php_class: 'VSlim\\VHttpd\\Response']
@[heap]
struct VSlimResponse {
pub mut:
	status       int
	body         string
	content_type string @[php_prop: contentType]
mut:
	headers map[string]string
}

@[php_class: 'VSlim\\Psr7Adapter']
@[heap]
struct VSlimPsr7Adapter {}

@[php_class: 'VSlim\\Debug\\ObjectProbe']
@[heap]
struct VSlimDebugObjectProbe {}

pub fn (req &VSlimRequest) free() {
	_ = req
}

pub fn (res &VSlimResponse) free() {
	_ = res
}

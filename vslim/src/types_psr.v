module main

import vphp

@[php_implements: 'Psr\\Http\\Message\\StreamInterface']
@[php_class: 'VSlim\\Psr7\\Stream']
@[heap]
struct VSlimPsr7Stream {
mut:
	content  string
	position int
	detached bool
	metadata map[string]string
}

@[php_implements: 'Psr\\Http\\Message\\UploadedFileInterface']
@[php_class: 'VSlim\\Psr7\\UploadedFile']
@[heap]
struct VSlimPsr7UploadedFile {
mut:
	stream_ref        &VSlimPsr7Stream = unsafe { nil } @[php_ignore]
	size_hint         int              = -1              @[php_ignore]
	error_code        int              @[php_ignore]
	client_filename   string           @[php_ignore]
	client_media_type string           @[php_ignore]
	moved             bool
	target_path       string @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\ResponseInterface']
@[php_class: 'VSlim\\Psr7\\Response']
@[heap]
struct VSlimPsr7Response {
mut:
	status           int = 200
	reason_phrase    string              @[php_ignore]
	protocol_version string = '1.1'              @[php_ignore]
	headers          map[string][]string @[php_ignore]
	header_names     map[string]string   @[php_ignore]
	body_ref         &VSlimPsr7Stream = unsafe { nil }    @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\UriInterface']
@[php_class: 'VSlim\\Psr7\\Uri']
@[heap]
struct VSlimPsr7Uri {
mut:
	scheme   string
	user     string
	password string
	host     string
	port     int = -1
	path     string
	query    string
	fragment string
}

@[php_implements: 'Psr\\Http\\Message\\RequestInterface']
@[php_class: 'VSlim\\Psr7\\Request']
@[heap]
struct VSlimPsr7Request {
mut:
	method           string = 'GET'
	request_target   string              @[php_ignore]
	protocol_version string = '1.1'              @[php_ignore]
	headers          map[string][]string @[php_ignore]
	header_names     map[string]string   @[php_ignore]
	body_ref         &VSlimPsr7Stream = unsafe { nil }    @[php_ignore]
	uri_ref          &VSlimPsr7Uri    = unsafe { nil }       @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_class: 'VSlim\\Psr7\\ServerRequest']
@[heap]
struct VSlimPsr7ServerRequest {
mut:
	method             string = 'GET'
	request_target     string              @[php_ignore]
	protocol_version   string = '1.1'              @[php_ignore]
	headers            map[string][]string @[php_ignore]
	header_names       map[string]string   @[php_ignore]
	body_ref           &VSlimPsr7Stream = unsafe { nil }    @[php_ignore]
	uri_ref            &VSlimPsr7Uri    = unsafe { nil }       @[php_ignore]
	server_params_ref  vphp.PhpArray       @[php_ignore]
	cookie_params_ref  vphp.PhpArray       @[php_ignore]
	query_params_ref   vphp.PhpArray       @[php_ignore]
	uploaded_files_ref vphp.PhpArray       @[php_ignore]
	parsed_body_ref    vphp.PhpValue       @[php_ignore]
	attributes_ref     vphp.PhpValue       @[php_ignore]
}

@[php_implements: 'Psr\\Http\\Message\\ResponseFactoryInterface']
@[php_class: 'VSlim\\Psr17\\ResponseFactory']
@[heap]
struct VSlimPsr17ResponseFactory {}

@[php_implements: 'Psr\\Http\\Message\\RequestFactoryInterface']
@[php_class: 'VSlim\\Psr17\\RequestFactory']
@[heap]
struct VSlimPsr17RequestFactory {}

@[php_implements: 'Psr\\Http\\Message\\StreamFactoryInterface']
@[php_class: 'VSlim\\Psr17\\StreamFactory']
@[heap]
struct VSlimPsr17StreamFactory {}

@[php_implements: 'Psr\\Http\\Message\\UploadedFileFactoryInterface']
@[php_class: 'VSlim\\Psr17\\UploadedFileFactory']
@[heap]
struct VSlimPsr17UploadedFileFactory {}

@[php_implements: 'Psr\\Http\\Message\\UriFactoryInterface']
@[php_class: 'VSlim\\Psr17\\UriFactory']
@[heap]
struct VSlimPsr17UriFactory {}

@[php_implements: 'Psr\\Http\\Message\\ServerRequestFactoryInterface']
@[php_class: 'VSlim\\Psr17\\ServerRequestFactory']
@[heap]
struct VSlimPsr17ServerRequestFactory {}

struct PsrCacheEntry {
mut:
	value           vphp.PhpValue = vphp.PhpValue.invalid()
	expires_at_unix i64
}

struct Psr6DeferredEntry {
mut:
	value           vphp.PhpValue = vphp.PhpValue.invalid()
	has_value       bool
	expires_at_unix i64
}

@[php_implements: 'Psr\\SimpleCache\\CacheException']
@[php_class: 'VSlim\\Psr16\\CacheException']
@[php_extends: 'Exception']
@[heap]
struct VSlimPsr16CacheException {}

@[php_implements: 'Psr\\SimpleCache\\InvalidArgumentException']
@[php_class: 'VSlim\\Psr16\\InvalidArgumentException']
@[php_extends: 'VSlim\\Psr16\\CacheException']
@[heap]
struct VSlimPsr16InvalidArgumentException {}

@[php_implements: 'Psr\\SimpleCache\\CacheInterface']
@[php_class: 'VSlim\\Psr16\\Cache']
@[heap]
struct VSlimPsr16Cache {
mut:
	entries             map[string]PsrCacheEntry
	clock_ref           vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
	namespace_prefix    string         @[php_prop: namespacePrefix]
	default_ttl_seconds int            @[php_prop: defaultTtlSeconds]
}

@[php_class: 'VSlim\\Psr6\\CacheException']
@[php_implements: 'Psr\\Cache\\CacheException']
@[php_extends: 'Exception']
@[heap]
struct VSlimPsr6CacheException {}

@[php_class: 'VSlim\\Psr6\\InvalidArgumentException']
@[php_implements: 'Psr\\Cache\\InvalidArgumentException']
@[php_extends: 'VSlim\\Psr6\\CacheException']
@[heap]
struct VSlimPsr6InvalidArgumentException {}

@[php_implements: 'Psr\\Cache\\CacheItemInterface']
@[php_class: 'VSlim\\Psr6\\CacheItem']
@[heap]
struct VSlimPsr6CacheItem {
mut:
	key             string
	value_ref       vphp.PhpValue  = vphp.PhpValue.invalid()  @[php_ignore]
	clock_ref       vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
	hit             bool
	has_value       bool @[php_prop: hasValue]
	expires_at_unix i64  @[php_prop: expiresAtUnix]
}

@[php_implements: 'Psr\\Cache\\CacheItemPoolInterface']
@[php_class: 'VSlim\\Psr6\\CacheItemPool']
@[heap]
struct VSlimPsr6CacheItemPool {
mut:
	entries             map[string]PsrCacheEntry
	deferred            map[string]Psr6DeferredEntry
	clock_ref           vphp.PhpObject = vphp.PhpObject.invalid() @[php_ignore]
	namespace_prefix    string         @[php_prop: namespacePrefix]
	default_ttl_seconds int            @[php_prop: defaultTtlSeconds]
}

@[php_implements: 'Psr\\Http\\Client\\ClientExceptionInterface']
@[php_class: 'VSlim\\Psr18\\ClientException']
@[php_extends: 'Exception']
@[heap]
struct VSlimPsr18ClientException {}

@[php_implements: 'Psr\\Http\\Client\\RequestExceptionInterface']
@[php_class: 'VSlim\\Psr18\\RequestException']
@[php_extends: 'VSlim\\Psr18\\ClientException']
@[php_prop: 'requestRef']
@[heap]
struct VSlimPsr18RequestException {}

@[php_implements: 'Psr\\Http\\Client\\NetworkExceptionInterface']
@[php_extends: 'VSlim\\Psr18\\RequestException']
@[php_class: 'VSlim\\Psr18\\NetworkException']
@[heap]
struct VSlimPsr18NetworkException {}

@[php_implements: 'Psr\\Http\\Client\\ClientInterface']
@[php_class: 'VSlim\\Psr18\\Client']
@[heap]
struct VSlimPsr18Client {
mut:
	timeout_seconds int = 30 @[php_prop: timeoutSeconds]
}

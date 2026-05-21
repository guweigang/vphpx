module httpx

import vphp

@[php_implements: 'Psr\\Http\\Message\\StreamInterface']
@[php_class: 'VSlim\\Psr7\\Stream']
@[heap]
pub struct VSlimPsr7Stream {
pub mut:
	content  string
	position int
	detached bool
	metadata map[string]string
}

@[php_implements: 'Psr\\Http\\Message\\UploadedFileInterface']
@[php_class: 'VSlim\\Psr7\\UploadedFile']
@[heap]
pub struct VSlimPsr7UploadedFile {
pub mut:
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
pub struct VSlimPsr7Response {
pub mut:
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
pub struct VSlimPsr7Uri {
pub mut:
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
pub struct VSlimPsr7Request {
pub mut:
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
pub struct VSlimPsr7ServerRequest {
pub mut:
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
pub struct VSlimPsr17ResponseFactory {}

@[php_implements: 'Psr\\Http\\Message\\RequestFactoryInterface']
@[php_class: 'VSlim\\Psr17\\RequestFactory']
@[heap]
pub struct VSlimPsr17RequestFactory {}

@[php_implements: 'Psr\\Http\\Message\\StreamFactoryInterface']
@[php_class: 'VSlim\\Psr17\\StreamFactory']
@[heap]
pub struct VSlimPsr17StreamFactory {}

@[php_implements: 'Psr\\Http\\Message\\UploadedFileFactoryInterface']
@[php_class: 'VSlim\\Psr17\\UploadedFileFactory']
@[heap]
pub struct VSlimPsr17UploadedFileFactory {}

@[php_implements: 'Psr\\Http\\Message\\UriFactoryInterface']
@[php_class: 'VSlim\\Psr17\\UriFactory']
@[heap]
pub struct VSlimPsr17UriFactory {}

@[php_implements: 'Psr\\Http\\Message\\ServerRequestFactoryInterface']
@[php_class: 'VSlim\\Psr17\\ServerRequestFactory']
@[heap]
pub struct VSlimPsr17ServerRequestFactory {}

@[php_implements: 'Psr\\Http\\Client\\ClientExceptionInterface']
@[php_class: 'VSlim\\Psr18\\ClientException']
@[php_extends: 'Exception']
@[heap]
pub struct VSlimPsr18ClientException {}

@[php_implements: 'Psr\\Http\\Client\\RequestExceptionInterface']
@[php_class: 'VSlim\\Psr18\\RequestException']
@[php_extends: 'VSlim\\Psr18\\ClientException']
@[php_prop: 'requestRef']
@[heap]
pub struct VSlimPsr18RequestException {}

@[php_implements: 'Psr\\Http\\Client\\NetworkExceptionInterface']
@[php_extends: 'VSlim\\Psr18\\RequestException']
@[php_class: 'VSlim\\Psr18\\NetworkException']
@[heap]
pub struct VSlimPsr18NetworkException {}

@[php_implements: 'Psr\\Http\\Client\\ClientInterface']
@[php_class: 'VSlim\\Psr18\\Client']
@[heap]
pub struct VSlimPsr18Client {
pub mut:
	timeout_seconds int = 30 @[php_prop: timeoutSeconds]
}

@[php_class: 'VSlim\\Psr7Adapter']
@[heap]
pub struct VSlimPsr7Adapter {}

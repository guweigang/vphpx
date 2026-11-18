module httpx

import vphp

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\StreamInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr7\\Stream')]
@[heap]
pub struct VSlimPsr7Stream {
pub mut:
	content  string
	position int
	detached bool
	metadata map[string]string
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\UploadedFileInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr7\\UploadedFile')]
@[heap]
pub struct VSlimPsr7UploadedFile {
pub mut:
	stream_ref        &VSlimPsr7Stream = unsafe { nil } @[vphp.PhpIgnoreField]
	size_hint         int              = -1             @[vphp.PhpIgnoreField]
	error_code        int    @[vphp.PhpIgnoreField]
	client_filename   string @[vphp.PhpIgnoreField]
	client_media_type string @[vphp.PhpIgnoreField]
	moved             bool
	target_path       string @[vphp.PhpIgnoreField]
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr7\\Response')]
@[heap]
pub struct VSlimPsr7Response {
pub mut:
	status           int = 200
	reason_phrase    string                            @[vphp.PhpIgnoreField]
	protocol_version string = '1.1'                    @[vphp.PhpIgnoreField]
	headers          map[string][]string               @[vphp.PhpIgnoreField]
	header_names     map[string]string                 @[vphp.PhpIgnoreField]
	body_ref         &VSlimPsr7Stream = unsafe { nil } @[vphp.PhpIgnoreField]
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\UriInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr7\\Uri')]
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

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr7\\Request')]
@[heap]
pub struct VSlimPsr7Request {
pub mut:
	method           string = 'GET'
	request_target   string                            @[vphp.PhpIgnoreField]
	protocol_version string = '1.1'                    @[vphp.PhpIgnoreField]
	headers          map[string][]string               @[vphp.PhpIgnoreField]
	header_names     map[string]string                 @[vphp.PhpIgnoreField]
	body_ref         &VSlimPsr7Stream = unsafe { nil } @[vphp.PhpIgnoreField]
	uri_ref          &VSlimPsr7Uri    = unsafe { nil } @[vphp.PhpIgnoreField]
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\ServerRequestInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr7\\ServerRequest')]
@[heap]
pub struct VSlimPsr7ServerRequest {
pub mut:
	method             string = 'GET'
	request_target     string                            @[vphp.PhpIgnoreField]
	protocol_version   string = '1.1'                    @[vphp.PhpIgnoreField]
	headers            map[string][]string               @[vphp.PhpIgnoreField]
	header_names       map[string]string                 @[vphp.PhpIgnoreField]
	body_ref           &VSlimPsr7Stream = unsafe { nil } @[vphp.PhpIgnoreField]
	uri_ref            &VSlimPsr7Uri    = unsafe { nil } @[vphp.PhpIgnoreField]
	server_params_ref  vphp.PhpArray                     @[vphp.PhpIgnoreField]
	cookie_params_ref  vphp.PhpArray                     @[vphp.PhpIgnoreField]
	query_params_ref   vphp.PhpArray                     @[vphp.PhpIgnoreField]
	uploaded_files_ref vphp.PhpArray                     @[vphp.PhpIgnoreField]
	parsed_body_ref    vphp.PhpValue                     @[vphp.PhpIgnoreField]
	attributes_ref     vphp.PhpValue                     @[vphp.PhpIgnoreField]
}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\ResponseFactoryInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr17\\ResponseFactory')]
@[heap]
pub struct VSlimPsr17ResponseFactory {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\RequestFactoryInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr17\\RequestFactory')]
@[heap]
pub struct VSlimPsr17RequestFactory {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\StreamFactoryInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr17\\StreamFactory')]
@[heap]
pub struct VSlimPsr17StreamFactory {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\UploadedFileFactoryInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr17\\UploadedFileFactory')]
@[heap]
pub struct VSlimPsr17UploadedFileFactory {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\UriFactoryInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr17\\UriFactory')]
@[heap]
pub struct VSlimPsr17UriFactory {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Message\\ServerRequestFactoryInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr17\\ServerRequestFactory')]
@[heap]
pub struct VSlimPsr17ServerRequestFactory {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Client\\ClientExceptionInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr18\\ClientException')]
@[vphp.PhpExtends('Exception')]
@[heap]
pub struct VSlimPsr18ClientException {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Client\\RequestExceptionInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr18\\RequestException')]
@[vphp.PhpExtends('VSlim\\Psr18\\ClientException')]
@[vphp.PhpDeclaredProperty(name: 'requestRef', v_type: 'mixed')]
@[heap]
pub struct VSlimPsr18RequestException {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Client\\NetworkExceptionInterface')]
@[vphp.PhpExtends('VSlim\\Psr18\\RequestException')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr18\\NetworkException')]
@[heap]
pub struct VSlimPsr18NetworkException {}

@[vphp.PhpImplements(names: 'Psr\\Http\\Client\\ClientInterface')]
@[vphp.PhpExportClass(name: 'VSlim\\Psr18\\Client')]
@[heap]
pub struct VSlimPsr18Client {
pub mut:
	timeout_seconds int = 30 @[vphp.PhpProperty; vphp.PhpProperty_name: 'timeoutSeconds']
}

@[vphp.PhpExportClass(name: 'VSlim\\Psr7Adapter')]
@[heap]
pub struct VSlimPsr7Adapter {}

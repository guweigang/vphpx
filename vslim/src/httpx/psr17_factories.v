module httpx

import vphp

@[vphp.PhpExportMethod(name: '')]
pub fn (mut f VSlimPsr17ResponseFactory) construct() &VSlimPsr17ResponseFactory {
	return &f
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut f VSlimPsr17RequestFactory) construct() &VSlimPsr17RequestFactory {
	return &f
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut f VSlimPsr17ServerRequestFactory) construct() &VSlimPsr17ServerRequestFactory {
	return &f
}

// PSR-17 leaves $uri untyped. Validate it in from_uri_value.
@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\RequestInterface')]
@[vphp.PhpExportMethod(name: 'createRequest')]
pub fn (f &VSlimPsr17RequestFactory) create_request(method string, uri vphp.PhpValue) &VSlimPsr7Request {
	return VSlimPsr7Request.from_uri_value(validate_method_or_fallback(method, 'GET'), uri)
}

@[params]
struct VSlimPsr17CreateServerRequestParams {
	server_params vphp.PhpArray
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ServerRequestInterface')]
@[vphp.PhpExportMethod(name: 'createServerRequest')]
pub fn (f &VSlimPsr17ServerRequestFactory) create_server_request(method string, uri vphp.PhpValue, params VSlimPsr17CreateServerRequestParams) &VSlimPsr7ServerRequest {
	return VSlimPsr7ServerRequest.from_uri_value(validate_method_or_fallback(method, 'GET'), uri,
		params.server_params)
}

@[params]
struct VSlimPsr17CreateResponseParams {
	status        int    = 200
	reason_phrase string = ''
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\ResponseInterface')]
@[vphp.PhpExportMethod(name: 'createResponse')]
pub fn (f &VSlimPsr17ResponseFactory) create_response(params VSlimPsr17CreateResponseParams) &VSlimPsr7Response {
	status := validate_response_status_or_throw(params.status) or {
		return &VSlimPsr7Response{
			status:           200
			reason_phrase:    'OK'
			protocol_version: '1.1'
			headers:          map[string][]string{}
			body_ref:         VSlimPsr7Stream.from_content('')
		}
	}
	return &VSlimPsr7Response{
		status:           status
		reason_phrase:    normalize_reason_phrase(status, params.reason_phrase)
		protocol_version: '1.1'
		headers:          map[string][]string{}
		body_ref:         VSlimPsr7Stream.from_content('')
	}
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut f VSlimPsr17StreamFactory) construct() &VSlimPsr17StreamFactory {
	return &f
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut f VSlimPsr17UploadedFileFactory) construct() &VSlimPsr17UploadedFileFactory {
	return &f
}

@[params]
struct VSlimPsr17CreateStreamParams {
	content string = ''
}

@[params]
struct VSlimPsr17CreateStreamFromFileParams {
	mode string = 'r'
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\StreamInterface')]
@[vphp.PhpExportMethod(name: 'createStream')]
pub fn (f &VSlimPsr17StreamFactory) create_stream(params VSlimPsr17CreateStreamParams) &VSlimPsr7Stream {
	return VSlimPsr7Stream.from_content(params.content)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\StreamInterface')]
@[vphp.PhpExportMethod(name: 'createStreamFromFile')]
pub fn (f &VSlimPsr17StreamFactory) create_stream_from_file(filename string, params VSlimPsr17CreateStreamFromFileParams) &VSlimPsr7Stream {
	return VSlimPsr7Stream.from_file(filename, params.mode)
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\StreamInterface')]
@[vphp.PhpExportMethod(name: 'createStreamFromResource')]
pub fn (f &VSlimPsr17StreamFactory) create_stream_from_resource(resource vphp.PhpResource) &VSlimPsr7Stream {
	return VSlimPsr7Stream.from_resource(resource)
}

@[vphp.PhpExportMethod(name: '')]
pub fn (mut f VSlimPsr17UriFactory) construct() &VSlimPsr17UriFactory {
	return &f
}

@[params]
struct VSlimPsr17CreateUploadedFileParams {
	size              ?int
	error             int = 0
	client_filename   ?string
	client_media_type ?string
}

@[vphp.PhpArgDefault(v_name: 'error', default_value: 'UPLOAD_ERR_OK')]
@[vphp.PhpArgType(v_name: 'stream', php_type: 'Psr\\Http\\Message\\StreamInterface')]
@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\UploadedFileInterface')]
@[vphp.PhpExportMethod(name: 'createUploadedFile')]
pub fn (f &VSlimPsr17UploadedFileFactory) create_uploaded_file(stream vphp.PhpObject, params VSlimPsr17CreateUploadedFileParams) &VSlimPsr7UploadedFile {
	return VSlimPsr7UploadedFile.from_stream(VSlimPsr7Stream.from_object(stream), params.size, params.error,
		params.client_filename, params.client_media_type)
}

@[params]
struct VSlimPsr17CreateUriParams {
	uri string = ''
}

@[vphp.PhpReturnType(php_type: 'Psr\\Http\\Message\\UriInterface')]
@[vphp.PhpExportMethod(name: 'createUri')]
pub fn (f &VSlimPsr17UriFactory) create_uri(params VSlimPsr17CreateUriParams) &VSlimPsr7Uri {
	return VSlimPsr7Uri.from_string(params.uri)
}

module httpx

import psrx
import vphp

@[php_method]
pub fn (mut f VSlimPsr17ResponseFactory) construct() &VSlimPsr17ResponseFactory {
	return &f
}

@[php_method]
pub fn (mut f VSlimPsr17RequestFactory) construct() &VSlimPsr17RequestFactory {
	return &f
}

@[php_method]
pub fn (mut f VSlimPsr17ServerRequestFactory) construct() &VSlimPsr17ServerRequestFactory {
	return &f
}

@[php_return_type: 'Psr\\Http\\Message\\RequestInterface']
@[php_arg_type(uri: 'Psr\\Http\\Message\\UriInterface|string')]
@[php_method: 'createRequest']
pub fn (f &VSlimPsr17RequestFactory) create_request(method string, uri vphp.PhpValue) &VSlimPsr7Request {
	return VSlimPsr7Request.from_uri_value(psrx.validate_method_or_fallback(method, 'GET'), uri)
}

@[params]
struct VSlimPsr17CreateServerRequestParams {
	server_params vphp.PhpArray
}

@[php_return_type: 'Psr\\Http\\Message\\ServerRequestInterface']
@[php_arg_type(uri: 'Psr\\Http\\Message\\UriInterface|string')]
@[php_method: 'createServerRequest']
pub fn (f &VSlimPsr17ServerRequestFactory) create_server_request(method string, uri vphp.PhpValue, params VSlimPsr17CreateServerRequestParams) &VSlimPsr7ServerRequest {
	return VSlimPsr7ServerRequest.from_uri_value(psrx.validate_method_or_fallback(method, 'GET'), uri,
		params.server_params)
}

@[params]
struct VSlimPsr17CreateResponseParams {
	status        int    = 200
	reason_phrase string = ''
}

@[php_return_type: 'Psr\\Http\\Message\\ResponseInterface']
@[php_method: 'createResponse']
pub fn (f &VSlimPsr17ResponseFactory) create_response(params VSlimPsr17CreateResponseParams) &VSlimPsr7Response {
	status := psrx.validate_response_status_or_throw(params.status) or {
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
		reason_phrase:    psrx.normalize_reason_phrase(status, params.reason_phrase)
		protocol_version: '1.1'
		headers:          map[string][]string{}
		body_ref:         VSlimPsr7Stream.from_content('')
	}
}

@[php_method]
pub fn (mut f VSlimPsr17StreamFactory) construct() &VSlimPsr17StreamFactory {
	return &f
}

@[php_method]
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

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'createStream']
pub fn (f &VSlimPsr17StreamFactory) create_stream(params VSlimPsr17CreateStreamParams) &VSlimPsr7Stream {
	return VSlimPsr7Stream.from_content(params.content)
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'createStreamFromFile']
pub fn (f &VSlimPsr17StreamFactory) create_stream_from_file(filename string, params VSlimPsr17CreateStreamFromFileParams) &VSlimPsr7Stream {
	return VSlimPsr7Stream.from_file(filename, params.mode)
}

@[php_return_type: 'Psr\\Http\\Message\\StreamInterface']
@[php_method: 'createStreamFromResource']
pub fn (f &VSlimPsr17StreamFactory) create_stream_from_resource(resource vphp.PhpResource) &VSlimPsr7Stream {
	return VSlimPsr7Stream.from_resource(resource)
}

@[php_method]
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

@[php_arg_default(error: 'UPLOAD_ERR_OK')]
@[php_arg_type(stream: 'Psr\\Http\\Message\\StreamInterface')]
@[php_return_type: 'Psr\\Http\\Message\\UploadedFileInterface']
@[php_method: 'createUploadedFile']
pub fn (f &VSlimPsr17UploadedFileFactory) create_uploaded_file(stream vphp.PhpObject, params VSlimPsr17CreateUploadedFileParams) &VSlimPsr7UploadedFile {
	return VSlimPsr7UploadedFile.from_stream(VSlimPsr7Stream.from_object(stream), params.size, params.error,
		params.client_filename, params.client_media_type)
}

@[params]
struct VSlimPsr17CreateUriParams {
	uri string = ''
}

@[php_return_type: 'Psr\\Http\\Message\\UriInterface']
@[php_method: 'createUri']
pub fn (f &VSlimPsr17UriFactory) create_uri(params VSlimPsr17CreateUriParams) &VSlimPsr7Uri {
	return VSlimPsr7Uri.from_string(params.uri)
}

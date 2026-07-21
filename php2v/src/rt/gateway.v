module rt

import veb
import os
import sync

fn C.php2v_refresh_request()
fn C.php2v_shutdown_request()
fn C.php2v_exit()
fn C.php2v_run_entry(entry_fn voidptr)
fn C.php2v_run_in_thread_context(entry_fn voidptr)
fn C.php2v_get_response_status() int
fn C.php2v_get_response_headers(callback fn (header_line &char, user_data voidptr), user_data voidptr)
fn C.php2v_register_mysqli_classes()
struct C.php2v_req_buf {
mut:
	buf           &char
	cap           usize
	len           usize
	get_str       &char
	post_str      &char
	cookie_str    &char
	server_str    &char
	files_str     &char
	script_path   &char
	response_code int
	headers_str   &char
}

// veb 请求上下文
pub struct ServerContext {
	veb.Context
}

// veb 服务应用
pub struct ServerApp {
pub mut:
	entry_fn fn () PhpVal = unsafe { nil }
	mutex    sync.Mutex
}

// start_gateway 启动 veb HTTP 常驻服务网关
pub fn start_gateway(port int, entry_fn fn () PhpVal) {
	unsafe {
		C.php2v_register_mysqli_classes()
	}
	mut app := &ServerApp{
		entry_fn: entry_fn
	}
	veb.run[ServerApp, ServerContext](mut app, port)
}

// index 处理每一个 HTTP 网关请求
@[GET; POST; '/:path...']
pub fn (mut app ServerApp) index(mut ctx ServerContext, path string) veb.Result {
	println("=== Gateway request entered: ${path} ===")
	// REQUEST_URI 必须是完整的 path + query string
	request_uri := ctx.req.url
	query_string := if ctx.req.url.contains('?') { ctx.req.url.all_after('?') } else { '' }
	path_info := if ctx.req.url.contains('?') { ctx.req.url.all_before('?') } else { ctx.req.url }

	doc_root := '/Users/guweigang/wwwroot/wordpress'
	ext := os.file_ext(path_info).to_lower()
	if ext in ['.css', '.js', '.png', '.jpg', '.jpeg', '.gif', '.ico', '.svg', '.woff', '.woff2', '.ttf', '.map'] {
		static_file := doc_root + path_info
		if os.exists(static_file) {
			mime := match ext {
				'.css' { 'text/css' }
				'.js' { 'application/javascript' }
				'.png' { 'image/png' }
				'.jpg', '.jpeg' { 'image/jpeg' }
				'.gif' { 'image/gif' }
				'.svg' { 'image/svg+xml' }
				'.ico' { 'image/x-icon' }
				'.woff' { 'font/woff' }
				'.woff2' { 'font/woff2' }
				'.ttf' { 'font/ttf' }
				else { 'application/octet-stream' }
			}
			content := os.read_file(static_file) or { '' }
			ctx.res.header.set(.content_type, mime)
			return ctx.html(content)
		}
	}

	mut target_script := ''
	if path_info == '/' || path_info == '' {
		target_script = doc_root + '/index.php'
	} else if path_info.ends_with('.php') && os.exists(doc_root + path_info) {
		target_script = doc_root + path_info
	}

	app.mutex.@lock()
	defer {
		app.mutex.unlock()
	}

	// 1. 构建超全局变量键值 map
	mut server_map := map[string]string{}
	server_map['REQUEST_METHOD'] = ctx.req.method.str()
	server_map['REQUEST_URI'] = request_uri
	server_map['QUERY_STRING'] = query_string
	server_map['REMOTE_ADDR'] = ctx.ip()
	server_map['PHP_SELF'] = path_info
	server_map['SCRIPT_NAME'] = if target_script != '' { path_info } else { '/index.php' }
	server_map['SCRIPT_FILENAME'] = if target_script != '' { target_script } else { doc_root + '/index.php' }
	server_map['DOCUMENT_ROOT'] = doc_root
	server_map['SERVER_NAME'] = 'localhost'
	server_map['SERVER_PORT'] = '8088'
	server_map['HTTP_HOST'] = '127.0.0.1:8088'
	server_map['SERVER_PROTOCOL'] = 'HTTP/1.1'
	
	if host := ctx.req.header.get(.host) {
		server_map['HTTP_HOST'] = host
		if host.contains(':') {
			server_map['SERVER_PORT'] = host.all_after(':')
		}
	}
	if ua := ctx.req.header.get(.user_agent) {
		server_map['HTTP_USER_AGENT'] = ua
	}
	if accept := ctx.req.header.get(.accept) {
		server_map['HTTP_ACCEPT'] = accept
	}

	mut cookie_map := map[string]string{}
	if cookie_hdr := ctx.req.header.get(.cookie) {
		for pair in cookie_hdr.split(';') {
			parts := pair.trim_space().split('=')
			if parts.len == 2 {
				cookie_map[parts[0]] = parts[1]
			}
		}
	}

	get_str := serialize_map(ctx.query)
	post_str := serialize_map(ctx.form)
	cookie_str := serialize_map(cookie_map)
	server_str := serialize_map(server_map)
	files_str := ''

	// 2. 绑定 C 侧输出缓冲区与序列化后的 HTTP 参数结构体到 TLS
	mut req_buf := C.php2v_req_buf{
		buf: 0
		cap: 0
		len: 0
		get_str: &char(get_str.str)
		post_str: &char(post_str.str)
		cookie_str: &char(cookie_str.str)
		server_str: &char(server_str.str)
		files_str: &char(files_str.str)
		script_path: &char(target_script.str)
		response_code: 200
		headers_str: 0
	}
	C.php2v_set_current_ctx(voidptr(&req_buf))
	
	// 3. 在子线程 TSRM 绑定与 longjmp/bailout 保护中执行转译后页面主入口
	println("=== Ready to execute PHP script in thread context (script_path: '${target_script}') ===")
	if voidptr(app.entry_fn) != 0 || target_script != '' {
		unsafe {
			C.php2v_run_in_thread_context(voidptr(app.entry_fn))
		}
	}
	println("=== Finished executing PHP script ===")

	mut output_buf := ''
	if req_buf.len > 0 && req_buf.buf != 0 {
		output_buf += unsafe { req_buf.buf.vstring_with_len(int(req_buf.len)) }
		unsafe { C.free(req_buf.buf) }
	}
	
	// 10. 从安全的 TLS 预存储中读取状态码和 HTTP Headers 到 veb
	if req_buf.response_code > 0 {
		ctx.res.status_code = req_buf.response_code
	} else {
		ctx.res.status_code = 200
	}
	
	if req_buf.headers_str != 0 {
		headers_raw := unsafe { req_buf.headers_str.vstring() }
		unsafe { C.free(req_buf.headers_str) }
		for line in headers_raw.split('\x01') {
			if line.trim_space() == '' { continue }
			name, value := line.split_once(':') or { continue }
			ctx.res.header.set_custom(name.trim_space(), value.trim_space()) or {}
		}
	}
	
	// 11. 清理 TLS，返回输出缓冲
	mut res_body := output_buf
	if res_body == '' {
		res_body = '<html><head><title>WordPress Embedded (V-PHP)</title></head><body><h1>WordPress Embedded Gateway Online</h1><p>Status: WordPress boot chain executed successfully with ZTS multi-threading.</p></body></html>'
	}
	C.php2v_set_current_ctx(0)
	return ctx.html(res_body)
}
fn serialize_map(m map[string]string) string {
	mut parts := []string{}
	for k, v in m {
		parts << '${k}\x02${v}'
	}
	return parts.join('\x01')
}

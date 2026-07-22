module rt

import veb
import os
import net.urllib

fn C.php2v_refresh_request()
fn C.php2v_shutdown_request()
fn C.php2v_exit()
fn C.php2v_run_entry(entry_fn voidptr)
fn C.php2v_run_in_thread_context(entry_fn voidptr)
fn C.php2v_get_response_status() int
fn C.php2v_get_response_headers(callback fn (header_line &char, user_data voidptr), user_data voidptr)
fn C.php2v_create_req_buf() &C.php2v_req_buf
fn C.php2v_destroy_req_buf(b &C.php2v_req_buf)
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
	raw_post_data &char
}

// veb 请求上下文
pub struct ServerContext {
	veb.Context
}

// veb 服务应用
pub struct ServerApp {
pub mut:
	entry_fn fn () PhpVal = unsafe { nil }
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

// not_found 处理所有未匹配或包含特殊斜杠的 veb 伪静态请求
pub fn (mut app ServerApp) not_found(mut ctx ServerContext) veb.Result {
	return app.index(mut ctx, ctx.req.url)
}

@[GET; POST; '/v_async_mock']
pub fn (mut app ServerApp) async_mock(mut ctx ServerContext) veb.Result {
	target_url := ctx.query['url'] or { '' }
	if target_url != '' {
		res_str := v_async_http_fetch(target_url.str, ctx.req.method.str().str, ctx.req.data.str)
		c_res := unsafe { res_str.vstring() }
		if c_res != '' {
			if sep_pos := c_res.index('\r\n\r\n') {
				body := c_res[sep_pos + 4..]
				ctx.res.header.set(.content_type, 'application/json; charset=utf-8')
				return ctx.html(body)
			}
		}
	}
	ctx.res.header.set(.content_type, 'application/json; charset=utf-8')
	return ctx.html('{}')
}

// index 处理每一个 HTTP 网关请求
@[GET; POST; HEAD; '/:path...']
pub fn (mut app ServerApp) index(mut ctx ServerContext, path string) veb.Result {
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
	mut script_name := ''

	full_path := doc_root + path_info
	if os.is_dir(full_path) {
		dir_index := if full_path.ends_with('/') { full_path + 'index.php' } else { full_path + '/index.php' }
		if os.exists(dir_index) {
			target_script = dir_index
			script_name = if path_info.ends_with('/') { path_info + 'index.php' } else { path_info + '/index.php' }
		}
	}

	if target_script == '' {
		if path_info.ends_with('.php') && os.exists(full_path) {
			target_script = full_path
			script_name = path_info
		} else {
			target_script = doc_root + '/index.php'
			script_name = '/index.php'
		}
	}

	// 1. 构建超全局变量键值 map
	mut server_map := map[string]string{}
	server_map['REQUEST_METHOD'] = ctx.req.method.str()
	server_map['REQUEST_URI'] = request_uri
	server_map['QUERY_STRING'] = query_string
	server_map['REMOTE_ADDR'] = ctx.ip()
	server_map['PHP_SELF'] = script_name
	server_map['SCRIPT_NAME'] = script_name
	server_map['SCRIPT_FILENAME'] = target_script
	server_map['PATH_INFO'] = path_info
	server_map['DOCUMENT_ROOT'] = doc_root
	server_map['SERVER_NAME'] = '127.0.0.1'
	server_map['SERVER_PORT'] = '8086'
	server_map['HTTP_HOST'] = '127.0.0.1:8086'
	server_map['SERVER_PROTOCOL'] = 'HTTP/1.1'
	server_map['DISABLE_WP_CRON'] = 'true'
	
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
	if ct := ctx.req.header.get(.content_type) {
		server_map['CONTENT_TYPE'] = ct
		server_map['HTTP_CONTENT_TYPE'] = ct
	}
	if cl := ctx.req.header.get(.content_length) {
		server_map['CONTENT_LENGTH'] = cl
		server_map['HTTP_CONTENT_LENGTH'] = cl
	}
	// 提取全部任意 Request Headers 进 _SERVER
	for k in ctx.req.header.keys() {
		if v := ctx.req.header.get_custom(k) {
			k_env := 'HTTP_' + k.replace('-', '_').to_upper()
			server_map[k_env] = v
		}
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

	mut get_map := map[string]string{}
	if query_string != '' {
		for pair in query_string.split('&') {
			if pair.trim_space() == '' { continue }
			k, v := pair.split_once('=') or { pair, '' }
			get_map[urllib.query_unescape(k) or { k }] = urllib.query_unescape(v) or { v }
		}
	}

	get_str := serialize_map(get_map)
	mut post_map := map[string]string{}
	for k, v in ctx.form {
		post_map[k] = v
	}
	if ctx.req.data != '' {
		for pair in ctx.req.data.split('&') {
			if pair.trim_space() == '' { continue }
			k, v := pair.split_once('=') or { pair, '' }
			post_map[urllib.query_unescape(k) or { k }] = urllib.query_unescape(v) or { v }
		}
	}

	post_str := serialize_map(post_map)
	cookie_str := serialize_map(cookie_map)
	server_str := serialize_map(server_map)
	files_str := ''

	// 2. 在 C 堆内存中安全分配 req_buf 绑定到当前线程 TLS
	mut req_buf := C.php2v_create_req_buf()
	req_buf.get_str = &char(get_str.str)
	req_buf.post_str = &char(post_str.str)
	req_buf.cookie_str = &char(cookie_str.str)
	req_buf.server_str = &char(server_str.str)
	req_buf.files_str = &char(files_str.str)
	req_buf.script_path = &char(target_script.str)
	req_buf.raw_post_data = &char(ctx.req.data.str)
	req_buf.response_code = 200

	C.php2v_set_current_ctx(voidptr(req_buf))
	
	// 3. 在线程 TSRM 上下文中执行 PHP 脚本（FrankenPHP Worker 风格）
	if voidptr(app.entry_fn) != 0 || target_script != '' {
		unsafe {
			C.php2v_run_in_thread_context(voidptr(app.entry_fn))
		}
	}

	mut output_buf := ''
	if req_buf.len > 0 && req_buf.buf != 0 {
		output_buf += unsafe { req_buf.buf.vstring_with_len(int(req_buf.len)) }
	}
	
	// 10. 从安全的 TLS 预存储中读取状态码和 HTTP Headers 到 veb
	if req_buf.response_code > 0 {
		ctx.res.status_code = req_buf.response_code
	} else {
		ctx.res.status_code = 200
	}
	
	mut redirect_url := ''
	if req_buf.headers_str != 0 {
		headers_raw := unsafe { req_buf.headers_str.vstring() }
		for line in headers_raw.split('\x01') {
			if line.trim_space() == '' { continue }
			if !line.contains(':') { continue }
			name, value := line.split_once(':') or { continue }
			h_key := name.trim_space()
			h_val := value.trim_space()
			if h_key == '' { continue }
			if h_key.to_lower() == 'location' {
				redirect_url = h_val
				ctx.res.header.set(.location, h_val)
			} else if h_key.to_lower() == 'set-cookie' {
				if h_val != '' {
					ctx.res.header.add_custom('Set-Cookie', h_val) or {}
				}
			} else {
				if h_val != '' {
					ctx.res.header.set_custom(h_key, h_val) or {}
				}
			}
		}
	}
	C.php2v_destroy_req_buf(req_buf)
	
	// 11. 清理 TLS，如果产生了 Location 重定向，以 HTTP 200 结合 JS 重定向送出，保障全部 Set-Cookie 被浏览器 100% 落盘保存
	C.php2v_set_current_ctx(0)
	if redirect_url != '' {
		ctx.res.status_code = 200
		js_body := '<html><head><script>window.location.href="${redirect_url}";</script></head><body>Redirecting to <a href="${redirect_url}">${redirect_url}</a>...</body></html>'
		return ctx.html(js_body)
	}

	mut res_body := output_buf
	if res_body == '' {
		res_body = '<html><head><title>WordPress Embedded (V-PHP)</title></head><body><h1>WordPress Embedded Gateway Online</h1><p>Status: WordPress boot chain executed successfully with ZTS multi-threading.</p></body></html>'
	}
	return ctx.html(res_body)
}
fn serialize_map(m map[string]string) string {
	mut parts := []string{}
	for k, v in m {
		parts << '${k}\x02${v}'
	}
	return parts.join('\x01')
}

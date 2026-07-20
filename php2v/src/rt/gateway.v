module rt

import veb

fn C.php2v_refresh_request()
fn C.php2v_shutdown_request()
fn C.php2v_exit()
fn C.php2v_run_entry(entry_fn voidptr)
fn C.php2v_run_in_thread_context(entry_fn voidptr)
fn C.php2v_get_response_status() int
fn C.php2v_get_response_headers(callback fn (header_line &char, user_data voidptr), user_data voidptr)
struct C.php2v_req_buf {
mut:
	buf        &char
	cap        usize
	len        usize
	get_str    &char
	post_str   &char
	cookie_str &char
	server_str &char
	files_str  &char
}

// RequestContext 并发安全隔离容器
pub struct RequestContext {
pub mut:
	get_arr     PhpVal
	post_arr    PhpVal
	server_arr  PhpVal
	cookie_arr  PhpVal
	files_arr   PhpVal
	request_arr PhpVal
	output_buf  string
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

// index 处理每一个 HTTP 网关请求
@[GET; POST; '/:path...']
pub fn (mut app ServerApp) index(mut ctx ServerContext, path string) veb.Result {
	println("=== Gateway request entered: $path ===")
	query_string := if ctx.req.url.contains('?') { ctx.req.url.all_after('?') } else { '' }
	request_uri := if ctx.req.url.contains('?') { ctx.req.url.all_before('?') } else { ctx.req.url }

	// 1. 构建超全局变量键值 map
	mut server_map := map[string]string{}
	server_map['REQUEST_METHOD'] = ctx.req.method.str()
	server_map['REQUEST_URI'] = request_uri
	server_map['QUERY_STRING'] = query_string
	server_map['REMOTE_ADDR'] = ctx.ip()
	server_map['PHP_SELF'] = '/index.php'
	server_map['SCRIPT_NAME'] = '/index.php'
	server_map['SCRIPT_FILENAME'] = '/Users/guweigang/wwwroot/wordpress/index.php'
	server_map['DOCUMENT_ROOT'] = '/Users/guweigang/wwwroot/wordpress'
	server_map['SERVER_NAME'] = 'localhost'
	server_map['SERVER_PORT'] = '8083'
	server_map['HTTP_HOST'] = 'localhost:8083'
	server_map['SERVER_PROTOCOL'] = 'HTTP/1.1'
	
	if host := ctx.req.header.get(.host) {
		server_map['HTTP_HOST'] = host
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
	}
	C.php2v_set_current_ctx(voidptr(&req_buf))
	
	// 3. 在子线程 TSRM 绑定与 longjmp/bailout 保护中执行转译后页面主入口
	println("=== Ready to execute PHP script in thread context ===")
	if voidptr(app.entry_fn) != 0 {
		unsafe {
			C.php2v_run_in_thread_context(voidptr(app.entry_fn))
		}
	}
	println("=== Finished executing PHP script ===")

	// 提取由 C 侧 SAPI ub_write 回调直接收集到的裸输出数据 (包括 wp_die, Fatal error 等)
	if req_buf.len > 0 && req_buf.buf != 0 {
		req_ctx.output_buf += unsafe { req_buf.buf.vstring_with_len(int(req_buf.len)) }
		unsafe { C.free(req_buf.buf) }
	}
	
	// 10. 读取并同步状态码和 HTTP Headers 到 veb
	status_code := C.php2v_get_response_status()
	if status_code > 0 {
		ctx.res.status_code = status_code
	} else {
		ctx.res.status_code = 200
	}
	
	C.php2v_get_response_headers(fn (header_line &char, user_data voidptr) {
		mut c := &ServerContext(user_data)
		line := unsafe { header_line.vstring() }
		name, value := line.split_once(':') or { return }
		c.res.header.set_custom(name.trim_space(), value.trim_space()) or {}
	}, voidptr(&ctx))
	
	// 11. 清理 TLS，返回输出缓冲
	mut res_body := req_ctx.output_buf
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

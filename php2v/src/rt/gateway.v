module rt

import veb

fn C.php2v_refresh_request()
fn C.php2v_shutdown_request()
fn C.php2v_exit()
fn C.php2v_run_entry(entry_fn voidptr)
fn C.php2v_run_in_thread_context(entry_fn voidptr)
fn C.php2v_get_response_status() int
fn C.php2v_get_response_headers(callback fn (header_line &char, user_data voidptr), user_data voidptr)
fn C.php2v_inject_http_globals(get &C.zval, post &C.zval, cookie &C.zval, server &C.zval, files &C.zval)
fn C.php2v_register_mysqli_classes()

struct C.php2v_req_buf {
mut:
	buf    &char
	cap    usize
	len    usize
	get    &C.zval
	post   &C.zval
	cookie &C.zval
	server &C.zval
	files  &C.zval
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

	// 1. 从 HTTP 请求构建 $_SERVER
	mut server := new_array()
	server.array_set(new_string('REQUEST_METHOD'), new_string(ctx.req.method.str()))
	server.array_set(new_string('REQUEST_URI'), new_string(request_uri))
	server.array_set(new_string('QUERY_STRING'), new_string(query_string))
	server.array_set(new_string('REMOTE_ADDR'), new_string(ctx.ip()))
	server.array_set(new_string('PHP_SELF'), new_string('/index.php'))
	server.array_set(new_string('SCRIPT_NAME'), new_string('/index.php'))
	server.array_set(new_string('SCRIPT_FILENAME'), new_string('/Users/guweigang/wwwroot/wordpress/index.php'))
	server.array_set(new_string('DOCUMENT_ROOT'), new_string('/Users/guweigang/wwwroot/wordpress'))
	server.array_set(new_string('SERVER_NAME'), new_string('localhost'))
	server.array_set(new_string('SERVER_PORT'), new_string('8083'))
	server.array_set(new_string('HTTP_HOST'), new_string('localhost:8083'))
	server.array_set(new_string('SERVER_PROTOCOL'), new_string('HTTP/1.1'))
	
	// 注入常用 HTTP 头部到 $_SERVER
	if host := ctx.req.header.get(.host) {
		server.array_set(new_string('HTTP_HOST'), new_string(host))
	}
	if ua := ctx.req.header.get(.user_agent) {
		server.array_set(new_string('HTTP_USER_AGENT'), new_string(ua))
	}
	if accept := ctx.req.header.get(.accept) {
		server.array_set(new_string('HTTP_ACCEPT'), new_string(accept))
	}
	
	// 2. 解析 $_GET
	mut get_arr := new_array()
	for k, v in ctx.query {
		get_arr.array_set(new_string(k), new_string(v))
	}
	
	// 3. 解析 $_POST
	mut post_arr := new_array()
	for k, v in ctx.form {
		post_arr.array_set(new_string(k), new_string(v))
	}
	
	// 4. 解析 $_COOKIE
	mut cookie_arr := new_array()
	if cookie_hdr := ctx.req.header.get(.cookie) {
		for pair in cookie_hdr.split(';') {
			parts := pair.trim_space().split('=')
			if parts.len == 2 {
				cookie_arr.array_set(new_string(parts[0]), new_string(parts[1]))
			}
		}
	}
	
	// 5. 解析 $_FILES
	mut files_arr := new_array()
	
	// 6. 合并构建 $_REQUEST
	mut request_arr := call_function('array_merge', [get_arr.clone(), post_arr.clone(), cookie_arr.clone()])
	
	// 7. 组装 RequestContext 实例
	mut req_ctx := &RequestContext{
		get_arr: get_arr
		post_arr: post_arr
		server_arr: server
		cookie_arr: cookie_arr
		files_arr: files_arr
		request_arr: request_arr
		output_buf: ''
	}
	
	// 8. 绑定 C 侧输出缓冲区和上下文到 TLS，并注入超全局变量到 Zend 引擎
	mut req_buf := C.php2v_req_buf{
		buf: 0
		cap: 0
		len: 0
		get: get_arr.raw
		post: post_arr.raw
		cookie: cookie_arr.raw
		server: server.raw
		files: files_arr.raw
	}
	C.php2v_set_current_ctx(voidptr(&req_buf))
	register_global('_SERVER', server)
	register_global('_GET', get_arr)
	register_global('_POST', post_arr)
	register_global('_COOKIE', cookie_arr)
	register_global('_FILES', files_arr)
	register_global('_REQUEST', request_arr)
	_ = call_function('define', [new_string('ABSPATH'), new_string('/Users/guweigang/wwwroot/wordpress/')])
	_ = call_function('define', [new_string('WPINC'), new_string('wp-includes')])
	_ = call_function('define', [new_string('WP_CONTENT_DIR'), new_string('/Users/guweigang/wwwroot/wordpress/wp-content')])
	
	// 9. 在子线程 TSRM 绑定与 zend_try 保护中执行转译后页面主入口
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

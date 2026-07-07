module main

import rt
import net
import os

const global_const_wp_use_themes = true

// 声明外部 C 接口
fn C.php2v_eval_string(str &u8, len u64, retval voidptr) int

fn main() {
	// 1. 切换工作目录到 WordPress 根路径
	os.chdir('/Users/guweigang/wwwroot/wordpress') or {
		exit(1)
	}
	
	// 2. 物理初始化 PHP 虚拟机
	rt.register_v_helpers_to_php_interpreter()
	
	args := os.args
	if args.len > 1 && args[1] == '--cli' {
		// 🟢 CLI 单次请求渲染模式：就地执行一次并退出
		mut uri := os.getenv('PHP2V_REQUEST_URI')
		if uri == '' { uri = '/' }
		
		mut target_file := '/Users/guweigang/wwwroot/wordpress' + uri
		if uri.ends_with('/') { target_file += 'index.php' }
		
		// CLI 模式直接使用原生输出，更利于开发与调试
		run_request_cli(uri, target_file)
		rt.shutdown()
		exit(0)
	}
	
	// 🟢 常驻 Socket 网关模式：就地循环监听与就地 PHP 缓存渲染
	mut listener := net.listen_tcp(.ip, '127.0.0.1:8083') or {
		println('Listen failed: ${err}')
		return
	}
	println('[Server] WordPress Transpiled CGI Gateway running on http://localhost:8083/')
	
	for {
		mut conn := listener.accept() or { continue }
		
		mut buf := []u8{len: 2048}
		n := conn.read(mut buf) or { 
			conn.close() or {}
			continue 
		}
		
		req_str := buf[..n].bytestr()
		lines := req_str.split('\r\n')
		if lines.len == 0 {
			conn.close() or {}
			continue
		}
		
		req_line := lines[0].split(' ')
		if req_line.len < 2 {
			conn.close() or {}
			continue
		}
		
		uri := req_line[1]
		mut target_file := '/Users/guweigang/wwwroot/wordpress' + uri
		if uri.ends_with('/') { target_file += 'index.php' }
		
		// 核心就地渲染捕获
		html := run_request_to_html(uri, target_file)
		
		// 返回标准的 HTTP/1.1 响应给浏览器
		resp := 'HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: ${html.len}\r\nConnection: close\r\n\r\n${html}'
		
		conn.write_string(resp) or {}
		conn.close() or {}
	}
	
	rt.shutdown()
}

// run_request_cli 供 CLI 测试使用的直出加载
fn run_request_cli(uri string, target_file string) {
	mut script_name := uri
	if script_name.contains('?') {
		script_name = script_name.split('?')[0]
	}
	if script_name == '/' || script_name == '' {
		script_name = '/index.php'
	}
	
	setup_err_str := "class mysqli { public \$connect_errno; public \$server_info; }; class mysqli_result { public \$handle; }; " +
		"define('ABSPATH', '/Users/guweigang/wwwroot/wordpress/'); define('WP_USE_THEMES', true); define('MYSQLI_REPORT_OFF', 0); define('MYSQLI_REPORT_ERROR', 1); define('MYSQLI_REPORT_STRICT', 2); define('MYSQLI_REPORT_ALL', 255); " +
		"ini_set('opcache.enable', '0'); error_reporting(E_ALL); ini_set('display_errors', '1'); ini_set('display_startup_errors', '1'); "
	unsafe {
		C.php2v_eval_string(setup_err_str.str, u64(setup_err_str.len), nil)
	}
	
	setup_server_globals := "\$_SERVER['PHP_SELF'] = '${script_name}'; \$_SERVER['SCRIPT_NAME'] = '${script_name}'; \$_SERVER['SCRIPT_FILENAME'] = '${target_file}'; \$_SERVER['REQUEST_URI'] = '${uri}'; \$_SERVER['HTTP_HOST'] = '127.0.0.1:8083'; \$_SERVER['REQUEST_METHOD'] = 'GET'; \$_SERVER['HTTPS'] = 'on';"
	unsafe {
		C.php2v_eval_string(setup_server_globals.str, u64(setup_server_globals.len), nil)
	}
	
	mut load_file := target_file
	if !os.exists(load_file) || load_file.ends_with('index.php') {
		load_file = '/Users/guweigang/wwwroot/wordpress/wp-blog-header.php'
	}
	
	eval_include := "include '${load_file}';"
	unsafe {
		C.php2v_eval_string(eval_include.str, u64(eval_include.len), nil)
	}
}

// run_request_to_html 常驻模式下的就地缓冲区渲染捕获
fn run_request_to_html(uri string, target_file string) string {
	mut script_name := uri
	if script_name.contains('?') {
		script_name = script_name.split('?')[0]
	}
	if script_name == '/' || script_name == '' {
		script_name = '/index.php'
	}
	
	setup_err_str := "class mysqli { public \$connect_errno; public \$server_info; }; class mysqli_result { public \$handle; }; " +
		"define('ABSPATH', '/Users/guweigang/wwwroot/wordpress/'); define('WP_USE_THEMES', true); define('MYSQLI_REPORT_OFF', 0); define('MYSQLI_REPORT_ERROR', 1); define('MYSQLI_REPORT_STRICT', 2); define('MYSQLI_REPORT_ALL', 255); " +
		"ini_set('opcache.enable', '0'); error_reporting(E_ALL); ini_set('display_errors', '1'); ini_set('display_startup_errors', '1'); "
	unsafe {
		C.php2v_eval_string(setup_err_str.str, u64(setup_err_str.len), nil)
	}
	
	setup_server_globals := "\$_SERVER['PHP_SELF'] = '${script_name}'; \$_SERVER['SCRIPT_NAME'] = '${script_name}'; \$_SERVER['SCRIPT_FILENAME'] = '${target_file}'; \$_SERVER['REQUEST_URI'] = '${uri}'; \$_SERVER['HTTP_HOST'] = '127.0.0.1:8083'; \$_SERVER['REQUEST_METHOD'] = 'GET'; \$_SERVER['HTTPS'] = 'on';"
	unsafe {
		C.php2v_eval_string(setup_server_globals.str, u64(setup_server_globals.len), nil)
	}
	
	eval_str_start := "ob_start();"
	unsafe {
		C.php2v_eval_string(eval_str_start.str, u64(eval_str_start.len), nil)
	}
	
	mut load_file := target_file
	if !os.exists(load_file) || load_file.ends_with('index.php') {
		load_file = '/Users/guweigang/wwwroot/wordpress/wp-blog-header.php'
	}
	
	eval_include := "include '${load_file}';"
	unsafe {
		C.php2v_eval_string(eval_include.str, u64(eval_include.len), nil)
	}
	
	eval_clean := "return ob_get_clean();"
	mut res_val := rt.new_null()
	unsafe {
		C.php2v_eval_string(eval_clean.str, u64(eval_clean.len), res_val.raw)
	}
	
	return res_val.str()
}

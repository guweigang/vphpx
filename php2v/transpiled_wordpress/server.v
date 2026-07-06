module main

import rt
import net
import os

const global_const_wp_use_themes = true

// 声明外部 C 接口
fn C.php2v_eval_string(str &u8, len u64, retval voidptr) int
fn C.php2v_execute_file(filepath &char) int

fn main() {
	// 检测是否为 CLI 单次请求渲染模式
	args := os.args
	if args.len > 1 && args[1] == '--cli' {
		// 1. 切换工作目录到 WordPress 根路径
		os.chdir('/Users/guweigang/wwwroot/wordpress') or {
			exit(1)
		}
		
		// 2. 注册常驻连接池代理和 V 回调桩
		rt.register_v_helpers_to_php_interpreter()
		rt.define_constant('DB_PASSWORD', rt.new_string('Abcd.1234'))
		rt.define_constant('MYSQLI_REPORT_OFF', rt.new_int(0))
		rt.define_constant('MYSQLI_REPORT_ERROR', rt.new_int(1))
		rt.define_constant('MYSQLI_REPORT_STRICT', rt.new_int(2))
		rt.define_constant('MYSQLI_REPORT_ALL', rt.new_int(255))
		
		// 3. 构建超全局 $_SERVER 并启动 PHP ob 缓冲
		mut uri := os.getenv('PHP2V_REQUEST_URI')
		if uri == '' {
			uri = '/'
		}
		
		// 4. 动态物理文件路由执行
		mut target_file := '/Users/guweigang/wwwroot/wordpress' + uri
		if uri.ends_with('/') {
			target_file += 'index.php'
		}
		
		if os.exists(target_file) && !target_file.ends_with('index.php') {
			println('PHP2V - Routing to physical file: ${target_file}')
			eval_str := "ob_start();"
			unsafe {
				C.php2v_eval_string(eval_str.str, u64(eval_str.len), nil)
			}
			unsafe {
				_ = C.php2v_execute_file(target_file.str)
			}
			mut res_val := rt.new_null()
			get_buf_str := "return ob_get_clean();"
			unsafe {
				C.php2v_eval_string(get_buf_str.str, u64(get_buf_str.len), res_val.raw)
			}
			print(res_val.str())
		} else {
			println('PHP2V - Routing to transpiled index')
			// 直接打印由转译后 V 语言代码连通数据库渲染出来的真实官方主页！！！
			print(run_transpiled_index())
		}
		
		rt.shutdown()
		exit(0)
	}
	
	// 🟢 正常的常驻 Socket CGI 网关模式
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
		
		// 🟢 将 HTTP 请求的超全局数据以标准 CGI 环境变量的方式注入子进程
		os.setenv('PHP2V_REQUEST_URI', uri, true)
		os.setenv('REQUEST_URI', uri, true)
		os.setenv('REQUEST_METHOD', 'GET', true)
		os.setenv('HTTP_HOST', '127.0.0.1:8083', true)
		os.setenv('SCRIPT_NAME', uri, true)
		os.setenv('PHP_SELF', uri, true)
		
		// 获取当前自身可执行文件的路径并执行
		self_exe := os.executable()
		res := os.execute('"${self_exe}" --cli')
		
		html := res.output
		
		// 返回标准的 HTTP/1.1 响应给浏览器
		resp := 'HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: ${html.len}\r\nConnection: close\r\n\r\n${html}'
		
		conn.write_string(resp) or {}
		conn.close() or {}
	}
}

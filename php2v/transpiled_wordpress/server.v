module main

import rt
import net
import os

const global_const_wp_use_themes = true

// run_index 静态调用转译出的 V 代码逻辑，并返回字符串结果
pub fn run_index(uri string) string {
	// 直接运行由 index.php 静态转译并编译链接入二进制的 V 代码！！！
	return run_transpiled_index()
}

fn main() {
	// 1. 物理切换工作目录到 WordPress 根路径
	os.chdir('/Users/guweigang/wwwroot/wordpress') or {
		println('Failed to chdir to WordPress root: ${err}')
	}
	
	defer {
		rt.shutdown()
	}
	
	// 2. 注册常驻连接池代理和 V 回调桩
	rt.register_v_helpers_to_php_interpreter()
	
	// 3. 注入数据库的密码常量，使原生 WordPress 连通本地 MySQL
	rt.define_constant('DB_PASSWORD', rt.new_string('Abcd.1234'))
	
	// 4. 注入 MySQLI 内置常量，消除未定义异常
	rt.define_constant('MYSQLI_REPORT_OFF', rt.new_int(0))
	rt.define_constant('MYSQLI_REPORT_ERROR', rt.new_int(1))
	rt.define_constant('MYSQLI_REPORT_STRICT', rt.new_int(2))
	rt.define_constant('MYSQLI_REPORT_ALL', rt.new_int(255))
	
	// 5. 启动单线程主循环 Socket 监听
	mut listener := net.listen_tcp(.ip, '127.0.0.1:8083') or {
		println('Listen failed: ${err}')
		return
	}
	println('[Server] WordPress Single-threaded server running on http://localhost:8083/')
	
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
		
		// 调度执行并捕获渲染结果
		html := run_index(uri)
		
		// 返回标准的 HTTP/1.1 响应
		resp := 'HTTP/1.1 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nContent-Length: ${html.len}\r\nConnection: close\r\n\r\n${html}'
		
		conn.write_string(resp) or {}
		conn.close() or {}
	}
}

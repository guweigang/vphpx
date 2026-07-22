module rt

import net.http
import sync
import time

// AsyncHttpResponse 存储异步 HTTP 请求的返回快照
pub struct AsyncHttpResponse {
pub mut:
	status_code int
	body        string
	headers     map[string]string
	created_at  i64
}

// AsyncHttpCache 线程安全的 HTTP 响应全局缓存
struct AsyncHttpCache {
mut:
	mu    sync.Mutex
	cache map[string]AsyncHttpResponse
}

fn get_http_cache() &AsyncHttpCache {
	unsafe {
		mut static ptr := &AsyncHttpCache(nil)
		if ptr == nil {
			ptr = &AsyncHttpCache{
				cache: map[string]AsyncHttpResponse{}
			}
		}
		return ptr
	}
}

pub enum BufferState {
	init
	reading_headers
	reading_body
	complete
	error
}

pub struct AsyncHttpBuffer {
pub mut:
	data           string
	header_len     int
	content_length int
	state          BufferState
	is_eof         bool
}

pub fn new_async_buffer() AsyncHttpBuffer {
	return AsyncHttpBuffer{
		data: ''
		header_len: 0
		content_length: 0
		state: .init
		is_eof: false
	}
}

pub fn (mut b AsyncHttpBuffer) append(chunk string) {
	b.data += chunk
	b.update_state()
}

pub fn (mut b AsyncHttpBuffer) set_eof() {
	b.is_eof = true
	b.update_state()
}

pub fn (mut b AsyncHttpBuffer) update_state() {
	if b.state == .init || b.state == .reading_headers {
		sep_pos := b.data.index('\r\n\r\n') or {
			b.data.index('\n\n') or { -1 }
		}
		if sep_pos != -1 {
			sep_len := if b.data.contains('\r\n\r\n') { 4 } else { 2 }
			b.header_len = sep_pos + sep_len
			b.state = .reading_body

			headers_part := b.data[..sep_pos].to_lower()
			if cl_pos := headers_part.index('content-length:') {
				val_part := headers_part[cl_pos + 15..].trim_space()
				lines := val_part.split_into_lines()
				if lines.len > 0 {
					b.content_length = lines[0].trim_space().int()
				}
			}
		} else {
			b.state = .reading_headers
		}
	}

	if b.state == .reading_body {
		if b.content_length > 0 {
			if b.data.len >= b.header_len + b.content_length {
				b.state = .complete
			}
		} else if b.is_eof {
			b.state = .complete
		}
	}

	if b.is_eof && b.header_len > 0 {
		b.state = .complete
	}
}

// v_async_fetch_worker 在 V 协程/线程中异步执行网络请求
fn v_async_fetch_worker(url string, method string, body string) {
	req := http.Request{
		url: url
		method: match method.to_upper() {
			'POST' { http.Method.post }
			'PUT' { http.Method.put }
			'DELETE' { http.Method.delete }
			'HEAD' { http.Method.head }
			else { http.Method.get }
		}
		data: body
		header: http.new_header(
			key: .content_type, value: 'application/x-www-form-urlencoded'
		)
	}
	
	res := req.do() or {
		return
	}

	raw_res := "HTTP/1.1 ${res.status_code} OK\r\nContent-Type: application/json\r\nContent-Length: ${res.body.len}\r\n\r\n${res.body}"

	mut buf := new_async_buffer()
	buf.append(raw_res)
	buf.set_eof()

	// 状态机等待：确认转为 .complete 状态后才存入 Cache
	if buf.state == .complete {
		mut hc := get_http_cache()
		hc.mu.@lock()
		hc.cache[url] = AsyncHttpResponse{
			status_code: res.status_code
			body: buf.data
			created_at: time.now().unix()
		}
		hc.mu.unlock()
	}
}

// v_async_http_fetch 供 C 侧调用的出站异步 Fetch 接口
@[export: 'v_async_http_fetch']
pub fn v_async_http_fetch(c_url &char, c_method &char, c_body &char) &char {
	url := unsafe { c_url.vstring() }
	method := unsafe { c_method.vstring() }
	body := unsafe { c_body.vstring() }

	if url == '' {
		return &char(''.str)
	}

	mut hc := get_http_cache()
	
	// 1. 优先查共享内存缓存 (600 秒有效)
	hc.mu.@lock()
	if url in hc.cache {
		cached := hc.cache[url]
		if time.now().unix() - cached.created_at < 600 {
			c_ptr := unsafe { &char(cached.body.str) }
			hc.mu.unlock()
			return c_ptr
		}
	}
	hc.mu.unlock()

	// 2. 触发 V 原生协程后台异步拉取真实网络数据
	spawn v_async_fetch_worker(url, method, body)

	// 3. 500ms 协程等待：等待 V 协程完成真实数据拉取，绝不向 PHP 吐假的占位 Frame
	for _ in 0 .. 50 {
		time.sleep(10 * time.millisecond)
		hc.mu.@lock()
		if url in hc.cache {
			cached := hc.cache[url]
			c_ptr := unsafe { &char(cached.body.str) }
			hc.mu.unlock()
			return c_ptr
		}
		hc.mu.unlock()
	}

	// 4. 若网络极其缓慢超 500ms，返回空字符串（触发 WP 重试机制，绝不写空 Transient 污染数据库）
	return &char(''.str)
}

module gateway

fn test_parse_urlencoded() {
	values := parse_urlencoded('message=hello+gateway&encoded=%E4%BD%A0%E5%A5%BD')
	assert values['message'] == 'hello gateway'
	assert values['encoded'] == '你好'
}

fn test_parse_cookies() {
	cookies := parse_cookies('session=abc123; theme=dark')
	assert cookies['session'] == 'abc123'
	assert cookies['theme'] == 'dark'
}

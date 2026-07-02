import rt

interface OAuthTokenProvider {
	getoauth64() rt.PhpVal
}

fn main() {
	defer {
		rt.shutdown()
	}
}

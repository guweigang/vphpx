import rt

struct Class_PHPMailer_PHPMailer_OAuth {
	rt.PhpObjectBase
pub mut:
	provider          rt.PhpVal = rt.new_null()
	oauthToken        rt.PhpVal = rt.new_null()
	oauthUserEmail    rt.PhpVal = rt.new_string('')
	oauthClientSecret rt.PhpVal = rt.new_string('')
	oauthClientId     rt.PhpVal = rt.new_string('')
	oauthRefreshToken rt.PhpVal = rt.new_string('')
}

fn (mut this Class_PHPMailer_PHPMailer_OAuth) construct(var_options rt.PhpVal) {
	this.provider = var_options.array_get(rt.new_string('provider'))
	this.oauthUserEmail = var_options.array_get(rt.new_string('userName'))
	this.oauthClientSecret = var_options.array_get(rt.new_string('clientSecret'))
	this.oauthClientId = var_options.array_get(rt.new_string('clientId'))
	this.oauthRefreshToken = var_options.array_get(rt.new_string('refreshToken'))
}

fn (mut this Class_PHPMailer_PHPMailer_OAuth) getgrant() rt.PhpVal {
	return rt.new_object('League_OAuth2_Client_Grant_RefreshToken', []string{},
		create_league_oauth2_client_grant_refreshtoken())
}

fn (mut this Class_PHPMailer_PHPMailer_OAuth) gettoken() rt.PhpVal {
	return rt.call_method(this.provider, 'getAccessToken', [this.getgrant(),
		rt.create_array([
			rt.ArrayItem{ key: 'refresh_token', val: this.oauthRefreshToken },
		])])
}

fn (mut this Class_PHPMailer_PHPMailer_OAuth) getoauth64() rt.PhpVal {
	if rt.is_true(rt.identical(rt.new_null(), this.oauthToken))
		|| rt.is_true(rt.call_method(this.oauthToken, 'hasExpired', []rt.PhpVal{})) {
		this.oauthToken = this.gettoken()
	}
	return rt.call_function('base64_encode', [
		rt.new_string('user=' +
			(this.oauthUserEmail).str() + '\\auth=Bearer ' + (this.oauthToken).str() + '\\\\'),
	])
}

struct Class_League_OAuth2_Client_Grant_RefreshToken {
	rt.PhpObjectBase
}

fn create_phpmailer_phpmailer_oauth(arg_0 rt.PhpVal) &Class_PHPMailer_PHPMailer_OAuth {
	mut obj := &Class_PHPMailer_PHPMailer_OAuth{
		PhpObjectBase:     rt.PhpObjectBase{}
		provider:          rt.new_null()
		oauthToken:        rt.new_null()
		oauthUserEmail:    rt.new_string('')
		oauthClientSecret: rt.new_string('')
		oauthClientId:     rt.new_string('')
		oauthRefreshToken: rt.new_string('')
	}
	obj.construct(arg_0)
	return obj
}

fn create_league_oauth2_client_grant_refreshtoken(_args ...rt.PhpVal) &Class_League_OAuth2_Client_Grant_RefreshToken {
	mut obj := &Class_League_OAuth2_Client_Grant_RefreshToken{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_PHPMailer_PHPMailer_OAuth) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			this.construct(dispatch_arg_0)
			return rt.new_null()
		}
		'getGrant' {
			return this.getgrant()
		}
		'getToken' {
			return this.gettoken()
		}
		'getOauth64' {
			return this.getoauth64()
		}
		else {
			return none
		}
	}
}

fn (this &Class_PHPMailer_PHPMailer_OAuth) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'provider' { return this.provider }
		'oauthToken' { return this.oauthToken }
		'oauthUserEmail' { return this.oauthUserEmail }
		'oauthClientSecret' { return this.oauthClientSecret }
		'oauthClientId' { return this.oauthClientId }
		'oauthRefreshToken' { return this.oauthRefreshToken }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_PHPMailer_PHPMailer_OAuth) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'provider' {
			this.provider = val
			return true
		}
		'oauthToken' {
			this.oauthToken = val
			return true
		}
		'oauthUserEmail' {
			this.oauthUserEmail = val
			return true
		}
		'oauthClientSecret' {
			this.oauthClientSecret = val
			return true
		}
		'oauthClientId' {
			this.oauthClientId = val
			return true
		}
		'oauthRefreshToken' {
			this.oauthRefreshToken = val
			return true
		}
		else {
			return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
		}
	}
}

fn (mut this Class_League_OAuth2_Client_Grant_RefreshToken) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_League_OAuth2_Client_Grant_RefreshToken) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_League_OAuth2_Client_Grant_RefreshToken) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}
}

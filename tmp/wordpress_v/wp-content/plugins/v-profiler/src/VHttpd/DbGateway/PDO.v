import rt

struct Class_VHttpd_DbGateway_PDO {
	rt.PhpObjectBase
pub mut:
		client rt.PhpVal = rt.new_null()
		sessionId rt.PhpVal = rt.new_null()
		lastInsertId rt.PhpVal = rt.new_null()
}

fn (mut this Class_VHttpd_DbGateway_PDO) construct(socketPath string, pool string, connectTimeoutSeconds f64, readTimeoutSeconds f64)  {
}

fn (mut this Class_VHttpd_DbGateway_PDO) magic_destruct()  {
	this.close()
}

fn (mut this Class_VHttpd_DbGateway_PDO) connect()  {
	if rt.is_true(rt.identical(this.client, rt.new_null())) {
		this.client = create_vhttpd_dbgateway_client(rt.get_property(rt.new_object('VHttpd_DbGateway_PDO', []string{}, &this), 'socketPath'), rt.get_property(rt.new_object('VHttpd_DbGateway_PDO', []string{}, &this), 'pool'), rt.get_property(rt.new_object('VHttpd_DbGateway_PDO', []string{}, &this), 'connectTimeoutSeconds'), rt.get_property(rt.new_object('VHttpd_DbGateway_PDO', []string{}, &this), 'readTimeoutSeconds'))
	}
	rt.call_method(this.client, 'connect', []rt.PhpVal{})
}

fn (mut this Class_VHttpd_DbGateway_PDO) close()  {
	// unsupported expression: Expr_NullsafeMethodCall
	this.client = rt.new_null()
	this.sessionId = rt.new_null()
}

fn (mut this Class_VHttpd_DbGateway_PDO) intransaction() bool {
	return (// unsupported expression: Expr_BinaryOp_NotIdentical).to_bool()
}

fn (mut this Class_VHttpd_DbGateway_PDO) begintransaction() bool {
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('transaction_already_started'))))
	}
	this.sessionId = rt.call_method(this.client(), 'beginTransaction', []rt.PhpVal{})
	return true
}

fn (mut this Class_VHttpd_DbGateway_PDO) commit() bool {
	if rt.is_true(rt.identical(this.sessionId, rt.new_null())) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('no_active_transaction'))))
	}
	rt.call_method(this.client(), 'commit', [this.sessionId])
	this.sessionId = rt.new_null()
	return true
}

fn (mut this Class_VHttpd_DbGateway_PDO) rollback() bool {
	if rt.is_true(rt.identical(this.sessionId, rt.new_null())) {
		rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('no_active_transaction'))))
	}
	rt.call_method(this.client(), 'rollback', [this.sessionId])
	this.sessionId = rt.new_null()
	return true
}

fn (mut this Class_VHttpd_DbGateway_PDO) prepare(sql string) rt.PhpVal {
	return create_vhttpd_dbgateway_pdostatement(rt.new_object('VHttpd_DbGateway_PDO', []string{}, &this).dup(), rt.new_string(sql).dup())
}

fn (mut this Class_VHttpd_DbGateway_PDO) query(sql string, mut var_params Class_VHttpd_DbGateway_?array) rt.PhpVal {
	mut var_stmt := this.prepare(sql)
	rt.call_method(var_stmt, 'execute', [if !(var_params).is_null() { var_params } else { rt.new_array() }])
	return var_stmt.dup()
}

fn (mut this Class_VHttpd_DbGateway_PDO) exec(sql string, mut var_params Class_VHttpd_DbGateway_?array) i64 {
	return this.execute(sql, mut rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if !(var_params).is_null() { var_params } else { rt.new_array() }), 0)
}

fn (mut this Class_VHttpd_DbGateway_PDO) execute(sql string, mut var_bindings Class_VHttpd_DbGateway_array, timeoutMs i64) i64 {
	mut var_result := this.gatewayexecute(sql, mut var_bindings, timeoutMs)
	return (// unsupported expression: Expr_Cast_Int).to_i64()
}

fn (mut this Class_VHttpd_DbGateway_PDO) gatewayexecute(sql string, mut var_bindings Class_VHttpd_DbGateway_array, timeoutMs i64) rt.PhpVal {
	mut var_result := rt.call_method(this.client(), 'execute', [rt.new_string(sql), rt.call_function('array_values', [var_bindings]), if !(this.sessionId).is_null() { this.sessionId } else { rt.new_string('') }, rt.new_int(timeoutMs)])
	this.lastInsertId = if var_result.array_isset(rt.new_string('last_insert_id')) { // unsupported expression: Expr_Cast_String } else { rt.new_null() }
	return var_result.dup()
}

fn (mut this Class_VHttpd_DbGateway_PDO) gatewayquery(sql string, mut var_bindings Class_VHttpd_DbGateway_array, timeoutMs i64) rt.PhpVal {
	return rt.call_method(this.client(), 'query', [rt.new_string(sql), rt.call_function('array_values', [var_bindings]), if !(this.sessionId).is_null() { this.sessionId } else { rt.new_string('') }, rt.new_int(timeoutMs)])
}

fn (mut this Class_VHttpd_DbGateway_PDO) isquerysql(sql string) bool {
	mut var_prefix := rt.new_string(rt.new_string(if rt.is_true(rt.call_function('strtok', [rt.new_string(sql.trim_left(' \t\n\r')), rt.new_string(' \t\r\n(')])) { rt.call_function('strtok', [rt.new_string(sql.trim_left(' \t\n\r')), rt.new_string(' \t\r\n(')]) } else { rt.new_string('') }.to_string().to_upper()))
	return (rt.call_function('in_array', [var_prefix.dup(), rt.create_array([rt.ArrayItem{ key: none, val: 'SELECT' }, rt.ArrayItem{ key: none, val: 'SHOW' }, rt.ArrayItem{ key: none, val: 'DESCRIBE' }, rt.ArrayItem{ key: none, val: 'EXPLAIN' }, rt.ArrayItem{ key: none, val: 'WITH' }, rt.ArrayItem{ key: none, val: 'PRAGMA' }]), rt.new_bool(true)])).to_bool()
}

fn (mut this Class_VHttpd_DbGateway_PDO) lastinsertid() string {
	return (this.lastInsertId).str()
}

fn (mut this Class_VHttpd_DbGateway_PDO) ping() bool {
	rt.call_method(this.client(), 'ping', []rt.PhpVal{})
	return true
}

fn (mut this Class_VHttpd_DbGateway_PDO) client() rt.PhpVal {
	this.connect()
	return if !(this.client).is_null() { this.client } else { rt.throw_exception(rt.new_object('RuntimeException', []string{}, create_runtimeexception(rt.new_string('db_gateway_client_not_initialized')))) }
}

struct Class_VHttpd_DbGateway_Client {
	rt.PhpObjectBase
}

struct Class_RuntimeException {
	rt.PhpObjectBase
}

struct Class_VHttpd_DbGateway_PDOStatement {
	rt.PhpObjectBase
}

fn create_vhttpd_dbgateway_pdo(socketPath string, pool string, connectTimeoutSeconds f64, readTimeoutSeconds f64) &Class_VHttpd_DbGateway_PDO {
	mut obj := &Class_VHttpd_DbGateway_PDO{
		PhpObjectBase: rt.PhpObjectBase{}
		client: rt.new_null()
		sessionId: rt.new_null()
		lastInsertId: rt.new_null()
	}
	obj.construct(socketPath, pool, connectTimeoutSeconds, readTimeoutSeconds)
	return obj
}

fn create_vhttpd_dbgateway_client() &Class_VHttpd_DbGateway_Client {
	mut obj := &Class_VHttpd_DbGateway_Client{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_runtimeexception() &Class_RuntimeException {
	mut obj := &Class_RuntimeException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_vhttpd_dbgateway_pdostatement() &Class_VHttpd_DbGateway_PDOStatement {
	mut obj := &Class_VHttpd_DbGateway_PDOStatement{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_VHttpd_DbGateway_PDO) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'__construct' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_f64()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_f64()
			this.construct(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
			return rt.new_null()
		}
		'__destruct' {
			this.magic_destruct()
			return rt.new_null()
		}
		'connect' {
			this.connect()
			return rt.new_null()
		}
		'close' {
			this.close()
			return rt.new_null()
		}
		'inTransaction' {
			return rt.new_bool(this.intransaction())
		}
		'beginTransaction' {
			return rt.new_bool(this.begintransaction())
		}
		'commit' {
			return rt.new_bool(this.commit())
		}
		'rollBack' {
			return rt.new_bool(this.rollback())
		}
		'prepare' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return this.prepare(dispatch_arg_0)
		}
		'query' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return this.query(dispatch_arg_0, mut dispatch_arg_1)
		}
		'exec' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_?array](if args.len > 1 { args[1] } else { rt.new_null() })
			return rt.new_int(this.exec(dispatch_arg_0, mut dispatch_arg_1))
		}
		'execute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return rt.new_int(this.execute(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2))
		}
		'gatewayExecute' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.gatewayexecute(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'gatewayQuery' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			mut dispatch_arg_1 := rt.cast_object_ptr[Class_VHttpd_DbGateway_array](if args.len > 1 { args[1] } else { rt.new_null() })
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return this.gatewayquery(dispatch_arg_0, mut dispatch_arg_1, dispatch_arg_2)
		}
		'isQuerySql' {
			dispatch_arg_0 := (if args.len > 0 { args[0] } else { rt.new_null() }).str()
			return rt.new_bool(this.isquerysql(dispatch_arg_0))
		}
		'lastInsertId' {
			return rt.new_string(this.lastinsertid())
		}
		'ping' {
			return rt.new_bool(this.ping())
		}
		'client' {
			return this.client()
		}
		else { return none }
	}
}

fn (this &Class_VHttpd_DbGateway_PDO) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	match prop_name {
		'client' { return this.client }
		'sessionId' { return this.sessionId }
		'lastInsertId' { return this.lastInsertId }
		else { return this.PhpObjectBase.dispatch_get_prop(prop_name) }
	}
}

fn (mut this Class_VHttpd_DbGateway_PDO) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	match prop_name {
		'client' { this.client = val; return true }
		'sessionId' { this.sessionId = val; return true }
		'lastInsertId' { this.lastInsertId = val; return true }
		else { return this.PhpObjectBase.dispatch_set_prop(prop_name, val) }
	}
}


fn (mut this Class_VHttpd_DbGateway_Client) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_DbGateway_Client) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_DbGateway_Client) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_RuntimeException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_RuntimeException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_RuntimeException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_VHttpd_DbGateway_PDOStatement) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_VHttpd_DbGateway_PDOStatement) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_VHttpd_DbGateway_PDOStatement) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_content_plugins_v_profiler_src_vhttpd_dbgateway_pdo_php() {
	// unsupported statement: Stmt_Declare
}

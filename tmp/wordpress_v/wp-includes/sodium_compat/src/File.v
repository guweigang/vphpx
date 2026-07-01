import rt

pub fn Class_ParagonIE_Sodium_File.buffer_size() i64 {
	return 8192
}
struct Class_ParagonIE_Sodium_File {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_File.box(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_keyPair rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_inputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_inputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_outputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 2 must be a string, ' + (rt.call_function('gettype', [var_outputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_nonce_mutated.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 3 must be a string, ' + (rt.call_function('gettype', [var_nonce_mutated.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_keyPair.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 4 must be a string, ' + (rt.call_function('gettype', [var_keyPair.dup()])).str() + ' given.')))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 3 must be CRYPTO_BOX_NONCEBYTES bytes'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 4 must be CRYPTO_BOX_KEYPAIRBYTES bytes'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_size.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.dup(), rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ifp.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.dup(), rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ofp.dup()]))))) {
		rt.call_function('fclose', [var_ifp.dup()])
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.box_encrypt(var_ifp.dup(), var_ofp.dup(), var_size.dup(), var_nonce_mutated.dup(), var_keyPair.dup())
	rt.call_function('fclose', [var_ifp.dup()])
	rt.call_function('fclose', [var_ofp.dup()])
	return var_res.dup()
}

fn Class_ParagonIE_Sodium_File.box_open(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_ephKeypair := rt.new_null()
	mut var_nonce_mutated := var_nonce
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_inputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_inputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_outputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 2 must be a string, ' + (rt.call_function('gettype', [var_outputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_nonce_mutated.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 3 must be a string, ' + (rt.call_function('gettype', [var_nonce_mutated.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_keypair.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 4 must be a string, ' + (rt.call_function('gettype', [var_keypair.dup()])).str() + ' given.')))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 4 must be CRYPTO_BOX_NONCEBYTES bytes'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 4 must be CRYPTO_BOX_KEYPAIRBYTES bytes'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_inputFile.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_size.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.dup(), rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ifp.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.dup(), rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ofp.dup()]))))) {
		rt.call_function('fclose', [var_ifp.dup()])
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.box_decrypt(var_ifp.dup(), var_ofp.dup(), var_size.dup(), var_nonce_mutated.dup(), var_keypair.dup())
	rt.call_function('fclose', [var_ifp.dup()])
	rt.call_function('fclose', [var_ofp.dup()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_nonce_mutated.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_ephKeypair.dup())
	if rt.has_exception() { unsafe { goto catch_label_1 } }
	unsafe { goto end_label_1 }

catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'SodiumException') {
		mut var_ex := var_e_1.dup()
		if !(var_ephKeypair).is_null() {
			var_ephKeypair = rt.new_null()
		}
		unsafe { goto end_label_1 }
	}
	else {
		rt.throw_exception(var_e_1)
		unsafe { goto end_label_1 }
	}

end_label_1:
	return var_res.dup()
}

fn Class_ParagonIE_Sodium_File.box_seal(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	mut var_publicKey_mutated := var_publicKey
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_inputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_inputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_outputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 2 must be a string, ' + (rt.call_function('gettype', [var_outputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_publicKey_mutated.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 3 must be a string, ' + (rt.call_function('gettype', [var_publicKey_mutated.dup()])).str() + ' given.')))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 3 must be CRYPTO_BOX_PUBLICKEYBYTES bytes'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_inputFile.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_size.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.dup(), rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ifp.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.dup(), rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ofp.dup()]))))) {
		rt.call_function('fclose', [var_ifp.dup()])
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_ephKeypair := fn () rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_keypair() }()
	mut var_msgKeypair := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_keypair_from_secretkey_and_publickey(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_secretkey(arg_0) }(var_ephKeypair.dup()), var_publicKey_mutated.dup())
	mut var_ephemeralPK := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_publickey(arg_0) }(var_ephKeypair.dup())
	mut var_nonce := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_generichash(arg_0, arg_1, arg_2) }(rt.new_string((var_ephemeralPK).str() + (var_publicKey_mutated).str()), rt.new_string(''), rt.new_int(24))
	mut var_firstWrite := rt.call_function('fwrite', [var_ofp.dup(), var_ephemeralPK.dup(), Class_ParagonIE_Sodium_Compat.crypto_box_publickeybytes()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_firstWrite.dup().is_long()))))) {
		rt.call_function('fclose', [var_ifp.dup()])
		rt.call_function('fclose', [var_ofp.dup()])
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_ephKeypair.dup())
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not write to output file'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_ephKeypair.dup())
		rt.call_function('fclose', [var_ifp.dup()])
		rt.call_function('fclose', [var_ofp.dup()])
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Error writing public key to output file'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.box_encrypt(var_ifp.dup(), var_ofp.dup(), var_size.dup(), var_nonce.dup(), var_msgKeypair.dup())
	rt.call_function('fclose', [var_ifp.dup()])
	rt.call_function('fclose', [var_ofp.dup()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_nonce.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(var_ephKeypair.dup())
	if rt.has_exception() { unsafe { goto catch_label_2 } }
	unsafe { goto end_label_2 }

catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'SodiumException') {
		mut var_ex := var_e_2.dup()
		var_ephKeypair = rt.new_null()
		unsafe { goto end_label_2 }
	}
	else {
		rt.throw_exception(var_e_2)
		unsafe { goto end_label_2 }
	}

end_label_2:
	return var_res.dup()
}

fn Class_ParagonIE_Sodium_File.box_seal_open(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_ecdhKeypair rt.PhpVal) rt.PhpVal {
	mut var_ephKeypair := rt.new_null()
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_inputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 1 must be a string, ' + (rt.call_function('gettype', [var_inputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_outputFile.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 2 must be a string, ' + (rt.call_function('gettype', [var_outputFile.dup()])).str() + ' given.')))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_ecdhKeypair.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror('Argument 3 must be a string, ' + (rt.call_function('gettype', [var_ecdhKeypair.dup()])).str() + ' given.')))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(rt.new_string('Argument 3 must be CRYPTO_BOX_KEYPAIRBYTES bytes'))))
	}
	mut var_publicKey := fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_publickey(arg_0) }(var_ecdhKeypair.dup())
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [var_inputFile.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.dup()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_size.dup().is_long()))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.dup(), rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ifp.dup()]))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.dup(), rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [var_ofp.dup()]))))) {
		rt.call_function('fclose', [var_ifp.dup()])
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_ephemeralPK := rt.call_function('fread', [var_ifp.dup(), Class_ParagonIE_Sodium_Compat.crypto_box_publickeybytes()])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.new_bool(var_ephemeralPK.dup().is_string()))))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	if rt.is_true(// unsupported expression: Expr_BinaryOp_NotIdentical) {
		rt.call_function('fclose', [var_ifp.dup()])
		rt.call_function('fclose', [var_ofp.dup()])
		rt.throw_exception(rt.new_object('SodiumException', []string{}, create_sodiumexception(rt.new_string('Could not read public key from sealed file'))))
	}
	mut var_nonce := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal, arg_2 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_generichash(arg_0, arg_1, arg_2) }(rt.new_string((var_ephemeralPK).str() + (var_publicKey).str()), rt.new_string(''), rt.new_int(24))
	mut var_msgKeypair := fn (arg_0 rt.PhpVal, arg_1 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_keypair_from_secretkey_and_publickey(arg_0, arg_1) }(fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.crypto_box_secretkey(arg_0) }(var_ecdhKeypair.dup()), var_ephemeralPK.dup())
	mut var_res := Class_ParagonIE_Sodium_File.box_decrypt(var_ifp.dup(), var_ofp.dup(), var_size.dup(), var_nonce.dup(), var_msgKeypair.dup())
	rt.call_function('fclose', [var_ifp.dup()])
	rt.call_function('fclose', [var_ofp.dup()])
	fn (arg_0 rt.PhpVal) rt.PhpVal { mut temp := Class_ParagonIE_Sodium_Compat{}; return temp.memzero(arg_0) }(.dup())
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	
	if rt.has_exception() { unsafe { goto catch_label_3 } }
	unsafe { goto end_label_3 }

catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'SodiumException') {
		mut var_ex := var_e_3.dup()
		unsafe { goto end_label_3 }
	}
	else {
		rt.throw_exception(var_e_3)
		unsafe { goto end_label_3 }
	}

end_label_3:
}

fn Class_ParagonIE_Sodium_File.generichash(var_filePath rt.PhpVal, key string, outputLength i64) rt.PhpVal {
	mut key_mutated := key
	mut outputLength_mutated := outputLength
}

fn Class_ParagonIE_Sodium_File.secretbox(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
}

fn Class_ParagonIE_Sodium_File.secretbox_open(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
}

fn Class_ParagonIE_Sodium_File.sign(var_filePath rt.PhpVal, var_secretKey rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_File.verify(var_sig rt.PhpVal, var_filePath rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_publicKey_mutated := var_publicKey
}

fn Class_ParagonIE_Sodium_File.box_encrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_boxKeypair rt.PhpVal) rt.PhpVal {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
}

fn Class_ParagonIE_Sodium_File.box_decrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_boxKeypair rt.PhpVal) rt.PhpVal {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
}

fn Class_ParagonIE_Sodium_File.secretbox_encrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
}

fn Class_ParagonIE_Sodium_File.secretbox_decrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
}

fn Class_ParagonIE_Sodium_File.onetimeauth_verify(mut var_state Class_ParagonIE_Sodium_Core_Poly1305_State, var_ifp rt.PhpVal, tag string, mlen i64) rt.PhpVal {
	mut var_state_mutated := var_state
	mut var_ifp_mutated := var_ifp
	mut tag_mutated := tag
}

fn Class_ParagonIE_Sodium_File.updatehashwithfile(var_hash rt.PhpVal, var_fp rt.PhpVal, size i64) rt.PhpVal {
	mut var_fp_mutated := var_fp
	mut size_mutated := size
}

fn Class_ParagonIE_Sodium_File.sign_core32(var_filePath rt.PhpVal, var_secretKey rt.PhpVal) rt.PhpVal {
}

fn Class_ParagonIE_Sodium_File.verify_core32(var_sig rt.PhpVal, var_filePath rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_publicKey_mutated := var_publicKey
}

fn Class_ParagonIE_Sodium_File.secretbox_encrypt_core32(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
}

fn Class_ParagonIE_Sodium_File.secretbox_decrypt_core32(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
}

fn Class_ParagonIE_Sodium_File.onetimeauth_verify_core32(mut var_state Class_ParagonIE_Sodium_Core32_Poly1305_State, var_ifp rt.PhpVal, tag string, mlen i64) rt.PhpVal {
	mut var_state_mutated := var_state
	mut var_ifp_mutated := var_ifp
	mut tag_mutated := tag
}

fn Class_ParagonIE_Sodium_File.ftell(var_resource rt.PhpVal) rt.PhpVal {
}

struct Class_ParagonIE_Sodium_Core_Util {
	rt.PhpObjectBase
}

struct Class_TypeError {
	rt.PhpObjectBase
}

struct Class_SodiumException {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Compat {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_file() &Class_ParagonIE_Sodium_File {
	mut obj := &Class_ParagonIE_Sodium_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_util() &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror() &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_sodiumexception() &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_compat() &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn (mut this Class_ParagonIE_Sodium_File) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	match method_name {
		'box' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'box_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_open(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'box_seal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_seal(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'box_seal_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_seal_open(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'generichash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.generichash(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'secretbox' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.secretbox(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'secretbox_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.secretbox_open(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'sign' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.sign(dispatch_arg_0, dispatch_arg_1)
		}
		'verify' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.verify(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'box_encrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_encrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'box_decrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_decrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'secretbox_encrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_encrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'secretbox_decrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_decrypt(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'onetimeauth_verify' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Poly1305_State](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.onetimeauth_verify(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'updateHashWithFile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.updatehashwithfile(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'sign_core32' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.sign_core32(dispatch_arg_0, dispatch_arg_1)
		}
		'verify_core32' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.verify_core32(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2)
		}
		'secretbox_encrypt_core32' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_encrypt_core32(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'secretbox_decrypt_core32' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_decrypt_core32(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'onetimeauth_verify_core32' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Poly1305_State](if args.len > 0 { args[0] } else { rt.new_null() })
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.onetimeauth_verify_core32(mut dispatch_arg_0, dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'ftell' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.ftell(dispatch_arg_0)
		}
		else { return none }
	}
}

fn (this &Class_ParagonIE_Sodium_File) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_File) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_TypeError) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_TypeError) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_TypeError) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_SodiumException) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_SodiumException) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_SodiumException) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}


fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Compat) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Compat) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}




pub fn init_wp_includes_sodium_compat_src_file_php() {
	if rt.is_true(rt.call_function('class_exists', [rt.new_string('ParagonIE_Sodium_File'), rt.new_bool(false)])) {
		return rt.new_null()
	}
}

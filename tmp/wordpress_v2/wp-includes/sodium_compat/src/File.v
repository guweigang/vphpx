import rt

pub fn Class_ParagonIE_Sodium_File.buffer_size() i64 {
	return 8192
}

struct Class_ParagonIE_Sodium_File {
	rt.PhpObjectBase
}

fn Class_ParagonIE_Sodium_File.box(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_keyPair rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	if !(var_inputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_inputFile.clone()])).str() + ' given.')))
	}
	if !(var_outputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_outputFile.clone()])).str() + ' given.')))
	}
	if !(var_nonce_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be a string, ' +
			(rt.call_function('gettype', [var_nonce_mutated.clone()])).str() + ' given.')))
	}
	if !(var_keyPair.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 4 must be a string, ' +
			(rt.call_function('gettype', [var_keyPair.clone()])).str() + ' given.')))
	}
	mut iife_temp_0 := Class_ParagonIE_Sodium_File{}
	mut iife_result_0 := iife_temp_0.strlen(var_nonce_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_0,
		Class_ParagonIE_Sodium_Compat.crypto_box_noncebytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be CRYPTO_BOX_NONCEBYTES bytes'))))
	}
	mut iife_temp_1 := Class_ParagonIE_Sodium_File{}
	mut iife_result_1 := iife_temp_1.strlen(var_keyPair.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_1,
		Class_ParagonIE_Sodium_Compat.crypto_box_keypairbytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 4 must be CRYPTO_BOX_KEYPAIRBYTES bytes'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ifp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.clone(),
		rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ofp.clone()])))))
	{
		rt.call_function('fclose', [var_ifp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.box_encrypt(var_ifp.clone(), var_ofp.clone(),
		var_size.clone(), var_nonce_mutated.clone(), var_keyPair.clone())
	rt.call_function('fclose', [var_ifp.clone()])
	rt.call_function('fclose', [var_ofp.clone()])
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.box_open(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_keypair rt.PhpVal) rt.PhpVal {
	mut var_ephKeypair := rt.new_null()
	mut var_nonce_mutated := var_nonce
	if !(var_inputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_inputFile.clone()])).str() + ' given.')))
	}
	if !(var_outputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_outputFile.clone()])).str() + ' given.')))
	}
	if !(var_nonce_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be a string, ' +
			(rt.call_function('gettype', [var_nonce_mutated.clone()])).str() + ' given.')))
	}
	if !(var_keypair.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 4 must be a string, ' +
			(rt.call_function('gettype', [var_keypair.clone()])).str() + ' given.')))
	}
	mut iife_temp_2 := Class_ParagonIE_Sodium_File{}
	mut iife_result_2 := iife_temp_2.strlen(var_nonce_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_2,
		Class_ParagonIE_Sodium_Compat.crypto_box_noncebytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 4 must be CRYPTO_BOX_NONCEBYTES bytes'))))
	}
	mut iife_temp_3 := Class_ParagonIE_Sodium_File{}
	mut iife_result_3 := iife_temp_3.strlen(var_keypair.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_3,
		Class_ParagonIE_Sodium_Compat.crypto_box_keypairbytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 4 must be CRYPTO_BOX_KEYPAIRBYTES bytes'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_inputFile.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ifp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.clone(),
		rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ofp.clone()])))))
	{
		rt.call_function('fclose', [var_ifp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.box_decrypt(var_ifp.clone(), var_ofp.clone(),
		var_size.clone(), var_nonce_mutated.clone(), var_keypair.clone())
	rt.call_function('fclose', [var_ifp.clone()])
	rt.call_function('fclose', [var_ofp.clone()])
	mut iife_temp_4 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_4 := iife_temp_4.memzero(var_nonce_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	mut iife_temp_5 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_5 := iife_temp_5.memzero(var_ephKeypair.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_1
		}
	}
	unsafe {
		goto end_label_1
	}
	catch_label_1:
	mut var_e_1 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_1, 'SodiumException') {
		mut var_ex := var_e_1.clone()
		if !var_ephKeypair.is_null() {
			var_ephKeypair = rt.new_null()
		}
		unsafe {
			goto end_label_1
		}
	} else {
		rt.throw_exception(var_e_1)
		unsafe {
			goto end_label_1
		}
	}

	end_label_1:
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.box_seal(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	mut var_publicKey_mutated := var_publicKey
	if !(var_inputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_inputFile.clone()])).str() + ' given.')))
	}
	if !(var_outputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_outputFile.clone()])).str() + ' given.')))
	}
	if !(var_publicKey_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be a string, ' +
			(rt.call_function('gettype', [var_publicKey_mutated.clone()])).str() + ' given.')))
	}
	mut iife_temp_6 := Class_ParagonIE_Sodium_File{}
	mut iife_result_6 := iife_temp_6.strlen(var_publicKey_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_6,
		Class_ParagonIE_Sodium_Compat.crypto_box_publickeybytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be CRYPTO_BOX_PUBLICKEYBYTES bytes'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_inputFile.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ifp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.clone(),
		rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ofp.clone()])))))
	{
		rt.call_function('fclose', [var_ifp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut iife_temp_7 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_7 := iife_temp_7.crypto_box_keypair()
	mut var_ephKeypair := iife_result_7
	mut iife_temp_8 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_8 := iife_temp_8.crypto_box_secretkey(var_ephKeypair.clone())
	mut iife_temp_9 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_9 := iife_temp_9.crypto_box_keypair_from_secretkey_and_publickey(iife_result_8,
		var_publicKey_mutated.clone())
	mut var_msgKeypair := iife_result_9
	mut iife_temp_10 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_10 := iife_temp_10.crypto_box_publickey(var_ephKeypair.clone())
	mut var_ephemeralPK := iife_result_10
	mut iife_temp_11 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_11 := iife_temp_11.crypto_generichash(rt.new_string(var_ephemeralPK.str() +
		var_publicKey_mutated.str()), rt.new_string(''), rt.new_int(24))
	mut var_nonce := iife_result_11
	mut var_firstWrite := rt.call_function('fwrite', [var_ofp.clone(),
		var_ephemeralPK.clone(), Class_ParagonIE_Sodium_Compat.crypto_box_publickeybytes()])
	if !(var_firstWrite.clone().is_long()) {
		rt.call_function('fclose', [var_ifp.clone()])
		rt.call_function('fclose', [var_ofp.clone()])
		mut iife_temp_12 := Class_ParagonIE_Sodium_Compat{}
		mut iife_result_12 := iife_temp_12.memzero(var_ephKeypair.clone())
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not write to output file'))))
	}
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(var_firstWrite,
		Class_ParagonIE_Sodium_Compat.crypto_box_publickeybytes()))))
	{
		mut iife_temp_13 := Class_ParagonIE_Sodium_Compat{}
		mut iife_result_13 := iife_temp_13.memzero(var_ephKeypair.clone())
		rt.call_function('fclose', [var_ifp.clone()])
		rt.call_function('fclose', [var_ofp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Error writing public key to output file'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.box_encrypt(var_ifp.clone(), var_ofp.clone(),
		var_size.clone(), var_nonce.clone(), var_msgKeypair.clone())
	rt.call_function('fclose', [var_ifp.clone()])
	rt.call_function('fclose', [var_ofp.clone()])
	mut iife_temp_14 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_14 := iife_temp_14.memzero(var_nonce.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	mut iife_temp_15 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_15 := iife_temp_15.memzero(var_ephKeypair.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_2
		}
	}
	unsafe {
		goto end_label_2
	}
	catch_label_2:
	mut var_e_2 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_2, 'SodiumException') {
		mut var_ex := var_e_2.clone()
		var_ephKeypair = rt.new_null()
		unsafe {
			goto end_label_2
		}
	} else {
		rt.throw_exception(var_e_2)
		unsafe {
			goto end_label_2
		}
	}

	end_label_2:
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.box_seal_open(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_ecdhKeypair rt.PhpVal) rt.PhpVal {
	mut var_ephKeypair := rt.new_null()
	if !(var_inputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_inputFile.clone()])).str() + ' given.')))
	}
	if !(var_outputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_outputFile.clone()])).str() + ' given.')))
	}
	if !(var_ecdhKeypair.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be a string, ' +
			(rt.call_function('gettype', [var_ecdhKeypair.clone()])).str() + ' given.')))
	}
	mut iife_temp_16 := Class_ParagonIE_Sodium_File{}
	mut iife_result_16 := iife_temp_16.strlen(var_ecdhKeypair.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_16,
		Class_ParagonIE_Sodium_Compat.crypto_box_keypairbytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be CRYPTO_BOX_KEYPAIRBYTES bytes'))))
	}
	mut iife_temp_17 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_17 := iife_temp_17.crypto_box_publickey(var_ecdhKeypair.clone())
	mut var_publicKey := iife_result_17
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_inputFile.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ifp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.clone(),
		rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ofp.clone()])))))
	{
		rt.call_function('fclose', [var_ifp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_ephemeralPK := rt.call_function('fread', [var_ifp.clone(),
		Class_ParagonIE_Sodium_Compat.crypto_box_publickeybytes()])
	if !(var_ephemeralPK.clone().is_string()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	mut iife_temp_18 := Class_ParagonIE_Sodium_File{}
	mut iife_result_18 := iife_temp_18.strlen(var_ephemeralPK.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_18,
		Class_ParagonIE_Sodium_Compat.crypto_box_publickeybytes()))))
	{
		rt.call_function('fclose', [var_ifp.clone()])
		rt.call_function('fclose', [var_ofp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read public key from sealed file'))))
	}
	mut iife_temp_19 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_19 := iife_temp_19.crypto_generichash(rt.new_string(var_ephemeralPK.str() +
		var_publicKey.str()), rt.new_string(''), rt.new_int(24))
	mut var_nonce := iife_result_19
	mut iife_temp_20 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_20 := iife_temp_20.crypto_box_secretkey(var_ecdhKeypair.clone())
	mut iife_temp_21 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_21 := iife_temp_21.crypto_box_keypair_from_secretkey_and_publickey(iife_result_20,
		var_ephemeralPK.clone())
	mut var_msgKeypair := iife_result_21
	mut var_res := Class_ParagonIE_Sodium_File.box_decrypt(var_ifp.clone(), var_ofp.clone(),
		var_size.clone(), var_nonce.clone(), var_msgKeypair.clone())
	rt.call_function('fclose', [var_ifp.clone()])
	rt.call_function('fclose', [var_ofp.clone()])
	mut iife_temp_22 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_22 := iife_temp_22.memzero(var_nonce.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	mut iife_temp_23 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_23 := iife_temp_23.memzero(var_ephKeypair.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_3
		}
	}
	unsafe {
		goto end_label_3
	}
	catch_label_3:
	mut var_e_3 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_3, 'SodiumException') {
		mut var_ex := var_e_3.clone()
		if !var_ephKeypair.is_null() {
			var_ephKeypair = rt.new_null()
		}
		unsafe {
			goto end_label_3
		}
	} else {
		rt.throw_exception(var_e_3)
		unsafe {
			goto end_label_3
		}
	}

	end_label_3:
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.generichash(var_filePath rt.PhpVal, key string, outputLength i64) rt.PhpVal {
	mut key_mutated := key
	mut outputLength_mutated := outputLength
	if !(var_filePath.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_filePath.clone()])).str() + ' given.')))
	}
	if !(rt.new_string(key_mutated).clone().is_string()) {
		if rt.is_true(rt.new_bool(rt.new_string(key_mutated).clone().is_null())) {
			key_mutated = ''
		} else {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 2 must be a string, ' +
				(rt.call_function('gettype', [rt.new_string(key_mutated).clone()])).str() +
				' given.')))
		}
	}
	if !(rt.new_int(outputLength_mutated).clone().is_long()) {
		if !(rt.new_int(outputLength_mutated).clone().is_long()
			|| rt.new_int(outputLength_mutated).clone().is_double()) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 3 must be an integer, ' +
				(rt.call_function('gettype', [rt.new_int(outputLength_mutated).clone()])).str() +
				' given.')))
		}
		outputLength_mutated = outputLength_mutated
	}
	if !(key_mutated == '') {
		mut iife_temp_24 := Class_ParagonIE_Sodium_File{}
		mut iife_result_24 := iife_temp_24.strlen(rt.new_string(key_mutated))
		if rt.is_true(rt.less(iife_result_24,
			Class_ParagonIE_Sodium_Compat.crypto_generichash_keybytes_min()))
		{
			rt.throw_exception(rt.new_object('TypeError', []string{},
				create_typeerror(rt.new_string('Argument 2 must be at least CRYPTO_GENERICHASH_KEYBYTES_MIN bytes'))))
		}
		mut iife_temp_25 := Class_ParagonIE_Sodium_File{}
		mut iife_result_25 := iife_temp_25.strlen(rt.new_string(key_mutated))
		if rt.is_true(rt.greater(iife_result_25,
			Class_ParagonIE_Sodium_Compat.crypto_generichash_keybytes_max()))
		{
			rt.throw_exception(rt.new_object('TypeError', []string{},
				create_typeerror(rt.new_string('Argument 2 must be at most CRYPTO_GENERICHASH_KEYBYTES_MAX bytes'))))
		}
	}
	if rt.is_true(rt.less(rt.new_int(outputLength_mutated),
		Class_ParagonIE_Sodium_Compat.crypto_generichash_bytes_min()))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument 3 must be at least CRYPTO_GENERICHASH_BYTES_MIN'))))
	}
	if rt.is_true(rt.greater(rt.new_int(outputLength_mutated),
		Class_ParagonIE_Sodium_Compat.crypto_generichash_bytes_max()))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Argument 3 must be at least CRYPTO_GENERICHASH_BYTES_MAX'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filePath.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('File does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_filePath.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_fp := rt.call_function('fopen', [var_filePath.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_fp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut iife_temp_26 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_26 := iife_temp_26.crypto_generichash_init(rt.new_string(key_mutated),
		rt.new_int(outputLength_mutated))
	mut var_ctx := iife_result_26
	for rt.is_true(rt.greater(var_size, rt.new_int(0))) {
		mut var_blockSize := if rt.is_true(rt.greater(var_size, rt.new_int(64))) {
			rt.new_int(64)
		} else {
			var_size
		}
		mut var_read := rt.call_function('fread', [var_fp.clone(),
			var_blockSize.clone()])
		if !(var_read.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Could not read input file'))))
		}
		mut iife_temp_27 := Class_ParagonIE_Sodium_Compat{}
		mut iife_result_27 := iife_temp_27.crypto_generichash_update(var_ctx.clone(),
			var_read.clone())
		var_size = rt.sub(var_size, var_blockSize)
	}
	rt.call_function('fclose', [var_fp.clone()])
	mut iife_temp_28 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_28 := iife_temp_28.crypto_generichash_final(var_ctx.clone(),
		rt.new_int(outputLength_mutated))
	return iife_result_28
}

fn Class_ParagonIE_Sodium_File.secretbox(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
	if !(var_inputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_inputFile.clone()])).str() + ' given..')))
	}
	if !(var_outputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_outputFile.clone()])).str() + ' given.')))
	}
	if !(var_nonce_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be a string, ' +
			(rt.call_function('gettype', [var_nonce_mutated.clone()])).str() + ' given.')))
	}
	mut iife_temp_29 := Class_ParagonIE_Sodium_File{}
	mut iife_result_29 := iife_temp_29.strlen(var_nonce_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_29,
		Class_ParagonIE_Sodium_Compat.crypto_secretbox_noncebytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be CRYPTO_SECRETBOX_NONCEBYTES bytes'))))
	}
	if !(var_key_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 4 must be a string, ' +
			(rt.call_function('gettype', [var_key_mutated.clone()])).str() + ' given.')))
	}
	mut iife_temp_30 := Class_ParagonIE_Sodium_File{}
	mut iife_result_30 := iife_temp_30.strlen(var_key_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_30,
		Class_ParagonIE_Sodium_Compat.crypto_secretbox_keybytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 4 must be CRYPTO_SECRETBOX_KEYBYTES bytes'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_inputFile.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ifp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.clone(),
		rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ofp.clone()])))))
	{
		rt.call_function('fclose', [var_ifp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.secretbox_encrypt(var_ifp.clone(), var_ofp.clone(),
		var_size.clone(), var_nonce_mutated.clone(), var_key_mutated.clone())
	rt.call_function('fclose', [var_ifp.clone()])
	rt.call_function('fclose', [var_ofp.clone()])
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.secretbox_open(var_inputFile rt.PhpVal, var_outputFile rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) rt.PhpVal {
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
	if !(var_inputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_inputFile.clone()])).str() + ' given.')))
	}
	if !(var_outputFile.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_outputFile.clone()])).str() + ' given.')))
	}
	if !(var_nonce_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be a string, ' +
			(rt.call_function('gettype', [var_nonce_mutated.clone()])).str() + ' given.')))
	}
	if !(var_key_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 4 must be a string, ' +
			(rt.call_function('gettype', [var_key_mutated.clone()])).str() + ' given.')))
	}
	mut iife_temp_31 := Class_ParagonIE_Sodium_File{}
	mut iife_result_31 := iife_temp_31.strlen(var_nonce_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_31,
		Class_ParagonIE_Sodium_Compat.crypto_secretbox_noncebytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be CRYPTO_SECRETBOX_NONCEBYTES bytes'))))
	}
	mut iife_temp_32 := Class_ParagonIE_Sodium_File{}
	mut iife_result_32 := iife_temp_32.strlen(var_key_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_32,
		Class_ParagonIE_Sodium_Compat.crypto_secretbox_keybytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 4 must be CRYPTO_SECRETBOX_KEYBYTES bytes'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_inputFile.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Input file does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_inputFile.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_ifp := rt.call_function('fopen', [var_inputFile.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ifp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_ofp := rt.call_function('fopen', [var_outputFile.clone(),
		rt.new_string('wb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_ofp.clone()])))))
	{
		rt.call_function('fclose', [var_ifp.clone()])
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open output file for writing'))))
	}
	mut var_res := Class_ParagonIE_Sodium_File.secretbox_decrypt(var_ifp.clone(), var_ofp.clone(),
		var_size.clone(), var_nonce_mutated.clone(), var_key_mutated.clone())
	rt.call_function('fclose', [var_ifp.clone()])
	rt.call_function('fclose', [var_ofp.clone()])
	mut iife_temp_33 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_33 := iife_temp_33.memzero(var_key_mutated.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_4
		}
	}
	unsafe {
		goto end_label_4
	}
	catch_label_4:
	mut var_e_4 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_4, 'SodiumException') {
		mut var_ex := var_e_4.clone()
		var_key_mutated = rt.new_null()
		unsafe {
			goto end_label_4
		}
	} else {
		rt.throw_exception(var_e_4)
		unsafe {
			goto end_label_4
		}
	}

	end_label_4:
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.sign(var_filePath rt.PhpVal, var_secretKey rt.PhpVal) rt.PhpVal {
	if !(var_filePath.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_filePath.clone()])).str() + ' given.')))
	}
	if !(var_secretKey.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_secretKey.clone()])).str() + ' given.')))
	}
	mut iife_temp_34 := Class_ParagonIE_Sodium_File{}
	mut iife_result_34 := iife_temp_34.strlen(var_secretKey.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_34,
		Class_ParagonIE_Sodium_Compat.crypto_sign_secretkeybytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 2 must be CRYPTO_SIGN_SECRETKEYBYTES bytes'))))
	}
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
		return Class_ParagonIE_Sodium_File.sign_core32(var_filePath.clone(), var_secretKey.clone())
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filePath.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('File does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_filePath.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_fp := rt.call_function('fopen', [var_filePath.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_fp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut iife_temp_35 := Class_ParagonIE_Sodium_File{}
	mut iife_result_35 := iife_temp_35.substr(var_secretKey.clone(), rt.new_int(0), rt.new_int(32))
	mut var_az := rt.call_function('hash',
		[rt.new_string('sha512'), iife_result_35, rt.new_bool(true)])
	mut iife_temp_36 := Class_ParagonIE_Sodium_File{}
	mut iife_result_36 := iife_temp_36.chrtoint(var_az.array_get(rt.new_int(0)))
	mut iife_temp_37 := Class_ParagonIE_Sodium_File{}
	mut iife_result_37 := iife_temp_37.inttochr(rt.new_int(rt.bitwise_and(iife_result_36,
		rt.new_int(248))))
	var_az.array_set(0, iife_result_37)
	mut iife_temp_38 := Class_ParagonIE_Sodium_File{}
	mut iife_result_38 := iife_temp_38.chrtoint(var_az.array_get(rt.new_int(31)))
	mut iife_temp_39 := Class_ParagonIE_Sodium_File{}
	mut iife_result_39 := iife_temp_39.inttochr(rt.new_int(rt.bitwise_and(iife_result_38,
		rt.new_int(63)) | 64))
	var_az.array_set(31, iife_result_39)
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_40 := Class_ParagonIE_Sodium_File{}
	mut iife_result_40 := iife_temp_40.substr(var_az.clone(), rt.new_int(32), rt.new_int(32))
	mut iife_temp_41 := Class_ParagonIE_Sodium_File{}
	mut iife_result_41 := iife_temp_41.hash_update(var_hs.clone(), iife_result_40)
	var_hs = Class_ParagonIE_Sodium_File.updatehashwithfile(var_hs.to_i64(), var_fp.clone(),
		var_size.clone())
	mut var_nonceHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_42 := Class_ParagonIE_Sodium_File{}
	mut iife_result_42 := iife_temp_42.substr(var_secretKey.clone(), rt.new_int(32), rt.new_int(32))
	mut var_pk := iife_result_42
	mut iife_temp_43 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_43 := iife_temp_43.sc_reduce(var_nonceHash.clone())
	mut iife_temp_44 := Class_ParagonIE_Sodium_File{}
	mut iife_result_44 := iife_temp_44.substr(var_nonceHash.clone(), rt.new_int(32))
	mut var_nonce := rt.new_string(iife_result_43.str() + iife_result_44.str())
	mut iife_temp_45 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_45 := iife_temp_45.ge_scalarmult_base(var_nonce.clone())
	mut iife_temp_46 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_46 := iife_temp_46.ge_p3_tobytes(iife_result_45)
	mut var_sig := iife_result_46
	var_hs = rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_47 := Class_ParagonIE_Sodium_File{}
	mut iife_result_47 := iife_temp_47.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_48 := Class_ParagonIE_Sodium_File{}
	mut iife_result_48 := iife_temp_48.hash_update(var_hs.clone(), iife_result_47)
	mut iife_temp_49 := Class_ParagonIE_Sodium_File{}
	mut iife_result_49 := iife_temp_49.substr(var_pk.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_50 := Class_ParagonIE_Sodium_File{}
	mut iife_result_50 := iife_temp_50.hash_update(var_hs.clone(), iife_result_49)
	var_hs = Class_ParagonIE_Sodium_File.updatehashwithfile(var_hs.to_i64(), var_fp.clone(),
		var_size.clone())
	mut var_hramHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_51 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_51 := iife_temp_51.sc_reduce(var_hramHash.clone())
	mut var_hram := iife_result_51
	mut iife_temp_52 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_52 := iife_temp_52.sc_muladd(var_hram.clone(), var_az.clone(),
		var_nonce.clone())
	mut var_sigAfter := iife_result_52
	mut iife_temp_53 := Class_ParagonIE_Sodium_File{}
	mut iife_result_53 := iife_temp_53.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_54 := Class_ParagonIE_Sodium_File{}
	mut iife_result_54 := iife_temp_54.substr(var_sigAfter.clone(), rt.new_int(0), rt.new_int(32))
	var_sig = rt.new_string(iife_result_53.str() + iife_result_54.str())
	mut iife_temp_55 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_55 := iife_temp_55.memzero(var_az.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_5
		}
	}
	unsafe {
		goto end_label_5
	}
	catch_label_5:
	mut var_e_5 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_5, 'SodiumException') {
		mut var_ex := var_e_5.clone()
		var_az = rt.new_null()
		unsafe {
			goto end_label_5
		}
	} else {
		rt.throw_exception(var_e_5)
		unsafe {
			goto end_label_5
		}
	}

	end_label_5:
	rt.call_function('fclose', [var_fp.clone()])
	return var_sig.clone()
}

fn Class_ParagonIE_Sodium_File.verify(var_sig rt.PhpVal, var_filePath rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_publicKey_mutated := var_publicKey
	if !(var_sig_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 1 must be a string, ' +
			(rt.call_function('gettype', [var_sig_mutated.clone()])).str() + ' given.')))
	}
	if !(var_filePath.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a string, ' +
			(rt.call_function('gettype', [var_filePath.clone()])).str() + ' given.')))
	}
	if !(var_publicKey_mutated.clone().is_string()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be a string, ' +
			(rt.call_function('gettype', [var_publicKey_mutated.clone()])).str() + ' given.')))
	}
	mut iife_temp_56 := Class_ParagonIE_Sodium_File{}
	mut iife_result_56 := iife_temp_56.strlen(var_sig_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_56,
		Class_ParagonIE_Sodium_Compat.crypto_sign_bytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 1 must be CRYPTO_SIGN_BYTES bytes'))))
	}
	mut iife_temp_57 := Class_ParagonIE_Sodium_File{}
	mut iife_result_57 := iife_temp_57.strlen(var_publicKey_mutated.clone())
	if rt.is_true(rt.new_bool(!rt.is_true(rt.identical(iife_result_57,
		Class_ParagonIE_Sodium_Compat.crypto_sign_publickeybytes()))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{},
			create_typeerror(rt.new_string('Argument 3 must be CRYPTO_SIGN_PUBLICKEYBYTES bytes'))))
	}
	mut iife_temp_58 := Class_ParagonIE_Sodium_File{}
	mut iife_result_58 := iife_temp_58.strlen(var_sig_mutated.clone())
	if rt.is_true(rt.less(iife_result_58, rt.new_int(64))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature is too short'))))
	}
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
		return Class_ParagonIE_Sodium_File.verify_core32(var_sig_mutated.clone(),
			var_filePath.clone(), var_publicKey_mutated.clone())
	}
	mut iife_temp_59 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_59 := iife_temp_59.chrtoint(var_sig_mutated.array_get(rt.new_int(63)))
	mut iife_temp_60 := Class_ParagonIE_Sodium_File{}
	mut iife_result_60 := iife_temp_60.substr(var_sig_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	mut iife_temp_61 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_61 := iife_temp_61.check_s_lt_l(iife_result_60)
	if rt.is_true(rt.bitwise_and(iife_result_59, rt.new_int(240))) && rt.is_true(iife_result_61) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('S < L - Invalid signature'))))
	}
	mut iife_temp_62 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_62 := iife_temp_62.small_order(var_sig_mutated.clone())
	if rt.is_true(iife_result_62) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature is on too small of an order'))))
	}
	mut iife_temp_63 := Class_ParagonIE_Sodium_File{}
	mut iife_result_63 := iife_temp_63.chrtoint(var_sig_mutated.array_get(rt.new_int(63)))
	if rt.is_true(rt.new_bool(rt.bitwise_and(iife_result_63, rt.new_int(224)) != 0)) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid signature'))))
	}
	mut var_d := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(32)))) { break
		 }
		rt.new_null()
		rt.pre_inc(var_i)
	}
	if rt.is_true(rt.identical(var_d, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('All zero public key'))))
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('file_exists', [
		var_filePath.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('File does not exist'))))
	}
	mut var_size := rt.call_function('filesize', [var_filePath.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_fp := rt.call_function('fopen', [var_filePath.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_fp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_orig := rt.get_static_prop('ParagonIE_Sodium_Compat', 'fastMult')
	rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', rt.new_bool(true))
	mut iife_temp_64 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_64 := iife_temp_64.small_order(var_publicKey_mutated.clone())
	if rt.is_true(iife_result_64) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Public key has small order'))))
	}
	mut iife_temp_65 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_65 := iife_temp_65.ge_frombytes_negate_vartime(var_publicKey_mutated.clone())
	mut var_A := iife_result_65
	mut iife_temp_66 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_66 := iife_temp_66.is_on_main_subgroup(var_A.clone())
	if rt.is_true(rt.new_bool(!(rt.is_true(iife_result_66)))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Public key is not on a member of the main subgroup'))))
	}
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_67 := Class_ParagonIE_Sodium_File{}
	mut iife_result_67 := iife_temp_67.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_68 := Class_ParagonIE_Sodium_File{}
	mut iife_result_68 := iife_temp_68.hash_update(var_hs.clone(), iife_result_67)
	mut iife_temp_69 := Class_ParagonIE_Sodium_File{}
	mut iife_result_69 := iife_temp_69.substr(var_publicKey_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_70 := Class_ParagonIE_Sodium_File{}
	mut iife_result_70 := iife_temp_70.hash_update(var_hs.clone(), iife_result_69)
	var_hs = Class_ParagonIE_Sodium_File.updatehashwithfile(var_hs.to_i64(), var_fp.clone(),
		var_size.clone())
	mut var_hDigest := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_71 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_71 := iife_temp_71.sc_reduce(var_hDigest.clone())
	mut iife_temp_72 := Class_ParagonIE_Sodium_File{}
	mut iife_result_72 := iife_temp_72.substr(var_hDigest.clone(), rt.new_int(32))
	mut var_h := rt.new_string(iife_result_71.str() + iife_result_72.str())
	mut iife_temp_73 := Class_ParagonIE_Sodium_File{}
	mut iife_result_73 := iife_temp_73.substr(var_sig_mutated.clone(), rt.new_int(32))
	mut iife_temp_74 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_74 := iife_temp_74.ge_double_scalarmult_vartime(var_h.clone(), var_A.clone(),
		iife_result_73)
	mut var_R := iife_result_74
	mut iife_temp_75 := Class_ParagonIE_Sodium_Core_Ed25519{}
	mut iife_result_75 := iife_temp_75.ge_tobytes(var_R.clone())
	mut var_rcheck := iife_result_75
	rt.call_function('fclose', [var_fp.clone()])
	rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', var_orig.clone())
	mut iife_temp_76 := Class_ParagonIE_Sodium_File{}
	mut iife_result_76 := iife_temp_76.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_77 := Class_ParagonIE_Sodium_File{}
	mut iife_result_77 := iife_temp_77.verify_32(var_rcheck.clone(), iife_result_76)
	return iife_result_77
}

fn Class_ParagonIE_Sodium_File.box_encrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_boxKeypair rt.PhpVal) rt.PhpVal {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
		mut iife_temp_78 := Class_ParagonIE_Sodium_Crypto32{}
		mut iife_result_78 := iife_temp_78.box_secretkey(var_boxKeypair.clone())
		mut iife_temp_79 := Class_ParagonIE_Sodium_Crypto32{}
		mut iife_result_79 := iife_temp_79.box_publickey(var_boxKeypair.clone())
		mut iife_temp_80 := Class_ParagonIE_Sodium_Crypto32{}
		mut iife_result_80 := iife_temp_80.box_beforenm(iife_result_78, iife_result_79)
		return Class_ParagonIE_Sodium_File.secretbox_encrypt(var_ifp_mutated.clone(),
			var_ofp_mutated.clone(), var_mlen.clone(), var_nonce_mutated.clone(), iife_result_80)
	}
	mut iife_temp_81 := Class_ParagonIE_Sodium_Crypto{}
	mut iife_result_81 := iife_temp_81.box_secretkey(var_boxKeypair.clone())
	mut iife_temp_82 := Class_ParagonIE_Sodium_Crypto{}
	mut iife_result_82 := iife_temp_82.box_publickey(var_boxKeypair.clone())
	mut iife_temp_83 := Class_ParagonIE_Sodium_Crypto{}
	mut iife_result_83 := iife_temp_83.box_beforenm(iife_result_81, iife_result_82)
	return Class_ParagonIE_Sodium_File.secretbox_encrypt(var_ifp_mutated.clone(),
		var_ofp_mutated.clone(), var_mlen.clone(), var_nonce_mutated.clone(), iife_result_83)
}

fn Class_ParagonIE_Sodium_File.box_decrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_boxKeypair rt.PhpVal) rt.PhpVal {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
		mut iife_temp_84 := Class_ParagonIE_Sodium_Crypto32{}
		mut iife_result_84 := iife_temp_84.box_secretkey(var_boxKeypair.clone())
		mut iife_temp_85 := Class_ParagonIE_Sodium_Crypto32{}
		mut iife_result_85 := iife_temp_85.box_publickey(var_boxKeypair.clone())
		mut iife_temp_86 := Class_ParagonIE_Sodium_Crypto32{}
		mut iife_result_86 := iife_temp_86.box_beforenm(iife_result_84, iife_result_85)
		return Class_ParagonIE_Sodium_File.secretbox_decrypt(var_ifp_mutated.clone(),
			var_ofp_mutated.clone(), var_mlen.clone(), var_nonce_mutated.clone(), iife_result_86)
	}
	mut iife_temp_87 := Class_ParagonIE_Sodium_Crypto{}
	mut iife_result_87 := iife_temp_87.box_secretkey(var_boxKeypair.clone())
	mut iife_temp_88 := Class_ParagonIE_Sodium_Crypto{}
	mut iife_result_88 := iife_temp_88.box_publickey(var_boxKeypair.clone())
	mut iife_temp_89 := Class_ParagonIE_Sodium_Crypto{}
	mut iife_result_89 := iife_temp_89.box_beforenm(iife_result_87, iife_result_88)
	return Class_ParagonIE_Sodium_File.secretbox_decrypt(var_ifp_mutated.clone(),
		var_ofp_mutated.clone(), var_mlen.clone(), var_nonce_mutated.clone(), iife_result_89)
}

fn Class_ParagonIE_Sodium_File.secretbox_encrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
		return (Class_ParagonIE_Sodium_File.secretbox_encrypt_core32(var_ifp_mutated.clone(),
			var_ofp_mutated.clone(), var_mlen.clone(), var_nonce_mutated.clone(),
			var_key_mutated.clone())).to_bool()
	}
	mut var_plaintext := rt.call_function('fread', [var_ifp_mutated.clone(),
		rt.new_int(32)])
	if !(var_plaintext.clone().is_string()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	mut var_first32 := Class_ParagonIE_Sodium_File.ftell(var_ifp_mutated.clone())
	mut iife_temp_90 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_90 := iife_temp_90.hsalsa20(var_nonce_mutated.clone(), var_key_mutated.clone())
	mut var_subkey := iife_result_90
	mut iife_temp_91 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_91 := iife_temp_91.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut var_realNonce := iife_result_91
	mut var_block0 := rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(32)])
	mut var_mlen0 := var_mlen
	if rt.is_true(rt.greater(var_mlen0, rt.sub(rt.new_int(64),
		Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_zerobytes())))
	{
		var_mlen0 = rt.sub(rt.new_int(64),
			Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_zerobytes())
	}
	mut iife_temp_92 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_92 := iife_temp_92.substr(var_plaintext.clone(), rt.new_int(0),
		var_mlen0.clone())
	var_block0 = rt.concat(var_block0, iife_result_92)
	mut iife_temp_93 := Class_ParagonIE_Sodium_Core_Salsa20{}
	mut iife_result_93 := iife_temp_93.salsa20_xor(var_block0.clone(), var_realNonce.clone(),
		var_subkey.clone())
	var_block0 = iife_result_93
	mut iife_temp_94 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_94 := iife_temp_94.substr(var_block0.clone(), rt.new_int(0),
		Class_ParagonIE_Sodium_Crypto.onetimeauth_poly1305_keybytes())
	mut var_state := create_paragonie_sodium_core_poly1305_state(iife_result_94)
	mut var_start := Class_ParagonIE_Sodium_File.ftell(var_ofp_mutated.clone())
	rt.call_function('fwrite', [var_ofp_mutated.clone(),
		rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(16)])])
	mut iife_temp_95 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_95 := iife_temp_95.substr(var_block0.clone(),
		Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_zerobytes())
	mut var_cBlock := iife_result_95
	rt.call_method(var_state, 'update', [var_cBlock.clone()])
	rt.call_function('fwrite', [var_ofp_mutated.clone(), var_cBlock.clone()])
	var_mlen = rt.sub(var_mlen, rt.new_int(32))
	mut var_iter := rt.new_int(1)
	mut var_incr := rt.new_int(Class_ParagonIE_Sodium_File.buffer_size() >> 6)
	rt.call_function('fseek', [var_ifp_mutated.clone(), var_first32.clone(),
		rt.get_constant('SEEK_SET')])
	for rt.is_true(rt.greater(var_mlen, rt.new_int(0))) {
		mut var_blockSize := if rt.is_true(rt.greater(var_mlen,
			Class_ParagonIE_Sodium_File.buffer_size()))
		{
			Class_ParagonIE_Sodium_File.buffer_size()
		} else {
			var_mlen
		}
		var_plaintext = rt.call_function('fread', [var_ifp_mutated.clone(),
			var_blockSize.clone()])
		if !(var_plaintext.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Could not read input file'))))
		}
		mut iife_temp_96 := Class_ParagonIE_Sodium_Core_Salsa20{}
		mut iife_result_96 := iife_temp_96.salsa20_xor_ic(var_plaintext.clone(),
			var_realNonce.clone(), var_iter.clone(), var_subkey.clone())
		var_cBlock = iife_result_96
		rt.call_function('fwrite', [var_ofp_mutated.clone(), var_cBlock.clone(),
			var_blockSize.clone()])
		rt.call_method(var_state, 'update', [var_cBlock.clone()])
		var_mlen = rt.sub(var_mlen, var_blockSize)
		var_iter = rt.add(var_iter, var_incr)
	}
	mut iife_temp_97 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_97 := iife_temp_97.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	mut iife_temp_98 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_98 := iife_temp_98.memzero(var_subkey.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_6
		}
	}
	unsafe {
		goto end_label_6
	}
	catch_label_6:
	mut var_e_6 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_6, 'SodiumException') {
		mut var_ex := var_e_6.clone()
		var_block0 = rt.new_null()
		var_subkey = rt.new_null()
		unsafe {
			goto end_label_6
		}
	} else {
		rt.throw_exception(var_e_6)
		unsafe {
			goto end_label_6
		}
	}

	end_label_6:
	mut var_end := Class_ParagonIE_Sodium_File.ftell(var_ofp_mutated.clone())
	rt.call_function('fseek', [var_ofp_mutated.clone(), var_start.clone(),
		rt.get_constant('SEEK_SET')])
	rt.call_function('fwrite', [var_ofp_mutated.clone(),
		rt.call_method(var_state, 'finish', []rt.PhpVal{}),
		Class_ParagonIE_Sodium_Compat.crypto_secretbox_macbytes()])
	rt.call_function('fseek', [var_ofp_mutated.clone(), var_end.clone(),
		rt.get_constant('SEEK_SET')])
	var_state = rt.new_null()
	return true
}

fn Class_ParagonIE_Sodium_File.secretbox_decrypt(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
	if rt.is_true(rt.identical(rt.get_constant('PHP_INT_SIZE'), rt.new_int(4))) {
		return (Class_ParagonIE_Sodium_File.secretbox_decrypt_core32(var_ifp_mutated.clone(),
			var_ofp_mutated.clone(), var_mlen.clone(), var_nonce_mutated.clone(),
			var_key_mutated.clone())).to_bool()
	}
	mut var_tag := rt.call_function('fread', [var_ifp_mutated.clone(),
		rt.new_int(16)])
	if !(var_tag.clone().is_string()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	mut iife_temp_99 := Class_ParagonIE_Sodium_Core_HSalsa20{}
	mut iife_result_99 := iife_temp_99.hsalsa20(var_nonce_mutated.clone(), var_key_mutated.clone())
	mut var_subkey := iife_result_99
	mut iife_temp_100 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_100 := iife_temp_100.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut var_realNonce := iife_result_100
	mut iife_temp_101 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_101 := iife_temp_101.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut iife_temp_102 := Class_ParagonIE_Sodium_Core_Salsa20{}
	mut iife_result_102 := iife_temp_102.salsa20(rt.new_int(64), iife_result_101,
		var_subkey.clone())
	mut var_block0 := iife_result_102
	mut iife_temp_103 := Class_ParagonIE_Sodium_File{}
	mut iife_result_103 := iife_temp_103.substr(var_block0.clone(), rt.new_int(0), rt.new_int(32))
	mut var_state := create_paragonie_sodium_core_poly1305_state(iife_result_103)
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_File.onetimeauth_verify(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Poly1305_State](var_state),
		var_ifp_mutated.str(), var_tag.to_i64(), var_mlen.clone())))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	mut var_first32 := rt.call_function('fread', [var_ifp_mutated.clone(),
		rt.new_int(32)])
	if !(var_first32.clone().is_string()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	mut iife_temp_104 := Class_ParagonIE_Sodium_File{}
	mut iife_result_104 := iife_temp_104.strlen(var_first32.clone())
	mut var_first32len := iife_result_104
	mut iife_temp_105 := Class_ParagonIE_Sodium_File{}
	mut iife_result_105 := iife_temp_105.substr(var_block0.clone(), rt.new_int(32),
		var_first32len.clone())
	mut iife_temp_106 := Class_ParagonIE_Sodium_File{}
	mut iife_result_106 := iife_temp_106.substr(var_first32.clone(), rt.new_int(0),
		var_first32len.clone())
	mut iife_temp_107 := Class_ParagonIE_Sodium_File{}
	mut iife_result_107 := iife_temp_107.xorstrings(iife_result_105, iife_result_106)
	rt.call_function('fwrite', [var_ofp_mutated.clone(), iife_result_107])
	var_mlen = rt.sub(var_mlen, rt.new_int(32))
	mut var_iter := rt.new_int(1)
	mut var_incr := rt.new_int(Class_ParagonIE_Sodium_File.buffer_size() >> 6)
	for rt.is_true(rt.greater(var_mlen, rt.new_int(0))) {
		mut var_blockSize := if rt.is_true(rt.greater(var_mlen,
			Class_ParagonIE_Sodium_File.buffer_size()))
		{
			Class_ParagonIE_Sodium_File.buffer_size()
		} else {
			var_mlen
		}
		mut var_ciphertext := rt.call_function('fread', [var_ifp_mutated.clone(),
			var_blockSize.clone()])
		if !(var_ciphertext.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Could not read input file'))))
		}
		mut iife_temp_108 := Class_ParagonIE_Sodium_Core_Salsa20{}
		mut iife_result_108 := iife_temp_108.salsa20_xor_ic(var_ciphertext.clone(),
			var_realNonce.clone(), var_iter.clone(), var_subkey.clone())
		mut var_pBlock := iife_result_108
		rt.call_function('fwrite', [var_ofp_mutated.clone(), var_pBlock.clone(),
			var_blockSize.clone()])
		var_mlen = rt.sub(var_mlen, var_blockSize)
		var_iter = rt.add(var_iter, var_incr)
	}
	return true
}

fn Class_ParagonIE_Sodium_File.onetimeauth_verify(mut var_state Class_ParagonIE_Sodium_Core_Poly1305_State, var_ifp rt.PhpVal, tag string, mlen i64) rt.PhpVal {
	mut var_state_mutated := var_state
	mut var_ifp_mutated := var_ifp
	mut tag_mutated := tag
	mut var_pos := Class_ParagonIE_Sodium_File.ftell(var_ifp_mutated.clone())
	mut var_iter := rt.new_int(1)
	mut var_incr := rt.new_int(Class_ParagonIE_Sodium_File.buffer_size() >> 6)
	for mlen > 0 {
		mut var_blockSize := rt.new_int(if mlen > Class_ParagonIE_Sodium_File.buffer_size() {
			Class_ParagonIE_Sodium_File.buffer_size()
		} else {
			mlen
		})
		mut var_ciphertext := rt.call_function('fread', [var_ifp_mutated.clone(),
			var_blockSize.clone()])
		if !(var_ciphertext.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Could not read input file'))))
		}
		rt.call_method(var_state_mutated, 'update', [var_ciphertext.clone()])
		mlen = mlen - var_blockSize.to_i64()
		var_iter = rt.add(var_iter, var_incr)
	}
	mut iife_temp_109 := Class_ParagonIE_Sodium_Core_Util{}
	mut iife_result_109 := iife_temp_109.verify_16(rt.new_string(tag_mutated), rt.call_method(var_state_mutated,
		'finish', []rt.PhpVal{}))
	mut var_res := iife_result_109
	rt.call_function('fseek', [var_ifp_mutated.clone(), var_pos.clone(),
		rt.get_constant('SEEK_SET')])
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.updatehashwithfile(var_hash rt.PhpVal, var_fp rt.PhpVal, size i64) rt.PhpVal {
	mut var_fp_mutated := var_fp
	mut size_mutated := size
	if rt.is_true(rt.less(rt.get_constant('PHP_VERSION_ID'), rt.new_int(70200))) {
		if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
			var_hash.clone(),
		])))))
		{
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 1 must be a resource, ' +
				(rt.call_function('gettype', [var_hash.clone()])).str() + ' given.')))
		}
	} else {
		if !(var_hash.clone().is_object()) {
			rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
				'Argument 1 must be an object (PHP 7.2+), ' + (rt.call_function('gettype', [var_hash.clone()])).str() +
				' given.')))
		}
	}
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_fp_mutated.clone()])))))
	{
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 2 must be a resource, ' +
			(rt.call_function('gettype', [var_fp_mutated.clone()])).str() + ' given.')))
	}
	if !(rt.new_int(size_mutated).clone().is_long()) {
		rt.throw_exception(rt.new_object('TypeError', []string{}, create_typeerror(
			'Argument 3 must be an integer, ' +
			(rt.call_function('gettype', [rt.new_int(size_mutated).clone()])).str() + ' given.')))
	}
	mut var_originalPosition := Class_ParagonIE_Sodium_File.ftell(var_fp_mutated.clone())
	rt.call_function('fseek', [var_fp_mutated.clone(), rt.new_int(0),
		rt.get_constant('SEEK_SET')])
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(size_mutated)))) { break
		 }
		mut var_message := rt.call_function('fread', [var_fp_mutated.clone(), if rt.is_true(rt.greater(rt.sub(rt.new_int(size_mutated),
			var_i), Class_ParagonIE_Sodium_File.buffer_size()))
		{
			rt.sub(rt.new_int(size_mutated), var_i)
		} else {
			Class_ParagonIE_Sodium_File.buffer_size()
		}])
		if !(var_message.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Unexpected error reading from file.'))))
		}
		mut iife_temp_110 := Class_ParagonIE_Sodium_File{}
		mut iife_result_110 := iife_temp_110.hash_update(var_hash.clone(), var_message.clone())
		var_i = rt.add(var_i, Class_ParagonIE_Sodium_File.buffer_size())
	}
	rt.call_function('fseek', [var_fp_mutated.clone(), var_originalPosition.clone(),
		rt.get_constant('SEEK_SET')])
	return var_hash.clone()
}

fn Class_ParagonIE_Sodium_File.sign_core32(var_filePath rt.PhpVal, var_secretKey rt.PhpVal) rt.PhpVal {
	mut var_size := rt.call_function('filesize', [var_filePath.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_fp := rt.call_function('fopen', [var_filePath.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_fp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut iife_temp_111 := Class_ParagonIE_Sodium_File{}
	mut iife_result_111 := iife_temp_111.substr(var_secretKey.clone(), rt.new_int(0),
		rt.new_int(32))
	mut var_az := rt.call_function('hash',
		[rt.new_string('sha512'), iife_result_111, rt.new_bool(true)])
	mut iife_temp_112 := Class_ParagonIE_Sodium_File{}
	mut iife_result_112 := iife_temp_112.chrtoint(var_az.array_get(rt.new_int(0)))
	mut iife_temp_113 := Class_ParagonIE_Sodium_File{}
	mut iife_result_113 := iife_temp_113.inttochr(rt.new_int(rt.bitwise_and(iife_result_112,
		rt.new_int(248))))
	var_az.array_set(0, iife_result_113)
	mut iife_temp_114 := Class_ParagonIE_Sodium_File{}
	mut iife_result_114 := iife_temp_114.chrtoint(var_az.array_get(rt.new_int(31)))
	mut iife_temp_115 := Class_ParagonIE_Sodium_File{}
	mut iife_result_115 := iife_temp_115.inttochr(rt.new_int(rt.bitwise_and(iife_result_114,
		rt.new_int(63)) | 64))
	var_az.array_set(31, iife_result_115)
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_116 := Class_ParagonIE_Sodium_File{}
	mut iife_result_116 := iife_temp_116.substr(var_az.clone(), rt.new_int(32), rt.new_int(32))
	mut iife_temp_117 := Class_ParagonIE_Sodium_File{}
	mut iife_result_117 := iife_temp_117.hash_update(var_hs.clone(), iife_result_116)
	var_hs = Class_ParagonIE_Sodium_File.updatehashwithfile(var_hs.to_i64(), var_fp.clone(),
		var_size.clone())
	mut var_nonceHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_118 := Class_ParagonIE_Sodium_File{}
	mut iife_result_118 := iife_temp_118.substr(var_secretKey.clone(), rt.new_int(32),
		rt.new_int(32))
	mut var_pk := iife_result_118
	mut iife_temp_119 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_119 := iife_temp_119.sc_reduce(var_nonceHash.clone())
	mut iife_temp_120 := Class_ParagonIE_Sodium_File{}
	mut iife_result_120 := iife_temp_120.substr(var_nonceHash.clone(), rt.new_int(32))
	mut var_nonce := rt.new_string(iife_result_119.str() + iife_result_120.str())
	mut iife_temp_121 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_121 := iife_temp_121.ge_scalarmult_base(var_nonce.clone())
	mut iife_temp_122 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_122 := iife_temp_122.ge_p3_tobytes(iife_result_121)
	mut var_sig := iife_result_122
	var_hs = rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_123 := Class_ParagonIE_Sodium_File{}
	mut iife_result_123 := iife_temp_123.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_124 := Class_ParagonIE_Sodium_File{}
	mut iife_result_124 := iife_temp_124.hash_update(var_hs.clone(), iife_result_123)
	mut iife_temp_125 := Class_ParagonIE_Sodium_File{}
	mut iife_result_125 := iife_temp_125.substr(var_pk.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_126 := Class_ParagonIE_Sodium_File{}
	mut iife_result_126 := iife_temp_126.hash_update(var_hs.clone(), iife_result_125)
	var_hs = Class_ParagonIE_Sodium_File.updatehashwithfile(var_hs.to_i64(), var_fp.clone(),
		var_size.clone())
	mut var_hramHash := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_127 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_127 := iife_temp_127.sc_reduce(var_hramHash.clone())
	mut var_hram := iife_result_127
	mut iife_temp_128 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_128 := iife_temp_128.sc_muladd(var_hram.clone(), var_az.clone(),
		var_nonce.clone())
	mut var_sigAfter := iife_result_128
	mut iife_temp_129 := Class_ParagonIE_Sodium_File{}
	mut iife_result_129 := iife_temp_129.substr(var_sig.clone(), rt.new_int(0), rt.new_int(32))
	mut iife_temp_130 := Class_ParagonIE_Sodium_File{}
	mut iife_result_130 := iife_temp_130.substr(var_sigAfter.clone(), rt.new_int(0), rt.new_int(32))
	var_sig = rt.new_string(iife_result_129.str() + iife_result_130.str())
	mut iife_temp_131 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_131 := iife_temp_131.memzero(var_az.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_7
		}
	}
	unsafe {
		goto end_label_7
	}
	catch_label_7:
	mut var_e_7 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_7, 'SodiumException') {
		mut var_ex := var_e_7.clone()
		var_az = rt.new_null()
		unsafe {
			goto end_label_7
		}
	} else {
		rt.throw_exception(var_e_7)
		unsafe {
			goto end_label_7
		}
	}

	end_label_7:
	rt.call_function('fclose', [var_fp.clone()])
	return var_sig.clone()
}

fn Class_ParagonIE_Sodium_File.verify_core32(var_sig rt.PhpVal, var_filePath rt.PhpVal, var_publicKey rt.PhpVal) rt.PhpVal {
	mut var_sig_mutated := var_sig
	mut var_publicKey_mutated := var_publicKey
	mut iife_temp_132 := Class_ParagonIE_Sodium_File{}
	mut iife_result_132 := iife_temp_132.substr(var_sig_mutated.clone(), rt.new_int(32),
		rt.new_int(32))
	mut iife_temp_133 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_133 := iife_temp_133.check_s_lt_l(iife_result_132)
	if rt.is_true(iife_result_133) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('S < L - Invalid signature'))))
	}
	mut iife_temp_134 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_134 := iife_temp_134.small_order(var_sig_mutated.clone())
	if rt.is_true(iife_result_134) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Signature is on too small of an order'))))
	}
	mut iife_temp_135 := Class_ParagonIE_Sodium_File{}
	mut iife_result_135 := iife_temp_135.chrtoint(var_sig_mutated.array_get(rt.new_int(63)))
	if rt.is_true(rt.new_bool(rt.bitwise_and(iife_result_135, rt.new_int(224)) != 0)) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid signature'))))
	}
	mut var_d := rt.new_int(0)
	mut var_i := rt.new_int(0)
	for {
		if !(rt.is_true(rt.less(var_i, rt.new_int(32)))) { break
		 }
		rt.new_null()
		rt.pre_inc(var_i)
	}
	if rt.is_true(rt.identical(var_d, rt.new_int(0))) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('All zero public key'))))
	}
	mut var_size := rt.call_function('filesize', [var_filePath.clone()])
	if !(var_size.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not obtain the file size'))))
	}
	mut var_fp := rt.call_function('fopen', [var_filePath.clone(),
		rt.new_string('rb')])
	if rt.is_true(rt.new_bool(!(rt.is_true(rt.call_function('is_resource', [
		var_fp.clone()])))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not open input file for reading'))))
	}
	mut var_orig := rt.get_static_prop('ParagonIE_Sodium_Compat', 'fastMult')
	rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', rt.new_bool(true))
	mut iife_temp_136 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_136 := iife_temp_136.ge_frombytes_negate_vartime(var_publicKey_mutated.clone())
	mut var_A := iife_result_136
	mut var_hs := rt.call_function('hash_init', [rt.new_string('sha512')])
	mut iife_temp_137 := Class_ParagonIE_Sodium_File{}
	mut iife_result_137 := iife_temp_137.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_138 := Class_ParagonIE_Sodium_File{}
	mut iife_result_138 := iife_temp_138.hash_update(var_hs.clone(), iife_result_137)
	mut iife_temp_139 := Class_ParagonIE_Sodium_File{}
	mut iife_result_139 := iife_temp_139.substr(var_publicKey_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_140 := Class_ParagonIE_Sodium_File{}
	mut iife_result_140 := iife_temp_140.hash_update(var_hs.clone(), iife_result_139)
	var_hs = Class_ParagonIE_Sodium_File.updatehashwithfile(var_hs.to_i64(), var_fp.clone(),
		var_size.clone())
	mut var_hDigest := rt.call_function('hash_final', [var_hs.clone(),
		rt.new_bool(true)])
	mut iife_temp_141 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_141 := iife_temp_141.sc_reduce(var_hDigest.clone())
	mut iife_temp_142 := Class_ParagonIE_Sodium_File{}
	mut iife_result_142 := iife_temp_142.substr(var_hDigest.clone(), rt.new_int(32))
	mut var_h := rt.new_string(iife_result_141.str() + iife_result_142.str())
	mut iife_temp_143 := Class_ParagonIE_Sodium_File{}
	mut iife_result_143 := iife_temp_143.substr(var_sig_mutated.clone(), rt.new_int(32))
	mut iife_temp_144 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_144 := iife_temp_144.ge_double_scalarmult_vartime(var_h.clone(), var_A.clone(),
		iife_result_143)
	mut var_R := iife_result_144
	mut iife_temp_145 := Class_ParagonIE_Sodium_Core32_Ed25519{}
	mut iife_result_145 := iife_temp_145.ge_tobytes(var_R.clone())
	mut var_rcheck := iife_result_145
	rt.call_function('fclose', [var_fp.clone()])
	rt.set_static_prop('ParagonIE_Sodium_Compat', 'fastMult', var_orig.clone())
	mut iife_temp_146 := Class_ParagonIE_Sodium_File{}
	mut iife_result_146 := iife_temp_146.substr(var_sig_mutated.clone(), rt.new_int(0),
		rt.new_int(32))
	mut iife_temp_147 := Class_ParagonIE_Sodium_File{}
	mut iife_result_147 := iife_temp_147.verify_32(var_rcheck.clone(), iife_result_146)
	return iife_result_147
}

fn Class_ParagonIE_Sodium_File.secretbox_encrypt_core32(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
	mut var_plaintext := rt.call_function('fread', [var_ifp_mutated.clone(),
		rt.new_int(32)])
	if !(var_plaintext.clone().is_string()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	mut var_first32 := Class_ParagonIE_Sodium_File.ftell(var_ifp_mutated.clone())
	mut iife_temp_148 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_148 := iife_temp_148.hsalsa20(var_nonce_mutated.clone(),
		var_key_mutated.clone())
	mut var_subkey := iife_result_148
	mut iife_temp_149 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_149 := iife_temp_149.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut var_realNonce := iife_result_149
	mut var_block0 := rt.call_function('str_repeat', [rt.new_string(''),
		rt.new_int(32)])
	mut var_mlen0 := var_mlen
	if rt.is_true(rt.greater(var_mlen0, rt.sub(rt.new_int(64),
		Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_zerobytes())))
	{
		var_mlen0 = rt.sub(rt.new_int(64),
			Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_zerobytes())
	}
	mut iife_temp_150 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_150 := iife_temp_150.substr(var_plaintext.clone(), rt.new_int(0),
		var_mlen0.clone())
	var_block0 = rt.concat(var_block0, iife_result_150)
	mut iife_temp_151 := Class_ParagonIE_Sodium_Core32_Salsa20{}
	mut iife_result_151 := iife_temp_151.salsa20_xor(var_block0.clone(), var_realNonce.clone(),
		var_subkey.clone())
	var_block0 = iife_result_151
	mut iife_temp_152 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_152 := iife_temp_152.substr(var_block0.clone(), rt.new_int(0),
		Class_ParagonIE_Sodium_Crypto.onetimeauth_poly1305_keybytes())
	mut var_state := create_paragonie_sodium_core32_poly1305_state(iife_result_152)
	mut var_start := Class_ParagonIE_Sodium_File.ftell(var_ofp_mutated.clone())
	rt.call_function('fwrite', [var_ofp_mutated.clone(),
		rt.call_function('str_repeat', [rt.new_string(''), rt.new_int(16)])])
	mut iife_temp_153 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_153 := iife_temp_153.substr(var_block0.clone(),
		Class_ParagonIE_Sodium_Crypto.secretbox_xsalsa20poly1305_zerobytes())
	mut var_cBlock := iife_result_153
	rt.call_method(var_state, 'update', [var_cBlock.clone()])
	rt.call_function('fwrite', [var_ofp_mutated.clone(), var_cBlock.clone()])
	var_mlen = rt.sub(var_mlen, rt.new_int(32))
	mut var_iter := rt.new_int(1)
	mut var_incr := rt.new_int(Class_ParagonIE_Sodium_File.buffer_size() >> 6)
	rt.call_function('fseek', [var_ifp_mutated.clone(), var_first32.clone(),
		rt.get_constant('SEEK_SET')])
	for rt.is_true(rt.greater(var_mlen, rt.new_int(0))) {
		mut var_blockSize := if rt.is_true(rt.greater(var_mlen,
			Class_ParagonIE_Sodium_File.buffer_size()))
		{
			Class_ParagonIE_Sodium_File.buffer_size()
		} else {
			var_mlen
		}
		var_plaintext = rt.call_function('fread', [var_ifp_mutated.clone(),
			var_blockSize.clone()])
		if !(var_plaintext.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Could not read input file'))))
		}
		mut iife_temp_154 := Class_ParagonIE_Sodium_Core32_Salsa20{}
		mut iife_result_154 := iife_temp_154.salsa20_xor_ic(var_plaintext.clone(),
			var_realNonce.clone(), var_iter.clone(), var_subkey.clone())
		var_cBlock = iife_result_154
		rt.call_function('fwrite', [var_ofp_mutated.clone(), var_cBlock.clone(),
			var_blockSize.clone()])
		rt.call_method(var_state, 'update', [var_cBlock.clone()])
		var_mlen = rt.sub(var_mlen, var_blockSize)
		var_iter = rt.add(var_iter, var_incr)
	}
	mut iife_temp_155 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_155 := iife_temp_155.memzero(var_block0.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	mut iife_temp_156 := Class_ParagonIE_Sodium_Compat{}
	mut iife_result_156 := iife_temp_156.memzero(var_subkey.clone())
	if rt.has_exception() {
		unsafe {
			goto catch_label_8
		}
	}
	unsafe {
		goto end_label_8
	}
	catch_label_8:
	mut var_e_8 := rt.get_and_clear_exception()
	if rt.instance_of(var_e_8, 'SodiumException') {
		mut var_ex := var_e_8.clone()
		var_block0 = rt.new_null()
		var_subkey = rt.new_null()
		unsafe {
			goto end_label_8
		}
	} else {
		rt.throw_exception(var_e_8)
		unsafe {
			goto end_label_8
		}
	}

	end_label_8:
	mut var_end := Class_ParagonIE_Sodium_File.ftell(var_ofp_mutated.clone())
	rt.call_function('fseek', [var_ofp_mutated.clone(), var_start.clone(),
		rt.get_constant('SEEK_SET')])
	rt.call_function('fwrite', [var_ofp_mutated.clone(),
		rt.call_method(var_state, 'finish', []rt.PhpVal{}),
		Class_ParagonIE_Sodium_Compat.crypto_secretbox_macbytes()])
	rt.call_function('fseek', [var_ofp_mutated.clone(), var_end.clone(),
		rt.get_constant('SEEK_SET')])
	var_state = rt.new_null()
	return true
}

fn Class_ParagonIE_Sodium_File.secretbox_decrypt_core32(var_ifp rt.PhpVal, var_ofp rt.PhpVal, var_mlen rt.PhpVal, var_nonce rt.PhpVal, var_key rt.PhpVal) bool {
	mut var_ifp_mutated := var_ifp
	mut var_ofp_mutated := var_ofp
	mut var_nonce_mutated := var_nonce
	mut var_key_mutated := var_key
	mut var_tag := rt.call_function('fread', [var_ifp_mutated.clone(),
		rt.new_int(16)])
	if !(var_tag.clone().is_string()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	mut iife_temp_157 := Class_ParagonIE_Sodium_Core32_HSalsa20{}
	mut iife_result_157 := iife_temp_157.hsalsa20(var_nonce_mutated.clone(),
		var_key_mutated.clone())
	mut var_subkey := iife_result_157
	mut iife_temp_158 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_158 := iife_temp_158.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut var_realNonce := iife_result_158
	mut iife_temp_159 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_159 := iife_temp_159.substr(var_nonce_mutated.clone(), rt.new_int(16),
		rt.new_int(8))
	mut iife_temp_160 := Class_ParagonIE_Sodium_Core32_Salsa20{}
	mut iife_result_160 := iife_temp_160.salsa20(rt.new_int(64), iife_result_159,
		var_subkey.clone())
	mut var_block0 := iife_result_160
	mut iife_temp_161 := Class_ParagonIE_Sodium_File{}
	mut iife_result_161 := iife_temp_161.substr(var_block0.clone(), rt.new_int(0), rt.new_int(32))
	mut var_state := create_paragonie_sodium_core32_poly1305_state(iife_result_161)
	if rt.is_true(rt.new_bool(!(rt.is_true(Class_ParagonIE_Sodium_File.onetimeauth_verify_core32(mut rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Poly1305_State](var_state),
		var_ifp_mutated.str(), var_tag.to_i64(), var_mlen.clone())))))
	{
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Invalid MAC'))))
	}
	mut var_first32 := rt.call_function('fread', [var_ifp_mutated.clone(),
		rt.new_int(32)])
	if !(var_first32.clone().is_string()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('Could not read input file'))))
	}
	mut iife_temp_162 := Class_ParagonIE_Sodium_File{}
	mut iife_result_162 := iife_temp_162.strlen(var_first32.clone())
	mut var_first32len := iife_result_162
	mut iife_temp_163 := Class_ParagonIE_Sodium_File{}
	mut iife_result_163 := iife_temp_163.substr(var_block0.clone(), rt.new_int(32),
		var_first32len.clone())
	mut iife_temp_164 := Class_ParagonIE_Sodium_File{}
	mut iife_result_164 := iife_temp_164.substr(var_first32.clone(), rt.new_int(0),
		var_first32len.clone())
	mut iife_temp_165 := Class_ParagonIE_Sodium_File{}
	mut iife_result_165 := iife_temp_165.xorstrings(iife_result_163, iife_result_164)
	rt.call_function('fwrite', [var_ofp_mutated.clone(), iife_result_165])
	var_mlen = rt.sub(var_mlen, rt.new_int(32))
	mut var_iter := rt.new_int(1)
	mut var_incr := rt.new_int(Class_ParagonIE_Sodium_File.buffer_size() >> 6)
	for rt.is_true(rt.greater(var_mlen, rt.new_int(0))) {
		mut var_blockSize := if rt.is_true(rt.greater(var_mlen,
			Class_ParagonIE_Sodium_File.buffer_size()))
		{
			Class_ParagonIE_Sodium_File.buffer_size()
		} else {
			var_mlen
		}
		mut var_ciphertext := rt.call_function('fread', [var_ifp_mutated.clone(),
			var_blockSize.clone()])
		if !(var_ciphertext.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Could not read input file'))))
		}
		mut iife_temp_166 := Class_ParagonIE_Sodium_Core32_Salsa20{}
		mut iife_result_166 := iife_temp_166.salsa20_xor_ic(var_ciphertext.clone(),
			var_realNonce.clone(), var_iter.clone(), var_subkey.clone())
		mut var_pBlock := iife_result_166
		rt.call_function('fwrite', [var_ofp_mutated.clone(), var_pBlock.clone(),
			var_blockSize.clone()])
		var_mlen = rt.sub(var_mlen, var_blockSize)
		var_iter = rt.add(var_iter, var_incr)
	}
	return true
}

fn Class_ParagonIE_Sodium_File.onetimeauth_verify_core32(mut var_state Class_ParagonIE_Sodium_Core32_Poly1305_State, var_ifp rt.PhpVal, tag string, mlen i64) rt.PhpVal {
	mut var_state_mutated := var_state
	mut var_ifp_mutated := var_ifp
	mut tag_mutated := tag
	mut var_pos := Class_ParagonIE_Sodium_File.ftell(var_ifp_mutated.clone())
	for mlen > 0 {
		mut var_blockSize := rt.new_int(if mlen > Class_ParagonIE_Sodium_File.buffer_size() {
			Class_ParagonIE_Sodium_File.buffer_size()
		} else {
			mlen
		})
		mut var_ciphertext := rt.call_function('fread', [var_ifp_mutated.clone(),
			var_blockSize.clone()])
		if !(var_ciphertext.clone().is_string()) {
			rt.throw_exception(rt.new_object('SodiumException', []string{},
				create_sodiumexception(rt.new_string('Could not read input file'))))
		}
		rt.call_method(var_state_mutated, 'update', [var_ciphertext.clone()])
		mlen = mlen - var_blockSize.to_i64()
	}
	mut iife_temp_167 := Class_ParagonIE_Sodium_Core32_Util{}
	mut iife_result_167 := iife_temp_167.verify_16(rt.new_string(tag_mutated), rt.call_method(var_state_mutated,
		'finish', []rt.PhpVal{}))
	mut var_res := iife_result_167
	rt.call_function('fseek', [var_ifp_mutated.clone(), var_pos.clone(),
		rt.get_constant('SEEK_SET')])
	return var_res.clone()
}

fn Class_ParagonIE_Sodium_File.ftell(var_resource rt.PhpVal) i64 {
	mut var_return := rt.call_function('ftell', [var_resource.clone()])
	if !(var_return.clone().is_long()) {
		rt.throw_exception(rt.new_object('SodiumException', []string{},
			create_sodiumexception(rt.new_string('ftell() returned false'))))
	}
	return rt.new_int(var_return.to_i64())
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

struct Class_ParagonIE_Sodium_Core_Ed25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Crypto32 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Crypto {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_HSalsa20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Salsa20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core_Poly1305_State {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Ed25519 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_HSalsa20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Util {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Salsa20 {
	rt.PhpObjectBase
}

struct Class_ParagonIE_Sodium_Core32_Poly1305_State {
	rt.PhpObjectBase
}

fn create_paragonie_sodium_file(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_File {
	mut obj := &Class_ParagonIE_Sodium_File{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Util {
	mut obj := &Class_ParagonIE_Sodium_Core_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_typeerror(_args ...rt.PhpVal) &Class_TypeError {
	mut obj := &Class_TypeError{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_sodiumexception(_args ...rt.PhpVal) &Class_SodiumException {
	mut obj := &Class_SodiumException{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_compat(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Compat {
	mut obj := &Class_ParagonIE_Sodium_Compat{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_ed25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core_Ed25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_crypto32(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Crypto32 {
	mut obj := &Class_ParagonIE_Sodium_Crypto32{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_crypto(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Crypto {
	mut obj := &Class_ParagonIE_Sodium_Crypto{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_hsalsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_salsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core_Salsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core_poly1305_state(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core_Poly1305_State{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_ed25519(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Ed25519 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Ed25519{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_hsalsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_HSalsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_HSalsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_util(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Util {
	mut obj := &Class_ParagonIE_Sodium_Core32_Util{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_salsa20(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Salsa20 {
	mut obj := &Class_ParagonIE_Sodium_Core32_Salsa20{
		PhpObjectBase: rt.PhpObjectBase{}
	}
	return obj
}

fn create_paragonie_sodium_core32_poly1305_state(_args ...rt.PhpVal) &Class_ParagonIE_Sodium_Core32_Poly1305_State {
	mut obj := &Class_ParagonIE_Sodium_Core32_Poly1305_State{
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
			return Class_ParagonIE_Sodium_File.box(dispatch_arg_0, dispatch_arg_1, dispatch_arg_2,
				dispatch_arg_3)
		}
		'box_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_open(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'box_seal' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_seal(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'box_seal_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_seal_open(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'generichash' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := (if args.len > 1 { args[1] } else { rt.new_null() }).str()
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.generichash(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'secretbox' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.secretbox(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
		}
		'secretbox_open' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.secretbox_open(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3)
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
			return Class_ParagonIE_Sodium_File.verify(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'box_encrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_encrypt(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'box_decrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return Class_ParagonIE_Sodium_File.box_decrypt(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2, dispatch_arg_3, dispatch_arg_4)
		}
		'secretbox_encrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_encrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'secretbox_decrypt' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_decrypt(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'onetimeauth_verify' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core_Poly1305_State](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.onetimeauth_verify(mut dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'updateHashWithFile' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.updatehashwithfile(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
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
			return Class_ParagonIE_Sodium_File.verify_core32(dispatch_arg_0, dispatch_arg_1,
				dispatch_arg_2)
		}
		'secretbox_encrypt_core32' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_encrypt_core32(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'secretbox_decrypt_core32' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := if args.len > 2 { args[2] } else { rt.new_null() }
			dispatch_arg_3 := if args.len > 3 { args[3] } else { rt.new_null() }
			dispatch_arg_4 := if args.len > 4 { args[4] } else { rt.new_null() }
			return rt.new_bool(Class_ParagonIE_Sodium_File.secretbox_decrypt_core32(dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3, dispatch_arg_4))
		}
		'onetimeauth_verify_core32' {
			mut dispatch_arg_0 := rt.cast_object_ptr[Class_ParagonIE_Sodium_Core32_Poly1305_State](if args.len > 0 {
				args[0]
			} else {
				rt.new_null()
			})
			dispatch_arg_1 := if args.len > 1 { args[1] } else { rt.new_null() }
			dispatch_arg_2 := (if args.len > 2 { args[2] } else { rt.new_null() }).str()
			dispatch_arg_3 := (if args.len > 3 { args[3] } else { rt.new_null() }).to_i64()
			return Class_ParagonIE_Sodium_File.onetimeauth_verify_core32(mut dispatch_arg_0,
				dispatch_arg_1, dispatch_arg_2, dispatch_arg_3)
		}
		'ftell' {
			dispatch_arg_0 := if args.len > 0 { args[0] } else { rt.new_null() }
			return rt.new_int(Class_ParagonIE_Sodium_File.ftell(dispatch_arg_0))
		}
		else {
			return none
		}
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

fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Ed25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Ed25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Crypto32) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Crypto32) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Crypto32) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Crypto) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Crypto) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Crypto) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Salsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Salsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Ed25519) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_HSalsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Util) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Util) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Salsa20) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_method(method_name string, args []rt.PhpVal) ?rt.PhpVal {
	return none
}

fn (this &Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_get_prop(prop_name string) ?rt.PhpVal {
	return this.PhpObjectBase.dispatch_get_prop(prop_name)
}

fn (mut this Class_ParagonIE_Sodium_Core32_Poly1305_State) dispatch_set_prop(prop_name string, val rt.PhpVal) bool {
	return this.PhpObjectBase.dispatch_set_prop(prop_name, val)
}

fn main() {
	defer {
		rt.shutdown()
	}

	if rt.is_true(rt.call_function('class_exists', [
		rt.new_string('ParagonIE_Sodium_File'),
		rt.new_bool(false),
	]))
	{
		return rt.new_null()
	}
}

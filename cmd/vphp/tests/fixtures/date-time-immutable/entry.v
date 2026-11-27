module main

import vphp

const ext_config = vphp.ExtensionConfig{ name: 'date_time_immutable_probe' }

@[vphp.PhpExportFunction(name: 'vphpDateImmutable')]
pub fn date_immutable(text string) !vphp.PhpDateTimeImmutable {
	return vphp.PhpDateTimeImmutable.parse(text)
}

@[vphp.PhpExportFunction(name: 'vphpDateMillis')]
pub fn date_millis(value vphp.PhpDateTimeImmutable) !string {
	return value.unix_milliseconds_string()
}

@[vphp.PhpExportFunction(name: 'vphpDateFormat')]
pub fn date_format(value vphp.PhpDateTimeImmutable, pattern string) !string {
	return value.format(pattern)
}

@[vphp.PhpExportFunction(name: 'vphpDateAdd')]
pub fn date_add(value vphp.PhpDateTimeImmutable, interval vphp.PhpDateInterval) !vphp.PhpDateTimeImmutable {
	return value.add(interval.borrowed_view())
}

@[vphp.PhpExportFunction(name: 'vphpDateInterval')]
pub fn date_interval(spec string) !vphp.PhpDateInterval {
	return vphp.PhpDateInterval.parse(spec)
}

@[vphp.PhpExportFunction(name: 'vphpDateIntervalIdentity')]
pub fn date_interval_identity(value vphp.PhpDateInterval) vphp.PhpDateInterval {
	return value
}

@[vphp.PhpExportFunction(name: 'vphpDateTimestampRequired')]
@[vphp.PhpArgOptional(v_name: 'value', optional: false)]
pub fn date_timestamp_required(value ?vphp.PhpDateTimeInterface) !vphp.PhpValue {
	if date := value {
		return vphp.PhpValue.int(date.unix_seconds()!)
	}
	return vphp.PhpValue.null()
}

@[vphp.PhpExportFunction(name: 'vphpDateTimestampDefault')]
@[vphp.PhpArgOptional(v_name: 'value', optional: false)]
@[vphp.PhpArgDefault(v_name: 'value', default_value: 'null')]
pub fn date_timestamp_default(value ?vphp.PhpDateTimeInterface) !vphp.PhpValue {
	return date_timestamp_required(value)
}

@[vphp.PhpExportFunction(name: 'vphpDateInterfaceIdentityClosure')]
pub fn date_interface_identity_closure() fn (vphp.PhpDateTimeInterface) vphp.PhpDateTimeInterface {
	return fn (date vphp.PhpDateTimeInterface) vphp.PhpDateTimeInterface {
		return date
	}
}

@[vphp.PhpExportFunction(name: 'vphpDateIdentityClosure')]
pub fn date_identity_closure() fn (vphp.PhpDateTimeImmutable) vphp.PhpDateTimeImmutable {
	return fn (date vphp.PhpDateTimeImmutable) vphp.PhpDateTimeImmutable {
		return date
	}
}

@[vphp.PhpExportFunction(name: 'vphpDateThroughCallback')]
pub fn date_through_callback(value vphp.PhpDateTimeImmutable, callback vphp.PhpCallable) !vphp.PhpDateTimeImmutable {
	result := callback.with_result[vphp.PhpDateTimeImmutable, vphp.ZVal](fn (response vphp.PhpDateTimeImmutable) vphp.ZVal {
		return response.to_value().to_request_scoped().to_zval()
	}, value)!
	return vphp.PhpDateTimeImmutable.must_from_zval(result)
}

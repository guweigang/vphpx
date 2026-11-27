module httpx

import vphp

@[vphp.PhpExternalInterface(name: 'Psr\\Http\\Message\\RequestInterface')]
pub interface PsrRequestContract {}

pub type PsrRequest = vphp.PhpInterface[PsrRequestContract]

@[vphp.PhpExternalInterface(name: 'Psr\\Http\\Message\\ServerRequestInterface')]
pub interface PsrServerRequestContract {}

pub type PsrServerRequest = vphp.PhpInterface[PsrServerRequestContract]

@[vphp.PhpExternalInterface(name: 'Psr\\Http\\Message\\ResponseInterface')]
pub interface PsrResponseContract {}

pub type PsrResponse = vphp.PhpInterface[PsrResponseContract]

@[vphp.PhpExternalInterface(name: 'Psr\\Http\\Message\\StreamInterface')]
pub interface PsrStreamContract {}

pub type PsrStream = vphp.PhpInterface[PsrStreamContract]

@[vphp.PhpExternalInterface(name: 'Psr\\Http\\Message\\UriInterface')]
pub interface PsrUriContract {}

pub type PsrUri = vphp.PhpInterface[PsrUriContract]

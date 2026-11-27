--TEST--
VSlim PSR-7 URI clones and serializes its V components without reparsing
--SKIPIF--
<?php if (!extension_loaded('vslim')) echo 'skip'; ?>
--FILE--
<?php
$uriClass = VSlim\Psr7\Uri::class;
$write = new ReflectionMethod($uriClass, '__serialize');
$read = new ReflectionMethod($uriClass, '__unserialize');
if ((string) $write->getReturnType() !== 'array' || (string) $read->getReturnType() !== 'void'
    || (string) $read->getParameters()[0]->getType() !== 'array') {
    throw new RuntimeException('The PHP serialization hooks lost their signatures');
}

class CopyableUriSubclass extends VSlim\Psr7\Uri
{
    public string $label = 'default';

    public function __serialize(): array
    {
        return parent::__serialize() + ['label' => $this->label];
    }

    public function __unserialize(array $data): void
    {
        $label = $data['label'];
        unset($data['label']);
        parent::__unserialize($data);
        $this->label = $label;
    }
}

$uri = new CopyableUriSubclass('https://name:secret@[::1]:443/b%20c?x=1#frag');
$uri->label = 'kept';
$uri->path = "raw\0path";
$snapshot = $uri->__serialize();
$clone = clone $uri;
[$decoded, $alias] = unserialize(serialize([$uri, $uri]));
if ($decoded !== $alias || $decoded === $uri || $decoded === $clone
    || $clone === $uri
    || $decoded::class !== CopyableUriSubclass::class || $clone::class !== CopyableUriSubclass::class
    || $decoded->__serialize() !== $snapshot || $clone->__serialize() !== $snapshot
    || $decoded->getHost() !== '[::1]' || $decoded->getUserInfo() !== 'name:secret'
    || $decoded->port !== 443 || $decoded->getPort() !== null
    || $decoded->getPath() !== "raw\0path" || $decoded->label !== 'kept') {
    throw new RuntimeException('The PHP copy lost URI state, subclass state or shared identity');
}

$decoded->path = '/changed';
if ($uri->__serialize() !== $snapshot || $clone->__serialize() !== $snapshot) {
    throw new RuntimeException('The restored URI shares mutable V state');
}
$clone->host = 'copy.example';
if ($uri->__serialize() !== $snapshot || $decoded->getHost() !== '[::1]') {
    throw new RuntimeException('The cloned URI shares mutable V state');
}
$probe = new VSlim\Dev\PhpSignatureProbe();
if (method_exists($probe, 'cloneWithProperties') !== (PHP_VERSION_ID >= 80500)) {
    throw new RuntimeException('Unexpected availability of the V clone-with bridge');
}
if (PHP_VERSION_ID >= 80500) {
    $properties = ['host' => 'updated.example', 'label' => 'updated'];
    $nativeClone = 'clone';
    $copies = [$nativeClone($uri, $properties), $probe->cloneWithProperties(properties: $properties, object: $uri)];
    if (PHP_VERSION_ID >= 80600) {
        $copyWith = eval('return $probe->cloneWithProperties(object: ?, properties: $properties);');
        $parameters = (new ReflectionFunction($copyWith))->getParameters();
        if (count($parameters) !== 1 || $parameters[0]->getName() !== 'object'
            || (string) $parameters[0]->getType() !== 'object') {
            throw new RuntimeException('The partial URI clone did not retain the object parameter');
        }
        $copies[] = $copyWith(object: $uri);
    }
    foreach ($copies as $updated) {
        if ($updated === $uri || $updated::class !== $uri::class || $updated->getHost() !== 'updated.example'
            || $updated->label !== 'updated' || $updated->getPath() !== "raw\0path"
            || $updated->__serialize() !== array_replace($snapshot, $properties) || $uri->__serialize() !== $snapshot) {
            throw new RuntimeException('Clone-with did not update the separate V and PHP property storage');
        }
    }
}
$relative = new VSlim\Psr7\Uri('/items?search=1');
if ((string) unserialize(serialize($relative)) !== '/items?search=1') {
    throw new RuntimeException('A relative URI changed during serialization');
}

$previous = $uri->__serialize();
foreach ([
    array_replace($snapshot, ['scheme' => 'http', 'port' => '443']),
    array_replace($snapshot, ['scheme' => 'http', 'host' => []]),
    array_diff_key($snapshot, ['query' => true]),
] as $malformed) {
    try {
        $uri->__unserialize($malformed);
        throw new RuntimeException('Accepted malformed URI state');
    } catch (UnexpectedValueException) {
        if ($uri->__serialize() !== $previous) {
            throw new RuntimeException('A failed restore partially mutated the URI');
        }
    }
}
$host = 'host-by-reference.example';
$byReference = $previous;
$byReference['host'] =& $host;
$uri->__unserialize($byReference);
$host = 'changed-after-restore.example';
if ($uri->getHost() !== 'host-by-reference.example') {
    throw new RuntimeException('The URI restore retained a reference to input state');
}

$uri->host = 'swap.example';
$uri->path = '/swap-path';
$hostAlias =& $uri->host;
$pathAlias =& $uri->path;
$aliasedState = $uri->__serialize();
$aliasedState['host'] =& $pathAlias;
$aliasedState['path'] =& $hostAlias;
$uri->__unserialize($aliasedState);
if ($uri->getHost() !== '/swap-path' || $uri->getPath() !== 'swap.example'
    || $hostAlias !== '/swap-path' || $pathAlias !== 'swap.example') {
    throw new RuntimeException('Restoring the URI from references lost its original components or bindings');
}

try {
    unserialize('O:' . strlen($uriClass) . ':"' . $uriClass . '":0:{}');
    throw new RuntimeException('PHP unserialize accepted a URI with missing state');
} catch (UnexpectedValueException) {
}

class UserUriProbe extends VSlim\Dev\SerializableUriProbe
{
    public string $beforeRestore;

    public function __unserialize(array $data): void
    {
        // Zend has allocated the object, but the parent hook has not run.
        $this->beforeRestore = $this->getHost();
        parent::__unserialize($data);
    }
}

$native = new UserUriProbe();
$native->host = 'native.example';
$native->path = "native\0path";
$native->label = 'saved';
$revived = unserialize(serialize($native));
if ($revived::class !== UserUriProbe::class || $revived->beforeRestore !== ''
    || $revived->getHost() !== 'native.example' || $revived->getPath() !== "native\0path"
    || $revived->label !== 'saved' || (new ReflectionObject($revived))->isCloneable()) {
    throw new RuntimeException('The exported URI descendant lost its V state or copy policy');
}
$revived->path = '/independent';
if ($native->getPath() !== "native\0path") {
    throw new RuntimeException('The URI descendant shared mutable state after serialization');
}
echo "ok\n";
?>
--EXPECT--
ok

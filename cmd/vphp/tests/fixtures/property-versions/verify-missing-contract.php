<?php
declare(strict_types=1);

if (isset($argv[2])) {
    require $argv[2];
}

switch ($argv[1]) {
    case 'interface':
        eval('class MissingVersionedProperty implements VphpInheritedVersionedContract {
            public bool $active = true;
            public int $phase = 85;
        }');
        break;
    case 'abstract':
        eval('class MissingVersionedProperty extends VphpVersionedAbstract {}');
        break;
    default:
        throw new InvalidArgumentException('Expected interface or abstract');
}
new MissingVersionedProperty();

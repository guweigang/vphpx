<?php
declare(strict_types=1);

if (isset($argv[2])) {
    require $argv[2];
}

switch ($argv[1]) {
    case 'interface':
        eval('class MissingVersionedMethod implements VphpInheritedVersionedMethods {
            public static function phase(): int { return 85; }
        }');
        break;
    case 'abstract':
        eval('class MissingVersionedMethod extends VphpVersionedMethodBase {}');
        break;
    default:
        throw new InvalidArgumentException('Expected interface or abstract');
}
new MissingVersionedMethod();

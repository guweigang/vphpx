<?php
declare(strict_types=1);

function privateScoreProbeMethods(): array
{
    return [
        'checkPrivateScope' => <<<'PHP'
public function checkPrivateScope(): void {
    $alias =& $this->score;
    $alias = 19;
    if ($this->score !== 19) {
        throw new RuntimeException("Reference write did not reach the property");
    }
    $this->score = 7;
    if ($alias !== 7) {
        throw new RuntimeException("Property write did not reach the reference");
    }
}
PHP,
        'bindPrivateScore' => 'public function bindPrivateScore(): void { $alias =& $this->score; }',
        'writePrivateScore' => 'public function writePrivateScore(): void { $this->score = 3; }',
        'sharePrivateScore' => 'public function sharePrivateScore(): array { return ["score" => &$this->score]; }',
        'scoreReference' => 'public function &scoreReference(): int { return $this->score; }',
    ];
}

function loadReferenceContractStub(string $path): void
{
    if (PHP_VERSION_ID < 80400) {
        require $path;
        return;
    }

    // Fill only the fixture method bodies, keeping the generated signatures,
    // class declarations, properties, and contracts intact.
    $source = file_get_contents($path);
    foreach (privateScoreProbeMethods() as $name => $method) {
        $signature = strstr($method, ' {', true);
        $source = str_replace("$signature {}", $method, $source, $count);
        if ($count !== 2) {
            throw new RuntimeException("Expected two generated stub signatures for $name, found $count");
        }
    }
    $probe = tempnam(sys_get_temp_dir(), 'vphp-contract-stub-');
    if ($probe === false) {
        throw new RuntimeException("Could not create the stub probe file");
    }
    try {
        if (file_put_contents($probe, $source) === false) {
            throw new RuntimeException("Could not write the stub probe file");
        }
        require $probe;
    } finally {
        unlink($probe);
    }
}

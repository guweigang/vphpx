<?php

declare(strict_types=1);

const VSLIM_PACKAGE_TYPES = ['binary', 'source'];
const VSLIM_ARCHIVE_FORMATS = ['zip'];

main($argv);

function main(array $argv): void
{
    $options = parse_options($argv);
    $repoRoot = realpath(__DIR__ . '/../../');
    if ($repoRoot === false) {
        fail('Unable to resolve repository root.');
    }

    $vslimRoot = $repoRoot . DIRECTORY_SEPARATOR . 'vslim';
    $distDir = normalize_path($options['dist-dir'] ?? ($vslimRoot . DIRECTORY_SEPARATOR . 'dist'));
    $packageType = $options['package-type'] ?? 'binary';
    $format = $options['format'] ?? 'zip';

    if (!in_array($packageType, VSLIM_PACKAGE_TYPES, true)) {
        fail('Unsupported --package-type. Expected one of: ' . implode(', ', VSLIM_PACKAGE_TYPES));
    }
    if (!in_array($format, VSLIM_ARCHIVE_FORMATS, true)) {
        fail('Unsupported --format. Expected one of: ' . implode(', ', VSLIM_ARCHIVE_FORMATS));
    }
    if (!class_exists('ZipArchive')) {
        fail('ZipArchive extension is required to build release archives.');
    }

    $version = trim((string) ($options['version'] ?? ''));
    if ($version === '') {
        $version = detect_version($repoRoot);
    }

    $platform = trim((string) ($options['platform'] ?? ''));
    if ($platform === '') {
        $platform = detect_platform();
    } else {
        $platform = normalize_slug($platform);
    }

    $archiveBase = 'vslim-' . normalize_slug($version) . '-' . $platform;
    if ($packageType === 'source') {
        $archiveBase .= '-source';
    }

    $stageDir = $distDir . DIRECTORY_SEPARATOR . $archiveBase;
    $archivePath = $distDir . DIRECTORY_SEPARATOR . $archiveBase . '.zip';
    rrmdir($stageDir);
    @unlink($archivePath);
    ensure_dir($stageDir);

    $extensionFile = null;
    if ($packageType === 'binary') {
        $extensionPath = trim((string) ($options['ext-path'] ?? ($vslimRoot . DIRECTORY_SEPARATOR . 'vslim.so')));
        if ($extensionPath === '') {
            fail('Missing --ext-path for binary package.');
        }
        $extensionPath = normalize_path($extensionPath);
        if (!is_file($extensionPath)) {
            fail('Extension binary not found: ' . $extensionPath);
        }
        $extensionFile = basename($extensionPath);
        ensure_dir($stageDir . DIRECTORY_SEPARATOR . 'extension');
        copy_file($extensionPath, $stageDir . DIRECTORY_SEPARATOR . 'extension' . DIRECTORY_SEPARATOR . $extensionFile);
    } else {
        stage_source_bundle($repoRoot, $stageDir);
    }

    stage_template_bundle($vslimRoot, $stageDir);
    stage_docs($repoRoot, $stageDir);
    file_put_contents(
        $stageDir . DIRECTORY_SEPARATOR . 'manifest.json',
        json_encode([
            'name' => 'vslim',
            'version' => $version,
            'platform' => $platform,
            'package_type' => $packageType,
            'archive' => basename($archivePath),
            'extension' => $extensionFile,
            'generated_at_utc' => gmdate(DATE_ATOM),
        ], JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES) . PHP_EOL
    );
    file_put_contents(
        $stageDir . DIRECTORY_SEPARATOR . 'README.md',
        build_release_readme($version, $platform, $packageType, $extensionFile)
    );

    create_zip_archive($stageDir, $archivePath);

    echo 'Created archive: ' . $archivePath . PHP_EOL;
}

function parse_options(array $argv): array
{
    $options = [];
    foreach (array_slice($argv, 1) as $arg) {
        if ($arg === '--help' || $arg === '-h') {
            echo <<<TXT
Usage:
  php vslim/scripts/package_release.php [options]

Options:
  --version=VALUE        Package version label.
  --platform=VALUE       Normalized platform label, for example linux-amd64.
  --package-type=VALUE   binary | source
  --ext-path=PATH        Path to compiled extension for binary packages.
  --format=VALUE         zip
  --dist-dir=PATH        Output directory for staged files and archives.

TXT;
            exit(0);
        }
        if (!str_starts_with($arg, '--')) {
            continue;
        }
        $parts = explode('=', substr($arg, 2), 2);
        $key = $parts[0];
        $value = $parts[1] ?? '1';
        $options[$key] = $value;
    }

    return $options;
}

function detect_version(string $repoRoot): string
{
    $cmd = 'git -C ' . escapeshellarg($repoRoot) . ' describe --tags --always --dirty';
    exec($cmd, $output, $exitCode);
    if ($exitCode !== 0 || empty($output)) {
        return 'dev';
    }

    return trim($output[0]) !== '' ? trim($output[0]) : 'dev';
}

function detect_platform(): string
{
    $os = strtolower(PHP_OS_FAMILY);
    $arch = strtolower(php_uname('m'));
    $os = match ($os) {
        'darwin' => 'macos',
        'bsd' => 'bsd',
        default => $os,
    };

    return normalize_slug($os . '-' . normalize_arch($arch));
}

function normalize_arch(string $arch): string
{
    return match (strtolower($arch)) {
        'x86_64', 'amd64', 'x64' => 'amd64',
        'aarch64', 'arm64' => 'arm64',
        default => normalize_slug($arch),
    };
}

function normalize_slug(string $value): string
{
    $value = strtolower(trim($value));
    $value = str_replace(['\\', '/', ' '], '-', $value);
    $value = preg_replace('/[^a-z0-9._-]+/', '-', $value) ?? $value;
    $value = preg_replace('/-+/', '-', $value) ?? $value;
    return trim($value, '-');
}

function normalize_path(string $path): string
{
    $normalized = str_replace(['/', '\\'], DIRECTORY_SEPARATOR, $path);
    if (preg_match('/^[A-Za-z]:[\\\\\\/]/', $normalized) === 1 || str_starts_with($normalized, DIRECTORY_SEPARATOR)) {
        return $normalized;
    }

    return getcwd() . DIRECTORY_SEPARATOR . $normalized;
}

function stage_template_bundle(string $vslimRoot, string $stageDir): void
{
    copy_tree($vslimRoot . DIRECTORY_SEPARATOR . 'templates' . DIRECTORY_SEPARATOR . 'app', $stageDir . DIRECTORY_SEPARATOR . 'template');
}

function stage_source_bundle(string $repoRoot, string $stageDir): void
{
    $files = [
        'vslim/build.v',
        'vslim/Makefile',
        'vslim/php_bridge.c',
        'vslim/php_bridge.h',
        'vphp/v_bridge.c',
        'vphp/v_bridge.h',
    ];
    foreach ($files as $relativePath) {
        copy_repo_file_if_present($repoRoot, $stageDir, $relativePath);
    }

    copy_repo_file_if_present($repoRoot, $stageDir, 'vslim/vslim_generated.c');

    copy_tree(
        $repoRoot . DIRECTORY_SEPARATOR . 'vphp' . DIRECTORY_SEPARATOR . 'bridge',
        $stageDir . DIRECTORY_SEPARATOR . 'source' . DIRECTORY_SEPARATOR . 'vphp' . DIRECTORY_SEPARATOR . 'bridge'
    );
}

function stage_docs(string $repoRoot, string $stageDir): void
{
    $docs = [
        'vslim/README.md' => 'docs/VSlim_README.md',
        'vslim/templates/app/README.md' => 'docs/TEMPLATE_README.md',
    ];
    foreach ($docs as $from => $to) {
        $src = $repoRoot . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $from);
        $dst = $stageDir . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $to);
        copy_file($src, $dst);
    }
}

function build_release_readme(string $version, string $platform, string $packageType, ?string $extensionFile): string
{
    $binarySection = $packageType === 'binary'
        ? <<<TXT
## Bundle contents

- `extension/{$extensionFile}`: prebuilt VSlim PHP extension for this platform.
- `template/`: starter app template that matches the current PSR-oriented project layout.
- `docs/`: VSlim framework and template references.

## Quick start

1. Copy `extension/{$extensionFile}` to a path your PHP runtime can load.
2. Validate the extension with:
   `php -d extension=/absolute/path/{$extensionFile} -m`
3. Copy `template/` into a new project directory and run `composer install`.
4. Start the HTTP entry with:
   `php -d extension=/absolute/path/{$extensionFile} -S 127.0.0.1:8080 public/index.php`

TXT
        : <<<TXT
## Bundle contents

- `template/`: starter app template that matches the current PSR-oriented project layout.
- `source/`: generated C bridge sources plus the current `vphp` bridge shim.
- `docs/`: VSlim framework and template references.

## Current status

This package contains a native Windows DLL built with the PHP 8.5 NTS x64 devel pack and the matching MSVC/NMake toolchain. The V side is used to emit bridge C sources; the final `php_vslim.dll` is compiled through the PHP Windows extension build flow.

TXT;

    return <<<MD
# VSlim Release Bundle

- Version: `{$version}`
- Platform: `{$platform}`
- Package type: `{$packageType}`

{$binarySection}
## Notes

- CI builds target PHP `8.5`.
- `template/` is the release-facing app skeleton; the repository source tree remains the canonical development layout.
- `docs/TEMPLATE_README.md` is the best entry point if you want the HTTP + CLI bootstrap flow first.
MD;
}

function create_zip_archive(string $sourceDir, string $archivePath): void
{
    ensure_dir(dirname($archivePath));
    $zip = new ZipArchive();
    $result = $zip->open($archivePath, ZipArchive::CREATE | ZipArchive::OVERWRITE);
    if ($result !== true) {
        fail('Unable to create zip archive: ' . $archivePath);
    }

    $rootName = basename($sourceDir);
    $iterator = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($sourceDir, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::SELF_FIRST
    );

    foreach ($iterator as $item) {
        $fullPath = $item->getPathname();
        $relativePath = $rootName . '/' . substr($fullPath, strlen($sourceDir) + 1);
        if ($item->isDir()) {
            $zip->addEmptyDir(str_replace('\\', '/', $relativePath));
            continue;
        }
        $zip->addFile($fullPath, str_replace('\\', '/', $relativePath));
    }

    $zip->close();
}

function copy_tree(string $from, string $to): void
{
    if (!is_dir($from)) {
        fail('Directory not found: ' . $from);
    }
    ensure_dir($to);
    $iterator = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($from, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::SELF_FIRST
    );
    foreach ($iterator as $item) {
        $target = $to . DIRECTORY_SEPARATOR . substr($item->getPathname(), strlen($from) + 1);
        if ($item->isDir()) {
            ensure_dir($target);
            continue;
        }
        copy_file($item->getPathname(), $target);
    }
}

function copy_file(string $from, string $to): void
{
    if (!is_file($from)) {
        fail('File not found: ' . $from);
    }
    ensure_dir(dirname($to));
    if (!copy($from, $to)) {
        fail('Failed to copy file: ' . $from);
    }
}

function copy_repo_file_if_present(string $repoRoot, string $stageDir, string $relativePath): void
{
    $src = $repoRoot . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $relativePath);
    if (!is_file($src)) {
        return;
    }
    $dst = $stageDir . DIRECTORY_SEPARATOR . 'source' . DIRECTORY_SEPARATOR . str_replace('/', DIRECTORY_SEPARATOR, $relativePath);
    copy_file($src, $dst);
}

function ensure_dir(string $path): void
{
    if (is_dir($path)) {
        return;
    }
    if (!mkdir($path, 0777, true) && !is_dir($path)) {
        fail('Unable to create directory: ' . $path);
    }
}

function rrmdir(string $path): void
{
    if (!file_exists($path)) {
        return;
    }
    if (is_file($path) || is_link($path)) {
        @unlink($path);
        return;
    }
    $iterator = new RecursiveIteratorIterator(
        new RecursiveDirectoryIterator($path, FilesystemIterator::SKIP_DOTS),
        RecursiveIteratorIterator::CHILD_FIRST
    );
    foreach ($iterator as $item) {
        if ($item->isDir()) {
            @rmdir($item->getPathname());
            continue;
        }
        @unlink($item->getPathname());
    }
    @rmdir($path);
}

function fail(string $message): void
{
    fwrite(STDERR, $message . PHP_EOL);
    exit(1);
}

--TEST--
VSlim builder-style components keep borrowed chains while factories stay fresh
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
declare(strict_types=1);

final class BuilderProbeConn
{
    public array $sent = [];

    public function __construct(private string $id) {}

    public function id(): string
    {
        return $this->id;
    }

    public function send(string $data, string $opcode = 'text'): void
    {
        $this->sent[] = $data;
    }
}

$cfg = new VSlim\Config();
$cfgLoad = $cfg->load_text("app = 'demo'\n");
echo (spl_object_id($cfg) === spl_object_id($cfgLoad) ? "config-borrowed\n" : "config-fresh\n");

$text1 = VSlim\Stream\Response::text(['a']);
$text2 = VSlim\Stream\Response::text(['b']);
echo (spl_object_id($text1) === spl_object_id($text2) ? "stream-factory-shared\n" : "stream-factory-fresh\n");
$textChain = $text1->set_header('x-demo', '1')->set_status(204)->set_content_type('text/custom');
echo (spl_object_id($text1) === spl_object_id($textChain) ? "stream-builder-borrowed\n" : "stream-builder-fresh\n");

$ws = new VSlim\WebSocket\App();
$conn = new BuilderProbeConn('ws-1');
$wsChain = $ws
    ->on_open(static fn ($conn, array $frame): string => 'open')
    ->remember($conn)
    ->join('room-1', $conn);
echo (spl_object_id($ws) === spl_object_id($wsChain) ? "ws-builder-borrowed\n" : "ws-builder-fresh\n");

$mcp = new VSlim\Mcp\App();
$mcpChain = $mcp
    ->server_info(['name' => 'demo', 'version' => '0.1.0'])
    ->capability('sampling', ['enabled' => true])
    ->register('tools/list', static fn (array $params): array => ['tools' => []]);
echo (spl_object_id($mcp) === spl_object_id($mcpChain) ? "mcp-builder-borrowed\n" : "mcp-builder-fresh\n");
?>
--EXPECT--
config-borrowed
stream-factory-fresh
stream-builder-borrowed
ws-builder-borrowed
mcp-builder-borrowed

<?php
declare(strict_types=1);

namespace App\Services;

use App\Repositories\KnowledgeRepository;

final class AssistantAnswerService
{
    public function __construct(private KnowledgeRepository $knowledge)
    {
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @return array<string, mixed>
     */
    public function preview(?array $workspace, string $question): array
    {
        $workspaceId = is_array($workspace) ? (string) ($workspace['id'] ?? '') : '';
        $question = trim($question);
        if ($workspaceId === '' || $question === '') {
            return [
                'question' => $question,
                'answer' => '',
                'citations' => [],
                'diagnostics' => $this->emptyDiagnostics(),
            ];
        }

        return $this->previewFromCorpus(
            $workspace,
            $question,
            $this->knowledge->releasedDocumentsForWorkspace($workspaceId),
            $this->knowledge->releasedEntriesForWorkspace($workspaceId),
        );
    }

    /**
     * @param array<string, mixed>|null $workspace
     * @param array<int, array<string, mixed>> $documents
     * @param array<int, array<string, mixed>> $entries
     * @return array<string, mixed>
     */
    public function previewFromCorpus(?array $workspace, string $question, array $documents, array $entries): array
    {
        $question = trim($question);
        if ($question === '') {
            return [
                'question' => $question,
                'answer' => '',
                'citations' => [],
                'diagnostics' => $this->emptyDiagnostics(),
            ];
        }

        $documentStats = $this->publishedOnly($documents);
        $documents = $documentStats['rows'];
        $entryStats = $this->publishedOnly($entries);
        $entries = $entryStats['rows'];
        if ($entries === [] && $documents === []) {
            return [
                'question' => $question,
                'answer' => '',
                'citations' => [],
                'diagnostics' => [
                    'documents_seen' => '0',
                    'entries_seen' => '0',
                    'documents_ranked' => '0',
                    'entries_ranked' => '0',
                    'published_filter_used' => '0',
                    'fallback_used' => '0',
                ],
            ];
        }

        $rankedEntries = $this->rankKnowledgeRows($entries, $question, true);
        $rankedDocuments = $this->rankKnowledgeRows($documents, $question, false);

        $citations = [];
        foreach (array_slice($rankedEntries, 0, 2) as $row) {
            $entry = $row['row'];
            if (!is_array($entry)) {
                continue;
            }
            $citations[] = [
                'title' => (string) ($entry['title'] ?? ''),
                'kind' => (string) ($entry['kind'] ?? 'faq'),
                'status' => (string) ($entry['status'] ?? ''),
                'coverage_focus' => (string) ($entry['coverage_focus'] ?? $entry['title'] ?? ''),
                'excerpt' => $this->snippet((string) ($entry['body'] ?? $entry['title'] ?? ''), 120),
                'score' => (string) ($row['score'] ?? 0),
                'matched_terms' => implode(', ', $this->matchedTerms((array) ($row['terms'] ?? []))),
                'source_detail' => (string) ($entry['owner'] ?? ''),
            ];
        }
        foreach (array_slice($rankedDocuments, 0, 2) as $row) {
            $document = $row['row'];
            if (!is_array($document)) {
                continue;
            }
            $citations[] = [
                'title' => (string) ($document['title'] ?? ''),
                'kind' => 'document',
                'status' => (string) ($document['status'] ?? ''),
                'coverage_focus' => (string) ($document['coverage_focus'] ?? $document['title'] ?? ''),
                'excerpt' => $this->documentExcerpt($document),
                'score' => (string) ($row['score'] ?? 0),
                'matched_terms' => implode(', ', $this->matchedTerms((array) ($row['terms'] ?? []))),
                'source_detail' => (string) ($document['source_type'] ?? 'upload') . ' / ' . (string) ($document['language'] ?? 'zh-CN'),
            ];
        }
        $citations = array_slice($citations, 0, 3);

        $answerParts = [];
        foreach (array_slice($rankedEntries, 0, 2) as $row) {
            $entry = $row['row'];
            if (!is_array($entry)) {
                continue;
            }
            $answerParts[] = $this->snippet((string) ($entry['body'] ?? $entry['title'] ?? ''), 110);
        }
        foreach (array_slice($rankedDocuments, 0, 1) as $row) {
            $document = $row['row'];
            if (!is_array($document)) {
                continue;
            }
            $answerParts[] = $this->snippet((string) ($document['summary'] ?? $document['body'] ?? $document['title'] ?? ''), 110);
        }
        $usedFallback = false;
        if ($answerParts === [] && $citations !== []) {
            $titles = array_map(static fn (array $citation): string => (string) ($citation['title'] ?? ''), $citations);
            $answerParts[] = '当前知识库中最相关的材料集中在：' . implode('、', array_filter($titles, static fn (string $value): bool => $value !== '')) . '。';
            $usedFallback = true;
        }

        $brand = is_array($workspace) ? (string) ($workspace['brand_name'] ?? $workspace['name'] ?? '该租户') : '该租户';
        $answer = $answerParts !== []
            ? $brand . ' 当前基于已发布知识给出的回答预览：' . implode(' ', $answerParts)
            : '';

        return [
            'question' => $question,
            'answer' => $answer,
            'citations' => $citations,
            'diagnostics' => [
                'documents_seen' => (string) count($documents),
                'entries_seen' => (string) count($entries),
                'documents_ranked' => (string) count($rankedDocuments),
                'entries_ranked' => (string) count($rankedEntries),
                'published_filter_used' => ($documentStats['filtered'] || $entryStats['filtered']) ? '1' : '0',
                'fallback_used' => $usedFallback ? '1' : '0',
            ],
        ];
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array{rows: array<int, array<string, mixed>>, filtered: bool}
     */
    private function publishedOnly(array $rows): array
    {
        $published = array_values(array_filter($rows, static function (array $row): bool {
            return (string) ($row['status'] ?? '') === 'published';
        }));

        return [
            'rows' => $published !== [] ? $published : $rows,
            'filtered' => $published !== [],
        ];
    }

    /**
     * @param array<int, array<string, mixed>> $rows
     * @return array<int, array{score:int,row:array<string,mixed>,terms:array<int,string>}>
     */
    private function rankKnowledgeRows(array $rows, string $question, bool $withBody): array
    {
        $question = trim($question);
        if ($question === '') {
            return [];
        }

        $terms = array_values(array_filter(
            preg_split("/[\s,.;:!?()\[\]{}\"'\/\\\\-]+/u", mb_strtolower($question, 'UTF-8')) ?: [],
            static fn (string $term): bool => $term !== ''
        ));
        $questionLower = mb_strtolower($question, 'UTF-8');
        $ranked = [];

        foreach ($rows as $row) {
            $title = (string) ($row['title'] ?? '');
            $body = $withBody
                ? (string) ($row['body'] ?? '')
                : (string) (($row['summary'] ?? '') . ' ' . ($row['body'] ?? ''));
            $haystack = mb_strtolower(trim($title . ' ' . $body), 'UTF-8');
            if ($haystack === '') {
                continue;
            }

            $score = 0;
            $matchedTerms = [];
            if (mb_strpos($haystack, $questionLower, 0, 'UTF-8') !== false) {
                $score += 8;
            }
            foreach ($terms as $term) {
                if ($term === '') {
                    continue;
                }
                if (mb_strpos($haystack, $term, 0, 'UTF-8') !== false) {
                    $score += 2;
                    $matchedTerms[] = $term;
                }
                if (mb_strpos(mb_strtolower($title, 'UTF-8'), $term, 0, 'UTF-8') !== false) {
                    $score += 1;
                    $matchedTerms[] = $term;
                }
            }

            if ($score <= 0) {
                continue;
            }
            $ranked[] = [
                'score' => $score,
                'row' => $row,
                'terms' => $this->matchedTerms($matchedTerms),
            ];
        }

        usort($ranked, static function (array $left, array $right): int {
            return ($right['score'] <=> $left['score']);
        });

        return $ranked;
    }

    private function snippet(string $text, int $limit): string
    {
        $text = trim(preg_replace('/\s+/u', ' ', $text) ?? '');
        if ($text === '') {
            return '';
        }
        if (mb_strlen($text, 'UTF-8') <= $limit) {
            return $text;
        }

        return rtrim(mb_substr($text, 0, $limit, 'UTF-8')) . '…';
    }

    /**
     * @param array<string, mixed> $document
     */
    private function documentExcerpt(array $document): string
    {
        $summary = trim((string) ($document['summary'] ?? ''));
        if ($summary !== '') {
            return $this->snippet($summary, 120);
        }

        $body = trim((string) ($document['body'] ?? ''));
        if ($body !== '') {
            return $this->snippet($body, 120);
        }

        return '来源类型：' . (string) ($document['source_type'] ?? 'upload') . '，分块数：' . (string) ($document['chunks'] ?? '0');
    }

    /**
     * @param array<int, string> $terms
     * @return array<int, string>
     */
    private function matchedTerms(array $terms): array
    {
        $normalized = [];
        foreach ($terms as $term) {
            $term = trim($term);
            if ($term === '' || in_array($term, $normalized, true)) {
                continue;
            }
            $normalized[] = $term;
        }

        return $normalized;
    }

    /**
     * @return array<string, string>
     */
    private function emptyDiagnostics(): array
    {
        return [
            'documents_seen' => '0',
            'entries_seen' => '0',
            'documents_ranked' => '0',
            'entries_ranked' => '0',
            'published_filter_used' => '0',
            'fallback_used' => '0',
        ];
    }
}

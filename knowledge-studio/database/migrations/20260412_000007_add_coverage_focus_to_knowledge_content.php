<?php
declare(strict_types=1);

return new class extends VSlim\Database\Migration {
    public function up(): bool
    {
        $this->tryAddColumn('knowledge_documents', 'coverage_focus varchar(255) not null');
        $this->tryAddColumn('knowledge_entries', 'coverage_focus varchar(255) not null');

        try {
            $this->execute("UPDATE `knowledge_documents` SET `coverage_focus` = `title` WHERE `coverage_focus` = '' OR `coverage_focus` IS NULL");
        } catch (\Throwable) {
        }

        try {
            $this->execute("UPDATE `knowledge_entries` SET `coverage_focus` = `title` WHERE `coverage_focus` = '' OR `coverage_focus` IS NULL");
        } catch (\Throwable) {
        }

        return true;
    }

    public function down(): bool
    {
        $this->tryDropColumn('knowledge_entries', 'coverage_focus');
        $this->tryDropColumn('knowledge_documents', 'coverage_focus');

        return true;
    }

    private function tryAddColumn(string $table, string $definition): void
    {
        try {
            $this->addColumn($table, $definition);
        } catch (\Throwable) {
        }
    }

    private function tryDropColumn(string $table, string $column): void
    {
        try {
            $this->dropColumn($table, $column);
        } catch (\Throwable) {
        }
    }
};

import json
import pathlib
import sys

root = pathlib.Path(sys.argv[1])
files = {}
for path in sorted(root.rglob('*')):
    relative = path.relative_to(root)
    if any(part.startswith('.') or part in ('compiler', 'docs', 'assets', 'tests') for part in relative.parts):
        continue
    if path.is_file() and not path.name.endswith('_test.v') and (
        path.suffix in ('.v', '.c', '.h', '.php') or path.name == 'v.mod'
    ):
        files[relative.as_posix()] = path.read_text(encoding='utf-8')
pathlib.Path(sys.argv[2]).write_text(json.dumps(files, ensure_ascii=False), encoding='utf-8')

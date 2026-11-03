"""Controleer de goedgekeurde FMT-iconen; genereer geen oud ontwerp."""
from pathlib import Path
import hashlib
import json
root = Path(__file__).resolve().parent
for name, expected in json.loads((root / 'icon-hashes.json').read_text()).items():
    if hashlib.sha256((root / name).read_bytes()).hexdigest() != expected:
        raise SystemExit(f'Goedgekeurd icoon ontbreekt of wijkt af: {name}')
print('Goedgekeurde FMT-Kladblok-iconen gecontroleerd.')

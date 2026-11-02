from pathlib import Path
from PIL import Image
from io import BytesIO
import struct
root = Path(__file__).resolve().parent
for name in ('kladblok',):
    image = Image.open(root / f'fmt-{name}.png').convert('RGBA')
    chunks = []
    for tag, size in [('icp4',16),('icp5',32),('icp6',64),('ic07',128),('ic08',256),('ic09',512),('ic10',1024),('ic11',32),('ic12',64),('ic13',256),('ic14',512)]:
        buffer = BytesIO()
        image.resize((size,size),Image.Resampling.LANCZOS).save(buffer,format='PNG')
        data = buffer.getvalue()
        chunks.append(tag.encode()+struct.pack('>I',len(data)+8)+data)
    body = b''.join(chunks)
    (root/'FMT-Kladblok.icns').write_bytes(b'icns'+struct.pack('>I',len(body)+8)+body)

from PIL import Image, ImageDraw, ImageFont
from pathlib import Path
import html
out=Path(__file__).resolve().parent
B='#0A0A0A'; R='#E10600'
def make(kind):
 im=Image.new('RGBA',(1024,1024)); d=ImageDraw.Draw(im); parts=[]
 def rect(box,fill=B,r=0):
  (d.rounded_rectangle if r else d.rectangle)(box,fill=fill,**({'radius':r} if r else {}))
  x,y,x2,y2=box;parts.append(f'<rect x="{x}" y="{y}" width="{x2-x}" height="{y2-y}" rx="{r}" fill="{fill}"/>')
 def line(points,w=44):
  d.line(points,fill=B,width=w);pts=' '.join(f'{x},{y}' for x,y in points);parts.append(f'<polyline points="{pts}" fill="none" stroke="{B}" stroke-width="{w}" stroke-linecap="square" stroke-linejoin="miter"/>')
 def poly(pts):
  d.polygon(pts,fill=B);parts.append('<polygon points="'+' '.join(f'{x},{y}' for x,y in pts)+f'" fill="{B}"/>')
 rect((32,32,992,992),'#FFFFFF',180)
 # Canonical target, with one bar width clear space.
 ox,oy,s=600,128,.8
 for x,y,w,h in [(135,0,50,110),(135,210,50,110),(0,135,110,50),(210,135,110,50)]:rect((ox+x*s,oy+y*s,ox+(x+w)*s,oy+(y+h)*s))
 cx,cy=ox+160*s,oy+160*s; rr=29*s
 d.ellipse((cx-rr,cy-rr,cx+rr,cy+rr),fill=R);parts.append(f'<circle cx="{cx}" cy="{cy}" r="{rr}" fill="{R}"/>')
 if kind=='kladblok':
  rect((240,426,784,820)); rect((288,474,736,772),'#FFFFFF')
  for x in (336,488,640): rect((x,398,x+48,476))
  for y in (528,624,720): rect((344,y,680,y+36))
 elif kind=='werkplaats':
  for y in (426,622):
   for x in (184,430,676):rect((x,y,x+164,y+148))
 elif kind=='screenshot':
  for x,y in [(184,426),(708,426),(184,662),(708,662)]:
   rect((x,y,x+132,y+48) if y==426 else (x,y+60,x+132,y+108))
   rect((x,y,x+48,y+108) if x==184 else (x+84,y,x+132,y+108))
  poly([(360,674),(382,594),(590,518),(648,576),(440,674)])
 elif kind=='video':
  rect((184,426,840,720)); rect((228,470,796,676),'#FFFFFF')
  poly([(455,486),(455,644),(602,565)])
  rect((184,760,380,820));rect((426,760,582,820));rect((628,760,840,820))
 im.save(out/f'fmt-{kind}.png')
 (out/f'fmt-{kind}.svg').write_text('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1024 1024">'+''.join(parts)+'</svg>')
 return im
if __name__ == '__main__':
 make('kladblok')

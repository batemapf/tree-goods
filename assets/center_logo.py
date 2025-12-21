from PIL import Image
import numpy as np
import os

os.chdir('/Users/patrickbateman/tree-goods/assets')

for suffix in ['black', 'white']:
    orig = f'logo-primary-{suffix}-original.png'
    out = f'logo-primary-{suffix}.png'
    
    img = Image.open(orig).convert('RGBA')
    
    # Crop to the wordmark area - the main content block ends around column 680
    # Use a wider crop to be safe: 0 to 720
    wordmark = img.crop((0, 0, 720, 370))
    
    # Get the bounding box of non-transparent pixels
    bbox = wordmark.getbbox()
    
    if bbox:
        left, top, right, bottom = bbox
        print(f'{suffix}: bbox = {bbox}')
        print(f'  Content size: {right-left} x {bottom-top}')
        
        # Crop to exact content
        content = wordmark.crop(bbox)
        
        # Add equal padding
        pad = 40
        new_w = content.width + pad*2
        new_h = content.height + pad*2
        
        centered = Image.new('RGBA', (new_w, new_h), (0,0,0,0))
        centered.paste(content, (pad, pad), content)
        centered.save(out)
        
        print(f'  Saved: {new_w} x {new_h}')

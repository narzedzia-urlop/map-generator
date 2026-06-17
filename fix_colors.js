const fs = require('fs');
let text = fs.readFileSync('index.html', 'utf8');

text = text.replace(/<div class="color-swatch( selected)?" data-color="brand_green" style="background:linear-gradient\(135deg,#10BF63,#089A4E\)"(?: title="Zielony")?><\/div>/g, (match, sel) => {
  const hasTitle = match.includes('title=');
  const t1 = hasTitle ? ' title="Jasny Zielony"' : '';
  const t2 = hasTitle ? ' title="Zielony"' : '';
  const t3 = hasTitle ? ' title="Ciemny Zielony"' : '';
  const s = sel || '';
  
  return `<div class="color-swatch" data-color="brand_green_light" style="background:linear-gradient(135deg,#4de590,#10BF63)"${t1}></div>
            <div class="color-swatch${s}" data-color="brand_green" style="background:linear-gradient(135deg,#3bd67c,#18A95D)"${t2}></div>
            <div class="color-swatch" data-color="brand_green_dark" style="background:linear-gradient(135deg,#1eb86a,#089A4E)"${t3}></div>`;
});

// Update PALETTE
text = text.replace("brand_green: { c1:'#10BF63', c2:'#089A4E' },", "brand_green_light: { c1:'#4de590', c2:'#10BF63' },\n  brand_green:       { c1:'#3bd67c', c2:'#18A95D' },\n  brand_green_dark:  { c1:'#1eb86a', c2:'#089A4E' },");

fs.writeFileSync('index.html', text);
console.log("Replaced successfully!");

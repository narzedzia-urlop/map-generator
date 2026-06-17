$text = [IO.File]::ReadAllText("index.html")

$oldBlock = '<div class="color-swatch" data-color="brand_green" style="background:linear-gradient(135deg,#10BF63,#089A4E)" title="Zielony"></div>'
$newBlock = '<div class="color-swatch" data-color="brand_green_light" style="background:linear-gradient(135deg,#4de590,#10BF63)" title="Jasny Zielony"></div>
            <div class="color-swatch" data-color="brand_green" style="background:linear-gradient(135deg,#3bd67c,#18A95D)" title="Zielony"></div>
            <div class="color-swatch" data-color="brand_green_dark" style="background:linear-gradient(135deg,#1eb86a,#089A4E)" title="Ciemny Zielony"></div>'
$text = $text.Replace($oldBlock, $newBlock)

$oldBlockSel = '<div class="color-swatch selected" data-color="brand_green" style="background:linear-gradient(135deg,#10BF63,#089A4E)" title="Zielony"></div>'
$newBlockSel = '<div class="color-swatch" data-color="brand_green_light" style="background:linear-gradient(135deg,#4de590,#10BF63)" title="Jasny Zielony"></div>
            <div class="color-swatch selected" data-color="brand_green" style="background:linear-gradient(135deg,#3bd67c,#18A95D)" title="Zielony"></div>
            <div class="color-swatch" data-color="brand_green_dark" style="background:linear-gradient(135deg,#1eb86a,#089A4E)" title="Ciemny Zielony"></div>'
$text = $text.Replace($oldBlockSel, $newBlockSel)

$oldBlockNoTitle = '<div class="color-swatch" data-color="brand_green" style="background:linear-gradient(135deg,#10BF63,#089A4E)"></div>'
$newBlockNoTitle = '<div class="color-swatch" data-color="brand_green_light" style="background:linear-gradient(135deg,#4de590,#10BF63)"></div>
              <div class="color-swatch" data-color="brand_green" style="background:linear-gradient(135deg,#3bd67c,#18A95D)"></div>
              <div class="color-swatch" data-color="brand_green_dark" style="background:linear-gradient(135deg,#1eb86a,#089A4E)"></div>'
$text = $text.Replace($oldBlockNoTitle, $newBlockNoTitle)

$oldBlockNoTitleSel = '<div class="color-swatch selected" data-color="brand_green" style="background:linear-gradient(135deg,#10BF63,#089A4E)"></div>'
$newBlockNoTitleSel = '<div class="color-swatch" data-color="brand_green_light" style="background:linear-gradient(135deg,#4de590,#10BF63)"></div>
              <div class="color-swatch selected" data-color="brand_green" style="background:linear-gradient(135deg,#3bd67c,#18A95D)"></div>
              <div class="color-swatch" data-color="brand_green_dark" style="background:linear-gradient(135deg,#1eb86a,#089A4E)"></div>'
$text = $text.Replace($oldBlockNoTitleSel, $newBlockNoTitleSel)

$oldPal = "brand_green: { c1:'#10BF63', c2:'#089A4E' },"
$newPal = "brand_green_light: { c1:'#4de590', c2:'#10BF63' },`n  brand_green:       { c1:'#3bd67c', c2:'#18A95D' },`n  brand_green_dark:  { c1:'#1eb86a', c2:'#089A4E' },"
$text = $text.Replace($oldPal, $newPal)

[IO.File]::WriteAllText("index.html", $text)

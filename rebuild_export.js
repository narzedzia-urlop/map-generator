const fs = require('fs');
let html = fs.readFileSync('index.html', 'utf8');

const expJsStart = html.indexOf('// ── EXPORT MODAL ─');
const skrotyStart = html.indexOf('// ── SKRÓTY KLAWISZOWE');
const scriptClose = html.lastIndexOf('</script>');

const before = html.substring(0, expJsStart);
const skrotyOnward = html.substring(skrotyStart, scriptClose + 9);

const newExportJS = `// ── EXPORT MODAL ─────────────────────────────────────────────────────────────
let cropBox = { x:0, y:0, w:1, h:1 };
let expDrag = null;
let lassoPolygons = [];
let lassoDrawing = false;
let currentLasso = [];

document.querySelectorAll('.exportBtn').forEach(b => b.addEventListener('click', openExportModal));

function openExportModal() {
  cropBox = { x:0, y:0, w:1, h:1 };
  lassoPolygons = [];
  currentLasso = [];
  lassoDrawing = false;

  const saved = state.selectedId;
  state.selectedId = null;
  render();
  state.selectedId = saved;

  const mapCv = map && map.getCanvas ? map.getCanvas() : null;
  const prev  = document.getElementById('expPrev');
  const srcW  = canvas.width, srcH = canvas.height;
  prev.width  = srcW; prev.height = srcH;
  const pCtx  = prev.getContext('2d');
  if (mapCv) pCtx.drawImage(mapCv, 0, 0, srcW, srcH);
  pCtx.drawImage(canvas, 0, 0, srcW, srcH);

  document.getElementById('exportModal').classList.add('visible');
  setTimeout(function() { updateCropUI(); initLassoCanvas(); }, 80);
}

function closeExportModal() {
  document.getElementById('exportModal').classList.remove('visible');
  lassoPolygons = []; currentLasso = []; lassoDrawing = false;
  render();
}

function updateCropUI() {
  const wrap   = document.getElementById('expPreviewWrap');
  const rectEl = document.getElementById('expCropRect');
  const label  = document.getElementById('expDimLabel');
  if (!wrap || !rectEl) return;
  const pw = wrap.clientWidth, ph = wrap.clientHeight;
  rectEl.style.left   = cropBox.x * pw + 'px';
  rectEl.style.top    = cropBox.y * ph + 'px';
  rectEl.style.width  = cropBox.w * pw + 'px';
  rectEl.style.height = cropBox.h * ph + 'px';
  const prev = document.getElementById('expPrev');
  const srcW = prev.width || 1, srcH = prev.height || 1;
  const ow = Math.round(cropBox.w * srcW), oh = Math.round(cropBox.h * srcH);
  if (label) label.textContent = (cropBox.w >= 0.999 && cropBox.h >= 0.999)
    ? ('Pelny: ' + srcW + 'x' + srcH + 'px')
    : (ow + 'x' + oh + 'px');
}

function initLassoCanvas() {
  const lCv = document.getElementById('expLassoCv');
  const wrap = document.getElementById('expPreviewWrap');
  if (!lCv || !wrap) return;
  lCv.width  = wrap.clientWidth;
  lCv.height = wrap.clientHeight;
  drawLassoOverlay();
}

function drawLassoOverlay() {
  const lCv = document.getElementById('expLassoCv');
  if (!lCv) return;
  const lCtx = lCv.getContext('2d');
  lCtx.clearRect(0, 0, lCv.width, lCv.height);
  const prev = document.getElementById('expPrev');
  const scaleX = lCv.width  / (prev.width  || 1);
  const scaleY = lCv.height / (prev.height || 1);

  function drawPoly(pts, strokeColor, fillColor) {
    if (pts.length < 2) return;
    lCtx.beginPath();
    lCtx.moveTo(pts[0].x * scaleX, pts[0].y * scaleY);
    for (var i = 1; i < pts.length; i++) lCtx.lineTo(pts[i].x * scaleX, pts[i].y * scaleY);
    lCtx.closePath();
    lCtx.fillStyle = fillColor; lCtx.fill();
    lCtx.strokeStyle = strokeColor; lCtx.lineWidth = 2;
    lCtx.setLineDash([5, 4]); lCtx.stroke(); lCtx.setLineDash([]);
  }

  lassoPolygons.forEach(function(pts) { drawPoly(pts, '#ef4444', 'rgba(239,68,68,0.35)'); });
  if (currentLasso.length > 1) drawPoly(currentLasso, '#f97316', 'rgba(249,115,22,0.2)');
}

function onExpMove(e) {
  if (!expDrag) return;
  const d = expDrag;
  const dx = (e.clientX - d.sx) / d.wr.width;
  const dy = (e.clientY - d.sy) / d.wr.height;
  const MIN = 0.04;
  let x = d.orig.x, y = d.orig.y, w = d.orig.w, h = d.orig.h;
  if (d.type === 'move') {
    x = Math.max(0, Math.min(1 - w, x + dx));
    y = Math.max(0, Math.min(1 - h, y + dy));
  } else {
    var dir = d.dir;
    if (dir.indexOf('e') >= 0) w = Math.max(MIN, Math.min(1 - x, w + dx));
    if (dir.indexOf('s') >= 0) h = Math.max(MIN, Math.min(1 - y, h + dy));
    if (dir.indexOf('w') >= 0) { var nx = Math.max(0, Math.min(x+w-MIN, x+dx)); w = w+x-nx; x = nx; }
    if (dir.indexOf('n') >= 0) { var ny = Math.max(0, Math.min(y+h-MIN, y+dy)); h = h+y-ny; y = ny; }
  }
  cropBox = { x:x, y:y, w:w, h:h };
  updateCropUI();
}

function onExpUp() {
  expDrag = null;
  document.removeEventListener('pointermove', onExpMove);
}

function doExport() {
  const mapCv = map && map.getCanvas ? map.getCanvas() : null;
  const srcW = canvas.width, srcH = canvas.height;

  const saved = state.selectedId;
  state.selectedId = null;
  render();
  state.selectedId = saved;

  const comp = document.createElement('canvas');
  comp.width = srcW; comp.height = srcH;
  const cCtx = comp.getContext('2d');
  if (mapCv) cCtx.drawImage(mapCv, 0, 0, srcW, srcH);
  cCtx.drawImage(canvas, 0, 0, srcW, srcH);

  if (lassoPolygons.length > 0) {
    cCtx.globalCompositeOperation = 'destination-out';
    lassoPolygons.forEach(function(pts) {
      cCtx.beginPath();
      cCtx.moveTo(pts[0].x, pts[0].y);
      for (var i = 1; i < pts.length; i++) cCtx.lineTo(pts[i].x, pts[i].y);
      cCtx.closePath();
      cCtx.fill();
    });
    cCtx.globalCompositeOperation = 'source-over';
  }

  var cx = Math.round(cropBox.x * srcW), cy = Math.round(cropBox.y * srcH);
  var cw = Math.max(1, Math.round(cropBox.w * srcW)), ch = Math.max(1, Math.round(cropBox.h * srcH));

  var minPx = 1500;
  var scale  = Math.max(1, minPx / Math.max(cw, ch));
  var outW   = Math.round(cw * scale), outH = Math.round(ch * scale);

  var out = document.createElement('canvas');
  out.width = outW; out.height = outH;
  var oCtx = out.getContext('2d');
  oCtx.imageSmoothingEnabled = true;
  oCtx.imageSmoothingQuality = 'high';
  oCtx.drawImage(comp, cx, cy, cw, ch, 0, 0, outW, outH);

  var mapName = (BUILTIN_MAPS.find(function(m) { return m.id === state.activeMapId; }) || { name:'mapa' }).name;
  var fname = 'mapka_' + mapName.toLowerCase().replace(/\\s+/g, '_') + '_' + Date.now() + '.png';
  out.toBlob(function(blob) {
    if (!blob) { toast('Blad eksportu', 'error'); return; }
    var url = URL.createObjectURL(blob);
    var a = document.createElement('a'); a.download = fname; a.href = url;
    document.body.appendChild(a); a.click(); document.body.removeChild(a);
    setTimeout(function() { URL.revokeObjectURL(url); }, 1000);
    toast('Eksportowano ' + outW + 'x' + outH + 'px', 'success');
  }, 'image/png');

  render();
  closeExportModal();
}

// Init modal events after DOMContentLoaded
document.addEventListener('DOMContentLoaded', function() {
  document.getElementById('expCancelBtn')?.addEventListener('click', closeExportModal);

  document.getElementById('expResetCropBtn')?.addEventListener('click', function() {
    cropBox = { x:0, y:0, w:1, h:1 }; updateCropUI();
  });

  document.getElementById('expClearLassoBtn')?.addEventListener('click', function() {
    lassoPolygons = []; currentLasso = []; drawLassoOverlay();
  });

  document.getElementById('expConfirmBtn')?.addEventListener('click', doExport);

  var cropRectEl = document.getElementById('expCropRect');
  if (cropRectEl) {
    cropRectEl.addEventListener('pointerdown', function(e) {
      if (e.target.classList.contains('exp-handle')) return;
      e.preventDefault(); e.stopPropagation();
      var wrap = document.getElementById('expPreviewWrap');
      expDrag = { type:'move', sx:e.clientX, sy:e.clientY, orig:{...cropBox}, wr:wrap.getBoundingClientRect() };
      document.addEventListener('pointermove', onExpMove);
      document.addEventListener('pointerup', onExpUp, { once:true });
    });
  }

  document.querySelectorAll('.exp-handle').forEach(function(h) {
    h.addEventListener('pointerdown', function(e) {
      e.preventDefault(); e.stopPropagation();
      var wrap = document.getElementById('expPreviewWrap');
      expDrag = { type:'resize', dir:h.dataset.dir, sx:e.clientX, sy:e.clientY, orig:{...cropBox}, wr:wrap.getBoundingClientRect() };
      document.addEventListener('pointermove', onExpMove);
      document.addEventListener('pointerup', onExpUp, { once:true });
    });
  });

  var lCv = document.getElementById('expLassoCv');
  if (lCv) {
    lCv.addEventListener('pointerdown', function(e) {
      e.preventDefault(); e.stopPropagation();
      lassoDrawing = true;
      currentLasso = [];
      var r = lCv.getBoundingClientRect();
      var prev = document.getElementById('expPrev');
      lCv.setPointerCapture(e.pointerId);
      currentLasso.push({ x:(e.clientX-r.left)/r.width*prev.width, y:(e.clientY-r.top)/r.height*prev.height });
    });
    lCv.addEventListener('pointermove', function(e) {
      if (!lassoDrawing) return;
      var r = lCv.getBoundingClientRect();
      var prev = document.getElementById('expPrev');
      currentLasso.push({ x:(e.clientX-r.left)/r.width*prev.width, y:(e.clientY-r.top)/r.height*prev.height });
      drawLassoOverlay();
    });
    lCv.addEventListener('pointerup', function() {
      if (!lassoDrawing) return;
      lassoDrawing = false;
      if (currentLasso.length > 5) lassoPolygons.push([...currentLasso]);
      currentLasso = [];
      drawLassoOverlay();
    });
  }
});

`;

const newModalHTML = `<!-- ── EXPORT MODAL ─────────────────────────────────────────────────────── -->
<div id="exportModal">
  <div class="export-modal-box">
    <div class="export-modal-title">&#x1F4BE; Ustawienia eksportu PNG</div>
    <div class="export-modal-body">
      <div class="export-preview-wrap" id="expPreviewWrap">
        <canvas id="expPrev" style="width:100%;height:100%;display:block;"></canvas>
        <div style="position:absolute;inset:0;pointer-events:none;">
          <div id="expCropRect" class="crop-rect" style="pointer-events:all;">
            <div class="crop-handle exp-handle nw" data-dir="nw"></div>
            <div class="crop-handle exp-handle n"  data-dir="n"></div>
            <div class="crop-handle exp-handle ne" data-dir="ne"></div>
            <div class="crop-handle exp-handle e"  data-dir="e"></div>
            <div class="crop-handle exp-handle se" data-dir="se"></div>
            <div class="crop-handle exp-handle s"  data-dir="s"></div>
            <div class="crop-handle exp-handle sw" data-dir="sw"></div>
            <div class="crop-handle exp-handle w"  data-dir="w"></div>
          </div>
        </div>
        <canvas id="expLassoCv" style="position:absolute;inset:0;width:100%;height:100%;cursor:crosshair;"></canvas>
      </div>
      <div class="export-sidebar">
        <div>
          <div class="export-section-title">Ramka kadrowania</div>
          <div class="export-dim-label" id="expDimLabel">Pelny ekran</div>
          <button class="btn btn-outline" id="expResetCropBtn" style="width:100%;font-size:12px;padding:6px;margin-bottom:8px;">&#8635; Reset ramki</button>
        </div>
        <div>
          <div class="export-section-title">&#x1FA84; Gumka lasso</div>
          <p style="font-size:11px;color:var(--text-muted);margin:4px 0 8px;line-height:1.4;">Narysuj obszar na podgladzie freehand &ndash; zostanie wyciety z PNG (przezroczysty).</p>
          <button class="btn btn-outline" id="expClearLassoBtn" style="width:100%;font-size:12px;padding:6px;">&#x1F5D1;&#xFE0F; Wyczysc zaznaczenia</button>
        </div>
        <div style="margin-top:8px;">
          <p style="font-size:11px;color:var(--text-muted);">Eksport min. 1500px, przezroczyste tlo.</p>
        </div>
      </div>
    </div>
    <div class="export-modal-footer">
      <button class="btn btn-outline" id="expCancelBtn">Anuluj</button>
      <button class="btn btn-primary" id="expConfirmBtn">&#x1F4BE; Eksportuj PNG</button>
    </div>
  </div>
</div>`;

const finalHtml = before + newExportJS + skrotyOnward + '\n' + newModalHTML + '\n</body>\n</html>\n';
fs.writeFileSync('index.html', finalHtml);
console.log('Done. New length:', finalHtml.length);

$html = Get-Content 'index.html' -Raw

$newCityDB = @"
const CITY_DB = {
  caribbean: [
    { name: 'Punta Cana', lng: -68.3739, lat: 18.5820, type: 'plaza' },
    { name: 'Santo Domingo', lng: -69.9312, lat: 18.4861, type: 'miasto' },
    { name: 'Hawana', lng: -82.3666, lat: 23.1136, type: 'miasto' },
    { name: 'Varadero', lng: -81.2515, lat: 23.1568, type: 'plaza' },
    { name: 'Nassau (Bahamy)', lng: -77.3390, lat: 25.0343, type: 'miasto' },
    { name: 'Kingston', lng: -76.7920, lat: 18.0179, type: 'miasto' },
    { name: 'Montego Bay', lng: -77.9188, lat: 18.4714, type: 'plaza' },
    { name: 'San Juan (Portoryko)', lng: -66.1057, lat: 18.4655, type: 'miasto' },
    { name: 'Aruba', lng: -69.9683, lat: 12.5211, type: 'wyspa' },
    { name: 'Barbados', lng: -59.5432, lat: 13.1939, type: 'wyspa' }
  ],
  canaries: [
    { name: 'Teneryfa', lng: -16.6291, lat: 28.2916, type: 'wyspa' },
    { name: 'Santa Cruz', lng: -16.2518, lat: 28.4636, type: 'miasto' },
    { name: 'Gran Canaria', lng: -15.5997, lat: 27.9202, type: 'wyspa' },
    { name: 'Las Palmas', lng: -15.4363, lat: 28.1235, type: 'miasto' },
    { name: 'Lanzarote', lng: -13.6234, lat: 29.0469, type: 'wyspa' },
    { name: 'Fuerteventura', lng: -14.0135, lat: 28.3587, type: 'wyspa' }
  ],
  balearics: [
    { name: 'Majorka', lng: 2.9958, lat: 39.6953, type: 'wyspa' },
    { name: 'Palma de Mallorca', lng: 2.6502, lat: 39.5696, type: 'miasto' },
    { name: 'Minorka', lng: 4.0226, lat: 39.9496, type: 'wyspa' },
    { name: 'Ibiza', lng: 1.4330, lat: 38.9067, type: 'wyspa' }
  ],
  madeira_azores: [
    { name: 'Funchal (Madera)', lng: -16.9081, lat: 32.6511, type: 'miasto' },
    { name: 'Ponta Delgada (Azory)', lng: -25.6687, lat: 37.7412, type: 'miasto' }
  ],
  mediterranean: [
    { name: 'Valletta (Malta)', lng: 14.5146, lat: 35.8989, type: 'miasto' },
    { name: 'Nikozja (Cypr)', lng: 33.3600, lat: 35.1856, type: 'miasto' },
    { name: 'Pafos (Cypr)', lng: 32.4245, lat: 34.7720, type: 'plaza' },
    { name: 'Cagliari (Sardynia)', lng: 9.1190, lat: 39.2238, type: 'miasto' },
    { name: 'Palermo (Sycylia)', lng: 13.3615, lat: 38.1157, type: 'miasto' },
    { name: 'Katania (Sycylia)', lng: 15.0873, lat: 37.5079, type: 'miasto' }
  ],
  greece_extended: [
    { name: 'Korfu', lng: 19.9197, lat: 39.6243, type: 'wyspa' },
    { name: 'Mykonos', lng: 25.3274, lat: 37.4415, type: 'wyspa' },
    { name: 'Santorini', lng: 25.4317, lat: 36.3932, type: 'wyspa' },
    { name: 'Rodos', lng: 28.2272, lat: 36.4341, type: 'miasto' },
    { name: 'Kos', lng: 27.2896, lat: 36.8932, type: 'miasto' },
    { name: 'Zakynthos', lng: 20.8996, lat: 37.7818, type: 'miasto' },
    { name: 'Kreta', lng: 24.8093, lat: 35.2401, type: 'wyspa' },
    { name: 'Heraklion (Kreta)', lng: 25.1325, lat: 35.3387, type: 'miasto' },
    { name: 'Chania (Kreta)', lng: 24.0196, lat: 35.5138, type: 'miasto' }
  ],
  exotic: [
    { name: 'Male (Malediwy)', lng: 73.5093, lat: 4.1755, type: 'miasto' },
    { name: 'Mahe (Seszele)', lng: 55.4920, lat: -4.6796, type: 'wyspa' },
    { name: 'Port Louis (Mauritius)', lng: 57.5012, lat: -20.1609, type: 'miasto' },
    { name: 'Phuket (Tajlandia)', lng: 98.3923, lat: 7.8804, type: 'plaza' },
    { name: 'Bali (Indonezja)', lng: 115.1889, lat: -8.4095, type: 'wyspa' },
    { name: 'Zanzibar', lng: 39.2083, lat: -6.1659, type: 'wyspa' }
  ],
  europe_cities: [
    { name: 'Rzym', lng: 12.4964, lat: 41.9028, type: 'miasto' },
    { name: 'Paryż', lng: 2.3522, lat: 48.8566, type: 'miasto' },
    { name: 'Londyn', lng: -0.1276, lat: 51.5074, type: 'miasto' },
    { name: 'Madryt', lng: -3.7038, lat: 40.4168, type: 'miasto' },
    { name: 'Barcelona', lng: 2.1686, lat: 41.3874, type: 'miasto' },
    { name: 'Berlin', lng: 13.4050, lat: 52.5200, type: 'miasto' },
    { name: 'Amsterdam', lng: 4.9041, lat: 52.3676, type: 'miasto' },
    { name: 'Praga', lng: 14.4378, lat: 50.0755, type: 'miasto' },
    { name: 'Wiedeń', lng: 16.3738, lat: 48.2082, type: 'miasto' },
    { name: 'Ateny', lng: 23.7275, lat: 37.9838, type: 'miasto' },
    { name: 'Lizbona', lng: -9.1393, lat: 38.7223, type: 'miasto' }
  ],
  world: [
    { name: 'Nowy Jork', lng: -74.0060, lat: 40.7128, type: 'miasto' },
    { name: 'Dubaj', lng: 55.2708, lat: 25.2048, type: 'miasto' },
    { name: 'Tokio', lng: 139.6917, lat: 35.6895, type: 'miasto' },
    { name: 'Sydney', lng: 151.2093, lat: -33.8688, type: 'miasto' },
    { name: 'Rio de Janeiro', lng: -43.1729, lat: -22.9068, type: 'miasto' },
    { name: 'Kapsztad', lng: 18.4232, lat: -33.9249, type: 'miasto' }
  ]
};
"@

$newBuiltinMaps = @"
const BUILTIN_MAPS = [
  { id: 'world', name: 'Świat', sub: 'Widok globalny', emoji: '🌍', center: [0, 20], zoom: 1.5, category: 'Świat' },
  { id: 'europe', name: 'Europa', sub: 'Kontynent europejski', emoji: '🇪🇺', center: [15, 50], zoom: 3.5, category: 'Regiony' },
  { id: 'caribbean', name: 'Karaiby', sub: 'Morze Karaibskie', emoji: '🥥', center: [-73, 19], zoom: 4.5, category: 'Regiony' },
  { id: 'canaries', name: 'Wyspy Kanaryjskie', sub: 'Hiszpania', emoji: '🌋', center: [-15.5, 28.3], zoom: 6.5, category: 'Wyspy' },
  { id: 'balearics', name: 'Baleary', sub: 'Hiszpania', emoji: '⛵', center: [2.9, 39.5], zoom: 7, category: 'Wyspy' },
  { id: 'greece', name: 'Grecja', sub: 'Morze Egejskie', emoji: '🏛️', center: [24, 38], zoom: 5.5, category: 'Kraje' },
  { id: 'crete', name: 'Kreta', sub: 'Grecja', emoji: '🏝️', center: [24.8, 35.2], zoom: 7.5, category: 'Wyspy' },
  { id: 'italy', name: 'Włochy', sub: 'Półwysep Apeniński', emoji: '🍕', center: [12.5, 42], zoom: 5, category: 'Kraje' },
  { id: 'spain', name: 'Hiszpania', sub: 'Półwysep Iberyjski', emoji: '💃', center: [-3.7, 40.4], zoom: 5, category: 'Kraje' },
  { id: 'egypt', name: 'Egipt', sub: 'Afryka Północna', emoji: '🐪', center: [30, 26], zoom: 5, category: 'Kraje' },
  { id: 'turkey', name: 'Turcja', sub: 'Eurazja', emoji: '🕌', center: [35, 39], zoom: 5, category: 'Kraje' },
  { id: 'maldives', name: 'Malediwy', sub: 'Ocean Indyjski', emoji: '🤿', center: [73.5, 4.1], zoom: 7, category: 'Wyspy' }
];
"@

$html = $html -replace '(?s)const CITY_DB = \{.*?\n\};', $newCityDB
$html = $html -replace '(?s)const BUILTIN_MAPS = \[.*?\n\];', $newBuiltinMaps

# Replace the Map setup, events and image setup 
$newInit = @"
let map;

function initImages() {
  for (const [key, src] of Object.entries(MARKER_SRCS)) {
    try { 
      const b64 = (typeof B64_IMAGES !== 'undefined') ? B64_IMAGES[src.split('/').pop()] : null;
      loadImg(b64 || src).then(i => markerImgs[key] = i);
    }
    catch(e) { console.warn(e.message); }
  }
  
  map = new maplibregl.Map({
    container: 'mapContainer',
    style: 'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json',
    center: [0, 20],
    zoom: 1.5,
    preserveDrawingBuffer: true,
    attributionControl: false
  });
  
  map.on('load', () => {
    resizeCanvas();
    render();
    selectMap('europe');
  });
  
  map.on('move', render);
  map.on('zoom', render);
  
  // Custom click handling
  map.on('mousedown', onMapMouseDown);
  map.on('mousemove', onMapMouseMove);
  map.on('mouseup', onMapMouseUp);
  map.on('dblclick', onMapDblClick);
  
  // Disable default double click zoom
  map.doubleClickZoom.disable();
  
  window.addEventListener('resize', resizeCanvas);
  buildMapGrid(); 
  updateLabelPreview();
}

function resizeCanvas() {
  const cont = document.getElementById('mapContainer');
  canvas.width = cont.clientWidth;
  canvas.height = cont.clientHeight;
}

let isDraggingMarker = false;

function onMapMouseDown(e) {
  if (e.originalEvent.button !== 0) return;
  
  if (state.addingMode) {
    const label = document.getElementById('markerLabel')?.value.trim() || '';
    placeMarker(e.lngLat.lng, e.lngLat.lat, label);
    return;
  }
  
  const hit = hitMarker(e.point.x, e.point.y);
  if (hit) {
    e.preventDefault();
    map.dragPan.disable();
    isDraggingMarker = true;
    saveState();
    state.draggingId = hit.id;
    state.selectedId = hit.id;
    buildMarkersList(); 
    render();
  } else {
    state.selectedId = null;
    buildMarkersList(); 
    render();
  }
}

function onMapMouseMove(e) {
  if (isDraggingMarker && state.draggingId) {
    const m = state.markers.find(m => m.id === state.draggingId);
    if (m) {
      m.lng = e.lngLat.lng;
      m.lat = e.lngLat.lat;
      render();
    }
  } else if (!state.addingMode) {
    canvas.style.cursor = hitMarker(e.point.x, e.point.y) ? 'grab' : 'default';
  }
}

function onMapMouseUp(e) {
  if (isDraggingMarker) {
    isDraggingMarker = false;
    map.dragPan.enable();
    state.draggingId = null;
  }
}

function onMapDblClick(e) {
  if (state.addingMode) return;
  const hit = hitMarker(e.point.x, e.point.y);
  if (hit) { 
    state.selectedId = hit.id; 
    openEditModal(hit); 
    buildMarkersList(); 
    render(); 
  }
}

function selectMap(id) {
  state.activeMapId = id;
  cancelAddingMode();
  const mapData = BUILTIN_MAPS.find(m => m.id === id);
  if (mapData && map) {
    map.flyTo({ center: mapData.center, zoom: mapData.zoom });
  }
  document.querySelectorAll('.map-card').forEach(c => c.classList.toggle('active', c.dataset.id===id));
  render(); 
  closeAutocomplete();
}

function render() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  
  // Calculate projected coordinates for all markers
  state.markers.forEach(m => {
    if (m.lng !== undefined && m.lat !== undefined && map) {
      const pt = map.project([m.lng, m.lat]);
      m.x = pt.x;
      m.y = pt.y;
    }
  });

  const activeMarkers = state.markers.filter(m => m.mapId === state.activeMapId || !m.mapId);
  const activeConns = state.connections.filter(c => {
    return !!activeMarkers.find(m => m.id === c.fromId);
  });
  activeConns.forEach(c => drawConnection(ctx, c, activeMarkers));
  activeMarkers.forEach(m => drawMarker(ctx, m, m.id === state.selectedId));
}

function exportPNG() {
  const saved = state.selectedId;
  state.selectedId = null;
  render();

  const mapName = (BUILTIN_MAPS.find(m => m.id === state.activeMapId) || { name: 'mapa' }).name;
  const fname   = \`mapka_\${mapName.toLowerCase().replace(/\s+/g, '_')}_\${Date.now()}.png\`;

  try {
    const mlCanvas = map.getCanvas();
    const finalCanvas = document.createElement('canvas');
    finalCanvas.width = mlCanvas.width;
    finalCanvas.height = mlCanvas.height;
    const fctx = finalCanvas.getContext('2d');
    
    // Draw MapLibre base
    fctx.drawImage(mlCanvas, 0, 0);
    // Draw our custom overlay
    fctx.drawImage(canvas, 0, 0, mlCanvas.width, mlCanvas.height);

    finalCanvas.toBlob(blob => {
      if (!blob) { toast('Błąd: nie można wyeksportować', 'error'); return; }
      const url = URL.createObjectURL(blob);
      const a   = document.createElement('a');
      a.download = fname; a.href = url;
      document.body.appendChild(a); a.click(); document.body.removeChild(a);
      setTimeout(() => URL.revokeObjectURL(url), 1000);
      toast(\`Eksportowano: \${fname}\`, 'success');
    }, 'image/png');
  } catch(err) {
    toast('Błąd eksportu: ' + err.message, 'error');
  } finally {
    state.selectedId = saved;
    render();
  }
}
"@

$html = $html -replace '(?s)async function initImages\(\) \{.*?\n\}', $newInit
$html = $html -replace '(?s)function drawMap\(c, w, h, img\) \{.*?\n\}', ''
$html = $html -replace '(?s)function render\(\) \{.*?\n\}', ''
$html = $html -replace '(?s)function exportPNG\(\) \{.*?\n\}', ''

Set-Content -Path 'index.html' -Value $html -Encoding UTF8

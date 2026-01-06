<template>
  <div ref="containerRef" class="waf-3d-container" style="position: relative; touch-action: none; width: 100%; height: 100%; min-height: 350px; background: #020408;">
    <!-- 3D Canvas -->
    <canvas ref="canvasRef" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 5; cursor: grab; display: block;"></canvas>

    <!-- Overlay UI - Minimal -->
    <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; z-index: 10; pointer-events: none; user-select: none;">
      <!-- Title Badge -->
      <div style="position: absolute; top: 12px; left: 50%; transform: translateX(-50%); padding: 0.35rem 1rem; background: rgba(0,0,0,0.6); backdrop-filter: blur(8px); border: 1px solid rgba(6, 182, 212, 0.3); border-radius: 9999px;">
        <div style="display: flex; align-items: center; gap: 0.5rem;">
          <div style="position: relative; display: flex; align-items: center; justify-content: center; width: 8px; height: 8px;">
            <div style="position: absolute; width: 100%; height: 100%; background: #22d3ee; border-radius: 50%; animation: ping 1s cubic-bezier(0, 0, 0.2, 1) infinite; opacity: 0.75;"></div>
            <div style="position: relative; width: 6px; height: 6px; background: #06b6d4; border-radius: 50%; box-shadow: 0 0 8px #06b6d4;"></div>
          </div>
          <span style="font-family: monospace; color: #67e8f9; font-size: 0.7rem; font-weight: bold; letter-spacing: 0.15em; text-shadow: 0 0 8px rgba(6, 182, 212, 0.7);">GLOBAL THREAT MONITOR</span>
        </div>
      </div>

      <!-- Legend (compact) -->
      <div style="position: absolute; bottom: 8px; right: 8px; padding: 0.5rem; background: rgba(0,0,0,0.6); backdrop-filter: blur(8px); border-radius: 6px; border: 1px solid rgba(255,255,255,0.05);">
        <div style="display: flex; gap: 1rem; font-family: monospace; font-size: 9px; color: #9ca3af;">
          <div style="display: flex; align-items: center; gap: 4px;">
            <div style="width: 6px; height: 6px; border-radius: 50%; background: #ef4444; box-shadow: 0 0 6px #ef4444;"></div>
            <span>BLOCKED</span>
          </div>
          <div style="display: flex; align-items: center; gap: 4px;">
            <div style="width: 6px; height: 6px; border-radius: 50%; background: #22c55e; box-shadow: 0 0 6px #22c55e;"></div>
            <span>ALLOWED</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="isLoading" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center; background: #020408; z-index: 50;">
      <div style="position: relative; width: 48px; height: 48px; margin-bottom: 0.75rem;">
        <div style="position: absolute; inset: 0; border: 2px solid transparent; border-top-color: #06b6d4; border-radius: 50%; animation: spin 1s linear infinite;"></div>
        <div style="position: absolute; inset: 6px; border: 2px solid transparent; border-right-color: rgba(6, 182, 212, 0.5); border-radius: 50%; animation: spin 1s linear infinite reverse;"></div>
      </div>
      <div style="font-family: monospace; color: #06b6d4; font-size: 0.65rem; letter-spacing: 0.08em; animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;">CONNECTING...</div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted, reactive, watch } from 'vue'
import * as THREE from 'three'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js'
import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer.js'
import { RenderPass } from 'three/examples/jsm/postprocessing/RenderPass.js'
import { UnrealBloomPass } from 'three/examples/jsm/postprocessing/UnrealBloomPass.js'
import { CSS2DRenderer, CSS2DObject } from 'three/examples/jsm/renderers/CSS2DRenderer.js'

const props = defineProps({
  blockedCount: { type: Number, default: 0 },
  allowedCount: { type: Number, default: 0 },
  integrity: { type: Number, default: 100 }
})

const containerRef = ref(null)
const canvasRef = ref(null)
const isLoading = ref(true)

const localStats = reactive({
  blocked: props.blockedCount || 84291,
  allowed: props.allowedCount || 1250000,
  integrity: props.integrity || 99
})

watch(() => props.blockedCount, (v) => { if (v) localStats.blocked = v })
watch(() => props.allowedCount, (v) => { if (v) localStats.allowed = v })
watch(() => props.integrity, (v) => { if (v) localStats.integrity = v })

// THREE.js Variables
let scene, camera, renderer, composer, controls, labelRenderer
let earthGroup, earthMesh, atmosphereMesh
let particles = []
let sourceMarkers = []
let animationFrameId
let clock = new THREE.Clock()
let attackQueue = []
let pollInterval = null

// Earth Constants
const EARTH_RADIUS = 10
const TAIWAN_COORDS = { lat: 25, lon: 118 }
const ATTACK_COLOR = 0xff3366
const SAFE_COLOR = 0x00ff88
const LON_OFFSET = -8

function initScene() {
  if (!containerRef.value || !canvasRef.value) return

  const width = containerRef.value.clientWidth
  const height = containerRef.value.clientHeight

  scene = new THREE.Scene()
  scene.fog = new THREE.FogExp2(0x020408, 0.015)

  camera = new THREE.PerspectiveCamera(50, width / height, 0.1, 200)
  camera.position.set(20, 15, 30)

  renderer = new THREE.WebGLRenderer({
    canvas: canvasRef.value,
    antialias: false,
    powerPreference: "high-performance",
    alpha: true
  })
  renderer.setSize(width, height)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
  renderer.toneMapping = THREE.ACESFilmicToneMapping
  renderer.toneMappingExposure = 1.2

  const renderScene = new RenderPass(scene, camera)
  const bloomPass = new UnrealBloomPass(new THREE.Vector2(width, height), 1.5, 0.4, 0.85)
  bloomPass.threshold = 0.1
  bloomPass.strength = 1.0
  bloomPass.radius = 0.5

  composer = new EffectComposer(renderer)
  composer.addPass(renderScene)
  composer.addPass(bloomPass)

  controls = new OrbitControls(camera, containerRef.value)
  controls.enableDamping = true
  controls.dampingFactor = 0.05
  controls.enableRotate = true
  controls.enableZoom = true
  controls.rotateSpeed = 0.5
  controls.zoomSpeed = 0.8
  controls.autoRotate = true
  controls.autoRotateSpeed = 0.1
  controls.minDistance = 15
  controls.maxDistance = 70
  controls.enablePan = false

  labelRenderer = new CSS2DRenderer()
  labelRenderer.setSize(width, height)
  labelRenderer.domElement.style.position = 'absolute'
  labelRenderer.domElement.style.top = '0'
  labelRenderer.domElement.style.left = '0'
  labelRenderer.domElement.style.pointerEvents = 'none'
  containerRef.value.appendChild(labelRenderer.domElement)

  const ambientLight = new THREE.AmbientLight(0x334466, 2.0)
  scene.add(ambientLight)

  const sunLight = new THREE.DirectionalLight(0xffffff, 3.0)
  sunLight.position.set(50, 20, 30)
  scene.add(sunLight)

  createEarth()
  createStarfield()

  isLoading.value = false
  animate()
  
  startDemoLoop()
  
  window.addEventListener('resize', handleResize)
}

function createEarth() {
  earthGroup = new THREE.Group()
  scene.add(earthGroup)

  // Texture Loader
  const textureLoader = new THREE.TextureLoader()
  const mapTexture = textureLoader.load('/images/world_map_blank.svg')
  mapTexture.colorSpace = THREE.SRGBColorSpace

  // Earth Sphere with texture
  const geometry = new THREE.SphereGeometry(EARTH_RADIUS, 64, 64)
  const material = new THREE.MeshBasicMaterial({
    map: mapTexture,
    transparent: true,
    opacity: 0.4,
    color: 0x88ccff
  })
  
  earthMesh = new THREE.Mesh(geometry, material)
  earthGroup.add(earthMesh)

  // Atmosphere Glow
  const atmoGeo = new THREE.SphereGeometry(EARTH_RADIUS + 0.5, 64, 64)
  const atmoMat = new THREE.MeshPhongMaterial({
    color: 0x00aaff,
    transparent: true,
    opacity: 0.15,
    side: THREE.BackSide,
    blending: THREE.AdditiveBlending
  })
  atmosphereMesh = new THREE.Mesh(atmoGeo, atmoMat)
  earthGroup.add(atmosphereMesh)
  
  // Mark Taiwan Location (Target)
  const taiwanPos = latLonToVector3(TAIWAN_COORDS.lat, TAIWAN_COORDS.lon, EARTH_RADIUS)
  const markerGeo = new THREE.RingGeometry(0.2, 0.4, 32)
  const markerMat = new THREE.MeshBasicMaterial({ color: 0x00ff88, side: THREE.DoubleSide })
  const marker = new THREE.Mesh(markerGeo, markerMat)
  marker.position.copy(taiwanPos)
  marker.lookAt(new THREE.Vector3(0,0,0))
  marker.position.multiplyScalar(1.01)
  earthGroup.add(marker)
}

function createStarfield() {
  const starsGeo = new THREE.BufferGeometry()
  const starsCount = 2000
  const posArray = new Float32Array(starsCount * 3)
  
  for(let i=0; i<starsCount*3; i++) {
    posArray[i] = (Math.random() - 0.5) * 200
  }
  
  starsGeo.setAttribute('position', new THREE.BufferAttribute(posArray, 3))
  const starsMat = new THREE.PointsMaterial({ 
    size: 0.3, 
    color: 0xffffff, 
    transparent: true, 
    opacity: 0.8 
  })
  const starMesh = new THREE.Points(starsGeo, starsMat)
  scene.add(starMesh)
}

function latLonToVector3(lat, lon, radius) {
  const adjustedLon = lon + LON_OFFSET
  const phi = (90 - lat) * (Math.PI / 180)
  const theta = (adjustedLon + 180) * (Math.PI / 180)
  
  const x = -radius * Math.sin(phi) * Math.cos(theta)
  const y = radius * Math.cos(phi)
  const z = radius * Math.sin(phi) * Math.sin(theta)
  
  return new THREE.Vector3(x, y, z)
}

function spawnPacket(type, lat = null, lon = null) {
  const isAttack = type === 'attack'
  const color = isAttack ? ATTACK_COLOR : SAFE_COLOR
  
  const startLat = lat !== null ? lat : (Math.random() - 0.5) * 160
  const startLon = lon !== null ? lon : (Math.random() - 0.5) * 360
  
  const startPos = latLonToVector3(startLat, startLon, EARTH_RADIUS)
  const targetPos = latLonToVector3(TAIWAN_COORDS.lat, TAIWAN_COORDS.lon, EARTH_RADIUS)
  
  const midPos = startPos.clone().add(targetPos).multiplyScalar(0.5).normalize().multiplyScalar(EARTH_RADIUS + 5 + Math.random() * 5)
  
  const curve = new THREE.QuadraticBezierCurve3(startPos, midPos, targetPos)
  const points = curve.getPoints(30)
  const geometry = new THREE.BufferGeometry().setFromPoints(points)
  
  const material = new THREE.LineBasicMaterial({ 
    color: color, 
    transparent: true, 
    opacity: 0.3 
  })
  const trail = new THREE.Line(geometry, material)
  
  const packetGeo = new THREE.SphereGeometry(isAttack ? 0.25 : 0.2, 8, 8)
  const packetMat = new THREE.MeshBasicMaterial({ color: color })
  const packetMesh = new THREE.Mesh(packetGeo, packetMat)
  
  earthGroup.add(trail)
  earthGroup.add(packetMesh)
  
  particles.push({
    mesh: packetMesh,
    trail: trail,
    curve: curve,
    progress: 0,
    speed: 0.01 + Math.random() * 0.015,
    type: type
  })
}

function updateParticles() {
  for (let i = particles.length - 1; i >= 0; i--) {
    const p = particles[i]
    p.progress += p.speed
    
    if (p.progress >= 1) {
      createImpact(p.curve.getPoint(1), p.type === 'attack' ? ATTACK_COLOR : SAFE_COLOR)
      
      earthGroup.remove(p.mesh)
      earthGroup.remove(p.trail)
      p.mesh.geometry.dispose()
      p.trail.geometry.dispose()
      particles.splice(i, 1)
      continue
    }
    
    const pos = p.curve.getPoint(p.progress)
    p.mesh.position.copy(pos)
  }
}

let impactList = []

function createImpact(pos, color) {
  const geometry = new THREE.RingGeometry(0.1, 0.3, 16)
  const normal = pos.clone().normalize()
  
  const material = new THREE.MeshBasicMaterial({ 
    color: color, 
    transparent: true, 
    opacity: 1.0, 
    side: THREE.DoubleSide 
  })
  const mesh = new THREE.Mesh(geometry, material)
  mesh.position.copy(pos)
  mesh.lookAt(pos.clone().add(normal)) 
  mesh.position.add(normal.multiplyScalar(0.05))
  
  earthGroup.add(mesh)
  impactList.push({ mesh, age: 0 })
}

function updateImpacts() {
  for(let i = impactList.length - 1; i >= 0; i--) {
    const imp = impactList[i]
    imp.age += 0.05
    imp.mesh.scale.setScalar(1 + imp.age * 8)
    imp.mesh.material.opacity = 1 - imp.age
    
    if (imp.age >= 1) {
      earthGroup.remove(imp.mesh)
      imp.mesh.geometry.dispose()
      imp.mesh.material.dispose()
      impactList.splice(i, 1)
    }
  }
}

// Demo data for marketing page
const demoAttacks = [
  { lat: 39.9, lon: 116.4, blocked: true, country: 'CN' },
  { lat: 37.5, lon: 127.0, blocked: false, country: 'KR' },
  { lat: 35.7, lon: 139.7, blocked: false, country: 'JP' },
  { lat: 55.7, lon: 37.6, blocked: true, country: 'RU' },
  { lat: 40.7, lon: -74.0, blocked: false, country: 'US' },
  { lat: 51.5, lon: -0.1, blocked: false, country: 'UK' },
  { lat: -33.9, lon: 151.2, blocked: false, country: 'AU' },
  { lat: 1.3, lon: 103.8, blocked: true, country: 'SG' },
  { lat: 52.5, lon: 13.4, blocked: true, country: 'DE' },
  { lat: 48.9, lon: 2.3, blocked: false, country: 'FR' },
]

let demoIndex = 0
let demoTimeoutId = null

function startDemoLoop() {
  const spawnNext = () => {
    const attack = demoAttacks[demoIndex]
    const type = attack.blocked ? 'attack' : 'safe'
    spawnPacket(type, attack.lat, attack.lon)
    
    // Also spawn random safe traffic
    if (Math.random() > 0.4) {
      spawnPacket('safe')
    }
    
    demoIndex = (demoIndex + 1) % demoAttacks.length
    
    const delay = 500 + Math.random() * 700
    demoTimeoutId = setTimeout(spawnNext, delay)
  }
  
  setTimeout(spawnNext, 1500)
}

function animate() {
  animationFrameId = requestAnimationFrame(animate)

  if (earthGroup) {
    earthGroup.rotation.y += 0.001
  }

  updateParticles()
  updateImpacts()
  controls.update()
  composer.render()
  labelRenderer.render(scene, camera)
}

function handleResize() {
  if (!containerRef.value) return
  const width = containerRef.value.clientWidth
  const height = containerRef.value.clientHeight
  camera.aspect = width / height
  camera.updateProjectionMatrix()
  renderer.setSize(width, height)
  composer.setSize(width, height)
  labelRenderer.setSize(width, height)
}

function cleanup() {
  cancelAnimationFrame(animationFrameId)
  if (demoTimeoutId) clearTimeout(demoTimeoutId)
  if (pollInterval) clearInterval(pollInterval)
  window.removeEventListener('resize', handleResize)
  if (renderer) renderer.dispose()
  if (composer) composer.dispose()
  if (scene) {
    scene.traverse(obj => {
      if (obj.geometry) obj.geometry.dispose()
      if (obj.material) {
        if (Array.isArray(obj.material)) obj.material.forEach(m => m.dispose())
        else obj.material.dispose()
      }
    })
  }
}

onMounted(() => { setTimeout(initScene, 100) })
onUnmounted(cleanup)
</script>

<style scoped>
@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

@keyframes ping {
  75%, 100% {
    transform: scale(2);
    opacity: 0;
  }
}

@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.5; }
}
</style>

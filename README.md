# SpaceInvadersSaver (macOS Sonoma)

ScreenSaver (.saver) para macOS que carga tu proyecto **Space Invaders** (HTML/JS/CSS, imágenes o video) dentro de un `WKWebView`. Compila con **GitHub Actions** y funciona en **macOS Sonoma**.

---

## 🚀 Cómo usar (paso a paso)

### 0) Requisitos locales (opcional)
- Si querés compilar en tu Mac: **Xcode 15+** (Sonoma), **XcodeGen** (`brew install xcodegen`).  
  *No es obligatorio si solo vas a compilar en GitHub.*

### 1) Crear el repositorio en GitHub
1. Creá un repo vacío (público o privado).
2. Descargá este ZIP y descomprimilo. Vas a ver esta estructura:
   ```
   SpaceInvadersSaver/
   ├─ project.yml
   ├─ Info.plist
   ├─ Sources/
   │  └─ SpaceInvadersSaverView.swift
   ├─ Resources/
   │  └─ web/   ← acá va tu juego (index.html, js, assets)
   └─ .github/workflows/build.yml
   ```
3. Copiá **todo** el contenido a tu repo.

### 2) Poner tu juego dentro del protector de pantalla
- Ya dejé tu ZIP descomprimido en `Resources/web`. Asegurate de que exista **`Resources/web/index.html`**.
- Tu HTML/JS/CSS se abrirá a pantalla completa dentro del ScreenSaver. Si tu juego era un video, ponelo también en `Resources/web` y referencialo desde `index.html`.

### 3) Compilar en GitHub (CI/CD)
1. Commit y push a la rama **main**.
2. GitHub Actions ejecutará el workflow **build-and-release** (archivo `.github/workflows/build.yml`):
   - Instala **XcodeGen**.
   - Genera el proyecto Xcode desde `project.yml`.
   - Compila el **.saver** en Release.
   - Te deja un **artifact** descargable llamado `SpaceInvadersSaver.zip` con el `.saver` adentro.
3. Si creás un **tag** (por ejemplo `v1.0.0`), además te publica un **Release** con el ZIP.

### 4) Instalar el .saver en tu Mac
- Descargá `SpaceInvadersSaver.zip` del artifact o de Releases y abrilo.
- Hacé doble clic en `SpaceInvadersSaver.saver` o movelo a:
  - `~/Library/Screen Savers` (solo tu usuario), o
  - `/Library/Screen Savers` (todos los usuarios, requiere admin).
- Abrí **Ajustes del Sistema → Fondo de pantalla y salvapantallas** y elegilo.
- Si macOS te muestra advertencia por desarrollador no identificado, andá a **Privacidad y Seguridad → Abrir de todos modos**.

### 5) Compilar localmente (opcional)
```bash
brew install xcodegen
xcodegen generate
xcodebuild -project SpaceInvadersSaver.xcodeproj -scheme SpaceInvadersSaver -configuration Release -derivedDataPath build CODE_SIGNING_ALLOWED=NO CODE_SIGNING_REQUIRED=NO CODE_SIGN_IDENTITY="" build
open build/Build/Products/Release
```

El resultado es `SpaceInvadersSaver.saver` dentro de `build/Build/Products/Release`.

---

## 🛠️ Personalización útil
- Cambiá el **bundle id** en `project.yml` e `Info.plist` (`com.drhugodabien.SpaceInvadersSaver`).
- Si tu HTML principal no se llama `index.html` o está en otra carpeta, ajustá la lógica en `SpaceInvadersSaverView.swift` o renombrá tus archivos.
- Para silenciar cualquier audio, controlalo desde tu `index.html`.

---

## ❓ Preguntas frecuentes
- **¿Hace falta firmar o notarizar?** No para uso personal. Para distribución amplia, conviene firmar y notarizar.
- **¿Se puede configurar?** Este ejemplo no tiene hoja de configuración. Podés agregarla con `hasConfigureSheet = true`.
- **¿Sirve para juegos WebGL/Canvas?** Sí, cargan en `WKWebView`. Evitá recursos remotos que pidan permisos especiales.

---

Hecho con cariño para que subas tu invencible Space Invaders a toda la Universidad 😉.

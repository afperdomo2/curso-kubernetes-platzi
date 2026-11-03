# Entornos del curso

Referencia de la skill `mejorar-clase`. El curso se practicó en **dos** entornos distintos. No son intercambiables: si un paso es exclusivo de uno, hay que decirlo y dar el equivalente.

| | 🐳 **minikube** (Ubuntu) — actual | 🖥️ **Docker Desktop** (Windows 11) — histórico |
|---|---|---|
| Naturaleza | VM/contenedor aparte, gestionado con `minikube` | Clúster integrado en Docker Desktop |
| Crear | `minikube start --driver=docker` | Ajustes → *Kubernetes* → *Enable Kubernetes* |
| Contexto | `minikube` | `docker-desktop` |
| Runtime del nodo | containerd | containerd (comparte almacén con el Docker del host) |
| Imágenes locales | `minikube image build -t x ./x` | `docker build -t x ./x` |
| metrics-server | `minikube addons enable metrics-server` | **no viene**: `kubectl apply -f …/metrics-server/…/components.yaml` |
| Ingress controller | `minikube addons enable ingress` | instalación manual (ingress-nginx) |
| Ver un Service | `minikube service <svc>` / `minikube tunnel` | `http://localhost:<puerto>` directo |
| Dashboard | `minikube dashboard` | UI de Docker Desktop / `kubectl proxy` |
| Entrar al nodo | `minikube ssh` | no hay `minikube`; el nodo lo gestiona Docker Desktop |
| Nodos extra | `minikube node add` | no aplica |

## Reglas para documentar

1. **Marca siempre lo exclusivo de minikube**: `minikube addons`, `minikube image build`, `minikube ssh`, `minikube service`, `minikube dashboard`, `minikube tunnel`.
2. Para cualquier paso con diferencia, usa el patrón **Ruta A / Ruta B**:
   - **Ruta A — minikube (Ubuntu)**: comandos + verificación (`minikube image ls`, `kubectl get pods`).
   - **Ruta B — Docker Desktop (Windows 11)**: comandos + verificación (`docker images`, `kubectl get pods`).
3. Cada ruta termina en un comando que **confirma** que el paso funcionó.
4. Si el usuario sigue en el repo antiguo de Windows, recuérdale que su clúster es `docker-desktop`: `kubectl config current-context`.

## Por qué existe la diferencia de imágenes (el error más repetido)

En minikube, `docker build` / `docker compose build` construyen en el Docker del **host**, y el nodo (containerd) no los ve → `ErrImagePull` / `ImagePullBackOff` con `imagePullPolicy: Never`.
En Docker Desktop, el clúster sí comparte el almacén, así que `docker build` funciona.

Consecuencia para el módulo de escalado: **sin Pods no hay métricas**, y el HPA muestra `TARGETS: <unknown>`. El error de imágenes se disfraza de "el HPA está roto".

Después de reconstruir una imagen con el mismo tag:

```bash
kubectl rollout restart deploy/<nombre>-deployment
```

## Tabla de síntomas por entorno

| Síntoma | Entorno | Causa / salida |
|---------|---------|----------------|
| `connection refused` a `127.0.0.1:<puerto alto>` | minikube | `DOCKER_HOST` viejo de `docker-env`; abrir terminal nueva y usar `minikube image build` |
| `booting buildkit` → `404 page not found` | minikube (containerd) | `docker-env` es experimental; usar `minikube image build` |
| `ErrImagePull` tras `docker compose build` | minikube | la imagen no está en el nodo |
| `EXTERNAL-IP: <pending>` | minikube | `minikube tunnel` o `minikube service` |
| `minikube: command not found` | Windows | ese flujo no aplica; usar `kubectl` + `docker build` |
| `TARGETS: <unknown>` | ambos | metrics-server ausente o sin muestras (1–3 min) |

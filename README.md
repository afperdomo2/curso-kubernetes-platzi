# 🚢 Curso de Kubernetes (Platzi)

> Aprendizaje práctico de Kubernetes desde cero: conceptos, arquitectura, clúster local con **minikube** y uso de **kubectl**.

![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnubash&logoColor=white)
![Platzi](https://img.shields.io/badge/Platzi-8BC84B?style=for-the-badge)

---

## 📖 Sobre este repositorio

Notas y prácticas del curso de **Kubernetes** de Platzi. El contenido está organizado por módulos, cada uno con su propia carpeta y documentación.

## 🗺️ Mapa del curso

| # | Módulo | Descripción | Enlace |
|---:|--------|-------------|:------:|
| 01 | Introducción a Kubernetes | Qué es, problemas que resuelve, beneficios y conceptos clave | [🔗](01-intro-k8s/README.md) |
| 02 | Clúster local | Instalación de minikube/kubectl y creación de un clúster local | [🔗](02-local-cluster/README.md) |
| 03 | Arquitectura | Componentes del plano de control y de los nodos de trabajo | [🔗](03-architecture/README.md) |
| 04 | kubectl y la API | API REST de Kubernetes, CRUD de recursos, YAML y namespaces | [🔗](04-kubectl-api/README.md) |
| 05 | Declarativo vs Imperativo | Manifiestos YAML vs comandos directos, GitOps y buenas prácticas | [🔗](05-declarative-vs-imperative/README.md) |
| 06 | Pods, ReplicaSets y Deployments | La jerarquía de recursos: Pods, escalado, rolling updates y rollback | [🔗](06-pods-replicasets-deployments/README.md) |
| 07 | Services e Ingress | Exponer apps: Services (ClusterIP/NodePort/LB) y enrutamiento con Ingress | [🔗](07-service-ingress/README.md) |
| 08 | ConfigMaps y Secrets | Configuración y datos sensibles inyectados a los contenedores | [🔗](08-configs-secrets/README.md) |
| 09 | Networking | Modelo de red de K8s: CNI, kube-proxy, DNS interno y NetworkPolicies | [🔗](09-networking/README.md) |
| 10 | Tipos de Services | ClusterIP, NodePort, LoadBalancer y ExternalName en detalle | [🔗](10-services-clusterip-nodeport-loadbalancer/README.md) |

## 🧩 Estructura del proyecto

```
📦 curso-kubernetes-platzi
├── 📁 01-intro-k8s/          # 🐳 Introducción a Kubernetes
├── 📁 02-local-cluster/      # 🖥️ Clúster local con minikube
├── 📁 03-architecture/       # 🏛️ Arquitectura del clúster
├── 📁 04-kubectl-api/        # 🛠️ kubectl y la API de Kubernetes
│   ├── 📄 simple-pod.yml     #   Pod de ejemplo (nginx)
├── 📁 05-declarative-vs-imperative/  # ⚖️ Declarativo vs Imperativo
│   ├── 📄 mypod.yml                   #   Pod de ejemplo
├── 📁 06-pods-replicasets-deployments/  # 📦 Pods, ReplicaSets y Deployments
│   ├── 📄 replicaset.yml                 #   ReplicaSet de nginx (3 réplicas)
│   ├── 📄 deployment.yml                 #   Deployment hello-app (4 réplicas)
├── 📁 07-service-ingress/               # 🌐 Services e Ingress
├── 📁 08-configs-secrets/               # 🗂️ ConfigMaps y Secrets
│   ├── 📄 auth-config.yml               #   ConfigMap (url de auth)
│   ├── 📄 auth-secret.yml               #   Secret (client_id/client_secret)
├── 📁 09-networking/                    # 🌐 Networking
├── 📁 10-services-clusterip-nodeport-loadbalancer/  # 🔀 Tipos de Services
│   ├── 📄 deployment-clusterip.yaml              #   Deployment + Service ClusterIP
│   ├── 📄 deployment-nodeport.yaml               #   Deployment + Service NodePort
│   ├── 📄 deployment-loadbalancer.yaml           #   Deployment + Service LoadBalancer
│   ├── 📄 externalname.yaml                      #   Service ExternalName (alias DNS)
└── 📄 README.md                       # 📘 Este archivo
```

## 🧰 Herramientas necesarias

| Herramienta | Para qué se usa |
|-------------|-----------------|
| [minikube](https://minikube.sigs.k8s.io/docs/) | Clúster de Kubernetes local (single o multi-nodo) |
| [kubectl](https://kubernetes.io/es/docs/reference/kubectl/) | CLI oficial para interactuar con el clúster |
| [Docker](https://www.docker.com/) | Driver de contenedores para minikube y delivery de imágenes |

## ⚡ Mini cheat-sheet

```bash
# ── Información del clúster ──
kubectl cluster-info
kubectl config get-contexts
kubectl config use-context <context-name>

# ── Imperativo: acciones al momento ──
kubectl run mypod --image=nginx
kubectl delete pod mypod

# ── Declarativo: manifiestos YAML ──
kubectl apply -f mypod.yml
kubectl diff -f mypod.yml       # qué cambiaría (sin aplicar)
kubectl delete -f mypod.yml

# ── Consultar recursos ──
kubectl get pods
kubectl get pods -n my-namespace
kubectl describe pod <nombre>

# ── Namespaces ──
kubectl create namespace mi-equipo
```

> 💡 **Nota:** Los comandos de este curso se ejecutan desde **Bash** (Git Bash / WSL / Linux). Ajusta la sintaxis si trabajas con PowerShell.

## 📚 Recursos oficiales

- [Documentación de Kubernetes](https://kubernetes.io/es/docs/)
- [Documentación de kubectl](https://kubernetes.io/docs/reference/kubectl/)
- [Documentación de minikube](https://minikube.sigs.k8s.io/docs/)
- [Curso de Kubernetes - Platzi](https://platzi.com/cursos/kubernetes/)

---

🧠 *Hecho con ♥ mientras curso Kubernetes en Platzi.*
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

## 🧩 Estructura del proyecto

```
📦 curso-kubernetes-platzi
├── 📁 01-intro-k8s/          # 🐳 Introducción a Kubernetes
├── 📁 02-local-cluster/      # 🖥️ Clúster local con minikube
├── 📁 03-architecture/       # 🏛️ Arquitectura del clúster
├── 📁 04-kubectl-api/        # 🛠️ kubectl y la API de Kubernetes
│   ├── 📄 simple-pod.yml     #   Pod de ejemplo (nginx)
├── 📁 05-declarative/        # ⚖️ Declarativo vs Imperativo
│   ├── 📄 mypod.yml          #   Pod de ejemplo
└── 📄 README.md              # 📘 Este archivo
```

## 🧰 Herramientas necesarias

| Herramienta | Para qué se usa |
|-------------|-----------------|
| [minikube](https://minikube.sigs.k8s.io/docs/) | Clúster de Kubernetes local (single o multi-nodo) |
| [kubectl](https://kubernetes.io/es/docs/reference/kubectl/) | CLI oficial para interactuar con el clúster |
| [Docker](https://www.docker.com/) | Driver de contenedores para minikube y delivery de imágenes |

## ⚡ Mini cheat-sheet

```bash
# Ver información del clúster y contextos
kubectl cluster-info
kubectl config get-contexts

# Consultar recursos
kubectl get pods

# Crear / modificar recursos desde YAML
kubectl apply -f simple-pod.yml

# Eliminar recursos
kubectl delete pod lonely-pod
```

> 💡 **Nota:** Los comandos de este curso se ejecutan desde **Bash** (Git Bash / WSL / Linux). Ajusta la sintaxis si trabajas con PowerShell.

## 📚 Recursos oficiales

- [Documentación de Kubernetes](https://kubernetes.io/es/docs/)
- [Documentación de kubectl](https://kubernetes.io/docs/reference/kubectl/)
- [Documentación de minikube](https://minikube.sigs.k8s.io/docs/)
- [Curso de Kubernetes - Platzi](https://platzi.com/cursos/kubernetes/)

---

🧠 *Hecho con ♥ mientras curso Kubernetes en Platzi.*
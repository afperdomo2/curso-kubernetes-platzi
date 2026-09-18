# 🏛️ Arquitectura de Kubernetes

> Un clúster de Kubernetes se divide en dos grandes planos: el **Control Plane** (el "cerebro") y los **Nodos de trabajo** (el "músculo"). Todo se coordina para que el clúster converja al estado deseado.

## 🧠 Vista general

```mermaid
flowchart TB
    subgraph CP["👑 Control Plane"]
        API["🕹️ kube-apiserver"]:::main
        ETCD["💾 etcd"]
        SCD["🗓️ kube-scheduler"]
        CMC["⚙️ kube-controller-manager"]
        CCM["☁️ cloud-controller-manager"]
        API <--> ETCD
        API <--> SCD
        API <--> CMC
        API -.-> CCM
    end

    subgraph N1["🔹 Nodo 1"]
        direction TB
        K1["🔌 kubelet"]
        KX1["🔀 kube-proxy"]
        R1["🐳 Container runtime"]
        K1 --- R1
        K1 --- KX1
    end

    subgraph N2["🔹 Nodo 2"]
        direction TB
        K2["🔌 kubelet"]
        KX2["🔀 kube-proxy"]
        R2["🐳 Container runtime"]
        K2 --- R2
        K2 --- KX2
    end

    USER["🧑‍💻 kubectl"] -->|"HTTPS / API REST"| API
    API --> K1
    API --> K2

    classDef main fill:#f9f,stroke:#333,stroke-width:2px
```

> 🔑 **Regla de oro**: todos los componentes se comunican únicamente con el **kube-apiserver**. Los nodos **nunca** hablan directo con etcd, ni el scheduler con el kubelet.

## 👑 Plano de control (Control Plane)

| Componente | Función |
|------------|---------|
| 🕹️ **kube-apiserver** | Puerta de entrada del clúster. Expone la API REST, valida y administra los recursos. El único componente con el que interactúan kubectl y el resto. |
| 💾 **etcd** | Base de datos **clave-valor** donde se guarda todo el estado del clúster (la única fuente de verdad). |
| 🗓️ **kube-scheduler** | Decide **en qué nodo** se ejecuta cada pod nuevo según recursos, afinidades y restricciones. |
| ⚙️ **kube-controller-manager** | Ejecuta los *controladores*: vigila el estado real y lo ajusta al deseado (replica pods, detecta nodos caídos, gestiona endpoints...). |
| ☁️ **cloud-controller-manager** *(opcional)* | Integra APIs de nube (AWS, GCP, Azure): balanceadores, volúmenes y nodos gestionados. No aplica en minikube. |

## 🔹 Plano de datos (Nodos de trabajo)

| Componente | Función |
|------------|---------|
| 🔌 **kubelet** | Agente que corre en cada nodo. Arranca, supervisa y reporta el estado de los pods y contenedores. |
| 🔀 **kube-proxy** | Mantiene las reglas de red y el balanceo de carga hacia los pods (iptables/ipvs). |
| 🐳 **Container runtime** | Software que ejecuta contenedores (containerd, CRI-O, Docker). |

## ➕ Add-ons (complementos)

| Add-on | Función |
|--------|---------|
| 🌐 **CoreDNS** | Resolución de nombres dentro del clúster (los Services se descubren por DNS). |
| 📊 **metrics-server** | Recolecta métricas de CPU/memoria (base del autoescalado). |
| 🖥️ **Dashboard** | UI web para administrar el clúster. |

## 🔄 Flujo al crear un pod: declarativo

Cuando ejecutas `kubectl apply -f pod.yml`, ocurre lo siguiente:

```mermaid
sequenceDiagram
    participant kubectl as 🧑‍💻 kubectl
    participant api as 🕹️ kube-apiserver
    participant etcd as 💾 etcd
    participant sched as 🗓️ kube-scheduler
    participant kubelet as 🔌 kubelet

    kubectl->>api: POST /api/v1/namespaces/default/pods
    api->>etcd: Persiste el estado deseado
    api-->>sched: Avisa: hay un pod sin nodo asignado
    sched-->>api: Responde: "ejecútalo en el Nodo 2"
    api->>kubelet: Ordena crear el contenedor
    kubelet-->>api: Reporta estado "Running ✅"
```

## 🧠 Ideas clave

- **Declarativo**: declaras el *estado deseado* (ej. 3 réplicas) y Kubernetes converge hacia él continuamente.
- **Self-healing**: si un pod muere o un nodo cae, el *controller-manager* re-crea lo necesario en otro nodo.
- **API central**: todo pasa por `kube-apiserver`; etcd es solo lectura/escritura desde ahí.

## 🧭 Siguiente paso

- 🛠️ [kubectl y la API de Kubernetes](../04-kubectl-api/README.md)

---

🧠 *Resumen del módulo "Arquitectura" del curso de Platzi.*
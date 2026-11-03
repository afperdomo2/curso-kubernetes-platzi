# Comentar los YAML

Referencia de la skill `mejorar-clase`. Los manifiestos del curso son material de estudio: los comentarios explican **qué hace cada campo y por qué está ahí**, sin cambiar la semántica.

## Reglas

1. **No cambiar el valor de ningún campo.** Solo añadir comentarios.
2. Comentar en **español**.
3. Cabecera de bloque al inicio de cada archivo (ver plantilla).
4. Comentario **en línea** en los campos que no son obvios: `replicas`, `resources`, `imagePullPolicy`, `selector`, `hostPath`, `schedule`, `averageUtilization`, `updateMode`…
5. Si un campo es obligatorio para que algo funcione, dilo: `# ⚠️ Obligatorio para el HPA: es la base del %`.
6. Si el comando de construcción depende del entorno, documéntalo en el propio comentario (minikube vs Docker Desktop).
7. Si el archivo tiene varios documentos (`---`), separa con un comentario de qué es cada uno.
8. Verifica que sigue parseando: `python3 -c "import yaml,sys; list(yaml.safe_load_all(open(sys.argv[1])))" archivo.yaml`.

## Plantilla

```yaml
# =============================================================================
# KIND · Para qué sirve este recurso en el módulo
# -----------------------------------------------------------------------------
# Qué crea:
#   · Recurso A → detalle
#   · Recurso B → detalle
#
# Lo que hay que saber antes de aplicarlo:
#   · Requisito previo (PVC, CRD, addon, imagen construida…)
#   · Comando de construcción si depende del entorno
#
#   kubectl apply -f archivo.yaml
#   kubectl get <recurso> <nombre>
# =============================================================================
apiVersion: ...
kind: ...
metadata:
  name: ...                # nombre que referencian otros recursos
spec:
  campo: valor             # por qué ese valor y qué pasa si se cambia
```

## Ejemplos reales del curso

### Cabecera con dependencia de entorno

```yaml
# ⚠️ La imagen se construye en local y NO está en ningún registry:
#   minikube (Ubuntu):      minikube image build -t backend:latest  ./backend
#   Docker Desktop (Win11): docker build -t backend:latest ./backend
# Por eso imagePullPolicy: Never → nunca intenta descargarla de Docker Hub.
```

### Comentario que explica el "por qué" del valor

```yaml
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization          # % medio sobre requests.cpu, no sobre el nodo
        averageUtilization: 80     # 80 % de 50m ≈ 40m por Pod
```

### Aviso dentro del manifiesto

```yaml
# ⚠️ No lo apliques a la vez que my-hpa sobre el MISMO Deployment:
#    el HPA sube réplicas y el VPA sube requests, y se pelean.
```

## Errores que hay que evitar

| Error | Por qué |
|-------|---------|
| Cambiar un valor "para que sea más realista" | El manifiesto es el que usa el curso; si cambia, la doc miente |
| Comentar solo la cabecera | El valor educativo está en los campos (`resources`, `selector`, `hostPath`) |
| Repetir el nombre del campo con otras palabras | `replicas: 2  # dos réplicas` no aporta; explica la consecuencia |
| Dejar un `---` final huérfano | Rompe la lectura y algunos linters |
| Comentar sintaxis obsoleta (`autoscaling/v1`) | Si el campo es antiguo, mígralo o documéntalo como deuda |

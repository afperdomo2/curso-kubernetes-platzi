---
name: Mejorar clase (documentación)
description: Mejora la documentación de una clase/módulo del curso de Kubernetes (READMEs, comentarios de YAML, secciones, tablas, diagramas y troubleshooting) sin ejecutar nada contra el clúster. Úsala cuando el usuario pida "mejora la clase N", "documenta el módulo", "comenta los yaml", "agrega secciones" o "revisa la documentación".
---

# Mejorar la documentación de una clase

Esta skill existe para un solo tipo de trabajo: **dejar un módulo del curso bien documentado**.
No es una skill para ejecutar laboratorios ni para "probar que funciona".

## ⛔ Regla de oro: documentación, no ejecución

Prohibido usar el clúster o el motor de contenedores:

- ❌ `kubectl` (apply, get, describe, rollout, run, top…)
- ❌ `minikube` (start, addons, image build, ssh, service, tunnel)
- ❌ `docker` / `docker compose` (build, run, compose up)
- ❌ generar carga, escalar, desplegar, habilitar addons

Permitido (todo local, sin efectos):

- ✅ leer archivos, `grep`, `diff`, `wc`, `ls`, `find`
- ✅ `python3 -c "import yaml; ..."` para validar que un YAML parsea
- ✅ `bash scripts/verificar-docs.sh` (esta misma skill)

> Si de verdad hace falta verificar algo en vivo, **pregunta primero** y explica qué vas a ejecutar y por qué. Por defecto: no.
>
> Motivo: en módulos anteriores se desplegaron recursos, se habilitó un addon y se generó carga por "verificar"; eso cambió el entorno de estudio del usuario sin que lo pidiera. La documentación se escribe con lo que dicen los manifiestos y la documentación oficial, no con un laboratorio.

## 🧭 Cuándo usarla

- "mejora la documentación de la clase 15"
- "documenta este módulo", "comenta los yaml", "agrega secciones"
- "revisa si está documentado X en la clase N"

Si el usuario pide **ejecutar** el módulo o probarlo, esta skill no aplica: avísale.

## 🔄 Flujo de trabajo

1. **Leer `AGENTS.md`** (convenciones del repo) y la skill `entornos`.
2. **Reconocimiento** de la carpeta del módulo:
   - `README.md` (o READMEs, puede haber más de uno), todos los `*.yaml` y el código de apoyo.
   - Un módulo vecino ya documentado (13, 14, 15) como referencia de estilo.
   - El `README.md` raíz: ¿la fila y el árbol incluyen este módulo?
3. **Diagnóstico**: lista corta de huecos y errores reales. Busca en particular:
   - comandos que no existen o no funcionan (nombres de archivo equivocados, flags inventados),
   - pasos sin forma de comprobar el resultado,
   - comandos solo-minikube sin equivalente para Docker Desktop,
   - contradicciones entre README y YAML (nombres, puertos, rutas),
   - secciones duplicadas o de "historia del repo" que ya no aportan,
   - notas de PowerShell/Windows en un repo que hoy se practica en Ubuntu.
4. **Propuesta**: si el cambio es estructural (reescribir, borrar secciones), resume en 3–5 líneas qué vas a hacer y por qué antes de escribir.
5. **Escritura** siguiendo `estilo-readme` y `comentar-yaml`.
6. **Verificación** y **entrega** (abajo).

## 📄 Anatomía de un README de módulo

Orden recomendado (adaptar, no rellenar por rellenar):

```text
# 🎯 Título del módulo
> Blockquote: qué problema resuelve, en 2–3 líneas, y qué se va a practicar.

## 🗺️ Qué vas a construir          → diagrama Mermaid + 3–4 bullets
## 📁 Estructura / manifiestos     → tabla: archivo → qué crea
## ⚙️ Requisitos según entorno     → tabla minikube vs Docker Desktop
## 🚀 Paso 1..N                    → un H3 por paso
## 🧯 Troubleshooting              → tabla síntoma / causa / solución
## 🧹 Limpieza
## 🧭 Navegación                   → módulo anterior / inicio del curso
```

Reglas de contenido:

- **Cada paso se puede copiar y comprobar**: bloque `bash` + salida esperada (en bloque `text`) + "si falla, mira X".
- Las salidas de ejemplo se marcan como ejemplo, nunca se presentan como "verificado" si no lo están.
- Los pasos que dependen de un resultado previo lo dicen explícitamente ("requiere los Pods en `Running`").
- Explica **por qué** importa lo que se pide (p. ej. el porcentaje del HPA se calcula sobre `requests`).
- Documenta el error típico junto al paso donde ocurre y también en Troubleshooting.
- Nada de explicar "el comando malo" como sección: se documentan las rutas válidas (A/B) y el error va en Troubleshooting.
- Enlaza módulos relacionados con rutas relativas (`../13-multi-tier/README.md`), no con URLs absolutas.

## 🧾 YAML comentados

Cada manifiesto del módulo lleva cabecera y comentarios en línea: ver `comentar-yaml`.
Sin cambiar la semántica: los comentarios no deben alterar el recurso.

## 🖥️ Doble entorno

El curso se practicó en **Ubuntu + minikube** (actual) y en **Windows 11 + Kubernetes de Docker Desktop** (histórico, **no** es minikube).
Todo lo que sea exclusivo de minikube debe estar marcado y con equivalente: ver `entornos`.

## ✅ Verificación antes de entregar

```bash
bash .opencode/skills/mejorar-clase/scripts/verificar-docs.sh <carpeta-del-modulo>
```

Comprueba fences balanceados, Mermaid cerrado, links relativos existentes, YAML válidos y restos de PowerShell/ASCII art.
Además, a mano:

- ¿Se puede seguir el README de arriba a abajo sin adivinar?
- ¿Cada paso dice cómo verificar?
- ¿Hay alguna afirmación que no puedas respaldar con el manifiesto o la doc oficial? Bórrala o suavízala.
- ¿La tabla y el árbol del `README.md` raíz están al día?

## 📬 Entrega

Resume en la respuesta:

1. Qué archivos cambiaste y qué cambió en cada uno (tabla corta).
2. Qué **no** tocaste (código, manifiestos, otros módulos).
3. Verificación: qué ejecutaste del script y qué salió.
4. Pendientes/sugerencias que requieren decisión del usuario.

## 🚫 No hacer

- No tocar el código de la app ni la lógica de los manifiestos.
- No introducir tooling, CI, linters ni dependencias al repo.
- No escribir variantes PowerShell.
- No usar ASCII art para diagramas (solo Mermaid o tablas).
- No commitear sin que el usuario lo pida; si lo pide, solo lo que pidió.

#!/usr/bin/env bash
# Verificador estático de documentación (skill mejorar-clase).
#
# No toca el clúster ni el motor de contenedores: solo lee archivos.
#
# Uso:
#   bash verificar-docs.sh                # todo el repo
#   bash verificar-docs.sh 15-autoscaling-hpa-vpa
#
# Comprueba:
#   1. bloques de código balanceados  (```` ``` ````)
#   2. bloques ```mermaid cerrados
#   3. enlaces relativos que existan en disco
#   4. YAML que parseen
#   5. restos de PowerShell / ASCII art en los .md
#
# Salida: OK / ERROR por archivo. Código de salida 1 si hay errores.

set -uo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
cd "$repo_root" || exit 1

targets=("$@")
if [ ${#targets[@]} -eq 0 ]; then
  targets=(".")
fi

err=0
warn=0
files_md=()
files_yaml=()

while IFS= read -r f; do files_md+=("$f"); done < <(
  find "${targets[@]}" -type f -name '*.md' -not -path './.opencode/*' 2>/dev/null | sort
)
while IFS= read -r f; do files_yaml+=("$f"); done < <(
  find "${targets[@]}" -type f \( -name '*.yml' -o -name '*.yaml' \) 2>/dev/null | sort
)

fail() { printf '  ❌ %s\n' "$1"; err=$((err + 1)); }
note() { printf '  ⚠️  %s\n' "$1"; warn=$((warn + 1)); }

# --- 1 y 2: fences y mermaid ------------------------------------------------
for f in "${files_md[@]}"; do
  fences=$(grep -c '^```' "$f" || true)
  if (( fences % 2 != 0 )); then
    fail "$f: bloques de código desbalanceados ($fences marcas \`\`\`)"
  fi
  mermaid_open=$(grep -c '^```mermaid' "$f" || true)
  if (( mermaid_open > 0 )); then
    printf '  ✅ %-52s %s bloque(s) mermaid\n' "$f" "$mermaid_open"
  fi
done

# --- 3: enlaces relativos ---------------------------------------------------
for f in "${files_md[@]}"; do
  dir=$(dirname "$f")
  while IFS= read -r link; do
    [ -z "$link" ] && continue
    case "$link" in
      http*|mailto:*|'#'*) continue ;;
    esac
    path="${link%%#*}"
    [ -z "$path" ] && continue
    if [ ! -e "$dir/$path" ]; then
      fail "$f: enlace roto → $link"
    fi
  done < <(grep -oE '\]\([^)]+\)' "$f" | sed -e 's/^](//' -e 's/)$//' | sort -u)
done

# --- 4: YAML parsea ---------------------------------------------------------
for f in "${files_yaml[@]}"; do
  if command -v python3 >/dev/null 2>&1; then
    if ! python3 - "$f" <<'PY' >/dev/null 2>&1
import sys, yaml
with open(sys.argv[1]) as fh:
    list(yaml.safe_load_all(fh))
PY
    then
      fail "$f: no parsea como YAML"
    fi
  fi
done

# --- 5: restos de Windows / ASCII art --------------------------------------
for f in "${files_md[@]}"; do
  if grep -qiE 'powershell|invoke-expression' "$f"; then
    note "$f: menciona PowerShell (el repo se practica en Ubuntu; ¿es intencional?)"
  fi
  if grep -qE '^\s*\+-{2,}\+' "$f"; then
    note "$f: parece ASCII art (usar Mermaid o tabla)"
  fi
done

# --- resumen ---------------------------------------------------------------
echo
printf 'Revisados: %s .md, %s .yaml\n' "${#files_md[@]}" "${#files_yaml[@]}"
if (( err > 0 )); then
  printf 'Resultado: %s error(es), %s aviso(s)\n' "$err" "$warn"
  exit 1
fi
printf 'Resultado: OK (%s aviso(s))\n' "$warn"

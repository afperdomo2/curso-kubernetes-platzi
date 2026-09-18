# AGENTS.md

## Repo type

Study-notes repository for the Platzi Kubernetes course. **Docs only** — there is no source code, build, lint, or test pipeline to run. `git` is used just for versioning notes; no CI.

## Content conventions

- Write all documentation in **Spanish** (course and existing notes are Spanish).
- Course content lives in zero-padded numbered folders (`01-intro-k8s`, `02-local-cluster`, ...), one module per folder, each with its own `README.md`.
- Every module folder (`01`–`05`) has a filled `README.md`.
- The root `README.md` has a module map table — add a row there when a new module folder is created.
- YAML example files (e.g. `04-kubectl-api/simple-pod.yml`) may exist alongside a README; reference them from docs.
- Use **Mermaid** (` ```mermaid ` fenced blocks) for *all* diagrams — flowcharts, sequence diagrams, etc. Diagrams are **optional**: add them only when a visual adds real value to the doc (architecture, flows, relationships), not to every README.
- **Medium is a judgment call per doc**, not a fixed rule: a topic can be clear as a table, a code block, a Mermaid diagram, or a mix. Evaluate which combination communicates best and decide — some READMEs may have several diagrams, others none.
- Never use ASCII art or code fences for diagrams — plain text fences are only for commands/config examples.

## Commands in docs

- Shell snippets in the notes use **Bash** syntax (`eval $(minikube docker-env)`, `export`). The host is Windows; on PowerShell these snippets need conversion — never claim they run as-is in a Windows terminal.
- Any kubectl/minikube commands are informational documentation, not executed against a live cluster.

## Editing scope

- This repo is documentation-only; do not introduce build tooling, package manifests, or CI configs.
- When asked to "fill" a module README, match the documented style: emoji headers, tables, Mermaid diagrams, code blocks, links between modules.
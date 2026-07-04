#!/usr/bin/env bash
set -euo pipefail

workdir=$PWD
project_name=${PWD##*/}
session=${TMUX_SESSION:-latex-${project_name//[^[:alnum:]_-]/-}}
tex_file=${TEX_FILE:-}

if [[ -z "$tex_file" ]]; then
  if [[ -f report.tex ]]; then
    tex_file=report.tex
  else
    while IFS= read -r candidate; do
      if grep -q '\\documentclass' "$candidate"; then
        tex_file=$candidate
        break
      fi
    done < <(find . -maxdepth 1 -name '*.tex' -printf '%P\n' | sort)
  fi
fi

if [[ -z "$tex_file" || ! -f "$tex_file" ]]; then
  printf 'No main .tex file found. Set TEX_FILE=/path/to/file.tex and retry.\n' >&2
  exit 1
fi

pdf_file=${PDF_FILE:-build/${tex_file%.tex}.pdf}
printf -v watch_cmd 'mkdir -p build; evince %q >/dev/null 2>&1 & latexmk -pdf -pvc -interaction=nonstopmode -synctex=1 -outdir=build %q' "$pdf_file" "$tex_file"
printf -v editor_cmd 'nvim %q' "$tex_file"

if tmux has-session -t "$session" 2>/dev/null; then
  if [[ -n "${TMUX:-}" ]]; then
    tmux switch-client -t "$session"
  else
    tmux attach-session -t "$session"
  fi
  exit 0
fi

tmux new-session -d -s "$session" -c "$workdir" -n build
tmux send-keys -t "$session:build.0" "$watch_cmd" C-m
tmux new-window -t "$session" -c "$workdir" -n nvim "$editor_cmd"
tmux select-window -t "$session:nvim"

if [[ -n "${TMUX:-}" ]]; then
  tmux switch-client -t "$session"
else
  tmux attach-session -t "$session"
fi

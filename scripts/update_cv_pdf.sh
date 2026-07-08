#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cv_dir="$repo_root/cv-source"
pdf_target="$repo_root/assets/pdfs/CV_KH.pdf"
eco_keys="Ito2020"
medsel_keys="Toya2025,Hamaya2025,Taguchi2024,Ikesu2022,Hara2021,Shimizuguchi2020,Kaito2020,Taguchi2020a,Hara2018"
medoth_keys="Tokita2024,Kato2024,Nara2023,Taguchi2023,Toshimitsu2023,Kishida2022,Fujimori2022,Kosaka2021,Ito2021,Osawa2021,Fukaguchi2021,Soeno2021,Goto2020,Kinoshita2020,Baba2020,Taguchi2020b,Ito2019,Kinoshita2017"

cd "$cv_dir"

clean_build_artifacts() {
  rm -f CV_KH.aux CV_KH.fdb_latexmk CV_KH.fls CV_KH.log CV_KH.out CV_KH.pdf
  rm -f eco.aux eco.bbl eco.blg medsel.aux medsel.bbl medsel.blg medoth.aux medoth.bbl medoth.blg
}

clean_build_artifacts

write_multibib_aux() {
  local name="$1"
  local keys="$2"

  printf '%s\n' \
    '\relax' \
    "\\citation{$keys}" \
    '\bibstyle{unsrt}' \
    '\bibdata{publications}' \
    > "$name.aux"
}

write_multibib_aux eco "$eco_keys"
write_multibib_aux medsel "$medsel_keys"
write_multibib_aux medoth "$medoth_keys"

bibtex eco
bibtex medsel
bibtex medoth

perl -0pi -e 's/Konan\s+Hara/\\textbf{\\underline{Konan Hara}}/g' eco.bbl medsel.bbl medoth.bbl

pdflatex -interaction=nonstopmode -halt-on-error CV_KH.tex
pdflatex -interaction=nonstopmode -halt-on-error CV_KH.tex

mkdir -p "$(dirname "$pdf_target")"
cp CV_KH.pdf "$pdf_target"
clean_build_artifacts

echo "Updated $pdf_target"

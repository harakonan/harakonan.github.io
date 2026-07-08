# CV Source

This directory contains the LaTeX source for the public website CV.

To update the PDF embedded at `/cv/`, edit `CV_KH.tex` or `publications.bib`, then run:

```sh
./scripts/update_cv_pdf.sh
```

The script compiles the CV and copies the generated PDF to `assets/pdfs/CV_KH.pdf`, which is the file used by `_cv/cv.html`.

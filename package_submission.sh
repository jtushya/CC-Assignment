#!/usr/bin/env bash
set -euo pipefail

GROUP_ID="CSf364-JULIA-Group31"
ZIP_NAME="${GROUP_ID}.zip"
TMP_DIR="submission_${GROUP_ID}"

# Ensure build/test artifacts exist and are fresh.
(
  cd phase2
  ./verify_submission.sh
)

rm -rf "${TMP_DIR}"
mkdir -p "${TMP_DIR}"

cp phase2/lexer_phase2.l "${TMP_DIR}/"
cp phase2/parser.y "${TMP_DIR}/"
cp tests/phase2_valid_program.jl "${TMP_DIR}/"
cp tests/syntax_error_program.jl "${TMP_DIR}/"
cp phase2/intermediate_valid.tac "${TMP_DIR}/"
cp docs/cover_page_phase2.tex "${TMP_DIR}/"
cp docs/cover_page_phase2.pdf "${TMP_DIR}/"

rm -f "${ZIP_NAME}"
zip -r "${ZIP_NAME}" "${TMP_DIR}" >/dev/null

echo "Created ${ZIP_NAME}"
echo "Contents staged under ${TMP_DIR}/"

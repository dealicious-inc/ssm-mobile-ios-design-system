#!/usr/bin/env bash
#
# 이미지셋 PDF에 표시 크기(3x)를 초과하는 비트맵이 임베드되면 실패시킨다.
#
# 사진을 PDF로 감싸 에셋에 넣으면 Assets.car에 무압축 벡터 렌디션으로 저장되어
# 이 패키지를 쓰는 앱들의 용량이 수십 MB 단위로 팽창한다 (ssm-mobile-ios MP-7164:
# PDF 65개가 컴파일 후 761MB). 패스 기반 벡터 PDF(아이콘)는 이 검사를 통과한다.
#
# ssm-mobile-ios의 scripts/xcode/asset-pdf-guard.sh를 이식한 버전이다.
# CI(Linux)에서도 돌도록 sips 없이 PDF의 /MediaBox를 직접 읽는다.
#
# 사용:
#   scripts/asset-pdf-guard.sh              # git 변경분(staged+unstaged+untracked)의 imageset PDF 검사
#   scripts/asset-pdf-guard.sh <pdf...>     # 지정 파일만 검사

set -uo pipefail

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
cd "$repo_root"

targets=()
if [[ $# -gt 0 ]]; then
    targets=("$@")
else
    while IFS= read -r path; do
        [[ -z "$path" ]] && continue
        targets+=("$path")
    done < <(
        {
            git diff --cached --name-only --diff-filter=ACMR
            git diff --name-only --diff-filter=ACMR
            git ls-files --others --exclude-standard
        } | grep -E '\.imageset/[^/]+\.pdf$' | sort -u
    )
fi

if [[ ${#targets[@]} -eq 0 ]]; then
    echo "Asset PDF guard: no imageset PDFs to check."
    exit 0
fi

fail=0
for pdf in ${targets[@]+"${targets[@]}"}; do
    [[ -f "$pdf" ]] || continue

    # 임베드 비트맵이 없는 순수 벡터 PDF는 통과
    LC_ALL=C grep -aq "/Subtype[[:space:]]*/Image" "$pdf" || continue

    # PDF 표시 크기(pt). /MediaBox [x0 y0 x1 y1]에서 최대 페이지 크기를 읽는다.
    read -r box_w box_h < <(LC_ALL=C grep -a -o "/MediaBox[[:space:]]*\[[^]]*\]" "$pdf" \
        | tr -d '[]' | sed 's/\/MediaBox//' \
        | awk '{w=$3-$1; h=$4-$2; if (w>W) W=w; if (h>H) H=h} END{printf "%d %d", W, H}')
    if [[ -z "${box_w:-}" || "$box_w" -le 0 || -z "${box_h:-}" || "$box_h" -le 0 ]]; then
        echo "warning: ${pdf}: MediaBox를 읽지 못해 검사를 건너뜁니다."
        continue
    fi

    # 임베드 비트맵의 최대 해상도
    max_w=$(LC_ALL=C grep -ao "/Width[[:space:]]*[0-9][0-9]*" "$pdf" | awk '{if ($2+0 > m) m=$2+0} END{print m+0}')
    max_h=$(LC_ALL=C grep -ao "/Height[[:space:]]*[0-9][0-9]*" "$pdf" | awk '{if ($2+0 > m) m=$2+0} END{print m+0}')

    allow_w=$((box_w * 3))
    allow_h=$((box_h * 3))
    if (( max_w > allow_w || max_h > allow_h )); then
        echo "error: ${pdf}: ${max_w}x${max_h}px 비트맵이 ${box_w}x${box_h}pt PDF에 임베드되어 있습니다 (허용 ${allow_w}x${allow_h}px). 사진은 PDF 대신 PNG/JPEG 1x/2x/3x로 추가하세요. (MP-7172)"
        fail=1
    fi
done

if [[ "$fail" -ne 0 ]]; then
    exit 1
fi
echo "Asset PDF guard passed."

#!/usr/bin/env bash
# ClearedJobs Job API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./job.sh
set -euo pipefail

curl -sS -G "https://api.piloterr.com/v2/clearedjobs/job" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=analyst-washington-district-of-columbia-1902823.

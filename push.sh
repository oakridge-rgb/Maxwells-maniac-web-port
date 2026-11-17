#!/usr/bin/env bash
# Creates the GitHub repo "Maxwells-maniac-web-port" and pushes this project.
#
# Usage:
#   GH_TOKEN=<token> ./push.sh      # or paste the token when prompted
#
# The token needs the "repo" scope (classic) or "Contents: write" +
# "Administration: write" (fine-grained). It is used in memory only:
# never written to disk, never echoed, never stored in .git/config.
set -euo pipefail

REPO_NAME="Maxwells-maniac-web-port"
REPO_DESC="Clean-room web port of Maxwell's Maniac (Microsoft Entertainment Pack 4, 1992) - self-contained HTML5 reconstruction, no original Microsoft code or assets"

if [ -n "${GH_TOKEN:-}" ]; then
  TOKEN="$GH_TOKEN"
else
  printf "Paste a GitHub token (input hidden): "
  read -rs TOKEN
  echo
fi
[ -n "$TOKEN" ] || { echo "No token given."; exit 1; }

auth() { curl -s -H "Authorization: Bearer $TOKEN" \
              -H "Accept: application/vnd.github+json" "$@"; }

# 1. Identify the account
LOGIN=$(auth https://api.github.com/user | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('login') or '')")
[ -n "$LOGIN" ] || { echo "Token rejected by GitHub (check scope/expiry)."; exit 1; }
echo "Authenticated as: $LOGIN"

# 2. Create the repo if it doesn't exist
STATUS=$(auth -o /dev/null -w "%{http_code}" "https://api.github.com/repos/$LOGIN/$REPO_NAME")
if [ "$STATUS" = "200" ]; then
  echo "Repo already exists: $LOGIN/$REPO_NAME"
else
  echo "Creating repo $LOGIN/$REPO_NAME ..."
  auth -X POST https://api.github.com/user/repos \
    -d "{\"name\":\"$REPO_NAME\",\"description\":$(python3 -c "import json,sys;print(json.dumps(sys.argv[1]))" "$REPO_DESC"),\"private\":false,\"auto_init\":false}" \
    | python3 -c "import json,sys; d=json.load(sys.stdin); print('created:', d.get('full_name') or d.get('message','error'))"
fi

# 3. Push (token used one-shot in the URL, not saved to config)
git push --no-verify "https://x-access-token:${TOKEN}@github.com/${LOGIN}/${REPO_NAME}.git" HEAD:main
git push --no-verify "https://x-access-token:${TOKEN}@github.com/${LOGIN}/${REPO_NAME}.git" HEAD:main --tags 2>/dev/null || true

echo
echo "Done. Repo: https://github.com/$LOGIN/$REPO_NAME"

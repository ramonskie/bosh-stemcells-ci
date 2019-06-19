#!/bin/bash -eux

git clone bosh-linux-stemcell-builder bosh-linux-stemcell-builder-out

USN_URL="$(jq .url "usn-source/usn.json")"

commit_body=$(cat <<EOF
- $(jq .title "usn-source/usn.json")
  url: $(jq .url "usn-source/usn.json")
  priorities: $(jq .priorities "usn-source/usn.json")
  description: $(jq .description "usn-source/usn.json")
  cves: $(jq .cves "usn-source/usn.json")
EOF
)

pushd bosh-linux-stemcell-builder-out
	git add -A
	git config --global user.email "ci@localhost"
	git config --global user.name "CI Bot"
	git commit --allow-empty -m "Address USN" -m "${commit_body}"

	git log -1
popd

exit 1

#!/bin/bash -eux

git clone bosh-linux-stemcell-builder bosh-linux-stemcell-builder-out

usn_json="usn-source/usn.json"

commit_body=$(cat <<EOF
url: $(jq .url "${usn_json}")
priorities: $(jq '.priorities | join(",")' "${usn_json}")
description: $(jq .description "${usn_json}")
cves:
  $(jq '.cves[] | "* \(.)"' "${usn_json}"
EOF
)

pushd bosh-linux-stemcell-builder-out
	git add -A
	git config --global user.email "ci@localhost"
	git config --global user.name "CI Bot"
	git commit --allow-empty -m "$(jq .title "${usn_json}")" -m "${commit_body}"
popd

exit 1

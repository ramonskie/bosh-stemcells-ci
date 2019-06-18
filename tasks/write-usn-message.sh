#!/bin/bash -eux

git clone bosh-linux-stemcell-builder bosh-linux-stemcell-builder-out

USN_URL="$(jq .url "usn-source/usn.json")"

pushd bosh-linux-stemcell-builder-out
	git add -A
	git config --global user.email "ci@localhost"
	git config --global user.name "CI Bot"
	git commit --allow-empty -m "Address USN" -m "${USN_URL}"
popd

exit 1

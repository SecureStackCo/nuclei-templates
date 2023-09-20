#!/bin/bash

# test.sh will run tests to make sure that the SecureStack version of nuclei-templates is not corrupted by the public repo
# Specifically, we have removed commas from the description fields and changed name values and in several cases we've
# changed the severity as well.  Typically, we've changed some of the file exposures from infos to mediums, and occasionally
# highs.  

if [[ $(find ./ -name "*.yaml" | xargs grep -si "description:" | grep ',') == "0" ]]; then 
	echo "Found commas in at least one description value";
	exit 1;
else echo "No commas found!";
fi

ssfastnumb=$(find ./ -name "*.yaml" | xargs grep -si "securestack-fast" | wc -l | tr -d ' ')

echo "Number of securestack-fast tagged templates = $ssfastnumb"
echo
echo "Testing for merge conflict remnants.... "
#find ./ -name "*.yaml" | xargs grep -siE '===========================|<<<<|>>>>'
if [[ -n $(find ./ -name "*.yaml" | xargs grep -siE '===========================|<<<<|>>>>') ]]; then 
	echo "MERGE CONFLICT REMNANTS FOUND!"
	find ./ -name "*.yaml" | xargs grep -siE '===========================|<<<<|>>>>'
else echo "No merge conflicts"
fi

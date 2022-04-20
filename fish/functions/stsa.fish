#!/usr/bin/env fish

function stsa
    set -u AWS_ACCESS_KEY_ID
    set -u AWS_SECRET_ACCESS_KEY
    set -u AWS_SESSION_TOKEN
    set creds (aws sts assume-role \
        --role-arn arn:aws:iam::$argv:role/OrganizationAccountAccessRole \
        --role-session-name cli-session \
        --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
        --output json)

    set -xg AWS_ACCESS_KEY_ID (echo $creds | jq -r '.[0]')
    set -xg AWS_SECRET_ACCESS_KEY (echo $creds | jq -r '.[1]')
    set -xg AWS_SESSION_TOKEN (echo $creds | jq -r '.[2]')
end

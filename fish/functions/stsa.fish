#!/usr/bin/env fish

function stsa
    set -e AWS_ACCESS_KEY_ID
    set -e AWS_SECRET_ACCESS_KEY
    set -e AWS_SESSION_TOKEN
    switch $argv
        case production
            set acn 277454288534
        case staging
            set acn 079955430952
        case development
            set acn 522416699905
        case sandbox
            set acn 923779237983
        case '*'
            set acn $argv
    end

    set creds (aws sts assume-role \
        --role-arn arn:aws:iam::$acn:role/OrganizationAccountAccessRole \
        --role-session-name cli-session \
        --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
        --output json)

    set -xg AWS_ACCESS_KEY_ID (echo $creds | jq -r '.[0]')
    set -xg AWS_SECRET_ACCESS_KEY (echo $creds | jq -r '.[1]')
    set -xg AWS_SESSION_TOKEN (echo $creds | jq -r '.[2]')
end

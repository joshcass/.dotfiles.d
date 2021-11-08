#!/usr/bin/env fish

function stsa
    set -x (printf "AWS_ACCESS_KEY_ID %s AWS_SECRET_ACCESS_KEY %s AWS_SESSION_TOKEN %s" \
(aws sts assume-role \
--role-arn arn:aws:iam::516380219001:role/OrganizationAccountAccessRole \
--role-session-name cli-session \
--query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
--output text))
end

#!/bin/sh
# A new user signs up and logs in; the gossip search echoes its query into the page unescaped.
set -e
jar=$(mktemp)
base=http://app:10007
user="probe$$"
token() { curl -fsS -c "$jar" -b "$jar" "$base/$1" | sed -n 's/.*name="_csrf_token" type="hidden" value="\([^"]*\)".*/\1/p' | head -n 1; }
t=$(token register)
curl -fsS -o /dev/null -c "$jar" -b "$jar" --data "_csrf_token=$t&username=$user&password1=probe-pass&password2=probe-pass" "$base/register"
t=$(token login)
curl -fsS -o /dev/null -c "$jar" -b "$jar" --data "_csrf_token=$t&username=$user&password=probe-pass" "$base/login"
curl -fsS -b "$jar" "$base/gossip?search=%3Cb%3E$user%3C%2Fb%3E" | grep -qF "<b>$user</b>"

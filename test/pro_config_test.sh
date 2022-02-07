#!/bin/sh
# vim:et:ft=sh:sts=2:sw=2
set -o errexit

testIsConfigured() {
  assertFalse "pro shouldn't be configured" ${isConfigured}
}

oneTimeSetUp() {
  . ./lib/testhelper

  th_backup
  isConfigured='__pro_is_configured' # save command name in variable to make future changes easy
}

tearDown=th_restore

# Load and run shUnit2.
[ -n "${ZSH_VERSION:-}" ] && SHUNIT_PARENT=$0
. ./lib/shunit2

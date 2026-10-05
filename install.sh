#!/bin/bash
set -eu

# The caller (RPM .spec) is expected to set these environment variables:
# SRCDIR=.
# DESTDIR=%{buildroot}
# datadir=%{_datadir}

: "${SRCDIR:=.}"
: "${DESTDIR:=}"
: "${datadir:=/usr/share}"

mkdir -p "${DESTDIR}${datadir}/agama/openapi"

for dir in "${SRCDIR}"/[0-9]*; do
    if [ -d "$dir" ]; then
        cp -va "$dir" "${DESTDIR}${datadir}/agama/openapi/"
    fi
done

if [ -d "${SRCDIR}/nightly" ]; then
    cp -va "${SRCDIR}/nightly" "${DESTDIR}${datadir}/agama/openapi/"
fi

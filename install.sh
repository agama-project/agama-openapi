#!/bin/bash
set -eu

# The caller (RPM .spec) is expected to set these environment variables:
# SRCDIR=.
# DESTDIR=%{buildroot}
# datadir=%{_datadir}

if [ "${1-}" = --system ]; then
    SRCDIR=.
    DESTDIR=""
    datadir=/usr/share
fi

mkdir -p "${DESTDIR}${datadir}/agama/openapi"

if [ -d "${SRCDIR}/16.1" ]; then
    cp -a "${SRCDIR}/16.1" "${DESTDIR}${datadir}/agama/openapi/"
fi

if [ -d "${SRCDIR}/nightly" ]; then
    cp -a "${SRCDIR}/nightly" "${DESTDIR}${datadir}/agama/openapi/"
fi

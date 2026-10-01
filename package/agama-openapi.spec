#
# spec file for package agama-openapi
#
# Copyright (c) 2026 SUSE LLC
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#

Name:           agama-openapi
#               This will be set by osc services, that will run after this.
Version:        0
Release:        0
Summary:        OpenAPI specifications and JSON schemas for the Agama installer
License:        GPL-2.0-only
URL:            https://github.com/openSUSE/agama-openapi
BuildArch:      noarch
Source0:        %{name}-%{version}.tar

%description
OpenAPI specifications and JSON schemas for the Agama installer.
This package contains stable release specifications.

%package nightly
Summary:        Nightly OpenAPI specifications and JSON schemas for the Agama installer

%description nightly
Nightly OpenAPI specifications and JSON schemas for the Agama installer, generated
from the latest master branch.

%prep
%autosetup -p1

%build

%install
env \
  SRCDIR=. \
  DESTDIR=%{buildroot} \
  datadir=%{_datadir} \
  ./install.sh

%files
%doc README.md
%license LICENSE
%dir %{_datadir}/agama
%dir %{_datadir}/agama/openapi
%{_datadir}/agama/openapi/16.1

%files nightly
%doc README.md
%license LICENSE
%dir %{_datadir}/agama
%dir %{_datadir}/agama/openapi
%{_datadir}/agama/openapi/nightly

%changelog

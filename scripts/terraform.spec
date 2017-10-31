%if 0%{?_version:1}
%define         _verstr      %{_version}
%else
%define         _verstr      0.10.8
%endif

Name:           terraform
Version:        %{_verstr}
Release:        1%{?dist}
Summary:        Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.

Group:          Development/Libraries
License:        MPLv2.0
URL:            http://www.terraform.io
#Source0:        https://releases.hashicorp.com/%{name}/%{version}/%{name}_%{version}_linux_amd64.zip
BuildRoot:      %(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)


%description
Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.


%prep
export GOPATH=/usr/share/gocode
export PATH=$GOPATH/bin:$PATH

%build

%install
cd $GOPATH/src/github.com/hashicorp/terraform
mkdir -p %{buildroot}/%{_bindir}
cp bin/terraform %{buildroot}/%{_bindir}

%clean
rm -rf %{buildroot}


%files
%attr(755, root, root) %{_bindir}/terraform


%changelog
* Fri Oct 31 2017 allanhung hungallan@gmail.com
- version 0.10.8

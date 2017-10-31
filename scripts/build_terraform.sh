TERRAFORMVER=${1:-'0.10.8'}
RPMVER="${TERRAFORMVER/-/_}"
export RPMBUILDROOT=/root/rpmbuild
export GOPATH=/usr/share/gocode
export PATH=$GOPATH/bin:$PATH

# go repo
rpm --import https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO
curl -s https://mirror.go-repo.io/centos/go-repo.repo | tee /etc/yum.repos.d/go-repo.repo
# epel
yum install -y epel-release
yum -y install golang git rpm-build make which
mkdir -p $RPMBUILDROOT/SOURCES && mkdir -p $RPMBUILDROOT/SPECS && mkdir -p $RPMBUILDROOT/SRPMS
# fix rpm marcos
sed -i -e "s#.centos##g" /etc/rpm/macros.dist

# terraform
mkdir -p $GOPATH/src/github.com/hashicorp
cd $GOPATH/src/github.com/hashicorp
git clone --depth=10 -b v$TERRAFORMVER https://github.com/hashicorp/terraform.git

# build
cd $GOPATH/src/github.com/hashicorp/terraform
make fmt
XC_OS=linux XC_ARCH=amd64 make bin

/bin/cp -f /usr/local/src/build/terraform.spec $RPMBUILDROOT/SPECS/
rpmbuild -bb $RPMBUILDROOT/SPECS/terraform.spec --define "_version $RPMVER"

RPMBUILD for terraform
=========================

terraform rpm

How to Build
=========
    git clone https://github.com/allanhung/rpm_terraform
    cd rpm_terraform
    docker run --name=terraform_build --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS/x86_64 -v $(pwd)/rpms:/root/rpmbuild/RPMS/noarch -v $(pwd)/scripts:/usr/local/src/build centos /bin/bash -c "/usr/local/src/build/build_terraform.sh 0.10.8"

# check
    docker run --name=terraform_check --rm -ti -v $(pwd)/rpms:/root/rpmbuild/RPMS centos /bin/bash -c "yum localinstall -y /root/rpmbuild/RPMS/terraform-*.rpm"

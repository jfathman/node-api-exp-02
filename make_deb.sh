#! /bin/bash

# make_deb.sh

set -e

PACKAGE="node-api-exp-02"

DESCRIPTION="API Example"

ORGANIZATION="Acme Labs"

PLATFORM=ubuntu

ARCH=all

VERSION=$(node -e 'console.log(require("./package.json").version)')

if [ "$VERSION" == "undefined" ]; then
  echo "ERROR: package.json app version undefined"
  exit 1
fi

# RELEASE identifies package spin version.

if [ $# -eq 1 ]; then
  RELEASE=$1;
  FILENAME=${PACKAGE}_${VERSION}-${RELEASE}_${PLATFORM}_${ARCH}.deb
else
  for ((i = 0; i < 1000; i++))
  do
    RELEASE=$i
    FILENAME=${PACKAGE}_${VERSION}-${RELEASE}_${PLATFORM}_${ARCH}.deb
    if [ ! -f $FILENAME ]; then
      break
    fi
  done
fi

rm -rf ./deb-build

mkdir -p ./deb-build/DEBIAN
mkdir -p ./deb-build/usr/local/exp/node-api-exp-02
mkdir -p ./deb-build/usr/local/exp/node-api-exp-02/node_modules

cp app.js              ./deb-build/usr/local/exp/node-api-exp-02/.
cp package.json        ./deb-build/usr/local/exp/node-api-exp-02/.
cp npm-shrinkwrap.json ./deb-build/usr/local/exp/node-api-exp-02/.

cat << EOF >./deb-build/DEBIAN/install
/usr/local/exp/node-api-exp-02
EOF

cat << EOF >./deb-build/DEBIAN/preinst
#! /bin/sh
EOF

chmod 755 ./deb-build/DEBIAN/preinst

cat << EOF >./deb-build/DEBIAN/postinst
#! /bin/sh
id node-api-exp-02 >/dev/null 2>&1
if [ \$? -ne 0 ]; then
  useradd --shell /bin/bash --password node-api-exp-02 -m node-api-exp-02
fi
chown node-api-exp-02:node-api-exp-02 /usr/local/exp/node-api-exp-02
chown node-api-exp-02:node-api-exp-02 /usr/local/exp/node-api-exp-02/node_modules
chown node-api-exp-02:node-api-exp-02 /usr/local/exp/node-api-exp-02/app.js
chown node-api-exp-02:node-api-exp-02 /usr/local/exp/node-api-exp-02/package.json
chown node-api-exp-02:node-api-exp-02 /usr/local/exp/node-api-exp-02/npm-shrinkwrap.json
EOF

chmod 755 ./deb-build/DEBIAN/postinst

cat << EOF >./deb-build/DEBIAN/prerm
#! /bin/sh
EOF

chmod 755 ./deb-build/DEBIAN/prerm

cat << EOF >./deb-build/DEBIAN/postrm
#! /bin/sh
EOF

chmod 755 ./deb-build/DEBIAN/postrm

cat << EOF >./deb-build/DEBIAN/control
Package: ${PACKAGE}
Version: ${VERSION}-${RELEASE}
Section: non-free/misc
Priority: optional
Architecture: ${ARCH}
Maintainer: ${ORGANIZATION}
Description: ${DESCRIPTION}
EOF

cat << EOF >./deb-build/DEBIAN/copyright
This package was created on $(date)
Copyright:
  Copyright (C) $(date +"%Y") ${ORGANIZATION}
License:
  Commercial.  All rights reserved.
EOF

# intentional tab at beginning of dh line:

cat << EOF >./deb-build/DEBIAN/rules
#!/usr/bin/make -f
%:
	dh $@
EOF

cat << EOF >./deb-build/DEBIAN/compat
7
EOF

fakeroot dpkg-deb --build deb-build $FILENAME

file   $FILENAME
md5sum $FILENAME
ls -l  $FILENAME

rm -rf ./deb-build

exit 0

# end.

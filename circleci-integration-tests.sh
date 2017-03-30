#!/bin/sh

BLOCKSTACK_BRANCH="rc-0.14.2"

# needed on CircleCI's VMs
pip install --upgrade pip
pip install --upgrade six
pip install --upgrade setuptools
pip install --upgrade cryptography
pip install --upgrade scrypt

# install Blockstack and integration tests
git clone https://github.com/blockstack/blockstack-core /tmp/blockstack-core
cd /tmp/blockstack-core && git checkout "$BLOCKSTACK_BRANCH"

cd /tmp/blockstack-core && ./setup.py build && ./setup.py install 
cd /tmp/blockstack-core/integration_tests && ./setup.py build && ./setup.py install

npm install -g babel
npm install -g browserify

# get bitcoind 
sudo apt-get install bitcoind || exit 1

# run the relevant integration tests
blockstack-test-scenario blockstack_integration_tests.scenarios.name_preorder_register_portal_auth || exit 1
blockstack-test-scenario blockstack_integration_tests.scenarios.name_preorder_register_portal_datastore || exit 1
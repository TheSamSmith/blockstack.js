#!/bin/sh

# needed on CircleCI's VMs
pip install --upgrade pip
pip install --upgrade six
pip install --upgrade setuptools
pip install --upgrade cryptography

# install Blockstack and integration tests
git clone https://github.com/blockstack/blockstack/core /tmp/blockstack-core
cd /tmp/blockstack-core && ./setup.py && ./setup.py install 
cd /tmp/blockstack-core/integration_tests && ./setup.py && ./setup.py install
npm install -g babel
npm install -g browserify

# run the relevant integration tests
blockstack-test-scenario blockstack_integration_tests.scenarios.name_preorder_register_update_portal_auth || exit 1
blockstack-test-scenario blockstack_integration_tests.scenarios.name_preorder_register_update_portal_datastore || exit 1

#!/bin/sh
#
# Install Discover App
#

# deploy app
/appl/endeca/ToolsAndFrameworks/11.1.0/deployment_template/bin/deploy.sh --app /appl/endeca/ToolsAndFrameworks/11.1.0/reference/discover-data-cas/deploy.xml --no-prompt --install-config /silent-install-config.xml

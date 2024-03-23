#!/bin/bash

cat << EOF
These are the helm commands required to install mariadb.

# Add the 'bitnami' helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo list

# Fetch the helm chart to a local directory
helm fetch bitnami/mariadb --untar=true --untardir=.

# After customizing 'values.yaml' perform a dry-run/actual installation
helm -n workflow-database install --create-namespace --dry-run workflow-database -f ./values.yaml  .
helm -n workflow-database install --create-namespace workflow-database -f ./values.yaml  .

# Apply changes to 'values.yaml' to the installed components
helm -n workflow-database upgrade  workflow-database -f ./values.yaml .

# Connect to database with root account
mysql -h workflow-database.k3s.kippel.de --user=root --password=icrpass icrdb

# Clone database
mysqldump -h localhost --user=icr_owner --password=icrpass icrdb > x2df8h.icrdb.dump.sql
mysql -h workflow-database.k3s.kippel.de --user=root --password=icrpass icrdb < ./x2df8h.icrdb.dump.sql

# List tables in clone
mysqlshow -h workflow-database.k3s.kippel.de --user=root --password=icrpass icrdb

# Grant Access to non-root user
mysql -h workflow-database.k3s.kippel.de --user=root --password=icrpass icrdb << "EOF"
CREATE OR REPLACE USER 'icr_user'@'workflow-database.k3s.kippel.de' IDENTIFIED BY 'icrpass';
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'icr_user'@'workflow-database.k3s.kippel.de';
"EOF"

EOF

exit 0

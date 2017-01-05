#!/bin/bash

set -e

rm -f /var/run/apache2/apache2.pid

DIR_APP="/opt/app"

[ -d "$DIR_APP" ]

supervisord
supervisorctl tail -f apache2

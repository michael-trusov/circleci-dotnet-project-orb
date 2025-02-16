#!/bin/bash
#shellcheck disable=all

dotnet test $PROJECT_SOLUTION -p:CollectCoverage=true -p:CoverletOutputFormat=opencover --logger trx --filter FullyQualifiedName\!~IntegrationTest
#!/bin/sh
set -ae
cd "$(dirname $0)"

uvicorn api.main:app "$@"

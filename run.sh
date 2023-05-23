#!/bin/sh
set -ae
cd "$(dirname $0)"

uvicorn api.main:app "$@"




// The above code is used to run a local server using batchsrc within any UNIX operating system before starting to use it on VM. 

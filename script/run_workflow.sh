#!/usr/bin/env bash

# Run the CAMES builds
nextstrain build \
    --cpus 4 \
    --memory 8Gib \
    . \
    --configfile builds_cames.yaml \
    --config active_builds=CAMES

# nextstrain view auspice

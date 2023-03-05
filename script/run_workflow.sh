#!/usr/bin/env bash

# Run the CAMES builds
nextstrain build \
    --cpus 8 \
    --memory 16Gib \
    . \
    --configfile builds_cames.yaml \
    --config active_builds=CAMES

# nextstrain view auspice

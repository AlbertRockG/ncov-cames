#!/usr/bin/env bash

# Run the CAMES builds
nextstrain build \
    --cpus 16 \
    --memory 48Gib \
    . \
    --configfile builds_cames.yaml \
    --config active_builds=CAMES

# nextstrain view auspice

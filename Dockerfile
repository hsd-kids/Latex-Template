# ================================================
# Dockerfile für Abschlussarbeiten-Template
# ================================================

FROM debian:stable-slim

# Grundpakete und Tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates make perl python3 python3-pygments git \
    ghostscript xz-utils wget lmodern fontconfig \
    && rm -rf /var/lib/apt/lists/*

# TeX Live vollständig (ca. 5–6 GB, aber stressfrei)
RUN apt-get update && apt-get install -y --no-install-recommends texlive-full \
    && rm -rf /var/lib/apt/lists/*

# Standard-Arbeitsverzeichnis
WORKDIR /work

# Standard-EntryPoint -> Makefile
ENTRYPOINT ["/usr/bin/make"]

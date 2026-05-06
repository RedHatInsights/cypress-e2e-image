# DEPRECATED — This image is no longer built or published.
# See README.md for details.
FROM quay.io/fedora/fedora:42
LABEL deprecated="true"
LABEL description="This image is deprecated and should not be used."
ENTRYPOINT ["echo", "This image is deprecated."]

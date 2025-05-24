FROM quay.io/keycloak/keycloak:26.1.4

COPY --chown=keycloak:keycloak themes/modern-theme /opt/keycloak/themes/modern-theme
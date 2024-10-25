FROM php:8.2-alpine

LABEL "repository" = "https://github.com/magashops/action-deployer"
LABEL "homepage" = "https://github.com/magashops/action-deployer"

LABEL "com.github.actions.name"="LTH - Action Deployer"
LABEL "com.github.actions.description"="Custom PHP Deployer using GitHub Actions"
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="yellow"

RUN apk update --no-cache \
    && apk add --no-cache \
    bash \
    openssh-client \
    rsync

RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN composer global require deployer/deployer

ENTRYPOINT ["/entrypoint.sh"]
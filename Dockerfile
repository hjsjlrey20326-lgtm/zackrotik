FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl bash ca-certificates socat tzdata sqlite3 nginx gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Скачиваем и устанавливаем 3x-ui (или Heimdall, как в некоторых репозиториях)
RUN curl -L https://github.com/mhsanaei/3x-ui/releases/download/v2.8.7/x-ui-linux-amd64.tar.gz \
    -o /tmp/x-ui.tar.gz \
    && tar -xzf /tmp/x-ui.tar.gz -C /usr/local/ \
    && rm /tmp/x-ui.tar.gz \
    && chmod +x /usr/local/x-ui/x-ui

RUN mkdir -p /etc/x-ui /var/log/x-ui

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/bin/sh", "/start.sh"]
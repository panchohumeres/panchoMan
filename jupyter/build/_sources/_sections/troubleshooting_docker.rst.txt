=================================
Kibana: Troubleshooting en Docker
=================================

Problemas con Reportería:
---------------------------------------------------

* **Si botón de reportería no puede generar reportes por tiemout o agota los intentos**
    * **Referencias¨:
        https://discuss.elastic.co/t/reporting-not-working-on-kibana-under-docker/170027
        https://www.elastic.co/guide/en/kibana/current/reporting-settings-kb.html#reporting-kibana-server-settings
        https://www.elastic.co/guide/en/kibana/current/reporting-troubleshooting.html
    1. Probar si PDF se renderiza con un dashboard simple, con una sóla visualización con texto markdown.
    2. agregar estas líneas a docker-compose.yml y reiniciar el clúster:
        xpack.reporting.kibanaServer.hostname: kibana
        xpack.reporting.kibanaServer.protocol: http
        xpack.reporting.kibanaServer.port: 5601

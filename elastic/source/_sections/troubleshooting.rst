===================================
Elasticsearch: Troubleshooting
===================================

413 Request Entity Too Large
-----------------------------------

**Causas:**
    * En **NGINX** (proxy): **NO** se ha configurado parámetro :code:`client_max_body_size 20M;`
        Ver: https://panchohumeres.gitlab.io/nginx_man/_sections/troubleshooting.html#request-entity-too-large
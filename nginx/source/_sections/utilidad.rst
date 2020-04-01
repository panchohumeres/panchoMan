=====================================
NGINX: Comandos Útiles
=====================================

Comandos de utilidad en NGINX:

----------------------------------------------

    * Referencias:
        https://www.tecmint.com/useful-nginx-command-examples/

    *  Revisar versión:
    
        .. code-block:: bash
            
            nginx -v

            #Output esperado:
            
            nginx version: nginx/1.12.2

    * Revisar versión y opciones de configuración:

        .. code-block:: bash
            
            nginx -V

            #Output esperado:
            
            nginx version: nginx/1.12.2
            built by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
            built with OpenSSL 1.0.2k-fips  26 Jan 2017
            TLS SNI support enabled
            configure arguments: --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib64/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --http-client-body-temp-path=/var/lib/nginx/tmp/client_body --http-proxy-temp-path=/var/lib/nginx/tmp/proxy --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi --http-scgi-temp-path=/var/lib/nginx/tmp/scgi --pid-path=/run/nginx.pid --lock-path=/run/lock/subsys/nginx --user=nginx --group=nginx --with-file-aio --with-ipv6 --with-http_auth_request_module --with-http_ssl_module --with-http_v2_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_degradation_module --with-http_slice_module --with-http_stub_status_module --with-http_perl_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-pcre --with-pcre-jit --with-stream=dynamic --with-stream_ssl_module --with-google_perftools_module --with-debug --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic' --with-ld-opt='-Wl,-z,relro -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -Wl,-E'

    * Revisar sintaxis de Configuración de NGINX:

        .. code-block:: bash

            sudo nginx -t

            #Output esperado:

            nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
            nginx: configuration file /etc/nginx/nginx.conf test is successful

    * Mostrar texto de configuración completo:

            .. code-block:: bash

                sudo nginx -T

                #enviarla a un archivo de texto:

                sudo nginx -T >> test_config.nginx

    * Iniciar servicio:

            .. code-block:: bash

                sudo systemctl start nginx

                #Ó:

                sudo service nginx start

    * Habilitar servicio Nginx (**para que se inicie con boot del sistema**):

            .. code-block:: bash

                sudo systemctl enable nginx

                #Ó:

                sudo service nginx enable

    * Reiniciar servicio Nginx:

            .. code-block:: bash

                sudo systemctl restart nginx

                #Ó:

                sudo service nginx restart

    * Recargar configuración (Reload de archivo(s) de configuración):

            .. code-block:: bash

                sudo systemctl reload nginx

                #Ó:

                sudo service nginx reload

    * Verificar status servicio NGINX:

            .. code-block:: bash

                sudo systemctl status nginx

                #Ó:

                sudo service nginx status

    * Referencia de comandos (ayuda):

            .. code-block:: bash

                systemctl -h nginx
                
----------------------------------------------

Alpine Linux:
==============================================

         Ver más detalles en: https://panchohumeres.gitlab.io/linux_man/_sections/alpine.html#comandos-para-administrar-servicios
         
         **Otras Referencias:** https://www.cyberciti.biz/faq/how-to-install-nginx-web-server-on-alpine-linux/

        * Encontrar ip servidor:

            .. code-block:: bash

                ip a
                #Ó
                ifconfig -a

        * Asegurarse que nginx inicie al momento de REBOOT:

            .. code-block:: bash

                rc-update add nginx default
                #RESULTADO ESPERADO:
                 * service nginx added to runlevel default

        * Iniciar servidor nginx:

            .. code-block:: bash

                /etc/init.d/nginx start
                #Ó
                rc-service nginx start
                #Ó
                service nginx start

                #RESULTADOS ESPERADOS:
                 * Caching service dependencies ...                              [ ok ]
                 * /run/nginx: creating directory
                 * /run/nginx: correcting owner                                  [ ok ]
                 * Starting nginx ...

        * Re-iniciar servidor nginx:

            .. code-block:: bash

                rc-service nginx restart

        * Parar servidor nginx:

            .. code-block:: bash

                rc-service nginx stop

        * Ver status de Servidor nginx:

            .. code-block:: bash

                rc-service nginx status

        * Verificar que servidor nginx está corriendo:

            .. code-block:: bash

                pgrep nginx
                #Ó
                ps aux | grep "[n|N]ginx"

                #RESULTADOS ESPERADOS (EJEMPLOS)
                27876 root       0:00 nginx: master process /usr/sbin/nginx -c /etc/nginx/nginx.conf
                27877 nginx      0:00 nginx: worker process
                27878 nginx      0:00 nginx: worker process
                27879 nginx      0:00 nginx: worker process
                27880 nginx      0:00 nginx: worker process
                27882 nginx      0:00 nginx: worker process
                27883 nginx      0:00 nginx: worker process
                27884 nginx      0:00 nginx: worker process
                27885 nginx      0:00 nginx: worker process

        * Verificar que el puerto de NGINX está abierto:
            
            .. code-block:: bash

                netstat -tulpn | grep :80

                #RESULTADO ESPERADO:
                tcp   0  0 0.0.0.0:80   0.0.0.0:*     LISTEN      27876/nginx.conf
                tcp   0  0 :::80        :::*          LISTEN      27876/nginx.conf    

        * Ver Logs:
            Usar algunos de estos comandos:

            .. code-block:: bash

                less /var/log/nginx/error.log
                less /var/log/nginx/access.log
                tail -f /var/log/nginx/www.cyberciti.biz_access.log
                grep 'error' /var/log/nginx/www.cyberciti.biz_error.log            







        
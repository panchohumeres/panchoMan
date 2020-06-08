===========================
SSL/TSL: Prueba de Concepto
===========================

Basado en:
https://phoenixnap.com/kb/openssl-tutorial-ssl-certificates-private-keys-csrs


A. Generar CSR (certificate signing request ) y Private Key:
--------------------------------------------------------------

1. Instalar Open SSL
2. openssl req -out server.csr -new -newkey rsa:2048 -nodes -keyout privatekey.key

* **Output**: server.csr y privatekey.key.

3. Responder preguntas (dominio, compañía, dueño, etc.)
4. openssl req -in server.csr -noout -text >> example-csr-key.txt
   
   * **Output**: example-csr-key.txt con output.

5. Verificar si output son input entregados en paso 3.

B. Generar CSR a partir de Private Key:
----------------------------------------

1. openssl req -out CSR.csr -key privatekey.key -new
   
   * **Input**: Usando archivo privatekey de paso **A.2**.
   
   * **Output**: CSR.csr


C. Generar Certificado (CSR y privatekey) autofirmado:
-------------------------------------------------------
1. openssl req -newkey rsa:2048 -nodes -keyout domain.key-x509 -days 365 -out domain.crt
   
   * **Notas**: Parámetro "-days" indica que el certificado expirar en 365 días, mientras que parámetro "-x509" indica que es un certificado "autofirmado".
   
   * **Output**: Archivos "domain.crt" (Certificado) y "domain.key-x509" (Private Key).

2. openssl req -in domain.crt -noout -text >> example-self-signed.txt

   * **Output**: example-self-signed.txt con output.

3. **Opcional**: openssl x509 \ -signkey domain.key \ -in domain.csr \ -req -days 365 -out domain.crt
  
   * **Notas**: Generar CSR auto-firmada a partir de Private Key.
   
   * **Output**: Archivo "domain.crt" (Certificado).

D. Verficar certificados:
-----------------------------
   * openssl req -text -noout -verify -in server.csr | CSR
   * openssl rsa -in privatekey.key -check
   * **Notas**: Inputs son los mismos de los pasos **A.4** o **C.2**, con flag de "OK" (o no) al principio del output.
openssl x509 -in server.csr -text -noout
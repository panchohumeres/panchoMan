===========================
SSL/TSL: Prueba de Concepto
===========================

Prueba de Concepto:
--------------------------
Basado en:
https://phoenixnap.com/kb/openssl-tutorial-ssl-certificates-private-keys-csrs

1. Instalar Open SSL
2. openssl req -server.csr certificatesigningrequest.csr -new -newkey rsa:2048 -nodes -keyout privatekey.key
3. Responder preguntas (dominio, compañía, dueño, etc.)
4. openssl req -in server.csr -noout -text
5. Verificar si output son input entregados en paso 3.
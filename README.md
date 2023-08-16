# terraform-firstcreate-ec2
Esse foi o primeiro projeto que fiz sozinho utilizando Terraform; houve necessidade de subir uma instâcia ec2 na AWS para que eu pudesse configurar um WebServer Apache para subir uma landing page, geralmente construia toda a infraestrutura na unha mas dessa vez após ler sobre os beneficios de uso da Infraestrutura como Código busquei estudar mais sobre o Terraform para provisionamento de recursos utilizando linha de comando.

Após estudar e ler a documentaçao oficial, consegui provisionar minha primeira instância utilizando Terraform; no código desse repositório, criei 3 recursos:

- Security Group com regras de Entrada e Saída
- KeyPair apontando para a chave pública SSH da minha máquina
- Instância EC2

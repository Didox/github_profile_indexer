# Github Profile Indexer

## Visão Geral

Bem-vindo ao Github Profile Indexer! Este aplicativo permite que os usuários registrem perfis do Github, realizem scraping de informações e exibam dados detalhados dos perfis. Este README fornece uma visão geral da configuração, uso e comandos necessários para desenvolvimento e testes do projeto.

## Índice

- [Instalação](#instalação)
- [Configuração](#configuração)
- [Uso](#uso)
- [Testes](#testes)
- [Cobertura de Testes](#cobertura-de-testes)
- [Deploy no Heroku](#deploy-no-heroku)
- [Como acessar o app](#como-acessar-o-app)
- [Contato](#contato)

## Instalação

1. **Clone o repositório:**

   ```sh
   git clone https://github.com/didox/github_profile_indexer.git
   cd github_profile_indexer
   ```

2. **Instale as dependências:**

   Certifique-se de ter Ruby e Bundler instalados. Em seguida, execute:

   ```sh
   bundle install
   ```

3. **Instale o PostgreSQL:**

   Siga as instruções para instalar o PostgreSQL no seu sistema operacional:

   - **Ubuntu:**
     ```sh
     sudo apt update
     sudo apt install postgresql postgresql-contrib
     ```
   - **MacOS:**
     ```sh
     brew install postgresql
     ```
   - **Windows:**
     Baixe e instale o PostgreSQL do [site oficial](https://www.postgresql.org/download/windows/).

4. **Configuração do banco de dados (Postgres):**

   ```sh
   bundle exec rails db:create
   bundle exec rails db:migrate
   bundle exec rails db:seed
   ```

## Configuração

Certifique-se de ter as seguintes configurações no seu ambiente:

- **Token da API Bitly:** Crie uma conta no [Bitly](https://bitly.com/) e gere um token de API. Configure o token no seu ambiente:

  ```sh
  export TOKEN_BITLY=seu_token_bitly
  ```

## Uso

Para iniciar o servidor Rails, execute:

```sh
bundle exec rails s
```

Acesse `http://localhost:3000` no seu navegador para usar a aplicação.

## Testes

Usamos RSpec e Guard para testes e monitoramento de mudanças no código.

1. **Executar todos os testes:**

   ```sh
   bundle exec rspec
   ```

2. **Executar Rubocop para linting de código:**

   ```sh
   bundle exec rubocop
   ```

3. **Usar Guard para executar testes automaticamente em mudanças de arquivos:**

   ```sh
   bundle exec guard
   ```

## Cobertura de Testes

Para visualizar a cobertura dos testes, abra o arquivo `coverage/index.html` em seu navegador. Este arquivo é gerado após a execução dos testes com RSpec e fornece um relatório detalhado da cobertura de código.

## Deploy no Heroku

1. **Crie um aplicativo no Heroku:**

   ```sh
   heroku create github-profile-indexer-cf61ca4adfe2
   ```

2. **Adicione o PostgreSQL ao seu aplicativo:**

   ```sh
   heroku addons:create heroku-postgresql:hobby-dev
   ```

3. **Faça o deploy da sua aplicação:**

   ```sh
   git push heroku main
   ```

4. **Execute as migrações e seeds no Heroku:**

   ```sh
   heroku run rails db:migrate
   heroku run rails db:seed
   ```

5. **Coloque sua chave do TOKEN_BITLY :**

   ```sh
   heroku config:set TOKEN_BITLY="SEU_TOKEN_BITLY"
   ```

## Como acessar o app
   - [http://fretadao.didox.com.br](http://fretadao.didox.com.br)

## Contato

Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para entrar em contato:

- **Nome:** Danilo Aparecido
- **Github:** [didox](https://github.com/didox)
- **Email:** [danilo.aparecido.santos@gmail.com](mailto:danilo.aparecido.santos@gmail.com)

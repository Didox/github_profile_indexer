# Github Profile Indexer

## Visão Geral

Bem-vindo ao Github Profile Indexer! Este aplicativo permite que os usuários registrem perfis do Github, realizem scraping de informações e exibam dados detalhados dos perfis. Este README fornece uma visão geral da configuração, uso e comandos necessários para desenvolvimento e testes do projeto.

## Índice

- [Instalação](#instalação)
- [Configuração](#configuração)
- [Uso](#uso)
- [Testes](#testes)
- [Comandos](#comandos)
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

3. **Configuração do banco de dados:**

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

## Comandos

- **Iniciar o servidor Rails:**

  ```sh
  bundle exec rails s
  ```

- **Criar o banco de dados:**

  ```sh
  bundle exec rails db:create
  ```

- **Executar migrações do banco de dados:**

  ```sh
  bundle exec rails db:migrate
  ```

- **Popular o banco de dados:**

  ```sh
  bundle exec rails db:seed
  ```

- **Executar Rubocop para linting de código:**

  ```sh
  bundle exec rubocop
  ```

- **Executar RSpec para testes:**

  ```sh
  bundle exec rspec
  ```

- **Usar Guard para executar testes automaticamente em mudanças de arquivos:**

  ```sh
  bundle exec guard
  ```

## Contato

Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para entrar em contato:

- **Nome:** Danilo Aparecido
- **Github:** [didox](https://github.com/didox)
- **Email:** [danilo.aparecido.santos@gmail.com](mailto:danilo.aparecido.santos@gmail.com)

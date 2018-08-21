# iGym v1.0.0 - API

### índice de conteúdo
--- 

* [Setup do Projeto](#setup-do-projeto)
* [Dependências](#dependências)
* [Versionamento](#versionamento)
* [Changelog](#changelog)
* [Documentação da API](#documentação-da-api)


## Setup do Projeto
------------------------

### Dependências

 - Ruby v2.5.1
     - Caso não tenha Ruby intalado em sua máquina, recomendamos o uso do [RVM](https://rvm.io/) para a instalação do mesmo.
 - Rails v5.2.0
 - MySQL >= 5.6 
 - Git e Git Flow

**Download**

Acesse via terminal o local dos seus projetos e faça o download do repositório.
```bash
$ git clone git@gitlab.com:jera-software/iGym-api.git
```

Para utilização do ambiente de desenvolvimento configure o Git Flow.
```bash
$ sudo apt-get install git-flow
$ git flow init
```
Pressione Enter para todas as opções que serão exibidas. Depois disso você já estara na branch de development.

Caso opte por não utilizar Git Flow, é necessário fazer o download da branch `develop` remota.

**Configuração do Gemset**

Dentro da pasta do projeto, crie os arquivos `.ruby-version` e `.ruby-gemset` e depois entre novamente na pasta para carregar as novas configurações.
```bash
$ echo "ruby-2.5.1" > .ruby-version && echo "api-template" > .ruby-gemset
$ cd .
```

**Instalação das dependências**

A ferramenta `bundle` instalará todas as gems que foram definidas no Gemset do projeto.
```bash
$ gem install bundle
$ bundle install
```

**Configuração do banco de dados**

Primeiramente é necessário criar o arquivo de setup de banco: `config/database.yml`.
```bash
$ cp config/database.example.yml config/database.yml
```

Por fim, crie o banco de dados, rode as migrations e popule o mesmo.

```bash
$ rails db:create db:migrate db:seed
```

**Testes**

Utilizamos o framework de testes Rspec e cucumber para execução de testes.

```bash
$ rake rspec
$ rake cucumber
```

**Start do servidor**
```bash
$ rails s
```

## Versionamento

> Este projeto segue o [versionamento semântico](http://semver.org/lang/pt-BR/)

Dado um número de versão MAJOR.MINOR.PATCH, incremente a:

1. versão Maior(MAJOR): quando fizer mudanças incompatíveis na API,
1. versão Menor(MINOR): quando adicionar funcionalidades mantendo compatibilidade, e
1. versão de Correção(PATCH): quando corrigir falhas mantendo compatibilidade.

ex: 2.4.0

Rótulos adicionais para pré-lançamento(pre-release) e metadados de construção(build) 
estão disponíveis como extensão ao formato MAJOR.MINOR.PATCH.

ex: 1.0.0-rc1

## Changelog

## Documentação da API

# Annotations App

Aplicativo mobile desenvolvido em **Flutter**, com foco em gerenciamento de notas, autenticação de usuários e persistência local.  
O app permite criar, editar, excluir e visualizar notas, além de filtros e reset de dados.

---

## Funcionalidades

### Autenticação
- Tela de **Login**
- Tela de **Cadastro**
- Validação de campos

### Notas
- Listagem de notas
- Criar novas notas
- Editar notas existentes
- Excluir notas
- Reset por usuário da tabela de notas

### Detalhes das Notas
- Tela de detalhes acessível via **menu lateral**
- Visualização completa dos detalhes das notas
- Filtros disponíveis:
  - Todas
  - Ativas
  - Deletadas

---

## Estrutura de Navegação

- Login / Cadastro
- Home (Notas)
- Detalhes das Notas
- Menu lateral para acesso rápido às telas

---

## Tecnologias Utilizadas

- **Flutter**
- **Dart**
- Gerenciamento de estado (MobX)
- Injeção de dependências (Provider)
- Persistência local (SQLite)

---

## Executando o projeto via console Flutter

### Pré-requisitos
- Flutter instalado
- Android Studio ou Xcode configurado
- Emulador ou dispositivo físico

Verifique se está tudo correto:
```bash
flutter doctor
```

Em seguida execute os comandos:
```bash
flutter clean
flutter pub get
flutter run
```

O aplicativo será iniciado automaticamente no emulador ou dispositivo físico conectado.

---

**Autor**

Desenvolvido por **Ruan Oliveira**
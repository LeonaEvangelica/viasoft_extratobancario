# 💳 Projeto Extrato Bancário (Delphi + Firebird)

Este projeto é uma aplicação desktop desenvolvida em Delphi, com o objetivo de simular o gerenciamento de transações financeiras e exibir o extrato bancário atualizado em tempo real, com suporte ao cálculo automático de saldo e operações de inclusão, edição e exclusão de transações.

---

## ✅ Tecnologias Utilizadas

- **Delphi**: RAD Studio 12 Alexandria (32 bits)
- **Banco de dados**: Firebird 3.0 (32 bits)
- **Conexão**: FireDAC
- **Padrões de projeto**:
  - Strategy (para cálculo de saldo por tipo de transação)
  - Repository Pattern
  - Separação em camadas (Model, Repository, Service, View)
  - Helpers e Enum para tipo de transação

---

## 🗂️ Estrutura de Pastas

```
📁 src
├── 📁 Database
│   └── criar_tabela_transacao_firebird.sql
├── 📁 DataStructure
│   ├── uListaEncadeada.pas
│   └── uNoEncadeado.pas
├── 📁 Model
│   └── uModelTransacao.pas
├── 📁 Project
│   ├── 📁 Win32
│   │   └── 📁 Debug
│   │   │   ├── ExtratoBancario.exe
│   │   │   └── EXTRATOBANCARIO.FDB
│   ├── ExtratoBancario.dpr
│   └── ExtratoBancario.dproj
├── 📁 Repository
│   ├── uIRepositoryTransacao.pas
│   └── uRepositoryTransacao.pas
├── 📁 Service
│   └── uServiceTransacao.pas
├── 📁 Strategy
│   ├── uIStrategyTransacao.pas
│   ├── uStrategyContextTransacao.pas
│   ├── uStrategyCredito.pas
│   └── uStrategyDebito.pas
├── 📁 Utils
│   └── uTipoTransacaoHelper.pas
├── 📁 View
│   ├── frmPrincipal.pas
│   └── frmPrincipal.dfm
```

---

## ⚙️ Como Executar o Projeto

1. **Requisitos**:
   - RAD Studio 12 Alexandria (compilador Delphi Win32)
   - Firebird 3.0 32 bits
   - FireDAC configurado com suporte a Firebird

2. **Banco de Dados**:
   - O arquivo do banco `EXTRATOBANCARIO.FDB` deve estar na mesma pasta do executável.
   - A conexão usa:
     - Usuário: `SYSDBA`
     - Senha: `masterkey`
     - Servidor: `localhost`

3. **Compilação**:
   - Abra o projeto no Delphi.
   - Compile e execute.

---

## 🔑 Funcionalidades

- Adicionar nova transação (Crédito ou Débito)
- Editar informações dos clientes e descrição de transações existentes
- Excluir transações
- Cálculo automático do saldo após cada operação
- Interface gráfica amigável com `TStringGrid`
- Separação clara entre lógica de negócio e apresentação

---

## 📌 Observações

- O campo `TipoTransacao` é armazenado como `CHAR(1)` no banco:
  - `'C'` para Crédito
  - `'D'` para Débito
- O campo `Saldo` é calculado com base no valor da transação e no tipo, seguindo o padrão Strategy.
- O campo `Valor` não pode ser alterado após a inclusão.

---

## 🧱 Princípios SOLID Aplicados

Este projeto aplica principalmente o **Princípio da Responsabilidade Única (SRP)** e o **Princípio do Aberto/Fechado (OCP)**:

- **SRP (Single Responsibility Principle)**:  
  Cada classe possui uma responsabilidade clara — por exemplo, `TServiceTransacao` cuida da lógica de negócio, `TRepositoryTransacao` do acesso a dados, e as estratégias (`TStrategyCredito`, `TStrategyDebito`) são responsáveis por calcular o saldo com base no tipo de transação.

- **OCP (Open/Closed Principle)**:  
  O uso de Strategy permite que novas regras de cálculo de saldo possam ser adicionadas sem modificar o código existente, apenas estendendo o sistema com novas classes.

---

## 👨‍💻 Autor

Este projeto foi desenvolvido como parte de um exercício de arquitetura e domínio em Delphi.

---
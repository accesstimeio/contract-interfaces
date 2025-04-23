# AccessTime Smart Contract Interfaces

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](./LICENSE)
[![Solidity](https://img.shields.io/badge/Solidity-^0.8.21-yellow)](https://docs.accesstime.io/smart-contracts/introduction)

This repository contains the Solidity interface definitions for the [AccessTime](https://accesstime.io) protocol. Modular access control system based on token payments and time units. These interfaces define the expected behaviors for AccessTime core contracts, including access purchasing, modular extensions, and community voting.

## 📦 Installation

```bash
soldeer install @accesstimeio-contract-interfaces~1.0.0
```

or

```bash
forge soldeer install @accesstimeio-contract-interfaces~1.0.0
```

## 🧱 Interfaces

### `IAccessTime`

Core access management interface, including:

- Access time purchases (`purchase`, `purchasePackage`)
- Extras and packages support (`addExtra`, `addPackage`)
- Rate and module configuration
- Fund withdrawal and pause control

### `IAccessTimeFactory`

Deployment factory interface:

- Deploy new AccessTime contracts
- Toggle optional modules
- Manage fees and rates
- Update project metadata

### `IAccessVote`

Community voting system interface:

- Weekly voting epochs
- Star-based ratings
- Prevents double voting
- Factory management

## 📚 Documentation

You can find full documentation at  
👉 [docs.accesstime.io/smart-contracts/introduction](https://docs.accesstime.io/smart-contracts/introduction)

## 🔒 License

Licensed under [GPL-3.0-or-later](./LICENSE).

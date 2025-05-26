# Bitcoin Yield Aggregator Protocol (BYAP)

BYAP is a **decentralized Bitcoin-backed yield farming aggregator** built on the **Stacks Layer 2** smart contract platform. It enables users to earn optimized returns by distributing their STX tokens across multiple vetted DeFi protocols, while maintaining the security guarantees of Bitcoin through Stacks’ unique Proof-of-Transfer (PoX) consensus.

## 🌐 Overview

BYAP automatically allocates user deposits to selected yield-generating protocols based on configurable parameters such as base APY and protocol caps. It includes on-chain mechanisms for protocol management, user deposits, TVL tracking, and automated yield calculation over time.

### Key Features

* 🔐 **Bitcoin-secured yield** via Stacks PoX consensus
* 🤖 **Automated protocol allocation** and TVL limit enforcement
* 📊 **On-chain yield calculation** based on time-weighted returns
* 🛡️ **Risk controls** with protocol deactivation and max allocation settings
* 🧾 **Transparent state tracking** for users and protocols

## 🏗️ Architecture

```plaintext
+-----------------------+
|     Users (UI/API)    |
+-----------------------+
           |
           v
+-----------------------+
|   BYAP Smart Contract |
+-----------------------+
|   - add-protocol      |
|   - deposit           |
|   - withdraw          |
|   - calculate-yield   |
|   - deactivate-protocol|
+-----------------------+
     |           |        
     v           v
+-------------+ +----------------------+
| Protocol Map| | User Deposit Tracking|
| (Registry)  | | (user-deposits)      |
+-------------+ +----------------------+
     |
     v
+------------------------+
| Protocol TVL Tracking  |
| (protocol-total-deposits) |
+------------------------+
```

## 🧠 Core Concepts

### Protocol Registry

Defines a set of **supported protocols** including:

* `name`: Human-readable name
* `base-apy`: Annualized return rate in base units
* `max-allocation-percentage`: % cap relative to total system TVL
* `active`: Status for deposit eligibility

### Deposit Management

Users can deposit STX tokens into active protocols:

* Validates input
* Checks protocol caps and activeness
* Records user deposits and time of entry
* Updates total value locked (TVL) in the protocol

### Yield Calculation

Yield is computed linearly using:

```
Yield = (Base APY * Principal * Blocks Since Deposit) / (BASE-DENOMINATION * BLOCKS-PER-YEAR)
```

### Withdrawals

Users can withdraw principal + accrued yield. State is updated accordingly.

## 🧪 Functions Overview

### Protocol Admin Functions

| Function               | Description                   |
| ---------------------- | ----------------------------- |
| `add-protocol`         | Adds new yield protocol       |
| `deactivate-protocol`  | Marks a protocol as inactive  |
| `initialize-protocols` | Initializes default protocols |

### User Functions

| Function          | Description                                    |
| ----------------- | ---------------------------------------------- |
| `deposit`         | Stake STX tokens into selected protocol        |
| `withdraw`        | Withdraw STX and earned yield                  |
| `calculate-yield` | Read-only function for estimating earned yield |

## ⚙️ Constants & Parameters

| Name                        | Value           | Description                     |
| --------------------------- | --------------- | ------------------------------- |
| `MAX-PROTOCOLS`             | `5`             | Max protocols that can be added |
| `MAX-ALLOCATION-PERCENTAGE` | `100`           | Percent cap per protocol        |
| `BASE-DENOMINATION`         | `1_000_000`     | Yield math denominator          |
| `BLOCKS-PER-YEAR`           | `52596`         | Approximate Stacks block/year   |
| `MAX-DEPOSIT-AMOUNT`        | `1_000_000_000` | Cap per user deposit            |

## 🔐 Access Control

* Only the **contract owner** (`tx-sender` at deploy time) can add or deactivate protocols.
* Users can only deposit/withdraw their own funds.

## 🧾 Example Initialization

Two protocols are initialized by default:

```lisp
(try! (add-protocol u1 "Stacks Core Staking" u500 u20))
(try! (add-protocol u2 "Bitcoin Bridge Yield" u750 u30))
```

## 🛠️ Future Enhancements

* 📈 Dynamic APY updates based on market data or performance
* 🔄 Auto-rebalancing of deposits
* 🪙 Multi-asset support (via wrapped tokens)
* 📊 Dashboard integration for yield monitoring

## 🤝 Contributing

Pull requests and issue reports are welcome. For major changes, please open an issue first to discuss the scope and design.

# Tau Caste Deed Registry

A simple on-chain registry of deeds performed by members of the Tau castes.  
Users record actions, missions, and decisions tied to each caste and world.  
The community votes each deed as **honored** or **dishonored**, reflecting its alignment with the Greater Good.

Fully text-based, permissionless, and built for creative Warhammer 40K world-building on Base.

---

## Contract

Deployed on Base:  
`0x8e51bdeeba218ef29f1cb4660b20b453a861b78c`  
https://basescan.org/address/0x8e51bdeeba218ef29f1cb4660b20b453a861b78c#code

Main file: `contracts/TauCasteDeedRegistry.sol`

---

## How it works

Each deed entry stores:

- `caste` – Tau caste (Shas, Fio, Por, Kor, Aun)  
- `individual` – Name or designation  
- `deed` – Description of the action  
- `world` – Planet or theatre of operations  
- `remark` – Short contextual note  
- `honored` / `dishonored` – Community votes  

Entry **0** is a built-in example.

---

## Example

```solidity
recordDeed(
  "Shas",
  "Shas'vre Kais",
  "Held a defensive line for 19 hours without retreat.",
  "Dal'yth",
  "Exemplary discipline."
);

voteDeed(1, true);   // Honored

Closing Note
A small ledger of the Greater Good etched onto the chain —
a living record of courage, duty, and doctrine.
Every deed shapes how the Empire is remembered.

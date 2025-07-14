# 🎟️ NFT Event Ticketing on Abstract Chain

This project is part of my journey to explore **abstraction** and **consumer crypto** by building in public.

I'm using this project to learn and document how to build real-world use cases on [Abstract Chain](https://docs.abs.xyz/overview), focusing on **UX-first web3** that feels like Web2.

## 🌱 Goal

Create an event ticketing platform using **smart contracts**, a **Go backend**, and a **smooth frontend** powered by **Abstract tools** (like AGW – Abstract Global Wallet).

Each event = an NFT collection.  
Each ticket = an NFT owned by the buyer.  
Each scan = an on-chain verification of ownership.

---

## 🧱 Project Architecture

### 🔐 Smart Contracts

- Deploy a contract that handles NFT ticket collections per event.
- Mint NFT tickets to buyers.
- Verify ownership at event check-in.

### ⚙️ Backend (in Go)

- Deploy contracts based on event data (name, date, supply...).
- Expose APIs for:
  - Ticket purchase
  - Ownership verification

### 🖥️ Frontend

- Users can:
  - Create events
  - Buy tickets (with smooth Abstract UX)
  - View & present ticket at entry
- Uses AGW (Abstract Global Wallet) to abstract all the crypto logic.

---

## 🧪 Workflow

1. **Event owner** signs in.
2. Fills event info (name, date, location, supply...).
3. Backend deploys NFT contract on Abstract Chain.
4. Buyers mint NFT tickets directly to their wallet (via AGW).
5. At the venue, ownership is verified by scanning.

---

## 📚 Tech Stack

| Layer         | Tool                      |
| ------------- | ------------------------- |
| Smart Contract| Solidity |
| Backend       | Go                        |
| Frontend      | Nuxt          |

---

## 🧠 Why this project?

Because it’s simple enough to ship fast and **complex enough to learn deeply** about real consumer crypto UX.

---

## 📢 Build in Public

Follow my journey on [Twitter](https://x.com/17Mogza)  
I’m sharing every milestone, insight & struggle.

---

## 🪐 About Abstract Chain

> Abstract Chain is a consumer-focused Layer 2 built for invisible crypto UX and programmable smart wallets.  
Learn more: [docs.abs.xyz](https://docs.abs.xyz/overview)

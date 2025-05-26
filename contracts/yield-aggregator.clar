;; Title: Bitcoin Yield Aggregator Protocol (BYAP)
;; Summary: A decentralized yield farming aggregator built on Stacks Layer 2
;; Description: Maximizes Bitcoin-backed yield opportunities through automated 
;;              protocol allocation and risk management. Users can deposit STX 
;;              tokens across multiple vetted DeFi protocols while maintaining 
;;              Bitcoin security guarantees through Stacks' unique consensus model.

;; ERROR CONSTANTS

(define-constant ERR-UNAUTHORIZED (err u1))
(define-constant ERR-INSUFFICIENT-FUNDS (err u2))
(define-constant ERR-INVALID-PROTOCOL (err u3))
(define-constant ERR-WITHDRAWAL-FAILED (err u4))
(define-constant ERR-DEPOSIT-FAILED (err u5))
(define-constant ERR-PROTOCOL-LIMIT-REACHED (err u6))
(define-constant ERR-INVALID-INPUT (err u7))

;; PROTOCOL CONFIGURATION CONSTANTS

(define-constant CONTRACT-OWNER tx-sender)
(define-constant MAX-PROTOCOLS u5)
(define-constant MAX-ALLOCATION-PERCENTAGE u100)
(define-constant BASE-DENOMINATION u1000000)
(define-constant MAX-PROTOCOL-NAME-LENGTH u50)
(define-constant MAX-BASE-APY u10000) ;; 100% APY cap
(define-constant MAX-DEPOSIT-AMOUNT u1000000000) ;; 1 billion base units
(define-constant BLOCKS-PER-YEAR u52596) ;; Approximate Stacks blocks per year

;; DATA STORAGE MAPS

;; Protocol Registry: Stores all supported yield protocols
(define-map supported-protocols
  { protocol-id: uint }
  {
    name: (string-ascii 50),
    base-apy: uint,
    max-allocation-percentage: uint,
    active: bool,
  }
)

;; User Deposit Tracking: Individual user positions per protocol
(define-map user-deposits
  {
    user: principal,
    protocol-id: uint,
  }
  {
    amount: uint,
    deposit-time: uint,
  }
)

;; Protocol TVL Tracking: Total value locked per protocol
(define-map protocol-total-deposits
  { protocol-id: uint }
  { total-deposit: uint }
)
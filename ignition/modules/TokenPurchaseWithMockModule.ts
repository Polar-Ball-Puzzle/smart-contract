import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const TokenPurchaseWithMockModule = buildModule("TokenPurchaseWithMockModule", (m) => {
  const initialHolder = m.getAccount(0);

  const mockUSDT = m.contract("ERC20Mock", [
    "Mock USDT",         // name
    "USDT",              // symbol
    initialHolder,       // recipient of minted tokens
    1_000_000n * 10n ** 6n, // 1 million USDT (6 decimals)
    6                    // decimals
  ]);

  const tokenPurchase = m.contract("TokenPurchase", [mockUSDT]);

  return { mockUSDT, tokenPurchase };
});

export default TokenPurchaseWithMockModule;

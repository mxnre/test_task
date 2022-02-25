// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StackOverflow {
  struct Asset {
    address currency;
    address settlementCurrency;
    bytes32 marketObjectCodeRateReset;
    uint contractDealDate;
    uint statusDate;
    uint initialExchangeDate;
    uint maturityDate;
    uint purchaseDate;
    uint capitalizationEndDate;
    uint cycleAnchorDateOfInterestPayment;
    uint cycleAnchorDateOfRateReset;
    uint cycleAnchorDateOfScalingIndex;
    uint cycleAnchorDateOfFee;
    int notionalPrincipal;
    int nominalInterestRate;
    int accruedInterest;
    int rateMultiplier;
  }
  function createAsset(Asset memory asset)
    external
  {
    require(asset.currency != address(0x00), "Invalid currency address");
    require(asset.settlementCurrency != address(0x00), "Invalid settlement currency address");
    require(asset.marketObjectCodeRateReset != bytes32(0x00), "Code rate request is required");
    require(asset.contractDealDate != 0, "Contract deal date can't be empty");
    require(asset.statusDate != 0, "statusDate can't be empty");
    require(asset.initialExchangeDate != 0, "initialExchangeDate can't be empty");
    require(asset.maturityDate != 0, "maturityDate can't be empty");
    require(asset.purchaseDate != 0, "purchaseDate can't be empty");
    require(asset.capitalizationEndDate != 0, "capitalizationEndDate can't be empty");
    require(asset.cycleAnchorDateOfInterestPayment != 0, "cycleAnchorDateOfInterestPayment can't be empty");
    require(asset.cycleAnchorDateOfScalingIndex != 0, "cycleAnchorDateOfScalingIndex can't be empty");
    require(asset.cycleAnchorDateOfFee != 0, "cycleAnchorDateOfFee can't be empty");
    require(asset.notionalPrincipal != 0, "notionalPrincipalnotionalPrincipal can't be empty");
    require(asset.nominalInterestRate != 0, "nominalInterestRate can't be empty");
    require(asset.accruedInterest != 0, "accruedInterest can't be empty");
    require(asset.rateMultiplier != 0, "rateMultiplier can't be empty");

    saveDetailsToStorage(
      asset.currency,
      asset.settlementCurrency,
      asset.marketObjectCodeRateReset,
      asset.notionalPrincipal,
      asset.nominalInterestRate,
      asset.accruedInterest,
      asset.rateMultiplier
    );

    saveDatesToStorage(
      asset.contractDealDate,
      asset.statusDate,
      asset.initialExchangeDate,
      asset.maturityDate,
      asset.purchaseDate,
      asset.capitalizationEndDate,
      asset.cycleAnchorDateOfInterestPayment,
      asset.cycleAnchorDateOfRateReset,
      asset.cycleAnchorDateOfScalingIndex,
      asset.cycleAnchorDateOfFee
    );
  }

  function saveDetailsToStorage(
    address currency,
    address settlementCurrency,
    bytes32 marketObjectCodeRateReset,
    int notionalPrincipal,
    int nominalInterestRate,
    int accruedInterest,
    int rateMultiplier
  )
    internal
  {
      // Mock function
      // skip implementation
  }

  function saveDatesToStorage(
    uint contractDealDate,
    uint statusDate,
    uint initialExchangeDate,
    uint maturityDate,
    uint purchaseDate,
    uint capitalizationEndDate,
    uint cycleAnchorDateOfInterestPayment,
    uint cycleAnchorDateOfRateReset,
    uint cycleAnchorDateOfScalingIndex,
    uint cycleAnchorDateOfFee
  )
      internal
  {
      // Mock function
      // skip implementation
  }
}

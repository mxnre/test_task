// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * Test task "Investor registration"
 * A gas usage optimization
 *
 * function "setLeadInvestorForARound" need to be optimized by a gas usage.
 * current transaction cost > 140 000
 * expected transaction cost < 55 000
 *
 * Required to save the interface.
 * All other modifications are allowed.
 **/

library BytesLib {
  function toAddress(
    bytes memory _bytes,
    uint256 _start
  )
    internal
    pure
    returns (address)
  {
    require(_start + 20 >= _start, "toAddress_overflow");
    require(_bytes.length >= _start + 20, "toAddress_outOfBounds");
    address tempAddress;

    assembly {
      tempAddress := div(mload(add(add(_bytes, 0x20), _start)), 0x1000000000000000000000000)
    }

    return tempAddress;
  }

  function toUint64(
    bytes memory _bytes,
    uint256 _start
  )
    internal
    pure
    returns (uint64)
  {
    require(_start + 8 >= _start, "toUint64_overflow");
    require(_bytes.length >= _start + 8, "toUint64_outOfBounds");
    uint64 tempUint;

    assembly {
      tempUint := mload(add(add(_bytes, 0x8), _start))
    }

    return tempUint;
  }

  function toUint8(
    bytes memory _bytes,
    uint256 _start
  )
    internal
    pure
    returns (uint8)
  {
    require(_start + 1 >= _start, "toUint8_overflow");
    require(_bytes.length >= _start + 1 , "toUint8_outOfBounds");
    uint8 tempUint;

    assembly {
      tempUint := mload(add(add(_bytes, 0x1), _start))
    }

    return tempUint;
  }

  function slice(
    bytes memory _bytes,
    uint256 _start,
    uint256 _length
  )
    internal
    pure
    returns (bytes memory)
  {
    require(_length + 31 >= _length, "slice_overflow");
    require(_start + _length >= _start, "slice_overflow");
    require(_bytes.length >= _start + _length, "slice_outOfBounds");

    bytes memory tempBytes;

    assembly {
      switch iszero(_length)
      case 0 {
        tempBytes := mload(0x40)
        let lengthmod := and(_length, 31)
        let mc := add(add(tempBytes, lengthmod), mul(0x20, iszero(lengthmod)))
        let end := add(mc, _length)

        for {
          let cc := add(add(add(_bytes, lengthmod), mul(0x20, iszero(lengthmod))), _start)
        } lt(mc, end) {
          mc := add(mc, 0x20)
          cc := add(cc, 0x20)
        } {
          mstore(mc, mload(cc))
        }

        mstore(tempBytes, _length)
        mstore(0x40, and(add(mc, 31), not(31)))
      }
      default {
        tempBytes := mload(0x40)
        mstore(tempBytes, 0)
        mstore(0x40, add(tempBytes, 0x20))
      }
    }
    return tempBytes;
  }
}

contract GasUsageOptimisation {
  // struct Investor {
  //   address account; // 20 bytes
  //   uint64 deposit; // 8 bytes
  //   uint8 age; // 1 bytes
  //   bool kyc; // 1 bytes
  //   bool verificationStatus; // 1 bytes
  //   bool USResident; // 1 bytes
  // } // total 32 bytes

  using BytesLib for bytes;

  uint public investmentRound = 1;

  // investment round => investors info
  mapping(uint => bytes32) public investors;

  /**
    * @notice Lead investor registration
    *
    * @param investor A lead investor address
    * @param depositAmount The amount deposited by a investor
    * @param age Investor age
    * @param kycStatus Investor KYC status
    * @param isVerifiedInvestor Investor verification status
    * @param isUSResident Resident status
    **/
  function setLeadInvestorForARound(
    address investor,
    uint64 depositAmount,
    uint8 age,
    bool kycStatus,
    bool isVerifiedInvestor,
    bool isUSResident
  )
    external
  {
    require(investor != address(0x00), "Invalid investor address");
    require(depositAmount > 0, "A deposint amount should be more than zero");
    require(age > 18, "The investor should be adult");

    uint _investmentRound = investmentRound;
    bytes32 hash = bytes32(abi.encodePacked(investor, depositAmount, age, kycStatus, isVerifiedInvestor, isUSResident));

    investors[_investmentRound] = hash;
    investmentRound = _investmentRound + 1;
  }

  /**
    * @notice Returns a lead investor details
    **/
  function getInvestorDetailsByInvestmentRound(
    uint round
  )
    external
    view
    returns (
      address investor,
      uint64 depositAmount,
      uint8 age,
      bool kycStatus,
      bool isVerifiedInverstor,
      bool isUSResident
    )
  {
    bytes memory hash = abi.encodePacked(investors[round]);
    investor = hash.toAddress(0);
    depositAmount = hash.toUint64(20);
    age = hash.toUint8(28);
    kycStatus = bytesToBool(1, hash.slice(29, 1));
    isVerifiedInverstor = bytesToBool(1, hash.slice(30, 1));
    isUSResident = bytesToBool(1, hash.slice(31, 1));
  }

  // Helper functions
  function bytesToBool(
    uint _offst,
    bytes memory _input
  )
    private
    pure
    returns (bool _output)
  {
    uint8 x;

    assembly {
      x := mload(add(_input, _offst))
    }

    x==0 ? _output = false : _output = true;
  }
}

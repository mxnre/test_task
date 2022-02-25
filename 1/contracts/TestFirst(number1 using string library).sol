//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./string.sol";// String  library
contract TestFirst {
    //
    //
    //test1
    //
    //
    function buildStringByTemplate(
      string calldata template
         ) external pure returns (string memory) {
        bytes memory arr = bytes(template);
        bytes memory res = new bytes(arr.length);
        uint256 p = 0;
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] != 0x7b && arr[i] != 0x7d) {
                res[p] = arr[i];
                p += 1;
            }
        }
        return string(res);
    }
      //test2 
      // apple
      // electricity
      // year
    function  trimMirroringChars() external pure returns (string memory) {
        string[] memory str = new string[](3);
         str[0] = "apple";
         str[1] = "electricity";
         str[2] = "year";
        uint256 pos;
        uint256 len1;
        uint256 len2;
        bytes memory a;
        bytes memory b;
        string memory resTemp = str[0];

        for (uint256 i = 1; i < str.length; i++) {
          a = bytes(resTemp);
          b = bytes(str[i]);
          len1 = a.length;
          len2 = b.length;
          uint256 len = len1 > len2 ? len2 : len1;
          for (uint256 j = 0; j < len; j++) {
              if (a[len1 - j - 1] != b[j]) {
                pos = j ;
                break;
              }
          }
         
          if (pos == 0) {
            resTemp = Strings.concat(resTemp, str[i]);
          } else {
            string memory astr = Strings.substring(resTemp, int(len1 - pos), 0);
            string memory bstr = Strings.substring(str[i], int(len2 - pos), int(pos));
            resTemp = Strings.concat(astr, bstr);
          }
        }
      return resTemp;
   }
}

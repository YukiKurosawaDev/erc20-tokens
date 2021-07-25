// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract s {
using SafeMath for uint256;

    function test(uint256 val) public view  returns (uint256){
        uint256 saleFee=1000;
        uint256 saleFee2=uint256(1 * 10 ** 18).div(saleFee);
        uint256 maxSale=1000;
        
        //if(recipient==address(this)){
            if(val>=saleFee){
                val=val.sub(saleFee);
                uint256 tokenGet=val.mul(saleFee2).div(1 * 10 ** 3);
                if(val <= maxSale){
                    if(tokenGet<=9*10**18){
                        //transferBalanceToUser(sender,tokenGet);
                        return tokenGet;
                    }
                    else{
                        //transferTokenToUser(sender,val);
                        return val;
                    }
                }
                else{
                    uint left=val.sub(maxSale);
                    if(left<=9*10**18){
                        //transferTokenToUser(sender,left.mul(1 * 10 ** 3).div(saleFee2));
                        //transferBalanceToUser(sender,maxSale.mul(saleFee2).div(1 * 10 ** 3));
                        return left.mul(saleFee2).div(1 * 10 ** 3);
                    }
                    else{
                        //transferTokenToUser(sender,val);
                        return val;
                    }
                }
            }
        //}
        
        return 0;
    }
}
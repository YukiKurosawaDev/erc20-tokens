// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./YERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract YNPresalePair is ERC20, Ownable {

    using SafeMath for uint256;
    

    constructor() ERC20("Yuki Presale Pair", "YN-PPs") {
        
    }

    uint256 maxBuy=1 * 10 ** 18;
    uint256 buyFee=1 * 10 ** 18;
    uint256 maxSale=1 * 10 ** 18;
    uint256 saleFee2=1 * 10 ** 18;

    function buy() external payable{
                
        YERC20 yerc20=YERC20(address(this));       
        
        uint256 val=msg.value;
       
        uint256 tokenGet=val.mul(1 * 10 ** decimals()).div(buyFee);
        if(tokenGet <= maxBuy){
            if(tokenGet<=yerc20.balanceOf(address(this))){
                //transferTokenToUser(msg.sender,tokenGet);
            }
            else{
                //transferBalanceToUser(msg.sender,val);
            }
        }
        else{
            uint left=tokenGet.sub(maxBuy);
            if(maxBuy<=yerc20.balanceOf(address(this))){
                //transferBalanceToUser(msg.sender,left.div(1 * 10 ** decimals()).mul(buyFee));
                //transferTokenToUser(msg.sender,maxBuy);
            }
            else{
                //transferBalanceToUser(msg.sender,val);
            }
        }
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {        
        bool ret= super.transfer(recipient, amount);
        
        address sender=msg.sender;
        uint256 val=amount;
        
        if(recipient==address(this)){
            uint256 tokenGet=val.mul(saleFee2).div(1 * 10 ** decimals());
            if(val <= maxSale){
                if(tokenGet<=address(this).balance){
                    //transferBalanceToUser(sender,tokenGet);
                }
                else{
                    //transferTokenToUser(sender,val);
                }
            }
            else{
                uint left=val.sub(maxSale);
                if(left<=address(this).balance){
                    //transferTokenToUser(sender,left);
                    //transferBalanceToUser(sender,maxSale.mul(saleFee2).div(1 * 10 ** decimals()));
                }
                else{
                    //transferTokenToUser(sender,val);
                }
            }
        }
        
        
        return ret;
    }
}
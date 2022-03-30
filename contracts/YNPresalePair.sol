// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./YERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract YNPresalePair is ERC20, Ownable {

    using SafeMath for uint256;

    uint256 _buyFee=0;
    uint256 _saleFee=0;
    uint256 ETH=1 * 10 ** 18;

    uint256 _maxBuy=0;
    uint256 _maxSale=0;
    uint8 _decimal=18;

    constructor(address token,uint256 maxAmount,uint256 amountPerETH,uint maxBuy,uint maxSale) ERC20("Yuki Presale Pair", "YN-PPs") {
        _decimal=YERC20(token).decimals();
        _mint(msg.sender, maxAmount * 10 ** _decimal);
        _buyFee=ETH / amountPerETH;
        _saleFee=ETH / amountPerETH;
        _maxBuy=maxBuy;
        _maxSale=maxSale;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimal;
    }

    function transferTokenToUser(address user,uint256 money) public onlyOwner {
        _transferTokenToUser(user,money);
    }

    function _transferTokenToUser(address user,uint256 money) private {
        YERC20 yerc20=YERC20(address(this));
        require(money<=yerc20.balanceOf(address(this)));
        yerc20.transfer(user,money);
    }

    function buy() external payable{
                
        YERC20 yerc20=YERC20(address(this));       
        
        uint256 val=msg.value;
       
        uint256 tokenGet=val.mul(1 * 10 ** _decimal).div(_buyFee);
        if(tokenGet <= _maxBuy){
            if(tokenGet<=yerc20.balanceOf(address(this))){
                _transferTokenToUser(msg.sender,tokenGet);
            }
            else{
                payable(msg.sender).transfer(val);
            }
        }
        else{
            require(val<=_maxBuy,"YNPresale: AMOUNT SALE AMOUNT EXCEED.");
        }
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {        
        bool ret= super.transfer(recipient, amount);
        
        uint256 val=amount;
        
        if(recipient==address(this)){
            uint256 tokenGet=val.mul(_saleFee).div(1 * 10 ** _decimal);
            if(val <= _maxSale){
                if(tokenGet<=address(this).balance){
                    payable(msg.sender).transfer(tokenGet);
                }
                else{
                    payable(msg.sender).transfer(val);
                }
            }
            else{
                require(val<=_maxSale,"YNPresale: MAX SALE AMOUNT EXCEED.");
            }
        }
        
        
        return ret;
    }

    function transferBalanceToYuki(uint256 money) public onlyOwner {
        require(money<=address(this).balance);
        payable(owner()).transfer(money);
    }
    
    function transferBalanceToUser(address user,uint256 money) public onlyOwner {
        require(money<=address(this).balance);
        payable(user).transfer(money);
    }
}
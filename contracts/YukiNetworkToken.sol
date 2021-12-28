// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./YERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract YukiNetworkToken is ERC20, ERC20Burnable, Pausable, Ownable {
    
    using SafeMath for uint256;
    
    constructor() ERC20("Yuki Network Token", "YUKI") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }  
    
    // ERC20 Logics
    function decimals() public view virtual override returns (uint8) {
        return 3;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }    
	
    //Functions below is used for recovery
    function generator() public pure returns (string memory){
        return "Remix 0.5.5 with Solidity 0.8.11 based on Yuki Chain Wallet V3";
    }
    
    function license() public pure returns (string memory){
        return "MIT License";
    }
    
    function authorIdentifier() public pure returns (string memory){
        return "Yuki Kurosawa (@YukiKurosawaDev)";
    }
    
    function authorTwitter() public pure returns (string memory){
        return "https://twitter.com/YukiKurosawaDev";
    }
    
    function balanceOfWallet() public view returns (uint256){
        return address(this).balance;
    }
    
    function balanceOfWalletToken(address token) public view returns (uint256){
        YERC20 yerc20=YERC20(token);
        return yerc20.balanceOf(address(this));
    }
    
    
    receive () external payable{
                
    }
    
    function transferBalanceToYuki(uint256 money) public onlyOwner {
        require(money<=address(this).balance);
        payable(owner()).transfer(money);
    }
    
    function transferBalanceToUser(address user,uint256 money) public onlyOwner {
        require(money<=address(this).balance);
        payable(user).transfer(money);
    }
    
    function transferTokenToUser(address user,uint256 money) public onlyOwner {
        YERC20 yerc20=YERC20(address(this));
        require(money<=yerc20.balanceOf(address(this)));
        yerc20.transfer(user,money);
    }
    
    function transferTokenToYuki(address token,uint256 money) public onlyOwner {
        YERC20 yerc20=YERC20(token);
        require(money<=yerc20.balanceOf(address(this)));
        yerc20.transfer(address(owner()),money);
    }
    
    function nameOfToken(address token) public view returns(string memory) {
        YERC20 yerc20=YERC20(token);
        return yerc20.name();
    }
    
    function symbolOfToken(address token) public view returns(string memory) {
        YERC20 yerc20=YERC20(token);
        return yerc20.symbol();
    }
}
// File: contracts\YERC20.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface YERC20 {
    /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint256);

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory);

  /**
  * @dev Returns the token name.
  */
  function name() external view returns (string memory);

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address _owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: contracts\YukiWallet.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Test {
    
    address owner;
    
    constructor() {
        owner=msg.sender;
    }
    
    function name() public pure returns (string memory){
        return "Yuki's Chain Wallet";
    }
    
    function symbol() public pure returns (string memory){
        return "YUKIWALLET";
    }
    
    function generator() public pure returns (string memory){
        return "Remix 0.4.1 with Solidity 0.8.4";
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
    
    function addressOfYuki() public view returns (address){
        return address(owner);
    }
    
    function balanceOfYuki() public view returns (uint256){
        return owner.balance;
    }
    
     function balanceOfYukiToken(address token) public view returns (uint256){
        YERC20 yerc20=YERC20(token);
        return yerc20.balanceOf(owner);
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
    
    function transferBalanceToYuki(uint256 money) public {
        require(money>=address(this).balance);
        payable(owner).transfer(money);
    }
    
    function transferTokenToYuki(address token,uint256 money) public{
        YERC20 yerc20=YERC20(token);
        require(money>=yerc20.balanceOf(address(this)));
        yerc20.transfer(address(owner),money);
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

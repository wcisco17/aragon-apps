pragma solidity 0.4.18;

import "../Vault.sol";
import "./standards/ERC20.sol";


contract ERC20Connector is Vault, IConnector {
    function deposit(address token, address who, uint256 value, bytes how) payable external returns (bool){
        require(how.length == 0); // sending data is not supported in ERC20
        // require(who == msg.sender); // maybe actual sender wants to signal who sent it

        require(ERC20(token).transferFrom(who, this, value));

        Deposit(token, who, value);
    }

    function transfer(address token, address to, uint256 value, bytes how) external returns (bool) {
        require(how.length == 0); // sending data is not supported in ERC20

        require(ERC20(token).transfer(to, value));

        Transfer(token, to, value);
    }

    function balance(address token) public view returns (uint256) {
        return ERC20(token).balanceOf(this);
    }
}
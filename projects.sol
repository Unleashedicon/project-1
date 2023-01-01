// SPDX-License-Identifier: MIT
pragma solidity ^0.5.16;
contract Transaction{
    // The contract's balance.
    uint public balance;

    // Constructor function to set the initial balance.
constructor() public {
        balance = 200;
    } 
    
    // Ensure that the account is not frozen.
    modifier notFrozen {
  require(!frozen[msg.sender], "Account is frozen");
  _;
}
    function SetBalance(uint _newbalance) public notFrozen{
         // Ensure that the new balance is greater than 0.
        require(_newbalance > 0, "Your balance is not greater than 0");
        balance = _newbalance;
    }
    function deposit(uint _amount) public notFrozen {
        // Ensure that the amount to be deposited is greater than 0.
        require(_amount > 0, "Amount must be greater than 0");
        balance += _amount;
    }
    function withdraw(uint _amount) public notFrozen {
        // Ensure that the amount to be deposited is greater than 0.
        require(_amount > 0, "Amount must be greater than 0");
         // Ensure that the amount to be withdrawn is less than or equal to the current balance.
        require(_amount <= balance, "Amount is less than your balance");
        balance -= _amount;
        // Revert the transaction with an error message if the withdrawal fails.
        revert("Transaction failed");
    }
    function transfer(address payable _to, uint _amount) public notFrozen {

        require(_to != address(0), "Recipient address is invalid");
        // Ensure that the amount to be deposited is greater than 0.
        require(_amount > 0, "Amount must be greater than 0");
        // Ensure that the amount to be transferred is less than or equal to the current balance.
        require(_amount <= balance, "your balance is insufficient");
        balance -= _amount;
        // Transfer the funds to the recipient account.
        _to.transfer(_amount);
        // Ensure that the transfer was successful.
        assert(_amount == 0);
    }
    // Mapping to store the balances of individual accounts.
    mapping (address => uint) public balances;
    function checkbalances(address _account) public view returns(uint) {
        return balances[_account];
    }

    // Mapping to store the frozen status of individual accounts.
    mapping (address => bool) public frozen;
    function freezeAccount(address _account) public notFrozen {
        frozen[_account] = true;
    }
}
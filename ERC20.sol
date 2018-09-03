pragma solidity ^0.4.16;

interface tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData) external; }

contract TokenREC20 {
    // Public varible of the Token
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    // 18 decimals is the strongly suggested default, avoid changing it
    uint256 public totalSupply;

    // this creates an array with all balances
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    // This generates a public event on the blockchain that will notify clients
    event Tranfer(address indexed from, address indexed to, uint256 value);

    // This generates a public event on the blockchain that will notify clients
    event Approval(address indexed _owner, address indexed _sender, uint256 _value);

    // This notifies the clients about amount burnt
    event Burn(address indexed from, uint256 value);

    // Constructor function
    // Initilizes contract with inital supply tokens to creator of the contract
    function TokenERC20(
        uint256 initialSupply,
        string tokenName,
        string tokenSymbol
    ) public {
        totalSupply = initialSupply * 10 ** uint256(decimals); // Update total supply with the decimal amount
        balanceOf[msg.sender] = totalSupply; // Give creator all inital token
        name = tokenName; // Set the name for display purposes
        symbol = tokenSymbol; // Set the symbol for display purposes
    }

    // Internal tranfer, only can be called by this contract
    function _tranfer(address _from, address _to, uint _value) internal {

        // Prevent tranfer to 0x0 address. Use burn() instead
        require(_to !=0x0);

        // Check if the sender has enough
        require(balanceOf[_from] >= _value);

        // Check for overflows
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        // Save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];

        // subtract from the sender
        balanceOf[_from] -= _value;

        // Add the same to the recipient
        balanceOf[_to] += _value;

        emit Tranfer(_from, _to, _value);

        // Asserts are used to  use static analysis to find bugs in your code. They should never fail
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    //
}
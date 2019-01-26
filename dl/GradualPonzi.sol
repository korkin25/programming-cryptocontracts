///////////////////////////////////
// see https://etherscan.io/address/0xf89e29fd10716757d1d3d2997975c639c8750e92#code

contract GradualPonzi {
    address[] public investors;
    mapping (address => uint) public balances;
    uint public constant MINIMUM_INVESTMENT = 1e15;

    function GradualPonzi () public {
        investors.push(msg.sender);
    }

    function () public payable {
        require(msg.value >= MINIMUM_INVESTMENT);
        uint eachInvestorGets = msg.value / investors.length;
        for (uint i=0; i < investors.length; i++) {
            balances[investors[i]] += eachInvestorGets;
        }
        investors.push(msg.sender);
    }

    function withdraw () public {
        uint payout = balances[msg.sender];
        balances[msg.sender] = 0;
        msg.sender.transfer(payout);
    }
}

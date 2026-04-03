// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract PredictionMarket is ERC1155, Ownable, ReentrancyGuard {
    IERC20 public immutable collateralToken;
    
    uint256 public constant YES = 0;
    uint256 public constant NO = 1;
    
    bool public resolved;
    uint256 public winningOutcome;

    event MarketResolved(uint256 winningOutcome);
    event SharesPurchased(address indexed buyer, uint256 outcome, uint256 amount);

    constructor(address _collateralToken, string memory _uri) 
        ERC1155(_uri) 
        Ownable(msg.sender) 
    {
        collateralToken = IERC20(_collateralToken);
    }

    /**
     * @dev Simple 1:1 minting for demo. 1 USDC = 1 Yes + 1 No share.
     */
    function mintShares(uint256 _amount) external nonReentrant {
        collateralToken.transferFrom(msg.sender, address(this), _amount);
        _mint(msg.sender, YES, _amount, "");
        _mint(msg.sender, NO, _amount, "");
    }

    /**
     * @dev Resolves the market based on external data.
     */
    function resolve(uint256 _winningOutcome) external onlyOwner {
        require(!resolved, "Already resolved");
        require(_winningOutcome == YES || _winningOutcome == NO, "Invalid outcome");
        
        resolved = true;
        winningOutcome = _winningOutcome;
        emit MarketResolved(_winningOutcome);
    }

    /**
     * @dev Winners redeem their shares for the collateral.
     */
    function redeem(uint256 _amount) external nonReentrant {
        require(resolved, "Market not resolved");
        require(balanceOf(msg.sender, winningOutcome) >= _amount, "Insufficient winning shares");

        _burn(msg.sender, winningOutcome, _amount);
        collateralToken.transfer(msg.sender, _amount);
    }
}

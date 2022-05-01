// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

interface IUniswap{
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, 
        address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function WETH() external pure returns (address);
}

interface IERC20{
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}
contract UniswapV2Contract{
    IUniswap uniswap;
    
    constructor(address _uniswap){
        uniswap = IUniswap(_uniswap);
    }

    function swapTokensForETH(
        address token,
        uint256 amountIn,
        uint256 amountOutMin,
        uint256 deadline)
        external {
            IERC20(token).approve(address(this), amountIn);
            IERC20(token).transferFrom(msg.sender, address(this), amountIn);
            address[] memory path = new address[](2);
            //First Element is what you spend, Second is what you get in return
            path[0] = token;
            path[1] = uniswap.WETH();
            uniswap.swapExactTokensForETH(amountIn, amountOutMin, path, msg.sender, deadline);
        }
    }


import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PolarSkinNFT is ERC1155, Ownable {
    mapping(uint256 => uint256) public prices;
    GameToken public token;

    constructor(address tokenAddress) ERC1155("https://game.example/api/item/{id}.json") {
        token = GameToken(tokenAddress);
    }

    function setPrice(uint256 tokenId, uint256 price) external onlyOwner {
        prices[tokenId] = price;
    }

    function buySkin(uint256 tokenId) external {
        require(prices[tokenId] > 0, "Skin not for sale");
        require(token.balanceOf(msg.sender) >= prices[tokenId], "Insufficient balance");
        
        token.transferFrom(msg.sender, owner(), prices[tokenId]);
        _mint(msg.sender, tokenId, 1, "");
    }
}

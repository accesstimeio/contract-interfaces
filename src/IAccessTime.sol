// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.21;

/**
 * @title AccessTime
 * @dev This contract extends the TokenRate, ExtraTime, Package, Pausable contracts and
 * provides functionality for purchasing and managing access time.
 */
interface IAccessTime {
    struct Extra {
        uint256 unixTime; // unixTime of the extra
        uint256 percent; // Percentage of the extra
        bool exist;
    }

    struct PackageTime {
        uint256 unixTime;
        bool exist;
    }

    // Mapping to store user access times
    function accessTimes(address client) external view returns (uint256 time);
    // Mapping to store extras
    function extras(uint256 extraId) external view returns (Extra memory extraDetail);
    // Mapping to store packages
    function packages(uint256 packageId) external view returns (PackageTime memory package);
    // Mapping to store payment token rates
    function tokenRates(address paymentToken) external view returns (uint256 rate);
    // Version of AccessTime
    function VERSION() external view returns (uint8);

    /**
     * @dev Emitted when a user purchases access time.
     * @param user The user who made the purchase.
     * @param amount The amount of access time have in seconds.
     * @param paymentToken The address of the payment token used for the purchase.
     */
    event Purchased(address indexed user, uint256 indexed amount, address indexed paymentToken);
    /**
     * @dev Emitted when a user purchases a package.
     * @param user The user who made the purchase.
     * @param amount The amount of access time have in seconds.
     * @param paymentToken The address of the payment token used for the purchase.
     * @param packageID The ID of the purchased package.
     */
    event PurchasedPackage(
        address indexed user, uint256 indexed amount, address indexed paymentToken, uint256 packageID
    );
    /**
     * @dev Emitted when an extra is added or updated.
     * @param extraID The ID of the extra.
     * @param unixTime The unixTime limit of the extra.
     * @param percent The percentage of the extra.
     */
    event ExtraUpdated(uint256 indexed extraID, uint256 indexed unixTime, uint256 indexed percent);
    /**
     * @dev Emitted when extra time is added for a user.
     * @param user The address of the user.
     * @param unixTime The unixTime of extra time added.
     * @param newTime The new time for the user.
     */
    event ExtraTimed(address indexed user, uint256 indexed unixTime, uint256 indexed newTime);
    /**
     * @dev Emitted when a package is added or updated.
     * @param packageID The ID of the package.
     * @param time The time of the package.
     */
    event PackageUpdated(uint256 indexed packageID, uint256 indexed time);
    /**
     * @dev Emitted when a payment token rate is updated.
     * @param paymentToken The address of the payment token.
     * @param rate The updated rate for the payment token.
     */
    event RateUpdate(address indexed paymentToken, uint256 indexed rate);
    /**
     * @dev Emitted when module status updated
     * @param moduleKey Module Key
     * @param newStatus Module Status
     */
    event ModuleStatusUpdated(bytes32 indexed moduleKey, bool indexed newStatus);

    /// @notice Related purchase must be worth at least 1 second
    error PurchaseMinOneSecond();
    /// @notice Purchase is not acceptable to given package
    error PurchaseTimeNotEqualToPackageTime();
    /// @notice ExtraTime is not found
    error ExtraTimeNotFound(uint256 extraID);
    /// @notice Package is not found
    error PackageNotFound(uint256 packageID);
    /// @notice Payment cannot be done with 2 currency
    error EtherOrToken();
    /// @notice Zero payment cannot acceptable
    error PaymentCantBeZero();
    /// @notice Payment method is not supported
    error NotSupported(address paymentToken);
    /// @notice Ether withdraw failed
    error WithdrawEtherFailed();
    /// @notice Deployer address cant be zero address
    error DeployerCantBeZeroAddress();
    /// @notice Caller must be deployer
    error OnlyDeployerAuthorized();
    /// @notice Modules status is not as expected
    error ModuleNotAsExpected(bytes32 moduleName);
    /// @notice Given fee is higher than MAX_FEE_PERCENT
    error InvalidFee();

    /**
     * @dev Allows a user to purchase access time.
     * @param amount The payment amount for the access time purchase.
     * @param paymentToken The address of the payment token (0 for Ether).
     */
    function purchase(uint256 amount, address paymentToken) external;

    /**
     * @dev Allows a user to purchase a package.
     * @param amount The payment amount for the package purchase.
     * @param paymentToken The address of the payment token (0 for Ether).
     * @param packageID The ID of the package to purchase.
     */
    function purchasePackage(uint256 amount, address paymentToken, uint256 packageID) external;

    /**
     * @dev Adds a new extra.
     * @param unixTime The unixTime limit of the extra.
     * @param percent The percentage of the extra.
     */
    function addExtra(uint256 unixTime, uint256 percent) external;

    /**
     * @dev Updates an existing extra.
     * @param extraID The ID of the extra.
     * @param unixTime The new unixTime limit of the extra.
     * @param percent The new percentage of the extra.
     */
    function updateExtra(uint256 extraID, uint256 unixTime, uint256 percent) external;

    /**
     * @dev Only deployer can toggle module status.
     */
    function toggleExtraTimeModule() external;

    /**
     * @dev Adds a new package.
     * @param unixTime The time of the package.
     */
    function addPackage(uint256 unixTime) external;

    /**
     * @dev Updates an existing package.
     * @param packageID The ID of the package.
     * @param unixTime The new time of the package.
     */
    function updatePackage(uint256 packageID, uint256 unixTime) external;

    /**
     * @dev Only deployer can toggle module status.
     */
    function togglePackageModule() external;
    
    /**
     * @dev Updates the rate for a payment token.
     * @param paymentToken The address of the payment token.
     * @param rate The new rate for the payment token.
     */
    function updateRate(address paymentToken, uint256 rate) external;

    /**
     * @dev Allows the contract owner to withdraw Ether balance from the contract.
     */
    function withdrawEther() external;

    /**
     * @dev Allows the contract owner to withdraw tokens from the contract.
     * @param tokenAddress The address of the token to withdraw.
     */
    function withdrawToken(address tokenAddress) external;

    /**
     * @dev Pause deploy functions
     */
    function pause() external;

    /**
     * @dev Unpause deploy functions
     */
    function unpause() external;
}

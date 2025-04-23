// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.21;

/**
 * @title AccessTimeFactory
 * @dev This contract extends the TokenRate contract and provides a factory for deploying AccessTime
 * contracts.
 */
interface IAccessTimeFactory {
    // Array to store deployed AccessTime contracts
    function contracts(uint256 deployId) external view returns (address accessTime);

    // Array to store deployment details
    function deploymentDetails(address accessTime)
        external
        view
        returns (
            bool status,
            uint256 id,
            bool includedExtraTime,
            bool includedPackageModule,
            string memory name,
            string memory description,
            string memory website
        );

    // Array to store accessTime fees
    function fees(address accessTime) external view returns (uint256 fee);

    // Mapping to store payment token rates
    function tokenRates(address paymentToken) external view returns (uint256 rate);

    // Version of AccessTime
    function VERSION() external view returns (uint8);

    /**
     * @dev Emitted when a new AccessTime contract is deployed.
     * @param id The ID of the contract.
     * @param user The user who deployed the contract.
     * @param contractAddress The address of the deployed AccessTime contract.
     */
    event Deployed(uint256 indexed id, address indexed user, address indexed contractAddress);
    /**
     * @dev Emitted when a AccessTime deployment details updated, added due to website domain checks
     * @param contractAddress The address of AccessTime contract.
     */
    event DeploymentDetailsUpdated(address indexed contractAddress);
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

    /// @notice Given deployment id is not deployed
    error InvalidDeployment(uint256 deploymentId);
    /// @notice Caller is unauthorized
    error Unauthorized();
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
     * @dev Deploys a new AccessTime contract.
     * @param amount The payment amount for deploying the contract.
     * @param paymentToken The address of the payment token (0 for Ether).
     * @param activateExtraTime The status of the extra module for the AccessTime contract.
     * @param activatePackageModule The status of the package module for the AccessTime contract.
     * @param details The details of project, 0 index is name, 1 index is description, 2 index is website
     */
    function deploy(
        uint256 amount,
        address paymentToken,
        bool activateExtraTime,
        bool activatePackageModule,
        string[3] memory details
    )
        external
        payable;

    /**
     * @dev Updates deployment details by owner
     * @param deploymentId Deployment Id
     * @param details The details of project, 0 index is name, 1 index is description, 2 index is website
     */
    function updateDeploymentDetails(uint256 deploymentId, string[3] memory details) external;

    /**
     * @dev Toggle ExtraTime module by owner
     * @param deploymentId Deployment Id
     */
    function toggleExtraTimeModule(uint256 deploymentId) external;

    /**
     * @dev Toggle Package module by owner
     * @param deploymentId Deployment Id
     */
    function togglePackageModule(uint256 deploymentId) external;

    /**
     * @dev Updates the default fee percentage for withdraw fee percent.
     * @param percent The new fee percentage.
     */
    function updateDefaultFee(uint256 percent) external;

    /**
     * @dev Updates the accessTime fee percentage for withdraw fee percent.
     * @param percent The new fee percentage.
     */
    function updateFee(address accessTime, uint256 percent) external;

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

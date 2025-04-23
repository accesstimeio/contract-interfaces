// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.21;

/**
 * @title AccessVote
 * @dev Weekly voting system of AccessTimes
 */
interface IAccessVote {
    function factory() external view returns (address);

    /// @notice History of participant votes on AccessTimes
    function votes(uint256 epochWeek, address accessTime, address participant) external view returns (uint256 star);

    /// @notice Event of participant vote on AccessTime
    event Voted(uint256 indexed epochWeek, address indexed accessTime, address indexed participant, uint256 star);

    /// @notice Given AccessTime is not deployed
    error InvalidAccessTime();

    /// @notice Participant already voted before
    error AlreadyParticipated();

    /// @notice Given address is invalid
    error ZeroAddress();

    /// @notice Given star is invalid
    error InvalidStar();

    /**
     * @dev Participate vote to given AccessTime
     * @param star Star count of AccessTime vote
     */
    function participate(address accessTime, uint256 star) external;

    /**
     * @dev Update factory address
     * @param factoryAddress New AccessTime Factory address
     */
    function updateFactory(address factoryAddress) external;

    /**
     * @dev Pause contract
     */
    function pause() external;

    /**
     * @dev Unpause contract
     */
    function unpause() external;
}

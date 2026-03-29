// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

/// @title Tau Caste Deed Registry
/// @notice Record deeds performed by members of the Tau castes and vote if they honor the Greater Good.
/// @dev Simple, safe, text-only contract.

contract TauCasteDeedRegistry {

    struct Deed {
        string caste;        // Tau caste (Shas, Fio, Por, Kor, Aun)
        string individual;   // Name or designation
        string deed;         // Description of the action
        string world;        // Location or world
        string remark;       // Short note or context
        address creator;     // Who recorded it
        uint256 honored;     // Honored votes
        uint256 dishonored;  // Dishonored votes
        uint256 createdAt;   // Timestamp
    }

    Deed[] public logs;

    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event DeedRecorded(uint256 indexed id, string caste, string individual, address indexed creator);
    event DeedVoted(uint256 indexed id, bool honored, uint256 honoredVotes, uint256 dishonoredVotes);

    constructor() {
        logs.push(
            Deed({
                caste: "Example Caste (Fill your own below)",
                individual: "Example individual",
                deed: "Describe the deed",
                world: "Example world",
                remark: "Short remark",
                creator: address(0),
                honored: 0,
                dishonored: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordDeed(
        string calldata caste,
        string calldata individual,
        string calldata deed,
        string calldata world,
        string calldata remark
    ) external {
        require(bytes(caste).length > 0, "Caste required");

        logs.push(
            Deed({
                caste: caste,
                individual: individual,
                deed: deed,
                world: world,
                remark: remark,
                creator: msg.sender,
                honored: 0,
                dishonored: 0,
                createdAt: block.timestamp
            })
        );

        emit DeedRecorded(logs.length - 1, caste, individual, msg.sender);
    }

    function voteDeed(uint256 id, bool honored) external {
        require(id < logs.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;

        Deed storage d = logs[id];

        if (honored) {
            d.honored += 1;
        } else {
            d.dishonored += 1;
        }

        emit DeedVoted(id, honored, d.honored, d.dishonored);
    }

    function totalDeeds() external view returns (uint256) {
        return logs.length;
    }
}

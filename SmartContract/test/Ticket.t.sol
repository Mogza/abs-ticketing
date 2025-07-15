// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/Ticket.sol";

contract TicketTest is Test {
    Ticket ticket;
    address payable organizer = payable(address(0xABCD));
    address buyer = address(0xBEEF);

    string constant NAME = "Test Event Ticket";
    string constant SYMBOL = "TET";
    string constant EVENT_NAME = "Test Event";
    uint256 constant EVENT_DATE = 1730000000;
    uint256 constant MAX_SUPPLY = 100;
    uint256 constant TICKET_PRICE = 0.1 ether;
    string constant BASE_URI = "ipfs://Qm.../";

    function setUp() public {
        vm.deal(organizer, 0);

        vm.prank(organizer);
        ticket = new Ticket(
            NAME,
            SYMBOL,
            EVENT_NAME,
            EVENT_DATE,
            MAX_SUPPLY,
            TICKET_PRICE,
            BASE_URI,
            organizer
        );

        vm.deal(buyer, 1 ether);
    }

    function testInitialValues() public {
        assertEq(ticket.name(), NAME);
        assertEq(ticket.symbol(), SYMBOL);
        assertEq(ticket.eventName(), EVENT_NAME);
        assertEq(ticket.eventDate(), EVENT_DATE);
        assertEq(ticket.ticketPrice(), TICKET_PRICE);
        assertEq(ticket.maxSupply(), MAX_SUPPLY);
        assertEq(ticket.owner(), organizer);
    }

    function testPublicMinting() public {
        vm.prank(buyer);
        ticket.mint{value: TICKET_PRICE}();

        assertEq(ticket.totalSupply(), 1);
        assertEq(ticket.ownerOf(0), buyer);
    }

    function testRevertIfNotEnoughETH() public {
        vm.prank(buyer);
        vm.expectRevert("Not enough ETH sent");
        ticket.mint{value: TICKET_PRICE - 0.01 ether}();
    }

    function testRevertIfSoldOut() public {
        for (uint256 i = 0; i < MAX_SUPPLY; i++) {
            vm.prank(buyer);
            ticket.mint{value: TICKET_PRICE}();
        }

        vm.prank(buyer);
        vm.expectRevert("All tickets sold");
        ticket.mint{value: TICKET_PRICE}();
    }

    function testOwnerCanWithdraw() public {
        vm.prank(buyer);
        ticket.mint{value: TICKET_PRICE}();

        uint256 before = organizer.balance;

        vm.prank(organizer);
        ticket.withdraw();

        assertEq(organizer.balance, before + TICKET_PRICE);
    }

    function testOnlyOwnerCanWithdraw() public {
        vm.prank(buyer);
        vm.expectRevert();
        ticket.withdraw();
    }

    function testHasTicket() public {
        assertFalse(ticket.hasTicket(buyer));

        vm.prank(buyer);
        ticket.mint{value: TICKET_PRICE}();

        assertTrue(ticket.hasTicket(buyer));
    }

    function testOwnerMint() public {
        vm.prank(organizer);
        ticket.ownerMint(buyer);

        assertEq(ticket.totalSupply(), 1);
        assertEq(ticket.ownerOf(0), buyer);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Book {
    address[10] public people_xiazhaoxuan;
    uint public borrowIndex_xiazhaoxuan;

    mapping (address =>
     mapping(uint =>
      BorrowInfo_xiazhaoxuan)
      ) book_xiazhaoxuan;

    receive () payable external{
    }

    struct BorrowInfo_xiazhaoxuan {
        uint BorrowId_xiazhaoxuan;
        address BorrowPeople_xiazhaoxuan;
        uint LinkedBookId_xiazhaoxuan;
        uint StartTime_xiazhaoxuan;
        bool BorrowState_xiazhaoxuan;
    }

    function borrowBook(uint id) public returns (uint) {
        require(id >= 0 && id <= 10);
        borrowIndex_xiazhaoxuan += 1;
        people_xiazhaoxuan[id] = msg.sender;
        BorrowInfo_xiazhaoxuan storage borrowinfo =
         book_xiazhaoxuan[msg.sender][id];
        borrowinfo.BorrowId_xiazhaoxuan = borrowIndex_xiazhaoxuan;
        borrowinfo.BorrowPeople_xiazhaoxuan = msg.sender;
        borrowinfo.LinkedBookId_xiazhaoxuan = id;
        borrowinfo.StartTime_xiazhaoxuan = block.timestamp;
        borrowinfo.BorrowState_xiazhaoxuan = true;
        return id;
    }

    function returnBook(uint id) public returns (uint) {
        require(id >= 0 && id <= 10);
        BorrowInfo_xiazhaoxuan storage borrowinfo =
         book_xiazhaoxuan[msg.sender][id];
        borrowinfo.BorrowState_xiazhaoxuan = false;
        people_xiazhaoxuan[id] = 0x0000000000000000000000000000000000000000;
        return id;
    }
    
    function getBorrower() public view returns (address[10] memory, uint, address, uint, uint, bool) {
        BorrowInfo_xiazhaoxuan storage borrowinfo =
         book_xiazhaoxuan[msg.sender][borrowIndex_xiazhaoxuan];
        return (people_xiazhaoxuan,
         borrowinfo.BorrowId_xiazhaoxuan,
          borrowinfo.BorrowPeople_xiazhaoxuan,
           borrowinfo.LinkedBookId_xiazhaoxuan,
            borrowinfo.StartTime_xiazhaoxuan,
             borrowinfo.BorrowState_xiazhaoxuan);
    }
}
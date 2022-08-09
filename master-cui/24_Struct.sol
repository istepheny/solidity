// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

// 结构体
contract Struct{
    struct Car {
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function example() external {
        Car memory car1 = Car("toyota",1990,msg.sender);
        Car memory car2 = Car({model:"lambo",year:1980,owner:msg.sender});
        Car memory car3;
        car3.model="tesla";
        car3.year=2010;
        car3.owner=msg.sender;

        cars.push(car1);
        cars.push(car2);
        cars.push(car3);

        cars.push(Car("ferrari",2020,msg.sender));

        // 
        Car storage _car = cars[0];
        _car.year = 1999;
        delete _car.owner;

        delete cars[1];
    }
}
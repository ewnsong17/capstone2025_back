class Move {
    constructor(id, place, name, price, date) {
        this.id = id;
        this.place = place;
        this.name = name;
        this.price = price;
        this.date = date;
    }

    toString() {
        return `Name: ${this.name} Place: ${this.place} Price: ${this.price} Date: ${this.date}`;
    }
}


module.exports = Move;
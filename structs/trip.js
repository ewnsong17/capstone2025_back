class MyTrip {
    constructor(name, type, price, start_date, end_date, country) {
        this.name = name;
        this.type = type;
        this.price = price;
        this.start_date = start_date;
        this.end_date = end_date;
        this.country = country;
    }

    toString() {
        return `Name: ${this.name} Price: ${this.price} Country: ${this.country}`;
    }
}


module.exports = MyTrip;
class Review {
    constructor(id, name, price, start_date, end_date, country, rate, comment) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.start_date = start_date;
        this.end_date = end_date;
        this.country = country;
        this.rate = rate;
        this.comment = comment;
    }

    toString() {
        return `Name: ${this.name} Rate: ${this.rate} Comment: ${this.comment}`;
    }
}


module.exports = Review;
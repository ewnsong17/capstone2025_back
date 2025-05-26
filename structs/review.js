class Review {
    constructor(id, place_id, name, place, reg_date, rate, comment) {
        this.id = id;
        this.place_id = place_id;
        this.name = name;
        this.place = place;
        this.reg_date = reg_date;
        this.rate = rate;
        this.comment = comment;
    }

    toString() {
        return `Name: ${this.name} Rate: ${this.rate} Comment: ${this.comment}`;
    }
}


module.exports = Review;
class Place {
    constructor(name, place, reg_date) {
        this.name = name;
        this.place = place;
        this.reg_date = reg_date;
    }

    toString() {
        return `Name: ${this.name} Place: ${this.place} Date: ${this.reg_date}`;
    }
}


module.exports = Place;
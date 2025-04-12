class Package {
    constructor(id, name, price, start_date, end_date, country, image) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.start_date = start_date;
        this.end_date = end_date;
        this.country = country;
        this.image = image;
    }

    toString() {
        return `Name: ${this.name} Price: ${this.price} Image: ${this.image}`;
    }
}


module.exports = Package;
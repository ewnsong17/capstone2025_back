class Package {
    constructor(id, name, type, price, start_date, end_date, country, image, url) {
        this.id = id;
        this.name = name;
        this.type = type;
        this.price = price;
        this.start_date = start_date;
        this.end_date = end_date;
        this.country = country;
        this.image = image;
        this.url = url;
    }

    toString() {
        return `Name: ${this.name} Price: ${this.price} Image: ${this.image}`;
    }
}


module.exports = Package;
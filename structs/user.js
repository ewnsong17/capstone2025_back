class User {
    constructor(id, name, image, birthday) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.birthday = birthday;
    }

    toString() {
        return `ID: ${this.id} NAME: ${this.name} IMAGE: ${this.image} BIRTHDAY: ${this.birthday}`;
    }
}


module.exports = User;
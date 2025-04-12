class User {
    constructor(id, name) {
        this.id = id;
        this.name = name;
    }

    toString() {
        return `ID: ${this.id} NAME: ${this.name}`;
    }
}


module.exports = User;
class User {
    constructor(id, name, email, birthday) {
        this.name = name;
        this.email = email;
        this.birthday = birthday;
    }

    toString() {
        return `NAME: ${this.name} EMAIL: ${this.email} BIRTHDAY: ${this.birthday}`;
    }
}

module.exports = User;

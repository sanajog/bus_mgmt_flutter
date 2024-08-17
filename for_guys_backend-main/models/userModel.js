const mongoose = require("mongoose")
const userSchema = mongoose.Schema({
    firstName: {
        type: String
    },
    lastName: {
        type: String
    },
    email: {
        type: String
    },
    password: {
        type: String
    },
    phoneNum: {
        type: String,
    },
    bookedBus: [{
        type: mongoose.Schema.Types.ObjectId,
        ref:'Bus'
    }],
    isAdmin: {
        type: String,
        required: false
    }
}, { timestamps: true });

const User = mongoose.model("User", userSchema);
module.exports = User;
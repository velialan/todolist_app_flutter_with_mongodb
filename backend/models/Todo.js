const mongoose = require('mongoose');

const TodoSchema = new mongoose.Schema(
    {
        title: {
            type: String,
            required: true
        },
        date:{
            type:Date,
            default:Date.now
        },
        isFinished:{
            type:Boolean,
            default:false
        }
    }
)

const Todo = mongoose.model('Todo',TodoSchema);
module.exports=Todo;
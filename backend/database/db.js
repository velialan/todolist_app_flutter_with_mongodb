const mongoose = require('mongoose');

mongoose.connect('mongodb://127.0.0.1:27017/todo_list_app', {
    useCreateIndex: true,
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false
})
    .then(() => console.log('connected mongodb'))
    .catch((error) => console.log('error connection' + error));
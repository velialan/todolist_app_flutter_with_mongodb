const express = require('express');

const app=express();

const bodyParser = require('body-parser');



app.use(express.json());
app.use(bodyParser.json());

require('./database/db');

const todoRouter = require('./router/todoRouter');

app.use('/api',todoRouter);




const PORT=3001;

app.listen(PORT,(error, success)=>{
    if(error) throw error;
    console.log(`Server started ${PORT}`);
})
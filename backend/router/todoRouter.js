/**express ile router oluşturuyoruz */
const todoRouter = require('express').Router();
//**controller çağırıyoruz */
const Controller= require('../controllers/todoController');

todoRouter.post("/addTodo", Controller.addTodo);

todoRouter.post("/updateTodo", Controller.updateTodo);

todoRouter.post("/deleteTodo", Controller.deleteTodo);

todoRouter.get("/getAllTodos", Controller.getAllTodos);

module.exports = todoRouter;

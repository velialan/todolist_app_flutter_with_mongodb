const Todo = require('../models/Todo');

/**Create todo */

const addTodo = async (req, res, next) => {

    const todo = new Todo(req.body);
    try {
        const result = await todo.save();
        if (result) {
            return res.status(201).json({
                mesage: "kayıt eklendi"
            })
        } else {
            return res.status(400).json({
                mesage: "kayıt eklenemedi"
            })
        }

    } catch (error) {
        return res.status(500).json({
            mesage: error.message
        })
    }
}
/**Update Todo */
const updateTodo = async (req, res, next) => {
    try {
        const todo = await Todo.findById(req.body.id, {}, { lean: true });
        if (todo) {
            const updated = await Todo.findByIdAndUpdate(
                { _id: req.body.id },
                req.body,
                { lean: true, new: true }
            );

            if (updated) {
                return res.status(201).json({
                    mesage: "kayıt güncellendi"
                })

            } else {

                return res.status(400).json({
                    mesage: "Güncelleme hatası"
                })
            }
        } else {
            return res.status(404).json({
                mesage: "kayıt bulunamadı"
            })
        }



    } catch (error) {
        return res.status(500).json({
            mesage: error.message
        })
    }
}
/**delete todo */

const deleteTodo = async (req, res, next) => {
    try {
        const todo = await Todo.findByIdAndDelete({ _id: req.body.id });
        if (todo) {
            return res.status(201).json({
                message: "Kayıt  silindi",
            });
        } else {
            return res.status(400).json({
                message: "hata oluştu",
            });
        }
    } catch (error) {
        return res.status(500).json({
            mesage: error.message
        })
    }
};

/**get all todo */
const getAllTodos = async (req, res, next) => {
    try {
        const allTodos = await Todo.find({}, {}, { lean: true });
        return res.status(200).json(allTodos);
    } catch (error) {
        return res.status(500).json({
            mesage: error.message
        })
    }
};

module.exports={
    addTodo,
    updateTodo,
    deleteTodo,
    getAllTodos
}
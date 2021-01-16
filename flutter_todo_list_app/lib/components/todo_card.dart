import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final bool isFinished;
  final Function function;

  const TodoCard(
      {Key key, this.title, this.date, this.isFinished, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          RotatedBox(
              quarterTurns: 3,
              child: Text(
                date.hour.toString() + ':' + date.minute.toString(),
                style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              )),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: !isFinished
                          ? [Color(0xff845EC2), Color(0xffD65DB1)]
                          : [Color(0xff252a34), Color(0x00)])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                                                      child: Center(
                              child: Text(                              
                                title,
                                style: TextStyle(                                
                                  color: isFinished
                                      ? Colors.grey[400]
                                      : Colors.white,
                                  fontWeight: isFinished ? null : FontWeight.bold,
                                  fontSize: 20,
                                  decoration: isFinished
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          Checkbox(
                            key: UniqueKey(),
                            value: isFinished,
                            onChanged: (bool value) {
                              this.function(value);
                            },
                          ),
                        ],
                      ),
                      Text(date.day.toString() +
                          '.' +
                          date.month.toString() +
                          '.' +
                          date.year.toString())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

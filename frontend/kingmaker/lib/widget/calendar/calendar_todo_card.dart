import 'package:flutter/material.dart';
import 'package:kingmaker/page/todo_detail_page.dart';
import 'package:kingmaker/provider/schedule_provider.dart';
import 'package:provider/provider.dart';
class CalendarTodoCard extends StatelessWidget {
  const CalendarTodoCard({super.key, required this.data});
  final Map<String, String> data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        await Provider.of<ScheduleProvider>(context, listen: false).getDetail(int.parse(data['id']!), data['type']!);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodoDetailPage())
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        padding: EdgeInsetsDirectional.symmetric(vertical: 15),
        margin: EdgeInsetsDirectional.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: data['achieved'] == '1' ? Colors.grey : Colors.greenAccent,
                  borderRadius: BorderRadius.circular(100),
                ),
                width: 15,
                height: 15,
              ),
            ),
            Text('${data['title']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}

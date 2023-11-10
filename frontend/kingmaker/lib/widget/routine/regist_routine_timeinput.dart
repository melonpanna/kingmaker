import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kingmaker/provider/regist_provider.dart';
import 'package:provider/provider.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class TimeInput extends StatefulWidget {
  const TimeInput({super.key, required this.type});
  final String type;
  @override
  State<TimeInput> createState() => _TimeInputState();
}

class _TimeInputState extends State<TimeInput> {
  DateTime dateTimeSelected = DateTime.now();
  String getHourString(int hour) {
    if (hour < 12) {
      return '오전  $hour';
    } else if (hour == 12) {
      return '오후  12';
    } else {
      return '오후  ${hour - 12}';
    }
  }

  void _openTimePickerSheet(BuildContext context) async {
    final result = await TimePicker.show<DateTime?>(
      context: context,
      sheet: TimePickerSheet(
        sheetTitle: '시작 시간을 선택해 주세요',
        minuteTitle: '분',
        hourTitle: '시간',
        saveButtonText: '선택',
        saveButtonColor: Colors.lightBlueAccent,
        minuteInterval: 1,
      ),
    );

    if (result != null) {
      String hour = (result.hour < 10)? '0${result.hour}' : '${result.hour}';
      String minute = (result.minute < 10)? '0${result.minute}' : '${result.minute}';
      if (widget.type == 'start'){
        Provider.of<RegistProvider>(context, listen: false).setStartTime('$hour:$minute');
      } else {
        Provider.of<RegistProvider>(context, listen: false).setEndTime('$hour:$minute');
      }
      setState(() {
        dateTimeSelected = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),

              ),
              onPressed: () => _openTimePickerSheet(context),
              child: Text('${getHourString(dateTimeSelected.hour)}시 ${dateTimeSelected.minute}분'),
            ),
          ],
        );
  }
}

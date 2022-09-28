import 'package:flutter/material.dart';

List<String> time = ['AM', 'PM'];

class Wheel extends StatelessWidget {
  final Function(int value) onChanged;
  final int itemCount;
  final String? time;
  const Wheel({
    Key? key,
    required this.onChanged,
    required this.itemCount,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        perspective: 0.005,
        diameterRatio: 1.2,
        onSelectedItemChanged: onChanged,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: itemCount,
          builder: (context, index) {
            return Center(
              child: SizedBox(
                child: Text(
                  index < 10 ? '0 $index' : '$index',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class WheelTime extends StatelessWidget {
  final Function(int value) onChanged;

  const WheelTime({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 50,
        perspective: 0.005,
        diameterRatio: 1.2,
        onSelectedItemChanged: onChanged,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 2,
          builder: (context, index) {
            return Center(
              child: SizedBox(
                child: Text(
                  time[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

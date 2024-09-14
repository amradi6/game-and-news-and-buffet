import 'package:flutter/material.dart';

class DeviceDetailsScreen extends StatefulWidget {
  const DeviceDetailsScreen({
    super.key,
    required this.deviceName,
    required this.games,
    required this.imageGame,
  });

  final String deviceName;
  final List<String> games;
  final List<String> imageGame;

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {

  TimeOfDay? selectedTime;

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(
            "${widget.deviceName} Games",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView.builder(
            itemCount: widget.games.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: const Color(0xff0F1346).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListTile(
                  titleAlignment: ListTileTitleAlignment.center,
                  leading: Image.asset(
                    widget.imageGame[index],
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  title: Align(
                    alignment: const Alignment(-0.5, 0),
                    child: Text(
                      widget.games[index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  textColor: Colors.white,
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _selectTime(context).then(
              (value) {
                if (selectedTime != null) {
                  // هنا يمكنك إضافة منطق الحجز بعد اختيار الوقت
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text(
                        'Confirm Booking',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        'Do you want to book ${widget.deviceName} at ${selectedTime!.format(context)}?',
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // تنفيذ عملية الحجز هنا
                            Navigator.of(context).pop();
                          },
                          child: const Text('Confirm'),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          },
          backgroundColor: Colors.orange,
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}

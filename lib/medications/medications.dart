import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rx_track/medications/camera.dart';

class Medications extends StatefulWidget {
  final CameraDescription camera;

  const Medications({super.key, required this.camera});

  @override
  State<Medications> createState() => _MedicationsState();
}

class _MedicationsState extends State<Medications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: IconButton(
          color: Colors.black,
            icon: const Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Camera(
                    camera: widget.camera,
                  ),
                ),
              );
            }),
        body: card());
  }

  Widget card() {
    Map<String, bool> medications = {
      'Adderall 20mg': false,
      'Lexapro 10mg': false,
    };
    return ListView(
      children: medications.entries.map((entry) {
        String medName = entry.key;
        bool isTaken = entry.value;
        return Card(
          child: ListTile(
            title: Text(medName),
            subtitle: Text('Next Refill: 3 weeks'),
            trailing: Checkbox(
              value: isTaken,
              onChanged: (bool? newValue) {
                setState(() {
                  medications[medName] = newValue!;
                });
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}

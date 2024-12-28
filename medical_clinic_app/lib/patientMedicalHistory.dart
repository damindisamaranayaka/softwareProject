import 'package:flutter/material.dart';

class PatientMedicalHistory extends StatefulWidget {
  const PatientMedicalHistory({super.key});

  @override
  _PatientMedicalHistoryState createState() => _PatientMedicalHistoryState();
}

class _PatientMedicalHistoryState extends State<PatientMedicalHistory> {
  final TextEditingController _drugAllergiesController = TextEditingController();
  final TextEditingController _otherIllnessesController = TextEditingController();
  final TextEditingController _currentMedicationsController = TextEditingController();

  final List<String> _conditions = [
    'High Blood Pressure',
    'Cancer',
    'Heart Attack',
    'Kidney Disease',
    'Lung Disease'
  ];
  final List<bool> _selectedConditions = List.generate(5, (index) => false);

  void _saveMedicalHistory() {
    final allergies = _drugAllergiesController.text;
    final illnesses = _otherIllnessesController.text;
    final medications = _currentMedicationsController.text;
    final selectedConditions = _conditions
        .asMap()
        .entries
        .where((entry) => _selectedConditions[entry.key])
        .map((entry) => entry.value)
        .toList();

    print('Drug Allergies: $allergies');
    print('Selected Conditions: $selectedConditions');
    print('Other Illnesses: $illnesses');
    print('Current Medications: $medications');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Medical history saved successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Medical History'),
        backgroundColor: const Color.fromARGB(255, 99, 181, 249),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlueAccent,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  'https://s3-media0.fl.yelpcdn.com/bphoto/kROaBMMNs2u1t9RHYMbv9g/1000s.jpg',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Patient Medical History",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Please list any drug allergies:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _drugAllergiesController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter allergies',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Have you ever had (Please check all that apply):",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Column(
                children: _conditions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final condition = entry.value;
                  return CheckboxListTile(
                    title: Text(condition),
                    value: _selectedConditions[index],
                    onChanged: (value) {
                      setState(() {
                        _selectedConditions[index] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Text(
                "Other illnesses:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _otherIllnessesController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter other illnesses',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Please list your Current Medications:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _currentMedicationsController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter medications',
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: const Text("Back"),
                  ),
                  ElevatedButton(
                    onPressed: _saveMedicalHistory,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Save"),
                  ),
                 /* ElevatedButton(
                    onPressed: () {
                      // Navigate to the next page if needed
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("Next"),
                  ),  */
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
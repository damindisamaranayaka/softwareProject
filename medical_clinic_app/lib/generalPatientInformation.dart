import 'package:flutter/material.dart';
import 'patientMedicalHistory.dart'; // Import the PatientMedicalHistory page

class GeneralPatientInformation extends StatefulWidget {
  const GeneralPatientInformation({super.key});

  @override
  _GeneralPatientInformationState createState() =>
      _GeneralPatientInformationState();
}

class _GeneralPatientInformationState
    extends State<GeneralPatientInformation> {
  String? _selectedGender;
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  void _savePatientInfo() {
    if (_selectedGender == null ||
        _monthController.text.isEmpty ||
        _dayController.text.isEmpty ||
        _yearController.text.isEmpty ||
        _heightController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print("Gender: $_selectedGender");
    print("Birth Date: ${_monthController.text}/${_dayController.text}/${_yearController.text}");
    print("Height: ${_heightController.text} cm");
    print("Weight: ${_weightController.text} kg");
    print("Reason: ${_reasonController.text}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Patient information saved successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General Patient Information'),
        backgroundColor: const Color.fromARGB(255, 99, 181, 249),
        elevation: 0,
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
                  "General Patient Information",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Gender:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _selectedGender,
                hint: const Text('Select Gender'),
                isExpanded: true,
                items: ['Male', 'Female'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              const SizedBox(height: 15),
              const Text(
                "Patient Birth Date",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _monthController,
                      hintText: "Month",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _dayController,
                      hintText: "Day",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildTextField(
                      controller: _yearController,
                      hintText: "Year",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _heightController,
                labelText: "Patient Height (cm's)",
              ),
              const SizedBox(height: 15),
              _buildTextField(
                controller: _weightController,
                labelText: "Patient Weight (Kg's)",
              ),
              const SizedBox(height: 15),
              const Text(
                "Reason for seeing the doctor:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _reasonController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Enter details",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Back",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PatientMedicalHistory(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _savePatientInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      {String? labelText, String? hintText, TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      ),
    );
  }
}
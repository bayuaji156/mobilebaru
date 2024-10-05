import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(FormApp());
}

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Form App',
      home: LoginScreen(),
    );
  }
}

// Model Class for Event Data
class Event {
  String name;
  String address;
  String age;
  String event;
  String selection; // This will hold the selected competition or snack

  Event({required this.name, required this.address, required this.age, required this.event, required this.selection});
}

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://wallpapercave.com/wp/wp9764006.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85, // 85% of the screen width
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: const Color.fromARGB(255, 96, 8, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(controller: usernameController, placeholder: 'Username'),
                      SizedBox(height: 10),
                      CustomTextField(controller: passwordController, placeholder: 'Password', obscureText: true),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EventSelectionScreen()),
                          );
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Event')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => IndependenceFormScreen()),
                );
              },
              child: Text('Event Kemerdekaan'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EidFormScreen()),
                );
              },
              child: Text('Event Idul Fitri'),
            ),
          ],
        ),
      ),
    );
  }
}

class IndependenceFormScreen extends StatefulWidget {
  @override
  _IndependenceFormScreenState createState() => _IndependenceFormScreenState();
}

class _IndependenceFormScreenState extends State<IndependenceFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  
  List<Event> events = [];
  String selectedCompetition = "Balap Karung"; // Default selection
  List<String> competitions = ["Balap Karung", "Balap Kelereng", "Tarik Tambang"];

  void addEvent() {
    final event = Event(
      name: nameController.text,
      address: addressController.text,
      age: ageController.text,
      event: "Kemerdekaan",
      selection: selectedCompetition,
    );

    setState(() {
      events.add(event);
    });

    nameController.clear();
    addressController.clear();
    ageController.clear();
    selectedCompetition = competitions[0]; // Reset to default
  }

  void editEvent(int index) {
    nameController.text = events[index].name;
    addressController.text = events[index].address;
    ageController.text = events[index].age;
    selectedCompetition = events[index].selection;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(controller: nameController, placeholder: 'Nama'),
                CustomTextField(controller: addressController, placeholder: 'Alamat'),
                CustomTextField(controller: ageController, placeholder: 'Umur'),
                DropdownButton<String>(
                  value: selectedCompetition,
                  items: competitions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCompetition = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  events[index] = Event(
                    name: nameController.text,
                    address: addressController.text,
                    age: ageController.text,
                    event: "Kemerdekaan",
                    selection: selectedCompetition,
                  );
                  nameController.clear();
                  addressController.clear();
                  ageController.clear();
                  selectedCompetition = competitions[0]; // Reset to default
                  Navigator.pop(context);
                });
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://1.bp.blogspot.com/-wqPboxwOXxM/XvNBoL48DtI/AAAAAAAAKEQ/rJ-Fh0FSAuIqLEY57zzpx-690M72gDpUwCLcBGAsYHQ/s1600/21-gambar-hari-kemerdekaan-indonesia-17-agustus-1945.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85, // Responsive width
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.7), // Semi-transparent background
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Di isi ya!!!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(controller: nameController, placeholder: 'Nama'),
                        CustomTextField(controller: addressController, placeholder: 'Alamat'),
                        CustomTextField(controller: ageController, placeholder: 'Umur'),
                        DropdownButton<String>(
                          value: selectedCompetition,
                          items: competitions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCompetition = newValue!;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            addEvent();
                          },
                          child: Text('Enter'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('List of Events'),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      itemCount: events.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(events[index].name),
                                          subtitle: Text('Event: ${events[index].event}, Selection: ${events[index].selection}'),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () => editEvent(index),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () => deleteEvent(index),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('View Events'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EidFormScreen extends StatefulWidget {
  @override
  _EidFormScreenState createState() => _EidFormScreenState();
}

class _EidFormScreenState extends State<EidFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController eventController = TextEditingController();
  
  List<Event> events = [];
  String selectedSnack = "Nastar"; // Default selection
  List<String> snacks = ["Nastar", "Putri Salju", "Astor"];

  void addEvent() {
    final event = Event(
      name: nameController.text,
      address: addressController.text,
      age: ageController.text,
      event: "Idul Fitri",
      selection: selectedSnack,
    );

    setState(() {
      events.add(event);
    });

    nameController.clear();
    addressController.clear();
    ageController.clear();
    selectedSnack = snacks[0]; // Reset to default
  }

  void editEvent(int index) {
    nameController.text = events[index].name;
    addressController.text = events[index].address;
    ageController.text = events[index].age;
    selectedSnack = events[index].selection;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Event'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(controller: nameController, placeholder: 'Nama'),
                CustomTextField(controller: addressController, placeholder: 'Alamat'),
                CustomTextField(controller: ageController, placeholder: 'Umur'),
                DropdownButton<String>(
                  value: selectedSnack,
                  items: snacks.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSnack = newValue!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  events[index] = Event(
                    name: nameController.text,
                    address: addressController.text,
                    age: ageController.text,
                    event: "Idul Fitri",
                    selection: selectedSnack,
                  );
                  nameController.clear();
                  addressController.clear();
                  ageController.clear();
                  selectedSnack = snacks[0]; // Reset to default
                  Navigator.pop(context);
                });
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteEvent(int index) {
    setState(() {
      events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://wallpapercave.com/wp/wp7019263.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85, // Responsive width
              padding: EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 22, 173, 207).withOpacity(0.7), // Semi-transparent background
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Di isi ya!!!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomTextField(controller: nameController, placeholder: 'Nama'),
                        CustomTextField(controller: addressController, placeholder: 'Alamat'),
                        CustomTextField(controller: ageController, placeholder: 'Umur'),
                        DropdownButton<String>(
                          value: selectedSnack,
                          items: snacks.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSnack = newValue!;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            addEvent();
                          },
                          child: Text('Enter'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 3, 2, 1),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('List of Events'),
                                  content: Container(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      itemCount: events.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(events[index].name),
                                          subtitle: Text('Event: ${events[index].event}, Selection: ${events[index].selection}'),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(Icons.edit),
                                                onPressed: () => editEvent(index),
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () => deleteEvent(index),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('View Events'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Text Field
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool obscureText;

  const CustomTextField({required this.controller, required this.placeholder, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.all(16),
      ),
    );
  }
}

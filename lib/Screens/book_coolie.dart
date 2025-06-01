import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
// import 'package:twilio_flutter/twilio_flutter.dart';

class BookCoolie extends StatefulWidget {
  @override
  State<BookCoolie> createState() => _BookCoolieState();
}

class _BookCoolieState extends State<BookCoolie> {
  String? _selectedTime;
  final List<String> _stations = ["Raipur", "Durg"];
  String? _selectedStation;

  //init twilio

  bool isLoading = false;
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _trainNameController = TextEditingController();
  final TextEditingController _trainNumberController = TextEditingController();
  final TextEditingController _coachNumberController = TextEditingController();
  final TextEditingController _seatNumberController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void dispose() {
    _weightController.dispose();
    _trainNameController.dispose();
    _trainNumberController.dispose();
    _coachNumberController.dispose();
    _seatNumberController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  

  final List<String> _locations = ["Entry Gate", "Platform No.1"];
  String? _pickupPoint;
  String? _dropPoint;
  int? _fee;

  void _onWeightChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        _fee = 100; // Flat rate logic or can be made dynamic
      });
    } else {
      setState(() {
        _fee = null;
      });
    }
  }

  void _submitBooking() async {
    if (_pickupPoint == null ||
        _dropPoint == null ||
        _selectedStation == null ||
        _weightController.text.isEmpty ||
        _selectedTime == null ||
        _nameController.text.isEmpty ||
        _trainNameController.text.isEmpty ||
        _trainNumberController.text.isEmpty ||
        _coachNumberController.text.isEmpty ||
        _seatNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    String message = '''
      You have a Passenger:

      Pickup Point: $_pickupPoint
      Drop Point: $_dropPoint
      Time: $_selectedTime
      Train Name: ${_trainNameController.text}
      Train Number: ${_trainNumberController.text}
      Coach: ${_coachNumberController.text}
      Seat: ${_seatNumberController.text}
      Weight: ${_weightController.text} kg
      Fee: ₹$_fee
      ''';

    // TwilioResponse response = await twilioFlutter.sendSMS(
    //   toNumber: '+919560952125',
    //   messageBody: message,
    // );
    print('$message');

    // TwilioResponse response = await twilioFlutter.sendSMS(
    //     toNumber: '+919560952125',
    //     messageBody:
    //         'You have a Passenger - Pickup Point:$_pickupPoint , Drop point: $_dropPoint at:_$_selectedTime, Train Number:${_trainNumberController.text}, Train name:${_trainNameController.text}, Fee:₹$_fee');
    // print(response.responseCode);

    // print('Twilio Response Code: ${response.responseCode}');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('Request sent!')),
    // );
    final user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   user.uid;
    // }

    try {
      setState(() {
        isLoading = true;
      });
      final QuerySnapshot coolieSnapshot = await FirebaseFirestore.instance
          .collection('coolie_list')
          .where('Available', isEqualTo: true)
          .limit(1)
          .get();

      if (coolieSnapshot.docs.isEmpty) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No Sahayaks available at the moment.')),
        );
        return;
      }

      final DocumentSnapshot selectedCoolie = coolieSnapshot.docs.first;
      final String coolieId = selectedCoolie.id;
      String coolieName = selectedCoolie['Name'];
      String cooliePhone = selectedCoolie['Phone_number'];
      String coolieBillNo = selectedCoolie['Bill_no'];

      Map<String, dynamic> bookingData = {
        'id': user?.uid,
        'pickupPoint': _pickupPoint,
        'dropPoint': _dropPoint,
        'time': _selectedTime.toString(),
        'name': _nameController.text,
        'trainName': _trainNameController.text,
        'trainNumber': _trainNumberController.text,
        'coachNumber': _coachNumberController.text,
        'seatNumber': _seatNumberController.text,
        'weight': _weightController.text,
        'fee': _fee,
        'timestamp': FieldValue.serverTimestamp(),
        'coolie_assigned': coolieId,
        'coolie_name': coolieName,
        'coolie_number': cooliePhone,
        'coolie_bill_number': coolieBillNo,
        'status':'Arriving at Your Location',
        // 'doc_id':
      };

        final docRef = FirebaseFirestore.instance.collection('coolie_bookings').doc();
        bookingData['doc_id'] = docRef.id;

        await docRef.set(bookingData);

      await FirebaseFirestore.instance
          .collection('coolie_list')
          .doc(coolieId)
          .update({
        'Available': false,
        'passenger_assigned': user?.uid,
      });
      setState(() {
        isLoading = false;
      });

      // TwilioResponse response = await twilioFlutter.sendSMS(
      //   toNumber: '+91Phno',
      //   messageBody:
      //       'You have a Passenger - Name:${_nameController.text} Pickup Point:$_pickupPoint , Drop point: $_dropPoint at :$_selectedTime, Train Number :${_trainNumberController.text}, Train  ame :${_trainNameController.text}, Fee :₹$_fee',
      // );

      // print('Twilio Response Code: ${response.responseCode}');

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              const Text(
                'Your Sahayak has been booked!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              Text('Name:$coolieName'),
              Text('Phone Number: $cooliePhone'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text('OK'),
              )
            ],
          ),
        ),
      );
    } catch (e) {
      print('Error sending SMS: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send request.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      // borderSide: const BorderSide(color: Colors.deepOrange, width: 1.5),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Book a Sahayak',
          style: TextStyle(
            color: Colors.deepOrange,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Fields with * are mandatory',
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Passenger Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedStation,
              decoration: InputDecoration(
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
                labelText: 'Select Station *',
              ),
              items: _stations
                  .map((station) => DropdownMenuItem(
                        value: station,
                        child: Text(station),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStation = value;
                });
              },
            ),

            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
                value: _pickupPoint,
                decoration: InputDecoration(
                  border: borderStyle,
                  enabledBorder: borderStyle,
                  focusedBorder: borderStyle,
                  labelText: 'Select Pickup Point *',
                ),
                items: _locations
                    .where(
                        (loc) => loc != _dropPoint) // Filter out selected drop
                    .map((location) => DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _pickupPoint = value;
                    if (_pickupPoint == _dropPoint) _dropPoint = null;
                  });
                }),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _dropPoint,
              decoration: InputDecoration(
                border: borderStyle,
                enabledBorder: borderStyle,
                focusedBorder: borderStyle,
                labelText: 'Select Drop Point *',
              ),
              items: _locations
                  .where((loc) =>
                      loc != _pickupPoint) // Filter out selected pickup
                  .map((location) => DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _dropPoint = value;
                  if (_pickupPoint == _dropPoint) _pickupPoint = null;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      labelText: 'Weight of Luggage (kg)',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: _onWeightChanged,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _timeController,
                    readOnly: true, // Prevents keyboard from showing
                    decoration: InputDecoration(
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Select Time *',
                    ),
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          final hour = pickedTime.hourOfPeriod
                              .toString()
                              .padLeft(2, '0');
                          final minute =
                              pickedTime.minute.toString().padLeft(2, '0');
                          final period =
                              pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
                          _timeController.text = '$hour:$minute $period';
                          _selectedTime = '$hour:$minute $period';
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _trainNameController,
                    decoration: InputDecoration(
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Train Name',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _trainNumberController,
                    decoration: InputDecoration(
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Train Number',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _coachNumberController,
                    decoration: InputDecoration(
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Coach No.',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _seatNumberController,
                    decoration: InputDecoration(
                      border: borderStyle,
                      enabledBorder: borderStyle,
                      focusedBorder: borderStyle,
                      labelText: 'Seat No.',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fee Calculated: ₹${_fee ?? "--"}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isLoading ? null : _submitBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isLoading ? Colors.grey : Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}

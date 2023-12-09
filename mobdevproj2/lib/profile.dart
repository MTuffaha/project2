import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFFFB4F4F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ProfileForm(),
        ),
      ),
    );
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  late final GlobalKey<FormState> _formKey;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  late TextEditingController _nameController;
  late String _name = '';
  late String _email = '';
  late String _address = '';

  // Variables to track changes
  late String _updatedName;
  late String _updatedAddress;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController(text: _name);
    _updatedName = _name;
    _updatedAddress = _address;
    // Load user data when the page is initialized
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _loadUserData() async {
    // Fetch user data from Firestore
    User? user = _auth.currentUser;
    if (user != null) {
      CollectionReference userCollection = _firestore.collection('users');
      DocumentSnapshot<Object?> userData = await userCollection.doc(user.uid).get();

      setState(() {
        _name = userData['name'] ?? '';
        _email = user.email ?? '';
        _address = userData['address'] ?? '';
        _nameController.text = _name; // Update the controller value
        _updatedName = _name;
        _updatedAddress = _address;
      });
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        User? user = _auth.currentUser;
        if (user != null) {
          // Update user data in Firestore
          await _firestore.collection('users').doc(user.uid).set({
            'name': _nameController.text,
            'address': _address,
          }, SetOptions(merge: true));

          // Update user's email for sign-in
          await user.verifyBeforeUpdateEmail(_email);

          // Update the state variables after form submission
          setState(() {
            _updatedName = _nameController.text;
            _updatedAddress = _address;
            _email = _email; // Update the email display
          });

          // User data successfully updated
          print('User data updated');
        }
      } catch (e) {
        print('Error updating user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Display user's name at the top
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Hello, $_updatedName!',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Display user's email
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Email: $_email',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        // Display user's address
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Address: $_updatedAddress',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFBB3B3),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

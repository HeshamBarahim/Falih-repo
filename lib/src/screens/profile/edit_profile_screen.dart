import 'package:falih/src/config/const.dart';
import 'package:falih/src/config/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/custom_textfield.dart';
import 'components/custome_dropdown_button.dart';
import 'components/date_picker.dart';
import 'components/profile_image.dart';
import 'components/update_button.dart';

class EditProfileScreen extends StatefulWidget {
  static const String sc_route = '/edit-profile-screen';

  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final String currentBirthDate = '2000/12/15';

  String DropdownButtonValue = 'Male';

  // Variable to hold the selected date
  DateTime? _selectedDate;

  // Function to show the DatePicker dialog and handle the selected date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // Initial date
      firstDate: DateTime(1900), // Minimum date
      lastDate: DateTime.now(), // Set the last date to current date
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions From Sizes Calss
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: iconColor_2,
            size: SizeConfig.screenWidth! * 0.078,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.097,
            vertical: SizeConfig.screenHeight! * 0.118,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              ProfileImage(
                imgURL:
                    'https://www.esafety.gov.au/sites/default/files/2019-07/protect_your_personal_information_0.jpg',
                changeImageFunction: () {
                  // Change Img Action
                },
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.095),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // First Name TextField
                    CostomTextField(
                      inputType: TextInputType.name,
                      controller: _firstNameController,
                      onChangedFunction: (val) {
                        //
                      },
                      validator: (val) {
                        //
                        if (val == null || val.isEmpty) {
                          return 'Please Enter Your First Name';
                        }
                      },
                      // Prevent User From Input Space
                      inputFormatters:
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      hintText: 'Hisham',
                    ),

                    SizedBox(height: SizeConfig.screenHeight! * 0.021),
                    // Last Name TextField
                    CostomTextField(
                      inputType: TextInputType.name,
                      controller: _lastNameController,
                      onChangedFunction: (val) {
                        //
                      },
                      validator: (val) {
                        //
                        if (val == null || val.isEmpty) {
                          return 'Please Enter Your Last Name';
                        }
                      },
                      // Prevent User From Input Space
                      inputFormatters:
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      hintText: 'Baraheem',
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.021),
                    // Phone Number TextField
                    CostomTextField(
                      inputType: TextInputType.phone,
                      controller: _phoneController,
                      onChangedFunction: (val) {
                        //
                      },
                      validator: (val) {
                        //
                        if (val == null || val.isEmpty) {
                          return 'Please Enter Your Phone Number';
                        }
                      },
                      // Prevent User From Input Space
                      inputFormatters:
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      hintText: '777-7777777',
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.021),
                    // Gender Dropdown Field
                    CustomDropdownButton(
                      value: DropdownButtonValue,
                      onChangedFunction: (val) {
                        setState(() {
                          DropdownButtonValue = val!;
                        });
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight! * 0.021),
                    // Date of Birth Field
                    DatePicker(
                      dateText: _selectedDate != null
                          ? '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}'
                          : currentBirthDate, // Display selected date or hint,
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.095),
              // Update Profile Button
              UpdateButton(
                onPressed: () {
                  // Update profile action
                  if (_formKey.currentState!.validate() &&
                      DropdownButtonValue != null &&
                      (_selectedDate != null &&
                          _selectedDate == currentBirthDate)) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: SizeConfig.screenHeight! * 0.2,
                          child: Center(
                            child: Text('Profile Successfully Edited'),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

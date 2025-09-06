import 'package:flutter/material.dart';
import 'data.dart';
import 'database_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class PersonalTab extends StatefulWidget {
  const PersonalTab({super.key});

  @override
  State<PersonalTab> createState() => _PersonalTabState();
}

class _PersonalTabState extends State<PersonalTab> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late Future<UserInfo?> _userInfoFuture;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _preferredNameController;
  late TextEditingController _genderController;
  late TextEditingController _dobController;
  late TextEditingController _maritalStatusController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipController;

  final List<String> _genders = ['Male', 'Female', 'Non-binary', 'Other'];
  final List<String> _maritalStatuses = [
    'Single',
    'Married',
    'Divorced',
    'Widowed',
  ];

  @override
  void initState() {
    super.initState();
    _userInfoFuture = _fetchUserInfo();
  }

  Future<UserInfo?> _fetchUserInfo() async {
    final dbHelper = DatabaseHelper();
    UserInfo? userInfo = await dbHelper.getUserInfo();

    if (userInfo != null) {
      _firstNameController = TextEditingController(text: userInfo.firstName);
      _lastNameController = TextEditingController(text: userInfo.lastName);
      _middleNameController = TextEditingController(text: userInfo.middleName);
      _preferredNameController = TextEditingController(
        text: userInfo.preferredName,
      );
      _genderController = TextEditingController(text: userInfo.gender);
      _dobController = TextEditingController(text: userInfo.dateOfBirth);
      _maritalStatusController = TextEditingController(
        text: userInfo.maritalStatus,
      );
      _addressController = TextEditingController(text: userInfo.addressLine1);
      _cityController = TextEditingController(text: userInfo.city);
      _stateController = TextEditingController(text: userInfo.state);
      _zipController = TextEditingController(text: userInfo.zipCode);
    } else {
      // In case no data is found, initialize controllers with empty strings
      _firstNameController = TextEditingController();
      _lastNameController = TextEditingController();
      _middleNameController = TextEditingController();
      _preferredNameController = TextEditingController();
      _genderController = TextEditingController();
      _dobController = TextEditingController();
      _maritalStatusController = TextEditingController();
      _addressController = TextEditingController();
      _cityController = TextEditingController();
      _stateController = TextEditingController();
      _zipController = TextEditingController();
    }
    return userInfo;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _preferredNameController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    _maritalStatusController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final updatedUserInfo = UserInfo(
        id: 1,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        middleName: _middleNameController.text,
        preferredName: _preferredNameController.text,
        fullName:
            '${_firstNameController.text} ${_middleNameController.text} ${_lastNameController.text}',
        jobTitle: 'VP, People & Culture',
        profilePicture: 'assets/profile.png',
        workPhone: '555-555-5555',
        mobilePhone: '555-555-5555',
        workEmail: 'jake@example.com',
        gender: _genderController.text,
        dateOfBirth: _dobController.text,
        maritalStatus: _maritalStatusController.text,
        addressLine1: _addressController.text,
        city: _cityController.text,
        state: _stateController.text,
        zipCode: _zipController.text,
      );

      await DatabaseHelper().updateUserInfo(updatedUserInfo);
      setState(() {
        _isEditing = false;
        _userInfoFuture = _fetchUserInfo();
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile saved!')));
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _userInfoFuture = _fetchUserInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfo?>(
      future: _userInfoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data found.'));
        } else {
          final userInfo = snapshot.data!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _isEditing
                    ? _buildEditForm(userInfo)
                    : _buildViewMode(userInfo),
              ),
            ),
            floatingActionButton: _isEditing
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: _cancelEdit,
                        label: const Text('Cancel'),
                        icon: const Icon(Icons.cancel),
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      FloatingActionButton.extended(
                        onPressed: _saveForm,
                        label: const Text('Save'),
                        icon: const Icon(Icons.save),
                        backgroundColor: const Color(0xFFF07E2E),
                      ),
                    ],
                  )
                : FloatingActionButton(
                    onPressed: _toggleEdit,
                    backgroundColor: const Color(0xFFF07E2E),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
          );
        }
      },
    );
  }

  Widget _buildViewMode(UserInfo userInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(userInfo.profilePicture),
              ),
              const SizedBox(height: 10),
              Text(
                userInfo.fullName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                userInfo.jobTitle,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        _buildSection('Contact Information', [
          _buildInfoRow(
            icon: Icons.phone,
            label: 'Work',
            value: userInfo.workPhone,
            actionIcon: Icons.call,
            onActionPressed: () =>
                launchUrl(Uri(scheme: 'tel', path: userInfo.workPhone)),
          ),
          _buildInfoRow(
            icon: Icons.phone,
            label: 'Mobile',
            value: userInfo.mobilePhone,
            actionIcon: Icons.message,
            onActionPressed: () =>
                launchUrl(Uri(scheme: 'sms', path: userInfo.mobilePhone)),
          ),
          _buildInfoRow(
            icon: Icons.email,
            label: 'Work',
            value: userInfo.workEmail,
            actionIcon: Icons.mail_outline,
            onActionPressed: () =>
                launchUrl(Uri(scheme: 'mailto', path: userInfo.workEmail)),
          ),
        ]),
        _buildSection('Basic Information', [
          _buildInfoRow(label: 'First Name', value: userInfo.firstName),
          _buildInfoRow(label: 'Last Name', value: userInfo.lastName),
          _buildInfoRow(label: 'Middle Name', value: userInfo.middleName),
          _buildInfoRow(label: 'Preferred Name', value: userInfo.preferredName),
          _buildInfoRow(label: 'Gender', value: userInfo.gender),
          _buildInfoRow(label: 'Date of Birth', value: userInfo.dateOfBirth),
          _buildInfoRow(label: 'Marital Status', value: userInfo.maritalStatus),
          _buildInfoRow(label: 'SSN', value: '***-**-****'),
        ]),
        _buildSection('Address', [
          _buildInfoRow(label: 'Address Line 1', value: userInfo.addressLine1),
          _buildInfoRow(label: 'City', value: userInfo.city),
          _buildInfoRow(label: 'State', value: userInfo.state),
          _buildInfoRow(label: 'Zip Code', value: userInfo.zipCode),
        ]),
      ],
    );
  }

  Widget _buildEditForm(UserInfo userInfo) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildEditableSection('Basic Information', [
            _buildEditableField(
              controller: _firstNameController,
              label: 'First Name',
              validator: (value) =>
                  value!.isEmpty ? 'First Name is required' : null,
            ),
            _buildEditableField(
              controller: _lastNameController,
              label: 'Last Name',
              validator: (value) =>
                  value!.isEmpty ? 'Last Name is required' : null,
            ),
            _buildEditableField(
              controller: _middleNameController,
              label: 'Middle Name',
            ),
            _buildEditableField(
              controller: _preferredNameController,
              label: 'Preferred Name',
            ),
            // Replaced with a dropdown menu
            _buildGenderDropdown(userInfo.gender),
            // Replaced with a date picker
            _buildDateField(controller: _dobController, label: 'Date of Birth'),
            // Replaced with a dropdown menu
            _buildMaritalStatusDropdown(userInfo.maritalStatus),
          ]),
          _buildEditableSection('Address', [
            _buildEditableField(
              controller: _addressController,
              label: 'Address Line 1',
            ),
            _buildEditableField(controller: _cityController, label: 'City'),
            _buildEditableField(controller: _stateController, label: 'State'),
            _buildEditableField(controller: _zipController, label: 'Zip Code'),
          ]),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGenderDropdown(String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _genders.contains(initialValue) ? initialValue : null,
        decoration: const InputDecoration(
          labelText: 'Gender',
          labelStyle: TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: UnderlineInputBorder(),
        ),
        validator: (value) => value == null ? 'Gender is required' : null,
        items: _genders.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            _genderController.text = newValue;
          }
        },
      ),
    );
  }

  Widget _buildMaritalStatusDropdown(String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _maritalStatuses.contains(initialValue) ? initialValue : null,
        decoration: const InputDecoration(
          labelText: 'Marital Status',
          labelStyle: TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: UnderlineInputBorder(),
        ),
        validator: (value) =>
            value == null ? 'Marital Status is required' : null,
        items: _maritalStatuses.map((String value) {
          return DropdownMenuItem<String>(value: value, child: Text(value));
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            _maritalStatusController.text = newValue;
          }
        },
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const UnderlineInputBorder(),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today, color: Color(0xFFF07E2E)),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: Color(0xFFF07E2E),
                        onPrimary: Colors.white,
                        onSurface: Colors.black,
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFF07E2E),
                        ),
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (pickedDate != null) {
                controller.text = pickedDate.toIso8601String().split('T')[0];
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    IconData? icon,
    required String label,
    required String value,
    IconData? actionIcon,
    VoidCallback? onActionPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          ),
          if (actionIcon != null)
            IconButton(
              onPressed: onActionPressed,
              icon: Icon(actionIcon, color: const Color(0xFFF07E2E)),
            ),
        ],
      ),
    );
  }

  Widget _buildEditableSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String label,
    FormFieldValidator<String>? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: const UnderlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskmanager/data/models/auth_utility.dart';
import 'package:taskmanager/data/models/login_model.dart';
import 'package:taskmanager/data/models/network_response.dart';
import 'package:taskmanager/data/services/network_caller.dart';

import '../ widgets/screen_backgrounds.dart';
import '../ widgets/user_profile_appbar.dart';
import '../../data/utils/url.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData userData = AuthUtility.userInfo.data!;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  ImagePicker picker = ImagePicker();
  bool _profileUpdateInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailController.text = userData.email ?? '';
    _firstNameController.text = userData.firstName ?? '';
    _lastNameController.text = userData.lastName ?? '';
    _mobileController.text = userData.mobile ?? '';
  }

  Future<void> profileUpdate() async {
    _profileUpdateInProgress = true;
    if (mounted) {
      setState(() {});
    }
    final Map<String, dynamic> requestBody = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "mobile": _mobileController.text.trim(),
      "photo": "",
    };
    if (_passwordController.text.isNotEmpty) {
      requestBody['Password'] = _passwordController.text;
    }
    final NetworkResponse response =
    await NetworkCaller().postRequest(Urls.profileUpdate, requestBody);
    _profileUpdateInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess){
      userData.firstName = _firstNameController.text.trim();
      userData.lastName = _lastNameController.text.trim();
      userData.mobile = _mobileController.text.trim();
      AuthUtility.updateUserInfo(userData);
      _passwordController.clear();
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile Update success!')));
      }
    }
    else{
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile Update failed! Try again.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileAppBar(isUpdateScreen: true),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Update Profile',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          selectImage();
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 24, right: 24, bottom: 16, top: 16),
                                decoration: BoxDecoration(
                                    color: const Color(0xFF666666),
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text(
                                  'Photo',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Visibility(
                                visible: imageFile != null,
                                child: Text(imageFile?.name ?? ''),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _emailController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your email';
                          }
                          if (!value!.contains('@')) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: 'Email'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your First Name';
                          }
                          return null;
                        },
                        decoration:
                        const InputDecoration(hintText: 'First Name'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                        decoration:
                        const InputDecoration(hintText: 'Last Name'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _mobileController,
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 11) {
                            return 'Enter valid mobile number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(hintText: 'Mobile'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _profileUpdateInProgress == false,
                          replacement:
                          const Center(child: CircularProgressIndicator()),
                          child: ElevatedButton(
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              profileUpdate();
                            },
                            child: const Icon(
                              Icons.arrow_circle_right_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void selectImage() {
    picker.pickImage(source: ImageSource.gallery).then(
          (xFile) {
        if (xFile != null) {
          imageFile = xFile;
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
  }
}
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bus_management/constants/button.dart';
import 'package:bus_management/constants/snack.dart';
import 'package:bus_management/features/auth/service/service.dart';
import 'package:bus_management/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

final Service _service = Service();

class _ProfileViewState extends ConsumerState<ProfileView> {
  Map<String, dynamic>? _profileData;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  void getProfile() async {
    try {
      print('Fetching profile data...');
      final response = await _service.getProfile(context);
      print('API response: $response');
      if (response != null &&
          response['success'] == true &&
          response.containsKey('user')) {
        setState(() {
          _profileData = response['user'];
        });
        print('Profile data set: $_profileData');
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch profile data');
      }
    } catch (e) {
      print('Error fetching profile: $e');
      showSnackBar(
        color: Colors.red,
        message: e.toString().replaceFirst('Exception: ', ''),
        context: context,
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    await secureStorage.delete(key: "token");
    EasyLoading.showSuccess('Logged out', dismissOnTap: true);
    Navigator.pushReplacementNamed(context, AppRoute.signinRoute);
  }

  void showLogout(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: "Logout",
      //  titleTextStyle: G.montserrat(
      //   color: AppColors.primaryColor,
      //   fontSize: 15,
      //   fontWeight: FontWeight.w600,
      // ),
      desc: "Are you sure you want to logout?",
      btnCancelOnPress: () {},
      btnOkOnPress: () => logout(context),
    ).show();
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            'View Profile',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _profileData == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 80,
                      backgroundImage: AssetImage('assets/busregister.png'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_profileData!['firstName']} ${_profileData!['lastName'] ?? 'User'}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.verified, color: Colors.blue),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email: ${_profileData!['email'] ?? 'N/A'}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Phone Number: ${_profileData!['phoneNum'] ?? 'N/A'}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () {
                            showLogout(context);
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

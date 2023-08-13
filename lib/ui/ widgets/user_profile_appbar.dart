import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskmanager/data/models/auth_utility.dart';
import 'package:taskmanager/ui/screen/auth/login_screen.dart';
import 'package:taskmanager/ui/screen/update_profile_screen.dart';


class UserProfileAppBar extends StatefulWidget {
  final bool? isUpdateScreen;

  const UserProfileAppBar({
    super.key,
    this.isUpdateScreen,
  });

  @override
  State<UserProfileAppBar> createState() => _UserProfileAppBarState();
}

class _UserProfileAppBarState extends State<UserProfileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepOrange,
        title: GestureDetector(
          onTap: () {
            if ((widget.isUpdateScreen ?? false) == false) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UpdateProfileScreen()));
            }
          },
          child: Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: CachedNetworkImage(
                      placeholder: (_, __) => const Icon(Icons.person),
                      imageUrl: AuthUtility.userInfo.data?.photo ?? '',
                      errorWidget: (_, __, ___) => const Icon(Icons.person),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AuthUtility.userInfo.data?.firstName ?? ''} ${AuthUtility.userInfo.data?.lastName ?? ''}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    AuthUtility.userInfo.data?.email ?? 'user@email.com',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthUtility.clearUserInfo();
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                          (route) => false);
                }
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowRightFromBracket,
              )
          ),
        ]);
  }
}
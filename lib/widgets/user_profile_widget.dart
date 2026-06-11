import 'package:flutter/material.dart';
import 'package:comprehensive_knowledge_hub_platform/models/user_model.dart';
import 'package:comprehensive_knowledge_hub_platform/services/user_service.dart';

class UserProfileWidget extends StatefulWidget {
  final String uid;

  const UserProfileWidget({Key? key, required this.uid}) : super(key: key);

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  final UserService _userService = UserService();
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    final UserModel userModel = await _userService.getUser(widget.uid);
    setState(() {
      _userModel = userModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userModel != null) {
      return Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(_userModel!.photoURL),
          ),
          Text(_userModel!.displayName),
          Text(_userModel!.email),
        ],
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
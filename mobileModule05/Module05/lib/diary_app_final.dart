import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Diary extends StatefulWidget {
   const Diary({
    super.key,
    required this.cred,
    required this.logout,
  });

  final Credentials? cred;
  final Future<void> Function() logout;
  @override
  State<Diary> createState() => _DiaryState();
}

class _DiaryState extends State<Diary> with TickerProviderStateMixin {
  // final _tabController = TabController(initialIndex: 0, length: 2, vsync: TickerProviderStateMixin);

  @override
  Widget build(BuildContext context) {
    return const Text("");
  }
}
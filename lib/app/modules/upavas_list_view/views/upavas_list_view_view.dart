import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/upavas_list_view_controller.dart';

class UpavasListViewView extends GetView<UpavasListViewController> {
  const UpavasListViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UpavasListViewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UpavasListViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

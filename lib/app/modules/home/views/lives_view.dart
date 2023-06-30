import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LivesView extends GetView {
  const LivesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LivesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LivesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

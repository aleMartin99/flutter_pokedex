import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

/// Body of home screen
class HomeBody extends StatefulWidget {
  ///
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.sp),
          child: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Text('Home body'),
          ),
        ),
      ),
    );
  }
}

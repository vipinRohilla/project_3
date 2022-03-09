import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart';
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResposiveLayout extends StatefulWidget {

  final Widget mobileScreenLayout;
  final Widget webScreenLayout;

  const ResposiveLayout({ Key? key, required this.mobileScreenLayout, required this.webScreenLayout }) : super(key: key);

  @override
  State<ResposiveLayout> createState() => _ResposiveLayoutState();
}

class _ResposiveLayoutState extends State<ResposiveLayout> {

  @override
  void initState() {
    super.initState();

    addData();
  }

  addData() async{
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refereshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
        if(constraints.maxWidth < mobileScreen){
          return widget.mobileScreenLayout;
        }
        return widget.webScreenLayout;
    });
  }
}
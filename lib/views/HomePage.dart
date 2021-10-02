import 'package:chat/utilities/signIn.dart';
import 'package:chat/views/SignInPage.dart';
import 'package:chat/views/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage(this.title);
  final _loginController = Get.put(LoginController());
  final title;
  void _logOut(BuildContext context) async {
    await _loginController.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => SignInPage()));
  }

/***
 *  User(displayName: Hend Jannat, email: h.jannat@lamah.com, emailVerified: true, isAnonymous: false, 
 * metadata: UserMetadata(creationTime: 2021-09-12 11:36:55.873, lastSignInTime: 2021-09-29 12:49:06.438), 
 * phoneNumber: null, photoURL: https://lh3.googleusercontent.com/a/AATXAJxf2arhXF3zfnZztqhpiblGU7_p7Un_hTbTVie0=s96-c,
 *  providerData, [UserInfo(displayName: Hend Jannat, email: h.jannat@lamah.com, phoneNumber: null,
 *  photoURL: https://lh3.googleusercontent.com/a/AATXAJxf2arhXF3zfnZztqhpiblGU7_p7Un_hTbTVie0=s96-c,
 *  providerId: google.com, uid: 109969944507026403385)], refreshToken: , tenantId: null, uid: ygghNt4YGeOddGyFtHRZ9b2jEPo1)

 */
  @override
  Widget build(BuildContext context) {
    print(_loginController.user);
    return Scaffold(
      endDrawer: SideDrawer(_loginController.user),
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => _logOut(context),
            child: Text(
              "Log out",
              style: TextStyle(color: Colors.yellow),
            ),
          ),
          Builder(
            builder: (context) => GestureDetector(
              child: CircleAvatar(
                  backgroundImage: Uri.parse(_loginController.user.photoURL).isAbsolute
                      ? NetworkImage(_loginController.user.photoURL)
                      : AssetImage("assets/images/user.png") as ImageProvider),
              onTap: () {
                print("open");
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
        ],
        title: Text(title),
      ),
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}

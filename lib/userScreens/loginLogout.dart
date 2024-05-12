/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
//import 'dart:html';

class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin= false;
  @override
  void initState() {
    super.initState();
    isSignedIn();
  }
  void isSignedIn() async{
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    //if (isLoggedin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage()));
    }

    setState(() {
      loading= false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;
   // print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
   // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    final UserCredential authResult = await firebaseAuth.signInWithCredential(
        credential);
    final FirebaseUser user = authResult.user;
//    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    if (firebaseAuth != null) {
      print("111111111111111111111111111111111111");
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        print("222222222222222222222222222222222222222");
        Firestore.instance
            .collection("users")
            .document(user.uid)
            .setData({
          "id": user.uid,
          "username": user.displayName,
          "profilePicture": user.photoUrl
        });

        await preferences.setString(("id"), user.uid);
        await preferences.setString(("username"), user.displayName);
        await preferences.setString(("photoUrl"), user.displayName);
      }
      else {
        await preferences.setString(("id"), documents[0]['id']);
        await preferences.setString(("username"), documents[0]['username']);
        await preferences.setString(("photoUrl"), documents[0]['photoUrl']);
      }
      Fluttertoast.showToast(msg: "login was successful");
      setState(() {
        loading = false;
      });
    } else {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text("Login",
        style: TextStyle(color: Colors.red.shade900),),
        elevation: 0.1,
      ),
      body: Stack(
        children: [
          Center(
            child: FlatButton(
              color: Colors.red.shade900,
              onPressed: (){
                handleSignIn();
              },child: Text("Sign in with Google account",style: TextStyle(color: Colors.white),),
            )
          ),
          Visibility(
            visible: loading?? true,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
//import 'dart:html';
//etho de unstar
/*
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/tools/app_methods.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/firebase_methods.dart';
import 'package:trendy_hues/userScreens/signup.dart';
import 'package:trendy_hues/tools/progressdialog.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
Future<void> fnc()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TrendyLogin());
}

class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {


  //TextEditingController email = new TextEditingController();
  //TextEditingController password = new TextEditingController();
 // final scaffoldKey = new GlobalKey<ScaffoldState>();
 // BuildContext context;

  //--------------------------------------change//
  //AppMethods appMethods = new FirebaseMethods();
/*
  final GoogleSignIn googleSignIn= new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;

  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if(isLoggedin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage() ));
    }

    setState(() {
      loading=false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    getCurrentUser() async {
      final FirebaseUser user = await firebaseAuth.currentUser();
      final uid = user.uid.toString();
      final displayName = user.displayName;
      return uid;
    }


    if (firebaseAuth != null) {
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: firebaseAuth.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseAuth.uid)
            .setData({
          "id": firebaseAuth.uid,
          "username": firebaseAuth.displayName,
          "profilePicture": firebaseAuth.photoUrl
        });

        await preferences.setString(("id"), firebaseAuth.uid);
        await preferences.setString(("username"), firebaseAuth.displayName);
        await preferences.setString(("photoUrl"), firebaseAuth.displayName);
      }
    } else {
      await preferences.setString(("id"), documents[0]['id']);
      await preferences.setString(("username"), documents[0]['username']);
      await preferences.setString(("photoUrl"), documents[0]['photoUrl']);

      Fluttertoast.showToast(msg: "hello");
      setState(() {
        loading = false;
      });
    }
  }
*/



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Login"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("My Login",
          style: new TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }*/
   // this.context = context;
    return new Scaffold(
   //   key: scaffoldKey,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      // decoration:BoxDecoration(
      //gradient: LinearGradient(
      // colors: [
      // Colors.lightGreenAccent,
      // Colors.white
      // ]
      //)
      //),
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
      /*body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email
            ),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            appButton(
                btnTxt: "Login",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme
                    .of(context)
                    .primaryColor),
            new GestureDetector(
              onTap: () {
               // Navigator.of(context).push(
                 //   new MaterialPageRoute(builder: (context) => new TrendySignup()));
              },
              child: new Text(
                "Not Registered? Sign Up Here",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),*/
      body: _buildBody(context),
    );
  }

  /*verifyLoggin() async {
    if (email.text == "") {
      //showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
     // showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    //displayProgressDialog(context);
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.toLowerCase(),
          password: password.text.toLowerCase());
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("NO user found for that email"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }else if(e.code=='wrong-password'){
        showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("Wrong password provided"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
    }
    //AppMethods obj;
    // String response = await obj.logginUser(
    //   email: email.text.toLowerCase(), password: password.text.toLowerCase());
    // if (response == successful) {
    // closeProgressDialog(context);
    // Navigator.of(context).pop(); //------------Add true in ()
    //} else {
    // closeProgressDialog(context);
    //showSnackBar(response, scaffoldKey);
    //}
  }*/




  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.votes.toString()),
            onTap: () => record.reference.updateData({'votes': record.votes + 1})
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";*/

//-----------------------baby example database-----------------
/*
Future<void> fnc()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.votes.toString()),
            onTap: () => record.reference.updateData({'votes': record.votes + 1})
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}*/


class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {


  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethods = new FirebaseMethods();
/*
  final GoogleSignIn googleSignIn= new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;

  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if(isLoggedin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage() ));
    }

    setState(() {
      loading=false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    getCurrentUser() async {
      final FirebaseUser user = await firebaseAuth.currentUser();
      final uid = user.uid.toString();
      final displayName = user.displayName;
      return uid;
    }


    if (firebaseAuth != null) {
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: firebaseAuth.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseAuth.uid)
            .setData({
          "id": firebaseAuth.uid,
          "username": firebaseAuth.displayName,
          "profilePicture": firebaseAuth.photoUrl
        });

        await preferences.setString(("id"), firebaseAuth.uid);
        await preferences.setString(("username"), firebaseAuth.displayName);
        await preferences.setString(("photoUrl"), firebaseAuth.displayName);
      }
    } else {
      await preferences.setString(("id"), documents[0]['id']);
      await preferences.setString(("username"), documents[0]['username']);
      await preferences.setString(("photoUrl"), documents[0]['photoUrl']);

      Fluttertoast.showToast(msg: "hello");
      setState(() {
        loading = false;
      });
    }
  }
*/



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Login"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("My Login",
          style: new TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }*/
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      // decoration:BoxDecoration(
      //gradient: LinearGradient(
      // colors: [
      // Colors.lightGreenAccent,
      // Colors.white
      // ]
      //)
      //),
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email
            ),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            appButton(
                btnTxt: "Login",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme
                    .of(context)
                    .primaryColor),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new TrendySignup()));
              },
              child: new Text(
                "Not Registered? Sign Up Here",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  verifyLoggin() async {
    if (email.text == "") {
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text.toLowerCase(),
          password: password.text.toLowerCase());
    } on PlatformException catch (e) {
      print(e.message);
      if (e.code == 'user-not-found') {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("NO user found for that email"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      } else if (e.code == 'wrong-password') {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Wrong password provided"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
    }
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new MainPage()));

  }
}
*/


// firebase code
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/userScreens/signup.dart';
class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (value){
                        setState(() {
                          _email= value;
                        });
                      }
                  ),
                  SizedBox(height: 15.0),
                  TextField(
                      decoration:  InputDecoration(hintText: 'Password'),
                      onChanged: (value){
                        setState(() {
                          _password = value;
                        });
                      }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email,
                          password: _password).then((FirebaseUser) {
                        Navigator.of(context).pushReplacementNamed('/mainPage');
                      }).catchError((e) {
                        print(e);
                      });

                    },
                  ),
                  SizedBox(height: 15.0),
                  Text("Don't have an account ?"),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text('Sign up'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                     //Navigator.pushNamed(context , '/signup');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TrendySignup()));
                    //  Navigator.of(context).pushReplacementNamed('/signup');
                    },
                  ),
                ],
              )
          ),
        )
    );
  }
}*/


//-----------------------------------------layout changes
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
//import 'dart:html';

class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin= false;
  @override
  void initState() {
    super.initState();
    isSignedIn();
  }
  void isSignedIn() async{
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    //if (isLoggedin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage()));
    }

    setState(() {
      loading= false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;
   // print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
   // print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
    final UserCredential authResult = await firebaseAuth.signInWithCredential(
        credential);
    final FirebaseUser user = authResult.user;
//    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");

    if (firebaseAuth != null) {
      print("111111111111111111111111111111111111");
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: user.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        print("222222222222222222222222222222222222222");
        Firestore.instance
            .collection("users")
            .document(user.uid)
            .setData({
          "id": user.uid,
          "username": user.displayName,
          "profilePicture": user.photoUrl
        });

        await preferences.setString(("id"), user.uid);
        await preferences.setString(("username"), user.displayName);
        await preferences.setString(("photoUrl"), user.displayName);
      }
      else {
        await preferences.setString(("id"), documents[0]['id']);
        await preferences.setString(("username"), documents[0]['username']);
        await preferences.setString(("photoUrl"), documents[0]['photoUrl']);
      }
      Fluttertoast.showToast(msg: "login was successful");
      setState(() {
        loading = false;
      });
    } else {}
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: new Text("Login",
        style: TextStyle(color: Colors.red.shade900),),
        elevation: 0.1,
      ),
      body: Stack(
        children: [
          Center(
            child: FlatButton(
              color: Colors.red.shade900,
              onPressed: (){
                handleSignIn();
              },child: Text("Sign in with Google account",style: TextStyle(color: Colors.white),),
            )
          ),
          Visibility(
            visible: loading?? true,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
//import 'dart:html';
//etho de unstar
/*
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/tools/app_methods.dart';
import 'package:trendy_hues/tools/app_data.dart';
import 'package:trendy_hues/tools/firebase_methods.dart';
import 'package:trendy_hues/userScreens/signup.dart';
import 'package:trendy_hues/tools/progressdialog.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
import 'package:provider/provider.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*
Future<void> fnc()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TrendyLogin());
}

class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {


  //TextEditingController email = new TextEditingController();
  //TextEditingController password = new TextEditingController();
 // final scaffoldKey = new GlobalKey<ScaffoldState>();
 // BuildContext context;

  //--------------------------------------change//
  //AppMethods appMethods = new FirebaseMethods();
/*
  final GoogleSignIn googleSignIn= new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;

  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if(isLoggedin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage() ));
    }

    setState(() {
      loading=false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    getCurrentUser() async {
      final FirebaseUser user = await firebaseAuth.currentUser();
      final uid = user.uid.toString();
      final displayName = user.displayName;
      return uid;
    }


    if (firebaseAuth != null) {
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: firebaseAuth.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseAuth.uid)
            .setData({
          "id": firebaseAuth.uid,
          "username": firebaseAuth.displayName,
          "profilePicture": firebaseAuth.photoUrl
        });

        await preferences.setString(("id"), firebaseAuth.uid);
        await preferences.setString(("username"), firebaseAuth.displayName);
        await preferences.setString(("photoUrl"), firebaseAuth.displayName);
      }
    } else {
      await preferences.setString(("id"), documents[0]['id']);
      await preferences.setString(("username"), documents[0]['username']);
      await preferences.setString(("photoUrl"), documents[0]['photoUrl']);

      Fluttertoast.showToast(msg: "hello");
      setState(() {
        loading = false;
      });
    }
  }
*/



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Login"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("My Login",
          style: new TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }*/
   // this.context = context;
    return new Scaffold(
   //   key: scaffoldKey,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      // decoration:BoxDecoration(
      //gradient: LinearGradient(
      // colors: [
      // Colors.lightGreenAccent,
      // Colors.white
      // ]
      //)
      //),
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
      /*body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email
            ),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            appButton(
                btnTxt: "Login",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme
                    .of(context)
                    .primaryColor),
            new GestureDetector(
              onTap: () {
               // Navigator.of(context).push(
                 //   new MaterialPageRoute(builder: (context) => new TrendySignup()));
              },
              child: new Text(
                "Not Registered? Sign Up Here",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),*/
      body: _buildBody(context),
    );
  }

  /*verifyLoggin() async {
    if (email.text == "") {
      //showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
     // showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    //displayProgressDialog(context);
    try{
      UserCredential userCredential= await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.toLowerCase(),
          password: password.text.toLowerCase());
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("NO user found for that email"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }else if(e.code=='wrong-password'){
        showDialog(context: context,
            builder: (BuildContext context)
            {
              return AlertDialog(
                title: Text("Wrong password provided"),
                actions: [
                  FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
    }
    //AppMethods obj;
    // String response = await obj.logginUser(
    //   email: email.text.toLowerCase(), password: password.text.toLowerCase());
    // if (response == successful) {
    // closeProgressDialog(context);
    // Navigator.of(context).pop(); //------------Add true in ()
    //} else {
    // closeProgressDialog(context);
    //showSnackBar(response, scaffoldKey);
    //}
  }*/




  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.votes.toString()),
            onTap: () => record.reference.updateData({'votes': record.votes + 1})
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";*/

//-----------------------baby example database-----------------
/*
Future<void> fnc()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.votes.toString()),
            onTap: () => record.reference.updateData({'votes': record.votes + 1})
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final int votes;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['votes'] != null),
        name = map['name'],
        votes = map['votes'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$votes>";
}*/


class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {


  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethods = new FirebaseMethods();
/*
  final GoogleSignIn googleSignIn= new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedin = false;

  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedin = await googleSignIn.isSignedIn();
    if(isLoggedin) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage() ));
    }

    setState(() {
      loading=false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleUser
        .authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    getCurrentUser() async {
      final FirebaseUser user = await firebaseAuth.currentUser();
      final uid = user.uid.toString();
      final displayName = user.displayName;
      return uid;
    }


    if (firebaseAuth != null) {
      final QuerySnapshot result = await Firestore.instance.collection("users")
          .where("id", isEqualTo: firebaseAuth.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        Firestore.instance
            .collection("users")
            .document(firebaseAuth.uid)
            .setData({
          "id": firebaseAuth.uid,
          "username": firebaseAuth.displayName,
          "profilePicture": firebaseAuth.photoUrl
        });

        await preferences.setString(("id"), firebaseAuth.uid);
        await preferences.setString(("username"), firebaseAuth.displayName);
        await preferences.setString(("photoUrl"), firebaseAuth.displayName);
      }
    } else {
      await preferences.setString(("id"), documents[0]['id']);
      await preferences.setString(("username"), documents[0]['username']);
      await preferences.setString(("photoUrl"), documents[0]['photoUrl']);

      Fluttertoast.showToast(msg: "hello");
      setState(() {
        loading = false;
      });
    }
  }
*/



  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.green,
        title: new Text("Login"),
        centerTitle: false,
      ),
      body: new Center(
        child: new Text("My Login",
          style: new TextStyle(fontSize: 25.0),
        ),
      ),
    );
  }*/
    this.context = context;
    return new Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      // decoration:BoxDecoration(
      //gradient: LinearGradient(
      // colors: [
      // Colors.lightGreenAccent,
      // Colors.white
      // ]
      //)
      //),
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: false,
        elevation: 0.0,
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email
            ),
            new SizedBox(
              height: 30.0,
            ),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            appButton(
                btnTxt: "Login",
                onBtnclicked: verifyLoggin,
                btnPadding: 20.0,
                btnColor: Theme
                    .of(context)
                    .primaryColor),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new TrendySignup()));
              },
              child: new Text(
                "Not Registered? Sign Up Here",
                style: new TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  verifyLoggin() async {
    if (email.text == "") {
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }

    displayProgressDialog(context);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text.toLowerCase(),
          password: password.text.toLowerCase());
    } on PlatformException catch (e) {
      print(e.message);
      if (e.code == 'user-not-found') {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("NO user found for that email"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      } else if (e.code == 'wrong-password') {
        showDialog(context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Wrong password provided"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      }
    }
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => new MainPage()));

  }
}
*/
//-------------firebase login
/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trendy_hues/userScreens/signup.dart';
class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
          child: Container(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                      onChanged: (value){
                        setState(() {
                          _email= value;
                        });
                      }
                  ),
                  SizedBox(height: 15.0),
                  TextField(
                      decoration:  InputDecoration(hintText: 'Password'),
                      onChanged: (value){
                        setState(() {
                          _password = value;
                        });
                      }
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text('Login'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email,
                          password: _password).then((FirebaseUser) {
                        Navigator.of(context).pushReplacementNamed('/mainPage');
                      }).catchError((e) {
                        print(e);
                      });

                    },
                  ),
                  SizedBox(height: 15.0),
                  Text("Don't have an account ?"),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    child: Text('Sign up'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 7.0,
                    onPressed: () {
                     //Navigator.pushNamed(context , '/signup');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TrendySignup()));
                    //  Navigator.of(context).pushReplacementNamed('/signup');
                    },
                  ),
                ],
              )
          ),
        )
    );
  }
}*/

// layout design
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendy_hues/tools/app_tools.dart';
import 'package:trendy_hues/userScreens/MainPage.dart';
import 'package:trendy_hues/userScreens/itemDetails.dart';
import 'package:trendy_hues/userScreens/reset.dart';
import 'package:trendy_hues/userScreens/signup.dart';


class TrendyLogin extends StatefulWidget {
  @override
  _TrendyLoginState createState() => _TrendyLoginState();
}

class _TrendyLoginState extends State<TrendyLogin> {

  String _email;
  String _password;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

  TextEditingController __email = TextEditingController();
  TextEditingController __password = TextEditingController();
  //TextEditingController controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/background.png'),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      /* Positioned(
                        left: 30,
                        width: 80,
                        height: 500,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/image/2.png')
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-2.png')
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/clock.png')
                              )
                          ),
                        ),
                      ),*/
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 300,right: 230),
                          child: Center(
                            child: Text("Login",
                              style: TextStyle(
                                  color: Color.fromRGBO(143, 148, 251, 1),
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child : Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10)
                                )
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextFormField(
                                    controller: __email,
                                 // inputFormatters: [WhitelistingTextInputFormatter(RegExp('[0-9a-zA-Z@]'))],
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex = new RegExp(pattern);
                                        if (!regex.hasMatch(value))
                                          return 'Please make sure your email address is valid';
                                        else
                                          return null;
                                      }
                                    },
                                  onChanged: (value){
                                       setState(() {
                                       _email= value;
                                     });}
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(3.0),
                                child: TextFormField(
                                    controller: __password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey[400])
                                  ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        showSnackBar("The password field cannot be empty", _key);
                                        //return "The password field cannot be empty";
                                      } else if (value.length < 8) {
                                        showSnackBar("the password has to be at least 8 characters long",_key);
                                       // return "the password has to be at least 8 characters long";
                                      }
                                      return null;
                                    },
                                    onChanged: (value){
                                      setState(() {
                                        _password = value;
                                      });
                                    }
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ]
                              )
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            color: Color.fromRGBO(143, 148, 251, 1),
                            textColor: Colors.white,
                            elevation: 7.0,
                            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            onPressed: () {
                              FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: _email,
                                  password: _password).then((FirebaseUser) {
                                    if(firebaseUser.emailVerified){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));}
                                    else{
                                      print("invalid user");
                                      showSnackBar("Invalid User", scaffoldKey);
                                    }
                                    //Navigator.of(context).pushReplacementNamed('/mainPage');
                              }).catchError((e) {
                                print(e);
                              });

                            },
                          ),
                        ),
                        SizedBox(height: 30,),
                        Text("Don't have an account ?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),),
                        //SizedBox(height: 10.0),
                        RaisedButton(
                          color: Color.fromRGBO(143, 148, 251, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          textColor: Colors.white,
                          elevation: 7.0,
                          child: Text('Sign up'),
                          onPressed: () {
                            //Navigator.pushNamed(context , '/signup');
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TrendySignup()));
                            //  Navigator.of(context).pushReplacementNamed('/signup');
                          },
                        ),

                        SizedBox(height: 5,),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TrendyReset()));
                          },
                            child: Text("Forget Password", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),


                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }}





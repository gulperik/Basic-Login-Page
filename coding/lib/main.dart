
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'package:lottie/lottie.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
       title: 'Flutter Demo',
       theme: ThemeData(
      
       ),
       home: const RegisterView() ,
    ),
    
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
       primaryColor: Colors.orange,
      ),
      home: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
   
    super.initState();
  }

@override
  void dispose() {
    _email.dispose();
    _password.dispose();
    
    super.dispose();
  }


 @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Colors.orange,
        
        title: const Text('Login'),
      ),
      
     body: FutureBuilder(

      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),

      builder: (context, snapshot) {

        switch (snapshot.connectionState){

        
          case ConnectionState.done:
            
            return Column(
           children:[    
        Lottie.asset('assets/telefon.json',
        width: 180,
        height: 180,
        fit: BoxFit.fill
        ),

        TextField(
          controller: _email,
          enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(hintText: 'Enter your email here!'),
        ),

         
          TextField(
            controller: _password,
            //şifreyi gizler
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Enter your password here!'),
          ),

        
        TextButton(
      onPressed: () async {
        
      final email =_email.text;
      final password = _password.text;
     
  
      final UserCredential = FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      print(UserCredential);

     

      },
      child: const Text('Login',
      style: TextStyle(
        color: Colors.orange,
      ),),
     
     
     ),

     TextButton(
      onPressed: () async{
         await signInWithGoogle();
      },
     
     child: const Row(
      mainAxisAlignment: MainAxisAlignment.center,
       children:  [
        Icon(Icons.g_mobiledata), 
      SizedBox(width: 8),
     
     Text('Continue with Google',
        style: TextStyle(
      color: Colors.orange,
     ),
     
     ),
     
    ],

     ),


     )
       
          ] 

        );
            
           default: 
        return const Text('Loading...');
      }
    
        
        }

     ),     
       
     
    );

     
  }

   signInWithGoogle() async{

     GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

     GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

     AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken:googleAuth?.idToken ,
      );
          
         UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
         print(userCredential.user?.displayName);

        }
}



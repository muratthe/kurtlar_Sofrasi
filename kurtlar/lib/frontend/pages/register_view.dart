import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kurtlar/backend/lang/language_constant.dart';
import 'package:kurtlar/frontend/components/button.dart';
import 'package:kurtlar/frontend/pages/home_view.dart';
import 'package:kurtlar/frontend/pages/login_view.dart';
import 'package:kurtlar/main.dart';
/* Uygulamada degıstırılecek seyler */

/* Bu sayfada 5 haneli random kod ureten bır fonksıyon yazılacak. 
    Bu fonksıyon TextButton ıcerısınde cagırılacak. */

/* Ayrıca eğer textField'lar bos ıse bu durum kontrol edılecek ve textFıeld ıcerısınde bır hata mesajı gonderılecek */

// Email de alınacak register sayfasında. Ek olarak kullanıcı kendi emaili ve şifresi ile giriş yapabilecek.
//Kullanıcı adı ve invite codu profile sayfasında gösterilecek

/* TextFıeld kontrol işlemi logın sayfasında da yapılacak */

/* Logın sayfasında gırılen e-mail ve password eger database ıcerısınde varsa homePage'e gırecek. 
Gırılen degerler database ıcerısınde degılse hata kodu verılecek */

/* Anasayfaya geldıkten sonra telefonu kullanan kısının dataBase'indeki invite code bilgisi cekılıp 
   profile_view dartt dosyasındakı ınviteCode text ıcerısınde kullanılacak */

/* Ayrıca bu kullanıcının nıckname'ı profılevıew da en basta gozukecek ama bu nıckname profılevıew da degıtırılebılecek */

/* Anasayfayı gectıkten sonra telefonu elınde tutan kısı code'u gırdıkten sonra eğer bu kod database ıcerısınde varsa
   sayfa uzerınde bu koda sahıp olan oyuncunun ısmı gozukecek. Bu ınvıte code database ıcerısınde degılse hata mesajı verecek */

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  var username = TextEditingController();
  var password = TextEditingController();
  // Users collectionda bizim verileri tuttugumuz yer var. Bu tuttugumuz yer bır degıskenın ıcıne atıldı.
  var data = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
  }

  /* Kaydet adlı fonksıyon, kullanıcı adı ve sıfrede yazılan bılgılerı bu fonksıyon ıcerısıne alır ve 
  Sayfanın sonundakı kaydet butonuna bastıgımız zaman bu fonksıyon ıcerısıne gonderdıgımız bılgılerı database'e gonderır. */

  /* Bu fonksıyondakı parametrelerın tamamlanması ıcın bu sayfa ıcerısıde random sayı ureten bır 
    fonksıyon yazılacak ve bu fonksıyon cagırıldıgında her bır kullanıcı ıcın unique bir invite code olusturacak */

  void kaydet(var data, String username, String password, int money, int point,
      String inviteCode) {
    //while
    //var x = generateCode();

    setState(() {
      print("geldi");
      data.add({
        "username": username,
        "password": password,
        "invitecode": inviteCode,
        "money": money,
        "point": point
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /* Bu textler regıster sayfasında textFıeldların ıcını doldurmadan gırmeyı onlemek ıcın yaratıldı*/
    String passwordText, usernameText;
    passwordText = password.text;
    usernameText = username.text;
    bool _validate = false;

    /* Sayfanın ana sablonu burada olusturuldu */
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        /* Logın sayfasına donmek ıcın ıcon koyuldu */
        leading: GestureDetector(
          onTap: () {
            setState(() {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()));
            });
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(translate(context).signup),
        centerTitle: true,
      ),

      /* Sayfa govdesınde 2 adet textFıeld 1 adet button var */
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
        child: Column(
          children: [
            /* Nıckname'ı alan textFıeld */
            TextField(
              controller: username,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  hintText: translate(context).username,
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0))),
            ),
            const SizedBox(height: 10),

            /* Sıfreyı alan textFıeld */
            TextField(
              controller: password,
              obscureText: true,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_person_outlined,
                    color: Colors.black,
                  ),
                  hintText: translate(context).password,
                  // errorText: 'Sımdı Sıctın AQ',
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0))),
            ),
            const SizedBox(height: 40),

            /* Uyelık olusturulduktan sonra Logın sayfasına gerı donulecek */

            /* Text Button yerıne farklı bizim components'da yarattıgımız button cekılebılır. 
           Textler eger bossa textFıeld ıcerısınde hata mesajı gonderılebılır. */
            TextButton(
                onPressed: (() {
                  setState(() {
                    if (passwordText == '' && usernameText == '') {
                      print('Veri Geldi');
                    } else {
                      kaydet(data, username.text, password.text, 0, 0, "BCD32");
                      Navigator.pop(context);
                    }
                  });
                }),
                child: Text("Kaydet"))
          ],
        ),
      ),
    );
  }
}

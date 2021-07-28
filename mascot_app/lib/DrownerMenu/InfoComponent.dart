import 'package:flutter/material.dart';
import 'package:mascot_app/ExtraComponents/AppbarDefault.dart';

class InfoContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBarDefault(titleP: "About us"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height:50),
              Text("MascotApp is a company and application focused on animals, currently a small company. Our goal is to provide virtual platforms, which allow users to be attentive and have the information of their pets in their hands, all the time through their mobile device.", style: TextStyle(fontSize: 16,), textAlign: TextAlign.justify,),
              SizedBox(height:30),
              Text("During the development of the mobile application, we seek to establish a base community of pet owners, which will allow us to implement various changes and design tests in our system, seeking the most centralized ux system for our clients.", style: TextStyle(fontSize: 16,), textAlign: TextAlign.justify,),
              SizedBox(height:30),
              Text("The business offer, which we actively seek, are responsibilities that every pet owner should perceive, however, they do not take into account due to the limited availability they have to have it at their immediate disposal. Seeking to make all owners aware of their responsibilities and the rights that their pets have, we focus on learning from our users and transmitting knowledge every day.", style: TextStyle(fontSize: 16,), textAlign: TextAlign.justify,),
            ],
          )
        ),    
      )
    );
    return scaffold;
  }
}
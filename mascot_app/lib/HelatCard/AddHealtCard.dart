import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mascot_app/ExtraComponents/HealtCardFuntios.dart';
import 'package:mascot_app/mainApp.dart';
import 'package:mascot_app/objects/cards.dart';
import 'package:mascot_app/provider/cards_provider.dart';
import 'package:mascot_app/utils/utilsCards.dart';
import 'package:provider/provider.dart';

class AddHealtCard extends StatefulWidget {
  final Cards card;
   
  const AddHealtCard({
    Key key,
    this.card,
  }) : super(key: key);

  @override
  _CardsEdittingPageState createState() => _CardsEdittingPageState();
}

class _CardsEdittingPageState extends State<AddHealtCard>{
  final _formKey = GlobalKey<FormState>();
  final petNameControler = TextEditingController();
  final sexControler = TextEditingController();
  final specieControler = TextEditingController();
  final breedControler = TextEditingController();
  final weightControler = TextEditingController();
  final colorControler = TextEditingController();
  final veterinarianControler = TextEditingController();
  final microchipIdControler = TextEditingController();
  File _profileImage;
  final picker = ImagePicker();

  Timestamp birthDay;

  
  @override
  void initState(){
    super.initState();

    if(widget.card == null){
      birthDay = Timestamp.fromDate(DateTime.now());
    }else{
      birthDay =  widget.card.birthday;
      petNameControler.text = widget.card.petName;
      sexControler.text = widget.card.sex;
      specieControler.text= widget.card.specie;
      breedControler.text = widget.card.breed;
      weightControler.text = widget.card.weight;
      colorControler.text = widget.card.color;
      microchipIdControler.text = widget.card.mchipId;
      veterinarianControler.text = widget.card.veterinarian;
    }
  }

  Future getImage() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null){
        _profileImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    appBar: AppBar(
      title: Text("Health card"),
      backgroundColor: Colors.greenDefault,
      leading: CloseButton(),
      actions: buildEditingActions(),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Form (
        key: _formKey,
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children:[
                Text('Profile image'),
                FlatButton(
                  onPressed: () => getImage(), 
                  child: _profileImage == null ?
                     widget.card != null ?
                      widget.card.profileImageUrl != null ?
                        Image.network(widget.card.profileImageUrl, height: 100)
                      :
                        Icon(Icons.person) 
                    :
                      Icon(Icons.person) 
                  : Image.file(_profileImage, height: 100)
                )
              ]
            ),
            buildInput("Pet Name", petNameControler),
            SizedBox(height:30),
            buildBirthDay(),
            SizedBox(height:10),
            buildInput("Sex", sexControler),
            SizedBox(height:15),
            buildInput("Specie", specieControler),
            SizedBox(height:15),
            buildInput("Breed", breedControler),
            SizedBox(height:15),
            buildInput("Weight", weightControler),
            SizedBox(height:15),
            buildInput("Color", colorControler),
            SizedBox(height:15),
            buildInput("Veterinarian", veterinarianControler),
            SizedBox(height:15),
            buildInput("Microchip Id", microchipIdControler),
          ],
        ),
      )
    )
  );


  List<Widget> buildEditingActions() => [
    ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: saveForm,
      icon: Icon(Icons.done),
      label: Text('save'),
    ),
  ];

  Widget buildInput(String title, TextEditingController controller) => TextFormField(
    style: TextStyle(fontSize: 18),
    decoration: InputDecoration(
      labelText: title,
      border: UnderlineInputBorder(),
      hintText: title,
    ),
    onFieldSubmitted: (_) => saveForm(),
    validator: (title) => 
      title != null && title.isEmpty ? title + 'cannot be emty' : null,
    controller: controller,
  );

  Widget buildBirthDay() =>  builHeader(
    header: 'BirthDay',
    child: Row(
      children: [
        Expanded(
          child: buildDropdownField(
            text: UtilsCards.birthDayTime(birthDay.toDate()),
            onClicked: () => pickBirthDay(),
          )
        ),
      ],
    )
  );

   Widget buildDropdownField({
    String text,
    VoidCallback onClicked,  
  }) => ListTile(
    title: Text(text),
    trailing: Icon(Icons.arrow_drop_down),
    onTap: onClicked, 
  );

  Widget builHeader({
    String header, Row child
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(header, style: TextStyle(fontWeight: FontWeight.bold,),),
      child,
    ],
  );

  Future pickBirthDay() async {
    final date = await pickDateTime(
      birthDay.toDate(), 
      firsDate: DateTime.utc(1950),
    );

    if(date == null) return;

    setState(() => birthDay = Timestamp.fromDate(date));
  }

  Future<DateTime> pickDateTime(
    DateTime initialDate, {
      DateTime firsDate,
    }
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firsDate ?? DateTime(2015, 8),
      lastDate: DateTime(2101)
    );

    if (date == null) return null;

    final time =
      Duration(hours: initialDate.hour, minutes: initialDate.minute);

    return date.add(time);
  }

  Future saveForm() async {
    final isValid = _formKey.currentState.validate();
    HCServices _hcServices = HCServices();

    if(isValid) {
      final event = Cards(
        petName: petNameControler.text,
        sex: sexControler.text,
        birthday: birthDay,
        specie: specieControler.text,
        breed: breedControler.text,
        weight: weightControler.text,
        color: colorControler.text,
        veterinarian: veterinarianControler.text,
        mchipId: microchipIdControler.text,
      );

      final isEditting = widget.card!= null;
      if(isEditting){
        _hcServices.updateProfile(_profileImage, widget.card.id);
        _hcServices.updateCard( widget.card.id,petNameControler.text, 
          birthDay,  sexControler.text, specieControler.text, 
          breedControler.text, weightControler.text,  
          colorControler.text, veterinarianControler.text,  microchipIdControler.text);
      }else{
        _hcServices.saveCard(petNameControler.text, 
          birthDay,  sexControler.text, specieControler.text, 
          breedControler.text, weightControler.text,  
          colorControler.text, veterinarianControler.text,  microchipIdControler.text, _profileImage);
      }
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomePage())
      );
    }
  }
}
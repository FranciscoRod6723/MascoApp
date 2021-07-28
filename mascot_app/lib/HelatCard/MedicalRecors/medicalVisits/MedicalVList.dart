import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/medicalVisits/AddMedicalVDialog.dart';
import 'package:mascot_app/objects/medicalV.dart';
import 'package:mascot_app/provider/medicalV_provider.dart';
import 'package:provider/provider.dart';

class ListMedicalV extends StatefulWidget {
  final List<MedicalV> meidicalV;
  final String idp;
  const ListMedicalV(this.meidicalV,this.idp,{ Key key }) : super(key: key);

  @override
  _ListMedicalVState createState() => _ListMedicalVState();
}

class _ListMedicalVState extends State<ListMedicalV> {
  @override
  Widget build(BuildContext context) {
    List<MedicalV> n = Provider.of<List<MedicalV>>(context) ?? []; 
    for(int i = 0; i < n.length; i++){
      if(widget.meidicalV.length > 0 && widget.meidicalV.length == n.length){
        if(widget.meidicalV[i].id != n[i].id && widget.meidicalV[i].id != null){
          widget.meidicalV.add(n[i]);
        }else if (widget.meidicalV[i].id == null 
                  && widget.meidicalV[i].name != n[i].name 
                  && widget.meidicalV[i].comments != n[i].comments 
                  && widget.meidicalV[i].reason != n[i].reason){
          widget.meidicalV[i].id = n[i].id;
        }
      }else if(widget.meidicalV.length == 0){
        for(int e = 0; e < n.length; e++){
          widget.meidicalV.add(n[e]);
        }
        break;
      }
      
    }
    return Container(
      padding: EdgeInsets.all(1),
      child: ListView(
        children: [ ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded){
            setState(() {
              widget.meidicalV[index].isExpanded = !widget.meidicalV[index].isExpanded;
            });
          },
          children: widget.meidicalV.map((MedicalV item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext contex, bool isExpanded){
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Slidable( 
                  actionPane: SlidableBehindActionPane(),
                  key: Key("dewornm"),
                  actions: [
                    IconSlideAction(
                      color: Colors.green,
                      onTap: () => showDialog(context: context, builder: (BuildContext context) => AddMedicalVDialog(widget.idp,item), barrierDismissible: false),
                      caption: "Edit",
                      icon: Icons.edit,
                    )
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      color: Colors.red,
                      onTap: () {
                        MRServices _mrServices = MRServices();
                        final provider = Provider.of<MedicalVProvider>(context, listen: false);
                        provider.deleteEvent(item);
                        if(item.id != null){
                          _mrServices.deletedMedicalV(widget.idp, item.id);
                        }
                      },
                      caption: "Deletd",
                      icon: Icons.delete
                    )
                  ],
                  child: Column(
                      crossAxisAlignment: 
                      CrossAxisAlignment.start, 
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(item.name, style: TextStyle(fontSize: 26),),
                        ),
                        Text(item.todate.toDate().toString(), style: TextStyle(fontSize: 16))
                      ]
                    )
                ));
              },
              isExpanded: item.isExpanded,
              body: 
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width:.5, color: Colors.grey)
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('Hour', style: TextStyle(fontSize:18),)
                        ),
                        Expanded(
                          child: Text(item.todate.toDate().hour.toString() + ":" + item.todate.toDate().minute.toString() , style: TextStyle(fontSize:16),)
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('Veterinarian', style: TextStyle(fontSize:18),)
                        ),
                        Expanded(
                          child: Text(item.veterinarian, style: TextStyle(fontSize:16),)
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('Reazon', style: TextStyle(fontSize:18),)
                        ),
                        Expanded(
                          child: Text(item.reason, style: TextStyle(fontSize:16),)
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text('Comments', style: TextStyle(fontSize:18),)
                        ),
                        Expanded(
                          child: Text(item.comments, style: TextStyle(fontSize:16),)
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ])
    );
  }
}
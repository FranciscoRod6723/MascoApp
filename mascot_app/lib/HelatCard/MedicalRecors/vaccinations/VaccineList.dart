import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/vaccinations/AddVacineDialog.dart';
import 'package:mascot_app/objects/vaccinations.dart';
import 'package:mascot_app/provider/vaccine_provider.dart';
import 'package:provider/provider.dart';

class ListVaccine extends StatefulWidget {
  final List<Vaccinations> vaccine;
  final String idp;
  const ListVaccine(this.vaccine,this.idp,{ Key key }) : super(key: key);

  @override
  _ListVaccineState createState() => _ListVaccineState();
}

class _ListVaccineState extends State<ListVaccine> {
  @override
  Widget build(BuildContext context) {
    List<Vaccinations> n = Provider.of<List<Vaccinations>>(context) ?? []; 
    for(int i = 0; i < n.length; i++){
      if(widget.vaccine.length > 0 && widget.vaccine.length == n.length){
        if(widget.vaccine[i].id != n[i].id && widget.vaccine[i].id != null){
          widget.vaccine.add(n[i]);
        }
      }else if(widget.vaccine.length == 0){
        for(int e = 0; e < n.length; e++){
          widget.vaccine.add(n[e]);
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
              widget.vaccine[index].isExpanded = !widget.vaccine[index].isExpanded;
            });
          },
          children: widget.vaccine.map((Vaccinations item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext contex, bool isExpanded){
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Slidable( 
                  actionPane: SlidableBehindActionPane(),
                  key: Key("asda"),
                  actions: [
                    IconSlideAction(
                      color: Colors.green,
                      onTap: () => showDialog(context: context, builder: (BuildContext context) => AddVaccineDialog(widget.idp,item), barrierDismissible: false),
                      caption: "Edit",
                      icon: Icons.edit,
                    )
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      color: Colors.red,
                      onTap: () {
                        MRServices _mrServices = MRServices();
                        final provider = Provider.of<VaccineProvider>(context, listen: false);
                        provider.deleteEvent(item);
                        if(item.id != null){
                          _mrServices.deletedVaccine(widget.idp, item.id);
                        }
                      },
                      caption: "Deletd",
                      icon: Icons.delete
                    )
                  ],
                  child: Center(
                    child: 
                    Column(
                      crossAxisAlignment: 
                      CrossAxisAlignment.start, 
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(item.vaccine, style: TextStyle(fontSize: 26),),
                        ),
                        Text(item.date.toDate().toString(), style: TextStyle(fontSize: 16))
                      ]
                    )
                  ),
                ));
              },
              isExpanded: item.isExpanded,
              body: Container(
                decoration: BoxDecoration(
                  border: Border.all(width:.5, color: Colors.grey)
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text('Next vaccine', style: TextStyle(fontSize:18),)
                          ),
                          Expanded(
                            child: Text(item.next.toDate().toString(), style: TextStyle(fontSize:16),)
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
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ])
    );
  }
}
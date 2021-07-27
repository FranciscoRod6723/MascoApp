import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mascot_app/ExtraComponents/MedicalRFuntions.dart';
import 'package:mascot_app/HelatCard/MedicalRecors/deworming/AddDewormingDialog.dart';
import 'package:mascot_app/objects/dewornm.dart';
import 'package:mascot_app/provider/dewornm_provider.dart';
import 'package:provider/provider.dart';

class ListDewornm extends StatefulWidget {
  final List<Dewornm> dewornm;
  final String idp;
  const ListDewornm(this.dewornm,this.idp,{ Key key }) : super(key: key);

  @override
  _ListDewornmState createState() => _ListDewornmState();
}

class _ListDewornmState extends State<ListDewornm> {
  @override
  Widget build(BuildContext context) {
    List<Dewornm> n = Provider.of<List<Dewornm>>(context) ?? []; 
    for(int i = 0; i < n.length; i++){
      if(widget.dewornm.length > 0 && widget.dewornm.length == n.length){
        if(widget.dewornm[i].id != n[i].id && widget.dewornm[i].id != null){
          widget.dewornm.add(n[i]);
        }
      }else if(widget.dewornm.length == 0){
        for(int e = 0; e < n.length; e++){
          widget.dewornm.add(n[e]);
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
              widget.dewornm[index].isExpanded = !widget.dewornm[index].isExpanded;
            });
          },
          children: widget.dewornm.map((Dewornm item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext contex, bool isExpanded){
                return Slidable( 
                  actionPane: SlidableBehindActionPane(),
                  key: Key("dewornm"),
                  actions: [
                    IconSlideAction(
                      color: Colors.green,
                      onTap: () => showDialog(context: context, builder: (BuildContext context) => AddDewornmDialog(widget.idp,item), barrierDismissible: false),
                      caption: "Edit",
                      icon: Icons.edit,
                    )
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      color: Colors.red,
                      onTap: () {
                        MRServices _mrServices = MRServices();
                        final provider = Provider.of<DewornmProvider>(context, listen: false);
                        provider.deleteEvent(item);
                        if(item.id != null){
                          _mrServices.deletedDewornm(widget.idp, item.id);
                        }
                      },
                      caption: "Deletd",
                      icon: Icons.delete
                    )
                  ],
                  child: Center(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.deworn), Text(item.date.toDate().toString())])),
                );
              },
              isExpanded: item.isExpanded,
              body: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Next dewornming', style: TextStyle(fontSize:18),)
                      ),
                      Expanded(
                        child: Text(item.next.toDate().toString(), style: TextStyle(fontSize:18),)
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
                        child: Text(item.veterinarian, style: TextStyle(fontSize:18),)
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text('Weight', style: TextStyle(fontSize:18),)
                      ),
                      Expanded(
                        child: Text(item.weight, style: TextStyle(fontSize:18),)
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
                        child: Text(item.comments, style: TextStyle(fontSize:18),)
                      )
                    ],
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ])
    );
  }
}
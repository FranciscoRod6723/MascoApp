import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mascot_app/ExtraComponents/HealtCardFuntios.dart';
import 'package:mascot_app/HelatCard/Notes/AddNotes.dart';
import 'package:mascot_app/objects/notes.dart';
import 'package:mascot_app/provider/notes_provider.dart';
import 'package:provider/provider.dart';

class ListNotes extends StatefulWidget {
  final List<Notes> notes;
  final String idp;
  const ListNotes(this.notes,this.idp,{ Key key }) : super(key: key);

  @override
  _ListNotesState createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  @override
  Widget build(BuildContext context) {
    List<Notes> n = Provider.of<List<Notes>>(context) ?? []; 
    for(int i = 0; i < n.length; i++){
      if(widget.notes.length > 0 && widget.notes.length == n.length){
        if(widget.notes[i].id != n[i].id && widget.notes[i].id != null){
          widget.notes.add(n[i]);
        }
      }else if(widget.notes.length == 0){
        for(int e = 0; e < n.length; e++){
          widget.notes.add(n[e]);
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
              widget.notes[index].isExpanded = !widget.notes[index].isExpanded;
            });
          },
          children: widget.notes.map((Notes item) {
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
                      onTap: () => showDialog(context: context, builder: (BuildContext context) => AddNoteDialog(widget.idp,item), barrierDismissible: false),
                      caption: "Edit",
                      icon: Icons.edit,
                    )
                  ],
                  secondaryActions: [
                    IconSlideAction(
                      color: Colors.red,
                      onTap: () {
                        HCServices _hcServices = HCServices();
                        final provider = Provider.of<NotesProvider>(context, listen: false);
                        provider.deleteEvent(item);
                        if(item.id != null){
                          _hcServices.deletedNote(widget.idp, item.id);
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
                        Text(item.title, style: TextStyle(fontSize: 26),), 
                        Text(item.createDate.toDate().toString(), style: TextStyle(fontSize: 16))
                      ]
                    )
                  ),
                ));
              },
              isExpanded: item.isExpanded,
              body: Container(
                decoration: BoxDecoration(
                  
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text("Descripción", style: TextStyle(fontSize: 18)),
                      ),
                      Expanded(
                        child: Text(item.description, style: TextStyle(fontSize: 16)),
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
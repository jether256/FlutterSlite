import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_null_safety/flutter_neumorphic.dart';
class AddEdit extends StatefulWidget {

  String title;
   AddEdit({required this.title});

  @override
  State<AddEdit> createState() => _AddEditState();
}

class _AddEditState extends State<AddEdit> {

  static var _priorities = ['High','Low'];

  final TextEditingController tit= TextEditingController();
  final TextEditingController de= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        title: Center(child: Text(widget.title)),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
        children: [


          //first element
          ListTile(
            title: DropdownButton(
              items:_priorities.map((e){
                
                return DropdownMenuItem(
                  value: e,
                    child:Text(e),
                );
                    
              }).toList(),
              value: 'High',
              style: const TextStyle(fontSize: 14,color: Colors.black),
              onChanged: (value) {

                setState(() {
                  debugPrint('user selected $value');
                });
  },
            ),
          ),

          //seconde element

           Padding(
            padding: const EdgeInsets.only(top:15,bottom: 15),
            child: TextField(
              controller: tit,
              onChanged: (value){

                debugPrint('Something changed in Title field');

              },
              decoration:  InputDecoration(
                labelText: 'Title',
                labelStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

//third element
          Padding(
            padding: const EdgeInsets.only(top:15,bottom: 15),
            child: TextField(
              controller: de,
              onChanged: (value){

                debugPrint('Something changed in Description field');

              },
              decoration:  InputDecoration(
                labelText: 'Description',
                labelStyle: const TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

//fourth
          Padding(
            padding: const EdgeInsets.only(top:15,bottom: 15),
            child: Row(
              children: [
                Expanded(
                    child:MaterialButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: const Text('Save',),
                      onPressed: (){

                        debugPrint('Save button clicked');
                      },
                    )
                ),

                const SizedBox(width: 5,),

                Expanded(
                    child:MaterialButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: const Text('Delete',),
                      onPressed: (){

                        debugPrint('Delete button clicked');
                      },
                    )
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }


}

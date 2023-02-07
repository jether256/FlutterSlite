import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:time_doc/main/helper/litehelper.dart';
import 'package:time_doc/main/remainderadd.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  List<Map<String,dynamic>> _rem=[];

  final TextEditingController tit= TextEditingController();
  final TextEditingController ed= TextEditingController();

  bool _isloading=true;

  void _refreshRem() async{
    final data=await SQLHelper.getItems();

    setState(() {
      _rem=data;
      _isloading=false;
    });
  }


  @override
  void initState() {
    _refreshRem();
    super.initState();
    
    print("number of item ${_rem.length}");
  }
  //int count=7;


  Future<void> addItem() async{

    await SQLHelper.createItem(tit.text,ed.text);
    _refreshRem();
    print("number of item ${_rem.length}");
  }

  Future<void> _updateItem(int id) async{
    await SQLHelper.updateItem(id, tit.text, ed.text);
    _refreshRem();
}

void _deleteItem(int id) async{
    await SQLHelper.deleteItem(id);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:Text('Deleted successfully'))
    );
    _refreshRem();
}

  void showForm(int? id){

    if(id != null){

      final existRem=
     _rem.firstWhere((element)=>element['id']==id);
      tit.text=existRem['title'];
      ed.text=existRem['description'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder:(_)=>Container(
          padding:  EdgeInsets.only(top: 15,left: 15,right: 15,
            //this will prevent the text keyboard from covering the text fields
            bottom:MediaQuery.of(context).viewInsets.bottom + 66//+120

          ),

          child:Column(
            mainAxisSize: MainAxisSize.min,
            children: [

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
                  controller:ed,
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
                child:MaterialButton(
                  color:id== null ?  Colors.green:Colors.purple,
                  textColor: Colors.white,
                  child: Text(id== null ? 'Save':'Update'),
                  onPressed: () async {

                    if(id== null) {
                      await addItem();

                    }else{

                      await _updateItem(id);

                    }

                    ed.text='';
                    tit.text='';

                    Navigator.pop(context);


                  },
                ),
              ),
            ],
          ),


        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        leading: const Icon(Icons.home),
        title:const Center(child: Text("Reminder")),
      ),
      body: SafeArea(
        child:ListView.builder(
            itemCount:_rem.length,
            itemBuilder:(BuildContext context,int i){

              return Card(
                elevation: 3,
                color: Colors.grey[100],
                child: ListTile(
                  leading:const CircleAvatar(
                    backgroundColor: Colors.cyan,
                    child: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                  ),
                  onTap: (){
                    showForm(_rem[i]['id']);
                  },
                  title: Text(_rem[i]['title']),
                  subtitle:Text(_rem[i]['description']),
                  trailing: InkWell(
                        onTap:(){

                          _deleteItem(_rem[i]['id']);
                        },child: const Icon(Icons.delete,color: Colors.grey,),
                ),
                ),
              );

            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        tooltip: "Add Reminder",
        onPressed: () {

         // navigateDeatil('Add Reminder');

          showForm(null);
          
        },
        child: const Icon(Icons.add,color: Colors.white,),),
    );
  }



  void navigateDeatil(String title){

    Navigator.push(context,MaterialPageRoute(builder:(BuildContext context){

      return AddEdit(title: title,);
    }));
  }
}

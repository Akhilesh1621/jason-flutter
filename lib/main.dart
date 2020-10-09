import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:json_xml/Contact.dart';
import 'package:xml/xml.dart' as xml;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  Future<List<Contact>> getContactsFromJSON(BuildContext context) async{
    String jsonString = await  DefaultAssetBundle.of(context).loadString("assets/data/contacts.json");
      List<dynamic> raw = jsonDecode(jsonString);
      return raw.map((f)=> Contact.fromJSON(f)).toList();
  }

  Future<List<Contact>> getContactsFromXML(BuildContext context) async{
    String xmlString = await  DefaultAssetBundle.of(context).loadString("assets/data/contact.xml");
    var raw = xml.parse(xmlString);
    var elements = raw.findAllElements("contact");

    return elements.map((elements){
      return Contact(elements.findAllElements("name").first.text,
          elements.findAllElements("email").first.text,
          int.parse(elements.findAllElements("age").first.text)
      );
    }).toList();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data parser"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getContactsFromXML(context),
          builder: (context,data){
            if(data.hasData){
              List<Contact> contacts = data.data;
              return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: Text(contacts[index].name,style: TextStyle(
                        fontSize: 25.0,
                         fontWeight: FontWeight.bold
                      ),),
                      subtitle: Text(contacts[index].email),
                    );
                  });
            }else {
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ) ,
      )
    );
  }
}

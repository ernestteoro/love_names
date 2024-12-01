//import 'package:contacts_service/contacts_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/app-contact.dart';
import '../../widgets/contact-avatar.dart';
import '../../widgets/contacts-list.dart';


class SelectContact extends StatefulWidget {

  final String title;

  const SelectContact({Key? key, required this.title}): super(key: key);

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact>{

  TextEditingController searchController = TextEditingController();
  List<Contact>? _contacts, _contactsList;
  bool _permissionDenied = false;
  String? filter;

  //List<AppContact> _contacts = [];
  List<AppContact> contactsFiltered = [];
  Map<String, Color> contactsColorMap = new Map();
  bool contactsLoaded = false;
  int colorIndex = 0;
  List colors = [
    Colors.green,
    Colors.indigo,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    super.initState();
    getPermissions();
    _fetchContacts();
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text(widget.title)
     ),
     body: Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: TextField(
             controller: searchController,
             onChanged:(value) =>_filterContact(),
             decoration: InputDecoration(
               hintText: 'search_contact'.tr(),
               contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
               border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(32.0)),
             ),
           ),
         ),
         Expanded(
             child:contactsLoaded == true ? _body():Container(  // still loading contacts
               padding: const EdgeInsets.only(top: 40),
               child: const Center(
                 child: CircularProgressIndicator(),
               ),
             )
         )
       ],
     ),
   );
  }

  _fetchContacts() async{
    if(!await FlutterContacts.requestPermission(readonly: true)){
      setState(() => _permissionDenied=true);
    }else{
      final contacts = await FlutterContacts.getContacts();
      setState(() {
        _contacts = contacts;
        _contactsList = contacts;
        contactsLoaded=true;
      });
    }
  }

  _body() {
    return ListView.builder(
        itemCount: _contactsList!=null ? _contactsList!.length: 0,
        itemBuilder: (context, i){
          Color baseColor = colors[colorIndex];
          colorIndex++;
          if (colorIndex == colors.length) {
            colorIndex = 0;
          }
          return ListTile(
            title: Text(_contactsList![i].displayName),
            onTap: () async {
              final fullContact = await FlutterContacts.getContact(_contactsList![i].id);
              Navigator.pop(context, fullContact);
            },
            leading: ContactAvatar(_contactsList![i], 36, baseColor),
          );
        }
    );
  }

  _filterContact(){
    setState(() {
      if(searchController.text.isNotEmpty){
        _contactsList = _contacts!.where((contact) => contact.displayName.toLowerCase().contains(searchController.text.toLowerCase())).toList();
      }else{
        _contactsList = _contacts;
      }
    });
  }

  String flattenPhoneNumber(String phoneStr) {
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  getPermissions() async {
    if (await Permission.contacts.request().isGranted) {
      _fetchContacts();
      searchController.addListener(() {
        _filterContact();
      });
    }
  }

}

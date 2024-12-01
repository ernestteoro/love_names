import 'package:flutter/material.dart';

import '../model/app-contact.dart';

class ContactsList extends StatelessWidget {
  final List<AppContact>? contacts;
  ContactsList({Key? key, this.contacts,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts!.length,
        itemBuilder: (context, index) {
          AppContact contact = contacts![index];

          return ListTile(
            onTap: () async {
              Navigator.pop(context, contact);
            },
            title: Text(contact.info!.displayName!),
            subtitle: Text(
                contact.info!.phones!.isNotEmpty ? contact.info!.phones!.elementAt(0).value! : ''
            ),
            //leading: ContactAvatar(contact, 36)
          );
        },
      ),
    );
  }
}

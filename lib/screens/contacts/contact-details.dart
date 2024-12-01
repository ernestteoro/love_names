import 'package:flutter/material.dart';

import '../../model/app-contact.dart';

class ContactDetails extends StatefulWidget {
  ContactDetails(this.contact, {this.onContactUpdate, this.onContactDelete});

  final AppContact contact;
  final Function(AppContact)? onContactUpdate;
  final Function(AppContact)? onContactDelete;

  @override
  _ContactDetailsState createState() => _ContactDetailsState();
}

class _ContactDetailsState extends State<ContactDetails> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(shrinkWrap: true, children: <Widget>[
                ListTile(
                  title: const Text("Name"),
                  trailing: Text(widget.contact.info!.givenName ?? ""),
                ),
                ListTile(
                  title: const Text("Family name"),
                  trailing: Text(widget.contact.info!.familyName ?? ""),
                ),
                Column(
                  children: <Widget>[
                    const ListTile(title: Text("Phones")),
                    Column(
                      children: widget.contact.info!.phones!
                        .map(
                          (phone) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ListTile(
                              title: Text(phone.label ?? ""),
                              trailing: Text(phone.value ?? ""),
                            ),
                          ),
                        )
                        .toList(),
                    )
                  ],
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

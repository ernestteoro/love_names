import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';

import '../utils/get-color-gradient.dart';

class ContactAvatar extends StatelessWidget {
  ContactAvatar(this.contact, this.size, this.color);
  final Contact contact;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle, gradient: getColorGradient(color)),
        child: (contact.photo != null && contact.photo!.isNotEmpty)
            ? CircleAvatar(
                backgroundImage: MemoryImage(contact.photo!),
              )
            : CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Text(contact.displayName.characters.first.toUpperCase(),
                    style: const TextStyle(color: Colors.white))));
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactMe extends StatelessWidget {
  const ContactMe({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Contact Me'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Mohammad Abdul-Shafi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.facebook, color: Colors.blue),
                onPressed: () async {
                  final fbAppUrl = Uri.parse("fb://facewebmodal/f?href=https://www.facebook.com/shefoo26122003");
                  final fbWebUrl = Uri.parse("https://www.facebook.com/shefoo26122003");
                  if (await canLaunchUrl(fbAppUrl)) {
                    await launchUrl(fbAppUrl);
                  } else {
                    await launchUrl(fbWebUrl, mode: LaunchMode.externalApplication);
                  }
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue),
                onPressed: () async {
                  final url = Uri.parse("https://www.linkedin.com/in/mohammad-abdul-shafi-a8935a21b/");
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                onPressed: () async {
                  final phone = '+201200466959';
                  final url = Uri.parse("https://wa.me/${phone.replaceAll('+', '')}");
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Close'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

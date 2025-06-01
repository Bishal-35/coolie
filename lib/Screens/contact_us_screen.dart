import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  void _launchPhone(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $phoneNumber');
    }
  }

  void _launchWebsite(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Important Contact Numbers / Help Lines',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              _buildContactRow('(a) For Suggestion / Complaints:', '139'),
              _buildContactRow('(b) Railway Women Help Line:', '182'),
              _buildContactRow(
                  '(c) CSM Incharge Ramesh Prasad Mandal:', '9752877088'),
              GestureDetector(
                onTap: () async {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: 'rpmandal.mandal0@gmail.com',
                    query: Uri.encodeFull('subject=&body='),
                  );

                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri,
                        mode: LaunchMode.externalApplication);
                  } else {
                    debugPrint('Could not launch email');
                  }
                },
                child: const Text(
                  'rpmandal.mandal0@gmail.com',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ), // _buildContactRow('(d) OC RPF:', '9752877709'),
              // _buildContactRow('(e) Commercial Control Raipur:', '9752877998'),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  final Uri url =
                      Uri.parse('https://railmadad.indianrailways.gov.in');
                  if (!await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  )) {
                    // This runs if launch fails
                    debugPrint("Could not launch IRCTC");
                  }
                },
                // _launchWebsite('https://railmadad.indianrailways.gov.in'),
                // _launchWebsite('https://railmadad.indianrailways.gov.in'),
                child: const Text(
                  'Website: railmadad.indianrailways.gov.in',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactRow(String label, String number) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GestureDetector(
        onTap: () => _launchPhone(number),
        child: RichText(
          text: TextSpan(
            text: '$label ',
            style: const TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: number,
                style: const TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

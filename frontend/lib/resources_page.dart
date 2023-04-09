import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources & Support'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('National Institute of Mental Health, Sri Lanka'),
            subtitle: const Text(
                'Offers mental health services, research, training, and advocacy in Sri Lanka.'),
            onTap: () {
              launch('http://nimh.health.gov.lk/');
            },
          ),
          ListTile(
            title: const Text('Sumithrayo'),
            subtitle: const Text(
                'Provides free and confidential emotional support to those in distress through a helpline, email, and in-person counseling sessions in Sri Lanka.'),
            onTap: () {
              launch('tel:+94112696666');
            },
          ),
          ListTile(
            title: const Text('The Care Mobile'),
            subtitle: const Text(
                'A mobile mental health service that provides counseling and support to those in need in rural and remote areas of Sri Lanka.'),
            onTap: () {
              launch('https://www.thecaremobile.lk/');
            },
          ),
          ListTile(
            title: const Text('National Council for Mental Health'),
            subtitle: const Text(
                'A government organization that works to improve mental health policies, services, and awareness in Sri Lanka.'),
            onTap: () {
              launch('https://www.ncmh.gov.lk/');
            },
          ),
          ListTile(
            title: const Text('Colombo North Teaching Hospital'),
            subtitle: const Text(
                'Provides psychiatric and psychological services to patients in Sri Lanka.'),
            onTap: () {
              launch('https://www.cnth.lk/');
            },
          ),
          ListTile(
            title: const Text('Lanka Alzheimer\'s Foundation'),
            subtitle: const Text(
                'Provides support and resources for individuals and families affected by Alzheimer\'s disease in Sri Lanka.'),
            onTap: () {
              launch('https://www.lankaalzheimers.org/');
            },
          ),
          ListTile(
            title: const Text('National Institute of Social Development'),
            subtitle: const Text(
                'Provides counseling and support for individuals and families dealing with mental health issues in Sri Lanka.'),
            onTap: () {
              launch('https://www.nisd.gov.lk/');
            },
          ),
        ],
      ),
    );
  }
}

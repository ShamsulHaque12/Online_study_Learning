import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tier2DetailsScreen extends StatelessWidget {
  final String tittle;
  Tier2DetailsScreen({super.key, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tier 2 Details'),
      ),
    );
  }
}

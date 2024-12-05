import 'package:flutter/material.dart';


Widget build3DSection({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }
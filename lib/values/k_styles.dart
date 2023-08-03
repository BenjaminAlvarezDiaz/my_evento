import 'package:flutter/material.dart';

import 'k_colors.dart';

bottomContainerShadow() => const BoxShadow(
    color: Color(0x55666666),
    spreadRadius: -1,
    blurRadius: 5,
    offset: Offset(1, 1));

topContainerShadow() => const BoxShadow(
    color: Color(0x40666666),
    spreadRadius: -1,
    blurRadius: 5,
    offset: Offset(0, 1));

centerContainerShadow() => const BoxShadow(
    color: Color(0x40666666),
    spreadRadius: -1,
    blurRadius: 5,
    offset: Offset(0, 0));

topContainerOrangeShadow() => BoxShadow(
      color: KPrimary.withOpacity(0.2),
      spreadRadius: -5,
      blurRadius: 5,
      offset: const Offset(0, 4),
    );

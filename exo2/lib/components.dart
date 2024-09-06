import 'package:exo2/consts.dart';
import 'package:flutter/material.dart';

class MyPadding extends Padding {
  const MyPadding({super.key, required super.child}): super(padding: defaultPadding);
}

class MyText extends Text {
  const MyText(super.data, {super.key}): super(style: defaulTextStyle);
}


class MySizedBox extends SizedBox {
  const MySizedBox({super.key, required super.child}) : super(width: 100);
}

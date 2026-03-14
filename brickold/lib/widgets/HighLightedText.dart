import 'package:flutter/material.dart';
import 'dart:math';

class DynamicTextHighlighting extends StatelessWidget {
  //DynamicTextHighlighting
  final String text;
  final List<String> highlights;
  final Color color;
  final TextStyle style;
  final bool caseSensitive;

  //RichText
  final TextAlign textAlign;
  final TextDirection textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int? maxLines;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const DynamicTextHighlighting({
    //DynamicTextHighlighting
    Key? key,
    required this.text,
    required this.highlights,
    this.color = Colors.yellow,
    this.style = const TextStyle(
      color: Colors.black,
    ),
    this.caseSensitive = true,

    //RichText
    this.textAlign = TextAlign.start,
    this.textDirection = TextDirection.ltr,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.textHeightBehavior,
  })  : assert(maxLines == null || maxLines > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controls
    if (text == '') {
      return _richText(_normalSpan(text));
    }
    if (highlights.isEmpty) {
      return _richText(_normalSpan(text));
    }
    for (int i = 0; i < highlights.length; i++) {
      if (highlights[i].isEmpty) {
        assert(highlights[i].isNotEmpty);
        return _richText(_normalSpan(text));
      }
    }

    //Main code
    List<TextSpan> spans = [];
    int start = 0;

    //For "No Case Sensitive" option
    String lowerCaseText = text.toLowerCase();
    List<String> lowerCaseHighlights = [];

    for (var element in highlights) {
      lowerCaseHighlights.add(element.toLowerCase());
    }

    while (true) {
      Map<int, String> highlightsMap = {}; //key (index), value (highlight).

      if (caseSensitive) {
        for (int i = 0; i < highlights.length; i++) {
          int index = text.indexOf(highlights[i], start);
          if (index >= 0) {
            highlightsMap.putIfAbsent(index, () => highlights[i]);
          }
        }
      } else {
        for (int i = 0; i < highlights.length; i++) {
          int index = lowerCaseText.indexOf(lowerCaseHighlights[i], start);
          if (index >= 0) {
            highlightsMap.putIfAbsent(index, () => highlights[i]);
          }
        }
      }

      if (highlightsMap.isNotEmpty) {
        List<int> indexes = [];
        highlightsMap.forEach((key, value) => indexes.add(key));

        int currentIndex = indexes.reduce(min);
        String currentHighlight = text.substring(currentIndex,
            currentIndex + highlightsMap[currentIndex]!.length);

        if (currentIndex == start) {
          spans.add(_highlightSpan(currentHighlight));
          start += currentHighlight.length;
        } else {
          spans.add(_normalSpan(text.substring(start, currentIndex)));
          spans.add(_highlightSpan(currentHighlight));
          start = currentIndex + currentHighlight.length;
        }
      } else {
        spans.add(_normalSpan(text.substring(start, text.length)));
        break;
      }
    }

    return _richText(TextSpan(children: spans));
  }

  TextSpan _highlightSpan(String value) {
    if (style.color == null) {
      return TextSpan(
        text: value,
        style: style.copyWith(
          color: Colors.black,
          backgroundColor: color,
        ),
      );
    } else {
      return TextSpan(
        text: value,
        style: style.copyWith(
          backgroundColor: color,
        ),
      );
    }
  }

  TextSpan _normalSpan(String value) {
    if (style.color == null) {
      return TextSpan(
        text: value,
        style: style.copyWith(
          color: Colors.black,
        ),
      );
    } else {
      return TextSpan(
        text: value,
        style: style,
      );
    }
  }

  RichText _richText(TextSpan text) {
    return RichText(
      key: key,
      text: text,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
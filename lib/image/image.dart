import 'dart:collection';

import 'package:advent/image/color.dart';
import 'package:advent/image/layer.dart';

class Image extends IterableBase<Pixel> {
  final int width, height;
  final List<Layer> layers;

  Image(this.width, this.height, this.layers);

  factory Image.fromString(int width, int height, String spec) {
    final layerSize = width * height;
    final layerCount = spec.length ~/ layerSize;

    final layers = List<Layer>(layerCount);
    for (var layerIndex = 0; layerIndex < layerCount; ++layerIndex) {
      final layerStart = layerIndex * layerSize;
      final slice = spec.substring(layerStart, layerStart + layerSize);
      layers[layerIndex] = Layer.fromString(width, height, slice);
    }

    return Image(width, height, layers);
  }

  Iterable<Pixel> _getPixels() sync* {
    for (var y = 0; y < height; ++y) {
      for (var x = 0; x < width; ++x) {
        yield Pixel.fromLayers(layers, x, y);
      }
    }
  }

  @override
  int get length => width * height;

  @override
  Iterator<Pixel> get iterator => _getPixels().iterator;

  @override
  String toString() {
    final buffer = StringBuffer();
    for (var y = 0; y < height; ++y) {
      for (var x = 0; x < width; ++x) {
        final pixel = Pixel.fromLayers(layers, x, y);
        buffer.write(pixel);
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}

class Pixel {
  final int x, y;
  final Color color;

  Pixel(this.x, this.y, this.color);

  factory Pixel.fromLayers(List<Layer> layers, int x, int y) {
    for (final layer in layers) {
      final color = layer.get(x, y);
      if (color != Color.transparent) {
        return Pixel(x, y, color);
      }
    }
    return Pixel(x, y, Color.transparent);
  }

  @override
  String toString() {
    switch (color) {
      case Color.black:
        return ' ';
      case Color.white:
        return 'w';
      default:
        throw StateError('There are transparent pixels');
    }
  }
}

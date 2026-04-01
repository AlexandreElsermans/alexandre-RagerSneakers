import 'package:flutter/material.dart';

class ImageBuilder {
  static ImageProvider getImageProvider(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return const AssetImage('assets/images/imgError.jpg');
    }
    
    // Si c'est une URL réseau
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return NetworkImage(imagePath);
    }
    
    // Si c'est un asset local
    if (imagePath.startsWith('assets/')) {
      return AssetImage(imagePath);
    }
    
    // Fallback
    return const AssetImage('assets/images/imgError.jpg');
  }
  
  static Widget buildCircleAvatar(String? imagePath, {double radius = 30}) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: getImageProvider(imagePath),
      child: imagePath == null || imagePath.isEmpty
          ? const Icon(Icons.image, size: 20)
          : null,
    );
  }
  
  static Widget buildImage(String? imagePath, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (imagePath == null || imagePath.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: Colors.grey[300],
        child: const Icon(Icons.image),
      );
    }
    
    // Si c'est une URL réseau
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: width,
            height: height,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image),
          );
        },
      );
    }
    
    // Si c'est un asset local
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.image),
        );
      },
    );
  }
}
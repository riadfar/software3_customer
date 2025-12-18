import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/service_item_model.dart';

class ServiceCard extends StatelessWidget {
  final ServiceItemModel service;

  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    final Color backgroundColor = service.isComingSoon ? const Color(0xFFF5F7FA) : Colors.white;
    final double opacity = service.isComingSoon ? 0.6 : 1.0;

    return GestureDetector(
      onTap: () {
        if (service.isComingSoon) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${service.title} is coming soon!"),
              duration: const Duration(seconds: 1),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          service.onTap();
        }
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.02,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(width * 0.06),
              border: service.isComingSoon ? Border.all(color: Colors.grey.withOpacity(0.2)) : null,
              boxShadow: service.isComingSoon
                  ? []
                  : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.05),
                  blurRadius: width * 0.04,
                  offset: Offset(0, height * 0.005),
                ),
              ],
            ),
            child: Opacity(
              opacity: opacity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon Bubble
                  Container(
                    padding: EdgeInsets.all(width * 0.035),
                    decoration: BoxDecoration(
                      color: service.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(service.icon, color: service.color, size: width * 0.075),
                  ),

                  // Text Content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04,
                          color: AppTheme.navy,
                        ),
                      ),
                      SizedBox(height: height * 0.008),
                      Text(
                        service.subtitle,
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: width * 0.03,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      service.isComingSoon ? Icons.lock_clock_outlined : Icons.arrow_forward_rounded,
                      color: Colors.grey[300],
                      size: width * 0.05,
                    ),
                  ),
                ],
              ),
            ),
          ),

         if (service.isComingSoon)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "SOON",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../models/furniture_request.dart';
import '../models/request.dart';
import '../models/request_type.dart';
import '../pages/home/tabs/requests/furniture_request_card.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
  });

  final Request request;

  @override
  Widget build(BuildContext context) {
    switch (request.type) {
      case RequestType.movingFurnitureIn:
      case RequestType.movingFurnitureOut:
        return FurnitureRequestCard(
          request: request as FurnitureRequest,
        );
    }
  }
}

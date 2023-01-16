import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../repositories/product_repository.dart';

part 'product_controller.g.dart';

class ProductController {
  final _productRepository = ProductRepository();

  @Route.get('/')
  Future<Response> find(Request request) async {
    try {
      final products = await _productRepository.findAll();

      return Response.ok(
        jsonEncode(products.map((p) => p.toMap()).toList()),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e, s) {
      log('Error finding produtos', error: e.toString(), stackTrace: s);
      return Response.internalServerError();
    }
  }

  Router get router => _$ProductControllerRouter(this);
}

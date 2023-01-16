import 'dart:async';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:vakinha_burger_api/app/core/exceptions/email_already_registered.dart';
import 'package:vakinha_burger_api/app/core/exceptions/user_notfound_exception.dart';
import 'package:vakinha_burger_api/app/entities/user.dart';
import 'package:vakinha_burger_api/app/repositories/user_repository.dart';

part 'auth_controller.g.dart';

class AuthController {
  final _userRepository = UserRepository();

  @Route.post('/')
  Future<Response> login(Request request) async {
    final jsonReq = jsonDecode(await request.readAsString());

    try {
      final user = await _userRepository.login(
        jsonReq['email'] as String,
        jsonReq['password'] as String,
      );

      return Response.ok(user.toJson(),
          headers: {'Content-Type': 'application/json'});
    } on UserNotfoundException catch (e, s) {
      print(e);
      print(s);

      return Response.forbidden(
        jsonEncode(
          {'error': 'User not found'},
        ),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e, s) {
      print(e);
      print(s);

      return Response.internalServerError(
        body: jsonEncode(
          {'error': 'Internal server error'},
        ),
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  @Route.post('/register')
  Future<Response> register(Request request) async {
    try {
      final userReq = User.fromJson(await request.readAsString());
      await _userRepository.save(userReq);

      return Response.ok(
        jsonEncode(''),
        headers: {'Content-Type': 'application/json'},
      );
    } on EmailAlreadyRegistered catch (e, s) {
      print(e);
      print(s);
      return Response.badRequest(
        body: jsonEncode(
          {'error': 'E-mail already registered'},
        ),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e, s) {
      print(e);
      print(s);
      return Response.internalServerError(
        body: jsonEncode(
          {'error': 'Internal server error'},
        ),
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  Router get router => _$AuthControllerRouter(this);
}

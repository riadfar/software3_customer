import 'package:dio/dio.dart';
import 'request_context.dart';
import 'request_handler.dart';
import 'handlers/token_injection_handler.dart';
import 'handlers/request_validation_handler.dart';
import 'handlers/header_construction_handler.dart';
import 'handlers/error_transformation_handler.dart';
import 'handlers/response_logging_handler.dart';
import '../dio_client.dart';

/// Orchestrator for the Chain of Responsibility pattern.
/// 
/// This class manages the handler chain and coordinates request processing.
/// It sets up the default chain of handlers and processes requests through them.
class RequestChain {
  RequestHandler? _firstHandler;
  final List<RequestHandler> _handlers = [];

  /// Creates a RequestChain with default handlers configured.
  /// 
  /// Default chain order:
  /// 1. TokenInjectionHandler - Injects auth token
  /// 2. RequestValidationHandler - Validates request structure
  /// 3. HeaderConstructionHandler - Constructs final headers
  /// 4. (Request sent to RemoteApi)
  /// 5. ErrorTransformationHandler - Transforms errors
  /// 6. ResponseLoggingHandler - Logs responses
  RequestChain() {
    _setupDefaultChain();
  }

  /// Sets up the default chain of handlers.
  void _setupDefaultChain() {
    final tokenHandler = TokenInjectionHandler();
    final validationHandler = RequestValidationHandler();
    final headerHandler = HeaderConstructionHandler();
    final errorHandler = ErrorTransformationHandler();
    final loggingHandler = ResponseLoggingHandler();

    // Build the chain
    tokenHandler
        .setNext(validationHandler)
        .setNext(headerHandler);

    _firstHandler = tokenHandler;
    _handlers.addAll([
      tokenHandler,
      validationHandler,
      headerHandler,
      errorHandler,
      loggingHandler,
    ]);
  }

  /// Adds a custom handler to the chain.
  /// 
  /// Handlers are added to the end of the chain (after default handlers).
  void addHandler(RequestHandler handler) {
    if (_firstHandler == null) {
      _firstHandler = handler;
      _handlers.add(handler);
      return;
    }

    // Find the last handler and add the new one
    var current = _firstHandler;
    while (current!.nextHandler != null) {
      current = current.nextHandler;
    }
    current.setNext(handler);
    _handlers.add(handler);
  }

  /// Processes a request through the handler chain.
  /// 
  /// This method:
  /// 1. Processes the request through request handlers (token, validation, headers)
  /// 2. Makes the actual HTTP call via RemoteApi
  /// 3. Processes the response through response handlers (error transformation, logging)
  /// 
  /// Returns the processed context with response or error.
  Future<RequestContext> processRequest(RequestContext context) async {
    try {
      // Phase 1: Request processing through chain
      RequestContext processedContext = context;
      if (_firstHandler != null) {
        processedContext = await _firstHandler!.handle(context);
      }

      // Check if validation failed
      if (processedContext.hasError) {
        // Process error through error handlers
        return await _processError(processedContext);
      }

      // Phase 2: Make HTTP request via RemoteApi
      Response? response;
      try {
        response = await _makeHttpRequest(processedContext);
        processedContext = processedContext.copyWith(response: response);
      } catch (e) {
        // Capture error for processing
        processedContext = processedContext.copyWith(error: e as Exception);
      }

      // Phase 3: Response processing through chain
      return await _processResponse(processedContext);
    } catch (e) {
      // Unexpected error, wrap and return
      return context.copyWith(error: e is Exception ? e : Exception(e.toString()));
    }
  }

  /// Makes the actual HTTP request using RemoteApi.
  Future<Response> _makeHttpRequest(RequestContext context) async {
    switch (context.method.toUpperCase()) {
      case 'GET':
        return await RemoteApi.get(
          context.url,
          headers: context.headers,
        );
      case 'POST':
        return await RemoteApi.post(
          context.url,
          body: context.body,
          headers: context.headers,
        );
      case 'PUT':
        return await RemoteApi.put(
          context.url,
          body: context.body,
          headers: context.headers,
        );
      case 'DELETE':
        return await RemoteApi.delete(
          context.url,
          headers: context.headers,
        );
      default:
        throw Exception('Unsupported HTTP method: ${context.method}');
    }
  }

  /// Processes errors through error transformation and logging handlers.
  Future<RequestContext> _processError(RequestContext context) async {
    final errorHandler = ErrorTransformationHandler();
    final loggingHandler = ResponseLoggingHandler();
    
    errorHandler.setNext(loggingHandler);
    return await errorHandler.handle(context);
  }

  /// Processes successful responses through logging handler.
  Future<RequestContext> _processResponse(RequestContext context) async {
    final loggingHandler = ResponseLoggingHandler();
    return await loggingHandler.handle(context);
  }
}


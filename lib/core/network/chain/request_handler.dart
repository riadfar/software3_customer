import 'request_context.dart';

/// Abstract base class for request handlers in the Chain of Responsibility pattern.
/// 
/// This class implements the Template Method pattern, providing the structure
/// for chain traversal while allowing subclasses to implement specific handling logic.
/// 
/// Each handler has a single responsibility and can either:
/// - Process the context and pass it to the next handler
/// - Stop the chain (by not calling passToNext)
abstract class RequestHandler {
  RequestHandler? nextHandler;

  /// Sets the next handler in the chain.
  /// Returns the handler that was set (for fluent chaining).
  RequestHandler setNext(RequestHandler handler) {
    nextHandler = handler;
    return handler;
  }

  /// Template method that defines the handler execution flow.
  /// 
  /// Subclasses should not override this method. Instead, they should
  /// implement [doHandle] to provide specific processing logic.
  Future<RequestContext> handle(RequestContext context) async {
    // Process the context with the specific handler logic
    final processedContext = await doHandle(context);

    // If there's an error and we should stop the chain, return early
    if (processedContext.hasError && shouldStopOnError()) {
      return processedContext;
    }

    // Pass to next handler if one exists
    if (nextHandler != null) {
      return await nextHandler!.handle(processedContext);
    }

    // End of chain, return processed context
    return processedContext;
  }

  /// Abstract method that subclasses must implement.
  /// 
  /// This method contains the specific processing logic for each handler.
  /// Handlers should modify the context as needed and return it.
  Future<RequestContext> doHandle(RequestContext context);

  /// Determines if the chain should stop when an error is encountered.
  /// 
  /// Override this method to change the default behavior.
  /// Default is false, meaning the chain continues even with errors.
  bool shouldStopOnError() => false;
}


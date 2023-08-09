import '../../managers/screen_manager.dart';
import '../../managers/screen_manager.dart';
import 'network.dart';

onResultErrorDefault(HttpResult error, {Function? onRetry}) {
  switch (error.type) {
    /* case HttpCodesEnum.e401_Unauthorized:
      return PageManager().goDoLogout(); */
    case HttpCodesEnum.s204_NoContent:
      return ScreenManager().openDefaultErrorAlert(
        'Ocurrió un error, por favor intente nuevamente más tarde',
        onRetry: onRetry,
      );
    case HttpCodesEnum.e500_InternalServerError:
      return ScreenManager().openDefaultErrorAlert(
        'Hubo un problema en el servidor, por favor intente nuevamente más tarde',
        onRetry: onRetry,
      );
    case HttpCodesEnum.NoInternetConnection:
      return ScreenManager().openDefaultErrorAlert(
        'No hay conexion a internet',
        onRetry: onRetry,
      );
    default:
      return ScreenManager().openDefaultErrorAlert(
        'Ocurrió un error, por favor intente nuevamente más tarde',
        onRetry: onRetry,
      );
  }
}

onErrorFunction({required HttpResult? error, onRetry}) {
  switch (error!.type) {
    /* case HttpCodesEnum.e401_Unauthorized:
      return PageManager().goDoLogout(); */
    case HttpCodesEnum.s204_NoContent:
      return ScreenManager().openDefaultErrorAlert(
        'Ocurrió un error, por favor intente nuevamente más tarde',
        onRetry: () => onRetry(),
      );
    case HttpCodesEnum.e500_InternalServerError:
      return ScreenManager().openDefaultErrorAlert(
        'Hubo un problema en el servidor, por favor intente nuevamente más tarde',
        onRetry: () => onRetry(),
      );
    case HttpCodesEnum.NoInternetConnection:
      return ScreenManager().openDefaultErrorAlert(
        'No hay conexion a internet',
        onRetry: () => onRetry(),
      );
    default:
      return ScreenManager().openDefaultErrorAlert(
        'Ocurrió un error, por favor intente nuevamente más tarde',
        onRetry: () => onRetry(),
      );
  }
}

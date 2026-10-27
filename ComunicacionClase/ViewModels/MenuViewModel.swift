import SwiftUI

@MainActor
@Observable
final class MenuViewModel {
    var ruta: [Ejemplo] = []
    
    /// Último enlace propio recibido, para mostrarlo en pantalla (útil al probar).
    private(set) var ultimoEnlace: String?

    // MARK: - Acciones

    /// Procesa una URL que abrió nuestra app. La vista lo llama desde `.onOpenURL`.
    func abrir(_ url: URL) {
        ultimoEnlace = url.absoluteString
        // Si la URL no es válida, `ejemplo(desde:)` da nil y simplemente no pasa nada.
        guard let ejemplo = EnlaceProfundoManager.shared.ejemplo(desde: url) else { return }
        // Se reemplaza la ruta completa: así el enlace siempre llega al mismo lugar,
        // sin importar qué pantalla estuviera abierta antes.
        ruta = [ejemplo]
    }
}

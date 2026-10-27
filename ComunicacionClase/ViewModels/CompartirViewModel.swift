import SwiftUI

/// Estado de la pantalla "Compartir con ShareLink".
/// Capa MVVM: **ViewModel**. Guarda el texto del usuario, la página que se comparte
/// y el archivo generado a partir del texto.
@MainActor
@Observable
final class CompartirViewModel {
    // MARK: - Estado

    /// Texto editable. La vista lo conecta al TextEditor con `@Bindable`,
    /// por eso NO es `private(set)`.
    var texto = "Estoy aprendiendo a comunicar mi app con el resto de iOS."

    /// Página que se comparte como enlace. El `!` es seguro porque el texto lo escribimos nosotros y es válido.
    let enlace = URL(string: "https://developer.apple.com/xcode/swiftui/")!

    /// Archivo .txt generado; nil mientras no se haya creado.
    private(set) var archivo: URL?

    /// Mensaje de error si no se pudo crear el archivo.
    private(set) var error: String?

    // MARK: - Acciones
    
    /// Escribe el texto actual en un archivo y guarda su URL.
    /// Si falla, guarda el motivo en `error` en lugar de cerrar la app.
    func prepararArchivo() {
        do {
            archivo = try ArchivoTemporalManager.shared.crearTexto(texto)
            error = nil
        } catch {
            archivo = nil
            self.error = "No se pudo crear el archivo: \(error.localizedDescription)"
        }
    }
}

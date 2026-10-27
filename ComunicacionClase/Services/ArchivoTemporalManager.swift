import Foundation

/// Crea un archivo de texto temporal para compartirlo.
/// Capa MVVM: **Service** (un "Manager"). Solo escribe el archivo y devuelve su ubicación.
struct ArchivoTemporalManager {
    
    // MARK: - Instancia compartida
    static let shared = ArchivoTemporalManager()
    
    // MARK: - Acciones

    /// Guarda `texto` en un archivo `.txt` dentro de la carpeta temporal y devuelve su URL.
    /// `throws` avisa que la función puede fallar (por ejemplo, sin espacio en disco):
    /// quien la llame debe usar `try` dentro de un `do { } catch { }`.
    func crearTexto(_ texto: String, nombre: String = "nota") throws -> URL {
        
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(nombre)
            .appendingPathExtension("txt")
        
        try texto.write(to: url, atomically: true, encoding: .utf8)
        return url
    }
    
}

// UIKit nos da UIApplication, de donde sale la dirección de los Ajustes de la app.
import UIKit

/// Arma las URLs que abren otras apps y servicios del sistema.
/// Capa MVVM: **Service** (un "Manager"). Solo construye direcciones; no las abre.
/// Abrirlas es trabajo de la vista, con `openURL`.
///
/// Cada app se reconoce por el **esquema** de la URL (lo que va antes de los dos puntos):
/// `https` abre Safari, `mailto` Correo, `tel` Teléfono...
struct EnlaceManager {
    // MARK: - Instancia compartida
    
    /// `static let shared`: una sola instancia compartida por toda la app (singleton).
    static let shared = EnlaceManager()
    
    /// `private init()` impide crear otra instancia desde fuera.
    private init() {}
    
    // MARK: - Acciones
    
    /// Devuelve los enlaces del ejemplo, en el orden en que se muestran.
    func obtener() -> [EnlaceExterno] {
        // Cada llamada a `enlace(...)` devuelve un opcional (una URL mal armada sería nil).
        // `compactMap { $0 }` descarta los nil y deja solo los enlaces válidos.
        [
            enlace("Abrir una página web", "safari", URL(string: "https://www.apple.com/mx/")),
            enlace("Buscar en Mapas", "map", mapas(buscar: "Zócalo, Ciudad de México")),
            enlace("Escribir un correo", "envelope", correo(para: "alumno@ejemplo.com")),
            enlace("Llamar por teléfono", "phone", URL(string: "tel:5555555555")),
            enlace("Mandar un mensaje", "message", URL(string: "sms:5555555555")),
            // Esta constante de Apple es el texto "app-settings:", que abre los Ajustes de nuestra app.
            enlace("Ajustes de esta app", "gearshape", URL(string: UIApplication.openSettingsURLString))
        ]
        .compactMap { $0 }
    }
    
    // MARK: - Ayudantes
    
    /// Junta título, ícono y URL en un `EnlaceExterno`. Si la URL es nil, devuelve nil
    /// (`url.map` solo ejecuta su cierre cuando hay valor).
    private func enlace(_ titulo: String, _ icono: String, _ url: URL?) -> EnlaceExterno? {
        url.map { EnlaceExterno(titulo: titulo, icono: icono, url: $0) }
    }
    
    /// Búsqueda en la app Mapas de Apple.
    /// `URLComponents` arma la URL por partes y convierte espacios, comas y acentos a un formato
    /// válido ("codificar"). Escribirlo a mano con un espacio rompe la URL.
    private func mapas(buscar texto: String) -> URL? {
        var componentes = URLComponents()
        componentes.scheme = "https"
        componentes.host = "maps.apple.com"
        componentes.queryItems = [URLQueryItem(name: "q", value: texto)]
        return componentes.url
    }
    
    /// Correo nuevo con destinatario, asunto y mensaje ya escritos.
    /// Con el esquema `mailto`, la dirección va en `path` y el resto como parámetros.
    private func correo(para direccion: String) -> URL? {
        var componentes = URLComponents()
        componentes.scheme = "mailto"
        componentes.path = direccion
        componentes.queryItems = [
            URLQueryItem(name: "subject", value: "Hola desde mi app"),
            URLQueryItem(name: "body", value: "Este correo se preparó desde la clase de iOS.")
        ]
        return componentes.url
    }
    
    

}

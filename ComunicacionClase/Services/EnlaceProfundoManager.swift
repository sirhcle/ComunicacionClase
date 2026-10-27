import Foundation

/// Crea y entiende los enlaces propios de la app, como `comunicacion://ejemplo/compartir`.
/// Capa MVVM: **Service** (un "Manager"). Convierte entre `Ejemplo` y URL; no navega
/// (navegar es trabajo de `MenuViewModel`).
///
/// Estructura de nuestros enlaces:
/// - esquema: `comunicacion` (registrado en el target → Info → URL Types)
/// - host:    `ejemplo`
/// - ruta:    el `rawValue` del ejemplo (`/compartir`)
struct EnlaceProfundoManager {
    // MARK: - Instancia compartida

    static let shared = EnlaceProfundoManager()
    private init() {}

    private let esquema = "comunicacion"
    private let host = "ejemplo"

    // MARK: - Acciones

    /// Construye el enlace que lleva a un ejemplo.
    func url(para ejemplo: Ejemplo) -> URL? {
        var componentes = URLComponents()
        componentes.scheme = esquema
        componentes.host = host
        componentes.path = "/" + ejemplo.rawValue
        return componentes.url
    }

    /// Interpreta una URL que llegó a la app. Devuelve el ejemplo al que apunta, o nil si no es válida.
    /// Siempre hay que validar: cualquier app (o persona) puede mandarte una URL inventada.
    func ejemplo(desde url: URL) -> Ejemplo? {
        // Debe ser nuestro esquema y nuestro host; si no, se ignora.
        guard url.scheme == esquema, url.host() == host else { return nil }
        // `lastPathComponent` es lo último de la ruta: "/compartir" → "compartir".
        // `Ejemplo(rawValue:)` devuelve nil si ese texto no corresponde a ningún caso.
        return Ejemplo(rawValue: url.lastPathComponent)
    }

    /// Comando para probar un enlace en el simulador desde la Terminal.
    func comandoSimulador(para ejemplo: Ejemplo) -> String {
        "xcrun simctl openurl booted \"\(url(para: ejemplo)?.absoluteString ?? "")\""
    }
}

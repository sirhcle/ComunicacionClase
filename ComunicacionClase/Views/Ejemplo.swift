// MARK: - Seccion

/// Agrupa los ejemplos del menú por día de clase.
/// - `enum` es una lista cerrada de opciones.
/// - `: String` le da a cada caso un texto (`rawValue`): aquí, el encabezado que ve el usuario.
/// - `CaseIterable` regala `Seccion.allCases` para recorrer los casos con `ForEach`.
/// - `Identifiable` pide un `id` único; `ForEach` lo usa para distinguir elementos.
enum Seccion: String, CaseIterable, Identifiable {
    case dia7 = "Comunicar Apps · Comunicar con otras apps"

    /// Propiedad calculada: no guarda nada, calcula su valor cada vez que se lee.
    var id: String { rawValue }

    /// Los ejemplos de esta sección. `filter` se queda con los que cumplen la condición;
    /// `$0` es el elemento que se está revisando y `self` la sección actual.
    var ejemplos: [Ejemplo] {
        Ejemplo.allCases.filter { $0.seccion == self }
    }
}

// MARK: - Ejemplo

/// Un caso por cada pantalla de ejemplo del proyecto.
/// Para agregar uno nuevo: un caso aquí y una línea en `MenuView.destino(para:)`.
/// - El `rawValue` es el nombre del caso ("compartir"...) y se reutiliza en los enlaces propios.
/// - `Hashable` permite usar un `Ejemplo` como valor de navegación.
enum Ejemplo: String, CaseIterable, Identifiable, Hashable {
    // MARK: Casos

    // Comunicacion
    case abrirApps
    case compartir
    case enlacesPropios
    case portapapeles

    // MARK: Datos para el menú

    var id: String { rawValue }

    /// Texto de la fila. En un `switch`, si cada rama es una sola expresión, no hace falta `return`.
    var titulo: String {
        switch self {
        case .abrirApps: "Abrir otras apps"
        case .compartir: "Compartir con ShareLink"
        case .enlacesPropios: "Enlaces propios (deep links)"
        case .portapapeles: "Portapapeles (extra)"
        }
    }

    /// Nombre del SF Symbol de la fila.
    var icono: String {
        switch self {
        case .abrirApps: "arrow.up.forward.app"
        case .compartir: "square.and.arrow.up"
        case .enlacesPropios: "link"
        case .portapapeles: "doc.on.clipboard"
        }
    }

    /// Día al que pertenece. Varios casos pueden compartir rama separados por comas.
    var seccion: Seccion {
        switch self {
        case .abrirApps, .compartir, .enlacesPropios, .portapapeles: .dia7
        }
    }
}

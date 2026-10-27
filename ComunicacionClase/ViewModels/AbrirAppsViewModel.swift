import SwiftUI

/// Estado de la pantalla "Abrir otras apps".
/// Capa MVVM: **ViewModel**. Pide la lista a `EnlaceManager` y guarda el aviso que se muestra
/// después de cada intento. La vista abre la URL (con `openURL`) y le cuenta aquí si se pudo.
@MainActor
@Observable
final class AbrirAppsViewModel {
    // MARK: - Estado

    // `private(set)`: la vista puede leerlas, pero solo este ViewModel las cambia.

    /// Los enlaces que se muestran en la lista.
    private(set) var enlaces: [EnlaceExterno] = []

    /// Texto para el usuario después de intentar abrir un enlace. Vacío = todavía no se intentó nada.
    private(set) var mensaje = ""

    // MARK: - Acciones
    
    /// Llena la lista. La vista lo llama en `.task`, al aparecer.
    func cargar() {
        enlaces = EnlaceManager.shared.obtener()
    }
    
    /// Guarda el resultado de un intento. `aceptado` es lo que contesta `openURL`:
    /// true si el sistema encontró algo que lo abriera.
    func registrar(_ enlace: EnlaceExterno, aceptado: Bool) {
        if aceptado {
            mensaje = "Se abrió: \(enlace.titulo)"
        } else {
            mensaje = "No se pudo abrir: \(enlace.titulo). Es normal en el simulador si esta app no existe"
        }
    }
}

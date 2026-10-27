import SwiftUI

/// Pantalla del ejemplo "Enlaces propios".
/// Capa MVVM: **View**. Cada botón abre un enlace `comunicacion://...` de esta misma app.
/// El sistema lo recibe y lo devuelve a `MenuView` por `.onOpenURL`, igual que si viniera de otra app.
/// Sirve para probar los deep links sin salir del simulador.
struct EnlacesPropiosView: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        List {
            Section("Toca para abrir un enlace de esta app") {
                // Recorremos solo los ejemplos que no son esta misma pantalla.
                ForEach(Ejemplo.allCases.filter { $0 != .enlacesPropios }) { ejemplo in
                    if let url = EnlaceProfundoManager.shared.url(para: ejemplo) {
                        Button {
                            openURL(url)
                        } label: {
                            VStack(alignment: .leading) {
                                Label(ejemplo.titulo, systemImage: ejemplo.icono)
                                // La URL en letra pequeña para que los alumnos vean cómo se forma.
                                Text(url.absoluteString)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }

            Section("Probar desde la Terminal (simulador)") {
                Text(EnlaceProfundoManager.shared.comandoSimulador(para: .compartir))
                    .font(.system(.footnote, design: .monospaced))
                    .textSelection(.enabled)
            }
        }
        .navigationTitle("Enlaces propios")
    }
}

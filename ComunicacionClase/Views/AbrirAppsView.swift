import SwiftUI

/// Pantalla del ejemplo "Abrir otras apps".
/// Capa MVVM: **View**. Dibuja la lista y, al tocar un enlace, le pide al sistema que lo abra.
struct AbrirAppsView: View {
    // MARK: - Estado

    /// @State: la vista es dueña del ViewModel y lo conserva entre redibujados.
    @State private var viewModel = AbrirAppsViewModel()

    /// @Environment lee valores que SwiftUI comparte con todas las vistas.
    /// `\.openURL` es una acción del sistema que abre una URL en la app que corresponda.
    @Environment(\.openURL) private var openURL

    // MARK: - Cuerpo
    
    var body: some View {
        // List con una colección crea una fila por enlace (EnlaceExterno es Identifiable).
        List(viewModel.enlaces) { enlace in
            Button {
                openURL(enlace.url) { aceptado in
                    viewModel.registrar(enlace, aceptado: aceptado)
                }
            } label: {
                Label(enlace.titulo, systemImage: enlace.icono)
            }
        }
        // Pega una vista abajo sin tapar la lista: aquí, el resultado del último intento.
        .safeAreaInset(edge: .bottom) {
            if !viewModel.mensaje.isEmpty {
                Text(viewModel.mensaje)
                    .font(.footnote)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.bar)
            }
        }
        .navigationTitle("Abrir otras apps")
        .task {
            viewModel.cargar()
        }
    }
    
    
}

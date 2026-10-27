import SwiftUI

/// Pantalla del ejemplo "Compartir con ShareLink".
/// Capa MVVM: **View**. `ShareLink` es un botón que abre la hoja de compartir de iOS
/// (Mensajes, AirDrop, Notas, Correo...).
struct CompartirView: View {
    // MARK: - Estado

    @State private var viewModel = CompartirViewModel()

    // MARK: - Cuerpo

    var body: some View {
        // @Bindable crea los bindings ($) hacia el ViewModel @Observable.
        @Bindable var viewModel = viewModel

        Form {
            Section("Texto a compartir") {
                TextEditor(text: $viewModel.texto)
                    .frame(minHeight: 100)
            }

            Section("Opciones") {
                // 1) Compartir un texto. `subject` es el asunto (lo usa Correo) y `message` el mensaje que acompaña.
                ShareLink(
                    item: viewModel.texto,
                    subject: Text("Desde mi app"),
                    message: Text("Mira lo que escribí:")
                ) {
                    Label("Compartir el texto", systemImage: "text.bubble")
                }

                // 2) Compartir una URL. `SharePreview` define el título y el ícono de la tarjeta de la hoja.
                ShareLink(
                    item: viewModel.enlace,
                    preview: SharePreview("Documentación de SwiftUI", image: Image(systemName: "swiftdata"))
                ) {
                    Label("Compartir una página web", systemImage: "link")
                }

                // 3) Compartir un archivo. Solo aparece cuando ya existe.
                if let archivo = viewModel.archivo {
                    ShareLink(item: archivo) {
                        Label("Compartir el archivo .txt", systemImage: "doc.text")
                    }
                }
            }

            Section {
                // Crea el archivo a partir del texto actual. Al terminar aparece la opción 3.
                Button("Crear archivo con el texto") {
                    viewModel.prepararArchivo()
                }
                if let error = viewModel.error {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("Compartir")
    }
}

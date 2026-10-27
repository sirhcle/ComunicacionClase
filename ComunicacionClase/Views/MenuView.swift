import SwiftUI

struct MenuView: View {
    
    @State private var viewModel = MenuViewModel()
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack(path: $viewModel.ruta) {
            List {
                ForEach(Seccion.allCases) { seccion in
                    Section(seccion.rawValue) {
                        ForEach(seccion.ejemplos) { ejemplo in
                            NavigationLink(value: ejemplo) {
                                Label(ejemplo.titulo, systemImage: ejemplo.icono)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Comunicar con otras apps")
            .navigationDestination(for: Ejemplo.self) { ejemplo in
                destino(para: ejemplo)
            }
        }
    }
    
    @ViewBuilder
    func destino(para ejemplo: Ejemplo) -> some View {
        switch ejemplo {
            
        case .abrirApps: Text("Abrir otras apps (proximamente)")
        case .compartir: Text("Compartir (proximamente)")
        case .enlacesPropios: Text("Enlaces propios (proximamente)")
        case .portapapeles: Text("Portapapeles (proximamente)")
        }
    }
    
}

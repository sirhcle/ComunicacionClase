import Foundation

struct EnlaceExterno: Identifiable {
    
    let titulo: String
    
    let icono: String
    
    let url: URL
    
    var id: URL { url }
    
    
}

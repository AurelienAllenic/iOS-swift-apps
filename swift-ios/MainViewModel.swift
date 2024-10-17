import Foundation

class MainViewModel: ObservableObject {
    
    @Published var isValid: Bool = false
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage: String?

    func checkConnection(login: String, password: String) {
        if let realPassword = DataController.registeredUsers[login] {
            if realPassword == password {
                isValid = true
            } else {
                isValid = false
            }
        } else {
            isValid = false
        }
    }
}

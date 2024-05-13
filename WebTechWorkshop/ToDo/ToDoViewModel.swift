import Foundation
import Combine

protocol ToDoViewModelProtocol: ObservableObject {
    var toDos: [ToDoModel] { get set }
    
    func addToDo(description: String)
    func removeToDo(index: Int)
    
    func loadToDosFromDB()
    func persistToDoInDB()
}

class ToDoViewModel: ToDoViewModelProtocol {
    @Published var toDos: [ToDoModel] = []
    
    init() {
        loadToDosFromDB()
    }
    
    func addToDo(description: String) {
        let newToDo = ToDoModel(id: UUID(), description: description, createAt: Date())
        toDos.insert(newToDo, at: 0)
        
        persistToDoInDB()
    }
    
    func removeToDo(index: Int) {
        guard index < toDos.count && index >= 0 else {
            return
        }
        
        toDos.remove(at: index)
        
        persistToDoInDB()
    }
    
    func loadToDosFromDB() {
        let decoder = JSONDecoder()
        
        if let toDosData = UserDefaults.standard.data(forKey: "toDos") {
            if let decodedToDos = try? decoder.decode([ToDoModel].self, from: toDosData) {
                toDos = decodedToDos
            }
        }
    }
    
    func persistToDoInDB() {
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(toDos) {
            UserDefaults.standard.set(encoded, forKey: "toDos")
        }
    }
}

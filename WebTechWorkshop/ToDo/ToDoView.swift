import SwiftUI
import Combine
import MapKit

struct ToDoView: View {
    @StateObject var toDoViewModel = ToDoViewModel()
    @State var newToDo = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Lista de Tarefas")
                .font(.title)
                .fontWeight(.bold)
                .padding([.top, .leading, .trailing], 20)
            
            TextField("Adicionar nova tarefa", text: $newToDo)
                .padding()
                .onSubmit {
                    toDoViewModel.addToDo(description: newToDo)
                    newToDo = ""
                }
            
            List {
                ForEach(toDoViewModel.toDos) { todo in
                    VStack(alignment: .leading) {
                        Text(todo.createAt.formatted())
                        Text(todo.description)
                        
                        Map(interactionModes: []) {
                            Marker("Marker", coordinate: CLLocationCoordinate2D(latitude: 40.76715601376993, longitude: -73.97139196845002))
                        }
                        .mapStyle(.hybrid(elevation: .realistic))
                        .frame(height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            if let index = toDoViewModel.toDos.firstIndex(where: { $0.id == todo.id }) {
                                toDoViewModel.removeToDo(index: index)
                            }
                        }
                        label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(.red)
                    }
                }
                .padding()
                .scrollContentBackground(.hidden)
                .background(Color.green.opacity(0.5))
            }
            .padding(.top)
        }
    }
}

#Preview {
    ToDoView()
}

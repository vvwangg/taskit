//
//  ListView.swift
//  ToDoList
//
//  Created by Borborick Zhu on 8/7/21.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State var items: [ItemModel] = [
        ItemModel(title: "This is the first title!", isCompleted: false, dateCompleted: "04/03/2021", date: Date()),
        ItemModel(title: "This is the second title", isCompleted: false, dateCompleted: "04/03/2021",date: Date()),
        ItemModel(title: "Third!", isCompleted: false, dateCompleted: "04/03/2021",date: Date())
    ]
    
    var body: some View {
        ZStack {
            if listViewModel.items.isEmpty {
                NoItemsView()
                    .transition(AnyTransition.opacity.animation(.easeIn))
            } else {
                List {
                    // Section 1: Recurring Features
                    ForEach(listViewModel.items) { item in
                        ListRowView(item: item)
                            .onTapGesture {
                                    listViewModel.updateItem(item: item)

                            }
                    }
                    .onDelete(perform: listViewModel.deleteItem)
                    .onMove(perform: listViewModel.moveItem)
                }
                .listStyle(PlainListStyle())
            }
        }
        .navigationTitle("📝 TO DO")
        
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink ("Add", destination:
                                    AddView())
        )
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
        }
        .preferredColorScheme(.dark)
        .environmentObject(ListViewModel())
    }
}


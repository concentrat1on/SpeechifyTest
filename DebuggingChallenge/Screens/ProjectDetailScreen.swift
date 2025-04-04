import SwiftUI

struct ProjectDetailScreen: View {
    let project: Project
    @EnvironmentObject var coordinator: MainCoordinator

    var body: some View {
        List {
            Section("Items") {
                ForEach(project.items) { item in
                    Button {
                        coordinator.navigateToWorkItem(item)
                    } label: {
                        WorkItemRowView(item: item)
                    }
                }
            }
        }
        .navigationTitle(project.name)
    }
}

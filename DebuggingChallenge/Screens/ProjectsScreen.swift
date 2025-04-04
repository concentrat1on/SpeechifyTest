import SwiftUI

#Preview {
    ProjectsScreen(viewModel: ProjectsViewModel(projectService: MockProjectService())
    )
    .environmentObject(MainCoordinator())
}

struct ProjectsScreen: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @ObservedObject var viewModel: ProjectsViewModel

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            if viewModel.projects.isEmpty {
                Loader(progress: $viewModel.loaderProgress, animated: true)
                    .frame(width: 64, height: 64)
            } else {
                List {
                    Section {
                        ForEach(viewModel.filteredProjects) { project in
                            Button {
                                coordinator.navigateToProject(project)
                            } label: {
                                ProjectRowView(project: project)
                            }
                        }
                    }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search Projects...")
                .navigationTitle("Projects")
                .navigationDestination(for: Project.self) { project in
                    ProjectDetailScreen(project: project)
                }
                .navigationDestination(for: WorkItem.self) { item in
                    WorkItemDetailView(item: item)
                }
            }
                
        }
        .onAppear { viewModel.loadProjects() }
    }


}

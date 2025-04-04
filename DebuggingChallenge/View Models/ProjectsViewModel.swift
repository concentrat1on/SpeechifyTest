import Combine

class ProjectsViewModel: ObservableObject {
    @Published var projects: [Project] = []
    @Published var searchText: String = ""
    @Published var loaderProgress: Float = 0
    let projectService: ProjectService
    
    var filteredProjects: [Project] {
        searchText.isEmpty ? projects : projects.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    private var task: Task<Void, Never>?

    init(projectService: ProjectService) {
        print(#function)
        self.projectService = projectService
    }

    @MainActor
    func loadProjects() {
        guard projects.isEmpty,
              task == nil else { return }
        
        task = Task {
            let fetchedProjects = await projectService.fetchProjects()
            projects = fetchedProjects
        }
    }
}

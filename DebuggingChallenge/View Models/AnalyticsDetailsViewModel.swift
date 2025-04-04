import Combine

class AnalyticsDetailsViewModel: ObservableObject {
    @Published var recentProjects: [Project] = []
    let projectService: ProjectService
    
    private var task: Task<Void, Never>?

    init(projectService: ProjectService) {
        print(#function)
        self.projectService = projectService
    }

    @MainActor
    func loadRecentProjects() {
        guard recentProjects.isEmpty,
              task == nil else { return }
        
        task = Task {
            let projects = await projectService.fetchProjects()
            recentProjects = projects
        }
    }
}

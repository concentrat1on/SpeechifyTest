import Combine

class AnalyticsViewModel: ObservableObject {
    @Published var analyticsDetails: [AnalyticsDetails] = []
    @Published var recentProjects: [Project] = []
    let analyticsService: AnalyticsService
    let projectService: ProjectService
    
    private var task: Task<Void, Never>?

    init(analyticsService: AnalyticsService, projectService: ProjectService) {
        print(#function)
        self.analyticsService = analyticsService
        self.projectService = projectService
    }

    @MainActor
    func loadAnalytics() {
        guard analyticsDetails.isEmpty,
              task == nil else { return }
        
        Task {
            let details = await analyticsService.fetchAnalyticsDetails()
            let projects = await projectService.fetchProjects()
            analyticsDetails = details
            recentProjects = projects
        }
    }
}

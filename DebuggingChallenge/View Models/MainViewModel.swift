//
//  MainViewModel.swift
//  DebuggingChallenge
//
//  Created by Illia Topor on 2025-04-04.
//

import Foundation

class MainViewModel: ObservableObject {
    let projectsViewModel: ProjectsViewModel
    let analyticsViewModel: AnalyticsViewModel
    
    init() {
        projectsViewModel = ProjectsViewModel(projectService: MockProjectService())
        analyticsViewModel = AnalyticsViewModel(analyticsService: MockAnalyticsService(), projectService: MockProjectService())
    }
}

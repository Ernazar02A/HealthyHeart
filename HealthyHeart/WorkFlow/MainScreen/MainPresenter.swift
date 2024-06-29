//
//
//  MainPresenter.swift
//  HealthyHeart
//
//  Created by Akai on 27/6/24.
//
//

import Foundation

protocol IMainDelegate: AnyObject {
    
}

protocol IMainPresenter {
    var page: Int { get set }
    var hasNext: Bool { get set }
    var isLoading: Bool { get }
    var advice: [AdviceModel] { get set }
    func setDelegate(_ delegate: IMainDelegate)
    func getCountItem(section: MonitoringDetails) -> Int
    func loadMoreItems()
    func viewDidLoad()
    func pushToProfile()
    func pushToNotifications()
}

class MainPresenter: IMainPresenter {
    
    let navigator: IMainNavigator
    
    weak var delegate: IMainDelegate?
    
    private (set) var isLoading = false
    
    var page: Int = 1
    
    var hasNext: Bool = false
    
    let locker = Locker()
    
    var advice: [AdviceModel] = [
        AdviceModel(
            photo: "photo",
            date: "25 апреля 2024",
            description: "Как работает сердце: основы анатомии и физиологии"
        ),
        AdviceModel(
            photo: "photo",
            date: "25 апреля 2024",
            description: "Как работает сердце: основы анатомии и физиологии"
        ),
        AdviceModel(
            photo: "photo",
            date: "25 апреля 2024",
            description: "Как работает сердце: основы анатомии и физиологии"
        ),
        AdviceModel(
            photo: "photo",
            date: "25 апреля 2024",
            description: "Как работает сердце: основы анатомии и физиологии"
        )
    ]
    
    init(navigator: IMainNavigator) {
        self.navigator = navigator
    }
    
    func setDelegate(_ delegate: IMainDelegate) {
        self.delegate = delegate
    }
    
    func getCountItem(section: MonitoringDetails) -> Int {
        switch section {
        case .survey:
            1
        case .advices:
            advice.count
        case .articles:
            advice.count
        }
    }
    
    func viewDidLoad() {
        page = 1
        hasNext = true
        //getAdvices()
        //getArticles()
    }
    
    func loadMoreItems() {
        //loadMoreAdvices()
        //loadMoreArticles()
    }
    
    func pushToProfile() {
        navigator.pushToProfile()
    }
    
    func pushToNotifications() {
        navigator.pushToNotifications()
    }
}

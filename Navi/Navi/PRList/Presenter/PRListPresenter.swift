//
//  PRListPresenter.swift
//  Navi
//
//  Created by Jushrita on 05/09/20.
//  Copyright © 2020 Jushrita. All rights reserved.
//

import Foundation

protocol PRListView: class {
    func renderView(state: PRListViewState)
    func getCurrentState() -> PRListViewState
}

struct PRData {
    var imageName: String
    var title: String
    var userName: String
    var firstDate: String
    var secondDate: String
}

struct PRListViewState {
    var prListData: [PRData]?
}

class PRListPresenter {
    weak var view: PRListView?
    let pageSize = 10
    var currentPageNumber = 1
    
    init(view: PRListView) {
        self.view = view
    }
    
    func getPRs(forPageNumber: Int?) {
        DispatchQueue.global().async { [weak self] in
            self?.getClosedPRs(forPageNumber: forPageNumber ?? 1)
        }
    }
    
    func getClosedPRs(forPageNumber: Int) {
        let newtworkService = PRListNetworkService(requestParams: getClosedPRRequest(pageNumber: forPageNumber))
        newtworkService.getPRList { [weak self] (response) in
            if let error = response.error {
                //TODO:- Error Handling
            } else {
                if let prDataList = response.response {
                    self?.process(prDataList: prDataList)
                }
            }
        }
    }
    
    func process(prDataList: [PRResponseModel]) {
        var prList = [PRData]()
        for pr in prDataList {
            prList.append(getPRData(data: pr))
        }
        if var currentState = view?.getCurrentState() {
            currentState.prListData = prList
            DispatchQueue.main.async { [weak self] in
                self?.view?.renderView(state: currentState)
            }
        }
    }
    
    func getPRData(data: PRResponseModel) -> PRData {
        let prData = PRData(imageName: "", title: data.title ?? "", userName: data.user?.login ?? "", firstDate: "Created at: \(DateUtility.utcToLocal(dateStr: data.created_at ?? "") ?? "")", secondDate: "Closed at: \(DateUtility.utcToLocal(dateStr: data.closed_at ?? "") ?? "")")
        return prData
    }
    
    func getClosedPRRequest(pageNumber: Int) -> PRRequestModel {
        let request = PRRequestModel(state: PRState.closed, pageNumber: pageNumber, pageSize: pageSize)
        return request
    }
    
    func reachedScreenEnd(indexPathRow: Int) {
        if indexPathRow == currentPageNumber * pageSize - 3 {
            currentPageNumber = currentPageNumber + 1
            getPRs(forPageNumber: currentPageNumber)
        }
    }
}

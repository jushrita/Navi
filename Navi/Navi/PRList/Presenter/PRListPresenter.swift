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
    var id: Int
    var title: String
    var userName: String
    var firstDate: String
    var secondDate: String
    var imageURL: String
}

struct PRListViewState {
    var prListData: [PRData] = [PRData]()
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
            if response.error != nil {
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
            let prData = getPRData(data: pr)
            prList.append(prData)
        }
        if var currentState = view?.getCurrentState() {
            currentState.prListData.append(contentsOf: prList)
            DispatchQueue.main.async { [weak self] in
                self?.view?.renderView(state: currentState)
            }
        }
    }
    
    func getPRData(data: PRResponseModel) -> PRData {
        let prData = PRData(id: data.id ?? -1, title: data.title ?? "", userName: data.user?.login ?? "", firstDate: "Created at: \(DateUtility.utcToLocal(dateStr: data.createdAt ?? "") ?? "")", secondDate: "Closed at: \(DateUtility.utcToLocal(dateStr: data.closedAt ?? "") ?? "")", imageURL: data.user?.avatarUrl ?? "")
        return prData
    }
    
    func getClosedPRRequest(pageNumber: Int) -> PRRequestModel {
        let request = PRRequestModel(state: PRState.closed, pageNumber: pageNumber, pageSize: pageSize)
        return request
    }
    
    func checkReachedScreenEnd(indexPathRow: Int) {
        if indexPathRow == currentPageNumber * pageSize - 1 {
            currentPageNumber = currentPageNumber + 1
            getPRs(forPageNumber: currentPageNumber)
        }
    }
    
//    func getAvatarImage(id: Int, url: String) {
//        AvatarNetworkService(url: url).getAvatr { [weak self](response) in
//            guard var currentState = self?.view?.getCurrentState() else {
//                return
//            }
//            var prDataList = currentState.prListData
//            let index = prDataList.firstIndex(where: { $0.id == id })
//            var newData = prDataList[index ?? 0]
//            newData.imageData = response.response
//            prDataList[index ?? 0] = newData
//            currentState.prListData = prDataList
//            DispatchQueue.main.async { [weak self] in
//                self?.view?.renderView(state: currentState)
//            }
//        }
//    }
}

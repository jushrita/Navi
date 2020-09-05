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
    
    init(view: PRListView) {
        self.view = view
    }
    
    func getPRs() {
        DispatchQueue.global().async { [weak self] in
            self?.getClosedPRs()
        }
    }
    
    func getClosedPRs() {
        let newtworkService = PRListNetworkService(requestParams: getClosedPRRequest())
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
        let prData = PRData(imageName: "", title: data.title ?? "", userName: data.user?.login ?? "", firstDate: utcToLocal(dateStr: data.created_at ?? "") ?? "", secondDate: utcToLocal(dateStr: data.closed_at ?? "") ?? "")
        return prData
    }
    
    func getClosedPRRequest() -> PRRequestModel {
        let request = PRRequestModel(state: PRState.closed)
        return request
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = utcDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = creationDateFormat
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

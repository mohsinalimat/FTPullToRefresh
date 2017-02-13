//
//  FTPullToRefreshView.swift
//  FTPullToRefreshDemo
//
//  Created by liufengting https://github.com/liufengting on 16/8/11.
//  Copyright © 2016年 liufengting. All rights reserved.
//

import UIKit

enum FTPullingState {
    case none
    case pulling
    case triggered
    case refreshing
    case success
    case failed
}

class FTPullToRefreshView: UIView {

    
    internal var pullingPercentage : CGFloat = CGFloat.nan {
        didSet{
            if abs(pullingPercentage) >= 1 {
                self.pullingState = .triggered
            }else{
                self.pullingState = .pulling
            }
            self.updateStateLabel()
        }
    }
    
    internal var pullingState : FTPullingState = .none {
        didSet {
            self.updateStateLabel()
        }
    }
    
    internal var refreshingBlock: (()->())? = nil
    internal var originalContentOffset: CGFloat = 0

    public func startRefreshing() {
        self.pullingState = .refreshing
        
        self.refreshingBlock?()
    }
    
    public func stopRefreshing(){
        
        self.pullingState = .success
    }
    
    
    lazy var displayLabel: UILabel = {
        let label : UILabel = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        self.addSubview(label)
        return label
    }()
    
    
    
    func updateStateLabel() {
        switch self.pullingState {
        case .pulling:
            self.displayLabel.text = "\(Int(abs(pullingPercentage*100)))%"
        case .triggered:
            self.displayLabel.text = "可以松手了。。"
        case .refreshing:
            self.displayLabel.text = "正在刷新。。"
        case .success:
            self.displayLabel.text = "刷新成功！！"
        case .failed:
            self.displayLabel.text = "刷新失败！！"
        default:
            self.displayLabel.text = ""
        }
    }
    
    
    
}

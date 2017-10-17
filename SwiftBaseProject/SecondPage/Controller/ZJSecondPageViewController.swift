//
//  ZJSecondPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ZJSecondPageViewController: ZJBaseViewController,UITextFieldDelegate {

    var myTableView:UITableView = UITableView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.separatorStyle = .none
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }
    let dataSources = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>()
    let disposeBag = DisposeBag()
    var titleArr:Array<Any>!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItems = nil
        self.navigationItem.title = "新闻"
//        数组的遍历
//        let numArr = [1,2,3,4,5]
//        Observable.from(numArr)
//            .map { $0 + 3 }
//            .subscribe(onNext: { (value) in
//                print("输出的值== \(value)")
//            }).disposed(by: disposeBag)
        
        myTableView.frame = self.view.bounds
        myTableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
            self.myTableView.deselectRow(at: indexPath, animated: true)
            switch (indexPath.row){
            case 0:
                let searchVC = ZJBookSearchViewController.init()
                self.navigationController?.pushViewController(searchVC, animated: true)
            case 1:
                let zhihuVC = ZJZhiHuViewController.init()
                self.navigationController?.pushViewController(zhihuVC, animated: true)
            default:
                break
            }
        }).addDisposableTo(disposeBag)
        self.view.addSubview(myTableView)
    
        dataSources.configureCell = {
            _ ,tableview,indexPath,title in
            let cell = tableview.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            cell.tag = indexPath.row
            cell.textLabel?.text = title
            return cell
        }
        //获取数据
        createItemDataSource()
            .bind(to: myTableView.rx.items(dataSource: dataSources))
            .addDisposableTo(disposeBag)
    }
    
    func createItemDataSource() -> Observable<[SectionModel<String,String>]> {
        return Observable.create({ (observer) -> Disposable in
            let section = SectionModel.init(model: "你好", items: ["图书查询","知乎demo"])
            observer.onNext([section]);
            observer.onCompleted()
            return Disposables.create()
        })
    }
}

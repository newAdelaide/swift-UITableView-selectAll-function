//
//  ViewController.swift
//  Test
//
//  Created by 尊驾 on 16/11/24.
//  Copyright © 2016年 尊驾. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let SCRRENW = UIScreen.main.bounds.size.width
    let SCRRENH = UIScreen.main.bounds.size.height
    
    
    var tabelview:UITableView = UITableView.init()
    var flag:Bool = false
    var leftBtn:UIBarButtonItem = UIBarButtonItem.init()
    var dataArr:NSMutableArray = NSMutableArray.init()
    var isSelect:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initData()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "编辑", style: UIBarButtonItemStyle.plain, target: self, action:#selector(self.editclick))
        
        leftBtn = UIBarButtonItem.init(title: "全选", style: UIBarButtonItemStyle.plain, target: self, action:#selector(self.leftClick));
        self.navigationItem.leftBarButtonItem = leftBtn
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.title = "swift测试"
        
        self.view.backgroundColor = UIColor.white;
        
        tabelview.frame = CGRect.init(x: 0, y: 64 , width:SCRRENW , height: SCRRENH-64)
        tabelview.backgroundColor = UIColor.white
        tabelview.delegate = self
        tabelview.dataSource = self
        tabelview.allowsSelectionDuringEditing = true
        tabelview .register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellid")
        self.view .addSubview(tabelview)
    }
    func initData() -> Void {
        for i in 0...20 {
            let str: String = "这是第\(i+1)条测试数据"
            dataArr.add(str)
        }
    }
    
    // MARK: 左侧导航栏按钮
    func leftClick() -> Void {
        if !self.tabelview.isEditing {
            return
        }
        isSelect = !isSelect
        if isSelect{
            leftBtn.title = "取消"
            for i in 0...self.dataArr.count {
                let index:NSIndexPath = NSIndexPath.init(row: i, section: 0)
                self.tabelview.selectRow(at: index as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
            }
            isSelect = true
        }else{
            leftBtn.title = "全选"
            for i in 0...self.dataArr.count {
                let index:NSIndexPath = NSIndexPath.init(row: i, section: 0)
                self.tabelview.deselectRow(at: (index as NSIndexPath) as IndexPath, animated: true)
            }
            isSelect = false
        }
        
    }
    
    // MARK: 右侧导航栏按钮
    func editclick() -> Void {
        flag = !flag
        if flag {
            tabelview.setEditing(true, animated: true)
        }else{
            tabelview.setEditing(false, animated: true)
            leftBtn.title = "全选"
            for i in 0...self.dataArr.count {
                let index:NSIndexPath = NSIndexPath.init(row: i, section: 0)
                self.tabelview.deselectRow(at: (index as NSIndexPath) as IndexPath, animated: true)
            }
            isSelect = false
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let str:NSString = self.dataArr[indexPath.row] as! NSString
        cell.textLabel?.text = str as String
        return cell;
    }

    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.init(rawValue: UITableViewCellEditingStyle.insert.rawValue | UITableViewCellEditingStyle.delete.rawValue)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


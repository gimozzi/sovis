//
//  학사공지.swift
//  SOVIS1
//
//  Created by sgcs on 2016. 7. 4..
//  Copyright © 2016년 JJ. All rights reserved.
//

import UIKit

class AcademyNoticeController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var list = Array<NotificationList>()
    
    var urlSession: NSURLSession!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.urlSession = NSURLSession(configuration: configuration)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //기존의 구분선 삭제하기
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        let urlString = NSUserDefaults.standardUserDefaults().stringForKey("학사공지")
        updatelist(urlString!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.urlSession.invalidateAndCancel()
        self.urlSession = nil
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 테이블 행의 갯수
        return self.list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 가져옴
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AcademyCell") as! AcademyCell
        let item = self.list[indexPath.row]
        
        //구분선역할을 할 뷰를 선언
        let separatorLineView: UIView = UIView(frame: CGRectMake(0, 0, view.frame.size.width, 5))
        //뷰의 색을 지정 여기에 이미지를 넣을 수도 있습니다
        separatorLineView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        //셀에 추가하기
        cell.contentView.addSubview(separatorLineView)
        
        cell.Title.text = item.Title
        cell.Date.text = item.date
        return cell
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = cell as? AcademyCell {
            cell.dataTask?.cancel()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "UrlView")
        {
            let Select = segue.destinationViewController as! UrlViewController
            let myindex = self.tableView.indexPathForSelectedRow!
            let row = myindex.row
            Select.url = list[row].URL
            Select.text = "학사공지"
            print("학사공지")
        }
    }
    
    func updatelist(key: String){
        
        let url = NSURL(string: key)
        
        guard let data = NSData(contentsOfURL: url!) else{
        
        //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        
            var noti = NotificationList()
            noti.Title = "servertimeout"
            noti.date = ""
            noti.URL = ""
            self.list.append(noti)
            return
        }
       
        
        do{
            let JsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
            
            let boarder = JsonObject["boarder"] as! NSArray
            
            var noti : NotificationList
            
            for row in boarder {
                
                noti = NotificationList()
                
                noti.Title = row["title"] as? String
                
                noti.date = row["date"] as? String
                
                noti.URL = row["url"] as? String
                
                self.list.append(noti)
            }
            
        } catch {
            
        }
        
    }
    
}

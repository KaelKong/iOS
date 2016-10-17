//
//  MapViewController.swift
//  StudyDemo
//
//  Created by KaelKong on 2016/10/17.
//  Copyright © 2016年 KaelKong. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    let data = NSArray(objects: "A","B","C","D","E","F")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //设置节数
    func numberOfSectionsInTableView(tableView: UITableView)->Int{
        return 1
    }
    
    //设置行数
    func tableView(tableView: UITableView,numberOfRowsInSection section: Int)-> Int{
        return data.count
    }
    
    //设置表单元格中的内容
    func tableView(tableView:UITableView,cellForRowAtIndexPath indexPath:NSIndexPath)->UITableViewCell{
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        cell.textLabel!.text  = "\(data.objectAtIndex(indexPath.row))"
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

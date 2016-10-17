//
//  ViewController.swift
//  StudyDemo
//
//  Created by KaelKong on 2016/10/11.
//  Copyright © 2016年 KaelKong. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet weak var pickerView: UIPickerView!
    let locationManager:CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var labelView: UILabel!
    var addressArray = [[String:AnyObject]]()
    var provinceIndex = 0
    var cityIndex = 0
    var areaIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("address", ofType: "plist")
        self.addressArray = NSArray(contentsOfFile: path!) as! Array
        //设置定位服务管理器代理
        locationManager.delegate = self
        //设置定位进度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //更新距离
        locationManager.distanceFilter = 100
        ////发送授权申请
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled())
        {
            //允许使用定位服务的话，开启定位服务更新
            locationManager.startUpdatingLocation()
            print("定位开始")
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponentsInPickerView(pickerView:UIPickerView)->Int{
        return 3
    }
    
    //设置选择框的行数，继承于UIPickerViewDataSource协议
    func pickerView(pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int{
        if component == 0 {
            return self.addressArray.count
        } else if component == 1 {
            let province = self.addressArray[provinceIndex]
            return province["cities"]!.count
        } else {
            let province = self.addressArray[provinceIndex]
            if let city = province["cities"]?[cityIndex] as? [String: AnyObject] {
                return city["areas"]!.count
            } else {
                return 0
            }
        }
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)
        -> String? {
            if component == 0 {
                return self.addressArray[row]["state"] as? String
            }else if component == 1 {
                let province = self.addressArray[provinceIndex]
                return province["cities"]?[row]["city"] as? String
            }else {
                let province = self.addressArray[provinceIndex]
                let city = province["cities"]?[cityIndex] as! [String: AnyObject]
                return city["areas"]?[row] as? String
            }
    }
    
    
    func pickerView(pickerView:UIPickerView,didSelectRow row: Int, inComponent component: Int){
        switch component {
        case 0:
            self.provinceIndex = row
            self.cityIndex = 0
            self.areaIndex = 0
            //重新加载市数据
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
            //市选中第一个数据
            pickerView.selectRow(0, inComponent: 1, animated: false)
            pickerView.selectRow(0, inComponent: 2, animated: false)
        case 1:
            self.cityIndex = row
            self.areaIndex = 0
            pickerView.reloadComponent(2)
             pickerView.selectRow(0, inComponent: 2, animated: false)
        case 2:
            self.areaIndex = row
        default:
            break
        }
    }
    
    func getPickerViewValue(){
        //获取选中的省
        let p = self.addressArray[provinceIndex]
        let province = p["state"]!
        
        //获取选中的市
        let c = p["cities"]![cityIndex]
        let city = c["city"] as! String
        
        //获取选中的县（地区）
        var area = ""
        if (c["areas"] as! [String]).count > 0 {
            area = (c["areas"] as! [String])[areaIndex]
        }
        
        //拼接输出消息
        let message = "索引：\(provinceIndex)-\(cityIndex)-\(areaIndex)\n"
            + "值：\(province) - \(city) - \(area)"
        
        //消息显示
        let alertController = UIAlertController(title: "您选择了",
                                                message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //定位改变执行，可以得到新位置、旧位置
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //获取最新的坐标
        let currLocation:CLLocation = locations.last!
        labelView.text = "经度：\(currLocation.coordinate.longitude)"
        //label1.text = "经度：\(currLocation.coordinate.longitude)"
        //获取纬度
        //label2.text = "纬度：\(currLocation.coordinate.latitude)"
        //获取海拔
        //label3.text = "海拔：\(currLocation.altitude)"
        //获取水平精度
        //label4.text = "水平精度：\(currLocation.horizontalAccuracy)"
        //获取垂直精度
        //label5.text = "垂直精度：\(currLocation.verticalAccuracy)"
        //获取方向
        //label6.text = "方向：\(currLocation.course)"
        //获取速度
        //label7.text = "速度：\(currLocation.speed)"
    }
    
}






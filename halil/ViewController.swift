//
//  ViewController.swift
//  halil
//
//  Created by INSU BYEON on 2017. 7. 5..
//  Copyright © 2017년 kokonoe. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet var tblView: UITableView!
    
    // 초기 데이터
    var dataArray = ["시노", "테스트", "어플리케이션"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
    * 우측 클릭[+] 버튼
    */
    @IBAction func btnAddClick(_ sender: Any) {
        let alertController = UIAlertController(title: "목록 추가", message: "할 일을 추가하세요", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "추가", style: .default, handler: {
            alert -> Void in
            
            let data = alertController.textFields![0] as UITextField
            
            print("[*] 받은 데이터 : \(String(describing: data.text))")
            
            if data.text == "" {
                // 데이터가 비어있음
                let alertError = UIAlertController(title: "오류", message: "으에엑, 데이터가 없는데요?", preferredStyle: UIAlertControllerStyle.alert)
                alertError.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertError, animated: true, completion: nil)
            } else {
                // 테이블에 추가
                self.dataArray.append(data.text!)
                self.tblView.beginUpdates()
                self.tblView.insertRows(at: [IndexPath(row: self.dataArray.count-1, section: 0)], with: .automatic)
                self.tblView.endUpdates()
            }
            
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "할 일"
        }

        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /**
    * Table cell 뿌려주기
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    /**
    * Table section 뿌려주기
    */
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "목록"
    }

    /**
    * Table Delete 버튼 이벤트 구현
    */
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.dataArray.remove(at: indexPath.row)
            let alertSuccess = UIAlertController(title: "알림", message: "목록이 삭제되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
            alertSuccess.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertSuccess, animated: true, completion: nil)
            self.tblView.reloadData()
        }
    }
    
    /**
    * Delete 버튼 이름 변경
    */
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    /**
    * Section 갯수 설정
    */
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    /**
    * Table secion 설정?
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArray.count
    }
    
    
}


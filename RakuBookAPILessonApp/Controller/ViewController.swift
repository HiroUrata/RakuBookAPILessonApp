//
//  ViewController.swift
//  RakuBookAPILessonApp
//
//  Created by UrataHiroki on 2021/11/06.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var searhResultTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    private let alamofire = Alamofire()
    
    private var cellContentsArray = [BookDetailDatas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searhResultTableView.register(UINib(nibName: "TableViewCustomCell", bundle: nil), forCellReuseIdentifier: "BookDetailCell")
        searhResultTableView.delegate = self
        searhResultTableView.dataSource = self
        
    }

    @IBAction func search(_ sender: UIButton) {
        
        if searchTextField.text!.count > 0{
            
            alamofire.getBookDetailDatas(searchKeyWord: searchTextField.text) { detail, error in
                
                if error != nil{
                    
                    return
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {[self] in
                    
                    cellContentsArray = detail!
                    searhResultTableView.reloadData()
                }
            }
        }
    }
    
}

extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 3.5
    }
}

extension ViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellContentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookDetailCell", for: indexPath) as! TableViewCustomCell
        
        cell.bookImageView.sd_setImage(with: URL(string: cellContentsArray[indexPath.row].mediumImageUrl!), completed: nil)
        cell.bookTitleLabel.text = cellContentsArray[indexPath.row].bookTitle
        cell.authorLabel.text = cellContentsArray[indexPath.row].author
        cell.itemPriceLabel.text = "\(String(cellContentsArray[indexPath.row].itemPrice!))円"
        
        return cell
    }
}

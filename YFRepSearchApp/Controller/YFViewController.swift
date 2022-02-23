//
//  ViewController.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/22.
//

import UIKit

class YFViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var tableView = UITableView()
    var textField = YFTextField()
    
    var root:Root = Root(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        textField.throttle(delay: 5.0) { (text) in
            if self.textField.text?.isEmpty != true{
                self.fetchData(keyword: text!)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let safeAreaTop = view.safeAreaInsets.top
        textField.frame = CGRect(x: 0, y: safeAreaTop, width: view.frame.size.width, height: 50)
        tableView.frame = CGRect(x: 0, y: safeAreaTop + textField.frame.size.height, width: view.frame.size.width, height: view.frame.size.height - textField.frame.size.height - safeAreaTop)
        
    }
    
    private func fetchData(keyword:String){
        
        YFAPIManager.shared.fetchData(keyword: keyword, perpage: 5) { [weak self] result in
            
            switch result{
            case .success(let root):
                self?.root = root
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.presentAlertVC(title: "エラー", message: error.localizedDescription, buttonTitle: "OK")
                }
                
            }
            
        }
    }
    
    func configureUI(){
        view.backgroundColor = .white
        textField.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50)
        textField.delegate = self
        view.addSubview(textField)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(YFContentCell.self, forCellReuseIdentifier:YFContentCell.identifier)
        view.addSubview(tableView)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.root.items!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YFContentCell.identifier, for: indexPath) as! YFContentCell
        cell.configure(repository: (self.root.items![indexPath.row]))
        
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
}

//
//  YFTextField.swift
//  YFRepSearchApp
//
//  Created by Yuta Fujii on 2022/02/23.
//

import UIKit

class YFTextField: UITextField {

    private var workItem: DispatchWorkItem?
    private var delay: Double = 0
    private var callback: ((String?) -> Void)? = nil


    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        
        placeholder = "文字を入力してください"
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    deinit {
        self.removeTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }


    func throttle(delay: Double, callback: @escaping ((String?) -> Void)) {
        self.delay = delay
        self.callback = callback
        DispatchQueue.main.async {
            self.callback?(self.text)
        }
        self.addTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }

    @objc private func editingChanged(_ sender: UITextField) {
        if self.workItem == nil {
            let text = sender.text
            self.callback?(text)
            let workItem = DispatchWorkItem(block: { [weak self] in
                self?.workItem?.cancel()
                self?.workItem = nil
                if text != sender.text {
                    self?.callback?(sender.text)
                }
            })
            self.workItem = workItem
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delay, execute: workItem)
        }
    }


}

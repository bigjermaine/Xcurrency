//
//  ToggleView.swift
//  Xcurrency
//
//  Created by MacBook AIR on 17/07/2023.
//

import UIKit



protocol ToggleViewDelegate: AnyObject {
    func ToggleViewDidTaPast30(_ toggleView:  ToggleView)
    func ToggleViewDidTaPast90(_ toggleView: ToggleView)
 
}
class ToggleView: UIView {
    
    enum state {
        case past30
        case past90
       
    }
    
    var State:state = .past30
    
    
    weak var Delegate: ToggleViewDelegate?
    
    private let past90Button:UIButton = {
        let button = UIButton()
        button.setTitle("Past 90 days", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let past30Button:UIButton = {
        let button = UIButton()
        button.setTitle("Past 30 days", for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    private let indicatorView: UIView =  {
        let view = UIView()
        view.backgroundColor =  .green
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(past30Button)
        addSubview(past90Button)
        addSubview(indicatorView)
        past30Button.addTarget(self, action: #selector(past30), for: .touchUpInside)
        past90Button.addTarget(self, action: #selector(past90), for: .touchUpInside)
        
    }
    
    
    @objc private func past30() {
        Delegate?.ToggleViewDidTaPast30(self)
        State = .past30
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIndicator()
        }
    }
    
    @objc private func past90() {
        Delegate?.ToggleViewDidTaPast90(self)
        State = .past90
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.layoutIndicator()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenWidth = UIScreen.main.bounds.width
        let width =  screenWidth/3
        
        
        
        past30Button.frame = CGRect(x:  50, y: 0, width:  width , height: 10)
        past90Button.frame = CGRect(x:past30Button.right, y: 0, width:  width , height: 10)
        indicatorView.frame = CGRect(x: 50 + past30Button.width/2, y: past30Button.bottom+10, width:  10, height: 10)
        layoutIndicator()
    }
    
    func layoutIndicator() {
        
        let screenWidth = UIScreen.main.bounds.width
        switch State {
            
        case .past30:
            indicatorView.frame = CGRect(x: 50 + past30Button.width/2, y: past30Button.bottom+10, width:  10, height: 10)
        case .past90:
            indicatorView.frame = CGRect(x: past90Button.right - past90Button.width/2, y:  past90Button.bottom+10, width:10, height: 10)
        }
        
        
    }
    func update(for state: state) {
        self.State = state
        UIView.animate(withDuration: 0.2) {[weak self ]  in
            self?.layoutIndicator()
        }
    }
}

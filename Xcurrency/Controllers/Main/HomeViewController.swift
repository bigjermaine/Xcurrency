//
//  HomeViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//

import UIKit
import SVProgressHUD
import Realm
import RealmSwift

//Delegate method for showing the sidemenu
protocol HomeViewControllerdelegate:AnyObject {
    func didTapManuButton()
}



class HomeViewController: UIViewController,PickerViewControllerdelegate {
   
    //99.9 percent chnace it can fail
    let realm = try! Realm()
    

    weak var delegate: HomeViewControllerdelegate?
    
    let buttonPicker =   ButtonPicker()
    
    
    let  graphView = GraphViewController()
    
    let  SecondGraphView = PieGraphViewController()
    
    let secondButtonPicker =   ButtonPicker()
    
    let toggleView = ToggleView()
    
    var pickerbool:Bool = false
    
    var multipleConvert = 871.77
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    
    private let graphScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let firstEntryField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.leftViewMode = .always
        field.keyboardType = .numberPad
        field.textColor = .black
        field.backgroundColor = .gray.withAlphaComponent(0.1)
        field.layer.cornerRadius = 4
        field.placeholder = "Currency"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
        return field
    }()
    
    private let firstEntryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black.withAlphaComponent(0.2)
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.text =  "EUR"
        return label
    }()
    
    private let convertButton:UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 0.32, green: 0.73, blue: 0.39, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
       return button
    }()
    private let secondEntryField: UITextField = {
        let field = UITextField()
        field.keyboardType = .numberPad
        field.translatesAutoresizingMaskIntoConstraints = false
        field.leftViewMode = .always
        field.textColor = .black
        field.isUserInteractionEnabled = false
        field.backgroundColor = .gray.withAlphaComponent(0.1)
        field.layer.cornerRadius = 4
        field.placeholder = "Currency"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 0))
        return field
    }()
    
    
    private let secondEntryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black.withAlphaComponent(0.2)
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.text =  "EUR"
        return label
    }()
   

    private let exchangeEntryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .systemBlue
        
        let attributedText = NSMutableAttributedString(string: "Mid-market exchange rate at \(Date().formattedTime())")
        
        let underlineRange = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: underlineRange)
        
    
        label.attributedText = attributedText
        
        return label
    }()


    private let titlelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemBlue
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 40)
        let fullText = "Currency\nCalculator."
        let attributedText = NSMutableAttributedString(string: fullText)
        
        // Find the range of the full stop
        if let rangeOfFullStop = fullText.range(of: ".") {
            let nsRangeOfFullStop = NSRange(rangeOfFullStop, in: fullText)
            
            // Set the color of the full stop to green
            attributedText.addAttribute(.foregroundColor, value: UIColor(red: 0.32, green: 0.73, blue: 0.39, alpha: 1.0), range: nsRangeOfFullStop)
        }

        // Assign the attributed text to the label
        label.attributedText = attributedText
        
        return label
    }()
    
    
    private  let InfoimageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 15
        imageView.tintColor = .systemBlue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        if let systemImage = UIImage(systemName: "info") {
            let resizedImage = systemImage.withConfiguration(UIImage.SymbolConfiguration(pointSize: 8))
            imageView.image = resizedImage
        }
        
        return imageView
    }()
    
    private  let rectangleView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = skyDarkBlueColor
        view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navBarButton()
        subviews()
        setPickerView()
        
    
       
        constriants()
        addChildren()
        
        graphScrollView.delegate = self
        
        toggleView.Delegate = self
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonPickerTapped))
        buttonPicker.addGestureRecognizer(tapGesture)
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector( secondPickerTapped))
        secondButtonPicker.addGestureRecognizer(tapGesture2)
       
        convertButton.addTarget(self, action: #selector( convertCurrency), for: .touchUpInside)
    
    }
    
    func didTapMenuButton(entry: Country, viewController: PickerViewController) {
        if pickerbool {
            buttonPicker.flagImageView.image = UIImage(named: entry.displayName)
            buttonPicker.countryLabel.text = entry.name
            firstEntryLabel.text = entry.name
        }else{
            //change method because api limitation
            secondButtonPicker.flagImageView.image = UIImage(named: entry.displayName)
            secondButtonPicker.countryLabel.text = entry.name
            secondEntryLabel.text = entry.name
            multipleConvert = entry.rate
        
        }
       
    }
   
   private func setPickerView() {
        buttonPicker.flagImageView.image = UIImage(named: "currency")
        buttonPicker.countryLabel.text = "EUR"
        firstEntryLabel.text = "EUR"
        buttonPicker.chevronImageView.image = UIImage(systemName: "chevron.down")
        buttonPicker.layer.borderWidth = 1.0
        buttonPicker.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        buttonPicker.layer.cornerRadius = 4
        
        secondButtonPicker.flagImageView.image = UIImage(named: "NG")
        secondButtonPicker.countryLabel.text = "NGN"
        secondEntryLabel.text = "NGN"
        secondButtonPicker.chevronImageView.image = UIImage(systemName: "chevron.down")
        secondButtonPicker.layer.borderWidth = 1.0
        secondButtonPicker.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        secondButtonPicker.layer.cornerRadius = 4
        
        
    }
    
    
    
    @objc func buttonPickerTapped() {
        let alert = UIAlertController(title: "Need To Subcribe TO API EndPOINT", message: "Cant Perform This Process Because Of Api Limitaions the base currency is Euro,you can use the next picker to change the currency you which to convert to", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
     }
    
    
    @objc func secondPickerTapped() {
        secondEntryField.text = ""
        HapticManager.shared.vibrateForSelection()
        pickerbool = false
       let vc = PickerViewController()
        vc.delegate = self
       let naVC =  UINavigationController(rootViewController: vc)
        present(naVC , animated: true, completion: nil)
    }
    
    
    
    @objc func listButtonTapped() {
        delegate?.didTapManuButton()
       }
    
    
    
    @objc func signupButtonTapped() {
        // Create and present the view controller in fullscreen
        
        AuthManager.shared.signout { done in
            if done {
                print("You out")
            }
        }
        let viewController = SigninViewController()
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func convertCurrency() {
        

        guard let text = firstEntryField.text,text != "" , let bases = buttonPicker.countryLabel.text,let convert = secondButtonPicker.countryLabel.text else {
            //Error Alert Control
            let alert = UIAlertController(title: "Error", message: "Please enter all the required values", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
            HapticManager.shared.vibrate(for: .error)
               return
           }
        
       
        HapticManager.shared.vibrateForSelection()
       
        let  value = multipleConvert * (Double(text) ?? 0.00)
        
      secondEntryField.text = "\(value)"
        
      saveRealm()
    }
    
    
    private func saveRealm() {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let newdataCurrency = person()
        newdataCurrency.Rate =  String(multipleConvert)
        newdataCurrency.baseCurrency = firstEntryLabel.text ?? ""
        newdataCurrency.ConvertCurency = secondEntryLabel.text ?? ""
        newdataCurrency.date = dateFormatter.string(from: Date())

        realm.beginWrite()
        realm.add(newdataCurrency)
        do {
            try realm.commitWrite()
            print("saved to realm")
        }catch{
            
        }
    }
}


   






extension HomeViewController:ToggleViewDelegate,UIScrollViewDelegate  {
   
    
    
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        if scrollView.contentOffset.x <= (view.width/2) {
            toggleView.update(for: .past30)


        }else  if scrollView.contentOffset.x > (view.width/2)  && scrollView.contentOffset.x <= (view.width) {
            toggleView.update(for: .past90)
        }
        
    }
    
    //Change with toogle view
    func ToggleViewDidTaPast30(_ toggleView: ToggleView) {
        graphScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    
    func ToggleViewDidTaPast90(_ toggleView: ToggleView) {
        graphScrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: false)
    }
    
    
    
    
    
    
    private func  navBarButton() {
        
        // Left
        let listButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: #selector(listButtonTapped))
        listButton.tintColor =  UIColor(red: 0.32, green: 0.73, blue: 0.39, alpha: 1.0)
        navigationItem.leftBarButtonItem = listButton
        
        // right
        let signupButton = UIBarButtonItem(title: "Signup", style: .plain, target: self, action: #selector(signupButtonTapped))
        signupButton.tintColor =  UIColor(red: 0.32, green: 0.73, blue: 0.39, alpha: 1.0)
        navigationItem.rightBarButtonItem = signupButton
    }
    
    
    
    
    //Note:views configuration
    
    private func subviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(titlelabel)
        scrollView.addSubview(firstEntryField)
        scrollView.addSubview(secondEntryField)
        scrollView.addSubview(secondEntryLabel)
        scrollView.addSubview( firstEntryLabel)
        scrollView.addSubview( buttonPicker)
        scrollView.addSubview(secondButtonPicker)
        scrollView.addSubview( convertButton)
        scrollView.addSubview( exchangeEntryLabel)
        scrollView.addSubview( InfoimageView)
        scrollView.addSubview( rectangleView)
        scrollView.addSubview( graphScrollView)
        graphScrollView.addSubview(toggleView)
        graphScrollView.contentSize = CGSize(width: view.width*2, height: 500)
     
    }
    
  
    
    
    private func addChildren() {
        
        addChild(graphView)
        graphScrollView.addSubview(graphView.view)
        graphView.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            graphView.view.leadingAnchor.constraint(equalTo: graphScrollView.leadingAnchor),
            graphView.view.topAnchor.constraint(equalTo: rectangleView.topAnchor, constant: 150),
            graphView.view.widthAnchor.constraint(equalTo: graphScrollView.widthAnchor),
            graphView.view.heightAnchor.constraint(equalToConstant: 500)
        ])

        graphView.didMove(toParent: self)


        addChild(SecondGraphView)
        graphScrollView.addSubview(SecondGraphView.view)
        SecondGraphView.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            SecondGraphView.view.leadingAnchor.constraint(equalTo: graphView.view.trailingAnchor),
            SecondGraphView.view.topAnchor.constraint(equalTo: rectangleView.topAnchor, constant: 150),
            SecondGraphView.view.widthAnchor.constraint(equalTo: graphScrollView.widthAnchor),
            SecondGraphView.view.heightAnchor.constraint(equalToConstant: 500)
        ])

        SecondGraphView.didMove(toParent: self)

    }
    
    private func constriants() {
        buttonPicker.translatesAutoresizingMaskIntoConstraints = false
        secondButtonPicker.translatesAutoresizingMaskIntoConstraints = false
        rectangleView.translatesAutoresizingMaskIntoConstraints = false
        graphScrollView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titlelabel.leadingAnchor.constraint(equalTo:  scrollView.leadingAnchor,constant: 20),
            titlelabel.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 40),
            titlelabel.heightAnchor.constraint(equalToConstant: 100),
            
            firstEntryField.topAnchor.constraint(equalTo:    titlelabel.bottomAnchor,constant: 40),
            firstEntryField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            firstEntryField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            firstEntryField.heightAnchor.constraint(equalToConstant: 50),
           
            firstEntryLabel.centerYAnchor.constraint(equalTo: firstEntryField.centerYAnchor),
            firstEntryLabel.trailingAnchor.constraint(equalTo:  firstEntryField.trailingAnchor,constant: -10),
            firstEntryLabel.heightAnchor.constraint(equalToConstant: 30),
           
            secondEntryField.topAnchor.constraint(equalTo:   firstEntryField.bottomAnchor,constant: 20),
            secondEntryField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            secondEntryField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            secondEntryField.heightAnchor.constraint(equalToConstant: 50),
           
            secondEntryLabel.centerYAnchor.constraint(equalTo: secondEntryField.centerYAnchor),
            secondEntryLabel.trailingAnchor.constraint(equalTo:   secondEntryField.trailingAnchor,constant: -10),
            secondEntryLabel.heightAnchor.constraint(equalToConstant: 30),
            
            buttonPicker.topAnchor.constraint(equalTo:      secondEntryField.bottomAnchor,constant: 40),
            buttonPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            buttonPicker.widthAnchor.constraint(equalToConstant: 150),
            buttonPicker.heightAnchor.constraint(equalToConstant: 50),
            
            
            secondButtonPicker.topAnchor.constraint(equalTo:      secondEntryField.bottomAnchor,constant: 40),
            secondButtonPicker.trailingAnchor.constraint(equalTo:   secondEntryField.trailingAnchor,constant: 0),
            secondButtonPicker.widthAnchor.constraint(equalToConstant: 150),
            secondButtonPicker.heightAnchor.constraint(equalToConstant: 50),
        
            convertButton.topAnchor.constraint(equalTo:     secondButtonPicker.bottomAnchor,constant: 40),
            convertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            convertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            convertButton.heightAnchor.constraint(equalToConstant: 50),
      
            exchangeEntryLabel.topAnchor.constraint(equalTo:      convertButton.bottomAnchor,constant: 40),
            exchangeEntryLabel.centerXAnchor.constraint(equalTo: convertButton.centerXAnchor),
            exchangeEntryLabel.widthAnchor.constraint(equalTo: convertButton.widthAnchor,constant: -40),
            exchangeEntryLabel.heightAnchor.constraint(equalToConstant: 50),
      
            InfoimageView.centerYAnchor.constraint(equalTo:  exchangeEntryLabel.centerYAnchor),
            InfoimageView.leadingAnchor.constraint(equalTo:  exchangeEntryLabel.trailingAnchor,constant: 0),
            InfoimageView.widthAnchor.constraint(equalToConstant: 30),
            InfoimageView.heightAnchor.constraint(equalToConstant: 30),

            
            
            rectangleView.topAnchor.constraint(equalTo:exchangeEntryLabel.bottomAnchor,constant: 40),
            rectangleView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 0),
            rectangleView.widthAnchor.constraint(equalTo:scrollView.widthAnchor),
            rectangleView.heightAnchor.constraint(equalToConstant: 500),
            rectangleView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            graphScrollView.topAnchor.constraint(equalTo:  rectangleView.topAnchor),
            graphScrollView.leadingAnchor.constraint(equalTo:   rectangleView.leadingAnchor),
            graphScrollView.trailingAnchor.constraint(equalTo:   rectangleView.trailingAnchor),
            graphScrollView.bottomAnchor.constraint(equalTo:   rectangleView.bottomAnchor),
         
            toggleView.topAnchor.constraint(equalTo:   graphScrollView.topAnchor,constant: 50),
            toggleView.leadingAnchor.constraint(equalTo:   rectangleView.leadingAnchor),
            toggleView.trailingAnchor.constraint(equalTo:   rectangleView.trailingAnchor),
            toggleView.heightAnchor.constraint(equalToConstant: 40)
         
            
            
           
            
           
        ])
    }
    
    
}

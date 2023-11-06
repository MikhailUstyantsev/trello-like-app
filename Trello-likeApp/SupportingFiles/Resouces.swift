//
//  Resouces.swift
//  WeekActivityTestCell
//
//  Created by Mikhail Ustyantsev on 04.11.2023.
//

import UIKit

enum R {
    
    //MARK: - Colors
  
    enum Colors {
        static let darkGray = UIColor(hexString: "#8A8F9E")
        static let lightGray = UIColor(hexString: "#C6C7CB")
        static let purple = UIColor(hexString: "#9C93FF")
        static let white = UIColor(hexString: "#F6F6F6")
        static let middleGray = UIColor(hexString: "#A8ABB7")
        static let black = UIColor(hexString: "#333333")
        static let blue = UIColor(hexString: "#106CBD")
        static let lightBlue = UIColor(hexString: "#C6DEF8")
    }
    
    //MARK: - Strings
    
    enum Strings {
        
        enum BoardViewController {
            static let appTitle = "Trello-like App"
            static let addList = "Добавить список"
        }
        
        enum TableHeaderView {
           static let addTitle = "Добавить"
        }
        
        enum BoardCollectionViewCell {
            static let addTask = "Добавить задачу"
            static let cancel = "Отмена"
        }
      
        
    }
    
    //MARK: - Numbers
    
    enum Numbers {
        
       
        
    }
    
    //MARK: - Images
    
    enum Images {
        
        
    }
    
    
    
    
    //MARK: - Fonts
    
    enum Fonts {
        
        static func montserratBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Bold", size: size) ?? UIFont()
        }
        
        static func montserratLight(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-Light", size: size) ?? UIFont()
        }
        
        static func montserratExtraLight(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-ExtraLight", size: size) ?? UIFont()
        }
        
        static func montserratSemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Montserrat-SemiBold", size: size) ?? UIFont()
        }
        
    }
    
    
}


//
//  Theme.swift
//  VoiceOfLaw
//
//  Created by Ernazar on 11/6/24.
//

import UIKit

protocol ThemeProperties {
    var blueGrayColor: UIColor { get }
    var bluishGrayColor: UIColor { get }
    var darkGrayColor: UIColor { get }
    var lightGrayColor: UIColor { get }
    var lightBluishGray: UIColor { get }
    var lightGrayishBlue: UIColor { get }
    var snowyGray: UIColor { get }
    var mediumGray: UIColor { get }
    var veryLightGray: UIColor { get }
    var lightGrayishBlueColor: UIColor { get }
    var navyBlueColor: UIColor { get }
    var darkBlueColor: UIColor { get }
    var skyBlueColor: UIColor { get }
    var skyBlue15Color: UIColor { get }
    var skyBlue30Color: UIColor { get }
    var slateBlue: UIColor { get }
    var redOrangeColor: UIColor { get }
    var unactiveButtonColor: UIColor { get }
    var activeButtonColor: UIColor { get }
    var brickRed: UIColor { get }
    var brightTangerine: UIColor { get }
    var vibrantCoralRed: UIColor { get }
    var brightGreen: UIColor { get }
    var white: UIColor { get }
}

struct Theme: ThemeProperties {
    
    static let shared = Theme()
    
    //Gray Colors
    let blueGrayColor = UIColor(named: "blue_gray")! //color #344054
    let bluishGrayColor = UIColor(named: "bluish_gray")! //color #667085
    let darkGrayColor = UIColor(named: "dark_gray")! //color #32303A
    let lightGrayColor = UIColor(named: "light_gray")! //color #EAECF0
    let lightBluishGray = UIColor(named: "light_bluish_gray")! //color #9EA7AF
    let lightGrayishBlue = UIColor(named: "light_grayish_blue")! //color #AFC0D0
    let snowyGray = UIColor(named: "snowy_gray")! //color #F6F7F9
    let mediumGray = UIColor(named: "medium_gray")! //color #BEBFC0
    let veryLightGray = UIColor(named: "very_light_gray")! //color #F1F1F1
    
    //Blue Colors
    let lightGrayishBlueColor = UIColor(named: "light_grayish_blue")! //color #D0D5DD
    let navyBlueColor = UIColor(named: "navy_blue")! //color #0077B6
    let darkBlueColor = UIColor(named: "dark_blue")! //color #101828
    let skyBlueColor = UIColor(named: "sky_blue")! //color #489FE1
    let skyBlue15Color = UIColor(named: "sky_blue_15")! //color #489FE1
    let skyBlue30Color = UIColor(named: "sky_blue_30")! //color #489FE1
    let slateBlue = UIColor(named: "slate_blue")! //color #475467
    
    //Red Colors
    let redOrangeColor = UIColor(named: "red_orange")! //color #F04438
    
    let unactiveButtonColor = UIColor(named: "light_bluish_gray")! //color #9EA7AF
    let activeButtonColor = UIColor(named: "sky_blue")! //color #489FE1
    let brickRed = UIColor(named: "brick_red")! //color #EB5757
    
    let brightTangerine = UIColor(named: "bright_tangerine")! //color #FFAC33
    let vibrantCoralRed = UIColor(named: "vibrant_coral_red")! //color #E64452
    let brightGreen = UIColor(named: "bright_green")! //color #4AC03F
    let white = UIColor(named: "white")! //color #FFFFFF
}

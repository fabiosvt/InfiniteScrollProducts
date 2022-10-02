//
//  CellModel.swift
//  InfiniteScrollProducts
//
//  Created by Fabio Silvestri on 30/09/22.
//

import Foundation

struct CellModel {
    let item: Product
    let indexPath: IndexPath
}

/**
 Feedback rating
 
 *values*
 
 `EXCELLENT`
 
 `GOOD`
 
 `AVERAGE`
 
 `BAD`
 
 `POOR`
 
 *functions*
 
 `func toString() -> String`
 
 Used to get the string version of the enum value.
 
 `mutating func from(integer input : Int)`
 
 Used to get the enum value from an `Int`
 
 - Author: Arun Patwardhan
 - Version: 1.0
 - Date: 1st August 2019
 
 **Contact Details**
 
 [arun@amaranthine.co.in](mailto:arun@amaranthine.co.in)
 
 [www.amaranthine.in](https://www.amaranthine.in)
 */
enum Rating
{
    case EXCELLENT, GOOD, AVERAGE, BAD, POOR
    
    func toString() -> String
    {
        switch self {
        case .EXCELLENT:
            return "EXCELLENT"
        case .GOOD:
            return "GOOD"
        case .AVERAGE:
            return "AVERAGE"
        case .BAD:
            return "BAD"
        case .POOR:
            return "POOR"
        }
    }
    
    mutating func from(integer input : Int)
    {
        switch input {
        case 0:
            self = .EXCELLENT
        case 1:
            self = .GOOD
        case 2:
            self = .AVERAGE
        case 3:
            self = .BAD
        case 4:
            self = .POOR
        default:
            self = .AVERAGE
        }
    }
}

/**
 Struct that represents the model for the data collected from the form.
 
 - Author: Arun Patwardhan
 - Version: 1.0
 - Date: 1st August 2019
 
 **Contact Details**
 
 [arun@amaranthine.co.in](mailto:arun@amaranthine.co.in)
 
 [www.amaranthine.in](https://www.amaranthine.in)
 */
struct FeedbackResponse
{
    var name                : String    = ""
    var email               : String    = ""
    var age                 : Date      = Date(timeIntervalSinceNow: 0)
    var serviceRating       : Rating    = Rating.AVERAGE
    var satisfactionRating  : Rating    = Rating.AVERAGE
    var dateOfSurvey        : Date      = Date(timeIntervalSinceNow: 0)
}

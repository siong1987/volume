//
//  ComplicationController.swift
//  Watch Extension
//
//  Created by Teng Siong Ong on 1/14/17.
//  Copyright © 2017 Teng Siong Ong. All rights reserved.
//

import ClockKit

class ComplicationController: NSObject, CLKComplicationDataSource {
  
  private let circularImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Circular")!)
  private let utilitarianImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Utilitarian")!)
  private let modularImageProvider = CLKImageProvider(onePieceImage: UIImage(named: "Complication/Modular")!)
  
  // MARK: - Timeline Configuration
  
  func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
    handler([.forward, .backward])
  }
  
  func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    handler(nil)
  }
  
  func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
    handler(nil)
  }
  
  func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
    handler(.showOnLockScreen)
  }
  
  // MARK: - Timeline Population
  
  func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
    // Call the handler with the current timeline entry
    handler(nil)
  }
  
  func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    // Call the handler with the timeline entries prior to the given date
    handler(nil)
  }
  
  func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
    // Call the handler with the timeline entries after to the given date
    handler(nil)
  }
  
  // MARK: - Placeholder Templates
  
  func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
    switch complication.family {
    case .circularSmall:
      let template =  CLKComplicationTemplateCircularSmallSimpleImage()
      template.imageProvider = circularImageProvider
      handler(template)
    case .modularSmall:
      let template =  CLKComplicationTemplateModularSmallSimpleImage()
      template.imageProvider = modularImageProvider
      handler(template)
    case .utilitarianSmall:
      let template =  CLKComplicationTemplateUtilitarianSmallSquare()
      template.imageProvider = utilitarianImageProvider
      handler(template)
    default:
      // We don't support others complications
      handler(nil)
    }
  }
}

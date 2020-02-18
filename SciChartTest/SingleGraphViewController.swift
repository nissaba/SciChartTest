//
//  SingleGraphViewController.swift
//  SciChartTest
//
//  Created by Pascale Beaulac on 2020-02-04.
//  Copyright © 2020 Notio Technologies inc. All rights reserved.
//

import UIKit
import SciChart

class SingleGraphViewController: UIViewController {
    @IBOutlet weak var surface: SCIChartSurface!
    private(set) lazy var notioData: [NotioData] = {
        if let path = Bundle.main.path(forResource: "notiodata", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try JSONDecoder().decode([NotioData].self, from: data)
            }catch {
                fatalError()
            }
        }
        return []
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataModel = notioData
        
        let powerDataSeries: SCIXyDataSeries = SCIXyDataSeries(xType: .int, yType: .double)
        powerDataSeries.seriesName = "Power"
        
        let cdaDataSeries: SCIXyDataSeries = SCIXyDataSeries(xType: .int, yType: .double)
        cdaDataSeries.seriesName = "CdA"
        
        
        for model in dataModel  {
            cdaDataSeries.append(x: model.timestamp, y: model.cdA)
            powerDataSeries.append(x: model.timestamp, y: model.power)
        }
        
        let seriesCdA = SCIFastLineRenderableSeries()
        seriesCdA.yAxisId = "CdA"
        seriesCdA.dataSeries = cdaDataSeries
        seriesCdA.strokeStyle = SCISolidPenStyle(colorCode: 0xFF0271B1, thickness: 2)
                
        let seriesPower = SCIFastLineRenderableSeries()
        seriesPower.yAxisId = "Power"
        seriesPower.dataSeries = powerDataSeries
        seriesPower.strokeStyle = SCISolidPenStyle(colorCode: 0xFFFF3333, thickness: 2)
                
        let rederer = SCIRenderableSeriesCollection()
        rederer.add(items: seriesPower)
        rederer.add(items: seriesCdA)
        
        let xAxis = SCICategoryDateAxis()
        
        // Create another numeric axis, left-aligned
        let yAxisLeft = SCINumericAxis()
//        yAxisLeft.axisTitle = "CdA"
        yAxisLeft.axisId = "CdA"
        yAxisLeft.axisAlignment = .left
        yAxisLeft.autoRange = .never
        yAxisLeft.growBy = SCIDoubleRange(min: 0, max: 0.1)
        yAxisLeft.visibleRange = SCIDoubleRange(min: 0, max: 4.0)
        yAxisLeft.tickLabelStyle = SCIFontStyle(fontSize: 12, andTextColorCode: 0xFF0271B1)
        yAxisLeft.titleStyle = SCIFontStyle(fontSize: 18, andTextColorCode: 0xFF0271B1)
        
        let yAxisRight = SCINumericAxis()
//        yAxisRight.axisTitle = "Power"
        yAxisRight.axisId = "Power"
        yAxisRight.axisAlignment = .right
        yAxisRight.growBy = SCIDoubleRange(min: 0, max: 0.1)
        yAxisRight.tickLabelStyle = SCIFontStyle(fontSize: 12, andTextColorCode: 0xFFFF3333)
        yAxisRight.titleStyle = SCIFontStyle(fontSize: 18, andTextColorCode: 0xFFFF3333)
        
        let xAxisDragModifier = SCIXAxisDragModifier()
        xAxisDragModifier.dragMode = .pan
        xAxisDragModifier.clipModeX = .stretchAtExtents
        
        let pinchZoomModifier = SCIPinchZoomModifier()
        pinchZoomModifier.direction = .xDirection
        
        //        let legendModifier = SCILegendModifier()
        //        legendModifier.showCheckBoxes = false
        
        let zoomExtentsModifier = SCIZoomExtentsModifier()
        zoomExtentsModifier.direction = .xDirection
        zoomExtentsModifier.executeOn = .doubleTap
        zoomExtentsModifier.isAnimated = true
        
        let zoomPanModifier = SCIZoomPanModifier()
        zoomPanModifier.direction = .xDirection
        zoomPanModifier.clipModeX = .stretchAtExtents
        zoomPanModifier.clipModeY = .none
        zoomPanModifier.zoomExtentsY = false
        
        SCIUpdateSuspender.usingWith(surface) {
            self.surface.xAxes.add(xAxis)
            self.surface.yAxes.add(items: yAxisLeft, yAxisRight)
            self.surface.renderableSeries = rederer
            self.surface.chartModifiers.add(items: xAxisDragModifier, pinchZoomModifier, zoomPanModifier, zoomExtentsModifier, SCILegendModifier(), SCIRolloverModifier())
            
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

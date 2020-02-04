//
//  ViewController.swift
//  SciChartTest
//
//  Created by Pascale Beaulac on 2020-01-31.
//  Copyright © 2020 Notio Technologies inc. All rights reserved.
//

import UIKit
import SciChart

class ViewController: UIViewController {
    @IBOutlet weak var cdaSurface: SCIChartSurface!
    @IBOutlet weak var powerSurface: SCIChartSurface!
    @IBOutlet weak var speedSurface: SCIChartSurface!
    let verticalGroup = SCIChartVerticalGroup()
    let sharedXRange = SCIDoubleRange()
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
        
        let speedDataSeries: SCIXyDataSeries = SCIXyDataSeries(xType: .int, yType: .double)
        speedDataSeries.seriesName = "Speed"
        
        for model in dataModel  {
            cdaDataSeries.append(x: model.timestamp, y: model.cdA)
            powerDataSeries.append(x: model.timestamp, y: model.power)
            speedDataSeries.append(x: model.timestamp, y: model.speed)
        }
        
        setupSurface(surface: cdaSurface, title: "CdA", dataSerires: cdaDataSeries, colorCode: 0xFF0271B1, isMainPane: true)
        setupSurface(surface: powerSurface, title: "Power", dataSerires: powerDataSeries, colorCode: 0xFFB14202, isMainPane: false)
        setupSurface(surface: speedSurface, title: "Speed", dataSerires: speedDataSeries, colorCode: 0xFFFF3333, isMainPane: false)
    }
    
    fileprivate func setupSurface(surface: SCIChartSurface, title: String, dataSerires: SCIXyDataSeries, colorCode: UInt32, isMainPane: Bool) {
        
        let series = SCIFastLineRenderableSeries()
        series.yAxisId = title
        series.dataSeries = dataSerires
        series.strokeStyle = SCISolidPenStyle(colorCode: colorCode, thickness: 2)
        
        let render = SCIRenderableSeriesCollection()
        render.add(items: series)
        
        let xAxis = SCICategoryDateAxis()
        xAxis.isVisible = isMainPane
        xAxis.visibleRange = sharedXRange
        
        // Create another numeric axis, left-aligned
        let yAxisLeft = SCINumericAxis()
        yAxisLeft.axisTitle = title
        yAxisLeft.axisId = title
        yAxisLeft.axisAlignment = .left
        
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
        zoomPanModifier.zoomExtentsY = true
        
        SCIUpdateSuspender.usingWith(surface) {
            surface.xAxes.add(xAxis)
            surface.yAxes.add(yAxisLeft)
            surface.renderableSeries = render
            surface.chartModifiers.add(items: xAxisDragModifier, pinchZoomModifier, zoomPanModifier, zoomExtentsModifier/*, legendModifier*/, SCIRolloverModifier())
            
            self.verticalGroup.addSurface(toGroup: surface)
        }
    }
}


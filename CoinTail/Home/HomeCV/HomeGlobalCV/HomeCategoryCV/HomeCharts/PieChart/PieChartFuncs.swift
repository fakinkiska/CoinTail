//
//  PieChartFuncs.swift
//  CoinTail
//
//  Created by Eugene on 23.05.23.
//

import UIKit
import Charts


extension HomeCategoryCell {

    // Настройки диаграммы
    func configureChart() {
        pieChart.rotationEnabled = false
        pieChart.drawEntryLabelsEnabled = false
        pieChart.drawHoleEnabled = true
        pieChart.drawCenterTextEnabled = true
        pieChart.highlightValue(x: -1, dataSetIndex: 0, callDelegate: false)
        pieChart.animate(xAxisDuration: 0.5, easingOption: .easeInOutCirc)
        pieChart.holeRadiusPercent = 0.7

        // Убрать список записей внизу диаграммы
        let legend: Legend = pieChart.legend
        legend.enabled = false
    }

    // Принимает все записи диаграммы и цвета категорий для отображения
    func updatePieChartData(values: [ChartDataEntry], colors: [UIColor]) {
        let dataSet = PieChartDataSet(entries: values, label: "")
        let data = PieChartData(dataSets: [dataSet])

        dataSet.colors = colors
        pieChart.data = data
        pieChart.notifyDataSetChanged()
    }

}
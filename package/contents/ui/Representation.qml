import QtQuick 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

import "../code/history.js" as History

Rectangle {
  color: border_color
  border.width: 1

  Row {
    id: cpuBars
    width: parent.width - 2
    height: parent.height
    x: 1

    Component {
      id: cpuBar
      Rectangle {
        width: parent.width / parent.children.length
        height: 1   // warning: cannot act as container if this is zero
        anchors.bottom: parent.bottom
        color: history_color
        Behavior on height { SmoothedAnimation { velocity: 200 } }

        Rectangle {
          width: parent.width
          anchors.bottom: parent.bottom
          color: current_color
        }
      }
    }
  }
  
  PlasmaCore.DataSource {
    id: datasource
    engine: "systemmonitor"
    interval: 500
    
    Component.onCompleted: {
      for (var i in sources) {
        var source = sources[i]
        if (source.match(/cpu\/cpu[0-9]+\/TotalLoad/)) {
          connectSource(source)
        }
      }
    }
    onSourceAdded: {
      if (source.match(/cpu\/cpu[0-9]+\/TotalLoad/))
        connectSource(source)
    }
    
    onNewData: {
      var value;
      if ((value = data['value'])) {
        var match
        if ((match = sourceName.match('^cpu/cpu([0-9]{1,2})/TotalLoad$'))) {
          var cpunum = parseInt(match[1])
          var h = value / 100 * cpuBars.height
          for (; cpuBars.children.length < cpunum + 1; )
            cpuBar.createObject(cpuBars)
          History.addH(cpunum, h)
          cpuBars.children[cpunum].height = Math.max(1, History.maxH(cpunum))
          cpuBars.children[cpunum].children[0].height = h
        }
      }
    }
  }
}

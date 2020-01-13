import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    property int columnCount: 128
    property int rowCount: 128
    property int newPixelHeight: 0
    property int newPixelWidth: 0
    property int maxPixelWidth: 100;
    property int maxPixelHeight: 100;
    property int minPixelWidth: 2;
    property int minPixelHeight: 2;
    property int pixelWidth: 20;
    property int pixelHeight: 20;
    property double zoomPercent: 0.5

    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("OledDesigner")

    Flickable
    {
        id: flickable
        clip: true
        contentWidth: columnCount * pixelWidth
        contentHeight:  rowCount * pixelHeight
        flickableDirection: Flickable.HorizontalAndVerticalFlick
        anchors.fill: parent

        Column
        {
            id: column
            //anchors.centerIn: parent
            Repeater
            {
                model: columnCount
                Row
                {
                    id:row
                    property int y_pos: row.Positioner.index

                    Repeater
                    {
                        id: repeatr
                        model: rowCount
                        // Oled display pixel
                        Rectangle
                        {
                            id: cell
                            height: pixelHeight;
                            width: pixelWidth;
                            border.color: "black";
                            border.width: (pixelWidth > minPixelWidth) ? 1: 0
                            Text
                            {
                                anchors.centerIn: parent
                                //text:  cell.Positioner.index + "," + y_pos;
                            }

                            MouseArea
                            {
                                anchors.fill: parent
                                onClicked:
                                {
                                    color = "orange";
                                }
                            }
                        }
                    }
                }
            }
        }

        MouseArea
        {
            anchors.fill: parent
            propagateComposedEvents: true
            onWheel:
            {
                // Zoom in
                if (wheel.angleDelta.y > 0)
                {
                    newPixelHeight = pixelHeight + pixelHeight * zoomPercent;
                    if (newPixelHeight > maxPixelHeight)
                        newPixelHeight = maxPixelHeight;

                    newPixelWidth = pixelWidth + pixelWidth * zoomPercent;
                    if (newPixelWidth > maxPixelWidth)
                        newPixelWidth = maxPixelWidth;
                }
                // Zoom out
                else
                {
                    newPixelHeight = pixelHeight - pixelHeight * zoomPercent;
                    if (newPixelHeight < minPixelHeight)
                        newPixelHeight = minPixelHeight;

                    newPixelWidth = pixelWidth - pixelWidth * zoomPercent;
                    if (newPixelWidth < minPixelWidth)
                        newPixelWidth = minPixelWidth;
                }
                //
                pixelHeight = newPixelHeight;
                pixelWidth = newPixelWidth;
            }
        }
    }
}

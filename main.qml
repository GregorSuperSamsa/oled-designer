import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    property int columnCount: 10
    property int rowCount: 10
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

        Column {
            id: matrix
            //anchors.fill: parent;
            //property int x_pos: index
            Repeater
            {
                model: columnCount
                Row
                {
                    property int y_pos: index
                    id:row
                    Repeater
                    {
                        id: repeatr
                        model: rowCount

                        Rectangle {
                            id: cell
                            height: pixelHeight;
                            width: pixelWidth;
                            border.color: "black";
                            Text
                            {
                                anchors.centerIn: parent
                                text:  "," + y_pos;
                            }
                        }
                    }
                }
            }
        }
        MouseArea
        {
            anchors.fill: parent
            onWheel:
            {
                if (wheel.angleDelta.y > 0)
                {
                    newPixelHeight = pixelHeight + pixelHeight * zoomPercent;
                    if (newPixelHeight > maxPixelHeight)
                        newPixelHeight = maxPixelHeight;

                    newPixelWidth = pixelWidth + pixelWidth * zoomPercent;
                    if (newPixelWidth > maxPixelWidth)
                        newPixelWidth = maxPixelWidth;
                }
                else
                {
                    newPixelHeight = pixelHeight - pixelHeight * zoomPercent;
                    if (newPixelHeight < minPixelHeight)
                        newPixelHeight = minPixelHeight;

                    newPixelWidth = pixelWidth - pixelWidth * zoomPercent;
                    if (newPixelWidth < minPixelWidth)
                        newPixelWidth = minPixelWidth;
                }
                pixelHeight = newPixelHeight;
                pixelWidth = newPixelWidth;
            }
        }
    }
}

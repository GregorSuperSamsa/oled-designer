import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Flickable {
         id: flickable
         clip: true
         anchors.fill: parent

    Column {

      anchors.fill: parent;
      Repeater {
        model: 128//myGameBoard.columnCount()

        Row {
          property int y_pos: index
id:row
          Repeater {
            id: repeatr
            model: 128//myGameBoard.rowCount()

            Rectangle {
                id: cell
              height: 10//root.height/128;
              width: 10//root.width/128;
              border.color: "black";

              //color: mouseArea.containsMouse && mouseArea.pressed ? "orange" : "white";

              MouseArea {
                   id: mouseArea
                   anchors.fill: parent
                   hoverEnabled: true
                   propagateComposedEvents: true
                   acceptedButtons: Qt.LeftButton | Qt.RightButton

                 property bool leftClick: mouseArea.pressedButtons == Qt.LeftButton

                   onEntered:
                   { //mouseArea.accepted = false
                      // console.log("Entered");
                       if (leftClick)
                       {
                           cell.color = "orange";
                           console.log("Entered leftClick = true");
                       }

                       if (mouseArea.button === Qt.LeftButton)
                       {
                           cell.color = "orange";
                           console.log("Entered left button");
                       }
                       else if (mouseArea.button & Qt.RightButton)
                       {
                           cell.color = "white"
                           console.log("Entered right button");
                       }

                   }

               }

            }
          } //Repeater
        } //Row
      } //Repeater
    }
    }//Column
}

import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0

Item {
  // XXX make it configurable
  property string border_color: "#00FFFFFF"
  property string current_color: "red"
  property string history_color: "#D9DA16"

  Plasmoid.compactRepresentation: Representation {}
  Plasmoid.fullRepresentation: Representation {}
}

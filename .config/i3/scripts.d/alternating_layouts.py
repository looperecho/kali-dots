#!/usr/bin/env python3
# i3 alternating layouts

from i3ipc import Connection, Event


def finder(con, window_id, parent):
    if con.id == window_id:
        return parent

    for node in con.nodes:
        res = finder(node, window_id, con)

        if res:
            return res

    return None


def set_layout(i3, e):
    # Set the layout/split for the currently focused window to either vertical
    # or horizontal, depending on its width/height:

    window = i3.get_tree().find_focused()
    parent = finder(i3.get_tree(), window.id, None)

    if parent and parent not in ("tabbed", "stacked"):
        if window.rect.height > window.rect.width:
            if parent.orientation == "horizontal":
                i3.command("split v")

        else:
            if parent.orientation == "vertical":
                i3.command("split h")


def main():
    # Listen for window focus changes and call set_layout when focus changes:
    i3 = Connection()
    i3.on(Event.WINDOW_FOCUS, set_layout)
    i3.main()


if __name__ == "__main__":
    main()

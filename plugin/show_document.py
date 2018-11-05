import os
import json
import sublime
import sublime_plugin

def get_file(filename):
    with open(os.path.abspath(__file__ + '/../' + filename), 'r', encoding = 'UTF-8') as file:
        return file.read()

usages = json.loads(get_file('usages.json'))

template = '''
    <body id="document">
        <style>''' + get_file('document.css') + '''</style>
        {0}
    </body>'''

def get_document(name):
    if name not in usages:
        return "<p>No description available.</p>"
    return '''<div class = "Title">
        <span class = "Function">{0}</span>
        <span class = "Spacer">&nbsp;</span>
        <span class = "Package">{1}</span>
    </div><p class = "Usage">
        Here are some definitions.
    </p>'''.format(name, '23333')

def get_key_region_at(view, point):
    if view.match_selector(point, 'variable.function.wolfram'):
        for region in view.find_by_selector('variable.function.wolfram'):
            if region.contains(point):
                return region
    return None

class WlEventListener(sublime_plugin.ViewEventListener):

    def on_query_completions(prefix, locations):
        return [
            ["me1\tmethod", "method1()"],
            ["me2\tmethod", "method2()"]
        ]

    def on_hover(self, point, hover_zone):
        if hover_zone != sublime.HOVER_TEXT: return
        key_region = get_key_region_at(self.view, point)
        if not key_region: return

        key = self.view.substr(key_region)
        window_width = min(1000, int(self.view.viewport_extent()[0]) - 64)
        key_start = key_region.begin()
        location = max(key_start - 1, self.view.line(key_start).begin())

        self.view.show_popup(
            content = template.format(get_document(key)),
            location = location,
            max_width = window_width,
            flags = sublime.HIDE_ON_MOUSE_MOVE_AWAY 
                  | sublime.COOPERATE_WITH_AUTO_COMPLETE
        )

import sublime
import sublime_plugin

class WolframEventListener(sublime_plugin.EventListener):

  def on_query_completions(view, prefix, locations):
    return [
      ["me1\tmethod", "method1()"],
      ["me2\tmethod", "method2()"]
    ]

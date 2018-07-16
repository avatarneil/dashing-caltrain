class Dashing.Caltrain extends Dashing.Widget

  ready: ->
    if @get('unordered')
      $(@node).find('ol').remove()
    else
      $(@node).find('ul').remove()
    # This is fired when the widget is done being rendered
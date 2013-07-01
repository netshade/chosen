class SelectParser

  constructor: ->
    @options_index = 0
    @parsed = []

  add_node: (child) ->
    if child.nodeName.toUpperCase() is "OPTGROUP"
      this.add_group(child)
    else
      this.add_option(child)

  add_group: (group) ->
    group_position = @parsed.length
    object =
      array_index: group_position
      group: true
      label: group.label
      children: 0
      visible: 0
      disabled: group.disabled
      expanded: null
      data: $(group).data()
    @parsed.push object
    this.add_option( option, group_position, group.disabled ) for option in group.childNodes
    object

  add_option: (option, group_position, group_disabled) ->
    object = {}
    if option.nodeName.toUpperCase() is "OPTION"
      if option.text != ""
        if group_position?
          @parsed[group_position].children += 1
        object =
          array_index: @parsed.length
          options_index: @options_index
          value: option.value
          text: option.text
          html: option.innerHTML
          selected: option.selected
          disabled: if group_disabled is true then group_disabled else option.disabled
          group_array_index: group_position
          classes: option.className
          style: option.style.cssText
          data: $(option).data()
          parent: @parsed[group_position]
      else
        object =
          array_index: @parsed.length
          options_index: @options_index
          empty: true
          data: $(option).data()
          parent: @parsed[group_position]
      @parsed.push(object)
      @options_index += 1
      object

SelectParser.select_to_array = (select) ->
  parser = new SelectParser()
  parser.add_node(child) for child in select.childNodes
  parser.parsed

this.SelectParser = SelectParser

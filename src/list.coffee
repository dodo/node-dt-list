{ Order } = require 'order'

mark = (el) ->
    el = el.xml ? el # get the builder if it is a template
    return (done) ->
        el._list_ready = done
        return el


class List extends Order
    constructor: ->
        super ({idx, before, after}) ->
            this[idx]._list = {idx, before, after, list:this}

    push:    (   el) -> super    mark el
    unshift: (   el) -> super    mark el
    insert:  (i, el) -> super i, mark el

# exports

List.List = List
module.exports = List

# browser support

( ->
    if @dynamictemplate?
        @dynamictemplate.List = List
    else
        @dynamictemplate = {List}
).call window if process.title is 'browser'



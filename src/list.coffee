{ Order } = require 'order'

warned = no

mark = (el) ->
    if not warned and el.builder? and not el.builder.adapters?.browser?.plugins?.list?
        console.warn "dt-list adapter plugin is missing!"
        warned = yes
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
    splice: (i, d, els...) ->
        super i, d, (mark el for el in els)...

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



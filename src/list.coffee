{ Order } = require 'order'

mark = (el) ->
    el = el.xml ? el # get the builder if it is a template
    if List.warn
        el.once 'added', ->
            root = el.root()
            if List.warn and root.builder?
                unless root.builder.adapters?.browser?.plugins?.list?
                    console.warn "dt-list adapter plugin is missing!"
                List.warn = no
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
List.warn = yes

# browser support

( ->
    if @dynamictemplate?
        @dynamictemplate.List = List
    else
        @dynamictemplate = {List}
).call window if process.title is 'browser'



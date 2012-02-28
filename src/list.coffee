{ Order } = require 'order'


class List extends Order



List.jqueryify = (root) ->
    return ({idx, before, after}) ->
#         console.error "list", @length, "before:#{before} idx:#{idx} after:#{after}", root?._jquery
        el = this[idx]._jquery
        if before isnt -1
            this[before]._jquery.after el
        else if after isnt -1
            this[after]._jquery.before el
        else
            root._jquery.append el

List.domify = (root) ->
    return ({idx, before, after}) ->
        el = this[idx]._dom
        if after isnt -1
            el.parent.insertBefore el, this[after]._dom
        else
            root._dom.appendChild el

# exports

List.List = List
module.exports = List



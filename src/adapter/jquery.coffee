
module.exports = (adapter) ->

    fn_add = adapter.fn.add
    adapter.fn.add = (parent, el) ->
        el._list_ready?()
        el._list_ready = null
        return fn_add(parent, el) unless el._list?
        {idx, before, after, list} = el._list
        el._list = null
        $el = el._jquery
        $par = parent._jquery
        $after = list[after]?._jquery
        $before = list[before]?._jquery

        if parent is parent.builder
            i = $par.length - 1
            # list handling:
            if before isnt -1
                $par.splice($par.index($before), 0, $el...)
            else if after isnt -1
                $par.splice($par.index($after) - $after.length, 0, $el...)
            else
                $par = $par.add($el)

            if parent._browser.wrapped # FIXME
                $par.first().replaceWith($el)
                if parent.parent is parent.parent?.builder # FIXME recursive?
                    $parpar = parent.parent?._jquery
                    parent._browser.wrapped = no
                    $par = $par.not(':first') # rm placeholder span
                    $parpar?.splice($parpar.index($par), i+1, $par...)
            else if $par.parent().length > 0
                # list handling:
                if before isnt -1
                    $el.insertAfter($before)
                else if after isnt -1
                    $el.insertBefore($after)
                else
                    $el.insertAfter($par[i])
        else
            # list handling:
            if before isnt -1
                $el.insertAfter($before)
            else if after isnt -1
                $el.insertBefore($after)
            else
                $par.append($el)
        # $.add isnt inplace
        parent._jquery = $par


    onreplace = adapter.onreplace
    adapter.onreplace = (oldtag, newtag) ->
        res = onreplace.call(this, oldtag, newtag)
        if oldtag._list?
            newtag._list ?= oldtag._list
            oldtag._list = null
            newtag._list.list[newtag._list.idx] = newtag
        if oldtag._list_ready?
            newtag._list_ready ?= oldtag._list_ready
            oldtag._list_ready = null
        return res

    return adapter

# browser support

( ->
    if @dynamictemplate?
        (@dynamictemplate.List ?= {}).jqueryify = module.exports
    else
        @dynamictemplate = {List:{jqueryify:module.exports}}
).call window if process.title is 'browser'

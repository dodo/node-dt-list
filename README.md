# [Δt dynamictemplate List Controller](http://dodo.github.com/node-dt-list/)

This provides List handling support for [asyncxml](http://dodo.github.com/node-asyncxml/) and [Δt](http://dodo.github.com/node-dynamictemplate/).

## Installation

```bash
$ npm install dt-list
```


## Usage

```javascript
var List = require('dt-list').List; // server
var List = dynamictemplate.List;   // browser

function myTemplate(view) {
    var that = this;
    var items = new List;
    view.on('add', function (model) {
        items.push(that.$li(function () {
            this.$p(model.text);
        }));
    });
    view.on('insert', function (i, model) {
        items.insert(i, that.$li(function () {
            this.$p(model.text);
        }));
    });
    view.on('remove', function (i) {
        var el;
        if (typeof i === 'undefined')
            el = items.remove(i);
        else
            el = items.shift();
        if (el) el.remove();
    });
}
```
[Example](http://dodo.github.com/example/list.html) in [detail](https://github.com/dodo/node-dynamictemplate/blob/master/example/list.coffee).


## api

Same api like [Order](http://github.com/dodo/node-order) but you don't have to give functions anymore, that does `List` for you. Just throw your [Δt](http://dodo.github.com/node-dynamictemplate/) elements created with [asyncxml](http://dodo.github.com/node-asyncxml) into the `List` like your would throw values into javascripts `Array`.




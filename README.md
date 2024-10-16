Run with [http-sh](https://github.com/cablehead/http-sh):

```
http-sh :5001 -s ./static -- ./root.sh
```

Then visit: http://localhost:5001

To dump pages:

```nushell
stacks 03BDHSE4NJ8JC3NSYEC9RLWT3 --meta |
    from json |
    get clip.children |
    each {|id| stacks $id --html} |
    each {|x| $"<div>($x)</div>"} | str join "\n" | save -f ./releases/v0.15.6.html

stacks 03CNQXHTMD078JM5Y56KOWD0V --meta |
    from json |
    get clip.children |
    each {|id| stacks $id --html} |
    each {|x| $"<div>($x)</div>"} | str join "\n" | save -f ./how-to/window-management.html
```
